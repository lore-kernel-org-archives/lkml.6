Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B94AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3088E24494
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Lj4hK+Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3088E24494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeGCKDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:03:25 -0400
Received: from mail-bl2nam02on0045.outbound.protection.outlook.com ([104.47.38.45]:40741
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933845AbeGCKDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d32PDjQ4SITMPhMt2q1AJixTo5UUvoUPxSXJlLtawOU=;
 b=Lj4hK+Q/2Fl131KgqPd5bDpnDeHErEY+FZFmeBLYBYvmq3n3obYKMszOtLIkM2nX9M5IDyoAeUqlrvCMSOJWMSYbeAoO4NQJc0wX1Wkc5gO2fhOpMC4R/aANhTOPgeOfNjhuy3/vd2s6lbF2g1+u8uxawQ8MeilK9y2BQWuecoI=
Received: from SN1PR0701CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:5173::29) by CY1PR0701MB1337.namprd07.prod.outlook.com
 (2a01:111:e400:4c1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 10:03:16 +0000
Received: from DM3NAM05FT009.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by SN1PR0701CA0019.outlook.office365.com
 (2a01:111:e400:5173::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:15 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT009.mail.protection.outlook.com (10.152.98.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:03:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w63A36IR023102
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 03:03:08 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:22 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:22 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A35nc029003;
        Tue, 3 Jul 2018 11:03:05 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A357d029002;
        Tue, 3 Jul 2018 11:03:05 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>,
        "Quentin Schulz" <quentin.schulz@free-electrons.com>
Subject: [PATCH 02/12] drm/dp: make dp_link_status and dp_get_lane_status usable from outside of the core
Date:   Tue, 3 Jul 2018 11:02:13 +0100
Message-ID: <1530612152-27555-3-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(3190300001)(189003)(36092001)(199004)(246002)(186003)(50226002)(2906002)(26005)(36756003)(42186006)(8936002)(8676002)(316002)(110136005)(76176011)(54906003)(16586007)(87636003)(336012)(478600001)(51416003)(26826003)(356003)(7416002)(5660300001)(105596002)(6666003)(106466001)(305945005)(7636002)(2201001)(4326008)(47776003)(486006)(86362001)(50466002)(126002)(14444005)(48376002)(426003)(11346002)(446003)(2616005)(476003)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1337;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT009;1:7/Kczsc2m7z0fFR3PsGLSQQcoy/YwjrTrdvOkEjOWR5WxqadHdRfFO9G6KB8Y8SK0SYtezGtLnjxm0n8wouCHfLgEQGuR9AbPonwbJiz2RH1DXLkl/EKzKk4Rr97GO9P
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b919519-32ee-4813-e2a1-08d5e0cc31bd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0701MB1337;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;3:PxMlKO4llSW77Fn3lBlnaZpyyWYuE1L6XMCEWU/xj4VAtpwE0CdZgKAXuaEng7JqDlUU2gVOjp84cBwIJccBxqxLIIYvwNTVaxE7fAOteAyBp88s0pRD3fA7JkEMrTDZTuNhR9Mfzv9j7uGocceD+dMxg9GdYK5G/C8OpnlUlR7l2VuissDfAERIWH+H84OCBDThf2xwNUlNb6I4oyR3c6YJi7vgsh3Etm7rzVpGAFuI3ToOFodjvxOP0Zac4SxcaLhhmEVju2lUMs7nkVBMIkBAv8N7+LwcLGjW/rdTv7d8ApMqUrhHSXDa5MLbEX1Y8iZNM2Hz1oZ6FCw4rNASxPp5h92nLjjwqdTcyDjJY7o=;25:aoDzW5PsJMA/ku0spUjr8tOW0bCK3IsWAnbud3hqcW9M/3ylU3skDIO6Hu7xZObxWsBTtc1j2+dRNHXBFFB8POwujjddx16OQrbAP/PiTY3tV1cD/zKguIlag4oJi5GET1Fxji6ZyyDnPZA+rSjkPBMtGKSe5lsy6FDjRalCwg5GN52KB1d8+P9W2QNBxaQ25yuRUjMnjyOfXlLCNgclr6rYZtv8mLgzkR0Yj1QjVDIjfUQckrd83U9lyuw8gdY7go4bvVigWkH3IQIlPSf0MZCqVj85eGkkI+dBk1U6RMJ/F9MouJT10op4N50FEie+n6HeEMJg6ai1zl/0OxMdAg==
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1337:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;31:4SvsGV1Tw5qWtbVqVB7rUWSysv+Of5RiqQsKA6AMXpm/IH0dAj9aHptWvstLiaTuI6114Ht9jRKbxcvoKPVKOT8M+4QpCfk8u1vBJxwnm1j6LelA4VaNSOWUcg+649Pkx8HCcXEtqO3jzfwsxz+Wm6iC0W1wreAgzM6yCrXjdG6NPpWcrxDffZW7IFNPeRwujOjO4pO7YG9D18UrsaCobYexc7nfw3I/JWqj/YQZulg=;20:gwPlmHgRb32FVphznE+GwZhjVI+FyfBOC9Fu0pO/ADh2BfNqTwLiRYMM99x/dKAlNnD+cr/pHHKgFprGFw4eq+sL4GRlHQ4g8uPiZbkao0ibGTT59PKAqiI5pkTsjEv2ovBXcoqEdHXT50j7uv+hXZMDAKm6o+vs4XOQYoIBS3xqUtjXOvPoLQZXFVJFo3wXtBTVElBojUcDgYKu/heB4r0PWrSGCaBeQZzi9Q+0U3dozzNa+hqZd/2JZZRrrlwuaswijy7oTkL3nDUddT8Myqrt4JHmIUz9pCxrreSCWyB+uAAADcOKvssSSaNjtffxZLJ5oLt4Qw5QDOi1EKBkPTOXwuP2YeoUlPdZzfDkCkOy5ZkPTh33gGO0P3Fi4VTjlYB4M8kQzI9KFygt4CddjP+VMoW9TmlD4Onh9uwZlQ1qrWVtid2K3paGhSB9DOllRcXp65kPHhGNtesS5xTQIb2cfkHIjxatTyBv5Xd6XRr5UmSAvJ6dNADIRnPLShCX
X-Microsoft-Antispam-PRVS: <CY1PR0701MB133760271423E3FB33ED58D1CD420@CY1PR0701MB1337.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1337;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1337;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;4:ZKOD5UWnUpldLSBx5ysk/0rC0bdu0/x5VgkK/KMERVDxoytdV4nA4vBlFW40TahqjUMtP6rPoZBtEZw1UqWXIbkH6zoAnh9l9NFMU9aaiLr0yvgQmpVfN+r+T7ZqZ1xdeX3MgSaP+4AZGhhV5l25ghgz8q8tSd7lack8vOk0QUfns+BTju5dZ1ICso0oAMPkxlMdMNJ02QB612pHwGCYxnG0eywhTCH5Co4IyNZaEscvGcLUWzax8xb1Bs6ySzNiIqzcdSXfV0D99xD+Swn90rn7568ERvNBpVCIhdI7+Ey1tEo6pfhr9yOkSUvuy5oztJhbnt6fy1QU9UhQFYqmRt6Tm3E/9F7DsZTCowgnpVM=
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1337;23:Uk2CBdEKLKDl4RzvBJZXhBfspjXzp//djx+f04D?=
 =?us-ascii?Q?Bl4pG7AAWLpWJbWrDHp9f0fYhArnRzLDagcVkdB2brnosVz8nKLLoUT64RJq?=
 =?us-ascii?Q?A+JLoA3OK/6nCqw/PLRbI5iK3HrH/pEktKkWVlA/AIy895m1Y/kWnS3oGZ68?=
 =?us-ascii?Q?fHUHfTNUWaTj3YlXXFlkuqrlEEt8bipd8GAit4iJjCchlVK/rtjSPy7nvr/H?=
 =?us-ascii?Q?+w2cAo3I17f8sN7RAQCEq3s+LwzrKcjdMosjBqBspvjN/zw5XNvza8KtTO2L?=
 =?us-ascii?Q?PD3sMEyzIj7DwKl8X26jHLX4Ud9ByLwxG5EujvwlFZ011qG83Ok7yNZfIJIp?=
 =?us-ascii?Q?1MGc8uUA8C6h2Mmjblj8uGeTb+SNS1wIaB+H8j2CXlUMl0+EYBYbexxgJIfL?=
 =?us-ascii?Q?GxQKbqLEzzQypeEBFUwwmL+XDHTONCCkpR8+f7DWwZJqJ6+H+hMcX+PXoeDU?=
 =?us-ascii?Q?Ox6JNOS+bVIdMDt0pESP25Iye/NzIQ0zX34X9/Ubgchur7ripZzHjEtxBhbY?=
 =?us-ascii?Q?/d4na3JrjDq1u1Ti7Ya+LdMlK6RYATGFNJErAfVLqyR1cNUf6fswzeG8Vbh7?=
 =?us-ascii?Q?nBE6rf9sykwKK3qCkM1DIQWBJYTWbVmGmdHMRYNk6uW5sldmD5rU8ArrESzZ?=
 =?us-ascii?Q?nwqRuY9oDS6RFdHGV7Wim6mcnrx0HacCf93lIrtC1oe36vjXrtczY6TNvmTE?=
 =?us-ascii?Q?JEN7EhLz62beiJbhFYZ6q/PGnni4QPJZPvB2PisJzQk5q+8WKjQqeNY6waoY?=
 =?us-ascii?Q?C5Dg4/VTiNvfSk6UvFcdS9iXBDOEGqx4yo4WQlSDoKqpVUNQZDGH7VbHv5ck?=
 =?us-ascii?Q?roCr9f12opdXOHLP2ZPCg9faMoThIldoWTvcRLWP/f0I0I3eoMpTiGMGClOh?=
 =?us-ascii?Q?KReu6lKrcYC+/5RkAJHagVgUtnrb4glfKoYPWeLj2GU6eflpgpv7xZES2BOD?=
 =?us-ascii?Q?5K3e2asiFd92ST0Xv8peo9Fuat0e7CxZnn0sQtVFTeuHig0bfKlxjupul7iP?=
 =?us-ascii?Q?iycOSv3LFa7qsJ5AK2hwnM19PLnyimXJjjw5EuweUpuNZNnsYajZeto4CyqC?=
 =?us-ascii?Q?vS+k7EGzzOSozLlClrzuFGTHsOqwjyZruB6AvGvNT3G9S79QT6btC2wSb9CH?=
 =?us-ascii?Q?mmPA8Hv0I30nJ22trgvX6By60fjmsktyz7hCt8U7YXD1tMVtlPu7upXFT5yc?=
 =?us-ascii?Q?FPcBscbBaS7yR4YTEzyUo8lfDP1WkLiGzSUu2?=
X-Microsoft-Antispam-Message-Info: kV4JDZ9XARC4xwiWQH+gpqQke4rc2Qy/tpCWo0DoDq1RhU5E37/olPad7yLd+2OaC2/9Fw2M9f6Cqe8tymbNYqIlLVOcZShPVeOpvmWCYUJBBdK6yR6k5g5JVurrkgwkpm7x5Rx+7VYPmfkWZLm4bThrlds1Hcu+qNp79IjY/7XPJ4ag6OjJ+z58qt6YIyQrNjU2KhDderxNq0Cf0mtmRpF6vgizfpnxZr5XWC9N32aIhglru3ZthmmuEaOM+AqsBm2IkiiKbIXeqTvwtwepLSeMLCbo0i2BWS75op3p/YFIqFKZLVQqItUFtTxqLyGP5pUodbd8cgMzh7Jn77HG4YQUJ83SiD02vFPXz/fW9Ljfuc1tU2AulqBKHjhBjt2Rs9shCgwlu1ArN9y09QXMpA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;6:o4WeWM532K3z2TRaHrDGSbpyM2FsIMf7thMJWvvi3gjGOKmKMT7EKwVZez3KHbZMrPQc+iQ+wLyWBQ6eq4wEWErB3ufOxSvdRgXRsWagEK0cZQhiHSjaodhc+rl7mYekpBhAvC/W5VZSs4sBmnDIdAUUj2TY9m6SyRUX5c/l9eCflIkLzrQC4Cl87qeRZv44lPcTiZQMgBL45su79ETpcCRLbeYNI4Z1zExoJeE/a4DMul4TDbKyV+llhmRmxp6EpSx6dICeUpc9mjMe2wL0owWaQO4tIhHpcjyXbiE1di1sCegLmwPCqrledibM7zydwqg47YRcMZryncrlVNotJDBDhhlTcTyBDsReOstRYQQNR9bV0q7sV//OKdTQ+OmkAVHvcpgMGR8YV/WY5Rw4UfrYvAgDW7DtkRxxMlOmXfWgI/G+MgC2M1BYNuCADXqfeZtGam0EmAL/EQHNeA0vfQ==;5:D0e6mOUNMc7Gqz58qrA+8ADgLLZDT9UiKVcJEfJyM5baSX7OCxTap8An8fWvj1zUyaHOOiEeupIr3V+gGOXfLSkPKXZLhiJ75qcE7X4WWRZLDXSpwsZsBoeMlBHzntBoB5iwF8IH6yipoL9Y8KJRdJx7oRpIXLukF6kdYGxjEFU=;24:s2i1+l/1ToXrE6Kq97v/Yoe+tyWAlkUfDNlF5CcCyhBhXDhHKnD0zW+YCg+42mZIkuzxmo+yo0x8eygCXcxEWYkWaKDS91xNGdrsmFTf7Qg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1337;7:Mm4hAChMyRf/lY63VOPuxMAY4P8YgwhtJZhnS9fejzteK0cKlKQaBcXgOZUNDcXCMmFmPpt2T1ZjFrSd57xsdZZsrPstl9UJpquJWxjeDYeqnnU8F5Rrzy1o+JOkbTxD0IZofTvEnC3eHzJtu640vXPYd0jP9jVL+tdX+pPRnC3TdKn/AaWFEX2G10KsqATzAi0S50WXM0ITJRSTjYLbfYzVVTBbckx3Vt1OncYnmntaSLOVES+ylTopl4vAASYK;20:aFNsbFkjN/zlwKDh+ZPT0IazqWt9eZZcfUL04JN0CdBbhPqFW7UAccYZM6L95nJ03fnOuBgAMpAS7jDT8Pak4ApjPpaPxJg3+6X1VslQJQmSnXpOIc1txi38d2fbg9YJmP7kTV3Ixd7lZZTuPT2TbNv4EeJWyzIEbUIMgt/utJzdlsH02rnuhFJnwVzWJ1lAufGu5Q7x8rvmDhBeQJY73HsEfJ0MDd1RMOs8ITcXTDkF7RhEDtpav3HxJChK4U/C
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:10.2926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b919519-32ee-4813-e2a1-08d5e0cc31bd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

dp_link_status and dp_get_lane_status are pretty generic and can be used
for other means, so let's make it "public".

This adds drm_dp_link_status and drm_dp_get_lane_status to the header
file and add the appropriate EXPORT_SYMBOL for it so that it can be used
by other drivers, be they compiled built-in or as modules.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c |   20 +++++++++++---------
 include/drm/drm_dp_helper.h     |    3 +++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index ffe14ec..3bc2e98 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -43,19 +43,21 @@
  */
 
 /* Helpers for DP link training */
-static u8 dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
+u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
 {
 	return link_status[r - DP_LANE0_1_STATUS];
 }
+EXPORT_SYMBOL(drm_dp_link_status);
 
-static u8 dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
 			     int lane)
 {
 	int i = DP_LANE0_1_STATUS + (lane >> 1);
 	int s = (lane & 1) * 4;
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 	return (l >> s) & 0xf;
 }
+EXPORT_SYMBOL(drm_dp_get_lane_status);
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count)
@@ -64,12 +66,12 @@ bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	u8 lane_status;
 	int lane;
 
-	lane_align = dp_link_status(link_status,
-				    DP_LANE_ALIGN_STATUS_UPDATED);
+	lane_align = drm_dp_link_status(link_status,
+					DP_LANE_ALIGN_STATUS_UPDATED);
 	if ((lane_align & DP_INTERLANE_ALIGN_DONE) == 0)
 		return false;
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_CHANNEL_EQ_BITS) != DP_CHANNEL_EQ_BITS)
 			return false;
 	}
@@ -84,7 +86,7 @@ bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	u8 lane_status;
 
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_LANE_CR_DONE) == 0)
 			return false;
 	}
@@ -99,7 +101,7 @@ u8 drm_dp_get_adjust_request_voltage(const u8 link_status[DP_LINK_STATUS_SIZE],
 	int s = ((lane & 1) ?
 		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
 		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 
 	return ((l >> s) & 0x3) << DP_TRAIN_VOLTAGE_SWING_SHIFT;
 }
@@ -112,7 +114,7 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
 	int s = ((lane & 1) ?
 		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
 		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 
 	return ((l >> s) & 0x3) << DP_TRAIN_PRE_EMPHASIS_SHIFT;
 }
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 62903ba..a488af0 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -935,6 +935,9 @@
 #define DP_MST_LOGICAL_PORT_0 8
 
 #define DP_LINK_STATUS_SIZE	   6
+
+u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r);
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
 bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
-- 
1.7.1

