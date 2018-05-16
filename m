Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeEPQhK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:37:10 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:27392
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751307AbeEPQhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:37:08 -0400
From: Nadav Amit <namit@vmware.com>
To: Kees Cook <keescook@chromium.org>
CC: LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC 5/8] x86: refcount: prevent gcc distortions
Thread-Topic: [RFC 5/8] x86: refcount: prevent gcc distortions
Thread-Index: AQHT7JNal4XNWp7ceUuT4zArssv9H6QyYvAAgAAsKIA=
Date: Wed, 16 May 2018 16:37:06 +0000
Message-ID: <BC3F1775-9EB8-4BA2-AADD-14080AF48E20@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
 <20180515141124.84254-6-namit@vmware.com>
 <CAGXu5j+wXoAaAFzmnU=VuYeHrGTyzBsEnCdeALYb=jXUaeeQ6g@mail.gmail.com>
In-Reply-To: <CAGXu5j+wXoAaAFzmnU=VuYeHrGTyzBsEnCdeALYb=jXUaeeQ6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2784;7:bghgQORfxfsGCuVvWK+rRR1R4GZx+BqUUSaJpUWAZuMqABRjUvlyn/Ub+KGXVzjM1yvXN57R3Hx5YoeRTF5IKUoSRJFkG/UYDucsEef0lvFBrC+fLP2wLU4JOnnDNMo7H3A51QBXJyoa/WCrwWoiBdSsU6tSxv+yYdvRuFmsAcE/zhzpTl4yRhyFDUuX5SnV/xx2vHEASdIS6KFc90CtyONKHp8oof6vYmpyyICTezflelZdYdzTrvQ9+6JKSrXl;20:AxH4Haxra+E2RT/1v2ugtnt93Ze5pAP6gB/qT5ZEqs7ddch4ci10pe+zs7nuNpFF6g3PwLJ+agRDLaW2K9lFXI7wpVD3Ekh6h9Bz/Co9L7NEn+L8vCWv+0p2L1JkNAUyTSKHgSq7/NJzdjyPFcQ2W9MdeU5mKwVXDCbJgkXj3CA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2784;
x-ms-traffictypediagnostic: SN2PR05MB2784:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB2784C139939A165FFF815083D0920@SN2PR05MB2784.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR05MB2784;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2784;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(199004)(189003)(476003)(81156014)(82746002)(81166006)(486006)(33656002)(54906003)(6246003)(14454004)(26005)(8676002)(99286004)(86362001)(5250100002)(3660700001)(97736004)(25786009)(446003)(8936002)(2900100001)(105586002)(478600001)(11346002)(6916009)(2906002)(2616005)(186003)(106356001)(6512007)(3280700002)(5660300001)(53936002)(36756003)(7736002)(6436002)(4326008)(83716003)(305945005)(76176011)(68736007)(6506007)(102836004)(66066001)(3846002)(6486002)(53546011)(6116002)(316002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2784;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /iVteLfF2wrOw9fHpapHySrW4vO5Qso1FoOcSLBFFUclB7iaH4FDGjQOjJmrwNg8C3GhjH8105MBdj/lq6osQMn51erM9AJ978vdwVjh80vdwpC2FqD34U6zu0gJTcDIRi+6YUKdjX84q573u4lRIl29TGjjalVZ0WRpyGlky629FYPSWs4B1mTSNv1s5Ca/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A7FBCAF9227B440B07B9140AA391CD5@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 741c0f2c-b5bc-4d11-17eb-08d5bb4b4310
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741c0f2c-b5bc-4d11-17eb-08d5bb4b4310
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 16:37:06.3171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GGbHS6017139

Kees Cook <keescook@chromium.org> wrote:

> On Tue, May 15, 2018 at 7:11 AM, Nadav Amit <namit@vmware.com> wrote:
>> GCC considers the number of statements in inlined assembly blocks,
>> according to new-lines and semicolons, as an indication to the cost of
>> the block in time and space. This data is distorted by the kernel code,
>> which puts information in alternative sections. As a result, the
>> compiler may perform incorrect inlining and branch optimizations.
>> 
>> The solution is to set an assembly macro and call it from the inlined
>> assembly block. As a result GCC considers the inline assembly block as
>> a single instruction.
>> 
>> This patch allows to inline functions such as __get_seccomp_filter().
>> The effect of the patch is as follows on the kernel size:
>> 
>>   text    data     bss     dec     hex filename
>> 18146418 10064100 2936832 31147350 1db4556 ./vmlinux before
>> 18148228 10063968 2936832 31149028 1db4be4 ./vmlinux after (+1678)
>> 
>> Static text symbols:
>> Before: 39673
>> After:  39649   (-24)
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Jan Beulich <JBeulich@suse.com>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> 
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> arch/x86/include/asm/refcount.h | 55 ++++++++++++++++++++-------------
>> 1 file changed, 33 insertions(+), 22 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
>> index 4cf11d88d3b3..a668c534206d 100644
>> --- a/arch/x86/include/asm/refcount.h
>> +++ b/arch/x86/include/asm/refcount.h
>> @@ -14,34 +14,43 @@
>>  * central refcount exception. The fixup address for the exception points
>>  * back to the regular execution flow in .text.
>>  */
>> -#define _REFCOUNT_EXCEPTION                            \
>> -       ".pushsection .text..refcount\n"                \
>> -       "111:\tlea %[counter], %%" _ASM_CX "\n"         \
>> -       "112:\t" ASM_UD2 "\n"                           \
>> -       ASM_UNREACHABLE                                 \
>> -       ".popsection\n"                                 \
>> -       "113:\n"                                        \
>> +
>> +asm ("\n"
>> +       ".macro __REFCOUNT_EXCEPTION counter:vararg\n\t"
> 
> Why are these vararg?

I don’t think it is needed here. I will fix it.

> 
> Also, I think for the whole series, these #define-a-macro cases need a
> comment in the code. It's not obvious from looking at the code why
> they've defined a macro instead of just leaving the asm as it was.

Right. I will add them.

> Beyond that, as long as there is no behavioral changes, I'm fine with
> the changes.

Thanks!

Nadav
