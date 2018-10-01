Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A18C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B1C2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oKJCzpwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B1C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeJAHOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:03 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:20832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbeJAHOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfzCEFwdorXT+IgJ+bavtHUjm5D1HZDMIaMPUTsvwiw=;
 b=oKJCzpwCquF+nUr1tuMaETX5MOZ9sjd/Mdbv2kIk4PKuud1JH86VPqRVsiBQV7xQGCJ5CG8XXPw7Vo5gg4h+sO1vdXogpOlQb9Vl3+uOgbVyemGQi00NREtPrN5wRSUjKuWYdSJXwC6EJVmQSPHqMEp8UpcKYiJJLq9rE5jepEQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 32/65] drm/nouveau/TBDdevinit: don't fail when
 PMU/PRE_OS is missing from VBIOS
Thread-Topic: [PATCH AUTOSEL 4.18 32/65] drm/nouveau/TBDdevinit: don't fail
 when PMU/PRE_OS is missing from VBIOS
Thread-Index: AQHUWR8OA43NaPubtUCWyx1V6iofXA==
Date:   Mon, 1 Oct 2018 00:38:23 +0000
Message-ID: <20181001003754.146961-32-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:XDth28QytYA6Kj6jRyHdG3JqDjd5XcVQXon2d4sG9Av4SlA83edjbagTwtYBoOh3plhRQpiV1krMjK+w6c9XoHWy/stYzyrehkviKs/P+ZJsTs0Bf3uF6iTHsGQuCt9SZUEAczGpvfbc2cV4t9qEhagL6ALER3ULJrmMNS1l2OAexHOm32EDR9gjvmF5tO4sW3VnryxOP2fOGAQIqTNq195M3IWrJCdu2xm3Th+3GZdY5v/pZDHkmQuMutZFdQZdw+Z/CB/6GXi/kXC1tDr1D113mekR7whPs293g+ufWWhozc+bFHaka9sIgLQEeVgRTL/IgZ/TUjWlKAl28pBt5YDWB+ZcMVpXlcXNy7jtH6uPLQHVr1/cdkXe5wxD6RW0SxmFHG106RX5zYnj0ieOqnS8+xuEeey+w/aR6eVL/iyRgjPBV8b9Sz9lb0BQzstttbXYgAPoNu4CL6a++xac9w==;5:4QgWyP+KAbLJFUP7rh63pDA8PeH/4Ir4eTGZRxK4MzQwkK5yrRRA//rfmgNYvXTlHpHStHWF72FIjQc6Ib4SLx4awwjgXalSYZLj2mqcJ8NLkhlL7wQvU9OEzU0zEgGmx0WdBQ2C9C+GwslVMQ2Oma/Y4rGfASwo485bZLl71bc=;7:zQ4n0ar3Khdc3wbo22f3/CKE32XWqdnqjhadYJppTO7bDooKPvMxI5/l+EpK3q0/6+anFsm/jbxqRdpf1U9zfkJD4V87pWmBPXEgtgvqsiDB8La2SCsXI/mBNgpQNFnDb4ahTsz7+XcO0O0eNMFSNXaujXlF6D6s9br0JA15twYxCMiaYikc0oUv6k0G2i4J1haYQBw1nD20UXiJU2OR4s4kN4sgT3V8S2MNHjllLcfOeMswRjfOQ+C4sMLwyX0j
x-ms-office365-filtering-correlation-id: 22ba9f8f-678b-4642-8def-08d62736432d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018119CD70ADC11BBB0E8492FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(14444005)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jc7E2tLeagnqyUUOYCf8GuJpDHZf4kOrwJ3nqsznKWL+2O386q46YMR3sR9xfxk1C+AXn9otmMVjIU6U8co2fL9Kp2tVVcqpDNC/O+54vUejkTTD2U/DOKScSCA0VfmbQrdtLh66ubn/mX/d4hR+qFm/M5Q3J6GD5e9DnELV/XcjwWQkr+tp981SUYyiFNMLUJM4AkqvEETQ1H7ANccg6g+y9oOuzci+HY9DC6nxv6RrdlaqnJzuu7p/orT1ynLWMcXse74AoZVSo1SWG0n9LZWS+Ae5pel1cJPHjLWOosNeEdVFKiy7hTkIE2cbc+uem0b5kl3wdo5j8k2FTKb4KGVzCnpOkIDo796varPK5zc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ba9f8f-678b-4642-8def-08d62736432d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:23.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 0a6986c6595e9afd20ff7280dab36431c1e467f8 ]

This Falcon application doesn't appear to be present on some newer
systems, so let's not fail init if we can't find it.

TBD: is there a way to determine whether it *should* be there?

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
index b80618e35491..d65959ef0564 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
@@ -158,7 +158,8 @@ gm200_devinit_post(struct nvkm_devinit *base, bool post=
)
 	}
=20
 	/* load and execute some other ucode image (bios therm?) */
-	return pmu_load(init, 0x01, post, NULL, NULL);
+	pmu_load(init, 0x01, post, NULL, NULL);
+	return 0;
 }
=20
 static const struct nvkm_devinit_func
--=20
2.17.1
