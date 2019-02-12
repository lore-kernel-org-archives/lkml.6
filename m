Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C94222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YfZezLtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbfBLVYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:24:34 -0500
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:47104
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729166AbfBLVYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+3LeqoG1EJOCORt37AqQAERbadMpPxLSNrP8t8he2c=;
 b=YfZezLtnM+jHsXg9D1f6JQHY3Tqfj7Hv9/e5kjJ2mq0CBNWXgAPg0Tk+n9ftbt7nzGkswmku2rYljhpjpv991avwjTctbnROKXUuq7IGDiEJOAZaQpPZIKGMhI7hE5KmvaEnH76TLFa9gLNP5DvSSC5LqV10SfXxJ8iW2AL19jA=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2705.namprd12.prod.outlook.com (20.176.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 21:24:29 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 21:24:29 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>
Subject: [PATCH 1/2] EDAC/mce_amd: Decode MCA_STATUS[Scrub] bit
Thread-Topic: [PATCH 1/2] EDAC/mce_amd: Decode MCA_STATUS[Scrub] bit
Thread-Index: AQHUwxlWAdlyuX6Hi0OAqSotUPNqWw==
Date:   Tue, 12 Feb 2019 21:24:28 +0000
Message-ID: <20190212212417.107049-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:805:a2::28) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:28::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12c597b7-7603-427f-c473-08d691307868
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2705;
x-ms-traffictypediagnostic: BN7PR12MB2705:
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2705;20:RNkse98KrLr3xz/TisULq7lZtyG/cLtkiO0f8c3FAuzn++YAl+umioCrdFt08O4i/F+MH9EZoREXEAUq/0qZuq8tkTXe9zDUlCF7wNJaPnJkd1RfR/ps76E32xS/rIvgpy8CHsIZwsK+RpKXlIhsyqh/Ewabk7+1N0jHuG3MFGVmIAc/UcFXXUcYddFCSY+iEEXblyAAeKDKwecy3hCLMzMShNytoHm0vFedyvkjMBrNIrshqqHyQs9BBjd483C3
x-microsoft-antispam-prvs: <BN7PR12MB270539D458C48F51DC353F9FF8650@BN7PR12MB2705.namprd12.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(376002)(39860400002)(189003)(199004)(81166006)(81156014)(97736004)(7736002)(4326008)(3846002)(6116002)(6486002)(2906002)(6916009)(1076003)(26005)(71190400001)(8676002)(71200400001)(386003)(6506007)(102836004)(66066001)(2351001)(486006)(72206003)(5640700003)(52116002)(6436002)(8936002)(476003)(478600001)(2616005)(105586002)(186003)(106356001)(25786009)(68736007)(14444005)(36756003)(256004)(54906003)(6512007)(316002)(99286004)(53936002)(14454004)(50226002)(2501003)(305945005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2705;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: csy98IEqW9Qw/dd1xBChT8zrtAA3BIzS2GPoZ/Y+HvYz28CYLtbt0jqkSkcpHsVL6V/J4LQRMc1ns4xs8fKFDKc/NzXamPUsm9GmGR5fg4lG2OFugr3fQShcGlfJfFVKKn0UO76+L+yAZ9mDpqAofMNXAtgFxtFpB/7oMPSlSYwzgj5xedSRau6Y/tNvmmxpPdLNe3wdqSaihCMTuES2SsmtIU5l8takfWRtPDo5pIvDy0CiOuJwSd12J2RGevEpgWWjwSu48Sm2alhkYieyk803eK48jQPctddzbhyUz7YQykKrBOt3wGBeWx0GjRYjgkjiCPo+VQKq7MJPw4UzS2TylACYkHRAGW5WizppRnzR6Vg21Akm/Jmseb8x+WbEaDeLiftU67x5MhtD8ML6k64pT0hhpP0KMGDzvKhAheI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c597b7-7603-427f-c473-08d691307868
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 21:24:27.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Previous AMD systems have had a bit in MCA_STATUS to indicate that an
error was detected on a scrub operation. However, this bit was defined
differently within different banks and families/models.

Starting with Family 17h, MCA_STATUS[40] is either Reserved/Read-as-Zero
or defined as "Scrub", for all MCA banks and CPU models. Therefore, we
can define this bit as the "Scrub" bit.

Define MCA_STATUS[40] as "Scrub" and decode it in the AMD MCE decoding
module for Family 17h and newer systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h | 1 +
 drivers/edac/mce_amd.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 299a38536567..22d05e3835f0 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -48,6 +48,7 @@
 #define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
 #define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred ex=
ception */
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
+#define MCI_STATUS_SCRUB	BIT_ULL(40)  /* Error detected during scrub opera=
tion */
=20
 /*
  * McaX field if set indicates a given bank supports MCA extensions:
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index f286b880f981..b349c22bb386 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1078,6 +1078,9 @@ amd_decode_mce(struct notifier_block *nb, unsigned lo=
ng val, void *data)
 	if (ecc)
 		pr_cont("|%sECC", ((ecc =3D=3D 2) ? "C" : "U"));
=20
+	if (fam >=3D 0x17)
+		pr_cont("|%s", (m->status & MCI_STATUS_SCRUB ? "Scrub" : "-"));
+
 	pr_cont("]: 0x%016llx\n", m->status);
=20
 	if (m->status & MCI_STATUS_ADDRV)
--=20
2.17.1

