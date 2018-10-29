Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536C6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B02082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y4Iurtg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7B02082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbeJ3Hrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:47:49 -0400
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com ([104.47.36.63]:25653
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730358AbeJ3Hrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0/+XMjNjgNrOUcmU0a0/CGIWnCv2drh9VmfVNzzXYo=;
 b=Y4Iurtg167R32PdVg6kMHey9YEETXNkhlM+a4cgBPeYoit0omPKhVDquOr6uPUFUXbiPumLzj4I9u7kgRK5g79NfN6rg7k1doH9IRLciVgBsMZBfKhMjc+trB2aaLlm+F25tvYeEjCt6ql16cvmtfKSnJEraff5067iJI5rtj68=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2501.namprd12.prod.outlook.com (52.132.141.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Mon, 29 Oct 2018 22:56:53 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 22:56:53 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH v2 0/8] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUbLgDFuRQTxZV8kW63ypYZqpqGKU22sTw
Date:   Mon, 29 Oct 2018 22:56:53 +0000
Message-ID: <DM5PR12MB2471ECEC7C2402484F138F6A95F30@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1540508826-144502-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1540508826-144502-1-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:1c3a:d3a:dc00:d869]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2501;20:SfrvuwREmSMVpQjcfmS2kDfTR06kg6Gun5bhMMYerSkiZGTMEutTLyssRyMr6lI1w9fdzxPyEGZdJ/qisenoi+ogB6N0C/uGn6YPbvPNefFaf5/wxkYoxsxM+6sLtJcyXBpZCBj6FtnEztTSoeGLFZo4o+u/eMuBLaUGfUSvgz0Qym3c7eDu1X6y0CufUoV+IKIxW9sRhMPHBVINPrlz9Xav28yIxtLtbb7U+6IovgqpTUa9CssCB+Q2uAc3R7aM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b2a535f3-ae31-448a-813a-08d63df1d1e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2501;
x-ms-traffictypediagnostic: DM5PR12MB2501:
x-microsoft-antispam-prvs: <DM5PR12MB25011F12ED74B6889EC36F6C95F30@DM5PR12MB2501.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(72170088055959)(228905959029699)(767451399110)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB2501;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2501;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(54534003)(13464003)(486006)(229853002)(14454004)(8936002)(71190400001)(71200400001)(68736007)(8676002)(478600001)(2900100001)(81156014)(256004)(14444005)(6116002)(99286004)(186003)(6506007)(97736004)(102836004)(72206003)(76176011)(81166006)(476003)(11346002)(446003)(46003)(2906002)(7696005)(53546011)(106356001)(6246003)(74316002)(9686003)(86362001)(6436002)(55016002)(110136005)(305945005)(5250100002)(7416002)(53936002)(7736002)(5660300001)(316002)(33656002)(25786009)(105586002)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2501;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yMoxFglDqRIGr3pKQ5D/9T0XoBXBy5C84v16F2AremlrMDnAFGAihv8Adunu1+N9rQfqhnibFBI9wmwwEJPznz59te93ibZ1eWXeNKB0nLCADuOa916GRiSVsppf2l2cYDOk+7RR4qXPckB6Upq6/owSdCHZFez29A8aEeS2chpyQ1WpEjGvXScfBekq1tBINRqZY6IK97SOqzK1rAoqhzOksdwRoUmRzXxS2X+0rKn9kX6TMOTvsGWbjTIuphIvXA1coG4O+Y9gaMNRremshCs1MArGxYo5ct3QezZqocaMeUVWE88r3xdRGjel9I/23Y1456EpyRFeA2290xKH+C1FHaQWwl8AyYdu6JUdDrQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a535f3-ae31-448a-813a-08d63df1d1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 22:56:53.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,=20

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Fenghua Yu
> Sent: Thursday, October 25, 2018 6:07 PM
> To: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; H Peter Anvin <hpa@zytor.com>; Tony Luck
> <tony.luck@intel.com>; Peter Zijlstra <peterz@infradead.org>; Reinette
> Chatre <reinette.chatre@intel.com>; Moger, Babu
> <Babu.Moger@amd.com>; James Morse <james.morse@arm.com>; Ravi V
> Shankar <ravi.v.shankar@intel.com>; Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com>; Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; Fenghua Yu
> <fenghua.yu@intel.com>
> Subject: [PATCH v2 0/8] selftests/resctrl: Add resctrl selftest
>=20
> With more and more resctrl features are being added by Intel, AMD
> and ARM, a test tool is becoming more and more useful to validate
> that both hardware and software functionalities work as expected.
>=20
> We introduce resctrl selftest to cover resctrl features on both
> X86 and ARM architectures. It first implements MBM (Memory Bandwidth
> Monitoring) and MBA (Memory Bandwidth Allocation) tests. We can
> enhance
> the selftest tool to include more functionality tests in future.
>=20
> There is an existing resctrl test suit 'intel_cmt_cat'. But the major
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
> v2:
> - Change code based on comments from Babu Moger
> - Clean up other places.
>=20
> Arshiya Hayatkhan Pathan (2):
>   selftests/resctrl: Add mbm test
>   selftests/resctrl: Add mba test

I suggest to use MBM and MBA(all caps) while talking about these features. =
 Same applies in each individual patches.

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
>  tools/testing/selftests/resctrl/README          |  53 ++
>  tools/testing/selftests/resctrl/fill_buf.c      | 175 ++++++
>  tools/testing/selftests/resctrl/mba_test.c      | 175 ++++++
>  tools/testing/selftests/resctrl/mbm_test.c      | 143 +++++
>  tools/testing/selftests/resctrl/membw.c         | 678
> ++++++++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl.h       |  88 +++
>  tools/testing/selftests/resctrl/resctrl_tests.c | 138 +++++
>  tools/testing/selftests/resctrl/resctrlfs.c     | 465 ++++++++++++++++
>  10 files changed, 1932 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/Makefile
>  create mode 100644 tools/testing/selftests/resctrl/README
>  create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
>  create mode 100644 tools/testing/selftests/resctrl/mba_test.c
>  create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
>  create mode 100644 tools/testing/selftests/resctrl/membw.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrl.h
>  create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
>  create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c
>=20
> --
> 2.5.0

