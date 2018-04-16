Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523897588-2-10904701046713514386
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
    1523897588; b=UQaAS6VsIWrjxkeEfQ4H5iuCQYn8gRwEQ5+4RXnf1DQewkrwSP
    LA7PAQ7V5KZngAHGevFolQ+/h1lWngETmglFJgcHHqk/NX3bsqk+vzsls24WndJ2
    ZdSWtWiu5qQqHvyWf/rijejEj9eioSgmC7hwFPtRyIuTN3d5UERfVAEcrzqUrxg9
    Rqy+c0ClugL9Xcnd48MauFMQ1QjWWtuWakESQjQ2IR++XwO0c/fNWQXDLJPIZiRf
    7rW6so6fWqnSgI7dZjMSeY01sdAm6nBOAohoumpbqA/5XISvSDwvXmTWr9eOMvHt
    GD7sliPd1gySNELZtogAU3LrYy/JNZUIZTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523897588; bh=3nezU4X6vszHEI5y7qyQA+AkShcmvNgJQC/D/SxZcc4=; b=
    UfFcvSO2VoK2nJLeInRTEtA0v6ShJH+H2ALTNJl2/OLFLHFJcC3TLDixXwaHjhMA
    Led48F9UoG506/kOdGKDM9OAnsdHM+CifFwS8s8qoI6YPkZCOw9RJbtshuVe0+D6
    Tp0iO4KFF7RVgvP/xlSDHRwCX2uu33qDmY1MqLOWcm3mOoh9v1e0F3WmyASjXqgP
    T3VT3D6LaXp3ou081ky/mxxDFHXpupZp07zyvgMx79Kga06K/6JFF9ylWKnr4b90
    5/xe13qAy7DsmSBTaAQAIXOBsGESOXSTrypQz3eq6Ry1Z8Y+IcVj7fFglXaeHWzl
    CDeAX51gEgnCZXPYmfx/bg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BMTTB+ok x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BMTTB+ok x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVrmnEhZ+iM9E2PYROWmkDhWfptJrRx+qq/s+yPt2OsBDXHBhmwaDGs/XSEWRf+oWETXmWRcnoAl94NjtaSe+hngeoXivFCFkjxvvdG+EJ6PaDJeJKK
    91x3oC838nSeTowxDo8zc3Dwpt0Sb8NKyvrTbq38oL+G+gU92u0Lmn+gy0RrcsTssK4TMjrLCY3aXD6yOPLMAK2HSAUBlaR405NY0Y25dSiR7bNu0PbHi0v5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=LKm0q7i8iHXf8934WjwA:9
    a=dIhjur6NHNyLdrKN:21 a=enJU1pQ4qS540yCE:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeDPQxG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:53:06 -0400
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:30912
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752902AbeDPQxF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:53:05 -0400
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAAJjAIAAAleAgAAEfoCAAAGdAA==
Date: Mon, 16 Apr 2018 16:53:00 +0000
Message-ID: <20180416165258.GH2341@sasha-vm>
References: <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home> <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home>
In-Reply-To: <20180416124711.048f1858@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:adCCv90Ft0/Yksk7E/mZ41eyycOAG1iBC/ZLW4XcsobUykQ//kX1NdVsGdMSK4+Rl1Z1CEQ99m3RPjUAzR1IUeQAWuwk3+1aYMTUvMGoL0ae2z2XinZHFlpfH9lTZxRRhomO+MxULNssg27k1VUNf3q2rKiQixqzhE9KCkxdGtOU10iwOwkdDDUnk7bbHoKz+8XKC/z2wkeQnyYL1RfJkqB9EoSkcp4Ietu0p2Baunwt5m0yb4EwjROh2uZXMW28;20:WFG0eHhcHGIwjJ7KBp98+04INcqs8juq78yX329O7M2ZZRQROTQ3usKmWy89DqDy5dlhbNjihJ359OADam2PXU2kRAE6buktq/a1DOtcxvXVzzBSVI6RMLmvX3SiJRt9dyV9cbkTEEOeBe7ZZ03p4CTvuwGjv3XqvRz85nq+CPg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967339DC11C404D6ED501E9FBB00@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501347)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39860400002)(39380400002)(396003)(376002)(366004)(189003)(199004)(6436002)(6116002)(3846002)(316002)(93886005)(186003)(14454004)(7736002)(68736007)(54906003)(486006)(39060400002)(3660700001)(3280700002)(10090500001)(6246003)(10290500003)(26005)(6916009)(53936002)(6486002)(102836004)(2906002)(478600001)(72206003)(305945005)(99286004)(9686003)(6512007)(4326008)(1076002)(66066001)(229853002)(11346002)(476003)(446003)(5250100002)(25786009)(5660300001)(76176011)(22452003)(33716001)(8676002)(33896004)(97736004)(81166006)(81156014)(105586002)(33656002)(7416002)(6506007)(86362001)(86612001)(2900100001)(106356001)(8936002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pRI4hYeuDJF2XAo8xsh37Mh144iCiQYhXqnKi9RsV1caME4cqC+WsrOGt9G5tMJLiilIBIAxPi9LxFBtrNJqNjqMduFCGYOTUx/wxs+0RUO26C0D4OH4RpThwhUfwe/A4FvFDxEWfmbWeSGEnx2OuBUdw7ajWquAQPJzrIhsw1qn8kffuMYMaOZiucg/YmJx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <350FC0434CF1254DBE9401FFE3F4C425@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 79c725c1-dbe3-4cd9-a72b-08d5a3ba8376
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c725c1-dbe3-4cd9-a72b-08d5a3ba8376
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:53:00.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:47:11PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 16:31:09 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> On Mon, Apr 16, 2018 at 12:22:44PM -0400, Steven Rostedt wrote:
>> >On Mon, 16 Apr 2018 16:14:15 +0000
>> >Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>> >
>> >> Since the rate we're seeing now with AUTOSEL is similar to what we we=
re
>> >> seeing before AUTOSEL, what's the problem it's causing?
>> >
>> >Does that mean we just doubled the rate of regressions? That's the
>> >problem.
>>
>> No, the rate stayed the same :)
>>
>> If before ~2% of stable commits were buggy, this is still the case with
>> AUTOSEL.
>
>Sorry, I didn't mean "rate" I meant "number". If the rate stayed the
>same, that means the number increased.

Indeed, just like the number of regressions in mainline has increased
over time.

>>
>> >>
>> >> How do you know if a bug bothers someone?
>> >>
>> >> If a user is annoyed by a LED issue, is he expected to triage the bug=
,
>> >> report it on LKML and patiently wait for the appropriate patch to be
>> >> backported?
>> >
>> >Yes.
>>
>> I'm honestly not sure how to respond.
>>
>> Let me ask my wife (who is happy using Linux as a regular desktop user)
>> how comfortable she would be with triaging kernel bugs...
>
>That's really up to the distribution, not the main kernel stable. Does
>she download and compile the kernels herself? Does she use LEDs?
>
>The point is, stable is to keep what was working continued working.
>If we don't care about introducing a regression, and just want to keep
>regressions the same as mainline, why not just go to mainline? That way
>you can also get the new features? Mainline already has the mantra to
>not break user space. When I work on new features, I sometimes stumble
>on bugs with the current features. And some of those fixes require a
>rewrite. It was "good enough" before, but every so often could cause a
>bug that the new feature would trigger more often. Do we back port that
>rewrite? Do we backport fixes to old code that are more likely to be
>triggered by new features?
>
>Ideally, we should be working on getting to no regressions to stable.

This is exactly what we're doing.

If a fix for a bug in -stable introduces a different regression,
should we take it or not?=
