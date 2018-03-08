Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491389-2-6296277946914261354
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
    t=1520491389; b=PUXSt4HzTXkRMKm9rgMQtU/DyEqvNicjMheQEEpHGnhBNv+
    6WLEEPWVmlyEWfShk3T9Lg3YXhYipz6Rl+DPt2++S9/QvJ9lgM7o7de8CpBusNzg
    HYCFXtL2PzA1kS7IuqG4Rb1azMIG6yIlEfMVTLqirsNTNYHxcSyDoaeERyd/N/BB
    7AlLxDQbXL8JccNhHvyO2LHK43Nwt+7GXar1gcet+dbiO8E7M2Bg7KrRACJs1kn7
    lm8H4o+pXYsiVJGsEfDE5dTfk6tbO4//voKVADKnnlMPgCPOTnvR6Sd1THx5MNSw
    mBK0mv3HgP1bdTDjuxS3XZ0xKYXEc1ymu0DbrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491389; bh=BuGBHe
    60/AA4lZrmGuzd++QNg93LlMhYQOA2ecNEiDg=; b=OpoSHW576ePEpKKSXDAPo3
    3wKGt3j70FzwuY7LbIGjC/CF6QmvON7/G/+hwfk/txiwhlLgxNL0qdG30P8UYLrS
    bPXlkNq0fYTO+BA7Xea/DBMo4hcLNouTVsccqPQlSudAzS+UMCZDIODH+svY//XL
    pC9AUaxicFkmsa8o0tNerY+D1AsMnaNoCQtqKcDzqo6XIN9XInCNaYkDprB3AmxB
    ns1gGHZUgxlWP+HMYZjiswl/IoFCT96MGf9Q7HI3gAXRbOs2HEQaWX4/hWeI8jIN
    P/B+gdYVPu14WMLU8cFYl/184lJE7E2iI9T9vXKEoepk/sjP6EW0gnnO7FgWhafw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l0pC1Fh3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l0pC1Fh3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeCHGmZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:42:25 -0500
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:61147
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965250AbeCHE7B (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Zhoujie Wu <zjwu@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 42/67] mmc: sdhci-xenon: wait 5ms after set
 1.8V signal enable
Thread-Topic: [PATCH AUTOSEL for 4.14 42/67] mmc: sdhci-xenon: wait 5ms after
 set 1.8V signal enable
Thread-Index: AQHTtpoBLFaJQNRJE0m/8n+cOIbtTg==
Date: Thu, 8 Mar 2018 04:57:49 +0000
Message-ID: <20180308045641.7814-42-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:k0gADKSyTj/k9XMHAuD5G1vsPVTIiBZATuN3FEJ9XI3udyyPJ42OR4Pm64xatFh3E0DLrC0CbHLcgGlujHavrGSkZWMM9i6bjy0nawWW3CA0hxoIHXzAFvthgzoMLY2FVmCRP5EutJijHJB2W/I9gw7hJx0ql3f467+vNVDDzEUxNBYEtxfjMlIsabztULrus0x2OOYHWonSNtFL0Pzxx2U4z7AbYWQpv/yToIdePzqvugaJ0IHGQoCsrDIGBdJK;20:d1zQoxBZP8cpiSpiP3ZBsC09SXQyMmXr7o11zXbdaRP18C7d+Hj/zX5SHuKXVllfDhnysG3mpUNSzGu+OtQ/QDd95o0Ayps2CP2NLfhCLWm3YGXsMeOY/UQwkIMic4/Dfu++RIxgT7+O6kOCVa063/Tu7Od1pIRCAn3wRFKSWoQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5366cab9-3560-4ef7-901b-08d584b14d9b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015D90FF27711536D5F53DFFBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3oXAtk3Jz/1NeEiWvadEJgZOdgLZ96D1HtMBNUcnAu5rzGc293Md6TSljLyMUi13fEiUAkrl4EekmarhbLecWVytCftpRLlBm7JsiKeP+D7IcYtHIEumlQOlYHT7wXkJWOKH17QNqI3n/iIxNGC5YJwoxW2BDkQzIV2hV9uRN+B+xOv52CNOk7SLFfsywUL1DZhhLSPQ/gebo2DEi+g9nyYSSvQkpBCbPTe2J5XO8WTveUl4axaHK4ANLqjNPDQ5x4xg28TXSuY1mVPp896PJ0UalisA9s3p3u7bmy6G2A1nAtZBtzOdesM2EGhjjLLiZzLRMxbeXp1WAw0zHm2V+g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5366cab9-3560-4ef7-901b-08d584b14d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:49.8946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
