Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55E22184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WyLYnpl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfB0SH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:07:29 -0500
Received: from mail-eopbgr680088.outbound.protection.outlook.com ([40.107.68.88]:55568
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfB0SH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYxOrP+NsP8Zo5D+U3PF2PJ18jo8NXZJdJgzZqIgU0w=;
 b=WyLYnpl6iLSvUgPRMDHg1RP0Yzd/dtk2Ge9A8j16EVflnABRoZ0tvfH0RIVtE0AjC1y0he1ISh6Lx+NjDosQL8+ENiySfCIDdc3WlZbKK3SbsN+C7axDweRnIokqYm8vAsdZly9Px1bpHNvAJxk2koLkYRhVh62poBb7OCiTWsw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1899.namprd12.prod.outlook.com (10.175.88.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 18:07:24 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::cd0a:9b15:b5d4:9ad1]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::cd0a:9b15:b5d4:9ad1%2]) with mapi id 15.20.1665.015; Wed, 27 Feb 2019
 18:07:24 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUwOxcI2L49msmtEaXEKYkdDAhPaX0DExQ
Date:   Wed, 27 Feb 2019 18:07:23 +0000
Message-ID: <DM5PR12MB24718574A11023A7BFE57CDC95740@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3569e77-cd45-4c6d-28b6-08d69cde6cd3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1899;
x-ms-traffictypediagnostic: DM5PR12MB1899:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1899;20:zHWPgfwSMuxze0NWMuVLXJN4UO6Eu8+Cj4BUQHLhS27ks2QlhfxMguBOPyd67tpyekx8s4cR4wQ+HNkp2drmDfWdgv7EzTjQAD4Ou0sCRgpKmLQpaMAKadYMdipunvv1URC8NkofEpgCcEUmDxWJk6GfrOXfKXEfITrK3nk8WvC2uukkDAcwdyEUcagejHLOWaayWz7/BlOAq6FEeRoBkl5x9/TMcp43DBf0tKziG2F8mzySRkfv5L0aO2ycKG4r
x-microsoft-antispam-prvs: <DM5PR12MB1899937D8F81F6D2F77AFA8795740@DM5PR12MB1899.namprd12.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(13464003)(54534003)(305945005)(7736002)(4326008)(33656002)(229853002)(6436002)(3846002)(102836004)(7416002)(105586002)(106356001)(26005)(6116002)(74316002)(81156014)(53546011)(6506007)(8676002)(8936002)(81166006)(97736004)(6246003)(256004)(68736007)(476003)(110136005)(71200400001)(486006)(186003)(14444005)(14454004)(53936002)(76176011)(5660300002)(478600001)(446003)(7696005)(25786009)(72206003)(99286004)(966005)(2906002)(52536013)(11346002)(66066001)(71190400001)(316002)(6306002)(86362001)(55016002)(9686003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1899;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3kXgUgHK3/jGwaPvjGbIt0U0z5X+4bKOncd+32+VynQKenwpga8mK8vLFnzaQe5zzNJ3mqNyyINkUIez1awRngrOW9TrTMlNAKLWS9aYpZlow+DBJWWR/xLTK37drvn6uwdSQwa8HeUyG/8oic99xEwtAKaLHJBUXJD20k+6QauqrV4BEJFofWnWqYZYvhW4jlnyr+bpbIfu6cymXbuK+PKPCLBkF2ZW4U+vTWrJ98LoaHDuH2edZUYb+MHmVuP6r+vUIir26lAOkfQkSV8JOar0qHnnbwaUTUMX+E4m7PzCbcP9n9BFz8ioMqcqWfRANlkIYPkElszf09z/H7fVZYMymksf5FWy7PEnK5avymPfnGD7I0RhpMBIhNbfS78DVby3HuRdb0nPc/mZArvq6RPn6bc3ibqPYpmqjd8m9yw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3569e77-cd45-4c6d-28b6-08d69cde6cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 18:07:24.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches look good. Tested v7 again on AMD system. Thanks


> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Saturday, February 9, 2019 8:50 PM
> To: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin
> <hpa@zytor.com>; Tony Luck <tony.luck@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Ravi V Shankar <ravi.v.shankar@intel.com>;
> Xiaochen Shen <xiaochen.shen@intel.com>; Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>; Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com>; Moger, Babu <Babu.Moger@amd.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; Fenghua Yu
> <fenghua.yu@intel.com>
> Subject: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
>=20
> With more and more resctrl features are being added by Intel, AMD
> and ARM, a test tool is becoming more and more useful to validate
> that both hardware and software functionalities work as expected.
>=20
> We introduce resctrl selftest to cover resctrl features on both
> X86 and ARM architectures. It first implements MBM (Memory Bandwidth
> Monitoring), MBA (Memory Bandwidth Allocation), L3 CAT (Cache Allocation
> Technology), and CQM (Cache QoS Monitoring)  tests. We can enhance
> the selftest tool to include more functionality tests in future.
>=20
> The tool has been tested on both Intel RDT and AMD QoS.
>=20
> There is an existing resctrl test suite 'intel_cmt_cat'. But the major
> purpose of the tool is to test Intel(R) RDT hardware via writing and
> reading MSR registers. It does access resctrl file system; but the
> functionalities are very limited. And it doesn't support automatic test
> and a lot of manual verifications are involved.
>=20
> So the selftest tool we are introducing here provides a convenient
> tool which does automatic resctrl testing, is easily available in kernel
> tree, and will be extended to AMD QoS and ARM MPAM.
>=20
> The selftest tool is in tools/testing/selftests/resctrl in order to have
> generic test code for all architectures.
>=20
> Changelog:
> v7:
> - Fix a few warnings when compiling patches separately, pointed by Babu
>=20
> v6:
> - Fix a benchmark reading optimized out issue in newer GCC.
> - Fix a few coding style issues.
> - Re-arrange code among patches to make cleaner code. No change in
> patches
> structure.
>=20
> v5:
> - Based the v4 patches submitted by Fenghua Yu and added changes to
> support
>   AMD.
> - Changed the function name get_sock_num to get_resource_id. Intel uses
>   socket number for schemata and AMD uses l3 index id. To generalize,
>   changed the function name to get_resource_id.
> - Added the code to detect vendor.
> - Disabled the few tests for AMD where the test results are not clear.
>   Also AMD does not have IMC.
> - Fixed few compile issues.
> - Some cleanup to make each patch independent.
> - Tested the patches on AMD system. Fenghua, Need your help to test on
>   Intel box. Please feel free to change and resubmit if something
>    broken.
> - Here is the link for previous version.
>   https://lore.kernel.org/lkml/1545438038-75107-1-git-send-email-
> fenghua.yu=3D
> @intel.com/
>=20
> v4:
> - address comments from Balu and Randy
> - Add CAT and CQM tests
>=20
> v3:
> - Change code based on comments from Babu Moger
> - Remove some unnessary code and use pipe to communicate b/w processes
>=20
> v2:
> - Change code based on comments from Babu Moger
> - Clean up other places.
>=20
> Arshiya Hayatkhan Pathan (4):
>   selftests/resctrl: Add MBM test
>   selftests/resctrl: Add MBA test
>   selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest
>   selftests/resctrl: Add Cache Allocation Technology (CAT) selftest
>=20
> Babu Moger (3):
>   selftests/resctrl: Add vendor detection mechanism
>   selftests/resctrl: Use cache index3 id for AMD schemata masks
>   selftests/resctrl: Disable MBA and MBM tests for AMD
>=20
> Fenghua Yu (2):
>   selftests/resctrl: Add README for resctrl tests
>   selftests/resctrl: Add the test in MAINTAINERS
>=20
> Sai Praneeth Prakhya (4):
>   selftests/resctrl: Add basic resctrl file system operations and data
>   selftests/resctrl: Read memory bandwidth from perf IMC counter and
>     from resctrl file system
>   selftests/resctrl: Add callback to start a benchmark
>   selftests/resctrl: Add built in benchmark
>=20
>  MAINTAINERS                                     |   1 +
>  tools/testing/selftests/resctrl/Makefile        |  16 +
>  tools/testing/selftests/resctrl/README          |  54 ++
>  tools/testing/selftests/resctrl/cache.c         | 274 +++++++++
>  tools/testing/selftests/resctrl/cat_test.c      | 242 ++++++++
>  tools/testing/selftests/resctrl/cqm_test.c      | 173 ++++++
>  tools/testing/selftests/resctrl/fill_buf.c      | 210 +++++++
>  tools/testing/selftests/resctrl/mba_test.c      | 178 ++++++
>  tools/testing/selftests/resctrl/mbm_test.c      | 150 +++++
>  tools/testing/selftests/resctrl/resctrl.h       | 117 ++++
>  tools/testing/selftests/resctrl/resctrl_tests.c | 238 ++++++++
>  tools/testing/selftests/resctrl/resctrl_val.c   | 723
> ++++++++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrlfs.c     | 668
> ++++++++++++++++++++++
>  13 files changed, 3044 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/Makefile
>  create mode 100644 tools/testing/selftests/resctrl/README
>  create mode 100644 tools/testing/selftests/resctrl/cache.c
>  create mode 100644 tools/testing/selftests/resctrl/cat_test.c
>  create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
>  create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
>  create mode 100644 tools/testing/selftests/resctrl/mba_test.c
>  create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrl.h
>  create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c
>=20
> --
> 2.7.4

