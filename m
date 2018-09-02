Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5865C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835ED205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g8WDYxAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835ED205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeIBRaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:14 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728318AbeIBRaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p4tymV4mJ/EfPGfzKKlBYKcPAZUko5iMBu/KrNXMUc=;
 b=g8WDYxAieyGaijyTSGCtdB+5VpRSlnW8aVjrpjzSJETqKIeHBYNY+f40SG2mUmMKAL4lBr2dYS1212oLRYxDzkTy7xyZWK/RS1lC+pImdCTSEMHmytlXUfawpP96IX8WOPm8pwpcbmFuUk02LdGVFX7CeHVIaPZNjtHPJHfxv8s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 18/62] ath9k: report tx status on EOSP
Thread-Topic: [PATCH AUTOSEL 4.9 18/62] ath9k: report tx status on EOSP
Thread-Index: AQHUQr7elL++3vDbnUmhmYdB1xl/3Q==
Date:   Sun, 2 Sep 2018 13:14:23 +0000
Message-ID: <20180902131411.183978-8-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:QC6qfo/ruq6CaZaeZg9RZZt4q1LMu4NQ/TXAhX465mBARpp7Xn//Xt6dJjHPdHOGfSEobl9nGTcFdVMcj6wGPvQHvQboJ1DNm/EFDlT7VpkKCV3ORpB0ExegwpvCV0+UnTZlrVEaTC4ZHUnQTE3YiqwmCabklUOMIGa1ntATuLAze9Ij2k7wF79/CMQncBkFTqwB7NanYHgAf1HOxRT/G4iEVa2uoM5XKBgM8SO9VVR6rQhRs1dl9gTL9Twegg7L4xuJXP/WYoWNLgLHhKd4LBxUqNCudB5dCMnRkeM2mvLC+MkkUSodwoQQRNYCebxxwytkymUSt56mUCX/eF10c/NJldUEhACPU3Aha2tOdl+Mtwg+6mfsgEF43+2FKawYMpPjYOde8q2ptQb2fDIwxYcJRXBQRemSSDZQG46DOVs4oAyt+WzloMPp7zSrc8/+fMQPrDjA4UyY1QGJvytjRw==;5:8OTQKsi9S0W/8DPiIzamk52uDI6lNCxSX8YzcHAbMfihxP1eiW+dZZwtsYORF7ubx/E5Z2dhN3kfigvuwEJWbSmFtym3C+ITY23vTOdmeswD5tYDnkWovTTdlKSiwlJeYJTQ2tSPqRL/zRSOjrswjY+ElkUOP1cjagsxjBke0IM=;7:yOOJU/QVQFGcDK80OiUWPtBHFC4mvzVK6/RwYNuSLh5+kfc9dBQW9QgQxo/Wx7hr0la7mDy50u2ViocDR9WEuIk1dcxyYGd3J53HViOnUwiT2CBeHjTDanDV00XMAKJSGLuw9jg4oIMRhHdezDpXtDH1Bz9CF5g8NRP0AZ5GLE2sDqv3K8gJo4gf5KV3Cz775juZ5QM/L1DFQ67s9o6rLKLxLmj2ZEVkQ7uRq0zWOxAwnoIVp+Iop2pcESRKzbNf
x-ms-office365-filtering-correlation-id: 40189cc2-3735-4ff2-9bb1-08d610d6009a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120BCF061FD9989CD4A8449FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(575784001)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G0Sl324cgVzvp8/v2dCO2cjzRVdPnoN4l4STzu1QKYr97+utalcGyLEZLCWIhGNlKGWy6TaB4xQgIah7M9uV0PKbR4/RyAse5r0uiVcPukS5JNh67i2ZooSwztOjJ6690c9M92CB9J59y+1s01XQoFa9K19L35gXjxCnHUTiAAb74zuek7JsslOA2pghZwl4SIotZhorsMrSw3toTJ2L26elkOf1dIsm6SYN/cdJg0tylReedYg7Ef088xVPdGG/0zmVjycF5LgWcuM8TTgjmUAlT5LnUAqyn3GucBmopJJG8RgT5uAq689iLmCL9vWpid2/ibMnZtaTl+XKPmk2Y1fukvM2L3fRF/cLrQb+Nww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40189cc2-3735-4ff2-9bb1-08d610d6009a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:23.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 36e14a787dd0b459760de3622e9709edb745a6af ]

Fixes missed indications of end of U-APSD service period to mac80211

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/a=
th/ath9k/xmit.c
index e47286bf378e..8a504afe667e 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -84,7 +84,8 @@ static void ath_tx_status(struct ieee80211_hw *hw, struct=
 sk_buff *skb)
 	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
 	struct ieee80211_sta *sta =3D info->status.status_driver_data[0];
=20
-	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+	if (info->flags & (IEEE80211_TX_CTL_REQ_TX_STATUS |
+			   IEEE80211_TX_STATUS_EOSP)) {
 		ieee80211_tx_status(hw, skb);
 		return;
 	}
--=20
2.17.1
