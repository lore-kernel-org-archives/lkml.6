Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4F9C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2B52087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fqPum37O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfARS1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:08 -0500
Received: from mail-eopbgr680080.outbound.protection.outlook.com ([40.107.68.80]:40721
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728454AbfARS1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPpJb9U4YKQTIcaQVmyJZsiS/8WhTB2r1Q5JuXtM4lw=;
 b=fqPum37Owj3B/osL7yGH8yD40qbl0YJi9n1IVpAnuJJeqqZExv8fs7qIzAYhSi0qJw9toroWtVrU6KirqCVcNV1XT+61ALQ1KPcFnkXCQrkPRQgYN0EDSSw9ZlO5sj4YVWvsTrup51uZIZbjmgkQsvxWSr6zejc5R+xbC4W/If8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1276.namprd12.prod.outlook.com (10.168.237.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 18:27:01 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:01 +0000
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
Subject: [PATCH v5 00/13] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH v5 00/13] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUr1tntay3ljQsrE+k59/cQMyLeg==
Date:   Fri, 18 Jan 2019 18:27:01 +0000
Message-ID: <20190118182646.16594-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0014.namprd04.prod.outlook.com
 (2603:10b6:803:21::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1276;20:pyqtWsNbWNFw3TNlzskl6fd2/Cbad/0jVHQNba+MIJTtLugWRVcnKFoC++OxNXZ6VOqNH6KX+zNlIgMHdsryvJxdvnKVWd24xg6V1uaW7s7sdQq1zm/TkePvqhbVslpHQhpEa73Lrx24PDYvLmqIu3KdMHuY6oV9esL6EKVRY6vs5EdK+gVZ5hyknhsD413miFyJauSWFeF8/sL/95fpxL+4BXzxstdvowx7NPZMuiIM0Z7p7maFUXchgorJmkeB
x-ms-office365-filtering-correlation-id: ffe9abc5-b685-41ee-c1e1-08d67d7289ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1276;
x-ms-traffictypediagnostic: DM5PR12MB1276:
x-microsoft-antispam-prvs: <DM5PR12MB12762E08F9A64547E1785F0B959C0@DM5PR12MB1276.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(54534003)(14444005)(305945005)(3846002)(53936002)(6512007)(54906003)(110136005)(4326008)(99286004)(102836004)(6486002)(8676002)(25786009)(476003)(6306002)(7736002)(316002)(6436002)(2616005)(106356001)(486006)(386003)(68736007)(186003)(2906002)(50226002)(81156014)(81166006)(52116002)(26005)(71200400001)(6506007)(97736004)(478600001)(8936002)(2501003)(71190400001)(72206003)(966005)(1076003)(256004)(66066001)(7416002)(2201001)(105586002)(36756003)(86362001)(6116002)(14454004)(5660300001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1276;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iyN2R1Zu2d2ni7PmpdAgFuYaLWquIgi3gg+3bkFvLltNvfuQRa9iAntMbGb2TgSQXROhL2bZhcRIo4pOBHCsf7YZi4kiRBRYVTtbcu+iiOme5l8H2+MQJMcPEQct5fF4ALLjdduaMoMnUveIMUZganvIBU1QwZNpfB2UfCsDp6unI1fcGzJ88luuUtbfss7UxVfE77oPyOb25Tf5h/oAY3tibjkIhgZ9imOTiof6r9obExixwsAN+qad6nzcfho8pWwHCQKWXvtoF24vEs3JoLuBWIMTgIBVZGMP10H+s87NORUwrZObZjIYev8Nyf5/MP3GX0s6UpXHkGApnZRv88v6BN/9aKntZTyy4E9tT5sofAOToMz4/TAEDtGI0MowRmQP9EQg8AQg7j/wPlaJ0OLA5h1HQf79L/4je1KD2Mk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe9abc5-b685-41ee-c1e1-08d67d7289ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:00.3151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With more and more resctrl features are being added by Intel, AMD
and ARM, a test tool is becoming more and more useful to validate
that both hardware and software functionalities work as expected.

We introduce resctrl selftest to cover resctrl features on both
X86 and ARM architectures. It first implements MBM (Memory Bandwidth
Monitoring) and MBA (Memory Bandwidth Allocation) tests. We can enhance
the selftest tool to include more functionality tests in future.

There is an existing resctrl test suite 'intel_cmt_cat'. But the major
purpose of the tool is to test Intel(R) RDT hardware via writing and
reading MSR registers. It does access resctrl file system; but the
functionalities are very limited. And it doesn't support automatic test
and a lot of manual verifications are involved.

So the selftest tool we are introducing here provides a convenient
tool which does automatic resctrl testing, is easily available in kernel
tree, and will be extended to AMD QoS and ARM MPAM.

The selftest tool is in tools/testing/selftests/resctrl in order to have
generic test code for all architectures.

Changelog:
v5:=20
- Based the v4 patches submitted by Fenghua Yu and added changes to support
  AMD.
- Changed the function name get_sock_num to get_resource_id. Intel uses
  socket number for schemata and AMD uses l3 index id. To generalize change=
d
  the function name to get_resource_id.
- Added the code to detect vendor.
- Disabled the few tests for AMD where the test results are not clear.
  Also AMD does not have IMC.
- Fixed few compile issues.
- Some cleanup to make each patch independent.
- Tested the patches on AMD system. Fenghua, Need your help to test on
  Intel box. Please feel free to change and resubmit if something
   broken.
- Here is the link for previous version.
  https://lore.kernel.org/lkml/1545438038-75107-1-git-send-email-fenghua.yu=
@intel.com/

v4:=20
- address comments from Balu and Randy
- Add CAT and CQM tests

v3:
- Change code based on comments from Babu Moger
- Remove some unnessary code and use pipe to communicate b/w processes

v2:
- Change code based on comments from Babu Moger
- Clean up other places.


Arshiya Hayatkhan Pathan (4):
  selftests/resctrl: Add MBM test
  selftests/resctrl: Add MBA test
  selftests/resctrl Add Cache QoS Monitoring (CQM) selftest
  selftests/resctrl: Add Cache Allocation Technology (CAT) selftest

Babu Moger (3):
  selftests/resctrl: Add vendor detection mechanism
  selftests/resctrl: Use cache index3 id for AMD schemata masks
  selftests/resctrl: Disable MBA and MBM tests for AMD

Fenghua Yu (2):
  selftests/resctrl: Add README for resctrl tests
  selftests/resctrl: Add the test in MAINTAINERS

Sai Praneeth Prakhya (4):
  selftests/resctrl: Add basic resctrl file system operations and data
  selftests/resctrl: Read memory bandwidth from perf IMC counter and
    from resctrl file system
  selftests/resctrl: Add callback to start a benchmark
  selftests/resctrl: Add built in benchmark

 MAINTAINERS                                     |   1 +
 tools/testing/selftests/resctrl/Makefile        |  16 +
 tools/testing/selftests/resctrl/README          |  53 ++
 tools/testing/selftests/resctrl/cache.c         | 275 +++++++++
 tools/testing/selftests/resctrl/cat_test.c      | 243 ++++++++
 tools/testing/selftests/resctrl/cqm_test.c      | 169 ++++++
 tools/testing/selftests/resctrl/fill_buf.c      | 198 +++++++
 tools/testing/selftests/resctrl/mba_test.c      | 174 ++++++
 tools/testing/selftests/resctrl/mbm_test.c      | 146 +++++
 tools/testing/selftests/resctrl/resctrl.h       | 117 ++++
 tools/testing/selftests/resctrl/resctrl_tests.c | 243 ++++++++
 tools/testing/selftests/resctrl/resctrl_val.c   | 727 ++++++++++++++++++++=
++++
 tools/testing/selftests/resctrl/resctrlfs.c     | 649 ++++++++++++++++++++=
+
 13 files changed, 3011 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/README
 create mode 100644 tools/testing/selftests/resctrl/cache.c
 create mode 100644 tools/testing/selftests/resctrl/cat_test.c
 create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c
 create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

--=20
1.8.3.1

