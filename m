Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492699-2-723769601116214624
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
    t=1520492698; b=EQhLB+UZh+0zca0HtcLPxsLLEpSCaKYOjbzhtPuu8CiDJp1
    jUF9Z0fFuSzSmKmngGPEsDPgRtdrymUtdHgmfjblA+/+82LgpEGjjGQY7xxRvTLT
    aFD034UfwHXYAvRxHzWYfisI5/VD9YKe/LNFUgqxkA/dEWKXUC9uUSUUBAWy0iju
    9wJIsQOPSO8Wsy5B1+69jvlCFyWE8HfZzHedLC0PnWyyr8kOpa1IIBvDAdJGS53m
    NGIwrjyERvutnSka84b8w+B6Womn/xjGiy1OJD2uAmZSug9zndOpVK6CLqo2gYaD
    xjlOdAGKYGU/hVcll+WAdSQzIXPtKBhKb4FwerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492698; bh=DgNuya
    pp6pM0+pCvUX7Fn+3mo36vhmSgS2TIlMDdnRg=; b=sIWMZAAty8k6qbGbmmYGL3
    MWH1p2yoyxm2S65yGzv8uClnV3SPNZ2sK22LJU0W1WZ/7POoyJ0AmXE9ILvk5FBo
    ItadEb0tRh920QSbPz/5jEt8d+MsO80jrt3VLP7u+4d9S7PQZNaNL0J95VHa9OyC
    I2Q8z1MxFb05zosPXSd+IpqnuSZ6Ot33xIwplOuqb72Eadx/ZC/oxIFJK1uaixyJ
    tkxvHa7spDGq0cGTGFJQVIMjIlCtHcHX847ARGH9hReAj/ilpRCz6x+sV+0znbft
    h5l3ASuup2TtGaFojNow3DYh45ez0rT2Lm2TRUHFyT1/9oSd04zs4+gXjR09oxaw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EbIgt9pC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EbIgt9pC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755331AbeCHHEJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:04:09 -0500
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:45128
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755299AbeCHE5E (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>, Jyri Sarha <jsarha@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 32/78] drm/tilcdc: ensure nonatomic iowrite64
 is not used
Thread-Topic: [PATCH AUTOSEL for 4.15 32/78] drm/tilcdc: ensure nonatomic
 iowrite64 is not used
Thread-Index: AQHTtpnJfCxZpFiK8EWzCktX2oj7Ew==
Date: Thu, 8 Mar 2018 04:56:15 +0000
Message-ID: <20180308045525.7662-32-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:/dKuUmapY7XxUubbs1JGYn7/mgnQpEm9V9voIkgWVG//diB2apWmfjh2dp7fTGRB47FAnVLXhn0WS//pFoEpCkwdFqS5DTWdz6qSZhj04OuB+8rXHZlbb3pAUpiQqIGMYwGShD2KOJ63/2G2MWeRWXQM+jL+xACyXdkxcETD48H1XU2T5OHYe+9zrnHjvnrjweRj/wQhgPKwt1bfm+lCuDlNn6Bfh2CvmH7YlfOdd4sr4UB92gpGtVcnmqhdd4Hx;20:Yxn9+Mnske0bYkbijAV6VdmrCaVgdJ/vbztI3/YQkhRUvpG6izlF/VqpH/3Lwx6nDNm5cLxsTQ3VPgAgg+RwjaVgFJmIV9NYayxG/BWrTY0XI6M32iAroO8vMSvrv7wIkTuwS1S6axnnz9bvzpGCpR7pVC07ptWKc7569HPTTxQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d83c64e3-8d63-4c0c-5f8a-08d584b10814
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902F1396811A4519D09F5B9FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: DmZN82Pv2+Q9kDKimbQloGPyCcspMLpvtW6Ds7fVjJ/H8AW5J9d0gHWB1xTxWo05kwdDjFauVoqquydPWXoDUKdTdcJ/7JNJSczI2sGM4lPvH5kMj5iC6eSCufnH+gL2ujN693qPLvZUxPfLolcZ1MT1kOkBviHVmNtkeuvy30gOgQQPeq6g2M/AC4uiZxLAwFUoYKyft4PYgGdtOcGMHHymCsC8SrxcgrXDrpVQLO6pjlFnJHPJix0F0LOgWeftOKmsAIkaqIafQFDBq/s+KqnkmIHZ6JEr6z44Hu8cRgwCDkRkuChjYqmwTqrSt7i/EsmV4oLpbLn/jH7APOVC6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c64e3-8d63-4c0c-5f8a-08d584b10814
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:15.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
