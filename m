Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C6C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736E222A5
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="fDOcNpvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeLWQQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:16:02 -0500
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:55712
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeLWQQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY+3I/mkdZGGulYetB3YJXDu0K+j9lvlT7KDxvRzNMo=;
 b=fDOcNpvTMe+3qZ5Lg+8v7VYfT5uQLLYBcwktGkWi21H9gEHAbPbkZok4iAi8NnoAN6bkcH3k/3WYiR9fdT18WRf2jX63myYNRXS33w5ZjsuShq2S9//xUmxbCC0Gh7I5RrNdIzKc7xUMH0JRc1scRxdmFzC4R/mqrHKrFVYChvw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1102.namprd22.prod.outlook.com (10.174.169.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:15:55 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:15:55 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "firoz.khan@linaro.org" <firoz.khan@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] mips: system call table generation support
Thread-Topic: [PATCH v5 0/7] mips: system call table generation support
Thread-Index: AQHUksNkwRxr1H0Clkm+GMhsJsm4RaWMkAAA
Date:   Sun, 23 Dec 2018 16:15:54 +0000
Message-ID: <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWXP265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::27) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1102;6:0sED9fAtv8T5dOH4cfKvjk+G49uwWy/lRNyt0GKUho6zzqMrTc52FwWrfpHnckWefCg6DeRortTGRIbXMXCs+XXofnnk73EuYeVSKo1eSZKLatYogtQ8ZlIhYD1lTLjR959nk5I4yW2FMAR0eMiFDaYH7Bs+DxEiK8KZ1N86ol5o8gu7r+YFW1LL10VKsVq/lpmhXx43MlViiDWqnOoZNWveFMUPq9f3DHYnJCAVMDcwXcpyAx007rbm0E1vUDyF9IsZh8W/6F1f1ay+e0FzfMxhXo8ZB7iPH/0hJA6gVc67OHV+7etEjLUdnXKamwJN075izrgHCClOCeaIjPzgestWQrikJEMfxTzQktllhbjz2PbArWXX7JcUUG2ijOhGQM3osqVJwsAwDGqMGND8Pih+AD6f6OJ1Vn3/c8nfHECOvGdr0cb5jYK4nFK+VpWGL1zI7mXNhp6asAogmz/bFw==;5:q4QoQjMj4i2Nla4VsM8LQFlSP8vRns//KGDCfb6HRXdwlkvCt7knMhTuVuKs2aHBCY3kpkqzzOW6SH0ar5g5eUPvTOF71aSk4jvcqem9cUNTtYfv27Z/OdBsCQFL/Y7JedV73n328Z4AEZfakdUWH7j4JuzhaKKJ/qJHBnnVPsk=;7:FrvRXeXawJXAijXs2g2z07Zl4B7nfkX8oRdT0XKaKndImvNEvEIycUEIWlelwPaDaRQxpgd/ca9PSCxW7/cS+Qegf6noA5omFsyhCt1ESuEKwz/9Zo6JNt8Qye0Na6vnlwp5cNKhdP9kxaVlycecaA==
x-ms-office365-filtering-correlation-id: af46f5c7-ac8d-4539-d47d-08d668f1ea27
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1102;
x-ms-traffictypediagnostic: MWHPR2201MB1102:
x-microsoft-antispam-prvs: <MWHPR2201MB110227B44409645DBBFB65D7C1BA0@MWHPR2201MB1102.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1102;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1102;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(376002)(366004)(199004)(189003)(105586002)(6506007)(386003)(6116002)(71190400001)(102836004)(6436002)(229853002)(99286004)(6246003)(76176011)(71200400001)(26005)(33656002)(106356001)(3846002)(6916009)(68736007)(7696005)(52116002)(54906003)(186003)(316002)(5660300001)(97736004)(55016002)(39060400002)(8936002)(2906002)(256004)(14444005)(4326008)(476003)(8676002)(81156014)(81166006)(9686003)(7736002)(6306002)(305945005)(7416002)(74316002)(42882007)(14454004)(446003)(508600001)(53936002)(66066001)(44832011)(25786009)(11346002)(966005)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1102;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B9hUkCFoj82runiZRXOsmXOQ3B9P6Py5S0H/nKqWH0LapjmyvgiMk5JcqRlmcPt1yu9arH08SN5cqToZyIrnrjLjlAVJRxuHKLwQIWWHkabEd61rVVwUlqVqJomOCdBqfDinGqaikNVR/+MfdsszkSRBcSNb11khOvikQ4JqNhhQx9DbahHTFKWX6Zst9XxNjy4LX72urPbeb4qXpgcB/9EHnlUOddfpYmJYzZ0dQJmO49hCgZBUMOZlxAj9RxSIHNNUjuiXpaL5ISvKvuroxrKoTDNajAYZND6mXwz5qgzWHO2g6X/0WmTGxwRMwAyg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af46f5c7-ac8d-4539-d47d-08d668f1ea27
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:15:54.8172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>=20
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>=20
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in
> the syscall.tbl file.
>=20
> Adding a new table entry consisting of:
> - System call number.
> - ABI.
> - System call name.
> - Entry point name.
> - Compat entry name, if required.
>=20
> ARM, s390 and x86 architecuture does exist the sim-
> ilar support. I leverage their implementation to
> come up with a generic solution.
>=20
> I have done the same support for work for alpha,
> ia64, m68k, microblaze, parisc, powerpc, sh, sparc,
> and xtensa. Below mentioned git repository contains
> more details about the workflow.
>=20
> https://github.com/frzkhn/system_call_table_generator/
>=20
> Finally, this is the ground work to solve the Y2038
> issue. We need to add two dozen of system calls to
> solve Y2038 issue. So this patch series will help to
> add new system calls easily by adding new entry in
> the syscall.tbl.
>=20
> Changes since v4:
> - _MIPS_SIM_ABIN64 (suppose to be _MIPS_SIM_NABI64)
> macro rename back to _MIPS_SIM_ABI64 to avoid
> toolchain issue.
>=20
> Changes since v3:
> - rearranged the patches for '64' to 'n64' conver-
> sion.
> - moved the unistd_nr_*.h files to asm/unistd.h
> - modified the *.sh files.
>=20
> Changes since v2:
> - fixed __NR_syscalls assign issue.
>=20
> Changes since v1:
> - optimized/updated the syscall table generation
> scripts.
> - fixed all mixed indentation issues in syscall.tbl.
> - added "comments" in syscall_*.tbl.
> - changed from generic-y to generated-y in Kbuild.
>=20
> Firoz Khan (7):
> mips: add __NR_syscalls along with __NR_Linux_syscalls
> mips: remove unused macros
> mips: rename macros and files from '64' to 'n64'
> mips: add +1 to __NR_syscalls in uapi header
> mips: remove syscall table entries
> mips: add system call table generation support
> mips: generate uapi header and system call table files
>=20
> arch/mips/Makefile                        |    3 +
> arch/mips/include/asm/Kbuild              |    4 +
> arch/mips/include/asm/unistd.h            |   11 +-
> arch/mips/include/uapi/asm/Kbuild         |    6 +
> arch/mips/include/uapi/asm/unistd.h       | 1074 +-----------------------=
-----
> arch/mips/kernel/Makefile                 |    2 +-
> arch/mips/kernel/ftrace.c                 |    8 +-
> arch/mips/kernel/scall32-o32.S            |  391 +----------
> arch/mips/kernel/scall64-64.S             |  444 ------------
> arch/mips/kernel/scall64-n32.S            |  341 +--------
> arch/mips/kernel/scall64-n64.S            |  117 ++++
> arch/mips/kernel/scall64-o32.S            |  379 +---------
> arch/mips/kernel/syscalls/Makefile        |   96 +++
> arch/mips/kernel/syscalls/syscall_n32.tbl |  343 +++++++++
> arch/mips/kernel/syscalls/syscall_n64.tbl |  339 +++++++++
> arch/mips/kernel/syscalls/syscall_o32.tbl |  382 ++++++++++
> arch/mips/kernel/syscalls/syscallhdr.sh   |   37 +
> arch/mips/kernel/syscalls/syscallnr.sh    |   28 +
> arch/mips/kernel/syscalls/syscalltbl.sh   |   36 +
> 19 files changed, 1427 insertions(+), 2614 deletions(-)
> delete mode 100644 arch/mips/kernel/scall64-64.S
> create mode 100644 arch/mips/kernel/scall64-n64.S
> create mode 100644 arch/mips/kernel/syscalls/Makefile
> create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
> create mode 100644 arch/mips/kernel/syscalls/syscall_n64.tbl
> create mode 100644 arch/mips/kernel/syscalls/syscall_o32.tbl
> create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
> create mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
> create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

Series applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
