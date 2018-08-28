Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B93CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180AF20842
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YVDcSnHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180AF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeH1ORX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:17:23 -0400
Received: from mail-eopbgr690087.outbound.protection.outlook.com ([40.107.69.87]:19755
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeH1ORV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3Ri/bs4CR1wNAji28g9k6AfZXFPftgYDK4O/tbnN3I=;
 b=YVDcSnHdgt7XWjPqxHrK7HCiCCIYFSaO3sLnDBz0X9jyuW5UnFGOvhLDURmjsbpGZO9K6EWMmKdINPSlPTGUThFkVb9lqTR5UKrFNJW7hSfqamkvgmpRbwpCRWFti+wOWICGQzvqJm4y5OpIsnYJcfyi0421f3Kdp73FonOnDfk=
Received: from DM5PR07CA0042.namprd07.prod.outlook.com (2603:10b6:3:16::28) by
 CY1PR07MB2166.namprd07.prod.outlook.com (2a01:111:e400:59d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 10:26:01 +0000
Received: from BY2NAM05FT044.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::207) by DM5PR07CA0042.outlook.office365.com
 (2603:10b6:3:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.13 via Frontend
 Transport; Tue, 28 Aug 2018 10:26:01 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT044.mail.protection.outlook.com (10.152.100.181) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1122.2 via
 Frontend Transport; Tue, 28 Aug 2018 10:26:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w7SAPsBX018582
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 Aug 2018 03:26:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Aug 2018 12:26:00 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 Aug 2018 12:26:00 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w7SAPlvY004062;
        Tue, 28 Aug 2018 11:25:47 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w7SAPkX4004047;
        Tue, 28 Aug 2018 11:25:46 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <stelford@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>
Subject: [PATCH v3 2/5] drm/dp: fix link probing for devices supporting DP 1.4+
Date:   Tue, 28 Aug 2018 11:24:45 +0100
Message-ID: <1535451894-2518-3-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1535451894-2518-1-git-send-email-dkos@cadence.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(189003)(199004)(36092001)(50226002)(87636003)(7636002)(305945005)(48376002)(26005)(186003)(478600001)(36756003)(50466002)(356003)(26826003)(8676002)(51416003)(76176011)(47776003)(7416002)(246002)(5660300001)(2201001)(8936002)(86362001)(336012)(2906002)(426003)(54906003)(110136005)(446003)(11346002)(16586007)(106466001)(42186006)(107886003)(316002)(2616005)(126002)(105596002)(476003)(486006)(4326008)(921003)(21314002)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2166;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT044;1:XDcYQLAcprWPOa1FWq1hwm+d/+DmpeS+Isgoz/K+1pPcNyJirjPlFULsmYWYxV2yuuG0B9C2VvXlegBd6Whg6MlgNkq6ltKpeV1XVnvc+msLrbWPnd1i54i0qphd3CDE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07dd5b13-f7fe-41fa-dcf1-08d60cd0a6aa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2166;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;3:/DUZ6R+p0flBxMkESRRSoCmjyOexqosOpsvFHt3Kh5EkctW0yPlyuxBSjDGps5tr6Nb46h3AjZ8CPTWLGsnprtgLURUobOX1Pu/KXyyOjBZl5z3KgGqkK31vAMeMf7LzVGDIamrka2CfqhHQStwx6KDhe3jiKjPBzsyyHyTBhgf+5CE1h28lTmh7B+r3UQL7XPr+r346yDFS3Q+EM1IvrQ//S7FTiCbyrUrHN14wwHI2CGwyCYP1q1bGi7GGAoZ2h7oRYZeQC2FMNuULI7Q2/qY18wvxhtDNGXTGbMhvXXPOI5JsSvgXHSTWWBrWE5A//nPRxygzutC87rggXoSx2Q==;25:Ils1tfDdaZvyqwkia1L3g4DUBcLAlQ12KTX/UFkPxi5vEhmNDTBEsPK04CvTKWHTyFjEx/1RaP1WuxUyiDMkxDQZrlL2S9yL8uAl5r9S8Q1CeHcrm//e35oHwnXdo+aROa5RUzEUDKzG0SQDZhBfbhVX8uA8a8xmhSL0kQFIYs0rygzTRJspZbnFTh0wYXpR/8uVNs0ZcQ9QUtbyNuMHOLVe2si2lUp9TLQL8M2ubxi+rbuv79dWioHX/00j0E2eG1VMbnvtAl6QXvYvBZN0kiISjYKeKEBFmQKdD8zfQltLE+8j96nR7+WDgH4rY3VL1G05HVtaBs9hgGXQTf4b0g==;31:C+cHfSERLFTdzNEjAoSxqCsxL3Sv66i3rZUqKUTxLXngYmGgIiJlWrTMLiekajKnms89kG+E2dzBFRIHquV4a9sZZVWCser3UGj1LvH2Fb45wIeZn9jf/6d2LI3HWSKY0Uq8REjQOoktmzr4kz5cPMiklw9Ce06ADjdlRc19Fnpr6WguTnqsmK6FZSzG6bGtyymRYGkVdBYYfJdoPF9gVz9Vk0gVQQaa2XsTnEIm1Mc=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2166:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;20:9bpUDtVg3Tem+hliurqUdQWNTmDt/M35El+HgV89GB+WKl7Z9jo9yGl/Ho5TGVYe0ThDDG6NjWXcMMV09BM4jCdfzkNcV9qINiVD/izNgr3v882URZSx8Yv1wazRwZGK4HvR1z/XWAQqGPANavjsH7FLfIc7Xc+j/Lr5LW1UeEPURQ7MGA/p3MPp57Nh8ljOHaLNDWFiwMUxZNDExVJAEGmyf9VrioIubRRtKuCwO58ExTd3KUPyI3HcNps32sxqbBrcuRfmGFDnPmEXoPIB0k1z+HnGVucqwzEy/BbaF4uHZqHxg6sR9F2ZDSqR6UV2R08twpQaq6ntG+zmH+bFQ3m2bRXmoA4Pqs4ur6cPf09v3t5aaBqPNZsHjdl/Z/6wVft6AkHO8/ioTY2xzdx5ZbRyEo8QTDkbjE9idXjp4CEkZT3GdU7cSbyxJU/2PNIJclwt7Cwgs51bHtxmGzuvQgUG+olbSWN6DA30yssoqIVuSsC7OlhKa7HZSObN5GW7;4:8HplYAwkeRpvdCSBdFcjtnht61UdqfTF2ov6SBTZTytawlBu8voyxKNFE/fjS15c6baM71EQc50CwVtZxP7p4K+LgyBYYK86E/Iut/n4+bxkpm9XLB1dJH3WlRzsa8qAqxVRQ9OzXIJovWl/ipJIykjRxLAqg7730CqIUCm7dC+m7gQ3ySnMF49hhk+XGgoug/vxS/v6Nh7v/plcy/3nxgt6+4kxD9W98QZIr00OyaNPFI8ZiIisqC22DVVUgWkslFR46lfU6DiuySPvMXHGPIrC3cuD11szBWMCXWLz2KgrwWbho/T/q16KcfNIkHku
X-Microsoft-Antispam-PRVS: <CY1PR07MB21666DE37AA0D7ADC2788516CD0A0@CY1PR07MB2166.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:CY1PR07MB2166;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2166;
X-Forefront-PRVS: 077884B8B5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2166;23:J/YlOxWQkBwf2/3xnn7+fpkhCC4T65Q94NX54Wi0i?=
 =?us-ascii?Q?xnHfkAKw7jI94jAorZPhMjh8wD7or5qjaleYVRlqQ7ASInA6zhlMIblFdkXt?=
 =?us-ascii?Q?rov+cKheG58xvi+uGAQ9sQvXIO1/Y172x8exE8XLQRC/SfVKSadOh0yKeXnS?=
 =?us-ascii?Q?WhQmMaHEuxW4kywoos4Wy7W5WC5iA4sv/b4rTqbxTSLJ7zpHxJa0XyJhVwfn?=
 =?us-ascii?Q?WrlP5hWlnzeeAGgh3T8+x6I6DGJDRThoQxk4plnswH+LXaSmakRJMeEhxbHG?=
 =?us-ascii?Q?bbzcQYZ2XdBeWFJ6SOLDR5AJu3itE7TmkISnABziZQ3R++vlv5v31vjiqUwk?=
 =?us-ascii?Q?w1Zm2aKCI5ItRujnAjhg0MCjFCaEVdCHHpDKJ2DSwFZ1ArKPJkZ52eFuwwBB?=
 =?us-ascii?Q?q7iAzxvdca+2bLcIWHB1JNolr15v5RaDLKr/sCNGUkwtXpfNSEhnrDYIwHGW?=
 =?us-ascii?Q?ZmJLNmb+E1Zb56wy59FMP2GyihpluixEV1s/bUFfiyuwBqtPKi6hW84k+VRU?=
 =?us-ascii?Q?A6d5/LEXRfbTYbxg+8GkGfJYR216J0Ax8uxpg+GZ166qKW6lrI+RYCieAPic?=
 =?us-ascii?Q?9rIBOYL2w3lE9NOJUyVQy0W0d2Wgbzts2Y8Zg1YADeQrDZ1r8s0dti5fUSZP?=
 =?us-ascii?Q?UdRXw0p+zpSs/AuIuNW/kVWQv9PkrmvOr10R8h00OmqS2mjbShyjZw8lHbAg?=
 =?us-ascii?Q?uXSo32djgwK6aglFUI81MtSdy26CHeeVuJ3ZtX72aBU+JerNFhkSYOM6wPxB?=
 =?us-ascii?Q?YvOmXT/kqSrVtofP5oP9gQt3pInG7a5u1GbCGugbOG3ScBUKLywyksJbbuNK?=
 =?us-ascii?Q?Mp7ezf5UotXeqy4RmSANfeFUUGGn+Y8x5fs9ZmCt5rhNZdl77C0yDoWmBgoU?=
 =?us-ascii?Q?ISCi+tHGEVrM7LJ2Xe6RdDI1wNSzQR+oRtc5mhUo3O/dJljqhwEXLSRPEKEE?=
 =?us-ascii?Q?4MlkUdEsuoEKLvrW1zhrJl7imbvA5mk5A4Z9/igBzZuAiJCzUNNlEC2ev3zn?=
 =?us-ascii?Q?3u4bxjIHTHxrk6ZR+nigUgyzHcn/wBapjYM7RGy2DAdJi/Hyn3k0QHsHHK+x?=
 =?us-ascii?Q?JeREQje72zyONBIxd666G9TkAtO64L9UIYxFtDT4WpKwwe2iPJhEldMopKgG?=
 =?us-ascii?Q?qRwf9maLCZsaiQsmxgzaT8z4vPNRQunjauGlBoFciISnl2McovdVdx6mewon?=
 =?us-ascii?Q?NgYH1qrcWSZo9Y=3D?=
X-Microsoft-Antispam-Message-Info: i9DXVZ31RdB0lKyQJYWHupddA6AIS53lHX+0KtrDSuk73w89Kc2looiP7YBNzXzVXlLj8Et/8MHOgwOvmjPJ4pvdyCQIXoKhJFl2CeLVVEngoIiZi00KdCmB0J3vFXGi2CyCZKmy+MV91YeIQUrtq0+R2IJ+0fvQQZnrvTi7g8/BoL5Noa2YGBmFjACSlv3bFgiWbxutiLVBOIealEWlfkDu3p/kEK6R9sKBtQUQ3QETYeteEFWz/5HMWwk2/y0WFkpnPO+Sj9bJ3jQWB8GVSbiIzIgSZlD6Q1AqiBrnjVVPM7KVEnfTkX8gySdc6x7uIfWVRIb4/vsCKQKzzJsIDExuyWlw0sf7Whol9XSIrei76YSESh1x0snfTChKJL7EF/wl7PFfDpRlC9Y53A8H2g==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;6:j6Qr4NW6FxccNCzCDAOM3cZDSPoYg7zqxbDVxTOEnurGIaC+NGtF2Kq4xbgmX4W2mg6IK/n8H+N6FjEibOcWmUQ69PYRm7xjYR/d3bXzMFpJ8uDOGjBeUvyvQVtpAvLRO+1f1tR/OgmRxhPvDJ8Haibmo5IjOdWFqa9PHpUA8/COT9nrehwNW54ZPfRCU/LKqzpsKGkuY2yF5gnLKsP9KPBz87kGAm9vF8GO0mAwyF6JZW5uiHUd5SGspc1NDGeYy/MN0Zj/7rbaju9cRsiLCI6+FCp01ND4uE7ewNo13h/iN8k47fSY0PlvojnIduNFG5Jj/CV+mSxzojyjNQuLcpEKNDFRhkRw1MqJqHoFzyO60uNpp/xf/W6Lb28940iL8LUp8TV3kVqpvFfiofN43S3TaWn9n5sNoaDgquwip7DzR9nAOe3qfl2F2G3YMM5Bg1Zwl1ZftjnKEnQorVj5Bw==;5:tRp5W9eZ7nG4c/8hboqQv69gQKwJuKiNRPTEhwrmLEhVq6yspRCvDvGORcDj097FnhBwhlDy9+LP5LKNj0WtqjrMRr+toM496bQZKnK8itEViZFVmlM2HFiTzNigVJqr4vUvtfFBtkQ6Aua1c7Z7HU2BILpLqEq7+N4ckfR8VBQ=;7:tWeVlez+jSC/JXWSvxBHrJ7S1FvMbUwrg2MQkuk7pSKihk0oyb8EQcb04QxqFF8nOndTIcLhXhwSp56urVCi3zqdTX0Rj6fDJbjp0qaO0A7doOfoWgtLAdvHL+13eLN+mxGTSBM0RI54NiNPWECN9fuiigHDOw2Y6DQnvQYKgBDynHm+bgW+C3P2yK09PeWTHLy3J7U3JeKar/xjKXvCZcEQaA6uItYT4c922eTlq5ZhJr4eeHCzLD7Homifk52r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;20:ytXc64FSYUI4rGc4EuWlI2faTkMbM9zLwEDQVAgCayaPM+GvblCP02d12eq025DL5+u1cDbkUhgHEcedgIgYQ6fKZIKzuXDpEiinf5vCSJz4qbdoZhjkCo9vG+7Cfr1+kcgDWsjehX9igUIh7Vno95k1e5zunGpLjRFipS+65BEHojBW1K5syaitcnx+xoKxMDUWfg8En2xxrKh+R/4ZkilC+JALmkCSHmnzaFwhJU1ApBDkXS+YoqyR2uGFGUow
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 10:26:00.7356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dd5b13-f7fe-41fa-dcf1-08d60cd0a6aa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from DP_DPCD_REV
to DP_ADAPTER_CAP should be retrieved starting from DP_DPCD_REV_EXTENDED.
All registers are copied except DP_DPCD_REV, DP_MAX_LINK_RATE and
DP_DOWNSTREAMPORT_PRESENT which represent the "true capabilities" of DPRX
device.

Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT might
falsely return lower capabilities to "avoid interoperability issues with some
of the existing DP Source devices that malfunction when they discover the
higher capabilities within those three registers.".

Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved and read 0
so it's safe to check against it even if DP revision is <1.4

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
 include/drm/drm_dp_helper.h     |  2 +-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 8c6b9fd89f8a..4b5bf6ee7fa7 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
 {
 	u8 values[3];
 	int err;
+	unsigned int addr;
 
 	memset(link, 0, sizeof(*link));
 
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
+	/*
+	 * DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
+	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
+	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
+	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
+	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
+	 * "true capabilities" of DPRX device.
+	 *
+	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
+	 * might falsely return lower capabilities to "avoid interoperability
+	 * issues with some of the existing DP Source devices that malfunction
+	 * when they discover the higher capabilities within those three
+	 * registers.".
+	 *
+	 * Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved
+	 * and read 0 so it's safe to check against it even if DP revision is
+	 * <1.4
+	 */
+	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
+	if (err < 0)
+		return err;
+
+	if (values[0] & DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT)
+		addr = DP_DP13_DPCD_REV;
+	else
+		addr = DP_DPCD_REV;
+
+	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
 	if (err < 0)
 		return err;
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 698082a02b97..06a478679781 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -125,7 +125,7 @@
 
 #define DP_TRAINING_AUX_RD_INTERVAL             0x00e   /* XXX 1.2? */
 # define DP_TRAINING_AUX_RD_MASK                0x7F    /* DP 1.3 */
-# define DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT	(1 << 7) /* DP 1.3 */
+# define DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT BIT(7) /* 1.3 */
 
 #define DP_ADAPTER_CAP			    0x00f   /* 1.2 */
 # define DP_FORCE_LOAD_SENSE_CAP	    (1 << 0)
-- 
2.17.1

