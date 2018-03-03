Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119661-2-1308455062977127672
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119661; b=vf+6mmODUZs9JxJdKll1LEGwLeR6foX9mca7pDcNH2VSeWP
    gRvSf2VBB3wQJubHIcf7OdY2PsJoCG1A/ePoWQtdGgGK7V5U/YOumVfMMBheG5v/
    dHIzZI9bpNJAVnH4SY36Zf+iHq7k5/DHLEyV0jbLG0FZWaXfzkMDr/HyVWZI4TkS
    G6uPBgv1VCbTVFya7H7z3tph8ENmpWN/B1VmsOcZGThq4QAZSeOUkrjV1dtvICzo
    xogN3EXescGBbCGIsJ9QP15REUkEylrviqLE7kYCmh+G5XJzY7Pa8www7UORCO5q
    nzj7BZLE0Cqb046+lfrUmCovHrcMg6RSVZv79sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119661; bh=ntbjdS
    b37JldPpqlp5lVu7CkgwVF+ZpDGwrXLOFWoKk=; b=sJySl/IWEEG8BsmU2akFHT
    +bdLx/ERlH9hTSNXTQHXse+02RSFKz2NcO9oDy4bhis8NStEax2rhquEwxf1qFqH
    /7rO0xo8GCiaqEDwMT4UwptSOL7SjkrwBJ0gtiXujo43IC1nXXvM1lfR7tih1FW+
    dwnK5TJmupMerBl/8CLsmnrHNhM0Kvl7ETY1HDQ2jtwkhLyJB8uH8TuGcFHVDOFT
    KttB68Ua75x083RO7Vwz2eqr/ughqGNk0+nbAP5RKDQCMOEj+qyRTQDy+X+KKQCk
    JtUKlofJSj0xQB0aZTdxOdHYfdPmzps5vqEIYpSmyKukxDjNvOOtRNCjQebGGURQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RxwVZRIa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RxwVZRIa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933916AbeCCX1g (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:27:36 -0500
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:4477
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934633AbeCCWhC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 192/219] power: supply: ab8500_charger: Bail
 out in case of error in 'ab8500_charger_init_hw_registers()'
Thread-Topic: [PATCH AUTOSEL for 4.9 192/219] power: supply: ab8500_charger:
 Bail out in case of error in 'ab8500_charger_init_hw_registers()'
Thread-Index: AQHTsz8jXX+SL4Vn70SDHQ/WqJde0w==
Date: Sat, 3 Mar 2018 22:29:48 +0000
Message-ID: <20180303222716.26640-192-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:onxDkexMR+GRcfSFJyc7XP8D7hN7VQzgIybvMfvtFedp8Zej8tamCseLdJcOQDbegR2N2uSq51HqWC2M9mPyJA8/3bPZ8o0ROjzsm32LpK6/VwFfDw7IrGwDFZX1nQaqWkjROl9DNxczBzS+jYC4exsaEp9kRPWMhfPLCGdr4QpMcCSHZgv3vmA1lZTe+OSaUoPUtwm0PTcu9ND+ju7vsWieE290q8OzusdM6rqS/fgo1jH1jFHW/s8gcO4k8bRy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad3ea7b1-ff74-4dde-a0b2-08d5815740af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB09698F0D6C05A84EEF5F780AFBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(15760500003)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Thm+jSM7BfAeVMbeJGGBqhF5yDB5s4+A5Zj2DQwRH0NRBSIl+wKPQt3V77emLB7Y9Wj8U2oGUkeEZSI6NpOwDRA3GsSHIE8q0A+rDZBKN7fTmABx6pkIWgHjnsKzntRk61+kxdqYcDMOnxwnsDBBKWiOuRJ2UA5ZeA/zWi267+M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3ea7b1-ff74-4dde-a0b2-08d5815740af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:48.6195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 09edcb647542487864e23aa8d2ef26be3e08978a ]

If an error occurs when we enable the backup battery charging, we should
go through the error handling path directly.

Before commit db43e6c473b5 ("ab8500-bm: Add usb power path support") this
was the case, but this commit has added some code between the last test and
the 'out' label.
So, in case of error, this added code is executed and the error may be
silently ignored.

Fix it by adding the missing 'goto out', as done in all other error
handling paths.

Fixes: db43e6c473b5 ("ab8500-bm: Add usb power path support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/supply/ab8500_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/a=
b8500_charger.c
index 037e93224c38..48a11fd86a7f 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3221,8 +3221,10 @@ static int ab8500_charger_init_hw_registers(struct a=
b8500_charger *di)
 	ret =3D abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_RTC, AB8500_RTC_CTRL_REG,
 		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(di->dev, "%s mask and set failed\n", __func__);
+		goto out;
+	}
=20
 	if (is_ab8540(di->parent)) {
 		ret =3D abx500_mask_and_set_register_interruptible(di->dev,
--=20
2.14.1
