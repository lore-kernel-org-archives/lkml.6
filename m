Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CECECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19F721531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EYPfjnGY";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AbElM8Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19F721531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbeITUkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:40:18 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:14475 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbeITUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:40:17 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KEsejD031597;
        Thu, 20 Sep 2018 07:55:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=dVRpLP24qSWhm4/hoCHTvnu1Uj8gmF6uVLySX0eCubQ=;
 b=EYPfjnGYXQLlAw+qbrUTRZ6yLm4qSSug+NbiyY7Cj29Yp27RnzWgQukRDvTaLsQ2Iy9n
 3boWHnEnkjQ+lzgVuEnJHx2Li/4KQS5U6FKRZBcj50eYMF4ZLgI9f7FuMaWzIJV+z1th
 0LNeLP1IX3WgU1FG0kb57rFSHSZi9orxnHAdYuZtaME1CbbyMQjeO2m5bwxwt46KwYV/
 cVMe/JyQHGMOtdLAekwAF9Sc40kGjYhFf0dQozdOrcT1h35GlReDZQpoKramZ90CRXOI
 cDPAg87++BIWb2fvAtCcaloVna572MK7+4vxBJaTWSsHiJaozgomPsnn2e5WK0d/9ott eQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0016.outbound.protection.outlook.com [207.46.163.16])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mgwnvk5qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 07:55:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVRpLP24qSWhm4/hoCHTvnu1Uj8gmF6uVLySX0eCubQ=;
 b=AbElM8NmtwFNRLbWC8e8QTkTHf8EvHSqje8ppl5YuIsowWhLsIfjlq/hdrTvAFUxAcP6USbEYCOuOnCikzFOwP3IRiaAhwfgns1DXyHHrBQee+fkquMFaso74A3BDddYQFdGJYWYhbXHR73t9jPL8kLugl2QY/UHyb0Qj4PPw6A=
