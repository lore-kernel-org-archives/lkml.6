Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B85EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1782146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zx8uIj1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBAW4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:56:11 -0500
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:46228
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbfBAW4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBot0fbgOvEZI47Fvy3GXHXaV/0H9SeCPxaDm2SzZw0=;
 b=zx8uIj1YidpR8SlbV+6twjbAxD7rkjjS5bwUifQUgMBy6vmOnv39rhDMMHdjF5qbwROjs91qyN3tSGZqBk6+AARPmVF2uHd24B7qoesCqqrw/ddhunaY9/y9U+uzSvSaqSWROx2fWJCgpC1zoA1bDiYN3Wk8mR+dEN4BaI85EEc=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2628.namprd12.prod.outlook.com (20.176.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 22:55:54 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 22:55:54 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 5/5] EDAC, mce_amd: Print ExtErrorCode and description on a
 single line
Thread-Topic: [PATCH 5/5] EDAC, mce_amd: Print ExtErrorCode and description on
 a single line
Thread-Index: AQHUuoFJQ5YnKMTJLEmBDjZXcu8IOg==
Date:   Fri, 1 Feb 2019 22:55:54 +0000
Message-ID: <20190201225534.8177-6-Yazen.Ghannam@amd.com>
References: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37)
 To BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:28::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2628;20:bBIrNSbrFgqQQovrOYH8Ytht6auNIei0Ri7A31j6ICEnKW6xgX6FxfY1eAKpq+htpAU1+90wb+8fV+ea5f72z8u7nHzplTO30OfjXz50wAwoR5srlbpuXKxdgLkbfPDkwUY6V4myQ/IfG8ufx8Iu4nNcAE7wAQfSvdXYSfpsvA/RAzvd0Ndb+qbQFQn8KSPDEYqkiqRTbiahTpvr1WnffA0LDnxBly0ocMdab4YZ0xiVpRk0deESttK/CQ9MXc5n
x-ms-office365-filtering-correlation-id: 646ad876-0a9f-4c08-d91c-08d688986bbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2628;
x-ms-traffictypediagnostic: BN7PR12MB2628:
x-microsoft-antispam-prvs: <BN7PR12MB2628C16BB310B393DA2D3D34F8920@BN7PR12MB2628.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(186003)(1076003)(2351001)(106356001)(71190400001)(52116002)(256004)(3846002)(105586002)(50226002)(6512007)(6116002)(25786009)(5640700003)(6436002)(66066001)(71200400001)(26005)(478600001)(6486002)(76176011)(316002)(97736004)(2906002)(11346002)(305945005)(7736002)(81166006)(8676002)(81156014)(54906003)(68736007)(446003)(36756003)(6916009)(99286004)(6506007)(2616005)(476003)(386003)(86362001)(102836004)(4326008)(14454004)(72206003)(2501003)(8936002)(53936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2628;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N2oU+XnfxhystpxtKSzNWVH/NFgB4UuV0en3dyowT/rWW7n9rqdH2NvGRvbH4C9ACQ1dZ63o5+nf40AhhG+UvYJ/wLvpoihLKUQqubtpLqXUztOGRJc3dfupxlcMwJTayHwIVXgDNkRrwGSZNbKjYMw0qd2Vxc7U+Fmdi+25uwsCPCw3PfZIurK8T98pGoBzSKM+xVktz3oR0xKH8On4Zq/97H2IaWRBadEsb20wasNckhllCYQwQY+eoyfXvsX/Row4a1IAdZTAeGZIGSDpaCxjpszFZr7apPrnH7yjH8tHsuGhBHHIJ1bCxIxzVuOMKWLHI4X0UvBFtbtzne81JMHJryM1Sp0LX/uRSP9CfFgZfgAb8SY45n/Cw+XQz0SJO32toHNwszr9TrSIx6rBqWnZQ6uBftQNTzJiaF8ZaJw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646ad876-0a9f-4c08-d91c-08d688986bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 22:55:53.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Save a log line by printing the extended error code and the description
on a single line. This is similar to how errors are printed in other
subsystems, e.g. "#, description". If we don't have a valid description
then only the number/code is printed.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/mce_amd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 7e29ceabdf6f..f286b880f981 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -965,13 +965,12 @@ static void decode_smca_error(struct mce *m)
=20
 	ip_name =3D smca_get_long_name(bank_type);
=20
-	pr_emerg(HW_ERR "%s Extended Error Code: %d\n", ip_name, xec);
+	pr_emerg(HW_ERR "%s Ext. Error Code: %d", ip_name, xec);
=20
 	/* Only print the decode of valid error codes */
 	if (xec < smca_mce_descs[bank_type].num_descs &&
 			(hwid->xec_bitmap & BIT_ULL(xec))) {
-		pr_emerg(HW_ERR "%s Error: ", ip_name);
-		pr_cont("%s.\n", smca_mce_descs[bank_type].descs[xec]);
+		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 	}
=20
 	if (bank_type =3D=3D SMCA_UMC && xec =3D=3D 0 && decode_dram_ecc)
--=20
2.17.1

