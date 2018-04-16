Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3665621-1523896091-2-4513426487163213287
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
    1523896090; b=r1aTpTY9bifwEugnqjqU9B8aekPvxBv3z+aRtTcYbkcmz+noEU
    OMYeHjjwbQXC4v4bHruS5hm5IhPSaDlKFyxyYE28W3bdJCORr4qDucQCejyor5l5
    emPJQRjeqAGNc6saR/OYHUujUS4j961EVUq8LoUpXxAhNMlqTz/mYFhjRpPamw4U
    V4sqkaYUQzki5sm5ay8Mg1BZ/PsX4AIr+sveUnFlGlhl8bk5AKZ/VqwQInUhbi2O
    6hMTTog9o0GC1dbXwv18XOgBkJnEIKoR9KcOZqGtoBpNqWZRbcEldZDaNH+So/IV
    F3sLZnLUMe04pTd93ooa9/YYf6AI2VsybEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523896090; bh=KiVweqsen3dUs+qQ74VRV4rhx3lpIsxfNUZ0AZ7dA6M=; b=
    Je6im9527PRv8biJYW/kaiXDxHKS1sndsHIjlW/bsIy7Adn5H+s8Pp3UKDMuc3BG
    RrZqacEC7owRx+2HsJsVY1mCxFAds6MZAuAqMsnusnnA6uzW5EjgQQ5Woe71LZXd
    PKz6uMoqUM2cgu1hzT7uONW7KTMFqeMHte9yIiJAgPef8o3rt5Pf5Gzc76dtOmNF
    pTGDp34nrkPcNUXo46bUSXQ2VvrTorqxAOPLmBxPZxXMqhmKkgEb33KwRAPXp9eI
    6Ql+Xb7FsU6bRTzozDs+7VG64dedwrQXB0qAdkDKKy14IGn+PsITdi2J5DRG5ml8
    G/8IHYE7lhI/aNRENmXM4A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iDfOdizU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iDfOdizU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJuMFtv2qx4Lq8wP83cMWyeu819awvQSGnP+8tmq14PHPXhRtKGrUOpwbAYcDma75eEQGDuGhyaRO4AARfa+MuIH0sDFvxrl3qVgUOrAmpUoMqH3pzYL
    nL8k15DstsUkd1K7JMsIBGbjRWGGXOXNTs/HqFLNS79gndEhw0EE6Y0+2Q6DQnZiHAnh28K/wwXgJFh1MM3nuJhrs0aqPVY/6v/yhwWp9eN0xEmZYrlGL9mr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mLchGBpZD5Fca-UeN4IA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeDPQ2I (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:28:08 -0400
Received: from mail-bl2nam02on0123.outbound.protection.outlook.com ([104.47.38.123]:5046
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752849AbeDPQ2H (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:28:07 -0400
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAAD94CAAAIigA==
Date: Mon, 16 Apr 2018 16:28:00 +0000
Message-ID: <20180416162757.GB2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
In-Reply-To: <20180416122019.1c175925@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:4F9O46Wo1+UCL2Y6QUzlHmkOwhosWc3Rllg7dyPEHZlmD/WulbphfEmd68qwf3N5c/SSVAgpey3/pBVViwDH0uwFyq4uuI70wrcsa+ap/GIz2DY12Rd1W2VyAHXpA70Oz03CmAI2Cpr9ZghqM8K13NrItpTla6s4jhzGFHBNw9qub4DCn5YnFUOTfYz5dQZNT63KhsmEkKbFR8ZIcUcsfgSfAHD1IUOF+efSzOava9tp+446qccowJvqypEHKUMx;20:vdz/4ZOQLsw4xEKKEGZcgd9ouuIo5+qQJfvO9lpGC7BzZHd0Lwx65QgEnA0nhk9r4mvIwa46MRy7EbcluPSZX6EwytOzLIDQ+0UwylDEKXU39whNPv/KVaL+Ly0Oe/TiDA3oa99G7itaotTf1bGCCqBbJPgSSXicf69pPCOMkfs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10308CD5C93CB840571157F9FBB00@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501347)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(39380400002)(366004)(396003)(346002)(376002)(189003)(199004)(6246003)(186003)(26005)(39060400002)(25786009)(4326008)(5660300001)(86612001)(33656002)(7416002)(6436002)(8936002)(6486002)(9686003)(68736007)(6116002)(3846002)(6512007)(5250100002)(229853002)(53936002)(72206003)(76176011)(1076002)(106356001)(10090500001)(33716001)(478600001)(59450400001)(2900100001)(6506007)(66066001)(11346002)(316002)(22452003)(7736002)(446003)(2906002)(105586002)(97736004)(8676002)(102836004)(54906003)(6916009)(33896004)(10290500003)(3660700001)(99286004)(93886005)(486006)(3280700002)(305945005)(14454004)(81166006)(81156014)(476003)(86362001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rq/NshPhf7Ob0FdTif6rquvj5OkFj3hxgIn7dDzAGs4LMydnAhYhdfuZXmw2XWLGS/FI3vDNiaW5+Jv8ThDrqvFBsVoWrTamFBGaGRc+DRurA3EYTraPoFJtgRPVe0r52OvL8kbNzPcNlzoJv8FnyJzNzC9bmcW1sqWEgzcfZVheu7RDKdVACxWlwiV28ade
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32A693D44F62364C9CE7D7F0F3157A72@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 55c1b7ad-9a95-4cd6-8f2f-08d5a3b7052c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c1b7ad-9a95-4cd6-8f2f-08d5a3b7052c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:28:00.2411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:20:19PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 18:06:08 +0200
>Pavel Machek <pavel@ucw.cz> wrote:
>
>> That means you want to ignore not-so-serious bugs, because benefit of
>> fixing them is lower than risk of the regressions. I believe bugs that
>> do not bother anyone should _not_ be fixed in stable.
>>
>> That was case of the LED patch. Yes, the commit fixed bug, but it
>> introduced regressions that were fixed by subsequent patches.
>
>I agree. I would disagree that the patch this thread is on should go to
>stable. What's the point of stable if it introduces regressions by
>backporting bug fixes for non major bugs.

One such reason is that users will then hit the regression when they
upgrade to the next -stable version anyways.

>Every fix I make I consider labeling it for stable. The ones I don't, I
>feel the bug fix is not worth the risk of added regressions.
>
>I worry that people will get lazy and stop marking commits for stable
>(or even thinking about it) because they know that there's a bot that
>will pull it for them. That thought crossed my mind. Why do I want to
>label anything stable if a bot will probably catch it. Then I could
>just wait till the bot posts it before I even think about stable.

People are already "lazy". You are actually an exception for marking your
commits.

Yes, folks will chime in with "sure, I mark my patches too!", but if you
look at the entire committer pool in the kernel you'll see that most
don't bother with this to begin with.=
