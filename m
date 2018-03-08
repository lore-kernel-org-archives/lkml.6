Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492340-2-15659696681539234447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492340; b=IJyajZkqkk0RKSRZG2j8CpfLglLsQ8BRUpdz0Ib8NelaYRJ
    zsyauUMY9ZGyL1tuSrPBZ8adZEaF0feyoeMWtL54CHFuoYPt/qZcwLFccTsn6wcO
    oG3nBToP8XO9vSmC6iiyDASdAf7m9X/u6h/yVArG+lnku6DifBKxBlQ831JJj0np
    Lo8DNasdhLYCoIbjPFmjHJDp7EJMLmtAQMB4W2N7n42W2+36nzrsGhNIAX9CqPkc
    1FVDAMCgWT/CjwBjU5Cj3yHoDLFfk5QGRM0ADVaUbzwNTd0Y9uU0e/eRQt4F/7Ps
    jgiYhOGfXEWUcFMB+jQ8q1HTA+AiXKHueSz0u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492340; bh=BuGBHe
    60/AA4lZrmGuzd++QNg93LlMhYQOA2ecNEiDg=; b=hdfuGvALONJmc66lLSWrvz
    0OTT6bp4YqZHT3rx9SyHttfujhny3UcXiSpyWsDg0Adk0TE4QYLy2+9TZgYDNJgt
    FGySFnXY2IRSl44j47k0i7Lg2n9/1MNe7F3UA/hZkUjK7YAhlPpnKIE03WptLuoq
    plUlocUEUrxeTBVYmbtbQkbyYcDTqmAXjmDEAxlqEAuLB2vXh3EfQnP7/CK3KMA1
    27boPiB4nEhOpixxzVOLKhYgVhU3eEmJTtMqELwDR9sPaqJaGXFd3cqg2XbOGKPA
    OsO1j0y7KdffqblWUkrUhRvihYrxeVTEuvBZT+HCqsSS3YcbakVLAgK51ZMGnqrw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B995Ci1v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B995Ci1v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965271AbeCHG6V (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:58:21 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934948AbeCHE5Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Zhoujie Wu <zjwu@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 49/78] mmc: sdhci-xenon: wait 5ms after set
 1.8V signal enable
Thread-Topic: [PATCH AUTOSEL for 4.15 49/78] mmc: sdhci-xenon: wait 5ms after
 set 1.8V signal enable
Thread-Index: AQHTtpnO10ZoyF79VEWQGECxfyDmAQ==
Date: Thu, 8 Mar 2018 04:56:23 +0000
Message-ID: <20180308045525.7662-49-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:4cjo2Uzaz9aqGWuU6QeRdXvO8ev37ikU7NuRE71cS6ByZoicJtT5dzyq8hhDFhev8WjazMRV2FoLCYIaBZ8ag4sgSXV0tj46COeAzEDgFvurr1FvSHKMl1t+a62kzObs9p61H/8XhNxzvo31EcxPU0eoIfOtOK4MHY40owv7tJOB6waVkUwsviqJDWc7lzBHRmWV8wll04U2wG6QanMWQiZJJB/fWfSYFEDF95b03N8ZpG9FqEyT/8Vd/9S2HIeZ;20:vFXcFKcFpV14XQN7fWozoK/ERuxs1qdybHWOpFSbgNAmcWdAc7RZLJ4Hj6lKpfLZweiqDB3JbSnwSV01Ko9EbQTLgZmsMLqEo0XWspCofg38lMiHWwnp4OYx+E0Nn0du/flqXRZsJC0SayAH8fUC5kyVfr/J7MN0wlyHZ6ikrg4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f545017-a603-49a5-9b17-08d584b10e2c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1079ADCB5CDD71DC070AB868FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Ky2lmkocO/k9GtIk7mDdv/No5YcYSqpYObqGd2kmtZgK7ayEuEz2npFrwCO6qleTq2/GYeW8joW44daYK6xLw8ISMAYYgLi8W7y4sB9dSmZfmvIleOl2zKuVppDpYJDr1s1RMGF0uIfs4l/sykKLELQ1sFxrXhbgwxfM77gkC3nI9S1w5WDtremuR+zoaEcR/2W+F3eTmto1iOZgEpc9GdGxUTfGh90jl7nhkfC7T9S/ZknfENW8mwROrl+/MO4PGmlkO5YtuSJfe0XHlpEUT9Qyl/CjzriKMQe/qcmX8VbMuc6mkD68R1sy/G2d6ocB9XOyvUDinZulLDhC1qsTQw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f545017-a603-49a5-9b17-08d584b10e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:23.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Zhoujie Wu <zjwu@marvell.com>

[ Upstream commit 8d876bf472dba73c015cea9feea80dcb80626a7c ]

According to SD spec 3.00 3.6.1 signal voltage switch
procedure step 6~8,
(6) Set 1.8V Signal Enable in the Host Control 2 register.
(7) Wait 5ms. 1.8V voltage regulator shall be stable within this period.
(8) If 1.8V Signal Enable is cleared by Host Controller, go to step (12).
Host should wait 5ms after set 1.8V signal enable bit in
Host Control 2 register and check if 1.8V is stable or not.

But current code checks this bit right after set it.
On some platforms with xenon controller found the bit is
cleared right away and host reports "1.8V regulator output
did not became stable" and 5ms delay can help.

Implement voltage_switch callback for xenon controller to add 5ms
delay to make sure the 1.8V signal enable bit is set by controller.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/sdhci-xenon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.=
c
index 0842bbc2d7ad..4d0791f6ec23 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -230,7 +230,14 @@ static void xenon_set_power(struct sdhci_host *host, u=
nsigned char mode,
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 }
=20
+static void xenon_voltage_switch(struct sdhci_host *host)
+{
+	/* Wait for 5ms after set 1.8V signal enable bit */
+	usleep_range(5000, 5500);
+}
+
 static const struct sdhci_ops sdhci_xenon_ops =3D {
+	.voltage_switch		=3D xenon_voltage_switch,
 	.set_clock		=3D sdhci_set_clock,
 	.set_power		=3D xenon_set_power,
 	.set_bus_width		=3D sdhci_set_bus_width,
--=20
2.14.1
