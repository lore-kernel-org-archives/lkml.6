Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F25C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0205420663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="DXNH/T0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0205420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeK0ElD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:41:03 -0500
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:59835
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbeK0ElD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Dq2hyadddzeD8uDfWpaYegz6998mIDlz42NZvWmMGc=;
 b=DXNH/T0P89t3jDc1MqTt3AOa12lbaYN0nVrmlAPZ50w+SKxa8QrHbbL7vMNRGNXiivMQZWBew2xJb3RqnAAcI2jvyPn5Lnx4USAP8wi5XcuDSrEKkhvqPEsllYPXlI+8EUeweZ/h8v+WDdGQ/0UGCR7IK7SE2Pu67SmZiqHNvFA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4229.namprd05.prod.outlook.com (52.135.200.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.13; Mon, 26 Nov 2018 17:46:10 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 17:46:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v6 00/10] x86/alternative: text_poke() fixes
Thread-Topic: [PATCH v6 00/10] x86/alternative: text_poke() fixes
Thread-Index: AQHUgU3HyrGS5K6YtUuO9VPXQ8unEaVh5CkAgAB5DQA=
Date:   Mon, 26 Nov 2018 17:46:09 +0000
Message-ID: <60FD8780-DA8B-421F-A136-4CFB6271DD6D@vmware.com>
References: <20181120203545.34928-1-namit@vmware.com>
 <20181126103252.GN2113@hirez.programming.kicks-ass.net>
In-Reply-To: <20181126103252.GN2113@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4229;20:nEfMCSUAnaKTj8mRoWK9bGSBmnoyvvKekx7z7miwEvE8GuVu5cVQq2lL7zXRIFxUhd8MAYpaQbhZo9q1cBZAcM10J/tDzAEyHNn4fzTLgFpOBg1XHxkG4Xj7p2s4PcsUYxAeD8ds9tZyZ9CnMJcy2W0R8A7//qR58G4JkhX9/w0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0d0247d2-9c18-4782-b781-08d653c70ce1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4229;
x-ms-traffictypediagnostic: BYAPR05MB4229:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB422926FF1304CC9C0AD9D193D0D70@BYAPR05MB4229.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4229;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4229;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(86362001)(106356001)(81166006)(8936002)(39060400002)(33656002)(4326008)(6506007)(14454004)(81156014)(476003)(2616005)(8676002)(102836004)(53546011)(25786009)(486006)(11346002)(446003)(2906002)(5660300001)(26005)(6512007)(76176011)(316002)(105586002)(6246003)(7416002)(305945005)(7736002)(186003)(53936002)(6486002)(229853002)(6916009)(97736004)(256004)(36756003)(6116002)(82746002)(3846002)(14444005)(83716004)(71190400001)(66066001)(71200400001)(478600001)(68736007)(54906003)(99286004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4229;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NW0PWFFCdZ+o6KoY4bnQNPPhIGTZkvcQyeF+r7bX/Xh+VvVfD/dRul4/VZpxPgaUFBl85W1cJDQF2Y2XHCT1GrEsQUVxEUUsKpsIZ04nGTCFfnQ+HyR1BTrioP5Y+c+M60siFFlqfBrSCREkMLufk2Ipt/XwOSX+GH0GMdYyVbkg8EDdb6OM7C9tciLPoYCWCOT1iLl0jXAwzqaNSarb+d15lbQbWSfBM0gZFxt046tjRp7ja9PPFAMend/IT8lc9eRySowZeK8WICvPQBQliZH6RLoHnJiRaubSUohhB/2RC5GPe09pqyUGgTqlG2a6iVR6GVALLa2LZKcFbQXhoeOOnxP5AprcYyueq31IeZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA46F7EED43CB74D849ACEBF1D88012E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0247d2-9c18-4782-b781-08d653c70ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 17:46:09.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 26, 2018, at 2:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Nov 20, 2018 at 12:35:35PM -0800, Nadav Amit wrote:
>=20
>> Nadav Amit (9):
>>  Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
>>  x86/jump_label: Use text_poke_early() during early init
>>  fork: provide a function for copying init_mm
>>  x86/alternative: initializing temporary mm for patching
>>  x86/alternative: use temporary mm for text poking
>>  x86/kgdb: avoid redundant comparison of patched code
>>  x86: avoid W^X being broken during modules loading
>>  x86/jump-label: remove support for custom poker
>>  x86/alternative: remove the return value of text_poke_*()
>>=20
>> arch/x86/include/asm/fixmap.h        |   2 -
>> arch/x86/include/asm/mmu_context.h   |  32 +++++
>> arch/x86/include/asm/pgtable.h       |   3 +
>> arch/x86/include/asm/text-patching.h |   7 +-
>> arch/x86/kernel/alternative.c        | 197 ++++++++++++++++++++-------
>> arch/x86/kernel/jump_label.c         |  19 ++-
>> arch/x86/kernel/kgdb.c               |  25 +---
>> arch/x86/kernel/module.c             |   2 +-
>> arch/x86/mm/init_64.c                |  35 +++++
>> arch/x86/xen/mmu_pv.c                |   2 -
>> include/linux/filter.h               |   6 +
>> include/linux/sched/task.h           |   1 +
>> init/main.c                          |   3 +
>> kernel/fork.c                        |  24 +++-
>> kernel/module.c                      |  10 ++
>> 15 files changed, 279 insertions(+), 89 deletions(-)
>=20
> Thanks Nadav!
>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

No problem, Peter.

One small request - on [02/10], since after your review the patch changed t=
o
be the single line that you provided, I set you as a co-developer. IIUC thi=
s
requires your signed-off-by.

Thanks again for all the reviews and the help.

