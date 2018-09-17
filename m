Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D29ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77362147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eKvtLJHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77362147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeIQI0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:42 -0400
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:45407
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729001AbeIQI0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5JQDPFq7Et9PiDZNykzkziBqjXno3LHFpnLoTrA/Do=;
 b=eKvtLJHEiWVyxp+WxwyfHHaai/8XiQOF5Pivbwvd7+0+kovRse1JeTAaPPlBelnIx/YEF/WxJosHMJmr93SVWnirg69edmtULw8LU2ZHYt5MEESeLeMLzu+eXJ5C485b6B+/OSiGZa0+vIM6EFn7M7CPSVwRfkZ4sStMNZxlPZo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 055/136] powerpc/powernv/ioda2: Reduce upper
 limit for DMA window size
Thread-Topic: [PATCH AUTOSEL 4.18 055/136] powerpc/powernv/ioda2: Reduce upper
 limit for DMA window size
Thread-Index: AQHUTjKhgsr/EM0EOkaSbbbRjl6CmQ==
Date:   Mon, 17 Sep 2018 03:00:46 +0000
Message-ID: <20180917030006.245495-55-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:cZBfPXRTYykMoLPUS+eEIqvf7yC+uiE+U6rweIvzbd3YTj5JSnCwUtx/CsBjssxjGhh32E84BUqHYgvfTWbe/i8F8vhvXWqEC6uTy+VCyzuJDOpurfn2Nwm5AF3bDX5npOyJYxogS02dFOvsCjePzQ3IapcI1vH3EkBAHQbQgkukPugXpeQ8qgiqmaTNiIA7PePe43vrOaW9JUtfEWpC4FMIIUWWXuCweUP/27j+aN7kSDtx6hJ0EvrgpjpPg+dvQY3HXvvDJW1ZujjA066OTS88rk6/zj/mrpoye2xboisgszcYVJe3JC/wYQ6uDjw2re4eyTcZMwNPzLuS0vDYVwv0PCXehPYneELj2COHRRU3VlRCRYbQZnFcW4Sky86uhcT3Bg7Usr6eaysvN0JBLoEY4yNgnUsKXj62ol2YSQAqCu1oFcX9p8xwWy1O347TzYMlwxYIrsNcAPAcFFbgrw==;5:5DnbfFGSMQqVdes6UGvP6b82qnBu+yu7TH1UfptyBW/qRbpdLTzAfHF4PXIRBlG/KAfgbDlMVPBLyMksYTtZwPZXots8dbkH6bwXPSLnuvRvnLlxwlm5ygouRmv+NojbIaLIA4iF1AN1zRv2nVjukRwlcAIBcVMIs5VTIvyUFUw=;7:wZCCOvUI8gJfawjP70mvO0y3DK5OM/AEsjy998UpLcdDENZ+aFmPKDWGRO/8wYYTHMSksMHqwypykmII4Y0k1Ncuu2iVNmPEEgUkMDBhr7T2k0m6B25N7QFbnDjVDqDh+fMYPTJjaex6OCERgSmqIYjowx+BMTJAtDN8tbntELIOalbKML6T3bvsMXawR6jVEGKW62G33OJuX7nhBO3yMCeOWZ4yvl5D81/AOgaOkB0mwBVWw6lqRPGgHdHaVcnf
x-ms-office365-filtering-correlation-id: fad77ff1-70e0-4065-08cb-08d61c49d510
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167E9FD65CF08B980FCF9CFFB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(4477795004)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: MaipuPwxOPUwM+UWmYn1y6CeTeFUbaPxj/F5sxH82MTk73iRxTl5sVOjN1XkbhA+xlJ78Geq6o0gUuV/zbAFe8t8VBFqosh1VHnXg9EO7wnrlrP4t20Y58oEMCSFaVTdWZwijkm616yrrUeLDTH3YxAcFQhfJ2KmtPMXyCgSw6cqiLjSYVkOTMML4KuqNnLOKh9Io1miPG17zfH1ktj+s4RuU6GSxS1qFJ7B41due6NyCbYUn8M4BbJyYmqdgJ3SpUosDXc7JOj7z8V5Ff6QxkMJrvNyLXm0UvDBVvjlEjhyt9Xb1/mrb2VApbebTKDm9BN1OjN0ExhhOsW/gZb7aFvXopLfCQ4qBO2hdM4t0n8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad77ff1-70e0-4065-08cb-08d61c49d510
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:46.6201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit d3d4ffaae439981e1e441ebb125aa3588627c5d8 ]

We use PHB in mode1 which uses bit 59 to select a correct DMA window.
However there is mode2 which uses bits 59:55 and allows up to 32 DMA
windows per a PE.

Even though documentation does not clearly specify that, it seems that
the actual hardware does not support bits 59:55 even in mode1, in other
words we can create a window as big as 1<<58 but DMA simply won't work.

This reduces the upper limit from 59 to 55 bits to let the userspace know
about the hardware limits.

Fixes: 7aafac11e3 "powerpc/powernv/ioda2: Gracefully fail if too many TCE l=
evels requested"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index a2cdf358a3ac..0976049d3365 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2841,7 +2841,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, =
__u64 bus_offset,
 	level_shift =3D entries_shift + 3;
 	level_shift =3D max_t(unsigned, level_shift, PAGE_SHIFT);
=20
-	if ((level_shift - 3) * levels + page_shift >=3D 60)
+	if ((level_shift - 3) * levels + page_shift >=3D 55)
 		return -EINVAL;
=20
 	/* Allocate TCE table */
--=20
2.17.1
