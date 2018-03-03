Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121070-2-5510397440578149879
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
    t=1520121070; b=GNayeocTVdsydvyKRMYHVd4akWrPgmAFGEQ5p4+NfjibLEY
    C7JaW7suG6tOtL5QvfFkxlbAhGgFGzHqC2SPtTROJDsvDv7XDylXBcBYgPajdGU6
    Yfc3ilufmFOCWSSGXSbrArJyv1883RS32304Fs1GBkAXfg1Xd8V/oj27lrrMSfEK
    oaL7UiKlRDH1XAtoQvdvAdKEa8BkQkJQGyZXYDEaTU62ZC5VbMD45bfSojkKGk3z
    9uTHCd6FOX2OZksewM4Wc/Np3u/aLJZ6fokH1ZzRO19zHmm2KAJ749725g4IT8z+
    Ymhlch2gWwNt2lIXKP1p+JMMEMG3fdQl4NJWCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121070; bh=rDUf0L
    kxhYoSnwUbmm93YgXcytn1we2yFCJr8M0Zm/s=; b=Nko2ix11QZTZ1AYDLFgl9D
    OxjVfO+umL5jrvVDSZbkesH0D2k156JHoa9tM+A+ykWnharGN5emp1QZQsa0ssT+
    udLU3A98aiCBcRqUDv+eaIblrg5NB8cYcpqQy3HYdlVBOnKgQSwnkpA/scQLbCWJ
    c9egPoBM2AXjSa+ktiRoW7uBUC/RGnzeZUHHfwSijlf93VLT/7PcT4bQ9u1e0VfK
    ByqRfAUtK8+wjNlsAhfD1jg/9/HCH4JfJSQ/HZfhqMDK1pXZDSPQZ/2SJlkXfAGy
    3z8pdBgBPMKiVtPzlW0OtDaQvLhU52SQFWGPo0j9J4s1/Me45eej1yU6zVH4BDtQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ohn9Fe3J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ohn9Fe3J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbeCCXu6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:50:58 -0500
Received: from mail-by2nam01on0133.outbound.protection.outlook.com ([104.47.34.133]:49841
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933982AbeCCWdL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 082/219] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Thread-Topic: [PATCH AUTOSEL for 4.9 082/219] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
Thread-Index: AQHTsz78GNSXM/2rAESoEzKdu61ixQ==
Date: Sat, 3 Mar 2018 22:28:43 +0000
Message-ID: <20180303222716.26640-82-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:Qog918xv2C5jXgSNjrZPe8kJQ6vaFJkBuiy3i3rjnwqAMOMrjxaSprJL6ZYNcvNkbXNJObNsW9JK69Jmqnk/cV6/QRfQOIekG/+uBQDb72v3lrga+7TfGASHiH2NsgbeWqR07FJNLMAY0CT0tgLvh/aRDNoeZy9MHfK2FQDsOVEqDOz2+CbU8CAoHQIx3XeP2AJ+gAw4/J/I6i1ibU/R1u3X3AG50JX5YICPyhR/AFhTBEW677RtPM1rEe6dsCV3
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abb503de-00ac-4142-b51c-08d58156bd69
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10977F57CF6BA9DD9EB15518FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2HnT/jpq5oBdLdnQumAlOyiv2Sa/5cYmLYNpafZQNXy47yFAx28PJ3qVZQrvji9Je5MBNhgDHyU+SeMiwibuwKSyhZQRLItjHA0SF8Rt2iGQdr3lsvgld79d9Psc7Y2N6wCwwGYTwTB+rG/vfLFEVvRWFutAu3GOeR81KJH9U8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb503de-00ac-4142-b51c-08d58156bd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:43.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
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
index 1ab7096af8e2..39137231f2b2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2572,6 +2572,7 @@ static struct omap_hwmod dra7xx_usb_otg_ss1_hwmod =3D=
 {
 	.class		=3D &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	=3D "l3init_clkdm",
 	.main_clk	=3D "dpll_core_h13x2_ck",
+	.flags		=3D HWMOD_CLKDM_NOAUTO,
 	.prcm =3D {
 		.omap4 =3D {
 			.clkctrl_offs =3D DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
@@ -2593,6 +2594,7 @@ static struct omap_hwmod dra7xx_usb_otg_ss2_hwmod =3D=
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
