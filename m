Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987EFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413CC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PJgtRLD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413CC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbeIXVOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:14:53 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730417AbeIXUuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTFvfuix4yPAxlx93+eKoQMsMDsZA6/2TzT5wWOdS/M=;
 b=PJgtRLD93UL6n79UI+YrZQvsbqyRZZeIOrV0HE8urxhyOqzm8NZn8FhDYS+U7a3XBAG+Do9FprFkZoiZsaROmBacS4beX4Ix+acM7W+jDNp6IWonV2G8xs9ZgxA6t6YbYWxUID8PFJOnyvtv2HDWlCSnrHWSeLtc+ecUHMOawQI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 15/76] mac80211_hwsim: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Topic: [PATCH AUTOSEL 4.18 15/76] mac80211_hwsim: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Index: AQHUVBWcLpkItvdqWkeYaKOCIJqHuA==
Date:   Mon, 24 Sep 2018 14:48:08 +0000
Message-ID: <20180924144751.164410-15-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:LX1s9N+L5e6M3XAbJUY8B5dYBnarmnweT8/49zZn8Hwq9WtgOiElDficDAgHYw/1m5iQk19P1TtOgzQccBuN2s7Ki7gslNfMKQL9dlL8iLMkG1bcLnvDvhhQEl2yeMrTQQBog1JPPfSf6EF5k6vl+3rRCHaGrRp1hgQ11Ujiq6SHcBeHVkVKsTPPPgxfwuCSLzcU6fhK3nty32AZOAVr3nUDq7UKgofzQ8QPHA0TnsIyXY/dN68h035/HCdNG2xtdeou7uP4XAQgSkcOYFn8jb/Z2enTYxWr76U9F4GfxmuLur6kTm+TF9Jm5t1rNIx1yHI+w4yzqpahUmltKnPMe7NN44Dw2l3uVjF4xDbyt7NLaNEqXVChhXl5XpKVle+uCkSWxalJ0Fe8UUB8+ivA6nB+Wxe99KQRawWwwk5tEFlu1RnT4jS00RhzUr84ZdogbnH2u3rGkzc7cDy+dkOJ+g==;5:WE5EhyVIMbDZBnQz0mIDBiS46U0l7zjQmApJ67n/aEi45ps85Zyvd9/wV1MIcArdy8j8p8iOE5vwDPEsuKyLaxZoQ+3wFZOOyw0k8wWS5P3jt6bzYuP/+jb8lxi4kE9bPY1jmkvbc7+UUE7U9SQE+2OdyJkLYpf7Ru5mQsp1H34=;7:r7AQIW2vAj80uOc+m+xgotX3fHWn7eQHoZRYJHhWoRIgeGDy2UMIHam5su3Ftj96RkCdRivS9iqm1c75bB3kWC3/zBvc5Qsz23KkNGWdb6211Mue3liH+jX9KXJUS202wWkOiZUGbb7ibuRBi0SRx7cr/aSWwbng0o26sgZSUcjX41DSNr3LwSufa2rwkwynHWgUA5hLrErOg923hdiBcXEjnSPkzaPFs2L1BHu3PghPWxIRl7HM6JrgyMMBVxiU
x-ms-office365-filtering-correlation-id: f6cff3e6-114f-424d-0c19-08d6222cbe93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08216B9D93369E0BFB2EF18CFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(575784001)(86362001)(15760500003)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: doWtjRewrfV/mbLDg7suCkQ1cZZipYfBgIDVD+F7pG3w8cdjRWNh2D4Y1EW9KoD6PchiQXsU7jos1dZ/31vKY0EaC2xK2Pz/QVSjQA0aoLVM2bVCHK0ACKHsoN+hDIZfHcnzKPxY5obpnaf3Yf3NVVaW9k1+FLVuQYTMC0KbGD6VFdm0KW37pJ0zeFKfC8ZOlJHBEYGrq2wPuY8eCOrmLSSFgPJ65yXELsmN8vltON9+Skg2XsMVbnr6TVyGnhbWqS0QqbwOdvCtjpsjfw2AsO0JiIhnpnt9D5+P6tlawDl9rJURBXE3bjHfMYtf2sXGRSXLY0wuERYIiuvfL6R+XazRl35LTy2KmgTMi+ZGVBA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cff3e6-114f-424d-0c19-08d6222cbe93
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:08.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danek Duvall <duvall@comfychair.org>

[ Upstream commit d7c863a2f65e48f442379f4ee1846d52e0c5d24d ]

The mac80211_hwsim driver intends to say that it supports up to four
STBC receive streams, but instead it ends up saying something undefined.
The IEEE80211_VHT_CAP_RXSTBC_X macros aren't independent bits that can
be ORed together, but values.  In this case, _4 is the appropriate one
to use.

Signed-off-by: Danek Duvall <duvall@comfychair.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index fe1b0108f06d..7d0b460868f9 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2699,9 +2699,6 @@ static int mac80211_hwsim_new_radio(struct genl_info =
*info,
 				IEEE80211_VHT_CAP_SHORT_GI_80 |
 				IEEE80211_VHT_CAP_SHORT_GI_160 |
 				IEEE80211_VHT_CAP_TXSTBC |
-				IEEE80211_VHT_CAP_RXSTBC_1 |
-				IEEE80211_VHT_CAP_RXSTBC_2 |
-				IEEE80211_VHT_CAP_RXSTBC_3 |
 				IEEE80211_VHT_CAP_RXSTBC_4 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 			sband->vht_cap.vht_mcs.rx_mcs_map =3D
--=20
2.17.1
