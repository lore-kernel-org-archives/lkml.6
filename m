Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeERTCy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:02:54 -0400
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:58496
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751221AbeERTCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:02:53 -0400
From: Nadav Amit <namit@vmware.com>
To: "hpa@zytor.com" <hpa@zytor.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Topic: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgACNMgCAABDSAIAAERIAgAACU4CAAASRAIAAAOaAgAACnwA=
Date: Fri, 18 May 2018 19:02:50 +0000
Message-ID: <6A3E90AA-7838-4C2A-B628-908F34902B75@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
 <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com>
 <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
 <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com>
 <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com>
 <2F760FAE-C19C-4BC3-A8CC-7D17CEF3B116@zytor.com>
In-Reply-To: <2F760FAE-C19C-4BC3-A8CC-7D17CEF3B116@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2429;7:J3xLfVpA97NDucxTd5wVVpYKVrvOrNJNEYlezWWlm/hdqBlVSeu768kLQ6n1FFbt1xQajh59+9Z+P9VSeFFIydMsFgR0+cJy7egXv2iFxu8ckFuS3BoWIus90Ly64TjXS4YuEqcM4r5CYXfxLEXQEVjYUvvJvfRWqljy2hwVPd0q/zVHBH02be4zOwAz/dBOBFbN8cdPsSw8IDeX5OpXmzVk4QJnjbCOG/OULPbrVtcFtZl7O9omOc8dVXBd7eLk;20:1gasFVhegF7C9QCMAd7YymBuFilSJwLko6naoDyv64aWgwypeWjgSJr7innInEVN0tQkDHskOwMtK2Hg0eO8OochItbeeFAb3smNRWe9HqFA43aq+q4Q6iFiK9dGsyTR+q8vOoRc+cHQFArFBFogwVs+3PRdK8iCV9nDBsCQ8Ic=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2429;
x-ms-traffictypediagnostic: SN2PR05MB2429:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB2429FF80496682E026A4D9A8D0900@SN2PR05MB2429.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2429;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2429;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(39380400002)(189003)(199004)(14454004)(478600001)(86362001)(6916009)(97736004)(4326008)(6512007)(53936002)(5250100002)(5660300001)(2501003)(6246003)(229853002)(6486002)(106356001)(105586002)(68736007)(83716003)(25786009)(2900100001)(76176011)(476003)(11346002)(316002)(446003)(2351001)(66066001)(2616005)(102836004)(186003)(54906003)(81156014)(1730700003)(8676002)(81166006)(8936002)(33656002)(82746002)(6116002)(3846002)(99286004)(5640700003)(3280700002)(3660700001)(53546011)(6506007)(93886005)(486006)(26005)(7736002)(305945005)(2906002)(6436002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2429;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8hU165aTdgptPBMRP2rg4FpvUshFaW4lo9dwphslgaBdRrjURZVylEYp293Bj49muxuo1rICYn6y7WgcGvVfrkr7ywQZOCoEC5qAuDvqU/Hn8/s6TXb4KZ80bWF0zLt+OLXtlDH8RFEg8BHJvdKWBjCHru7NlGHetRDHo1kzvCJiuFa4MaGfl97iFurxk745
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B316BD363727EE428095EE2998DF3196@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0fe2328a-7cff-46f5-955f-08d5bcf1f3e9
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe2328a-7cff-46f5-955f-08d5bcf1f3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 19:02:50.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4IJ317d014559

hpa@zytor.com wrote:

> On May 18, 2018 11:50:12 AM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Fri, May 18, 2018 at 11:34 AM <hpa@zytor.com> wrote:
>> 
>>> On May 18, 2018 11:25:32 AM PDT, Linus Torvalds <
>> torvalds@linux-foundation.org> wrote:
>> 
>>> Unfortunately gcc doesn't guarantee that global assembly inlines will
>> appear at the top of the file.
>> 
>> Yeah. It really would be better to do the "asm version of -inline".
>> 
>> We already do something like that for real *.S files on some
>> architectures
>> (because their assembly really wants it, eg
>> 
>> arch/arm/Makefile:
>> KBUILD_AFLAGS +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y)
>> -include
>> asm/unified.h -msoft-float
>> 
>> but I do want to point out that KBUILD_AFLAGS is *not* used for
>> compiler-generated assembly, only for actual *.S files.
>> 
>> Sadly, I don't actually know any way to make gcc call the 'as' phase
>> with
>> particular options. We can use "-Wa,xyzzy" to pass in xyzzy to the
>> assembler, but there is no "-include" option for GNU as afaik.
>> 
>> Can you perhaps define a macro symbol for "--defsym"? Probably not.
>> 
>>                      Linus
> 
> I looked at this thing a long time ago; it's not there, and the best would probably be to get global asm() working properly in gcc.

I can add a -Wa,[filename.s] switch. It works, but sort of undocumented.
