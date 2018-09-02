Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C483C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F66E20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KNnaKb+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F66E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeIBR11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:27:27 -0400
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:54080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727541AbeIBRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVcYFmUFBuilSo2KCpUF5IKJhDnDldJhhUv5xQ+BuAI=;
 b=KNnaKb+vUEA9ZPeyAdYnA+9BV8IbJUrLXl1a7uP+3zEUJFAz3FFTq8zAg2h1VUf49c+AnnwNS59CSQ6y1LnbHVlDKP2gN0ymmU3jQwE3SqJ+RmxTRmVAeAh5s3BPr5X01wHcxTy5+/UYw/8DOnpvBQH4LhOPJeDlB9oLjieVYjE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 22/89] firmware: vpd: Fix section enabled flag on
 vpd_section_destroy
Thread-Topic: [PATCH AUTOSEL 4.14 22/89] firmware: vpd: Fix section enabled
 flag on vpd_section_destroy
Thread-Index: AQHUQr3GPB68OyKqOke7nN/qGKUgbw==
Date:   Sun, 2 Sep 2018 13:06:35 +0000
Message-ID: <20180902064918.183387-22-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:+errPkqYsBKgKhzKVmfM4OkSM5AzyXog7yKUTlrnXJGBbC68obpURuI3xt9C2Xpxvx9t87T5MM7d4uu+dmroUDkaQK1FvGOI8UN+8jLodrLvh28t/ZpCDKVYx7pZ3S2A0f4ps1DAKKVUYquSUQbYFNv+2YhJ8u3O4SoT431NfVpYrHyo3ZgS6Bd8+JyDkpFWfj2js5Wlfq902ed2sqjb0y3guAocfRLqerMdCn9FvNrSx7k4EQ7/RXH/6Xt8UN1mDONv1DvmYUtpBqCKRYveAo/ebjYMyThbtyBvhiZitOewn/fvUF6Unwk3xvODm/UvPhy/1U5T+KzJp/euIT3fTW+FHn66yHurl+PN23Ya8FlslYou2KU5ewVJypa7+i9bD2WWf1CESOf5T3SriIMeFige9BDmpMzngR3mnxkTbDUjSnceUOTOAUQKVWWLfbVAc00bLNDiWAKA89OT4bijcw==;5:D3IsNFEcArSz69IOgeJhKBN/67ZK0Ml01m4XZrwbsNlnh3WqpVlhk1grDBFLw7h5kOyoR39XzDWdnMOE5OvcLBTRi6wgkv9eHjCsS4E3j7G4yvgmWVpv/M5pda7ybcya66ETu+om96UQh1KA1Oh/R4y9g0CUn/7AAlAyUcMBSck=;7:K53EkSxQ5xm6zT8LhPrqcMrsB779RN4HNIEjEhw+qx9G6Bdx5M9CHW9o592uo0er2HT8O6E0rnPuUDFuQ/5eeYQv2On2RzCYLbinXK7oVJ6JAVOBO8v5j1DrJ5Id4ZQJvdknmQdkMJyPjcO1mqBS8Fqn7k8j8V6hvU5Gwcg7X2yUzIox0PXrek7Lz/vsZ/dWcmvjuPdOgDPXmyRctsBVNJqGUDKb5e1lfPrLsfrq1ltGNCxXzmTMXYfKLZxXkM4g
x-ms-office365-filtering-correlation-id: 5463db46-3c1d-4c62-bb7c-08d610d4fa61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0856CB9045D3611E8FD3C510FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(575784001)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(4477795004)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jmYWV4MNAqvcxAQP22I5/2rt65++7Pfi/JmqjzPuC3BBJJEnPSJg2hMBSp2UPUzGjRfoR5tXZ58zLShrgsrbDDmJXzw4umyAdY2i4jWlEUriz1ySuEEL5j9iUkZ1ODhC8rSZRTRCVgOeb3LLw2t2oAunUymZ1G0b/bjKda+aE+XIGmaf9UTLHBKjTDd1MNl7W0CN0tvOKK5fr7MtklBLHJJg1eQjADUyCDyEAjJnX7SkdUgZk9+7FSfe3bOv4xoH99nmyLrLkfxwChqDc0pNyb92OLH4D3buDfaNkesELrOqxMikHxNlMtiOtDxVO3b4HrLa4mrEvROB1icFj9+ehMkOwADFXxHWNQ8SnCIh3aw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5463db46-3c1d-4c62-bb7c-08d610d4fa61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:35.0874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 45ca3f76de0507ecf143f770570af2942f263812 ]

static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
in vpd_probe() based on header's ro and rw sizes.
In vpd_remove() vpd_section_destroy() performs deinitialization based
on enabled flag, which is set to true by vpd_sections_init().
This leads to call of vpd_section_destroy() on already destroyed section
for probe-release-probe-release sequence if first probe performs
ro_vpd initialization and second probe does not initialize it.

The patch adds changing enabled flag on vpd_section_destroy and adds
cleanup on the error path of vpd_sections_init.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/google/vpd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index e4b40f2b4627..9c0f7cf920af 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -246,6 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
 		sysfs_remove_bin_file(vpd_kobj, &sec->bin_attr);
 		kfree(sec->raw_name);
 		memunmap(sec->baseaddr);
+		sec->enabled =3D false;
 	}
=20
 	return 0;
@@ -279,8 +280,10 @@ static int vpd_sections_init(phys_addr_t physaddr)
 		ret =3D vpd_section_init("rw", &rw_vpd,
 				       physaddr + sizeof(struct vpd_cbmem) +
 				       header.ro_size, header.rw_size);
-		if (ret)
+		if (ret) {
+			vpd_section_destroy(&ro_vpd);
 			return ret;
+		}
 	}
=20
 	return 0;
--=20
2.17.1
