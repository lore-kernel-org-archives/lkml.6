Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEDCC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB5C20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hGQ1cGKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfARS1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:50 -0500
Received: from mail-eopbgr790057.outbound.protection.outlook.com ([40.107.79.57]:56814
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729111AbfARS1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeLLPCNQ7S0sKk0Hu1EPMfRY62uAivpPwRIiM56e7UA=;
 b=hGQ1cGKkfI/IG8053aJboq6ugLLs3WY9KM40Zb0pf3+K997BVcdtoFGXpU1u7MdAt83HpsjHIa/Qoj2sTgKUvdjlzAITWvkrw9KWDE9lMO3hUFLIOMGHPpyH4cDYkqTo3hJWFKisqBmEHZiFpda8Ml1xRfBl9KVDybEMWrKitZA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1737.namprd12.prod.outlook.com (10.175.89.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 18:27:16 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:16 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "sai.praneeth.prakhya@intel.com" <sai.praneeth.prakhya@intel.com>,
        "arshiya.hayatkhan.pathan@intel.com" 
        <arshiya.hayatkhan.pathan@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: [PATCH v5 12/13] selftests/resctrl: Use cache index3 id for AMD
 schemata masks
Thread-Topic: [PATCH v5 12/13] selftests/resctrl: Use cache index3 id for AMD
 schemata masks
Thread-Index: AQHUr1twpCulb6PvAkeyosiniRhTow==
Date:   Fri, 18 Jan 2019 18:27:16 +0000
Message-ID: <20190118182646.16594-13-babu.moger@amd.com>
References: <20190118182646.16594-1-babu.moger@amd.com>
In-Reply-To: <20190118182646.16594-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0014.namprd04.prod.outlook.com
 (2603:10b6:803:21::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1737;20:XZ69fp1UeQxNPkuLM0pDKz1nFYNGKyvr8/BI0XtTODNmFusfrwADA7d3ThUJXLTCeRCkJ5DLlAg2qz0w/Acdpnadd85UwnZt6C5KJXSj7/6lx/cqJUYD/6m6A2KPkpMkY7aAp3n0xfqFH8Lc8a7IY7OLKqTmLZwFx+mNVJWz0s5qLNcAqmpPfKdyby0UpdtVmasrlk2HdXH8BbWocvyKBls2aCoS+3y4wU51o5fv4O0rWbS1pPM3SmmwlUfWKkhm
x-ms-office365-filtering-correlation-id: aebba7bb-6b26-41ef-b2ce-08d67d7292f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1737;
x-ms-traffictypediagnostic: DM5PR12MB1737:
x-microsoft-antispam-prvs: <DM5PR12MB1737CBC97A5E5E3E11C1DB06959C0@DM5PR12MB1737.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(54906003)(50226002)(6512007)(8676002)(6436002)(99286004)(1076003)(110136005)(53936002)(6486002)(7416002)(25786009)(8936002)(36756003)(26005)(4326008)(186003)(81156014)(316002)(6116002)(81166006)(3846002)(6346003)(476003)(71200400001)(105586002)(2616005)(68736007)(2906002)(71190400001)(14454004)(106356001)(486006)(2201001)(14444005)(6506007)(5660300001)(97736004)(102836004)(72206003)(256004)(11346002)(2501003)(7736002)(4744005)(86362001)(52116002)(66066001)(478600001)(305945005)(76176011)(386003)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1737;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bOiwqJAYRAY/rtFWCJtMr9hhjgysze1JtOGoZgRT+TFE+HiNSRMo4hCeOBZGnkT0bDjPHUB9pj/D2szdVguiUSmTM+JueYhupbqzrB6iNWsWPzHrNAOhmdNtAuW9yxypTuyMSVwIFtYwIZWRYDi3xqbzoSWIJ2CA9hXJhkeO/8UILQcjp2YakACyyBHPKcXgaCFS2zEUgvqHeDjjjq2gZSldvpmXI8eKYEhKM3/0c1HWix0Snz8V0PZ5UwJIQwZVcjLZDYa1YjoXMVJj/qZOrmu/3rq2HIittZ/7u03F7fNrA+bYAqqMtecKzuSPyu3VRTSbbmYNg5evKMniguNtgWDsds24qp9f9G5LB6DD5wSWQfRvCzpnffNcv12hHScACfE0+zbLeFGuowJ/EnJ/yUMquiVqYHPhU0SCmIx4djo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebba7bb-6b26-41ef-b2ce-08d67d7292f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:15.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD uses the cache l3 boundary for schemata masks. Update it accordigly.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/se=
lftests/resctrl/resctrlfs.c
index 146a10e..15cda1b 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -103,8 +103,13 @@ int get_resource_id(int cpu_no, int *resource_id)
 	char phys_pkg_path[1024];
 	FILE *fp;
=20
-	sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
-		PHYS_ID_PATH, cpu_no);
+	if (authentic_amd)
+		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
+                        PHYS_ID_PATH, cpu_no);
+	else
+		sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
+			PHYS_ID_PATH, cpu_no);
+
 	fp =3D fopen(phys_pkg_path, "r");
 	if (!fp) {
 		perror("Failed to open physical_package_id");
--=20
1.8.3.1