Received: from DM6PR07CA0017.namprd07.prod.outlook.com (2603:10b6:5:94::30) by
 DM6PR07MB4410.namprd07.prod.outlook.com (2603:10b6:5:bf::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 20 Sep 2018 14:55:31 +0000
Received: from CO1NAM05FT019.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by DM6PR07CA0017.outlook.office365.com
 (2603:10b6:5:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 14:55:31 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT019.mail.protection.outlook.com (10.152.96.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.5 via Frontend Transport; Thu, 20 Sep 2018 14:55:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEtRdx013298
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 20 Sep 2018 07:55:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 20 Sep 2018 16:55:34 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 20 Sep 2018 16:55:33 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEtOlh021568;
        Thu, 20 Sep 2018 15:55:24 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8KEtDCD021309;
        Thu, 20 Sep 2018 15:55:13 +0100
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
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <pgaj@cadence.com>, <ltyrala@cadence.com>,
        <stelford@cadence.com>, <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>
Subject: [PATCH v4 0/5] drm: add support for Cadence MHDP DPI/DP bridge.
Date:   Thu, 20 Sep 2018 15:54:35 +0100
Message-ID: <1537455288-20223-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(36092001)(189003)(199004)(486006)(8936002)(7636002)(26005)(5660300001)(186003)(105596002)(50226002)(2906002)(6666003)(246002)(336012)(478600001)(87636003)(50466002)(36756003)(106466001)(7416002)(51416003)(26826003)(8676002)(47776003)(316002)(48376002)(16586007)(126002)(14444005)(2616005)(54906003)(86362001)(426003)(4326008)(356003)(305945005)(2201001)(476003)(110136005)(42186006)(921003)(21314002)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4410;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT019;1:pOQ7IK8qf4+B/OlcbzUQUy4fCeqsUAyxQm/5NIn/u/T/qrX1p/7/uwI8BVzAmuJHy8ieUym5MwCXp4MYgeWICClthq5x8EOF5sJAahXC+O09bt6qysiVfG4IvqpBIxbi
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 140cef2f-3275-4e27-a97f-08d61f091c8b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4410;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4410;3:HYjenCCmy0Nj3jsY3vIbCGJAnQhMIMN+TT8UrQmBwIEzztgei7yd/xbrU2zHuRhICGcTN/2OXtrN0OpIVxDixLa5NJSTb8rVdDQVv0v2A7rj7+7vjyTQPwht0fK24oC41O4kAvuQIkKbasJTm3r6sSlcdzR560p/DyhYQS9NzGaO/3F3p5DpaViYvXHfJLB86cNh00FKiptVTCX/5+a+eeQ2ArvlBqtudtsSOi1lqlvi+hJiZwNfg5AUCd6om6Wu2usPxDq2a4XZMEhHLf3m3F/ecv4vdQ85tiFlFW+3s1Lk+z4FFdRSWVu0mJM4TGjyq/6ltXvuH1O+vUaHeI6U19bkFdwbQJLSRNcOeZJxjTQ=;25:cjYWOG7dSfAQXls7IaPEP2PeaS6eNYmRuEUJPOZDY5P5OQwVatqQpeti8/cZHCAXY3p+pm9VmfKo12STITShwMcx5BqPuYpEJjP0ILd1R2rgb5iph+VTZX6DitltnK9iIi9cJzH+1PQgZyM8M9A3i9zwsKJD12XZwsQLJxEq/2Tmcfv/klAW6TGFJBqCn/H3R5EKwjjm8edyOXJY/T7y9nh9dasIcawHueeQut0iyCp0gvX557QFhI1yMK90spM2dlkEMjACjPUmFA5ckfiVUYz9wm/1VikPUj+hxpHJws3iaF58D4eEW+6TjR3Tt4S9yV04RdWnr/U2HMz4C+BpLw==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4410:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4410;31:5q5uoSVPWhkgPjUJEehJWimZUlMvI7IkqQ3Z7ZjwGeYD/2TgKBKLxthZYb9tvrFgUmjmfnHnWulKaQeL/Gc27/mTowlzpmjA6YHUEqNO6E8gkcfjy94BMqlJcsqrrWBXVaoZvIZbbzxNA27Im6zYmDHzO3U/yyGfOfPHgaM20qAspUR6OQwys6wnBHAUWPT59PTn9otE75yAxFpX0wE7bJFp9pv66DY19KQQnPgg9JQ=;20:Lbv5J2tr2PPEwryTtQwNOFU+bVd9xhQV1MdijfzXQtM6kKycYqRlobgocnW1mE7r7Hvd+D1OiiQnSlDGogyTKZJ+wtHN6wpx22NPbqiO8nOvUb15Ss/WMJIBno6C4XLZPCm31JuWnklqR++ki4fw3yXkuY3elB6npcth7nmN/C/Gr0/cpWtxZ90iS+S06GKmHzXPdf4UW77k4Iw8n5wLyUGe/0V2I91dayDhol9WVS8A9bJvLFPlc6ysq6/SZ//BO1Ye7lPcb/3P4y7JfDhOywer6Ae1JiHtzOqxqSnz2SyKdVdaPp8X4+rVYYkMTYS9/2PKHnEDk/+kUxVXW0WXtF9Sl5QsVjWd1lSyAPA//yL3ER7xCAC/ihUokV1sYfZg9WXz5FILVsitlEzvNPxYICGKklJ7fi0K/U5rf5YLr7aNZ6QRqWE+SyG++u6hjbNDDLcAdPV/E90LYBB8EEUNog7wI9T0pjJlxSl9XAhgvGAKhBk5r1vr7w2yFrNWOhTS
X-Microsoft-Antispam-PRVS: <DM6PR07MB4410977C967DB3D1A9CA32B3CD130@DM6PR07MB4410.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93003095)(10201501046)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DM6PR07MB4410;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4410;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4410;4:hod/mSjyCN3kKs0dN7Zlp9fURQpt5yldUUo+MauRU69xH2vHzNV4TN0pdgvO+1SWxMgYGUYX6GdYPLvBsjjE+2hy/QKg9q3URZNb/GJ4KGjqH3P7NJ0LDppe3MfauyNORlKSJpqM9LFkQEVNEPYhRu8uguiU5L4BnGw1+5WFK10aHxt/Fzpp23+MEqbMKraWT/R3MyLzJSR0CK1u9kP86vZYdqAEMjPWjAqdcpVQByr1PpqKv6eWh5VxtqQn5o5VRdKVeK1XHO2lAC9xBM9MkQ==
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4410;23:5A/os04u0JhfCAPenoPN/QZXM5AuzP/O1EFzQ6IHY?=
 =?us-ascii?Q?nX0FG+Z09NuvHdZg69ShZzQbUiYJ76xtwQAZtbFcNN3ff0mfLzkOV6OdBd9I?=
 =?us-ascii?Q?fvCu04AYkWcUiq9sZDZPAhBVTfe9wbbDqUBLk8Mqh6sHjSbm0vdW6GA9xnQg?=
 =?us-ascii?Q?W2Gb0WM0yegljx0e6GXVJ9IGaCpsc3DwtsiDF1t/yrjVfzfLF4UyyVXGqYxz?=
 =?us-ascii?Q?aX7WRWt7TRoFjwD6FKXFqvVGxQ0QtraHptqKFpWTMY8Nhjfn3QHK3PjpIstN?=
 =?us-ascii?Q?h59FZyek+Mtr+WNcPlZItuLn9tn0PQ+pf6qCJWXSAjfHdE5B/Fn7bezaDkey?=
 =?us-ascii?Q?Plu/jIP+/KxC0nw7g7jxRco4JYHjIxNd0yNyDM8UuI4E8IhRks9cUIonwm0I?=
 =?us-ascii?Q?VqqnDe76IbgU0P4ktwgC59qQUZzuzhLAgJKdISSzsU1CEfVSoi7REIrxFnk+?=
 =?us-ascii?Q?Y1wnh8kYcX3d8fGGhg+dcm+eGGE7NXREMKXeSI6vcCdtw1sTBX4AmVwCiz3L?=
 =?us-ascii?Q?AUqEAVfWnSBaWgHX1p+ItcSzbITddQWX7/Cp0Z2DIULpJk7+soDfooCEIQZi?=
 =?us-ascii?Q?Sj5KpGaPTA66mRChGNlgGK7IPZ8wUL3v5P+7RRsPiVIoR2IqaEdKIJmaMkv/?=
 =?us-ascii?Q?1d9caACcz3B44J50+kGP82FgrhSOQVDfpl5/Re2G8Ph/l1ltchzr7xaUT0N3?=
 =?us-ascii?Q?xJRin9xzHUPimdOhHrkiOmZBu2HRYqSilWlzY8JMM60dFKbCOqsfpQ3Qplan?=
 =?us-ascii?Q?TPyYXPrYZR8+NB5MtpdUSwGc1sypKg2N7olNyMokmBt852r96NuX/s9xVSfZ?=
 =?us-ascii?Q?xlg8d3W+7Vh72foqiHulfAYOD+qhwKP1DZCo/A4tqhmFmo9pilZCOlylag4w?=
 =?us-ascii?Q?C1uQqgS14OtUBdjHWJctMJ+k3gePYUz9LVMshveSFtEyXbad/cV0sX9pBZKf?=
 =?us-ascii?Q?GYaRPPWuiO6UBTyvZaO5iGQHyWyKw0h7ZozHo5NMNlm/g38VxtqHi3cZtEeJ?=
 =?us-ascii?Q?/LoRuhBowAa3wQeQ80s3jqNr+FvunJjz2biZ9bKkCktasuSbdwu0Y2weaKSQ?=
 =?us-ascii?Q?z8pEFLB5UOEepRNynl9/9TuRoUB03z+IT8YlgV0y8v2Hf56A5fb/rN2QwOsp?=
 =?us-ascii?Q?e+8pjY7Bz0Kibi88KzN9HZ7Kqae/I2f?=
X-Microsoft-Antispam-Message-Info: NAuNm3M3RDZHSPaCljoMV5OnMkALzOb7NC++LRA8bq6jgb/0CCAQiV2FCCXYiTe5Pn3XApuXSnXYgiBcJTGa1o/Rfs61s1lMXI21/I68CyV8lw/vMNwmCMNZ24fI9XDI16SA3uC/2i77UxKPipNWZWwUWDDf8J6dW8B20jMkleX7XpIpVTx4pKhWIFYWgD/7xHw9/KX7v8+0GqGe98ixPVnVpI6GS5bzrIxYv2bvXmAL8ZtWDRxLgCudnHzk1s3Xu9y2tPlDR1rtcSO4vdXnFX40VJ4GlSnv+xN95YTB8uuvc8rDLWLyUvx2QKpFrV+D5gZ2jKYbk588r5SW2kcI4q7GwdUpB1ubDZZLB/HyEUU5ofyGhrmJ2wBBgiY786XyYxAgNrXhPESpkScsdjyp2w==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4410;6:FC72zWS2o5FY2sw+mXm3drKbNbJ52uL/NsE6sbaaSvkP8oMihqAuuuOs1pLPRDrw956N0VyX9AIUM0JTwtzCXPW0kf+PVOlEEChn6XhiQkLNyWCfgjeampEQcvtZmvLM4yP3SpIf8Vws+itz1WrSZFl1eeZPGpbBKACGhiuEqWsF4bGHy9iDYzUE6Q8kKTl7UHOpFu50Or4RN9CvWYLe33iatFwq4zpxg+h82BHdIKiaD2kgTcYekxEtGA+vJOlqNukD0+EEdVW4FPsyXH8AZprdT9hggTnUm68XXGqI0OWE5/9Ptdc6jYAFLhSqWMVbljaiPhEFegzJnTKb12rNeaUXFE2DrsG684PQbER1hH5UmjZDM6tQdMF6yParOQX+wSc/dY0MHy1LJCXJY6Dh8bxwUibw+96TXBptte4rc3/GjQqP2qfmgSjmS1r2x6fbuKaw+mNcEJ0pi1R7VpilZg==;5:9VWtahtmusWowzffDZLhfj62RUCAjc1KMMr+aok/CmHBnMIp7EJbRwcCja4qOh/ZlzT93cwrCJ3zwyr30gr+5RXjHkkvCPmX1VRrMQSGbjcz3g2FI0richsg9LEdZusRK9s3yMZoQRU/Zu08ZZsmFsXVD1cMwPkKyUCIZiHU5fQ=;7:yKgicX/9NI8+2NtbK8fs789yNxosUmJgTQWWrXjXCN2NqLM9pEkKCkNB9ruNDZp4ROPYUqRL2426VqIFZ6DYxMrJA5vsUp4ycSBOCDxVPzvoKtJqd0zvXaasdqBEZtitgtd4q+9t1poKqrhOMpEJzEL8XEHmiUs8+sj5dbzOilKrtw2206yQfIYtk2G9z3iTlbg3audv95OHAKQCO6gX2yOzb994p0Wy6anss46Q38RGz8gKGZqR4okdobAQkg2H
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4410;20:jpktXl6tP+ZNx3i/RD5Ru4dhlKX+EUvBgu2rzZt5kPuCQyBMM22Kj2y03dYjC9iCU6DsucgJ7tjrRM+awvz1p0eVabRIkGhbrCirSodXyaFbhAprbf3EFz9cOJ/t6WokT7EScWrACFf3WVsYzIRrCWUrdSospLU5i/tDGaMutN2vNLiyoTB8v5HO21fmBQ2PE7YYcDSQrXZLtofFj0MkO5ASXorXqj79AERsbw7FkoYEXCH/YbESSKjzzusUvsgh
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 14:55:30.7647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140cef2f-3275-4e27-a97f-08d61f091c8b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4410
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809200148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is the series of patches that will add support for the Cadence's DPI/DP
bridge. Please note that this is a preliminary version of the driver and there
will be more patches in the future with updates, fixes and improvements.
Please keep that in mind when looking at FIXME/TODO/XXX comments.

Initially, MHDP driver was developed as a DRM bridge driver and was planed to
be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there was already
a driver for Cadence's DP controller developed by RockChip, but that driver
uses the different DRM framework and looks like a part of a bigger system.
Both controllers (including firmware) are quite different internally
(MST/FEC/DSC support, link training done by driver, additional commands, IRQ's
etc.) but they have similar register map, except for Framer/Streamer (which is
noticeably different), so they appear similar.

The following patches contain:
- Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
  modifying it a bit (mostly new prefixes for functions and data types) so it
  can be used by two, higher level, drivers.
- Modifying existing RockChip's DP driver to use the common code after changes
  made to it (use the new cdns_mhdp_device structure and new function names).
- Modifying DRM helpers a bit. Some are required for new driver, some are
  updates from DP 1.2 to 1.3 or 1.4.
- Adding documentation for device tree bindings.
- Adding preliminary Cadence DPI/DP bridge driver.

Some of the things that will be added later on include (but are not limited
to):
- Support for Cadence SD0801 PHY (PHY's driver should be on the way by now)
- MST support
- DSC support
- FEC support
- HDCP support

Changes in v2:
- Added actual description of what the patch contains, what is it for and
  what's going on here in general.
- New structure. Now we have one common low level driver + two high level
  drivers - one for RockChip with minimum changes and one, more general, for
  Cadence.
- Dropped some changes made to DRM helpers.
- Updated the device tree bindings document.

Changes in v3:
- Corrected dt-bindings document
- Enabled some clocks at startup (since FW doesn't do that anymore).
- Changed Firmware file name to match the file on Linux Firmware repo.
- Added SST audio support
- Made common functions (in cdns-mhdp-common.*) public.

Changes in v4:
- Fixed Kconfig in drm/rockchip
- Fixed Signed-offs
- dp_link_status() is no longer public since it's used only in drm_dp_helper.c
- Replaced EXTRA_CFLAGS with ccflags-y in drm/rockchip Makefile


Damian Kos (1):
  drm/rockchip: prepare common code for cdns and rk dpi/dp driver

Quentin Schulz (4):
  drm/dp: fix link probing for devices supporting DP 1.4+
  drm/dp: make dp_get_lane_status usable from outside of the core
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
  drm: bridge: add support for Cadence MHDP DPI/DP bridge

 .../bindings/display/bridge/cdns,mhdp.txt     |   43 +
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 drivers/gpu/drm/bridge/cdns-mhdp-common.c     | 1108 ++++++++++++++
 .../cdns-mhdp-common.h}                       |  135 +-
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1308 +++++++++++++++++
 drivers/gpu/drm/drm_dp_helper.c               |   39 +-
 drivers/gpu/drm/rockchip/Kconfig              |    4 +-
 drivers/gpu/drm/rockchip/Makefile             |    4 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  234 +--
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |   42 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c         |  969 ------------
 include/drm/drm_dp_helper.h                   |    2 +
 13 files changed, 2750 insertions(+), 1150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-common.c
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.h => bridge/cdns-mhdp-common.h} (81%)
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 delete mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c

-- 
2.17.1

