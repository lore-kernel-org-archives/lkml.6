Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2513336-1525352844-2-12264446773098137770
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
    1525352843; b=GBXs+WuxQQ+jGFCizMQndHFLSgYH2eMseEtVGQRTUXTQWOoNF9
    aEHqflTqmStY5b85hYZWlfkIg+9AcLhmlEH/cUBfLsChy4XMpehVEyBccV6bMpZY
    SBJcF0j3CJX6W60oNMfoa+EAzpAJEgCvDuSYybDDgxqx+7aLayc0DmkC4G0H8xTy
    PjQG5RTwmgQANuEQ3xpysAjyjg3+s6CygkIUtBPLGfGMW2WaGX9v7scehrbw93c0
    yLnGPBIsDZKj0tBJwcwj1cki19bufxOvljJ2y8ZiJt+1cmteMSyK87FlSrBkQm1e
    wkoaDuRoflcECKdHznpFvWJ6WSbiYasYTgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525352843; bh=0x4zVG3okvILw3+LRda7P05aWLzI8fA6IxOUEVPp/8E=; b=
    ZBnm4HgLn1hhb48BSvkFBDh3g9un80nNB2ho69MHI1EGJ19hXwe0W9oz13TbI35A
    ckNIrPTzfJ1p4MfLihQy2iHyP9TeV2OwaPaKxV/q7qBHnnDiP9Q58F3kyOO4f7eu
    hh2e3+jgQNH1TapOMZjtU5pDRmzqEZqoudBtTScHd1p+39FkLl3b0UYw920mnVky
    vs8paxUbP7genlmAzii6Xe/csLOHrZND7S7LFjT1Cb0Ms3B5c0RrJ/HKQV/UBWkQ
    Jtg2TZt1jZFPI1Rf543fY8ROyWzb2upgbx5oryn6nV4VTWwh3fsJe8w/tfzc560r
    W/8qOAt7T8LC0hIyVJ1bSg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com
    header.i=@microsoft.com header.b=JlNX716y x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com
      header.i=@microsoft.com header.b=JlNX716y x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEPe9cBUX9pLrbm9NP8DmrJmeCMsRv8/IFELsdbpnFMgOchAwII2uDq/reN5zCtTgExSAvoQDxmAfGFOZ6ku6WeXJszjJXZpiSTCmaR5SQuWANFV1zoo
    PD30oUWIEsjkNQjbVCdVxcD5HLXXDSnty+Ww4SOaDmK2ivXSLrGWadwkjQMCtZ0oOmJ2ciPZ9rTPUO3e2r9MT7OwNBN4sdq4Xu9PyPDYlEBNPUlCtJXdbORn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=Lf-vpJhqX20A:10 a=dIDfqZzr2iQm7E_nV1AA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbeECNG5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 09:06:57 -0400
