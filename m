Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523897126-2-3374454024405616540
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
    1523897125; b=GG0YyWHGghDvJBgoya1GS/ofm85UrfAJwf4lyMVV6B2qoWPrRt
    101CiwzyzMXLSWpJgSXfXyw4z1QH06ibr4wPUtzWvIGrT2l14aeCC1L7NwYTv6b3
    sh9ZMmBa8jk/BHA84bK+3It/60CSsWcJ4rQDhGEoyjbwqu7co2rmmCln2vOo5H6u
    ai5SptwY44WZZWkt3+hjAaNq4ig49tCepLf1utV5nOE5M4M5+cR67ZYs4G2qq/mz
    jvxJlRuNTQ1fEDTTUvB5KiRUu4MaQf7NEV1CGKlrbdUHBZAYCPA0KYiGahTRTZzR
    S+dr0Bx4qyfsbz4uryoARvXYUHnSEHrnW4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523897125; bh=T7AWMliGYyfFhnDpTUT8BBMzLGTcfszcYsZ2ERTIHBg=; b=
    ASmviDw/Qe6enzH1rNg69+yQ+4yELVeSqHboNqEJGS94MjIt9Y2kHiyAcPkcTlJp
    rEB5L/rHvRKv0F2ySfF8XjZ23Axg3QzF6A3M685kIcSAGFsHIo0FYQkFthRnlBxB
    2schfLXA4OnqdiiUeDgG9Ho2Ordanc8M86ZgL3lIIJ8g4hBnxtk9ofgyLw8gwtaL
    4jsY+BfNyo4sg5BbX/5SLiZ3TTYKqFHNrqbRYfiKzj0EjPgMOYaNX7Oi6sfRF1ul
    ZU2BdSTiV1WUBW5V3p2es3Xs6TiPJejSAVl/cmDwzHAScTEpF1OM862Xl6/5UHyk
    pJ/wre2jCHftezTIoSyzbg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PZ3Xr97r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PZ3Xr97r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLC+2SXTphHZjvpQwji7RZKj3pIR80Zu3dE5pbCCqF5Yjnn4dXAa8Q5dhzkIJBFUyjuM1srmeizcM636x72DLXBcOjqfGMYbX9/MFXTsr2I3O0bc9elH
    Mz8y9amNTJmP4cHfO/oJmyyTdnYe1QO6+XvjF5ON0F9OWjiwXqlPgbLOlcO2HF629y4azSTr4yIQiW5LxM25vMsDSEP74gO9EccJ7N6b9lsWs03gAQoubhkJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=e7ubv2peixlGJVboVy4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeDPQpY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:45:24 -0400
Received: from mail-bn3nam01on0117.outbound.protection.outlook.com ([104.47.33.117]:36294
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750972AbeDPQpX (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:45:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAAQXAIAAAuyAgAAA5gCAAADDAA==
Date: Mon, 16 Apr 2018 16:45:16 +0000
Message-ID: <20180416164514.GG2341@sasha-vm>
References: <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416162850.GA7553@amd> <20180416163917.GE2341@sasha-vm>
 <20180416164230.GA9807@amd>
In-Reply-To: <20180416164230.GA9807@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:zcLFLMDvOy96YRuQ0deVPDGvDc/UnVSJiSnqRpB2hmuqXq5bJF4zRX2SmhTmwcXpVRD5LZ8lPr58H48UABPViAS4XvzVFcBi633noSpsuCkL5kDhWRT+4KsXzClw0SLw7d+2Yra49Lub4uqWwybtQZnBuEpE3RKwoxGxG4cX/XWPbx7Y0Xi5g8aT75AIYXXMD04cjd3Mk7JgxFZzt9MgRdn/a06b9k9NpXeAinijztaLvyQMeMZBHyZA0IVBl84+;20:NuKLL979vw0twH8v3y1v9F8U+6NtajZTJTzRvLf2mHCjTS9IudiCzUCt0KIuKWcjNYS0euo+ItxJmwFnjSBDnFBv/Aa0UYXWp7EcYD27ziTJfsnc6gN9krQwEZ4QT9aTyoqrGcOML6fzshaORRqxmvhDofbIr2VqCFnN8dvzPTo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0869AEB158DD995AD98B312EFBB00@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501347)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39380400002)(346002)(396003)(39860400002)(376002)(69234005)(377424004)(189003)(199004)(68736007)(305945005)(2906002)(102836004)(7736002)(3846002)(72206003)(93886005)(3280700002)(6916009)(7416002)(6506007)(105586002)(53936002)(54906003)(14454004)(3660700001)(33716001)(33656002)(6512007)(9686003)(6436002)(486006)(6116002)(10090500001)(6246003)(1076002)(478600001)(316002)(106356001)(81166006)(4326008)(99286004)(2900100001)(10290500003)(59450400001)(8676002)(229853002)(11346002)(81156014)(476003)(76176011)(446003)(22452003)(6486002)(33896004)(86362001)(26005)(39060400002)(8936002)(5660300001)(86612001)(25786009)(5250100002)(186003)(97736004)(66066001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jAP7gfQ310pWiLCUp0428PSwDLJ7ZFGYyYcfpOCS+NjjTkQzzREYR7e7+Rg6FAEO0MhhcW9ofrT2aaeFzTK2iHQqQA8DpLBq7Ect+WkXgGxnOhT3DPjfGv1lDIlUv7h66JsgcjQU+R3QQXW0VdoSIalg+seCBpIDwKiDQOxiZNmu5ijnmSYYYDsudOebAA1t
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F369767A41F444469453033E14F222E8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c2f89d01-c9a1-4d8a-2b30-08d5a3b96f29
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f89d01-c9a1-4d8a-2b30-08d5a3b96f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:45:17.0028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 06:42:30PM +0200, Pavel Machek wrote:
>On Mon 2018-04-16 16:39:20, Sasha Levin wrote:
>> On Mon, Apr 16, 2018 at 06:28:50PM +0200, Pavel Machek wrote:
>> >
>> >> >> Is there a reason not to take LED fixes if they fix a bug and don'=
t
>> >> >> cause a regression? Sure, we can draw some arbitrary line, maybe
>> >> >> designate some subsystems that are more "important" than others, b=
ut
>> >> >> what's the point?
>> >> >
>> >> >There's a tradeoff.
>> >> >
>> >> >You want to fix serious bugs in stable, and you really don't want
>> >> >regressions in stable. And ... stable not having 1000s of patches
>> >> >would be nice, too.
>> >>
>> >> I don't think we should use a number cap here, but rather look at the
>> >> regression rate: how many patches broke something?
>> >>
>> >> Since the rate we're seeing now with AUTOSEL is similar to what we we=
re
>> >> seeing before AUTOSEL, what's the problem it's causing?
>> >
>> >Regression rate should not be the only criteria.
>> >
>> >More patches mean bigger chance customer's patches will have a
>> >conflict with something in -stable, for example.
>>
>> Out of tree patches can't be a consideration here. There are no
>> guarantees for out of tree code, ever.
>
>Out of tree code is not consideration for mainline, agreed. Stable
>should be different.

This is a discussion we could have with in right forum, but FYI stable
doesn't even guarantee KABI compatibility between minor versions at this
point.
