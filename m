Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64AAECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F11208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LDwkMd+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F11208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeIQI2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:43 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:31712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729730AbeIQI2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ7ZcIwQsGdVaRbXdriMqOlkSxRPJyGqwImw/ND/HoI=;
 b=LDwkMd+IHAo+NUw4J3tuGoTCWfKkuHwfWpf3MKZXLvkwm/4vDsTMVdpbiHlk/Mb1VwIf9Zy1gSn/lAkHNoVnRz5rbQ9hApm8WoNNvG6saG9M6c0MHL26TnOWJyQKUsYgwLGuFgQ4LW6FxEn77vm07fHWnS9AQ5Roit7sdIWutzc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 126/136] ath10k: snoc: use correct bus-specific
 pointer in RX retry
Thread-Topic: [PATCH AUTOSEL 4.18 126/136] ath10k: snoc: use correct
 bus-specific pointer in RX retry
Thread-Index: AQHUTjK8+iXAQvaY/keFzdift8e3YA==
Date:   Mon, 17 Sep 2018 03:01:31 +0000
Message-ID: <20180917030006.245495-126-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:sadvxeFuynPrjhYo61LT8HkyeWfMJ/eDCTK75B2Tz7GQJGOF8TF5doJnBPANyQwHR4Yl25RnHSb6udpMmfhUSShE6GRcabiqx8piH9gN2RRlxry3TknlvTk726Tl8JgbltvwdszplJ8aw+08nRxt5zmW/vVcwSa368t5bFKnHjQW9ux/3JXkPNIThso6VstopaZX7iO653u0XaVZWd1qMUUBQzQtYRFpTYclZOP2TS7XWpNfAQkNep8SghJVIITc38qcE3KAjGU5Aj78fo8YOXBkNHNhconNW6TTxX5UxMIxdb4Ky3hS1V/NQfU2KPH0DYt5HgoR0xyHh8hKmwgqgcH56mre1qxawH+gOVX33O/dtqh70+j0IO30CL2kWxbBc9n+N9lSEardLfFA8vOJk8gz/T+g1202+VGGm5zunZGjqjWN4oRAbuKNL56/gaNjHpnS7EdaCW1rGTjQHRjksg==;5:k1B7OaUFvp6xu0AHfZxwAPZ8TM6MyaZkDVUU5RY63bLew19yVXyTgWifRJ/y/lewgxxC1q890n+zXasOkAC8Oo2g2x4aIcCNJ4illbpdGO8Sf3lguxqDpcG5ck85a7A3JmkeSNqw4eREYcJpmsBK5yETPLEpgU8y9q6QSsW3nYg=;7:qfyPE7ieiUwFjm9k/ttmkHMHqmCRwwegCo30DaYDG0zW+eS6YIKgmiNFguwrBydFBbeQsvBJoa35PH3viG/+xtFgkY8T6HD2Yc9CWzu6EZ34RbQg8swz6KYaede/w5VxfR6ISZESODjjoWdxX8TE4o5udnqFM17NN4+oe3X2Jm4bqP1nu9YpfCSW6bUAGa2rm9/h4X37M2ToYyLXudqaA34wtQRKamVyyYHvOl0rMA0PWrpRlQ5zehow3A0xB+lu
x-ms-office365-filtering-correlation-id: 0fc4b41a-ff5c-465d-f53d-08d61c4a201d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB01183CBEE5BE9A0328ACE1C7FB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(575784001)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Kz4JNf7zgI736y38SU+cGcBbu0croyYljdC6KWApzWGdPUsA1Sob1NsXpwYVRai4ZGFP3f8B2tINTaEXBqw8+yzTwwFrBz1FHgCbGTgUYMJ8hm7Wsx+AT6tYSOwZ6oHnWnv4KK/Ka1K1ms9o5Ws5QoHrFtWJp8U+4C8xGOQ+VBt7TJubD6IWzlsXsWlMIZd32JzQUJRuv6HShYEjA4FcWYMbLiUeNgXD3bbahkhgAZ41U+usay9doSxKS1IghkkCrqUnGEGooJ9xZQo7yAK5lyYU3Xk4nn+f4qysLKZxgzm42QPAYtgc8faTxTSoLBEXv8Hr+dsmRSdvXSuTJw4QtpdDua2MsMbgX05mNAT71o0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc4b41a-ff5c-465d-f53d-08d61c4a201d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:31.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 426a0f0b5a2fe1df3496ba299ee3521159dba302 ]

We're 'ath10k_snoc', not 'ath10k_pci'. This probably means we're
accessing junk data in ath10k_snoc_rx_replenish_retry(), unless
'ath10k_snoc' and 'ath10k_pci' happen to have very similar struct
layouts.

Noticed by inspection.

Fixes: d915105231ca ("ath10k: add hif rx methods for wcn3990")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/=
ath/ath10k/snoc.c
index a3a7042fe13a..aa621bf50a91 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -449,7 +449,7 @@ static void ath10k_snoc_htt_rx_cb(struct ath10k_ce_pipe=
 *ce_state)
=20
 static void ath10k_snoc_rx_replenish_retry(struct timer_list *t)
 {
-	struct ath10k_pci *ar_snoc =3D from_timer(ar_snoc, t, rx_post_retry);
+	struct ath10k_snoc *ar_snoc =3D from_timer(ar_snoc, t, rx_post_retry);
 	struct ath10k *ar =3D ar_snoc->ar;
=20
 	ath10k_snoc_rx_post(ar);
--=20
2.17.1
