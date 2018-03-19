Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521494967-2-17345587588124100460
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494966; b=m9w4JV/2xI5hCtx6NHXvJq3znGqi9qKHUfXOEosnfur0C2V
    3wqCtyqIBrka6nRiWIj7p+Sz1Uc3DLGBppemDrVkXRBy89fGsJKI7NEJ5BPoK1OV
    NdDgf+ZntqEGVeQ+5Oz62DWYG7leMYqES3xizco2xBQJY49F/2x12to7IfLR8IQp
    ja7w/ZtfibDeY2IQODTo7SJQlxgJntzUS82xdXsFgR6n1pxupBmD2duiDykBVjBj
    lHDnN6cMTVl8iafiLIP63x+O11EFTjMj8svz8Hfwv75oaLkhHiY/7NUvxPjypvId
    Z4ugBtRJxL7qTTgDTIeP98TJIf0GHXbvSzg3Tig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494966; bh=pPTyMt
    n68/xp12fAXWBGxicCkvQQDq5jlFP2cpZhXzM=; b=rjPKijUfnbiHauays0ae7n
    jn8ghzxwLF/jJdQlrdgFP1RLMT08uNPqXlFNPpGU32baQIHTdA7O4rXEq9LmH+g9
    UpEU8uH7OB3tpHLODJRgHmzAg/8b1TAB5LVVtNoE2giJAPuBzKXfHuLRqMiQ2vZK
    z3mQpyse4EPlRb48z19Dcruia1K7Ks9aV01hcmPZgmPdcxphuKdlVuQiCcy61zte
    OrUeHfsrrpTugMDHvSG5YLJbLWzaPYq+2KUtbtY+S0cdpOKpYVns8mYvDPhbRdQB
    CEJ6vUcmLxhO8at9krqa5MdG2EAJBya8HTmzy4wOSoZiFSESEvrDkNac0ihkP9FA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ifKjlacq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeegkeenucevlhhushhtvghrufhiiigvpeekvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ifKjlacq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeegkeenucevlhhushhtvghrufhiiigvpeekvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032342AbeCSV15 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:27:57 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:43648
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965240AbeCSQAK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jisheng Zhang <jszhang@marvell.com>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 066/281] usb: chipidea: properly handle host
 or gadget initialization failure
Thread-Topic: [PATCH AUTOSEL for 4.9 066/281] usb: chipidea: properly handle
 host or gadget initialization failure
Thread-Index: AQHTv5s1qbo91rmyYUyG//OGSsoHFg==
Date: Mon, 19 Mar 2018 15:59:07 +0000
Message-ID: <20180319155742.13731-66-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:Tqrv+kQ2geBPraTx4YN89dePiFIbCLnJ2969LF0yQygce1a6ygvUesqSdgY1CLbw++IHH/WYAR9DSuuV3ZEUIZGsiJ7R4Ien8dPz50dCI9tI4/gh/S5OMAMl1f0ifN5/6cRBzjUcIrmDAMszrulhO2LtHXZSGMF3MK8cL31INKvJq89NslmxFX/PJOeSr8ybcdTnMw0GvWHlxEgc+c/TcGwnOh+1JP8ojZC2dvbBx4U9/IpQRO2ZWe3GX4jEPArr;20:da57Ho2XTfrZP+QwWqQtJAwWPeJwB5M4eCsY/SrY1kALc/Ir5+j0IEpDYYueK6yYFIQ11VDWg/LQgV0BC/ue3qN/AO8W0Cht+4qMC3WJpDPS5cXHrEYFMa6LhNFeWNA2Z4hb3XH39Ydj20nCFLPi9g6VVmVIQROoYJ8KPQUfQdU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d55f16e-10c3-4440-3f79-08d58db27634
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0965889EBE5BCD4C4E93EAE5FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(8656006)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: T9F7jOr8zyo53F3C0+N7fezo1RKYyY1Tg8TlI3VnqxdGnWAOJvjJUG3QD4FgL0qnovcpgPzs4xIgN84rJHQGni/j+R/HeMzqGk4Wec/Av1a6LSt0DrTupxEKlX1XBtpxYA1mda41kgaRJZdlOxGT4F6ReBUx9QRyNsghy+h0IXWrbKjdUY8RxDKF1h0IKfJUJHgWp3yS3sV3aCn6/uEmo0UA88EciDldoJdu19QWCudZjGIksRJao39NVqK8VRqO8WwM1G+m/gstxOFiOszMAXwjCtylgMQHYrP5SfGivfQOxOIzMVeUjnFPOD/iz7xbQh7YSOAW5R7s3fRfFU6AWg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d55f16e-10c3-4440-3f79-08d58db27634
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:07.1373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jisheng Zhang <jszhang@marvell.com>

[ Upstream commit c4a0bbbdb7f6e3c37fa6deb3ef28c5ed99da6175 ]

If ci_hdrc_host_init() or ci_hdrc_gadget_init() returns error and the
error !=3D -ENXIO, as Peter pointed out, "it stands for initialization
for host or gadget has failed", so we'd better return failure rather
continue.

And before destroying the otg, i.e ci_hdrc_otg_destroy(ci), we should
also check ci->roles[CI_ROLE_GADGET].

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/chipidea/core.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 6e0d614a8075..64c6af2c8559 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -839,7 +839,7 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 }
=20
@@ -939,27 +939,35 @@ static int ci_hdrc_probe(struct platform_device *pdev=
)
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST) {
 		ret =3D ci_hdrc_host_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support host\n");
+		if (ret) {
+			if (ret =3D=3D -ENXIO)
+				dev_info(dev, "doesn't support host\n");
+			else
+				goto deinit_phy;
+		}
 	}
=20
 	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIPHER=
AL) {
 		ret =3D ci_hdrc_gadget_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support gadget\n");
+		if (ret) {
+			if (ret =3D=3D -ENXIO)
+				dev_info(dev, "doesn't support gadget\n");
+			else
+				goto deinit_host;
+		}
 	}
=20
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
 		ret =3D -ENODEV;
-		goto deinit_phy;
+		goto deinit_gadget;
 	}
=20
 	if (ci->is_otg && ci->roles[CI_ROLE_GADGET]) {
 		ret =3D ci_hdrc_otg_init(ci);
 		if (ret) {
 			dev_err(dev, "init otg fails, ret =3D %d\n", ret);
-			goto stop;
+			goto deinit_gadget;
 		}
 	}
=20
@@ -1024,7 +1032,12 @@ static int ci_hdrc_probe(struct platform_device *pde=
v)
=20
 	ci_extcon_unregister(ci);
 stop:
-	ci_role_destroy(ci);
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
+		ci_hdrc_otg_destroy(ci);
+deinit_gadget:
+	ci_hdrc_gadget_destroy(ci);
+deinit_host:
+	ci_hdrc_host_destroy(ci);
 deinit_phy:
 	ci_usb_phy_exit(ci);
=20
--=20
2.14.1
