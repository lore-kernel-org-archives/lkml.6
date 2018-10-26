Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE330ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B220834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emutex.onmicrosoft.com header.i=@emutex.onmicrosoft.com header.b="PBlt1IIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7B220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJ0Cwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:52:44 -0400
Received: from mail-eopbgr30093.outbound.protection.outlook.com ([40.107.3.93]:50723
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727706AbeJ0Cwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emutex.onmicrosoft.com; s=selector1-emutex-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU0pFFzZWJnOYPFRuqnc8xFDlI3tjfgfCCkhwrIetoc=;
 b=PBlt1IIS1Tm5iu26nNiMnp0wRs5ShsSwbLkdStv0UbiDan5QYkMMHwvQ5ibVaTJhV6htrEuPbtXPdIcfAg5MF4s8ErNFcfAkpUMaNanXAq8mMS8UZZ9PBvUXRykNoGzZ1XlF1Fiw9bY/yNOrGKmNBfbEatnis8NlW5Rly5Hyq20=
Received: from HE1P190MB0011.EURP190.PROD.OUTLOOK.COM (10.172.129.136) by
 HE1P190MB0156.EURP190.PROD.OUTLOOK.COM (10.172.131.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Fri, 26 Oct 2018 18:14:36 +0000
Received: from HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 ([fe80::8544:bd36:102c:871f]) by HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 ([fe80::8544:bd36:102c:871f%11]) with mapi id 15.20.1273.022; Fri, 26 Oct
 2018 18:14:36 +0000
From:   Carlos Iglesias <carlos.iglesias@emutex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dan O'Donovan <dan.odonovan@emutex.com>,
        Carlos Iglesias <carlos.iglesias@emutex.com>
Subject: [PATCH 1/2] dt-bindings: iio: pressure: Add support for Honeywell HSC
 SPI sensors
Thread-Topic: [PATCH 1/2] dt-bindings: iio: pressure: Add support for
 Honeywell HSC SPI sensors
Thread-Index: AQHUbVfAgajE3MQrBUmbAGy/vZHckw==
Date:   Fri, 26 Oct 2018 18:14:36 +0000
Message-ID: <20181026181406.14545-2-carlos.iglesias@emutex.com>
References: <20181026181406.14545-1-carlos.iglesias@emutex.com>
In-Reply-To: <20181026181406.14545-1-carlos.iglesias@emutex.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To HE1P190MB0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:3:c9::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=carlos.iglesias@emutex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.51.199.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1P190MB0156;6:VXI7lu2ESsn6KmWYhU1teuzabH/wnprdF8awMfIF72dnt4K6hTzhmGCXxTgcakoWfUXdRT/Ko9JlKZ3sVdiKxMcJp51TEMkScnGYhuqcZK950diyXX9jfDd+h2GP0ap54gZclymr06LDzTJwTr1ZlU35SybhPvaGz9T+kEl6+Ll0A9tap1qMZb+fJI54tR7wbRP68+hSUmLxWOFqz7Yp0d9unR5Ulq/Z6Mm6lq7aMap5pXDyh1/xp18Hrzka+yi3c8mTz+Isvhn1IUn0yhR31TGebmh0OkZUy4OaydCE0ZaH0FJQaYgQ86wm0XtRLmvnWLQSkGP2zrkoXl6MEDkbSEM7VRFWo8Ful4Y2k9v85DO7MKkrzzq9aznf6efhs/dZe6DTHlzOUut/o52FflxkH2o4mP+SLOuWo+0/mNB7chJtlNdhSC/rOQEvNH5OGxhKh1HXxKdcMtXP63gGH/sfzw==;5:jYTYwx0SRdTisEhyNXnYNnfHxRGD1KpmxLS2RFVfkBrTxTZy4PxHgItajr76fhbcsSgcGtv23jS00rH1/Tq99q3XC1LAKkFsA1X+nAmatvMgyDq1ZOn78T60Vd97qVN1zyXDllgfxBJZP4MREocIkbq+oxFVw0sdCooUgHSVxhY=;7:pP2Q9QemH0l0H8R9O394CDdR3fSyj6He64r7iQwWWsluWiloDyshA8nY/fPY0aFhRb5lH7pAOtUbgBpkf4Gk5F1EfhUsA5Y+jjBXT3tQMdqg/gvF9m2NMjD2p9Pd6JKzXjxGZLrgorkl3q/DM2ukgA==
x-ms-office365-filtering-correlation-id: 72376783-8bbc-4382-a643-08d63b6ee2d9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1P190MB0156;
x-ms-traffictypediagnostic: HE1P190MB0156:
x-microsoft-antispam-prvs: <HE1P190MB0156FE8FECAC859AD851806480F00@HE1P190MB0156.EURP190.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(20161123555045)(201703061421075)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1P190MB0156;BCL:0;PCL:0;RULEID:;SRVR:HE1P190MB0156;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(199004)(189003)(14454004)(53936002)(106356001)(55236004)(105586002)(71190400001)(99286004)(2900100001)(386003)(71200400001)(6506007)(8676002)(81156014)(110136005)(81166006)(8936002)(54906003)(25786009)(76176011)(52116002)(4326008)(68736007)(97736004)(5660300001)(508600001)(186003)(2501003)(44832011)(66066001)(6486002)(6436002)(26005)(217873002)(2616005)(11346002)(256004)(2906002)(5250100002)(102836004)(486006)(476003)(446003)(6116002)(3846002)(86362001)(305945005)(7736002)(36756003)(107886003)(1076002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1P190MB0156;H:HE1P190MB0011.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: emutex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tHmaUHxToexsAv9EWWAk+a3wi+CeS0cp0giaEu1IRqjR/WJxIVjkqW3GJtV+P174hjAzenPnugNlP5S8nHSzxMAQWDonZ1Djdcw7pujJBIG+Bd3kUYuR63+ynky/FeBlNSiU27ZrlnJKE2CPeNZJM05qc2LwBrjYenA1KUx6hErYY35mVdGrQh5XEaj5ywgzqaY7k0Tn3utIE5v/givA6i9ozkUx5gSYbE307Fsg9//cNgMotpUFzdGLxAijlXfoo1hZv4iZ2VN+BNN3SzRYTGau8xTsU1Ortn+itl3JtxExx0FuldmsZpT7EXmZlxBDSEJPJfci+k5r8wdcZ+LPv0f9Idoay9hbQC/U4eKf1MM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: emutex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72376783-8bbc-4382-a643-08d63b6ee2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 18:14:36.1883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84cc844b-5c53-4da1-99da-34ef4089ea8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the HSC pressure sensors.

Signed-off-by: Carlos Iglesias <carlos.iglesias@emutex.com>
---
 .../bindings/iio/pressure/hsc_spi.txt         | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/hsc_spi.=
txt

diff --git a/Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt b/D=
ocumentation/devicetree/bindings/iio/pressure/hsc_spi.txt
new file mode 100644
index 000000000000..2302d6eef7c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/hsc_spi.txt
@@ -0,0 +1,85 @@
+Honeywell HSC Series of Pressure Sensors
+
+Pressure sensors from Honeywell with analog, I2C and SPI interfaces
+
+Required properties:
+- compatible: selects the sensor model; must be one of the following
+	"honeywell,hsc001baa"
+	"honeywell,hsc001bab"
+	"honeywell,hsc001bac"
+	"honeywell,hsc001baf"
+	"honeywell,hsc1_6baa"
+	"honeywell,hsc1_6bab"
+	"honeywell,hsc1_6bac"
+	"honeywell,hsc1_6baf"
+	"honeywell,hsc2_5baa"
+	"honeywell,hsc2_5bab"
+	"honeywell,hsc2_5bac"
+	"honeywell,hsc2_5baf"
+	"honeywell,hsc004baa"
+	"honeywell,hsc004bab"
+	"honeywell,hsc004bac"
+	"honeywell,hsc004baf"
+	"honeywell,hsc006baa"
+	"honeywell,hsc006bab"
+	"honeywell,hsc006bac"
+	"honeywell,hsc006baf"
+	"honeywell,hsc010baa"
+	"honeywell,hsc010bab"
+	"honeywell,hsc010bac"
+	"honeywell,hsc010baf"
+	"honeywell,hsc100kaa"
+	"honeywell,hsc100kab"
+	"honeywell,hsc100kac"
+	"honeywell,hsc100kaf"
+	"honeywell,hsc160kaa"
+	"honeywell,hsc160kab"
+	"honeywell,hsc160kac"
+	"honeywell,hsc160kaf"
+	"honeywell,hsc250kaa"
+	"honeywell,hsc250kab"
+	"honeywell,hsc250kac"
+	"honeywell,hsc250kaf"
+	"honeywell,hsc400kaa"
+	"honeywell,hsc400kab"
+	"honeywell,hsc400kac"
+	"honeywell,hsc400kaf"
+	"honeywell,hsc600kaa"
+	"honeywell,hsc600kab"
+	"honeywell,hsc600kac"
+	"honeywell,hsc600kaf"
+	"honeywell,hsc001gaa"
+	"honeywell,hsc001gab"
+	"honeywell,hsc001gac"
+	"honeywell,hsc001gaf"
+	"honeywell,hsc015paa"
+	"honeywell,hsc015pab"
+	"honeywell,hsc015pac"
+	"honeywell,hsc015paf"
+	"honeywell,hsc030paa"
+	"honeywell,hsc030pab"
+	"honeywell,hsc030pac"
+	"honeywell,hsc030paf"
+	"honeywell,hsc060paa"
+	"honeywell,hsc060pab"
+	"honeywell,hsc060pac"
+	"honeywell,hsc060paf"
+	"honeywell,hsc100paa"
+	"honeywell,hsc100pab"
+	"honeywell,hsc100pac"
+	"honeywell,hsc100paf"
+	"honeywell,hsc150paa"
+	"honeywell,hsc150pab"
+	"honeywell,hsc150pac"
+	"honeywell,hsc150paf"
+- reg: the SPI chip select number used by the sensor.
+- spi-max-frequency: maximum clock frequency (Hz) used for the SPI bus.
+  The maximum value supported by the sensors is 400000.
+
+Example:
+
+	hsc_spi0: hsc@0 {
+		compatible =3D "honeywell,hsc010baa";
+		reg =3D <0>;
+		spi-max-frequency =3D <400000>;
+	};
--=20
2.19.1

