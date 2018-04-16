Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3665621-1523898584-2-1245774626325261110
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
    1523898584; b=gaw6dafKeZyJQO7iGdpTHt4ed8Nve4nTetTtFLzTZuxl+l6NkR
    wDFq+UphcwtGf5m82Yrd5u8pWzs2cAzHmFLqhs3gkEgEf1bvlcQ8rDE/8B1Lx/Gr
    B9Zg1/rmLMcsC8UQuGyChhTJEJMyXRGCATKHIXXEvtIWb0Jj5Wb6GoTq0jjkPdpS
    KyRuP6cPvuepn4zfP+S0CLLgfRj5fZrtAQfwOFidao1Yfi4InVoCTuOZAYSM02s9
    QbKXOnJ4HlJqS44qig3PDP14BjPVxlujyg5xbK7zGVbdkomPbF9C38G/0CttjWT4
    wgxEEjCcytgcXmEzdjSFzlp1pcAY1hh/9EgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523898584; bh=2UDfmGfCu4bhM3dYXDUTXFKcAu9hqFOe8UK/DqyR7zw=; b=
    FhHlZJtbUR84h5XKz2pYkpLfucGpVEuu6xkZNoHwLwmXh9waOt0g4zQc8C0bq5wO
    ue9qFGtNzyTQMtQw0NX/ZMzJ9sWUZt3nouZ/ADcajvdEem86ZUld8IwGq5r8NLtj
    yYWh+W5dBWVQEMKYrEBWh5DBhwZkPur5bfNH1SwTcYPu/V//VfUhb1g3bzlq7kCz
    u/pLBQxKXMdWG4Sehv7kOv6W4bsCWkXImnYGoiJ63/8kS/0+kZlDrEXNUpo6+Toi
    kjKSPdMvcVBArSH7my0o0WTmqYLZyDyde1jDIZjicTPfrlfyqn0PzMuJx8r8TG9I
    sKoDZG7sru3ew8Pvr9SWmA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T+8Q3m2d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T+8Q3m2d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/dJu511FyK5jr76kj9oGutS1Smaa5LgKrCbvam4W/VqKukc9IyKQj2Qm7aalXX8qypSqckDMmOBSiZ09Vu8gcRtnnfjCtQ4ZWbUDk0lbcNKSOZGy44
    aJ6JAEJhGAXCtJBYMVH8reEwipUqaMe7yNKgkCGrQ+pCfFaxNmFeka7FGvw9CweY2myKGV6er11/s8QHpxZBX1/NiVhb4jVXZECap85yQ4aojETXW29v62Li
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=oXBXaTmDLn9dmvlOoDMA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeDPRJm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:09:42 -0400
Received: from mail-sn1nam01on0091.outbound.protection.outlook.com ([104.47.32.91]:56400
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752666AbeDPRJl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 13:09:41 -0400
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAAD94CAAAIigIAAA1WAgAAA7ICAAALHgIAABJsA
Date: Mon, 16 Apr 2018 17:09:38 +0000
Message-ID: <20180416170936.GI2341@sasha-vm>
References: <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
In-Reply-To: <20180416125307.0c4f6f28@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:qi/6NiV3acvQsnGyCJvNqR/DoBmtXOZo7FrjDY5dlp32k5FJ7iY0UtLYcK5dUIdHuaJy7/LjvfR2QKknLgTKTPHk0hvPpKHOqoNn36N/MjTMbPRcwnB36gjxlgW6OSF08br3yeascyjVPDEQpdQlsgFqby5N3XuZLP3jaT+LQlXRc6uPWyqXaTl/pOU8Xlzpc/rXhm4ok/KXc9LOS4Y3VrJs4IWqZxwos4aI5ZENhrWfBFX79EKGDZo++PM1sdB1;20:D9yjsg2tPQIOZLNmZ8x1/SLK0bRiHHKZD2sd0+K0GRK1bdRee8FrEAR/4F26pe3yJeku6qGoNSAj3XKzDiei0h9XZ8rIJTH4zuhgZl2kMvDsft+btvN2TN2k7j7GP8f52kAHj70Q1390iQ9lCHdrMaYh4VMyp9NgsoLkarp6uxI=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110985D13F70146FDD22BD58FBB00@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501347)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(86612001)(229853002)(33896004)(105586002)(99286004)(59450400001)(102836004)(6486002)(33656002)(11346002)(6916009)(476003)(33716001)(575784001)(5250100002)(446003)(186003)(86362001)(93886005)(97736004)(76176011)(6506007)(2906002)(7736002)(26005)(5660300001)(6306002)(9686003)(6512007)(72206003)(2900100001)(54906003)(66066001)(6436002)(6246003)(7416002)(8676002)(53936002)(478600001)(1076002)(81156014)(81166006)(966005)(14454004)(68736007)(3280700002)(10090500001)(39060400002)(22452003)(8936002)(316002)(4326008)(106356001)(3660700001)(486006)(6116002)(3846002)(25786009)(305945005)(10290500003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +paD3yw8+pim99EWnAaSharSVyifKTeCl59s5rI9R1KbLcJFbRH9RqHmbJ9nMpO+RsmPewXuVY7gvbYZWRFPQoiHUZ2UNuVlouu9FK7nJVyPxlADlnRTlx9E4S9VlisONeu+v4S6r0T77JU3oAn6u1JwMlcGSIdacM3AELPrrREyfT5aPBZ5iaLjkD+1EsPf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4CDB12CF0C4C3D409CA5A741DA011A90@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 682f531e-75b3-4d73-7f22-08d5a3bcd68b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682f531e-75b3-4d73-7f22-08d5a3bcd68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 17:09:38.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:53:07PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 16:43:13 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> >If you are worried about people not putting enough "Stable: " tags in
>> >their commits, perhaps you can write them emails "hey, I think this
>> >should go to stable, do you agree"? You should get people marking
>> >their commits themselves pretty quickly...
>>
>> Greg has been doing this for years, ask him how that worked out for him.
>
>Then he shouldn't pull in the fix. Let it be broken. As soon as someone
>complains about it being broken, then bug the maintainer again. "Hey,
>this is broken in 4.x, and this looks like the fix for it. Do you
>agree?"

If that process would work, I would also get ACK/NACK on every AUTOSEL
request I'm sending.

What usually happens with customer reported issues is that either
they're just told to upgrade to the latest kernel (where the bug is
fixed), or if the distro team can't get them to do that and go hunting
for that bug, they'll just pick it for their kernel tree without ever
telling -stable.

I had a project to get all the fixes Cannonical had in their trees that
we're not in -stable. We're talking hundreds of patches here.

>I agree that some patches don't need this discussion. Things that are
>obvious. Off-by-one and stack-overflow and other bugs like that. Or
>another common bug is error paths that don't release locks. These
>should just be backported. But subtle fixes like this thread should
>default to (not backport unless someones complains or the
>author/maintainer acks it).

Let's play a "be the -stable maintainer" game. Would you take any
of the following commits?

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/com=
mit?id=3Dfc90441e728aa461a8ed1cfede08b0b9efef43fb
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/com=
mit?id=3Da918d2bcea6aab6e671bfb0901cbecc3cf68fca1
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/com=
mit?id=3Db1999fa6e8145305a6c8bda30ea20783717708e6