Received: from mail-sn1nam01on0110.outbound.protection.outlook.com ([104.47.32.110]:14784
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750922AbeECNG4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 09:06:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqAgAAynoCAAAVdgIAAAfQAgAAJ3ICAGfZ4AIAAN7QA
Date: Thu, 3 May 2018 13:06:50 +0000
Message-ID: <20180503130646.GG18390@sasha-vm>
References: <20180416155031.GX2341@sasha-vm> <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm> <20180416170501.GB11034@amd>
 <20180416171607.GJ2341@sasha-vm>
 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
 <20180416203629.GO2341@sasha-vm>
 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
 <20180416211845.GP2341@sasha-vm> <20180503094724.GD32180@amd>
In-Reply-To: <20180503094724.GD32180@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:CxX9h3PIxIrt2KNXk3DCOP5BS+artJQ8J9N8D1rN4TTjEwFo2I8CpWCDzmCqg+KaCtlK7/bazH5bvVSna8KeMXIiohcAjUHZG9NLMCtikBEpFtN7v5gfYbW4dLSSh8HmF5Dyl0EC8Tj8SkZ66s46aJQBMML7ba1SJdokwJgEnvtn2Kch9sSbepfBR7E7SvFIMKrO3MpuGsmMBa+Cc4sfDLwehtOMLe+TcDSZCndK87FX1GwqZcT7zKeGGAfvUC4S;20:kc8R5TNF5x+0Qu3TU8qa/Dzr8fhqQQp8XaHXjcX1Z9v1/GdgztNePPyJOVNLP0pQzIpQcEHIart3VDH6PuOYjbz36rtgHINOU4b8i3zgSBi3d0kCnYt/u4AhUrZtSGo42RaQvkkcd0U2Y6wpt/Ceq0hLNyjNlCvL8QjrB20R+Gk=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10975CEF5D664578BFF035B7FB870@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39860400002)(39380400002)(366004)(346002)(396003)(377424004)(51444003)(189003)(199004)(99286004)(11346002)(54906003)(3280700002)(68736007)(25786009)(229853002)(53936002)(8676002)(1076002)(72206003)(106356001)(81166006)(33656002)(33716001)(81156014)(7416002)(6246003)(8936002)(305945005)(478600001)(316002)(93886005)(105586002)(6486002)(22452003)(5660300001)(476003)(14454004)(59450400001)(3660700001)(7736002)(6436002)(76176011)(6506007)(86612001)(6916009)(10290500003)(33896004)(10090500001)(86362001)(102836004)(446003)(2906002)(5250100002)(66066001)(97736004)(39060400002)(2900100001)(26005)(6512007)(186003)(9686003)(6116002)(486006)(4326008)(3846002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XHHRQ8LIuJ6xTNbGaH4e1BqnHztVOWXsI7XNFxqdJBziDNStAREP5fzZ8L3IuwdI2nx5ywJ2T0yu30byjiPkWKaJj8BwrfjHF+9gRQf2t+gr7dHt+vUTdVl7PHEJbSIBNvWd6Cxg2h/nvNLNZv5rLP8bgS9nAwTsYxtkuYnrpFbhkc2FkGi0UEglz76zBeYA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5B5F51B140A0B4B9977D968BE5B2B27@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6a719733-6bd8-462d-db03-08d5b0f6bc18
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a719733-6bd8-462d-db03-08d5b0f6bc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 13:06:50.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 11:47:24AM +0200, Pavel Machek wrote:
>On Mon 2018-04-16 21:18:47, Sasha Levin wrote:
>> On Mon, Apr 16, 2018 at 10:43:28PM +0200, Jiri Kosina wrote:
>> >On Mon, 16 Apr 2018, Sasha Levin wrote:
>> >
>> >> So I think that Linus's claim that users come first applies here as
>> >> well. If there's a user that cares about a particular feature being
>> >> broken, then we go ahead and fix his bug rather then ignoring him.
>> >
>> >So one extreme is fixing -stable *iff* users actually do report an issu=
e.
>> >
>> >The other extreme is backporting everything that potentially looks like=
 a
>> >potential fix of "something" (according to some arbitrary metric),
>> >pro-actively.
>> >
>> >The former voilates the "users first" rule, the latter has a very, very
>> >high risk of regressions.
>> >
>> >So this whole debate is about finding a compromise.
>> >
>> >My gut feeling always was that the statement in
>> >
>> >	Documentation/process/stable-kernel-rules.rst
>> >
>> >is very reasonable, but making the process way more "aggresive" when
>> >backporting patches is breaking much of its original spirit for me.
>>
>> I agree that as an enterprise distro taking everything from -stable
>> isn't the best idea. Ideally you'd want to be close to the first
>
>Original purpose of -stable was "to be common base of enterprise
>distros" and our documentation still says it is.

I guess that the world changes?

At this point calling enterprise distros a niche wouldn't be too far
from the truth. Furthermore, some enterprise distros (as stated
earlier in this thread) don't even follow -stable anymore and cherry
pick their own commits.

So no, the main driving force behind -stable is not traditional
enterprise distributions.

>> I think that we can agree that it's impossible to expect every single
>> Linux user to go on LKML and complain about a bug he encountered, so the
>> rule quickly becomes "It must fix a real bug that can bother
>> people".
>
>I think you are playing dangerous word games.
>
>> My "aggressiveness" comes from the whole "bother" part: it doesn't have
>> to be critical, it doesn't have to cause data corruption, it doesn't
>> have to be a security issue. It's enough that the bug actually affects a
>> user in a way he didn't expect it to (if a user doesn't have
>> expectations, it would fall under the "This could be a problem..."
>> exception.
>
>And it seems documentation says you should be less aggressive and
>world tells you they expect to be less aggressive. So maybe that's
>what you should do?

Who is this "world" you're referring to?=
