Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482680-2-9579683643157962033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482679; b=WkM7UaRMtrJQdMdSZdXU9DyQa8+gbKS9g96nl/8S3yhKk75
    yPK/4ZmSTqNwFWnwGH+Y4BK7dn/4I3+1w+KRWl92zMibSfSTzeW2wTdneRa70/NC
    +FumJDSZvC5zspHbrlufaF0rOoUAHdOOitlq+oSPoGQDPvtc69GTafjGg4xVk7n7
    3oEZgysYp+AGM6pcm0YpHh9gScrBxUePIF6Uo8SWMx/VQoxS7Ns+TLR4s+6lbOYe
    WrBUunn/3Pi22ZthdpNuvnUaxe9Fd7h1UY4C7CBaxHf82Kd8vWTmrUs5mOcKMHiU
    8CDOEtU+touCk0IK5aeORMi1G+rL4KK7W0XpLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482679; bh=uQTqFO
    18fmV4cReEcdDyAxwEdObjBJUdqOiAA0YIaXY=; b=NMIdt1FX8l1x4dt4m7REZS
    2QtOw9HYg1Mdxn/EBy3gsLXTaDle5NfdSdJcAm2J0gbnSXFABJ7qsq/GbhIPdTGN
    8Tv4V57I4ts9BE76Y3GBDkRCaWabYqELuI3qtaeUFC/YmkgNGeQV3FOV7V1GI0oR
    9LHFtH2Pa5AHlaBSU6jQtggrJM1S5cYhCJhuEzEPVtDw79iaEaBZS2mWkox/h9tI
    Ehadv6tI5jAmrso8WNqBFtP6H7j1UyWoliE1ZeqLhQWksquZvI06C+Xqi06vMLe4
    qUcBYHTo3ZwWV74MR6NAxnOvPI0jJ/EPxjPqLMevr7vFHINGkoYPNMBSGORPtm7w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZD5Zv2Kz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelvdelkeenucevlhhushhtvghrufhiiigvpeektd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZD5Zv2Kz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelvdelkeenucevlhhushhtvghrufhiiigvpeektd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935046AbeCSQDw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:52 -0400
Received: from mail-co1nam03on0096.outbound.protection.outlook.com ([104.47.40.96]:50816
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932923AbeCSQDs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anilkumar Kolli <akolli@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 181/281] ath10k: add BMI parameters to fix
 calibration from DT/pre-cal
Thread-Topic: [PATCH AUTOSEL for 4.9 181/281] ath10k: add BMI parameters to
 fix calibration from DT/pre-cal
