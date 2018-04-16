Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3665621-1523896999-2-9671793937726366512
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
    1523896999; b=w4bpTNPWoyORVDSChuDH61aF7lg/LEMrxOyShOwiAzVRvEr+OD
    xzBMma/TdDLJr24HhsUfNvnr+8yvjXoQDaEvneTeGo1ktAOcpG/Xos3PkadB4gf3
    piBcdC37hCWoUjOMsWuBU+l+WFymyiPivHgv/aSIpmwQimkguwI0fweJ9T2TD1iG
    LiDMZZDB42sId8MjLMyF1AjcEyLWbCimQN0OU13+hHAIUStOiWb+de1gvjYZSsxy
    8IN10hRKmtUihWbAjK1+PWhnK/kIOq3jv47sYLWDRPJwafaJkKTOch2l1e+l0z+E
    Hss79dkG5mL3GWwbqkTxPfKQS/+p49Mre9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523896999; bh=IOJcQ4sVCr5TdvYtxbDghiZZ5BzkbFX5H5YI74HUerM=; b=
    I0+NXLEoaZIq0EMoSJrKwDO1sfLkCDPBNEz/sDlwY/IynWw/hvqO5urQedG9SuXg
    KUoib9k/GsNMw3BUIunUx3BLevlAcuijlwb8jwt650zRX4XVgkzi7yBjARLJ9zQq
    PLuZ6NLVQ8R5C5pGPnNfKTKd8FaznYQqES/ccHybmB0PKikWHfKN0lSz5ez5Bkf5
    Mt+k8VaTH8CUskD7HYo+a8sFRJE/6xenFifkmZiECsbhunj8Zy/LNiYbPiuCD6bw
    FnZ2NZzcdFkxQkpXBWfbl0sBIAYpQQ4ydEqt1OqLsST8TKfAsqd3lVdFp8LGymN1
    eezB6v3bRwHyeonCPkGgdQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YKZuHKKX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YKZuHKKX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE/eiFuq7VIB7nGAdXtLVlkLnOc8imDYN8t549KRM5TB0fihMfsovkVF10qXeqaFk4cwNEwMYrGufboHzaeNTq9IjXfQAjQaKwMXqlaziOpgOvulhBKk
    SP0RYrF6ehsY4mVk2HCUGwaCngYHAInSr8GQMBafR+ndniIDkOZSBdjn1f/RflEcalMBGzjjPOHYEJ6LhwaIa6zfDZLXVEec3RIRsvzqnYXS1JrwS8G4hxpe
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=eRz1Vuipfvw3u5SrtnsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeDPQnR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:43:17 -0400
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:27456
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751070AbeDPQnQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:43:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Steven Rostedt <rostedt@goodmis.org>,
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAAD94CAAAIigIAAA1WAgAAA7IA=
Date: Mon, 16 Apr 2018 16:43:13 +0000
Message-ID: <20180416164310.GF2341@sasha-vm>
References: <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
In-Reply-To: <20180416163952.GA8740@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:J024YXvPD8DOEm+xoCSkweq8vx/pFqD0YvhKgwcvvZJLoCWdnFyjBEOcPTt1rbinuAxULf57QZOFL4oRp6tVnmdV1XDHpswWbgG7DXjbzILZpGpqHqEw66QfJ3otl7WaS0W/oWVNCxyN625yDbhrQhtVlJAb2uHKtdZFt9A5OasrVE8u3bLn1omQ7Rr1t3FekHNsoVNt2VeAhaTgSHU2KISYdgFK8Lwtq3NDV0+uI3YGnIpVdYTY77WvQCFqGQ4E;20:AUrFMB+psiA3K9GkeNd5M9+QwMDAqg3Vrp0o7n1o76CsrhcgXJ5javqrLWD8T6LH/p6PUhMDQmNmu+NJ67SlyV+MHfH8oFw1n1KW2xQTicOB1o5JSXxiFGdtP8Obgi/34utV8if6gjMX/7zRh3+B95s5DeDwwSssueMr13ISPKs=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB107761A0FAAFB28D896AB452FBB00@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501347)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(346002)(39380400002)(366004)(39860400002)(199004)(189003)(377424004)(66066001)(6116002)(3846002)(99286004)(97736004)(22452003)(186003)(5250100002)(86612001)(316002)(4326008)(25786009)(6436002)(26005)(8676002)(6486002)(33716001)(10090500001)(106356001)(81166006)(81156014)(14454004)(229853002)(33656002)(102836004)(7736002)(11346002)(6916009)(105586002)(93886005)(53936002)(68736007)(9686003)(6512007)(6246003)(39060400002)(8936002)(305945005)(476003)(59450400001)(2900100001)(10290500003)(3280700002)(478600001)(7416002)(2906002)(446003)(76176011)(33896004)(3660700001)(6506007)(5660300001)(72206003)(86362001)(486006)(1076002)(54906003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +kOKH4z6wCkTYOrUTfJ4p1MdJFUQ6tHPbwBGON+T0H/wtVKmHT8RoE1QoAU3ckVSj7/NgbaszgZQosjgP4Jwg5gbJv1wxM92BPBK5AIUAT0UhXcnCogwCYFzQxhsyGKvdmQBn1ALKj6NNY7qG11RXhXGNPPejsp+B6onyH3Y3YNPUgGQcAuPeUJl8GiS3tx/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E911F47528F91A4AB1C7E5F9C2D9F832@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c84a0306-59ad-49f8-2ee5-08d5a3b92563
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84a0306-59ad-49f8-2ee5-08d5a3b92563
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:43:13.2456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 06:39:53PM +0200, Pavel Machek wrote:
>On Mon 2018-04-16 16:28:00, Sasha Levin wrote:
>> On Mon, Apr 16, 2018 at 12:20:19PM -0400, Steven Rostedt wrote:
>> >On Mon, 16 Apr 2018 18:06:08 +0200
>> >Pavel Machek <pavel@ucw.cz> wrote:
>> >
>> >> That means you want to ignore not-so-serious bugs, because benefit of
>> >> fixing them is lower than risk of the regressions. I believe bugs tha=
t
>> >> do not bother anyone should _not_ be fixed in stable.
>> >>
>> >> That was case of the LED patch. Yes, the commit fixed bug, but it
>> >> introduced regressions that were fixed by subsequent patches.
>> >
>> >I agree. I would disagree that the patch this thread is on should go to
>> >stable. What's the point of stable if it introduces regressions by
>> >backporting bug fixes for non major bugs.
>>
>> One such reason is that users will then hit the regression when they
>> upgrade to the next -stable version anyways.
>
>Well, yes, testing is required when moving from 4.14 to 4.15. But
>testing should not be required when moving from 4.14.5 to 4.14.6.

You always have to test, even without the AUTOSEL stuff. The rejection
rate was 2% even before AUTOSEL, so there was always a chance of
regression when upgrading minor stable versions.

>> >Every fix I make I consider labeling it for stable. The ones I don't, I
>> >feel the bug fix is not worth the risk of added regressions.
>> >
>> >I worry that people will get lazy and stop marking commits for stable
>> >(or even thinking about it) because they know that there's a bot that
>> >will pull it for them. That thought crossed my mind. Why do I want to
>> >label anything stable if a bot will probably catch it. Then I could
>> >just wait till the bot posts it before I even think about stable.
>>
>> People are already "lazy". You are actually an exception for marking you=
r
>> commits.
>>
>> Yes, folks will chime in with "sure, I mark my patches too!", but if you
>> look at the entire committer pool in the kernel you'll see that most
>> don't bother with this to begin with.
>
>So you take everything and put it into stable? I don't think that's a
>solution.

I don't think I ever said that I want to put *everything*

>If you are worried about people not putting enough "Stable: " tags in
>their commits, perhaps you can write them emails "hey, I think this
>should go to stable, do you agree"? You should get people marking
>their commits themselves pretty quickly...

Greg has been doing this for years, ask him how that worked out for him.=
