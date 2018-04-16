Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3578680-1523894531-2-12324155440554228436
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
    1523894530; b=oEmfzhoEs8hYfIkRbelKEB3Z//IfOT9yQrpQ23mmm2TVTzyVMn
    O80aYl/ql1uriFmgtD4BCHfKFepNeiFP7XPZGqQnZ+0HA5SrnfaDLce+BbjHNj6i
    KH7sBUV96rzEBoqT9cPmNnTxB8ZJzGaNbWAlVniLwWQagBBmU3qs6I3E1G2e+1Tp
    T4Sg+t4pEJl/bIKkHS4I7sFgv2x54YB2xYUraRxbzYtwbcWKNQPr2Jwy72943lqf
    guyk6mzviWnm1VxYnuK6rHXIsFpimZuM1uEAFQbO0B4QtPjyDvIvejAk+foaaQrN
    rXIPuKcwnfvZAQrpAv05j+4KzcEYbKRY+CHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523894530; bh=bVlmiGgo9lE8Yybu06TsWmNLBhGu+XrtCtfxvoTa7/A=; b=
    PKkVPmWPu7UIE8fgZFw5UFCJqn/LTVbbzLdFbvp38CmVEzeTgVF2mXnH4bEKrnz/
    cLaaWwXIfXSe58zexkIEDNO3vxsygIvY6v1F9bqPOfDYbwZ6MpzJceZmi77V6iwZ
    /KME41Z1Rs62otltDiO39+3tClEkS0xXC06Vz9fZXHpMJggaRUozNq7kexBvAUqg
    ubADpM0BYTV9wdTtLVNuOKJ5Lzke8YkchvgT8wQ0Qx7csbcSmVGigxvrtXRrXZJR
    aHNfQEBE0q5xNEt99ME1QCq1RnDEq7a72SP1JlqMLJaJyDcfg1W7qnOnoS/Rewbt
    a261Y5a06tDgaBjdvDZa9A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J2gsYi4j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J2gsYi4j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOuR1iLOPNlvgaLXETlwSo7MY3W5TkFlF2cHdASNo+IHbyz/zupCpaOoA9jbAljRC2TxFj5aHE+wFDuASKkAHT6nkAkhJ9V0Mf7yeGVgeRepwePX7/wR
    tLDK8sKSURYVEoaNflqyeQQBXEajLV282+4JBrsnF+nqMhCzK22v/nxLSHY7iAiG4RYr3Hq5RXRk2u0vxVQvTAE+VAWL1E9WwJSI4H752LMJVOR7hL+3juJs
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=0kFj_KZJ5l46gtkQh_AA:9
    a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeDPQCI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:02:08 -0400
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:23166
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752609AbeDPQCG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:02:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
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
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAA==
Date: Mon, 16 Apr 2018 16:02:03 +0000
Message-ID: <20180416160200.GY2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home>
In-Reply-To: <20180416113629.2474ae74@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:vUgOEf0gAHuRctq+UcW22EFpoYIk/JQ6I829N3P6x4q5XB18lv0w5P3kyciXcZIJDP42GqvXRt/bUhVLWR6wGL3gyKUXQiF/Ky6p6941KEg3wtrXfs0WaaBWZmdqt8/wO+DyuuNmvjP0kiV3NCpn1yhAbnUU5RqjI/94wed3xPYuZacCJN847SRewfv5Fhj1aFO0ILExgWENr33V/I4ZG7Nj6/Ms0dZpk9BcucxUmuckoMIW5aCceOt5voKFcbkv;20:LKSU8XTk+M8e63BYyqfRb8cO3fHqze+X0EmW+mNfJpBXwYxSRQM7FaViFvFZEyiM4wLMyPETJFiixNlRj3Bt2hiOQ7km+Scow0a67qlof9APreDrJwu1euyMsdyWO/Wckj6qZT421fkrZjSUFDBbr31ZBZCsxkXLm4nzxdsCGSA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030BA87EC65CE9BB21EEEFAFBB00@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501347)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(376002)(366004)(39380400002)(39860400002)(189003)(199004)(54094003)(11346002)(316002)(446003)(2906002)(22452003)(7736002)(6506007)(2900100001)(53546011)(66066001)(105586002)(97736004)(33716001)(10090500001)(478600001)(305945005)(476003)(81156014)(86362001)(81166006)(14454004)(33896004)(8676002)(6916009)(54906003)(102836004)(3280700002)(486006)(10290500003)(3660700001)(99286004)(93886005)(25786009)(4326008)(26005)(39060400002)(33656002)(7416002)(6436002)(5660300001)(86612001)(6246003)(186003)(72206003)(53936002)(106356001)(1076002)(76176011)(68736007)(6116002)(8936002)(6486002)(9686003)(229853002)(3846002)(6512007)(5250100002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qhoDCrYgKF917kAlJKGMM194xLSOQQ3ylIaoc0NJc1cnV0cJnD7EOip1uZE6QBzg+G/CkOrvvuvBtZlW+Vl3TnFV2iKAAsAYyvfW9QfLRYjiCGAocMJJsrL4oDBpFG1RV6JOMzMTm6Qs9gZDUzOknDK5whf1lUffFv/MkyHiKIDgQaom4RHuY/J1sUxmmwMJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C48F265BB7B6F44681ADEEE91A5DE688@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 564008d1-e9ef-4a2b-a1a4-08d5a3b36524
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564008d1-e9ef-4a2b-a1a4-08d5a3b36524
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:02:03.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:36:29AM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 08:18:09 -0700
>Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Mon, Apr 16, 2018 at 6:30 AM, Steven Rostedt <rostedt@goodmis.org> wr=
ote:
>> >
>> > I wonder if the "AUTOSEL" patches should at least have an "ack-by" fro=
m
>> > someone before they are pulled in. Otherwise there may be some subtle
>> > issues that can find their way into stable releases.
>>
>> I don't know about anybody else, but I  get so many of the patch-bot
>> patches for stable etc that I will *not* reply to normal cases. Only
>> if there's some issue with a patch will I reply.
>>
>> I probably do get more than most, but still - requiring active
>> participation for the steady flow of normal stable patches is almost
>> pointless.
>>
>> Just look at the subject line of this thread. The numbers are so big
>> that you almost need exponential notation for them.
>>
>
>I'm worried about just backporting patches that nobody actually looked
>at. Is someone going through and vetting that these should definitely
>be added to stable. I would like to have some trusted human (doesn't
>even need to be the author or maintainer of the patch) to look at all
>the patches before they are applied.

I do go through every single commit sent this way and review it.
Sometimes things slip by, but it's not a fully automatic process.

Let's look at this patch as a concrete example: the only reason,
according to the stable rules, that it shouldn't go in -stable is that
it's longer than 100 lines.

Otherwise, it fixes a bug, it doesn't introduce any new features, it's
upstream, and so on. It had some fixes that went upstream as well?
Great, let's grab those as well.

>I would say anything more than a trivial patch would require author or
>sub maintainer ack. Look at this patch, I don't think it should go to
>stable, even though it does fix issues. But the fix is for systems
>already having issues, and this keeps printk from making things worse.
>The fix has side effects that other commits have addressed, and if this
>patch gets backported, those other ones must too.

Sure, let's get those patches in as well.

One of the things Greg is pushing strongly for is "bug compatibility":
we want the kernel to behave the same way between mainline and stable.
If the code is broken, it should be broken in the same way.

If anything, after this discussion I'd recommend that we take this patch
and it's follow-up fixes...

>Maybe I was too strong by saying all patches should be acked, but
>anything more than buffer overflows and off by one errors probably
>require a bit more vetting by a human than to just pull in all patches
>that a bot flags to be backported.

If anyone wants to give me a hand with going through these I'd be more
than happy to. I know that Ben Hutchings is looking at the ones that
land in 4.4 carefully. It's always good to have more than 1 set of eyes!=
