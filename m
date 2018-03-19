Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481186-2-9948481745537163945
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
    t=1521481186; b=neQw+4lZr00sBwPzEQ/1ZpE9L+S41vSVwhSE4y8GI10BtgI
    tg4Iu2AFBbZgbHTgyVYgKsmBDkLpji+ExnQApUVrZ09EKQULgpQUMOTiNh8AlQ1c
    p+ox6Ehck+sMFwLCjiRsyAOEoT6+IZmmeYUKVciLBAwIRmv1hbiIL53lZF+yPEIj
    fQClE7sFHO7tsBAO9iwyexQfu5Cp5Sx4OqkSgsPz3pUUKco1oJxjYdo2DEelXJGk
    HMOtQe+MrvEQ5LfwqPJjbBGYRnqSUofi3jIarAJJPkBWq/i7BU047X6jlj7njAcx
    jRC1D54XeZoUlp0rdVH1mh9Z7fAagzfYr80Gs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481186; bh=6h8u4/
    SCtkN8ilwxtJsVq0XGqm/G4D8TuFEEwbXSt4g=; b=k2r6Imot0soUh022Nu9ged
    K48pR6k7uslNa4xTzOcOFAYqVJ2mnKVACIj1E6eS+i6LvrwO2irIOS8e3ry0lMoM
    JsJBKuF3x8wk4RHQIemfVF1aWOhvyj2eOBWOH9XJMaVshDRsikWZ+BNFz+RPYc12
    NxVbCNMz/gSv06PM67vecEvCkCfQCGOVLFKzI3O4m1R08ja6jS7hdSkljuEJcFpV
    dQFFAD31tpbdtPfznVRZAjZfTHaoKaywuBzV4P7tlS0TZHHmWjDWwLzx15/sjP+w
    YSS3i9K5Z1RJIvbRaUWD6O0xMBO0dmfQ0DFI3f5uKF8F+eMNuu64A24pk8nVtEaw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UGg7iP9m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdejvdenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UGg7iP9m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdejvdenucevlhhushhtvghrufhiiigvpedvje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965956AbeCSQGj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:06:39 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:13968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965952AbeCSQGg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 273/281] sdhci: Advertise 2.0v supply on SDIO
 host controller
Thread-Topic: [PATCH AUTOSEL for 4.9 273/281] sdhci: Advertise 2.0v supply on
 SDIO host controller
Thread-Index: AQHTv5vMfNdjPUXhhkunhDvZDz7qXg==
Date: Mon, 19 Mar 2018 16:03:18 +0000
Message-ID: <20180319155742.13731-273-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:asKTcok4QWlJKrKfGdCQt+etWPEZwAi84+Uw2xO8loTFFTi3GN1fQ/uaHd+3mfuatfiLxFB+DhkfXzeb7QcD+86u7KWw4IGjVL+Dkjl6tW5wh40ojFLcrq1Mb6875g8PpyIGWbHRTPYGn+DESrHh6ErToXXmAfyQI33yJ+Mcvc0m5hDaz16sT3aIa6PZttauDVapc9NiHCwDvCaVfNmO5EWrojYIi4WCFfwnQYuIt0MYHLm3RPSn6KVc7lMf6NHc;20:Bh4cacwnPYbCz0HmQitIuLHaJf0VreVSMEPUp6EulBvo5jvdtY9s7mzYELgJTRZornQn37M4elUIPWxNlcJC78xNOmK98wo2lEh/VyXtphz6fywZfnwI7fLHibkLoeM+vTvtZ0OfyzlYXkX9Wly6Qj/PNGo1Rs/NHExBhqXmzv4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2a83cb9-a932-4801-a7eb-08d58db3629c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0728C295456C17BC3DA391EDFBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(575784001)(478600001)(53936002)(107886003)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(106356001)(3846002)(22452003)(3660700001)(186003)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NAv5al+8GMClLm+B0UrZcA+1LbUriPdtaKeLTHSzxaObB2Dn31zBGf2xIqMJMYbClxW2V1CsAlS4O9B3/bwUCqBzwEwwposyftAyw6WeiHS2qPyGaWEEXR/rF9G/GfWkp0BZfQVmjV1mPhCAkYjF89m1+ITaQekc85/NdK+QhTQjiLeF8c/NvaMlvXrtcalgI7mBBXTGy/dRlg06/7LjC5J/E2RhX+wyMEWwwJAVlLPiOhcQ7DHNKpJ105ay8RaLMWKJYRDJ9d6zk7krt6f+BhBXCk2dXOMbzAIdUsSHciUu+hTGdddoRuy/4gF+8Xylswwt1k1sH5RzqhfrgDY3XQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a83cb9-a932-4801-a7eb-08d58db3629c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:18.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 2a609abe71ca59e4bd7139e161eaca2144ae6f2e ]

On Intel Edison the Broadcom Wi-Fi card, which is connected to SDIO,
requires 2.0v, while the host, according to Intel Merrifield TRM,
supports 1.8v supply only.

The card announces itself as

  mmc2: new ultra high speed DDR50 SDIO card at address 0001

Introduce a custom OCR mask for SDIO host controller on Intel Merrifield
and add a special case to sdhci_set_power_noreg() to override 2.0v supply
by enforcing 1.8v power choice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 ++
 drivers/mmc/host/sdhci.c          | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci=
-core.c
index b0b9ceb0ab01..cfb794766fea 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -492,6 +492,8 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_=
slot *slot)
 		slot->host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
 		break;
 	case INTEL_MRFLD_SDIO:
+		/* Advertise 2.0v for compatibility with the SDIO card's OCR */
+		slot->host->ocr_mask =3D MMC_VDD_20_21 | MMC_VDD_165_195;
 		slot->host->mmc->caps |=3D MMC_CAP_NONREMOVABLE |
 					 MMC_CAP_POWER_OFF_CARD;
 		break;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7d275e72903a..44ea9d88651f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1404,6 +1404,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, =
unsigned char mode,
 	if (mode !=3D MMC_POWER_OFF) {
 		switch (1 << vdd) {
 		case MMC_VDD_165_195:
+		/*
+		 * Without a regulator, SDHCI does not support 2.0v
+		 * so we only get here if the driver deliberately
+		 * added the 2.0v range to ocr_avail. Map it to 1.8v
+		 * for the purpose of turning on the power.
+		 */
+		case MMC_VDD_20_21:
 			pwr =3D SDHCI_POWER_180;
 			break;
 		case MMC_VDD_29_30:
--=20
2.14.1
