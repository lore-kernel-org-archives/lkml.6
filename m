Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA7EECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F18F20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ij66lmvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F18F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbeGXMUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:20:40 -0400
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:63872
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388563AbeGXMUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J19SSJJxChy2EneOUfYxhbebeqOCFM4xe0U7ySsbMdE=;
 b=ij66lmvLIQic/2uRijCxe0eHMDwfrnuZjM7rbkqbUE1UJWyhqq8OSZVXWaPzZzoNyeIRRFslO5utqdxLecTIy0dIhYRO4099iyoplYQ5GhWORG4Fm0cJ8ekz/pm88lJRM+vgVHpDWgAHlB9+oYiWeKjlkG6CM+B00M3H+C4VZUs=
Received: from SN1PR0701CA0081.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::49) by BN7PR07MB4705.namprd07.prod.outlook.com
 (2603:10b6:406:f1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Tue, 24 Jul
 2018 11:14:36 +0000
Received: from BY2NAM05FT056.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by SN1PR0701CA0081.outlook.office365.com
 (2a01:111:e400:52fd::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 24 Jul 2018 11:14:36 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT056.mail.protection.outlook.com (10.152.100.193) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Tue, 24 Jul 2018 11:14:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBESOK013067
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 24 Jul 2018 04:14:29 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 13:14:42 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 24 Jul 2018 13:14:42 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBERGv025162;
        Tue, 24 Jul 2018 12:14:27 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w6OBERoj025157;
        Tue, 24 Jul 2018 12:14:27 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <stelford@cadence.com>
Subject: [PATCH v2 3/5] drm/dp: make dp_link_status and dp_get_lane_status usable from outside of the core
Date:   Tue, 24 Jul 2018 12:13:34 +0100
Message-ID: <1532430824-23477-4-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1532430824-23477-1-git-send-email-dkos@cadence.com>
References: <1532430824-23477-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(199004)(36092001)(189003)(305945005)(105596002)(426003)(36756003)(14444005)(446003)(106466001)(7416002)(11346002)(4326008)(110136005)(316002)(16586007)(42186006)(54906003)(5660300001)(7636002)(47776003)(246002)(8676002)(26005)(51416003)(76176011)(356003)(2906002)(50226002)(186003)(486006)(87636003)(336012)(6666003)(26826003)(478600001)(50466002)(86362001)(48376002)(2201001)(107886003)(476003)(2616005)(126002)(8936002)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4705;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT056;1:6s8Teu91VEOsPAk7tAire4rLZGg7FuUmdeQycqw0eACciW1KDEC39cWodewu3RECPmdV08djRo+aKOL9NSA+xxLM4udJCBLE6DzxRIT57s2VaAJ6j0tCjWo3PfBk/lp3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f69997-5603-40df-f020-08d5f156a3c3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060);SRVR:BN7PR07MB4705;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;3:wqMO5Yhxd+nqBG3Bb5LZopmRgBA9t7Joand10rjVNJgvW67QpoL79wXs+wDGd7ZP5R5LkPHQ6ziA/zoMsEn9SEWYARsKBWvnEuUtwl6hhWCNim6MCCfLMHuVaZbshhcoJDuTx5tO0AbisM7Ag/w130csryNr8eClS0mG87KbXFchzw5Ao4VJ+nBl2xnPn4tpD6bt6C453wLL4XtFfaboHEVABs/Dr5t2Lnzpzmx4W9RGjO7vO5ElDoEvHXw8rmbLcgNlUyWp2BQcj5E/mqtMZ0gUWSi0h0o1sF1DbzMdXdHAsV82eNQYFNJODp3XqFX/9kPlzjyUbcGTV5w/O4u93JFqlke9gBuMaWN7WOumMsA=;25:uXSF1CTGn+t2XlXjdHW2T/b961TpmeHjesJxo+HZQQSYZ/V7zq+nNVkHvxH1zyA5IcTW0KCnewypMRLshB72GJqjcua5VTwply8/o+hSu2DlySMQqhqaoZOOkZXdr8kYieWJY42qE4GvaI/5i8gtcdq71K/I/JH0w2KCaEiFaWNEiiK4KjI7pjznR2U0NA9QlONH5oWy9nl6p8HrJjuNRW0k5Jqm/eOJ01vR8WVUj2cFRQ+DpcDIvMqCtEz/lI/paaferZXWk8Votx1sWC8fThRZOliuSO6UHfEvHrQ4Gc6jUUbk0c9iC7YN1JtjKGtXZFCpk6X9i24MPeoCUh7gsg==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4705:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;31:qOu2hmDiVl5bTMVjXHMy6cmUhnhkZTjKZbNQ6RHth7lLhB/TUjlazZq3DssmPK1F/EKDO2YeFG81S8bUQOOfrD4q0KruZGruAt5JZlCckboQfoS7VMYDiKHImjDf+pHocH6BeN/dzsKF260ryVvfUFeBs5bpDBA4OVCxSz036oUARsJgU1/6BO/xvw9JI0K4EF7QlsO9ehQk7/jrHNLIOmCKOBp6JDaUd/nR4YjS1wM=;20:B/qFZOQc3hB8R8ffUPEH45ZY/SzapKbu/+f5cglkxaKAKyevFZO6sk9rWoFGzRmvjFsN4O+yS0b9rgWB+oaqve+SOxcPFderu5mowm5+e5QB3KTmm6WEXh6wB+KRKRMgx/4wvseu563X20CBaEqc3ZPjNrdG9n+J2FFRL/IWM4+cwRhbxR2ZDR1neuH0GFpJEJlzU4aXjmsB9+JTPDh47uBexwTlphsqfYoRfyPcwOav06sbYoSxZU1XM+ZtnSgFGA+uVVJYAv+/ElOywyxXu7zKfo19LnY1OixmT/L28AtprqyVgSEWW2HYKYFJhWb9n09J4srLqERdl9+ZamL4El27eudMX5He4+xn57YvvcVNEoNbgXlC26dSIXzE2zm9S5WX41LJcGtN7oYbxnNoTsa3f51hh6qwziyTGoNxHZYo3SMBQQsXQ+aTxjQCVvv4f77/+LYK2U+DIqz7uTnrux6dp2vplBCA0jtWZ+h/AQlMF+CYsSXBWW3y7CFKEwoZ
X-Microsoft-Antispam-PRVS: <BN7PR07MB47057EFF8D2135BFBDB575B4CD550@BN7PR07MB4705.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4705;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4705;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;4:/s9CIE0DOxhmZU5l0T74aMoD168eKjVz4GNBB51A7tuyUi2820O+FS4d+hSMdxlIQfmJM2awFsNeF/iYYlGoFY+6F6r2kZm4/ZHoB6c+Sty9BYB6udEMk652YJ1kenoXMg0MVB42nVWj26XtDE9fsnQYV+/dRWYC0Kb9dLQWA/vT0k2uVqUaY6lZ3mMdI4JngK4uLDqRQOte7lAhHf69JwII7WLf8SxNW5xa+0IUg1VjCWeafDnPkfccKaRJq627Jgy2V6ir76x40Pw+FYlHZhOYvPAOEcxM50/v+1u9nnO3rQUE7I+eFT1jebEpGZ6f
X-Forefront-PRVS: 0743E8D0A6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4705;23:1rrSYFRHc7zfESZc9felFh2LRZxRTcws7eEpoD0mg?=
 =?us-ascii?Q?iHzccoyx+xvzcfLqnaZJ5QTzqYv0K+75+RztUg8c9e0jkCl2bz4A+7L1M0PC?=
 =?us-ascii?Q?V4wJO5qYDDPFp1TTwLALMTXrZ8FTe70iPKGAsJzzzqv7gajA2vfW4pwRkMMY?=
 =?us-ascii?Q?QlpASeexgEzSoUnjZx4GoymXaRHnP9TdP5ihKqrPJLUlgDaxCuOTQtaZAK/X?=
 =?us-ascii?Q?e6osXUZwXquKPLPgP+O1vmSf0rZKHBu28N4/8hJdKt1A+tH+guyCX9Wm7X+v?=
 =?us-ascii?Q?1svQWammwulC3ja0v50i7Dcq6PYSwVshooRktWN4nNZr0FA3ws4KWknhVpSf?=
 =?us-ascii?Q?rXotIj1G11ltUNAvnHqJPjiYIBvafiq2zZRypbvto5e3QM3jFNdqvTUlQHHX?=
 =?us-ascii?Q?zW1eJEVf1g3SWyUwfRLE17+cRge/cofHDFcCJtnMhwww/9Z0luRU94VuZNKt?=
 =?us-ascii?Q?FNno/eyviaX3Df67NUfcrKwigaAQkVykeNRFkLop7bSHdjHvWvh+t8djQrD9?=
 =?us-ascii?Q?77fBkcus7wDMCxQ4sYFYVQdAcGQUh943QTRFE/Fdjj5rwuwTtrDvJJSWPFH2?=
 =?us-ascii?Q?cNAVaAYywdmkG3nRuVkyPHxr9B0PYNObJL6l8/QXxwNO/koiAhN2MEL788NW?=
 =?us-ascii?Q?jwRP2dymTc3s3vZpUVZl54kxaTgjdmQSWoNKDcH3D2Lgv/Cpy1ASCSqAk86p?=
 =?us-ascii?Q?7/BvoFXe/m2eY+3vTErVnYAQb6VsrNn4p8+V6egEpT5rFGtFIJxMofBShK84?=
 =?us-ascii?Q?gyY1nhNQS/OKNBl6xZlo6ZGt4VNb+UGXcHLtKgAr/3kybBD/rL9JGG5NPfmc?=
 =?us-ascii?Q?rHxxNLkDCeuZjGLf25XW3MIb6wuKbM9E+RKRq+Rt74/V9FpH5qjNkbswoivI?=
 =?us-ascii?Q?BaqgUvNIvz1YiaQ09hz+mRm5xBE3EqgeGjJwLsjTysAd7yIUGMgCempk5gyR?=
 =?us-ascii?Q?Aw4oczY8ywsJ79Unbjm11Qrfao0n4Mppq0Yff5qqjGSro/vxt8eyVA/+823L?=
 =?us-ascii?Q?AlV+klw3YzzYbXMrqwyacCQU9h+XJ6ZuBDIolL7ByxpUD5l3bt8F6lRwhQ8D?=
 =?us-ascii?Q?5iNmEbrUbg4p48SSvDpJcQnOecag/KMDDAR2rIIO4BC/UCtyEFuGjs08o4sN?=
 =?us-ascii?Q?0uDinA/R1JI9UzbbzPV7jF31JDXXk/NBmTJp8X/XryjdLjZ6vZ6LfNWHmYUG?=
 =?us-ascii?Q?1vqwglCZQsNt+XWqDKHaNKwNPAiCV5Fnp7O?=
X-Microsoft-Antispam-Message-Info: aoYEIaWCWN3C3wGdHceEF6w7SB/EdqSNFzk3o1lx8zF0VwW3fDj+CG/2c63zXWCJP2L0wEFt3Dz+5DLXV86JXZjW4wZByD7/27UZMVOF/fIXtAH9wuHAbePexKXZdCmTRLvASUsXiA3iD/hFNIb0xk/vRAewZbrPQjH/E3nz4jwKrebr+XFlF0jgcNi9+zw/dgog08drrS/FTAeed0F88uoL27i0LC/0EBuj1UHHrUAuspWB96NIcAUYmymKttt4FNrxKLm+ul59OnOF2wE/rmD2KjrNABPEdLJp38Ml5IfClv8JJxga9aA8MXbB5vzF9RuVeZfXoavBTOHNJotpe9wis6SyzjFEYhQuP5XCTSvDZyo7yVCPSHEPD4de5vURLWIW7TcWSSyLqNXiH+j1vg==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;6:zF6MvC0xU1n4OTcJRsTHc57wIAfuR3sBht29Svg6Nhoi8+AQW1C4ul41/2ez+JFSJPGpOnGu+LHjUPz2wgX4xcVbFmGs6RgTWkANTi2iQzcT2ehFTVRD4EOlqT8w0GUpSBHS72DRDtWy0M6uS8L388zDVDJhIAP5IHULDEtnA2ayIjVOpSEZfAyEjnU7xgvfid4eo72owvZEMBe2vk0aY0TBE0naUfjARJtsHair4n2rZIMcGS8F+AJE0PvYV7L7yaBf23jsE+ofso/FiPEZl73S77rW53lNBN1AWBofscVXG5nHpSe8kCkrdvLlAs+mZmBV6jRyRd3Hf+jFfDX1fpMJgm0hR/VYqkPGyagtYxn0ovCcrCrw8/6s0qAXeQs8CeDaoDA9DSVjx07KHhM1t46i2k2LD27l+wHs51dCwSZzdGk1zroTmGPhP6vqULaZe4RelA29isYlRCfQRpOq6A==;5:JUoDoQDTjDszwheQFEWs3K1/S05r1BVfQL0PRJVFsxXU0mtd+f1vDITXn8s3EvZPTy/XEDggoYpARigldr6JmrWW7Y/kpfLASv6nW2gyQaBL304c5lAl5yiSirAbTO9FSqAZCtaTJBbPn329+ZxUJtxCOIZZFCJwRO8nHZLRt9M=;7:96e7HuAvuYsfdZlPIca0Z/vzzqnaEQUlWApvp/bh/u0hzInUXgoJT1uMh5eYJFolRCmYi6JycYR3D7UWwG8Js7f5I4qKj0V4WCaUgaHWmvcgHLplV+UV8FuDCe2Gye8XOMCgEujg5awZMViAds3sSXKjMuPNk5mYq4CeqztSx++xVddRuS2cf1Xn5/DTr72egdmCjWzduypGY8Wki0H5J8i3IxtJCfFnyKFXImW36yluxbboLUTPPYnJUaoVlHHf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;20:bA2c0KH16Vm7CS4ST5blWO1bx1DtBdf/Rv9AB+QjKW3KW7GmB2wnqmUvdl+zUFhmL/6osWEmv0Y/vetDNrnoVe5FOSud+9OHiIawsWQXgOYUNLB57nTbmVKTlTiImD6AT5FtTMWZa2W9c3a907rxl/IPNmVKTgcpWSm3ZQZxtldtk9dMM9FHrmnlynczPaJL6PJ4VCd9+0Er+VU+aepZnl9/Lem905+Fe1840qUmcWBSNHg/fpM8ihPvOs/yOkDg
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 11:14:31.8395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f69997-5603-40df-f020-08d5f156a3c3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

dp_link_status and dp_get_lane_status are pretty generic and can be used for
other means, so let's make it "public".

This adds drm_dp_link_status and drm_dp_get_lane_status to the header file and
add the appropriate EXPORT_SYMBOL for it so that it can be used by other
drivers, be they compiled built-in or as modules.

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 20 +++++++++++---------
 include/drm/drm_dp_helper.h     |  3 +++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 86a070269c87..8d10f70465cc 100644
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
index 92800f2241b1..1ba6b6855444 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -952,6 +952,9 @@
 #define DP_MST_LOGICAL_PORT_0 8
 
 #define DP_LINK_STATUS_SIZE	   6
+
+u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r);
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
 bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
-- 
2.17.1

