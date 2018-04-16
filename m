Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523896684-2-3030488060046646225
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
    1523896683; b=aYrKOIKRt6lW4wNPdl7vlwVp1Gde6aFTf4rKnnOeYuMe2YhXQV
    Z1yWh4rhMyN3cBEZM/QgqPG51adq04eqsbnxi9fkr2octzUba8Gc2C1/8UMXfT/D
    VZ3uihiwZj3m+wbzOEhLeBMLjFgjEUgYC0k1h99lciOnSzG/KwRc6gJM1uuHOpo/
    OxXrvdGIFneBK8txPnaTVA6i7ng1jQ8LtFMU0BB0+bSHvBcFcfpeW3UAz8Ad1inY
    1/y5GiRqBimX362V6NK4LZBBqE2DqvnJmRJIQIg50GVot+iz7A0McK8EXwm6sZYg
    li2z3e55y1UtL0L2POGkh/5+5EsKzCgUj33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523896683; bh=p+KrWTM4KCfQHVnYZWwjJLV0s7SZv6aQ5btuB5S0ZqU=; b=
    TV6apz45AJJzvXrHrcwwFduy3wBB0Xzyr0s0QikmrXycXIViH40Mde1uzuFNOlql
    RkuHLPkIgqQLGf6sFaInZt3con5d7GTrPZTpbVS+kJA8LeP8UV6yBnno75rF9tTF
    aKF3r5QAdAYgG+VtRGcadTTVQLf6uvwK5ehozcd2IjYvupVNhnJCoLaozYtGGVN8
    19oUC/E2eJfZFRvN8qRfFeaE2mlk5lqTUFsQfcq4ZE8pp6rciiFObheeoPo3UBYh
    Z0FfpWo7y3mjM6s3RJG1Ou5c9lgPcZu4Ngf98OQCvSe0T9xgkSpgB+eruHHbn+ru
    H/iZe9H8Sg2V8qTD63Xx8A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iZrULvRS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iZrULvRS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC09/jZwiUOZYCBA4+Ak6BcZGdBMVPs+FoBCC7cC4QbRz2n8WnXMqvXvAd7GTFJebxYJv2/YDH5LDYfvrmcmv5eGSZwvTLkG+VLBNW2aI2HfKYCq8yZj
    AdFxoDgzC9ZBZYDtnVO4+F6QOOEQeCAkrHv//L7bgVqDG40LpPVFAAYg2NTiZqr23dSVjpb21y/0FmBP5DyRJAaDsAXozHwFA4lyRj0FXNm+7SwpHk1rcrwa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=pCrMwNPSiSlshvviLFoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeDPQiB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:38:01 -0400
Received: from mail-by2nam01on0109.outbound.protection.outlook.com ([104.47.34.109]:22831
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752620AbeDPQh7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:37:59 -0400
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YCAAAMcgIAAAh8A
Date: Mon, 16 Apr 2018 16:37:56 +0000
Message-ID: <20180416163754.GD2341@sasha-vm>
References: <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home>
In-Reply-To: <20180416123019.4d235374@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:0JeLbCmcWLxuKLWLCQeIXuSkCRREI4uuEYkO0cTlOW8wS6E03ShJ8FtCkt0J1n4Gse5K7d4UOep6RuPkae3+7HEMhS3XYdRJBY7xGs/64YjaoK7xQJVBp36WYPF78IutUOOCqbNMSjKyNs+Hrhk+OihNjXQ/WVipizS5paukxtb0N5QrEhW5jySACIbk94HUBXpLHrAudywX3OwpC3YWjDkqyVIfm3P+2LijwiNTDOUf6zrlN46hkpIEWGTlVD4X;20:xlwgSdtMhpEACIXj2lejPt8dRg92ryELsCqRxzWtlOUaP+oBsdgG/bBs9FY7Jh3oUoQPTEjXn6mqO+JxCFDxyFRSJ3KwUJI90kFswoGHMmxHLvBRCFUfESuqSESlXEn3HKM9cvku/B9BGALtxZkMYQpQz9DmLAJE52qDnlD/+pw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014CE2CDDDF9E54ECA47545FBB00@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231232)(944501347)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(396003)(39860400002)(39380400002)(366004)(51444003)(199004)(189003)(6486002)(6916009)(66066001)(99286004)(229853002)(54906003)(26005)(6506007)(22452003)(33896004)(86612001)(33656002)(93886005)(76176011)(2900100001)(10090500001)(316002)(102836004)(8936002)(106356001)(68736007)(81156014)(81166006)(8676002)(5250100002)(7416002)(3280700002)(2906002)(3660700001)(1076002)(33716001)(11346002)(305945005)(446003)(476003)(486006)(53936002)(6512007)(9686003)(7736002)(186003)(6436002)(39060400002)(4326008)(6246003)(25786009)(5660300001)(105586002)(97736004)(478600001)(6116002)(3846002)(72206003)(14454004)(10290500003)(86362001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 67Crm/7GR8QgeaBgu5Oc/NbdummUdf2H/9wDjQvh7tNuci5w94wN81UbgS5rC9Y+/pqg3BEpafWybtklrpvFAS7Fh10bsmicFFWG46sdP28pBL5e3AbC6wt/PIeHMqnhjzBQaI/p8rAHtnpDeXSZNzg/WwN/d8u3zNsWivo3N+INDVrw7v/0dW1p5B+c+xSH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F4DE755B469B843A412DBA81A8E3C33@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 21b0796d-df18-4a35-6499-08d5a3b86891
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b0796d-df18-4a35-6499-08d5a3b86891
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:37:56.4520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:30:19PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 16:19:14 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> >Wait! What does that mean? What's the purpose of stable if it is as
>> >broken as mainline?
>>
>> This just means that if there is a fix that went in mainline, and the
>> fix is broken somehow, we'd rather take the broken fix than not.
>>
>> In this scenario, *something* will be broken, it's just a matter of
>> what. We'd rather have the same thing broken between mainline and
>> stable.
>
>Honestly, I think that removes all value of the stable series. I
>remember when the stable series were first created. People were saying
>that it wouldn't even get to more than 5 versions, because the bar for
>backporting was suppose to be very high. Today it's just a fork of the
>kernel at a given version. No more features, but we will be OK with
>regressions. I'm struggling to see what the benefit of it is suppose to
>be?

It's not "OK with regressions".

Let's look at a hypothetical example: You have a 4.15.1 kernel that has
a broken printf() behaviour so that when you:

	pr_err("%d", 5)

Would print:

	"Microsoft Rulez"

Bad, right? So you went ahead and fixed it, and now it prints "5" as you
might expect. But alas, with your patch, running:

	pr_err("%s", "hi!")

Would show a cat picture for 5 seconds.

Should we take your patch in -stable or not? If we don't, we're stuck
with the original issue while the mainline kernel will behave
differently, but if we do - we introduce a new regression.

So it's not the case that a -stable kernel will have *more* regression,
it'll just have similar ones to mainline.=
