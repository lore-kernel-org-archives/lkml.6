Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B9DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3B6214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KBnItJAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3B6214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeIQI2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:44 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:10368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728040AbeIQI2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOMKDYWTyyQ2Hrfi6VVvzk3Rv7ZuaZjZfon7pKL2NR0=;
 b=KBnItJAAR0wORhCsU9WZiq5pB/PAW8ROCC4uA7QftmWbgK3MBkc2YL7EdzvujbjxruLxbaiATLvJwoGfb/F41AezLLIx/VgYUkAenKZ8N8vfHFuAXhW8U3KJAh4kYIA6gVFkuAGcm6CSY4W+w2urWrjaMx/iaStZvsI71xh6bbs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 125/136] ath10k: fix incorrect size of
 dma_free_coherent in ath10k_ce_alloc_src_ring_64
Thread-Topic: [PATCH AUTOSEL 4.18 125/136] ath10k: fix incorrect size of
 dma_free_coherent in ath10k_ce_alloc_src_ring_64
Thread-Index: AQHUTjK78bSEYxOFiECl6pg0vVMVhA==
Date:   Mon, 17 Sep 2018 03:01:30 +0000
Message-ID: <20180917030006.245495-125-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:pjh2ZjbhT+lzsdcKOF1aO4NmfbE2dsIyDqcc/Dr6HLx9jQ62vGLtyoCEwh6QsFvDuuWwYMlP6AZu2rKBR2FkjAkc5zufcokeTwYowAjewdVGLHEjx7ZW4LURBFLI2IZopcEp2r5vye4d/qpOwhTEwsPe4j2DeM1txKjR5Bok7tCxuFlD2zxNNwRcaj11tjqENbY/pxoPJVwBAgxmPB6p2qBo7JcQ6QgwNzXYlmQXeAzuyRMsoDbhuY3aSi1na5Owz+gPoU8nzEO9fWgEc7SuNMJvEvaeeIwnbIz1bCi+D+MHJeBBE/PSIRPA+gWvPVPD6YI4LqQ2BWYNQVcLuoYfRF/JNsYJ1Gd9IIX7z54fO5W56xVaTvredibbB0s3HSvs9Y6L7qZNF7QvVZEZ+JAx9OW7Am5TesSYla+gYb6isSUYbk3iH3lYCq0yvxAKDyoBgLYAkC2FkQSsxAtHfI6EYA==;5:ZEW4HsR1qQsiPznfL2FIDhVGOdT342VwKioF2sV4h56IbJNVldNT6e5Go/osWOC0CJsfMbKzOYt4xC7vENDEDsEc3rMBsIGjHkpKtWzD60nV6xYp6mMSCWDVoch42w8PeRcmQRgli+Spqbsz5SvVgGuWGGqLcUPCY5XRG9/708E=;7:caY0oIQ0tsKe+h3MeFVBbk/ewu1AP91UhbT8oo2b1KatFi/MTsCSMIHoMYwR7M1vdJXJ+kRa3qZE9IwHxIghJSJbPwIAPT3im504JbJre7rpVT4LJYiundWBsR5FQPlpjC/x6TDv4SRyTiHXRDD+mUDcoOl9wSgo8sRuhH2Ar+mGjSqtaLYGL42m/w60CyYyE2Gc1Z3oH2oAonc011PZtc1Ch3+i+sa5ylzrBkj58lpNxQTWO40QMpazlECtc/Xt
x-ms-office365-filtering-correlation-id: 2ba8dd3f-6a90-4044-4656-08d61c4a1fee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
x-microsoft-antispam-prvs: <CY4PR21MB0118AA2C16B0063DD8D7988BFB1E0@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(2616005)(186003)(8936002)(10290500003)(66066001)(97736004)(102836004)(36756003)(5250100002)(256004)(3846002)(6116002)(2900100001)(476003)(2501003)(14454004)(54906003)(446003)(217873002)(110136005)(486006)(11346002)(6346003)(8676002)(575784001)(86362001)(26005)(72206003)(81166006)(81156014)(86612001)(14444005)(478600001)(25786009)(105586002)(2906002)(15760500003)(99286004)(68736007)(6666003)(6486002)(305945005)(7736002)(76176011)(6506007)(6512007)(53936002)(22452003)(1076002)(4326008)(6436002)(316002)(107886003)(10090500001)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: R/XFBBFbyiegmgphPjSI+Y1TAWvIbL6dk8JJ9sX4RmbsUTmM5KLjKGZr6PiSyfRiHXxFwMw7MfwL7iIeU3Mxv+FkKY+GcYmaWfJBB0M89wfWz2boGG/OhY+TiiV+7Jl5chHsuDFDANT03RCBstaIAjv5I8Nz2qCoubBoMIJbWIX5HRv5b5loY6EYhA88hfqe9fs615U8hxusv0MzJg3PgVVtS+TkAjtZYXq/tMMTpw2LxBV9WK5CMG3V+IEyH6OOcqiM0eadeds3ZQnaez0IklF8AINjiLqJd0cb83ShP/2af9PZiXQm+wzSj9AfKKlVgzNRBAQ9zsyhlf/6wtyrqB5xkP+sMP7LW7jTJfp7rDI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8dd3f-6a90-4044-4656-08d61c4a1fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:30.7290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 5a211627004e2cddd0ab8b9df19e5fb0bbe97634 ]

sizeof(struct ce_desc) should be a copy-paste mistake
just use sizeof(struct ce_desc_64) to avoid mem leak

Fixes: b7ba83f7c414 ("ath10k: add support for shadow register for WNC3990")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/ce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/at=
h/ath10k/ce.c
index 3b96a43fbda4..18c709c484e7 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1512,7 +1512,7 @@ ath10k_ce_alloc_src_ring_64(struct ath10k *ar, unsign=
ed int ce_id,
 		ret =3D ath10k_ce_alloc_shadow_base(ar, src_ring, nentries);
 		if (ret) {
 			dma_free_coherent(ar->dev,
-					  (nentries * sizeof(struct ce_desc) +
+					  (nentries * sizeof(struct ce_desc_64) +
 					   CE_DESC_RING_ALIGN),
 					  src_ring->base_addr_owner_space_unaligned,
 					  base_addr);
--=20
2.17.1
