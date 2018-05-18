Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeERTgY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:36:24 -0400
Received: from mail-dm3nam03on0045.outbound.protection.outlook.com ([104.47.41.45]:54511
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751744AbeERTgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:36:23 -0400
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
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgACNMgCAABDSAIAAERIAgAACU4CAAASRAIAAAOaAgAACnwCAAAJMgIAAAfyAgAAAzgCAAACDAIAAA8QA
Date: Fri, 18 May 2018 19:36:20 +0000
Message-ID: <F1BBC78E-CA44-4C7D-AF87-2F713266EE2A@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
 <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com>
 <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
 <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com>
 <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com>
 <2F760FAE-C19C-4BC3-A8CC-7D17CEF3B116@zytor.com>
 <6A3E90AA-7838-4C2A-B628-908F34902B75@vmware.com>
 <CA+55aFysH5iiJWCVFu1J6GQfN2G1AbMcHyc4RhpnrnPjtM3L0Q@mail.gmail.com>
 <C481FBCA-2FA6-49B6-84DC-83FF03F539B9@vmware.com>
 <CA+55aFz4vKF-xC+A=DOozkPMVyLHPC5xMqW+y6pg9D7W-c2BQw@mail.gmail.com>
 <102B8072-91D5-4D28-82C9-64D5AA73802C@zytor.com>
In-Reply-To: <102B8072-91D5-4D28-82C9-64D5AA73802C@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2463;7:esISJjh0cHTb6jttOs0w/bwK3S/0cJ355DB784tUwrbZjhq3u6JKkzY2+ESTU0mVX+zeu9pAYymkx4SnXksAmbOPLTBQ9e9M6k1W1bOpzTj+gyi7TDHj+qlhLlM/MNac+CMQ0P9CV3a66uiAOQb0HZgX1iqQq7Bx/J3EbXjvBqsP0WJ2ebHv4nB69m0GB9MOxJaNeEjXz7JqrhGYe0QkTJZDqVzvstwY+qAGRqbp3uL8+dBxurFIQ28kHyvlsj6W;20:mJl71MA1FYWSdmlQIty2RrmxdiIApytZ05w0zRi/hVSxG6VEKIx5p2wOfTKDS3QSXiCh84D1R81Mqqx5wC9IEnVDx0kjT/om6GZXT9xnNty4mQmSOjMsK4bWF4wbNmps0gQ93YGaJ+w2KvngdIzrHLYfKgAE3L4H8MwWLR/0NiQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2463;
x-ms-traffictypediagnostic: SN2PR05MB2463:
x-microsoft-antispam-prvs: <SN2PR05MB2463191AC50AAB55C5A8A637D0900@SN2PR05MB2463.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2463;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2463;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(366004)(396003)(69224002)(199004)(189003)(97736004)(186003)(3660700001)(14454004)(3280700002)(86362001)(316002)(229853002)(4326008)(6346003)(6246003)(102836004)(6506007)(33656002)(26005)(53546011)(53936002)(5660300001)(8676002)(68736007)(83716003)(1730700003)(5250100002)(2501003)(81166006)(81156014)(2900100001)(2351001)(8936002)(6512007)(76176011)(5640700003)(99286004)(82746002)(3846002)(6116002)(93886005)(6436002)(476003)(54906003)(6916009)(478600001)(446003)(6486002)(2906002)(25786009)(11346002)(2616005)(106356001)(7736002)(105586002)(305945005)(36756003)(66066001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2463;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: yzUEk5iTUHH/gOxFdFfM+SucNNsVBj4FtcJFSElmr0MwHn1RSGl8fee3bmGtF9XK7ufSXigNTnihJ1dqh+qELmcFSNssAeYI1+3YIZ8EjT9V8SdWF6qmfbcevGlxGTbTuRBY5Aj2xeVLV9x6DMjT6e6/9MsyqysZjpThzy39W9k53wIWCE4mgBSA6BscL6C9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <232C48DD0B53A34097A9E6C7251A5189@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6db1d538-0ac1-414d-1ce5-08d5bcf6a19b
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db1d538-0ac1-414d-1ce5-08d5bcf6a19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 19:36:20.0504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2463
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IJaU0R014711

hpa@zytor.com wrote:

> On May 18, 2018 12:21:00 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Fri, May 18, 2018 at 12:18 PM Nadav Amit <namit@vmware.com> wrote:
>> 
>>> Gnu ASM manual says: "Each time you run as it assembles exactly one
>> source
>>> program. The source program is made up of one or more files.”
>> 
>> Ok, that counts as documentation, although it's confusing as hell. Is
>> it
>> one source program or multiple files again? I see what they are trying
>> to
>> say, but it really could be phrased more clearly ;)
>> 
>>                    Linus
> 
> At least we have a solution!

Thanks for all your help. I will try to do it over over the weekend.

Funny, I see that this “trick” (-Wa,[filename.s]) is already being used to
include arch/x86/boot/code16gcc.h so I feel “safer” to use it.

Regards,
Nadav
