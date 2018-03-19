Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474869-2-1107601513864856431
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
    t=1521474868; b=ovKFWmnZU5mNdZNEda+itoKfhBNBsw2UVLxR7T1bdBy9BMU
    n2l7MBYXT3SXG6pDH7z1YJqzeKHgK/fx/rnq7kgi/i5bczJ9ACOfuVWhTwJbLWj7
    ATNvhW7JdBQlJ7XDRHEEa9CC4O/D7N1UGOlwuDU9q1czEjv8KPKvwkM9jY0sZ+M3
    lOCPo3PRwz8qbRpJSdxV0mmig7CZll5iQuw27r10+VXuGb2aMTXA+a7FVsQGLYDf
    rv0CPPSdbzQihPO8SIGWZ9XL4SyPq60ZXZ8PqarsobdKcKkCBnF4iVH/pYoudMHd
    6wsqaa0m/E7vjSa8nFnEwr7GMMoOrP/1PsR5F4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474868; bh=BrLlYt
    XOMcWYd4E0X4uqmbyIz90cmvoYledCMBRlJa0=; b=oCmnwCxhL0MQXD4kcC21/4
    7vF2A3UoGkz/xGHk9bziUngBHa9H5EqvBahA5ngIOgJ3v6VYqYU+cH8N82Ux2Za1
    K591WmPUfPXbGO6cFxDs7BCG1rTGn0/lAa7gnSejppU3zVgCcWgibJ2NGJlELNYU
    +biB84qNQX2B0g9GAznV1QruIpCAXkVVNoQv6McgpGolNBsR7yZFqaInaB9q9IXd
    IgDXdLwY+9UKFTWS6nA31lDOtewBX2z9ljXDoT8ivLawj9bWmF42dcTy5dcAWHpw
    yEDDEqM9pTnCa7hvGzBskpHv6NNRfRUGZHqZEle2SB5cUMox417YFQ4CEDPVrepw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I41VxjmZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvjeefnecuvehluhhsthgvrhfuihiivgepgeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I41VxjmZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvjeefnecuvehluhhsthgvrhfuihiivgepgeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934022AbeCSPyX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:54:23 -0400
Received: from mail-bl2nam02on0123.outbound.protection.outlook.com ([104.47.38.123]:41056
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934047AbeCSPuH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 111/124] sdhci: Advertise 2.0v supply on SDIO
 host controller
Thread-Topic: [PATCH AUTOSEL for 4.15 111/124] sdhci: Advertise 2.0v supply on
 SDIO host controller
Thread-Index: AQHTv5nP3B10rPwBckmns8pOprJYAg==
Date: Mon, 19 Mar 2018 15:49:05 +0000
Message-ID: <20180319154645.11350-111-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:fEHhl+F4tWsyJlDOd+p/B7ZZKx7seg7CUPEDjEpM4QGX7cZ48bukvpq9WRtpzHViuDOMuDB8bVzGB/awkoiXLMv5QvRExpvdn/UwmixIto0LYB0q3ydiQm7K2EMHbIav3mrweepcvLceHwlCVToB/abgeLUn9rr8bLA78qeUMfULkgO3idMlYVBd720lg6EOPKUTJlW0v4J2XvrEUuNrYP4ZP2d8Smmx3DP+q13ZaOixBro8+b5lqINtpuNV9Oo/;20:sjX16C1fMBEB3LYpwG0eLQ/7d+kkOI9s/aJxLv1ParzWQ5HUhk8fLM3yVkvT0+IhAcOeQA4COw1F0hJqsOvpfpXjKaqKeK6hrXaouhWVh+/QcA+cJ5MAxpB2B7b2gPIjh0AFYF6bqfZ/YvCxy1hgAnNERUXz+U2ZmihoiI6XRcw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed542f3a-5cab-4c91-e30c-08d58db11181
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109093832AB5765DAC1BB68FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(575784001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: J/ddDjkSZCtsA4MYCVXajGjg3iZDA5ErcHl1yN8QWDmLUyGH8sfbmIrWxFaU9jEeBTlDQck3P2xvjTe9LdWJszg3A536KTFivPOeuB0DR8Wrn48VcYu30mVxDOkiMH4CA1bmKj9w6//kxubI+k0FKy5dlyOUnwA1QAYx5yhGihGCmEcmr7MM8oyU9rlVVsZEjAW/lMqtXvLxVjFCDWknQQk0uqNG5XiBBkqWGWlYJnUcBSQrruYnCZgO54Ye/QwwQv642OCztoI1HOP1rMl84cpXzSmMlF8S1AlEZGCYPHoi2GCzSMwcQ1x+rbTGrQdrXf83mLrA1sJjHw2nH3c25w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed542f3a-5cab-4c91-e30c-08d58db11181
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:05.3584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index bf93e8b0b191..b8fa17a759dd 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -805,6 +805,8 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_=
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
index d24306b2b839..3a5f305fd442 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1470,6 +1470,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, =
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
