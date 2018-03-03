Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124167-2-4852574329913837471
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
    t=1520124166; b=vVfCoOJ/RBYuQqsRe+L1TlTkJJBvQen5XsKyL/1tksp3sZI
    Mit+X58ZAx80eFT+jCjA/vmWWmheBcjqbDa7ZbYboar3gSLnU1b7a+Y0WFPYlq7D
    m/1rbAcSufz4Omjgt7Doy1qUm3SHrpLlSAsoJvHuzmWGmG119441LQ1aL82qsyzH
    QyMQ/C8BeWG/yChLOQ3UStkQlUlEbhlvppW4h+fnZ/jXdhGh8lvFlOWszN89Tc0H
    DkUVHl3pbKyB71MAp8/yt5pdg9uFlxkAFwTATf6/+04UZtc4AT4vHLuJjchKhOxB
    ta0V+8tqcz2jCQ4iiN9PmWXiY4JwgJEWFSFx8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124166; bh=oTJI9A
    OfopbY9mapVPd0FghdrjUGDqHg0MrY6VuTKLY=; b=i4G9dxfVpcpBnhOEcgfb4U
    y7UZX6pC6x1BkF2oiGjKPIb4jpcWxV5OVIHJjc5vIlUyBC8C8KpCILcaIDQU7Dq/
    OjWrNLNyEUyTAkN5xSXVntG6qd9e3wRyd77fPVSaqsv9BXNaYJMTws67MfzJUxwu
    R6MYvyltwB1o/rUy/FKeFeomH/YTCX8ZnCi58H594TZHlM+vsdxAVcpHjuWWKLfm
    w88bjlOEk367kp7sYPaBD2/YCLnLFshqpyhHYwx2d0ogPmoPb0MHg3/eVVmnw0n6
    AHM67dHGA60EYUG30qLFAFfhc35oirMohcsFQRb64Y8+bV1fEiPZ8v+laFNX1IaA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EGyRtVUH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EGyRtVUH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeCDAm0 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:42:26 -0500
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:14704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932608AbeCCW0O (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 046/102] power: supply: ab8500_charger: Bail
 out in case of error in 'ab8500_charger_init_hw_registers()'
Thread-Topic: [PATCH AUTOSEL for 4.15 046/102] power: supply: ab8500_charger:
 Bail out in case of error in 'ab8500_charger_init_hw_registers()'
Thread-Index: AQHTsz5pZ11//rsx2U+FxTWV3w+lvg==
Date: Sat, 3 Mar 2018 22:24:35 +0000
Message-ID: <20180303222318.26006-46-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:C5nLjb24+btfMBy0jFakIraoyuf4NCAFhw0jC+FjqJpJSNsQOVy85g2c11gwlOOwJPP2bq1kAIedjhjFxXAMHjhWjQC3ysnbPU2sI8WoL6MH2Sh4j9TRU8rQCBflmin8sg43QMpfv57NEWsbBNkYABzHT8jT3Pv5IyHpsj+viyznMYM5RlpUU3kk01Ywqiab3WTDSTDhlIrFrLkmgWDdft+cORd78E4F/MO5KOQ/CBgOwBpCVugF22MRNbRAegNm
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47e53ddd-f095-4c58-d572-08d58155c210
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970595BF7EA0FE4D97C4F41FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(15760500003)(99286004)(2906002)(36756003)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nDp7IYwc6+CfJZl45Fu9GZtxZBtzO6rs7OgVD0GLCewCF9XtrO2jFx+WAtVu99YGpbCSdGEmf8Yb1LooS0KR2FCkwrKHlEPGIz2FeDNG4DsjImkoF28LIIB1M2cltHP4Ymbo8hnHLDUqgBxc/rgrXq6TB+5T6A7ud9E0rkdjqvs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e53ddd-f095-4c58-d572-08d58155c210
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:35.9315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 1cdbe7a0738d..5a76c6d343de 100644
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
