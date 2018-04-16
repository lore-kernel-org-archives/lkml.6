Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3848786-1523902645-2-8919489377777651992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523902644; b=BCWdfluqnFCSyS+1SVmbUgaMttnrQFT3vhOG0L+FqPPRqeTY05
    EGb3uXFEKy6kNhszALLpcC6iWqUrIGPh4E2XLMFaRTldbce2I1JqnPnQGNR8ZZF7
    LlM7UmKBNp/FnHVRc8wiVD+mAealkC92drrWJJs2fjXEoKEf1U/vxNkXW2Wvm7TJ
    ZT5ez7NUMiEGsVq8THmZls5aUQ8UHEb73Sd7tH3ClJYJ95rTMN3imhwtzYmQt93w
    JqDz2AVn42/7G2xunfWK9hEU3kziNoWnyAcdZGRHhl4oNZy6ADnjfq783Y/NjrGD
    5R/Lp0rIhU+pMvLXQHaGx4CYyAyr+lbfkOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523902644; bh=4tEB5x66RLzb/VJSNY3Ar7DJe9JDMrxc1ivZWmtyPa8=; b=
    icZmPo4BRbHSybdAxIDSFQ/STjBL+ZnXCjqwP4sBcOc20JseDlfaNxXXWMkzL+Hh
    mGzfcvb/aYWHSyt09yhxuOXwMocmLtRvDPAcOg77kFt3Bq3zzxJlOsk98FX0E3Gs
    HtthMTtyjXi9vuhJI5KUXkLpDYYX1YIIdHIxBUfgsS1SlfWn58IenjwhuipZabSO
    h5WqO1nQFXJarj/UGpGVLtDBptoLgae9C/37UjVHZfJB2wzOSc4/qakHBa6ZGQot
    3jw0SOuaj6CsujZ1t2mYp03r8zKKlQ14C3OR9UBzk9DnFXYz8Dp87XW4UPBHxc6Q
    TzCUXEeZQRggAdIGZEzr+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GdDSma/F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GdDSma/F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJsZiada7NrSAhZJMhNyLctaklWANlci6LmaVPZD37xLbChNTbWnvqdiHOSqnZcH1QOFtcwLPbr2fuaCZn4QF4mE0Yu5Fawv9jeSEgzzB0+OgMW7aC7r
    SgzqccAzuYGj1vg78sU8jNraKXoe/KsKt/8ClPrBTaH1Iw8RlAuQZiI19/kKf8hTTxZw82CGjR9ns7kXStwb4jyMpB9R/x36Xbq+fScfRPI/F9sVENrxa7RO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=NEAV23lmAAAA:8 a=D19gQVrFAAAA:8
    a=jFWWOh2WsecrSO2y4ugA:9 a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeDPSRV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:17:21 -0400
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:24576
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752308AbeDPSRT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 14:17:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqAgAAH5oCAAAkvgA==
Date: Mon, 16 Apr 2018 18:17:17 +0000
Message-ID: <20180416181715.GM2341@sasha-vm>
References: <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416170501.GB11034@amd> <20180416171607.GJ2341@sasha-vm>
 <20180416134423.2b60ff13@gandalf.local.home>