Thread-Index: AQHTv5uJbJXgoLg6HkS6zg+EsPjkpw==
Date: Mon, 19 Mar 2018 16:01:27 +0000
Message-ID: <20180319155742.13731-181-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:jUoDPAxM9oniyaXXj0PLdcZIaFxyOruhB1fU425oTxr9U5aeuix4mN4brmWPODpAvCj8UEtvSOc4EymDEDN3vhBEkZpmKMQ7zicQvKEdVBJi2MIgGqb/Q3TV9/ZM+tffSLGbO+L0khPA8GW3oJQTpJyMtpDIwrhJpGC27x0n6+wYdBfSjL/Ko40ioo7oLZ9pEsT4qH5MzKrBY4RzT9GGEnKh4I+0nUb8uHDPuK3KHRUDivF+oX6XN6VApa7/eq75;20:iVjwbPHKtFGUofHgZRVMQqnN2r4C6TLNExVVbss0wLguACMdDVGr4KCU0JeTIKY30kJCtthWJqWC7rfjQuP/TH9YtffNQN/OeGz8oSLRIWfkht4+6Ahgsi8fOqZyM5U/G/JFGqvI22WKS2xjxEpKrl01ipZjOovIAG59JOv3EGI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ba3556f-b844-4bf8-ae57-08d58db2ff42
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10941B7AC440CC1DDB4CD5FDFBD40@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(105586002)(8936002)(6486002)(3846002)(6116002)(3660700001)(86612001)(68736007)(7736002)(316002)(1076002)(305945005)(36756003)(6436002)(2501003)(14454004)(99286004)(76176011)(4326008)(5250100002)(86362001)(575784001)(81156014)(81166006)(25786009)(8676002)(6666003)(54906003)(2906002)(10090500001)(186003)(2900100001)(2950100002)(10290500003)(106356001)(3280700002)(110136005)(22452003)(478600001)(102836004)(53936002)(6506007)(6512007)(5660300001)(26005)(97736004)(66066001)(107886003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Vx7qXVWccMhtO8k2nTT9KPAiso2RHeS474qPzbcKo/pVWX2PbQRmQfv3sU7Kcp/RRnhXuzqu6JFwg1Fp2UD1buGT+2S5tH6aAMXOijN0KQsdu2Q2BausqbSALs1UyOCGH8budVepscNVM1jXmKBJV46rNey49Ikn1VZYZ+L4tUZTqaBMruGKOG0wHYi7hx2+Y/QCaY15Na8iejURt4yjNqOx9JxeIVOi84wxumvyrmUwiNZxqqnShtBV7BqNwQtN9e20Poc544Oab/MhWDPZc/WI4uizeHxKBYZJO0VyY/yMZgZhm7lN23IifLCM6Q1Krz7KCHRldIfKKp7vqXecMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba3556f-b844-4bf8-ae57-08d58db2ff42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:27.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anilkumar Kolli <akolli@qti.qualcomm.com>

[ Upstream commit a9f5f287fa1d47d61dfa8b60f94831174b2ea4d0 ]

QCA99X0, QCA9888, QCA9984 supports calibration data in
either OTP or DT/pre-cal file. Current ath10k supports
Calibration data from OTP only.

If caldata is loaded from DT/pre-cal file, fetching board id
and applying calibration parameters like tx power gets failed.

error log:
[   15.733663] ath10k_pci 0000:01:00.0: failed to fetch board file: -2
[   15.741474] ath10k_pci 0000:01:00.0: could not probe fw (-2)

This patch adds calibration data support from DT/pre-cal
file.  Below parameters are used to get board id and
applying calibration parameters from cal data.

		EEPROM[OTP]	FLASH[DT/pre-cal file]
Cal param	0x700		0x10000
Board id	0x10		0x8000

Tested on QCA9888 with pre-cal file.

Signed-off-by: Anilkumar Kolli <akolli@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/bmi.h  |  2 ++
 drivers/net/wireless/ath/ath10k/core.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/bmi.h b/drivers/net/wireless/a=
th/ath10k/bmi.h
index 7d3231acfb24..82bdec744055 100644
--- a/drivers/net/wireless/ath/ath10k/bmi.h
+++ b/drivers/net/wireless/ath/ath10k/bmi.h
@@ -83,6 +83,8 @@ enum bmi_cmd_id {
 #define BMI_NVRAM_SEG_NAME_SZ 16
=20
 #define BMI_PARAM_GET_EEPROM_BOARD_ID 0x10
+#define BMI_PARAM_GET_FLASH_BOARD_ID 0x8000
+#define BMI_PARAM_FLASH_SECTION_ALL 0x10000
=20
 #define ATH10K_BMI_BOARD_ID_FROM_OTP_MASK   0x7c00
 #define ATH10K_BMI_BOARD_ID_FROM_OTP_LSB    10
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/=
ath/ath10k/core.c
index 7b3017f55e3d..65ad7a130ca1 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -652,7 +652,7 @@ static int ath10k_core_get_board_id_from_otp(struct ath=
10k *ar)
 {
 	u32 result, address;
 	u8 board_id, chip_id;
-	int ret;
+	int ret, bmi_board_id_param;
=20
 	address =3D ar->hw_params.patch_load_addr;
=20
@@ -676,8 +676,13 @@ static int ath10k_core_get_board_id_from_otp(struct at=
h10k *ar)
 		return ret;
 	}
=20
-	ret =3D ath10k_bmi_execute(ar, address, BMI_PARAM_GET_EEPROM_BOARD_ID,
-				 &result);
+	if (ar->cal_mode =3D=3D ATH10K_PRE_CAL_MODE_DT ||
+	    ar->cal_mode =3D=3D ATH10K_PRE_CAL_MODE_FILE)
+		bmi_board_id_param =3D BMI_PARAM_GET_FLASH_BOARD_ID;
+	else
+		bmi_board_id_param =3D BMI_PARAM_GET_EEPROM_BOARD_ID;
+
+	ret =3D ath10k_bmi_execute(ar, address, bmi_board_id_param, &result);
 	if (ret) {
 		ath10k_err(ar, "could not execute otp for board id check: %d\n",
 			   ret);
@@ -739,6 +744,11 @@ static int ath10k_download_and_run_otp(struct ath10k *=
ar)
 		return ret;
 	}
=20
+	/* As of now pre-cal is valid for 10_4 variants */
+	if (ar->cal_mode =3D=3D ATH10K_PRE_CAL_MODE_DT ||
+	    ar->cal_mode =3D=3D ATH10K_PRE_CAL_MODE_FILE)
+		bmi_otp_exe_param =3D BMI_PARAM_FLASH_SECTION_ALL;
+
 	ret =3D ath10k_bmi_execute(ar, address, bmi_otp_exe_param, &result);
 	if (ret) {
 		ath10k_err(ar, "could not execute otp (%d)\n", ret);
--=20
2.14.1
