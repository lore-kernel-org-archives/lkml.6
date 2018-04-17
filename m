Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981994-2-8127428734972568841
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
    1523981994; b=rXciecOrfJ8aSwbrRYpRde5XPLB8g3YpJbcHZjpVYrMNWXzDHB
    C8Isu5sWfCHy+ey7ZX+q7N21W60PXrtXDFoouAE7zwGcLVpBTNzJlpEJKmvhNLjW
    xIqdsH8YYX/fiqn+tLzw+uPzekd5Ly6Bwl6vGqqQRqXIKUFM2KV+P6fthJIHl6M7
    iJ9KowDz4g3P0ArkbYhS1WV3AJQRqcC6L3pext4SNStglTCuzr5OX8+q+r3ZDiNN
    4iU8PyVQkeOQh6zA1h4M6c/nHZ49wxZsNTni+8iY4h/gQeaYqNyGMJ49vHQ/B/Jb
    aN1nTcbWk7U2KsNzLzU+0j+PZNRa4x+u7xUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523981994; bh=gzCYDZMLZ5O5okDOVvr2JMUsS1GwN+bO1RcZxogwjrE=; b=
    iv2WnMQfEjP1iCwDiUaiCEnfqmBJsUN57aArQDlPV6ao7K+pOgmBYkQ8RKMtvibY
    CJACnGlClrJsIRQnQD4dL6SJ2YHVhkw0lLMKQfp1sTZb3c6knSYvLgjhEQq/OPph
    oi/SNSu9P0RLE/ng2hfpGoEfRych5axDaUkWzylFYu0RcINOwyEuW2eAmhWDYjdL
    kruuZfEQq9XFu+KsPyzdoajxXhPbLv1rpXZpZ75eoqAnXZqV3c9mQXdrtig2FFg8
    pFYa/bm+Wtph4oytygGQPbNn+Rm4CQpfba+uWbhMmff/WsRLGiVHmgoGmV0RIZIn
    YxnlqfUuGAp0uC8eeuKyjA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C/epXbD2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C/epXbD2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCFuuADbDqtpCJUbWH0WmS00nCrQp2BmnC3DEzbngJQQ2lrwmL0cVe/ETTQjvybhxq/pMHIj5zIQHsnQidW5VgY5hZ5xBnpyvbho11C/4EZ1ybLiAYS5
    8bWQ/bknd40zHpaefHDlYY5IW3SitPelo7ZDRYjvQHcSygVKPAOFkGHstdxZLlUWPSyHkwkmtCSeT5dT42yOdk4zjK30r9pu+p/uy3kLZnh8BKQOATC1WIB8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=qHwAVdC6PccEh1uRRzYA:9 a=BsN9TcDhfwh2D3yI:21
    a=2EUiTx4m7oNUI-TS:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754406AbeDQQTk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:19:40 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:39472
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754386AbeDQQTh (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 12:19:37 -0400
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YCAAAMcgIAAAh8AgAAH3gCAAATcgIABMtsAgAAewoCAACg7gIAABqKA
Date: Tue, 17 Apr 2018 16:19:35 +0000
Message-ID: <20180417161933.GY2341@sasha-vm>
References: <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home> <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd> <20180416172327.GK2341@sasha-vm>
 <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
 <20180417133149.GR2341@sasha-vm>
 <20180417155549.6lxmoiwnlwtwdgld@quack2.suse.cz>
In-Reply-To: <20180417155549.6lxmoiwnlwtwdgld@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:Bkb1eXAtc4yZt2KZVJ3wqSzKDrR3KWH3M6cW+qNoJRCDjOiJ2lpLNTVmBZpMQ9IVt4kKOqsegJhpq7HWV6yZHDGOjMxpOpB7Mflj7cb8ozS+hGE56Mspb1osT81x5TM1jHOuFElLptkjlGmqNCwvlBHIArDSX4B+XeTIh8ib0jNoFrpqE5on/65ipXWtggxpO5jPLh0gixDuYr7sAt2Nv9M3uO9u59Mee7tqCCW6ilGYMraYk7mfZh7mt+m7jBIp;20:DMleutOREHUFb/41Q9HvDuD6qFshOP4C/J0ZhLnXq8hRfdpAkfm42qbotjUYYhMlTEJLz7AZvF6QaS8/sl9crG9OVVTQWu64IOrWtWAKD+kUNYcT/lOVUt1MVhBIlKD4g+AdzdByG54Rmxue9HJlVEoR/6t4SJnwxLUZkdqvw+o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09338D19813C054A4C19D333FBB70@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39860400002)(396003)(39380400002)(346002)(366004)(199004)(189003)(377424004)(81166006)(81156014)(6486002)(8936002)(478600001)(305945005)(2900100001)(486006)(72206003)(26005)(3660700001)(8676002)(10290500003)(186003)(25786009)(86362001)(4326008)(11346002)(446003)(97736004)(7416002)(5660300001)(3280700002)(105586002)(476003)(14454004)(2906002)(33716001)(6512007)(93886005)(6436002)(59450400001)(33896004)(6506007)(102836004)(99286004)(6916009)(86612001)(33656002)(66066001)(7736002)(9686003)(22452003)(68736007)(76176011)(3846002)(5250100002)(316002)(10090500001)(6116002)(6246003)(53936002)(39060400002)(54906003)(106356001)(229853002)(1076002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qGnA4RddCxFmHcd3DYhA8NEQ16biZn/aK+n02lTaa/EyFkh/7dEbxm/WW3nJYRuEfvY0LjQlCAXzXDTg24I2RuOcHl+DmYAMgfkMrq2BMiINmYrO2HQXev3pHQubmaMnY9MhzsgbT+GzgDo3TW/7YxTZChqSTz1x1YbTBh54CV3wmLZ3tOQ0t7EtHXmi16pB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <691D2CF14B25954AA8F1F65B4D37659A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d3150652-7695-4192-9126-08d5a47f02a1
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3150652-7695-4192-9126-08d5a47f02a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:19:35.3417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 05:55:49PM +0200, Jan Kara wrote:
>On Tue 17-04-18 13:31:51, Sasha Levin wrote:
>> We may be able to guesstimate the 'regression chance', but there's no
>> way we can guess the 'annoyance' once. There are so many different use
>> cases that we just can't even guess how many people would get "annoyed"
>> by something.
>
>As a maintainer, I hope I have reasonable idea what are common use cases
>for my subsystem. Those I cater to when estimating 'annoyance'. Sure I don=
't
>know all of the use cases so people doing unusual stuff hit more bugs and
>have to report them to get fixes included in -stable. But for me this is a
>preferable tradeoff over the risk of regression so this is the rule I use
>when tagging for stable. Now I'm not a -stable maintainer and I fully agre=
e
>with "those who do the work decide" principle so pick whatever patches you
>think are appropriate, I just wanted explain why I don't think more patche=
s
>in stable are necessarily good.

The AUTOSEL story is different for subsystems that don't do -stable, and
subsystems that are actually doing the work (like yourself).

I'm not trying to override active maintainers, I'm trying to help them
make decisions.

The AUTOSEL bot will attempt to apply any patch it deems as -stable for
on all -stable branches, finding possible dependencies, build them, and
run any tests that you might deem necessary.

You would be able to start your analysis without "wasting" time on doing
a bunch of "manual labor".

There's a big difference between subsystems like yours and most of the
rest of the kernel.

>> Even regression chance is tricky, look at the commits I've linked
>> earlier in the thread. Even the most trivial looking commits that end up
>> in stable have a chance for regression.
>
>Sure, you can never be certain and I think people (including me)
>underestimate the chance of regressions for "trivial" patches. But you jus=
t
>estimate a chance, you may be lucky, you may not...
>
>> >Another point I wanted to make is that if chance a patch causes a
>> >regression is about 2% as you said somewhere else in a thread, then by
>> >adding 20 patches that "may fix a bug that is annoying for someone" you=
've
>> >just increased a chance there's a regression in the release by 34%. And
>>
>> So I've said that the rejection rate is less than 2%. This includes
>> all commits that I have proposed for -stable, but didn't end up being
>> included in -stable.
>>
>> This includes commits that the author/maintainers NACKed, commits that
>> didn't do anything on older kernels, commits that were buggy but were
>> caught before the kernel was released, commits that failed to build on
>> an arch I didn't test it on originally and so on.
>>
>> After thousands of merged AUTOSEL patches I can count the number of
>> times a commit has caused a regression and had to be removed on one
>> hand.
>>
>> >this is not just a math game, this also roughly matches a real experien=
ce
>> >with maintaining our enterprise kernels. Do 20 "maybe" fixes outweight =
such
>> >regression chance? And I also note that for a regression to get reporte=
d so
>> >that it gets included into your 2% estimate of a patch regression rate,
>> >someone must be bothered enough by it to triage it and send an email
>> >somewhere so that already falls into a category of "serious" stuff to m=
e.
>>
>> It is indeed a numbers game, but the regression rate isn't 2%, it's
>> closer to 0.05%.
>
>Honestly, I think 0.05% is too optimististic :) Quick grepping of 4.14
>stable tree suggests some 13 commits were reverted from stable due to bugs=
.
>That's some 0.4% and that doesn't count fixes that were applied to
>fix other regressions.

0.05% is for commits that were merged in stable but later fixed or
reverted because they introduced a regression. By grepping for reverts
you also include things such as:

 - Reverts of commits that were in the corresponding mainline tree
 - Reverts of commits that didn't introduce regressions

>But the actual numbers don't really matter that much, in principle the mor=
e
>patches you add the higher is the chance of regression. You can't change
>that so you better have a good reason to include a patch...

You increase the chance of regressions, but you also increase the chance
of fixing bugs that affect users.

My claim is that the chance to fix bugs increases far more significantly
than the chance to introduce regressions.=