In-Reply-To: <20180416134423.2b60ff13@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:JvhAIJkzfj778N+j6hp9KcMno6bwWNp0OqQPLg6/TVIElzjEXN0/zNg3S4WgURM4EXsOMbDS3uutXhoBOwdgBtqTJ0xq/9RZtVx0jRta6TDX1xc2RCcLHAD0rOQdWnnFhkz+XrzOhhlCzLRWp9vMECMg4iK9nfyLMl9DLqSkj6XDYDaw85thUpbtHGDnpPCDStjDQdgHGcZGC/7flVtKByJbPV8zC58pNL70RDf9iRA8pCn6crwNAmSLfctuarQr;20:AI/jgMZwawwUqGGTprab/StKy+ooWk6SCdLmUwSHUOM2abEdXNbOssnTnfv8QCbQvVvS2NHAk8n67SIsRPXj8k1TSPt76BnvagJh1YQzTbDKZkp0IHmGKIomIGm9SkM9tiIrp5y9pJUzwq3aeaXy1GsX00XV3sBF0tLn/3Jiv10=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1127A7FAE505C56F55418323FBB00@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501347)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(346002)(366004)(396003)(376002)(39380400002)(199004)(189003)(7736002)(305945005)(3280700002)(10290500003)(33656002)(966005)(99286004)(229853002)(72206003)(6486002)(186003)(478600001)(54906003)(2906002)(316002)(86612001)(105586002)(26005)(93886005)(66066001)(2900100001)(7416002)(81156014)(8676002)(10090500001)(22452003)(68736007)(81166006)(5660300001)(1076002)(33896004)(3660700001)(4326008)(5250100002)(39060400002)(25786009)(14454004)(59450400001)(102836004)(6116002)(6246003)(33716001)(446003)(6306002)(486006)(9686003)(6506007)(6436002)(476003)(53936002)(3846002)(97736004)(8936002)(76176011)(106356001)(6512007)(6916009)(11346002)(86362001)(507254003)(556444002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KvYdboh6BUzIY+5BocmsQuhXxxLszL2YYkEvX0/iZz+1PoEESgWd5TNDiZXGirch6kGfodjbuG0QlCRJdS/pq4HSZup4WdupF+Xri1lCOxL+JSD00z5eEgJsoTdi916o1xupIDEOODx6jhINE+tvRMeZaedRV6k7bEOgIrdvMAhKgDz9RhQFl9irW0Esq9NZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD093F82ADD8374A9680DF28D6F0867B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1286281a-6012-434f-b3a7-08d5a3c649dc
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1286281a-6012-434f-b3a7-08d5a3c649dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 18:17:17.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 01:44:23PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 17:16:10 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>
>> So if a user is operating a nuclear power plant, and has 2 leds: green
>> one that says "All OK!" and a red one saying "NUCLEAR MELTDOWN!", and
>> once in a blue moon a race condition is causing the red one to go on and
>> cause panic in the little province he lives in, we should tell that user
>> to fuck off?
>>
>> LEDs may not be critical for you, but they can be critical for someone
>> else. Think of all the different users we have and the wildly different
>> ways they use the kernel.
>
>We can point them to the fix and have them backport it. Or they should
>ask their distribution to backport it.

It may work in your subsystem, but it really doesn't work this way with
the kernel.

Let me share a concrete example with you: there's a vfs bug that's a
pain to reproduce going around. It was originally reported on
CoreOS/AWS:

	https://github.com/coreos/bugs/issues/2356

But our customers reported to us that they're hitting this issue too.

We couldn't reproduce it, and the call trace indicated it may be a
memory corrution. We could however confirm with the customers that the
latest mainline fixes the issue.

Given that we couldn't reproduce it, and neither of us is a fs/ expert,
we sent a mail to LKML, just like you suggested doing:

	https://lkml.org/lkml/2018/3/2/1038

But unlike what you said, no one pointed us to the fix, even though the
issue was fixed on mainline. Heck, no one engaged in any meaningful
conversation about the bug.

I really think that we have a different views as to how well the whole
"let me shoot a mail to LKML" process works, which leads to different
views on -stable.

>Hopefully they tested the kernel they are using for something like
>that, and only want critical fixes. What happens if they take the next
>stable assuming that it has critical fixes only, and this fix causes a
>regression that creates the "ALL OK!" when it wasn't.
>
>Basically, I rather have stable be more bug compatible with the version
>it is based on with only critical fixes (things that will cause an
>oops) than to try to be bug compatible with mainline, as then we get
>into a state where things are a frankenstein of the stable base version
>and mainline. I could say, "Yeah this feature works better on this
>4.x version of the kernel" and not worry about "4.x.y" versions having
>it better.

This is how things used to work, right? Look at redhat kernels for
example, they'd stick with a kernel for tens of years, doing the tiniest
fixes, only when customers complained, and encouraging users to upgrade
only when the kernel would go EoL, and when customers couldn't do that
because they were too locked on that kernel version.

redhat still supports 2.6.9.

I thought we agreed that this is bad? We wanted users to be closer to
mainline, and we can't do it without bringing -stable closer to mainline
as well.=
