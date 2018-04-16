Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845642-1523903751-2-12023282503969177556
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
    1523903750; b=dX1Ck6SzeFcGZftwJtQS3m7k+ZhtX/THe9QZD2pW/hwGuhQV7g
    6mC6emObFuz/CJ1rRB/WC/vZwiIVTwlKHGGCz5rJ5Jiu67lHsAgHlXrl/PWU0655
    JVoj9IIUqHqOlW6PQQvrVpEUaALSjRwY/pG6FBGoZG7QL8t3zjxjwIKHWJCz1s/B
    9vZ0umHkE4Fibd0mKvbk0zDw04tyDUOUb77U75CebHfFwLcJ9N98a1NIWTeJKfne
    dOr1NYX6tGlS0GxZteWiTIGzLIQQE02NmH6e0awDY/uTZCQ418O473D/oOdabpbD
    uXheOjn7HeMycrkwrYCQJofONzPVV/LTLayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523903750; bh=gjLSJ5XBn/OsyRD1/4L1c5bJuQreHimJHkjlwfliPmM=; b=
    pMmEC6rY+SSamUH4DKNn24ihpmZoALZWPtUA55pXvMFHcMb+qnmc9jj53sRVJxof
    q0OeWEajFF9trlT95E44ONre68nb6GZj+tjYJFM7u5BIk2H2d9Cq+EvsGY8x2/no
    rEWIwE18wtZWmOkrZX+DmOJo9Q/jmzTcjE8v1gO9+wjQUlgAx8l0i9FH6YpRqQlT
    9JOkelhkft4hTtbK05BU6sV+M5rYLqDVhLiV1qE3IO9TNmzizLVaBFa0hOLbbTpl
    b0EpTf1QD5M3fn4HBkxBelyAiaqDowrxHEqqs8diyo5ucUXwrU8XeSQFMnMlWrKY
    Dr5o39ljLWiA4RZozG+GkA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z8mjFn9I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z8mjFn9I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBBCXtaG19YfZ5z3Q7RZciRR+TRpS+qTEo4w0A8YCs9MY/9cqviakpwPwnd8iLl0bcTAXURaG5Kok+GQhcZQNF+XIKJg/geytWOlW+O39dc+YFS/vjQg
    DmqD//5SjlXWXoh4EFOS6Q9zSA7UZdQuqC/b4o40f6Wt7E9fc+i9ZntyieaA3ZEs2NmRW1amyygVr1JrZuetrBlXOnktQ+rr1EPxrERs2R5wpCm4DQ8TvdrH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=Rf9ZfyFBVAhz81RCc0wA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeDPSft (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:35:49 -0400
Received: from mail-by2nam01on0134.outbound.protection.outlook.com ([104.47.34.134]:57626
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753197AbeDPSfs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 14:35:48 -0400
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
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAAD94CAAAIigIAAA1WAgAAA7ICAAALHgIAABJsAgAAGo4CAAAKVAIAADGCAgAACdgA=
Date: Mon, 16 Apr 2018 18:35:44 +0000
Message-ID: <20180416183542.GN2341@sasha-vm>
References: <20180416160608.GA7071@amd>
 <20180416122019.1c175925@gandalf.local.home> <20180416162757.GB2341@sasha-vm>
 <20180416163952.GA8740@amd> <20180416164310.GF2341@sasha-vm>
 <20180416125307.0c4f6f28@gandalf.local.home> <20180416170936.GI2341@sasha-vm>
 <20180416133321.40a166a4@gandalf.local.home> <20180416174236.GL2341@sasha-vm>
 <20180416142653.0f017647@gandalf.local.home>
In-Reply-To: <20180416142653.0f017647@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:O6NClnmYqsKB2cLncAU/yGrSyqKNEUdh35QphY1DNIvLe2L86ykvPldZYWNz9U/e6kfk4WiO4C4WloEpGkcECawOkxEs7RW5Bt3QeM3lWKKP1Afkghwknl6Gwa68S+TN4ao8tamSItF6GfLgu7K00RX3juRCqJIJO3YDDGci5yr9d37beDI/in+psA/dWgy+08+Rlu4jWonwKC5DrfQMmdZTugFW4zriRlRJlhsKgnSdETn+XimqhHElG11HWpr2;20:QJ+4zx8KAqKrloOCIT8Rhjk9e6FExMwdCYn4u3+0Ovv3Ou8U+GPMW2pcsdsFpXqbDK2+L9EXbgJ975q5SWKw1GC8iYGgLoY9/eyTACUzfOMbsjtms7oIM7FqguWRUxe4ffaMqmJl5+VhI7MDZNMrQ9IUwhQLaBxd0Hol6cezDAo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128C36E0A26857C5BCD00BCFBB00@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501347)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(366004)(346002)(39860400002)(39380400002)(199004)(189003)(68736007)(6246003)(305945005)(6916009)(6512007)(2900100001)(14454004)(106356001)(6436002)(39060400002)(33656002)(53936002)(9686003)(22452003)(54906003)(93886005)(316002)(478600001)(105586002)(72206003)(25786009)(8936002)(10290500003)(3846002)(8676002)(81156014)(6116002)(4326008)(5250100002)(10090500001)(11346002)(99286004)(446003)(86612001)(2906002)(33896004)(81166006)(33716001)(486006)(1076002)(476003)(6506007)(7416002)(97736004)(3280700002)(3660700001)(7736002)(76176011)(66066001)(86362001)(229853002)(186003)(6486002)(102836004)(26005)(5660300001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /TIDYhxsbBe28yyH7L8wnTPgqlVTkpJVO11NoNnpvAZwmqNr7l5QoLlS4UvuX1uHD1UP37SqF+oUQVcSi9GQxNPH3k4kxy27VFzzHzDCRT4l3XeV0NHeC5jOD4UKLTQN84M3dLxue+afcQlIBdg+2EpVqCA0XEpNw/7C5JxtUUbDKXcc0RUdVy5rkrAVTOGH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6F4768DA2D9B7409910EC330F4EC0F4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 04a4fde5-94e2-49d2-59b7-08d5a3c8dd9f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a4fde5-94e2-49d2-59b7-08d5a3c8dd9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 18:35:44.7336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 02:26:53PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 17:42:38 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>> Also note that all of these patches were tagged for stable and actually
>> ended up in at least one tree.
>>
>> This is why I'm basing a lot of my decision making on the rejection rate=
.
>> If the AUTOSEL process does the job well enough as the "regular"
>> process did before, why push it back?
>
>Because I think we are adding too many patches to stable. And
>automating it may just make things worse. Your examples above back my
>argument more than they refute it. If people can't determine what is
>"obviously correct" how is automation going to do any better?

I don't understand that statament, it sounds illogical to me.

If I were to tell you that I have a crack team of 10 kernel hackers who
dig through all mainline commits to find commits that should be
backported to stable, and they do it with less mistakes than
authors/maintainers make when they tag their own commits, would I get the
same level of objection?

On the correctness side, I have another effort to improve the quality of
testing -stable commits get, but this is somewhat unrelated to the whole
automatic selection process.=
