Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4218C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2EF20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IOm0tylB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2EF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbeIBRc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:27 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:63162
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730305AbeIBRc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqA3S+gBnuyuWpMGUEd71/ixpps4PPJcAk9aanCCF0U=;
 b=IOm0tylBUTdhBZYulP/C1o+uH8OVDQEh8eCuDSV5To3/0MzzYfC8sr+QIskg42B9iMuX1r0LkXqEcooJ2cXbcX2wHX6/AeEEliTMM9QFuSHfYbfovalUTvfdvSS+u+vSr0K537hPpu2xD0Fl5UMwAQ5Zq/VEwZW31F6EsNRo2Ko=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 27/47] MIPS: Octeon: add missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.4 27/47] MIPS: Octeon: add missing
 of_node_put()
Thread-Index: AQHUQr8emLek+aE8vkOk3BIIDqpaCQ==
Date:   Sun, 2 Sep 2018 13:16:12 +0000
Message-ID: <20180902131533.184092-27-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:XJmJBG5NEfo0JuYezLwgx7mqa58KlIDNQXJ8D9rdlNeyClNEGuYtUx/2BJLZYfmLKUtgz/yzkzkvlttu3DKfRet4Ou4DV2IHhwCyWJcgasJN94m4ikazta/aGEuYqjKHcQued6QdHfOfpy88LncJhGXSbCP0JBHGRxArdLutdDrsqobaeNM607ljBoOzpc9BPFHPLlUD/Bxkk0fub1eMgu5Mj8mcPxzaIqgoh816eBVUAN9arqsvX7E+Bc8EC+YsAlFAnfinpLOyeka0xwtzsEOjCVYhUCrUToNk8WFE/MN92Vvj3NvmXZrDHP8jewMQI0agZurgl4059iOcmKsH5CpgHWNKKDTtXJUNo8WNUcuyFe7d5TaMCps0dKCWUoDm3uZ2RI5xFhL0CYr6UKKNh5zCoIhFUi1wkCqlXo0/4ovHCwwF0IfV0+GHMY101ksxaPK9E25Y+ap/9EfWQBzHPQ==;5:T/1mMlUOMLyYZOC1q02O5KzAR+NmY0y3wERiQB6HF5i214M6IIba/Uyvt7W1mFFiINKf0JrG5/F/hb1YX16EjalM528fSRRPWSKEabtNY+f2Vh/ngIhqWCJ1zv9GZ0nQynl1/tF2JJM6m0eKCQh2IumNFQLk02119i3tnaGebTA=;7:vDybi0IsKpSPzOxI/6PV167I62O5L372jeEBoIdV2TX5WRnM34bGkf/lZQGC5vBC1Th0XdXqbJace5oE56nvQjRWbJSGxzFZqpAJYWG2nL1VBAM2m49H23kygPYH+fS1npJ1ZoSMWwJ5UKmcd+/3AGGCTpd9gkKztRaTd2l+tZcd2aQa995eUoBM3Z+tmDhhEYd4RmK3cGR56fjwMFSihT0jHhCMtnCGcU+qpTInZtenraBsH7qS2gCgzqUz8AQB
x-ms-office365-filtering-correlation-id: 5a13f60e-7447-4872-2754-08d610d6497f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629BE79E3B7D8EF148FAEA3FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(966005)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(575784001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6306002)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AwWToMdi6zZFoo35K77DW1QI9wfsc2kQWLBMHz3Cn0lRL2kEKkGOY+3if9Bwo8f5RPb4DiyGNsWSMKzLbwfpaLFImY0Dh4IKl4VcWZpBIi2Nwbd72/uGOHZd+zmh8DItpH0DhuMi3fsilW74k/R1c6kN0WbOB3yBrCCylcfZVnRUtuTgMw8DCOrvKCjwxoUq5jJSae6Va2AIj+gZGgBOD0AFcMdG9AnCCnMri1OGuFDs6/eexsXnDVHOy5+xs3vIvTN1ZyKbI5crERqcOJkxavB5bhKnz3Fw/7xHIY5TphSUsRUmPuKuoNVfmjMQVumJpMYYFfVQ9e+f4KMLB2MU3DxYkNN3AecXFnlUGv9Qtrs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a13f60e-7447-4872-2754-08d610d6497f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:12.3986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit b1259519e618d479ede8a0db5474b3aff99f5056 ]

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19558/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/cavium-octeon/octeon-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-o=
cteon/octeon-platform.c
index d113c8ded6e2..6df3a4ea77fc 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -349,6 +349,7 @@ static int __init octeon_ehci_device_init(void)
 		return 0;
=20
 	pd =3D of_find_device_by_node(ehci_node);
+	of_node_put(ehci_node);
 	if (!pd)
 		return 0;
=20
@@ -411,6 +412,7 @@ static int __init octeon_ohci_device_init(void)
 		return 0;
=20
 	pd =3D of_find_device_by_node(ohci_node);
+	of_node_put(ohci_node);
 	if (!pd)
 		return 0;
=20
--=20
2.17.1
