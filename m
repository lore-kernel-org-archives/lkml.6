Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B9DC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9CC2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q3KOSSMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfARS10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:26 -0500
Received: from mail-eopbgr790057.outbound.protection.outlook.com ([40.107.79.57]:56814
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729119AbfARS1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o85UoV6APNnSm8CUo3/lm7UUT3Wz0xToPBBvSe+Acw=;
 b=Q3KOSSMCMaTCEpyg1uqMn0jFrL6XaSu2gfYvVvLCEV1RGaV/bAhLByweyVhkA30o4gQD0oA7oRBi0cvbZpnd9VDLieRuSTf84Gup05FSwriHXvu9MfFuvh5OYcgJQfFhfytJ9bzE5e7yjPkt2jg9YuYVD1bATcHjz4XuWp5i/4o=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1737.namprd12.prod.outlook.com (10.175.89.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 18:27:18 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:18 +0000
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
Subject: [PATCH v5 13/13] selftests/resctrl: Disable MBA and MBM tests for AMD
Thread-Topic: [PATCH v5 13/13] selftests/resctrl: Disable MBA and MBM tests
 for AMD
Thread-Index: AQHUr1txhAdfIPGEpEyiEQVQaYWKQA==
Date:   Fri, 18 Jan 2019 18:27:17 +0000
Message-ID: <20190118182646.16594-14-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1737;20:iM/39GoVtMxh3QmwIAsK7kCmvzt2r6dWtSiXfiuD9lzyHOuzGVv/J9qCmxXxNNfuTbrEUHsi9mS6RRKD30/Hlc1n4g4/+AqaonH2a4Vtf56ePvQV42vU/AlTbu2g3UoXwiXFMn6LQfkn8vxuIJl9EuOnMb2hWuIOJ6AOVPQTQbfnWAKV3bSSqGSuDRSWEfU+zYoohswIi6D38tFMnQPTHZNw4KVya1CKokqyfpLLrD6Cvf1GF1J2jaN53IkrlXjw
x-ms-office365-filtering-correlation-id: 1523d5ed-d48a-4343-6f85-08d67d7293b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1737;
x-ms-traffictypediagnostic: DM5PR12MB1737:
x-microsoft-antispam-prvs: <DM5PR12MB1737148CAA7BB6044EC96B00959C0@DM5PR12MB1737.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(54906003)(50226002)(6512007)(8676002)(6436002)(99286004)(1076003)(110136005)(53936002)(6486002)(7416002)(25786009)(8936002)(36756003)(26005)(4326008)(186003)(81156014)(316002)(6116002)(81166006)(3846002)(6346003)(476003)(71200400001)(105586002)(2616005)(68736007)(2906002)(71190400001)(14454004)(106356001)(486006)(2201001)(6506007)(5660300001)(97736004)(102836004)(72206003)(256004)(11346002)(2501003)(7736002)(86362001)(52116002)(66066001)(478600001)(305945005)(76176011)(386003)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1737;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: deGcOQcLm2BleILtwQGibxGKV6m3AP5xeymp+aYj/rrw6P32AC+r1CDwxYK84K4JxgfBkTkOCvPvDO3Uek4vBMDWG+EEI/fnOaFT9niR3vKM7MccF8b5vG6Tra62Bel6KUlhCC8N+X3wnlQE2s1f1zEZd78xNlE5KI2Oh07m45Y+5UovsgSIjSUlFLMkLgJcMs8+L44KDFz+iOiKCLL/CSdrIjxUBIhMvGgjsZAXYSDMYBsHIXAyNCdu/Mq7Z4LX2qZn3mH1EYM2Vj494yPIq8G4OkPokqpSxkJ/pess0EGR9f/t4MRlu4r0YLLFCsOfb99SNGKj9mWrJICtwM133NagDqa7sPWxp3vHJK1/KSYuTFI1GLzLNghuD2TeB4uTiO5KBfo4hHZmpAlzNVcxRH35z8x0mvU6tXl2hgGJsI4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1523d5ed-d48a-4343-6f85-08d67d7293b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:16.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, disable MBA and MBM tests for AMD. Deciding test pass/fail
is not clear right now. We can enable when we have some clarity.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/cat_test.c      | 2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/sel=
ftests/resctrl/cat_test.c
index 57d501d..badf2d1 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -69,7 +69,7 @@ static void show_cache_info(unsigned long sum_llc_perf_mi=
ss, int no_of_bits,
 	printf("Allocated cache lines: %lu \t", allocated_cache_lines);
 	printf("Percent diff=3D%d \t", abs((int)diff_percent));
=20
-	if (abs((int)diff_percent) > MAX_DIFF_PERCENT)
+	if (genuine_intel && (abs((int)diff_percent) > MAX_DIFF_PERCENT))
 		printf("Failed\n");
 	else
 		printf("Passed\n");
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testin=
g/selftests/resctrl/resctrl_tests.c
index e8cbcd5..b12f2c5 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -202,7 +202,7 @@ int main(int argc, char **argv)
 	sprintf(bw_report, "reads");
 	sprintf(bm_type, "fill_buf");
=20
-	if (mbm_test) {
+	if (genuine_intel && mbm_test) {
 		printf("\nMBM BW Change Starting..\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "mbm");
@@ -212,7 +212,7 @@ int main(int argc, char **argv)
 		mbm_test_cleanup();
 	}
=20
-	if (mba_test) {
+	if (genuine_intel && mba_test) {
 		printf("\nMBA Schemata Change Starting..\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "mba");
--=20
1.8.3.1

