Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117493-6-11910870021278868496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117492; b=l6lPujmjgW35jcnqcrNMPYOvAxO7dzyguipoi6g52AFcCbW
    fY673ydsMOI9ROQSSPHpeMwCajff+xMSzHiN/WRBcev8P0fLSa+KkcKJAHFDs2+F
    0jcyPe3/Uz5hkI0FsEcBbl+PAAkANbHAeVwK/GYpbs8wlvqYQe6/2lGBmiKI53X7
    GLV0bN4TyIdW424KfO9f7MZuH3V6eNtx0mowPB4BSDZ4dwuD9rdohLzU5y2OEvoA
    kZ1SDfINogHEmpXMB17w0FckcNpmjae9jhZ/tbULCRsG0cDB/Zkk5L5OZfAV1fu7
    D8qzIOsQn9bVv7vm0/TPU09jeIWTAGtawqMhHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117492; bh=/DydwT
    0Yq2XT3rajPtEEx3K/d1knUW7+gWuLUiZwlDM=; b=PSeVZLu85vBEWUOkTQ8GcG
    HynnW+cIq0cagzfSbb/nLY00NdMH/qpidCtRrN84T5G7tNCqP/0Yn+y+ZA6CjMlR
    kNEBpsRKEW4QHdbtwnNQRFWqnPhzeVkPEfmzRTHDBcehEwfGYkt9DnKJ+9ZjFleW
    zzRfzYarqLghqmQ1iaINTmtI6i2BUiKj0Lfl/fhBorqDQYebS5xFtCJhSyhUIJ1J
    UvIuMQQdi6QlRBr+7JpW7WTzIO4I2cQVDN0ckMqzE2l/o6mFh85T8x1lygFiARMr
    ZmD65LhgIu0hCBTxGIMmV7fLNQYPzLXgqnL7uxQsvWJdhEYLpx6kDDq6uVRglM2g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bVtqjJ3e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bVtqjJ3e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935295AbeCCWvC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:51:02 -0500
Received: from mail-by2nam01on0110.outbound.protection.outlook.com ([104.47.34.110]:40784
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935118AbeCCWlM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 24/63] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Thread-Topic: [PATCH AUTOSEL for 3.18 24/63] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Thread-Index: AQHTsz+kM0TTQ6HCtkG5Wz7l1tJKLQ==
Date: Sat, 3 Mar 2018 22:33:24 +0000
Message-ID: <20180303223228.27323-24-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:V1TIQNO+Q2aL0f+zsFsZaNXRF6sG6WO4ED2sXTF77Zjhqxh0/CadSvFslqQg7n9y1Lfga5ErvGAWwqtgylvpXe4vEFXXMYEvoq4YqHqwlvt284aGupqrVu29dqYfOyOOW1v4YSAW2XvPR7h1Fyf7CpnRPAKifyoEBmTXg6zzPLAVtcekCuBbCgc1F4Gtre3KiFHC1rErGaAbnHaQZrYWPypJm63+JOOqxIqWayeVRg589Kc+Mi7I9kQZbjGpq9+g
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 735fe039-251b-455b-e9ea-08d58157dafa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0940A383E229217B4F6426EEFBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: VEkQtjeVyjmM3CHxpE1lWYFGBdfo1lhNCBAzQszFhF+ITa0cWRG81bol/HiXU0/juXxYjkzwmagYKB2wdJo5FZZ/OhP/DokdE6SKbVxI8eqGsJVDrBG81vPc/ICC3fbvccPZeEQoG1Sx1SBmjxxPTNCDiu1TEONbXTOYmwaMcco=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735fe039-251b-455b-e9ea-08d58157dafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:24.2474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roger Quadros <rogerq@ti.com>

[ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]

It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
is in use then there are random chances that the usb_otg_ss module
will fail to completely idle. i.e. IDLEST =3D 0x2 instead of 0x3.

Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
fixes this issue.

We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
issue or not so don't add this flag for those instances.

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap=
2/omap_hwmod_7xx_data.c
index 4e9d2a97c2cb..5c8da1a6feea 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2106,6 +2106,7 @@ static struct omap_hwmod dra7xx_usb_otg_ss1_hwmod =3D=
 {
 	.class		=3D &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	=3D "l3init_clkdm",
 	.main_clk	=3D "dpll_core_h13x2_ck",
+	.flags		=3D HWMOD_CLKDM_NOAUTO,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
@@ -2127,6 +2128,7 @@ static struct omap_hwmod dra7xx_usb_otg_ss2_hwmod =3D=
 {
 	.class		=3D &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	=3D "l3init_clkdm",
 	.main_clk	=3D "dpll_core_h13x2_ck",
+	.flags		=3D HWMOD_CLKDM_NOAUTO,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
--=20
2.14.1
