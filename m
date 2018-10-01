Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A94C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED32084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="iBQxcxQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ED32084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeJAQou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:44:50 -0400
Received: from mail-eopbgr680077.outbound.protection.outlook.com ([40.107.68.77]:59840
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728791AbeJAQot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQfWRCP1N/F9N5vY0l5NTFNPlLcNkypF4Bx4T/votZM=;
 b=iBQxcxQ1WNtokjptw5cP3XZ7DHABB/A2qYrdaavZopyW4itcdOqcFJyxzPI4cUWyRwHI+sDTMhFf13wwowVxBX1VftDLvVJfdcy5gKnOVxLwzdLK5T2pcAItNLltRZTCPGEG98Y8dIt/0mEm83ltcmSVcmDsOZepU3HnmMHcOTE=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB5332.namprd07.prod.outlook.com (20.176.177.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 10:07:43 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::6d92:d509:3a4a:2c7c]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::6d92:d509:3a4a:2c7c%2]) with mapi id 15.20.1164.029; Mon, 1 Oct 2018
 10:07:43 +0000
From:   "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
Thread-Topic: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
Thread-Index: AQHUWW6YXEMNiP6AC0u/a7CvXSbMkA==
Date:   Mon, 1 Oct 2018 10:07:43 +0000
Message-ID: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0068.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::28) To BN7PR07MB5298.namprd07.prod.outlook.com
 (2603:10b6:408:2d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB5332;6:ddikCsa9cfu5CBk6aC3NLurg6i/l80ak25vWK/AHnLPHvVcSFtLZmfkRF+1l7lMDYl7O9vnZpSBCIK7u+bIAYBGP5JQCfeJgfVc++/4sZeLlTQHACjk2eGolN8yIPqu2Td6tMVKFKIlg8DcDXEsu3ldMVPOteSuvLQvgR5vTN/XckHAeNkYHDxjdqljuByaS/KKCrh+j7wRuzfwGyGvrm0V8J/vYX75magJYXQzIS0zMRZaXUyHOjmFJAY4+ETa4TMY24ABsrimqZSRK9BSVa1J1A8vuHgIoX9lKtc05AEwjh6VeciUGUjMAsiwawpcbJO0D8K0hQqdW2F/l9g//ooWw44USeTKPSs+dZ61BKPNz8s/oB8pkqP7VFzzxsvcO7ERcXZA7CKp7MLBVFzYhj/aBHm2nRy15jhaYnjTkZ+5pIBxR8ueo9CgwNncrpCBQwpFwDrwyF+qU7VetE8TqbA==;5:ZcIrhf4Pt8d4SsTSWLtcSBZ7SM7SCDSLEyk7bZ3P3AEdZ8u7WeQ/l1EGfdB7AFw7t/N0qQ3OXScKY819qLuMseCg5fk23TiHBvyLuEF4Qldq71SOR8/ionb46VPGhfZJ3/KXvvD2WT5Yq6fJ1WY5qt3b8oeMbcOmFXegMa3LYvQ=;7:hvrGR5aXMB+Tqahij1LwIFJnpmriPMLyAjmZYHaESLtrnw6t37Yl+OOdBBmBEuJ9ev9q4n3jFmEUh6xpZXJVra8DsHncsYHmmOUzTVK2lGOoG3BudLMk46GPBLIAVcT45B7D58NB7scCTqaLs1YLufO3O2Jr8qahKRhD6pDYf+sOW+Lo7uA9n0e44ctEW48UTHM/jyaoDpPU8oB0f7uWpQj5UJx7t1MANEaqQcKTRnL0EZ2/u3zhdpZfhFtrR0fg
x-ms-office365-filtering-correlation-id: 5ab27667-363e-4d61-f8a3-08d62785ba1f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB5332;
x-ms-traffictypediagnostic: BN7PR07MB5332:
x-microsoft-antispam-prvs: <BN7PR07MB5332AD442476EA801B0AE9F683EF0@BN7PR07MB5332.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:BN7PR07MB5332;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB5332;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(25786009)(102836004)(6512007)(86362001)(305945005)(8676002)(7736002)(66066001)(8936002)(81166006)(81156014)(26005)(53936002)(1857600001)(476003)(14454004)(2616005)(486006)(256004)(14444005)(186003)(36756003)(72206003)(106356001)(34290500001)(6486002)(316002)(5250100002)(110136005)(4326008)(6436002)(71200400001)(2501003)(71190400001)(97736004)(105586002)(1076002)(2906002)(99286004)(6116002)(52116002)(3846002)(2900100001)(6506007)(39060400002)(386003)(68736007)(478600001)(5660300001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5332;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: isA0wZNrPkHmcHctSo71cBkRPu4L/Uj7F9qWfvyjMSoU/OB93p4MiqNIdSNczluhtaA1rEtKvEbusuB6H/e0ogw1lAJWpHL1F4fAcqO2YVsYv35pK7LV4HXUDiReyfhB8dCApC9nQKbJhm6W4lyd/+pDtjf6++u9Riy850sEk3NIlxLroYipEzl2Rpzaw6vxdmqk3j1PrKeF+OVQY3zymp2VCfqmrfXj3jUXvkOZy65ctrtE4WFUAq4pxusi5/vXd2iK9QrP37l17rrn5EniKrcHjjlT8KzCl0P246RWy+i9eRG/LPLXL+06jd26rPAU2+6XDhuWcLlUpAAqAOmpTbZHKPDpifiXn3UVk68BN+4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab27667-363e-4d61-f8a3-08d62785ba1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 10:07:43.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf events L1-dcache-load-misses, L1-dcache-store-misses are mapped to
armv8_pmuv3 (both DT and ACPI) event L1D_CACHE_REFILL. This is incorrect,
since L1D_CACHE_REFILL counts both load and store misses.
Similarly the events L1-dcache-loads, L1-dcache-stores, dTLB-load-misses
and dTLB-loads are wrongly mapped. Hence Deleting all these cache events
from armv8_pmuv3 cache mapping.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 arch/arm64/kernel/perf_event.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.=
c
index 33147aacdafd..6a67ad22d1eb 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -207,17 +207,9 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_=
COUNT_HW_CACHE_MAX]
 						[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
 	PERF_CACHE_MAP_ALL_UNSUPPORTED,
=20
-	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	=3D ARMV8_PMUV3_PERFCTR_L1D_CACHE,
-	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	=3D ARMV8_PMUV3_PERFCTR_L1D_CACHE_RE=
FILL,
-	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	=3D ARMV8_PMUV3_PERFCTR_L1D_CACHE=
,
-	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	=3D ARMV8_PMUV3_PERFCTR_L1D_CACHE_R=
EFILL,
-
 	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	=3D ARMV8_PMUV3_PERFCTR_L1I_CACHE,
 	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	=3D ARMV8_PMUV3_PERFCTR_L1I_CACHE_RE=
FILL,
=20
-	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	=3D ARMV8_PMUV3_PERFCTR_L1D_TLB_REF=
ILL,
-	[C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)]	=3D ARMV8_PMUV3_PERFCTR_L1D_TLB,
-
 	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	=3D ARMV8_PMUV3_PERFCTR_L1I_TLB_REF=
ILL,
 	[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)]	=3D ARMV8_PMUV3_PERFCTR_L1I_TLB,
=20
--=20
2.18.0

