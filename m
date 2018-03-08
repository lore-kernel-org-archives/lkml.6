Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491707-2-9118350512350284773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491707; b=afyhN6kk6M1yRBoC8lJ6wrJajXupeQNFCPvjTgryII7jFL0
    MTcR2Jiu/egTQFg8qj/LhIfsUqgB+gCnlRgy3gtH0lSdhtiibD+oPP435a6y6FK0
    Vxjlac92T9Z/096Sa/yVjiOotYkTJds8r4pvKFwDHg2KZ6hLQ5471YngKDz2Og9k
    OxIhdQXp8xpW+U286kAbLQMJ2C6ZJZMDRRm9ocL0iTY4zR5nvEOIji0smQnuiDaw
    yK7YijdeM01LB2qmjAENVHTI2r3YwiSbwy//pEpord22posIVsn/vaA81mvWus/l
    /c0/U4jTSaMbWjQ6qc0dcOcCg7Dos3FLI8CrHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491707; bh=DgNuya
    pp6pM0+pCvUX7Fn+3mo36vhmSgS2TIlMDdnRg=; b=mkN8VeEfXwggK5o0ytdd8a
    M1rrfw/ufbS6uM+JSJkTerl1EHgTVKuAEfgk2v0+lIr2Ung4jetdWaoMGxG0JRG9
    eTTyFTVX6LA8TKdU1Ez6vKa1ThcXlaucEZMbmK9QhdnXdCopHDKUajKeSmo5evu9
    HTBJxtoMmCTLyDXZRz9CwBIRP9ZQKp6sIIsybj8yqYpFCShY87L3OMHSgw3Sxk50
    AEIk5h1w7Ia6tDzj/TN8qrDP9w52E89yns0rwM55gNVsgagsez3CGRg7tCQ3cLEQ
    cD9Aqrv0X3f9akc62ekcZo/n/2JBLhGynJIh03Qihof/9toAnJVaiDbq7xYXohzQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eFTKRgzP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eFTKRgzP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935138AbeCHGsM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:48:12 -0500
Received: from mail-by2nam03on0121.outbound.protection.outlook.com ([104.47.42.121]:43475
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935239AbeCHE6T (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>, Jyri Sarha <jsarha@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 27/67] drm/tilcdc: ensure nonatomic iowrite64
 is not used
Thread-Topic: [PATCH AUTOSEL for 4.14 27/67] drm/tilcdc: ensure nonatomic
 iowrite64 is not used
Thread-Index: AQHTtpn+UCLtapP+uEmPbmxYWqAArA==
Date: Thu, 8 Mar 2018 04:57:43 +0000
Message-ID: <20180308045641.7814-27-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:ma6owKl8TVh9trzjzD7r8oE+Zm7GQm2ptHMCgwpSVDBRTERPmNqHivYtS+n/oWm4uQZ+rFDeneukXi8wKeZqWQs/ZmyLBdhBEyVJZLGrfZBL36xAHCmjzL4P5Ila32mjYEZ11MfPcZkw06MH3VrMv+NOokXUWzoaniV8sEBN6r0/R3iqajiT+xuIYYkmNpFK55Hw3uStiZyg9AUM2bY+EIQo4tei2KPweQ0nn+2GjXYEwBiwqJwSs3iXKIISuRNv;20:uV/nVnSxFewFejrG4OLTqgzl+IVGiN1JNkFpitmsTGKxvee4EWWX4ffO0tTfZJVAglLGU7sr0f3qG8pEjgTsvahS7vvNHZSTlPF61IEw2XYvnLIp9m21E1MwjKpfDDkPTYPYjMDQym4XPUbmd5KhsTRfbWOrdOaRyGbzkGz/ihA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 076e5132-095e-4df7-c0b6-08d584b1349f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08853B30E23B8132DA3B3A85FBDF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(305945005)(10290500003)(14454004)(2906002)(6116002)(6512007)(3280700002)(1076002)(7736002)(86612001)(2501003)(99286004)(5250100002)(186003)(3846002)(6436002)(59450400001)(22452003)(6486002)(26005)(53936002)(102836004)(76176011)(72206003)(478600001)(36756003)(81156014)(54906003)(25786009)(97736004)(105586002)(10090500001)(316002)(107886003)(110136005)(4326008)(575784001)(6666003)(6506007)(81166006)(8936002)(8676002)(68736007)(3660700001)(86362001)(5660300001)(106356001)(2900100001)(66066001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 13ZNJgwzTt5qSRYh4yC8qJNHgMVECaS5WlO71VySqI+VvckSSz6xDCHGxWwddgKtd3yuiU42xMh7U34frGsl4GQK0tC9mz+/kUy8f5G0zXrmQDck9bxfEMifqzE95e+FT/LuKAYXkb84ExiG7HHgnkAk5CdGpSBTzBkauH95dz1dreBz5+4/0Fr4i4reXRWQbTwASZmYvHY4Kh/5XrpiIRhFCh066UJT7RULhifCL+ZoKGPAFLDVX78/Qddfhrp2o24gIVKLNAwFQekEXxJ66HotG6xQgZI34r0u1/bbiK+atuzvK0CBt4oNUe00ncMBLimeZygMHvotrA7/SS2x4Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076e5132-095e-4df7-c0b6-08d584b1349f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:43.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit 4e5ca2d930aa8714400aedf4bf1dc959cb04280f ]

Add a check to ensure iowrite64 is only used if it is atomic.

It was decided in [1] that the tilcdc driver should not be using an
atomic operation (so it was left out of this patchset). However, it turns
out that through the drm code, a nonatomic header is actually included:

include/linux/io-64-nonatomic-lo-hi.h
is included from include/drm/drm_os_linux.h:9:0,
            from include/drm/drmP.h:74,
            from include/drm/drm_modeset_helper.h:26,
            from include/drm/drm_atomic_helper.h:33,
            from drivers/gpu/drm/tilcdc/tilcdc_crtc.c:19:

And thus, without this change, this patchset would inadvertantly
change the behaviour of the tilcdc driver.

[1] lkml.kernel.org/r/CAK8P3a2HhO_zCnsTzq7hmWSz5La5Thu19FWZpun16iMnyyNreQ@m=
ail.gmail.com

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/=
tilcdc_regs.h
index 9d528c0a67a4..5048ebb86835 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
@@ -133,7 +133,7 @@ static inline void tilcdc_write64(struct drm_device *de=
v, u32 reg, u64 data)
 	struct tilcdc_drm_private *priv =3D dev->dev_private;
 	volatile void __iomem *addr =3D priv->mmio + reg;
=20
-#ifdef iowrite64
+#if defined(iowrite64) && !defined(iowrite64_is_nonatomic)
 	iowrite64(data, addr);
 #else
 	__iowmb();
--=20
2.14.1
