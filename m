Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeERRYb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:24:31 -0400
Received: from mail-sn1nam02on0084.outbound.protection.outlook.com ([104.47.36.84]:2304
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750957AbeERRY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:24:29 -0400
From: Nadav Amit <namit@vmware.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Anvin <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Topic: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgACNMgCAABDSAA==
Date: Fri, 18 May 2018 17:24:27 +0000
Message-ID: <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
In-Reply-To: <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2430;7:irGpEoEhqeLjj8EAZndbf3bWOKL+qkacEFBcJB5RvybNiAwj/TZ9e8mYo4arNn6i6MYNu5XaMp2oG7JQNOwMWLnLknigN3F2FNyFn+Ethk5H92pV/padUkzVie+izzqL4GUjWp/BL1dFmc6fVsHDRaCVOs3dMRtsciN9Gtu8Br9J4YnOAyDgqT1VTxtj8F1oR4CeVKOZvUytzpAQeZP60ZJ4AC8m1Xq32Dq/UNmKW2kvSx4fAH0pXbpC4Qd9NnzB;20:g/Yq/7XEwYDGx6Lmyv0iHkd2GRz4XsQkpyCXj5o29FvjLuuyLWLnI4jkvAQ+PExAoKbgkHmEXkDMUwbJXJqifG6Cn3ZoFhCKA7o5aUGiJDf457txNZCeAMiSfxcfj/HzymgBOzrr9uOC1LPuY6BE4KmOB6Al8/FbVpY91EfVSPs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2430;
x-ms-traffictypediagnostic: SN2PR05MB2430:
x-microsoft-antispam-prvs: <SN2PR05MB2430F2D61953B244B4B4BA58D0900@SN2PR05MB2430.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2430;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2430;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(39380400002)(396003)(366004)(199004)(189003)(54094003)(105586002)(186003)(68736007)(106356001)(3280700002)(6436002)(11346002)(446003)(3660700001)(25786009)(14454004)(26005)(486006)(102836004)(6486002)(476003)(2616005)(2900100001)(6512007)(76176011)(66066001)(93886005)(478600001)(86362001)(3846002)(305945005)(6116002)(2906002)(97736004)(4326008)(99286004)(6246003)(33656002)(53936002)(54906003)(316002)(5250100002)(6916009)(53546011)(8936002)(6506007)(229853002)(81166006)(82746002)(81156014)(8676002)(7736002)(36756003)(83716003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2430;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: O6YRJ3Khc90mDQaw8eoHS/NcJ5rmL7l+uCSDszioZyIuXTSePtZtJMOCYPcy4drBCGWG+Ea2X91xKeUdNXtGXkVyowTykJTTBoi47+ahfhvkzQZjIXjfOhCt7KbyG/fYxuuvIR4O9BkxaaMSX0WTBExD+YENMDSn7KL3hPh/f1ce7RHgFSshhCNfynQut5AZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <76F269CE351B7A46961F46628903A64F@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1f1f18a1-c1a2-46ad-d9f8-08d5bce43543
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1f18a1-c1a2-46ad-d9f8-08d5bce43543
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 17:24:27.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2430
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IHObBN006891

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, May 18, 2018 at 12:59 AM Peter Zijlstra <peterz@infradead.org>
> wrote:
> 
>> This is an awesome hack, but is there really nothing we can do to make
>> it more readable? Esp, that global asm doing the macro definition is a
>> pain to read.
> 
> I actually find that macro to be *more* legible than what we do now,
> although I'm not enamored with the pseudo-operation name ("__BUG_FLAGS").
> 
> That said, the C header code itself I don't love.
> 
> I wonder if we should just introduce a new assembler header file, and get
> it included when processing compiler-generated asm. We already do that for
> our _real_ *.S files, with a number of our header files having constants
> and code for the asm case too, not just C.
> 
> But we could have an <asm/asm-macro.h> header file that has these kinds of
> macros (or "pseudo-instructions") for assembly language cases, and then we
> could just rely on them in inline asm.

Will it be ok just to use a global inline asm to set an “.include” directive
that gas would later process? (I can probably wrap it in a C macro so it
won’t be too disgusting)
