Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF247C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5591B20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aGK/VoQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5591B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbeJAHUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:20:45 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728940AbeJAHPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djxv04LVGIm0vC/nWZmDoBhHm3PBcz1a8+RcFAlGejQ=;
 b=aGK/VoQYa5wBOxFI4mqQ1Aw/8az5A+rAgesIowsvjV4BZIAQ+H0PRk+wDpBNEZTdJzifjOrecRuYxETyJEuPz0qlUYUy8iqFq60XucVQoON0XCUIwon/10JkIV0GoqjurL6GvkqFFj4M44WPjl9k9su9fo8/AW5O7rR7qJb+HuM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 11/26] drm/nouveau/TBDdevinit: don't fail when
 PMU/PRE_OS is missing from VBIOS
Thread-Topic: [PATCH AUTOSEL 4.9 11/26] drm/nouveau/TBDdevinit: don't fail
 when PMU/PRE_OS is missing from VBIOS
Thread-Index: AQHUWR9eDYaeb1lkuUa+n2Zcpulxtw==
Date:   Mon, 1 Oct 2018 00:40:35 +0000
Message-ID: <20181001004026.147201-11-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:Z5hnMA8PJDdeuNXEND6zAZURCz6dHljwJqgG4z0nfn1sRldMlxcszIym05gRpF5aR7M4yAF2PTXDmIF5wKliKs0qPHtVvNxA7/oBFEiSHbxc0AZcxiysJWKHDumwmZY/PeywJ/61GZa6PQrzZYHQ9w37swq5P/wvBef4THsfVdwaxLwFZzZlsp/T2L+jwt+goRbDigCzbpE09FhxFeR2KVAORBqYKsICduLlpj4KHWsGnJKFW4YprGq5/hJHMY0UhAbdx9d6Ie5okG9DeYNQ487TwQKIbM5j5QtHroE9Mj9rKB3VW2MMUIwqM2v2gIZ3kl6rWSUiPQtNeuK8KekkbDuEzKYvpoVF0SyVfUtFy7fZlaEP6tVg9dLlcM+Km1kEj7oVEHymicwnhGxboNuVy83n1d3NpVLpps0e9WpNVFCROaZlfP7es/ixhDJ0UOYOljDt4unSWYF6MDAKiT5ryQ==;5:MIcmZnFd+3j9zZ0fL/L20xWznJIPAzrl4a0aASoYVz7PL7FTeNeg1jAgKMOUQDYtoJfvoaeknrAFKGXl4phWJzk1w8N57rwI6qQiN3k+gwuzMYUZ5l7oPmflklz5ET8L7bFsvrLwRTEtA5UqnNBWWBsVFEs1ysarTufv8t+7lzU=;7:8BoS/bAQH3i8PnsjsUseeI/vLALO3LkqNQqptmcZDFA18jAmTo0rNEobkGIe1Mpj+qJTo7DUfTD23BFIlQ+zcbSvWtv05/ZMNV5NA8SvvMt/lVk+9f+SLO2AAr0AQRnYIyZK2hx8h0FxGYOh0SKIhK6qS5HOx+hQaGN6dIAyLJkFQJpgZ7mIZ3AWZ8uCs4Nq1GCveeEtFpxUez2zfiOeJNl/QTEfywcImhSs+p1P3X1YoDp0IQOnMwce0Tb4Wq+y
x-ms-office365-filtering-correlation-id: 1c6bb6b9-20d5-4dbe-5d3d-08d62736809c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01209555CFEC1F1A26AB41F7FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(575784001)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zYiiX4lUlrS3izUA7c3Q3vFl0w1DhTHuX38YTuQ+aHT9dT+d+kHAJRvnudBdBbvU+VpiAM9BURP6xQAVT7PYhHU2nnutE4eV2VreVVaOscsz3ujv4mQ3tJTWlHDhv8y+9e2P4OUVjJnjyXrtgZNJFiJxAmJQHrsousUg9kvMI8Jq0MQHWzXDbIFTVWPSvLGx1q1D1MUeIqloPtu6kAnLNDXYpdIMnpbEzd6qklak92yXpnjhjkm6ryjdPfapYPYx8yltBxBMV4qepKLWeUuAQgPjlQczzz/qSdrlaVz1wR64Y40wdMBfk4qhAXTaIs03VaiSXYQfEZCRKUYV+XMMc9QZttsZJowqEHJyQZVK834=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6bb6b9-20d5-4dbe-5d3d-08d62736809c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:35.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index a410c0db8a08..6a1b81e2b727 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
@@ -161,7 +161,8 @@ gm200_devinit_post(struct nvkm_devinit *base, bool post=
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
