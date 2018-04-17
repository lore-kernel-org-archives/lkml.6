Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874849-1523971917-2-10252130616148526054
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
    1523971916; b=NKWm5UAMjW541NeXt+n+DuExHpIE5xENL1jE+z2fmqRHj0uLUt
    bGR0VdHY0Gqat+eaDCneVBstH4a8SFR95yfMRaxmthg2O37/lqGZFmJlCaIvKu2+
    wKpTQz6oIr9VvxpQXN2EaBsjuYKe9XV+/UzoleojBLF8jnuX4E7h5Om0WZqSxv1x
    O0e925Ly4LJ5ltnZHTYlHsglTfePvn0HxPDLGVfqcV1AvVa3eGRdFWTeTJ9iYPoD
    rZKtE5sbUG8oi5HC+92/6fEpCMV7ugkJLPB8rawLws5BG86d6rx3nBmvLnVVdeZO
    j/JFHqUNTvi2oCI5/RiJ3M1dkJ1M8ez8ikYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523971916; bh=GJp9/4Xcogf05wxVr334MLsareKV5c834sO16kSyF84=; b=
    Mqfqxu2XE7NWluJF9Do4GryTipwF2UZN4d/qGKdxtBojhqkRmd/0iTqR4FI7+Csm
    Mmb9WAV48I2LBUIIrTyTlxhHKfqd3en/lr7waLyBCYJI6kqmC6IolHSQvpc4BFko
    2cyu+P4QJcXBjwe1KsRhxqQkUrmBIdH+KCdZpEJHXFma4TRRpqBzOP5rAHrZfyGZ
    mnK2zRtNZO3vnLomkkaBRqX+JhkvOQCQnLXwQhpeY6xSnqDjZHpeeK5N0W61BUhh
    CCZ9Sxf7EnWuOn9lLLCNIPWZKo0lcvA9Qo46KAsKX27KuRA5IjxxDV6RWS0Tms7q
    3UJphVHWxyxZC4ZFdIe/pA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XA3hH6aV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XA3hH6aV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAeDddNRGFHeI3WFKM28BVhtxtVk+PhVW9swm8re7YL1RccwxVsiWLC8KIKfUwGe5pgTqr/H3WCW8YVOdltum1w/ARSbI6fc1nyN2Eb2jsSertaEvTwm
    U4mvsMAoaH9D3MJEGn8PZz1p00I3qKjvc/7u9lDfEpPxCf46E1hmKbbtKHWfI2H1qdgD4KqW/UB/5bd8X3lZf4pUGKbBaUjLIETvQ4kGeqvrIkWBC7pmtB/u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=bdN2KwVvKgEldeEnkRcA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeDQNbz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 09:31:55 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:49760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753306AbeDQNbx (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 09:31:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Jan Kara <jack@suse.cz>
CC: Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YCAAAMcgIAAAh8AgAAH3gCAAATcgIABMtsAgAAewoA=
Date: Tue, 17 Apr 2018 13:31:51 +0000
Message-ID: <20180417133149.GR2341@sasha-vm>
References: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home> <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd> <20180416172327.GK2341@sasha-vm>
 <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
In-Reply-To: <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:ZRoxkFRfJYpqu+Q/kV+gEK2oqEUzOOhFQkPZqvFpKntvYrhXnKKNAPRaEF+QvQ/5iJdj5g6vJyZeJn5rG+E6GKP/JW0yPqYJJn5/G0vtffyqI9I3MrvsRfUDqT9fSyAMfyk+kRFqleSmN+zcLf/Or+NdL3BSWyEkn4a0qJTVajQED7n4Bcdko6o1Jm/ISBU8Xait8EBheLugnFKWIDdLtyJ+I48D5x7dz8VHyUoY17G4l4cr8UirDw3WiWd0Hz5u;20:ZmYD+S3tqQnmCkceLJ1N8QGTPadqTp8bAveyAjUdfaL5sqzI/B2uYun6uLoVfdYVQWik9xowaadwKGaQYj9BULvhYN/vzuHETCPNG+hpxeL06dY2+FzTy4xQcGEQG6puHFezqsswfaLR0B6e9+Snfy+YjsKSa/vLg80LNMU7nBI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091994C75C122B9D8EFFCAE9FBB70@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231232)(944501359)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39380400002)(346002)(376002)(39860400002)(51444003)(199004)(189003)(377424004)(53936002)(86362001)(6486002)(86612001)(229853002)(39060400002)(6916009)(33716001)(33656002)(6246003)(93886005)(186003)(22452003)(7416002)(316002)(5660300001)(7736002)(26005)(97736004)(54906003)(6506007)(102836004)(59450400001)(305945005)(99286004)(33896004)(76176011)(11346002)(446003)(476003)(68736007)(486006)(81166006)(8676002)(81156014)(6512007)(66066001)(9686003)(6436002)(14454004)(105586002)(5250100002)(106356001)(10090500001)(2900100001)(478600001)(8936002)(3846002)(1076002)(2906002)(3280700002)(10290500003)(72206003)(25786009)(6116002)(4326008)(3660700001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: d6iY5Wsb+hG6G+AMqPfGdmBqdNYbc/7Y8soMw2bV5W/Bh1E8mD2EQaqNKdKWhwCDrckk2LbI2v0T++ozb3paGV0K6HmiD5LrUroTSidcqdnZYX/7HlGZ5wrzEGUKo+XDqHa8P2SycGge/fEKM1NkQFiGX3Z7wJ0Y7nGVw0oG4WdRkGBXruAMgm1kDKsZroGH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C88A03DC010BF47AFFB120ED598BE62@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b4e62799-5012-4078-5e61-08d5a4679456
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e62799-5012-4078-5e61-08d5a4679456
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 13:31:51.8677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 01:41:44PM +0200, Jan Kara wrote:
>On Mon 16-04-18 17:23:30, Sasha Levin wrote:
>> On Mon, Apr 16, 2018 at 07:06:04PM +0200, Pavel Machek wrote:
>> >On Mon 2018-04-16 16:37:56, Sasha Levin wrote:
>> >> On Mon, Apr 16, 2018 at 12:30:19PM -0400, Steven Rostedt wrote:
>> >> >On Mon, 16 Apr 2018 16:19:14 +0000
>> >> >Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>> >> >
>> >> >> >Wait! What does that mean? What's the purpose of stable if it is =
as
>> >> >> >broken as mainline?
>> >> >>
>> >> >> This just means that if there is a fix that went in mainline, and =
the
>> >> >> fix is broken somehow, we'd rather take the broken fix than not.
>> >> >>
>> >> >> In this scenario, *something* will be broken, it's just a matter o=
f
>> >> >> what. We'd rather have the same thing broken between mainline and
>> >> >> stable.
>> >> >
>> >> >Honestly, I think that removes all value of the stable series. I
>> >> >remember when the stable series were first created. People were sayi=
ng
>> >> >that it wouldn't even get to more than 5 versions, because the bar f=
or
>> >> >backporting was suppose to be very high. Today it's just a fork of t=
he
>> >> >kernel at a given version. No more features, but we will be OK with
>> >> >regressions. I'm struggling to see what the benefit of it is suppose=
 to
>> >> >be?
>> >>
>> >> It's not "OK with regressions".
>> >>
>> >> Let's look at a hypothetical example: You have a 4.15.1 kernel that h=
as
>> >> a broken printf() behaviour so that when you:
>> >>
>> >> 	pr_err("%d", 5)
>> >>
>> >> Would print:
>> >>
>> >> 	"Microsoft Rulez"
>> >>
>> >> Bad, right? So you went ahead and fixed it, and now it prints "5" as =
you
>> >> might expect. But alas, with your patch, running:
>> >>
>> >> 	pr_err("%s", "hi!")
>> >>
>> >> Would show a cat picture for 5 seconds.
>> >>
>> >> Should we take your patch in -stable or not? If we don't, we're stuck
>> >> with the original issue while the mainline kernel will behave
>> >> differently, but if we do - we introduce a new regression.
>> >
>> >Of course not.
>> >
>> >- It must be obviously correct and tested.
>> >
>> >If it introduces new bug, it is not correct, and certainly not
>> >obviously correct.
>>
>> As you might have noticed, we don't strictly follow the rules.
>>
>> Take a look at the whole PTI story as an example. It's way more than 100
>> lines, it's not obviously corrent, it fixed more than 1 thing, and so
>> on, and yet it went in -stable!
>>
>> Would you argue we shouldn't have backported PTI to -stable?
>
>So I agree with that being backported. But I think this nicely demostrates
>a point some people are trying to make in this thread. We do take fixes
>with high risk or regression if they fix serious enough issue. Also we do
>take fixes to non-serious stuff (such as addition of device ID) if the
>chances of regression are really low.
>
>So IMHO the metric for including the fix is not solely "how annoying to
>user this can be" but rather something like:
>
>score =3D (how annoying the bug is) * ((1 / (chance of regression due to
>	including this)) - 1)^3
>
>(constants are somewhat arbitrary subject to tuning ;). Now both 'annoying=
'
>and 'regression chance' parts are subjective and sometimes difficult to
>estimate so don't take the formula too seriously but it demonstrates the
>point. I think we all agree we want to fix annoying stuff and we don't wan=
t
>regressions. But you need to somehow weight this over your expected
>userbase - and this is where your argument "but someone might be annoyed b=
y
>LEDs not working so let's include it" has problems - it should rather be
>"is the annoyance of non-working leds over expected user base high enough
>to risk a regression due to this patch for someone in the expected user
>base"? The answer to this second question is not clear at all to a casual
>reviewer and that's why we IMHO have CC stable tag as maintainer is
>supposed to have at least a bit better clue.

We may be able to guesstimate the 'regression chance', but there's no
way we can guess the 'annoyance' once. There are so many different use
cases that we just can't even guess how many people would get "annoyed"
by something.

Even regression chance is tricky, look at the commits I've linked
earlier in the thread. Even the most trivial looking commits that end up
in stable have a chance for regression.

>Another point I wanted to make is that if chance a patch causes a
>regression is about 2% as you said somewhere else in a thread, then by
>adding 20 patches that "may fix a bug that is annoying for someone" you've
>just increased a chance there's a regression in the release by 34%. And

So I've said that the rejection rate is less than 2%. This includes
all commits that I have proposed for -stable, but didn't end up being
included in -stable.

This includes commits that the author/maintainers NACKed, commits that
didn't do anything on older kernels, commits that were buggy but were
caught before the kernel was released, commits that failed to build on
an arch I didn't test it on originally and so on.

After thousands of merged AUTOSEL patches I can count the number of
times a commit has caused a regression and had to be removed on one
hand.

>this is not just a math game, this also roughly matches a real experience
>with maintaining our enterprise kernels. Do 20 "maybe" fixes outweight suc=
h
>regression chance? And I also note that for a regression to get reported s=
o
>that it gets included into your 2% estimate of a patch regression rate,
>someone must be bothered enough by it to triage it and send an email
>somewhere so that already falls into a category of "serious" stuff to me.

It is indeed a numbers game, but the regression rate isn't 2%, it's
closer to 0.05%.=
