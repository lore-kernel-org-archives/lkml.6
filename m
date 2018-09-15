Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D61ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C5121477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="alVMLxNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C5121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeIOHI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:08:28 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:14354
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728095AbeIOGrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTTRGiY7jC+4Qe9sBc4ylI1c56e2K1cIDCtAiwJbIoU=;
 b=alVMLxNi9aIb9MswJyKRduHD1pu9uJpQzBXvap7L2Y3XnjsjaKmkSTtRFnKG6F/Ui4oIdwaJ+ulk9I5XHI0Tyz7jzEKZ+ONy2yqfvvnxgpycDJQB6n1oLe9BUq2eoFwzVs6Hq4E+sqh6QeUhxSZA9YhsE9DeMHcXoPI92P7/INM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 13/92] KVM: PPC: Book3S HV: Add of_node_put() in
 success path
Thread-Topic: [PATCH AUTOSEL 4.18 13/92] KVM: PPC: Book3S HV: Add
 of_node_put() in success path
Thread-Index: AQHUTJOc18634CqEfEmE4n+LQHcddw==
Date:   Sat, 15 Sep 2018 01:29:57 +0000
Message-ID: <20180915012944.179481-13-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:nl0ykkxC2tpSoLTyRdesQfMhyJpw3HOEqifKmnlW6CVBGilK5+42WMmlYTvh+O1CKeYXTuPYRODYfSiHgtlhqg8tDugM2kK1O559ngqVBuLyW4iC6ZQalGaA4q0tIEFE1lv/U62m8TSF7u7kvsdt2bP6EJVNuCHdIlWJjuwF4i1LqFz0/SIo2qh0fgAlLLTuijajL4Re5ExyeQULHlc4CjSOp6pVaXx8qMSF3ku0u9R5+gh88Dsq+bVaBrra0cjLBjZvllAwEWePZtaDCwse83GWDV/UrSHMvpCzOvVa1bNsYnaUi1f7nCmDn2X1JZ51CeXTagROBuaf0rs8Cw+RT0xmmtJLFHYoPwvEeflaKpGoCY4RVrecinn3v488VF21QwK9nvR9Ae6APlnL7bCvSV9BbUPQjhPnOq7wfGpE0UDJucqjGRSb97+vANhAb7iNYyHIhr0WTdNr8vrf4XZVqg==;5:CJUqwAoiHS1sOo2LbIopI7fjYOnioSRWKOnZtJmKwxltsxvg5c85aUHhbjb2rkFXSpHDWgcMae7fu3jYdwP11GEnlcaIVvPBJ9SSPNVY8YutVS4bc5tOIhQcEiYPpreKtphKgheGuCPV7b0Zmd4T8OZHNgid3IMYf19MJYVmEIw=;7:b6zdjoegwAK/k0Qsr2uyH2TED6BG8edPD/O621u9Xgaum4zdIcmeUlGu3SK1Xl4YERWY+2em5Y6ap3uY0JZaYMQPegW749wT/8gWauVPOacCTDp3RtlAuzgP70uarcKLGqkHP8bUmFHknMlEZUImw/19H9KQytwgQItL0fOpA0x1+eeNNLCXNYCNUQHEHKjcU8IhuXcSidBgG3VOCE0MMBRLwmU/hRl5jgTU8+bIEnO04tl+DBvSB0NTZejGDs/b
x-ms-office365-filtering-correlation-id: f23d18b8-37d4-4140-b702-08d61aaabf72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840AD05E50B49761AD296F6FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(114624004)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hSaCVMMR4Jcfw9x4COJJPxD+4emzxMit813gLwWWkFCaE8ku5EZkzpInRITU/GNNhhfG87J80yEjM3x0MrZHxRMhGH3h+bvTSUjCmenO6IAISgYjek/tN/L55ar37+1qrpRhNEaD5WJo9G5E7UjPLchK8xFW9zDl7mvMX4CxfMImaR+ImoGz8vfPgGuogNYH+5ITd/Xv+iQM1HtHTK0o1MYGtszFKL2y0GDeIi+LxeblUwCiQ40m4hA2QVzmxfrYOkc2wB3ChtS3yZjme5yYPWk7gzc6MPpZCahsbDmrsUjOpgaCsNwqhpcfZGycpVV8LCPoUKmZeXSqmpU2bxNa3CRybN7aV35mzRjt99xujQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23d18b8-37d4-4140-b702-08d61aaabf72
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:57.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 51eaa08f029c7343df846325d7cf047be8b96e81 ]

The call to of_find_compatible_node() is returning a pointer with
incremented refcount so it must be explicitly decremented after the
last use. As here it is only being used for checking of node presence
but the result is not actually used in the success path it can be
dropped immediately.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f725758b899f ("KVM: PPC: Book3S HV: Use OPAL XICS emulation o=
n POWER9")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a995513573c2..2ebd5132a29f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4562,6 +4562,8 @@ static int kvmppc_book3s_init_hv(void)
 			pr_err("KVM-HV: Cannot determine method for accessing XICS\n");
 			return -ENODEV;
 		}
+		/* presence of intc confirmed - node can be dropped again */
+		of_node_put(np);
 	}
 #endif
=20
--=20
2.17.1
