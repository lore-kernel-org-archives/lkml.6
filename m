Return-Path: <Alexander.Levin@microsoft.com>
X-Cyrus-Session-Id: sloti22d1t05-1954995-1523973881-2-16154556524651646235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.41.138',
  Host='mail-dm3nam03on0138.outbound.protection.outlook.com', Country='US',
  FromHeader='com', MailFrom='com', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Alexander.Levin@microsoft.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523973880; b=Pr3wywQeym4y9Im2e63XscfOSvyjsapmOah6cmEsbJ5HWzjpMH
    kWPw6Il3oSGuvwqKiwBRfOxM1KapN4Mw+4Df3UKxghZ7OXAEDF9kfEuOdsLpY0l9
    T4QCr+zJX3jjvNbkzgV1wSBgcdTugvPLROsf8jjrEXuK8Ub852Wrp1S1mj7l2Jdn
    MRwH6RTVs/c3HxzJk7n3rPFln8YvZx7UFsTLXitoBipWoMMldFMQWFe67ILkyyc6
    vmQoAhLS7jZnhNJyFBwIwO8rNu5zITs3nWp+MWNunfc7cl7q6R5Q2V69qa85fiep
    034E0CPdyRvqLj8cisqqHvvSbNSHLvqqAYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=fm2; t=1523973880;
    bh=JDOR6TbaJc9c3w2DLgCWNKVsS/ULre4k+JWw5MiAKC8=; b=Kq1GFLwrj7Of
    9qvIabFFYtApNAFE5Zj+BTf76DGHKhOPM5Uh6/CT+kNNJfwTP5AZ+AhrEFcHB2sg
    G/tRaVtRL1Cp8WBuumcfciDiN1/WzbE8EoScUHLra6tagW88kbcB1q+c2WDBBr2h
    46AGc8uvskoDXExE250Bl6WIgnB2DhNShIi+ri9kq/7LUXMXkl+lnXBW3gYHyI7l
    JcuQcXuM9d9zwaKykuNI8pFPFxzHozpXzIO/vyV2xLVQMfAZAEEX/7+NZ567CAJH
    l7BW8ANjEqyJwYn9lXXxtLEOvYe33jjKE+5DC8fiWN27ZZbAFssu6uEDXxeacwWv
    GupkHdEyYw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hMhKJdky x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.41.138 (mail-dm3nam03on0138.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM03-DM3-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM03-DM3-obe.outbound.protection.outlook.com x-ptr-lookup=mail-dm3nam03on0138.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hMhKJdky x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.41.138 (mail-dm3nam03on0138.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM03-DM3-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM03-DM3-obe.outbound.protection.outlook.com x-ptr-lookup=mail-dm3nam03on0138.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAXUWEsDDQznJSwqNtTA0wzSTg0gua1obVmBQdQFemvgEMgELc1ZGd0y9Z29IMCCiNWC5lk+C+UECq7OVUYouB0UIm7p8wMyWhZ+Pp5mI1nFKmYZPJUZ
    l6vJTCScYt6FbAdPSk2hIW4q92E0qjFz/0WTqWYVwZcTV5ECm0fOF29pjW8i8qhM+R+XDn9xtDcilpcaD+soUtD0F456UaECnJg3ZVQBgzqgn9gLhZ0TPaJx
    zl7smKtdqz1JBMyIaYfMjg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=yuvGtnHiTCAl/P99C/B/pA==:117
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=S7Jpd1DRrsQboaCCudoA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Greg KH <greg@kroah.com>, Jiri Kosina <jikos@kernel.org>, Pavel Machek
	<pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Steven
 Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen
	<dave.hansen@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman
	<mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Peter Zijlstra
	<peterz@infradead.org>, Jan Kara <jack@suse.cz>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Tetsuo Handa
	<penguin-kernel@i-love.sakura.ne.jp>, Byungchul Park
	<byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqAgAAynoCAAAVdgIAAAfQAgAAJ3ICAAALKAIAA3PcAgAAHvICAADGIAA==
Date: Tue, 17 Apr 2018 14:04:36 +0000
Message-ID: <20180417140434.GU2341@sasha-vm>
References: <20180416161412.GZ2341@sasha-vm> <20180416170501.GB11034@amd>
 <20180416171607.GJ2341@sasha-vm>
 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
 <20180416203629.GO2341@sasha-vm>
 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
 <20180416211845.GP2341@sasha-vm>
 <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
 <20180417103936.GC8445@kroah.com> <20180417110717.GB17484@dhcp22.suse.cz>
In-Reply-To: <20180417110717.GB17484@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:q+pzdiBGs/kgbsHqMJQbaz2GB9K9E9fq16dz+imIlBT1Kc5xhpWlKxU43xM2hEbOgNRzkzTCLHa3ehSfOE8EDCPLe+gY3nxfEfIkwpHkG2eK4xKluPNbwe+6qyc5gS169kTmG4Ji0OQe+ElD86loCvzy0yXHpKDyfYIuLCapQ0KK5WoVaqP/1I1mshNu81wB3AKKfwhQgbzAltwOnlV62KPEiSVmcsEDm6rqOMIVqGonvMf6+kbC90v4/7mmpxki;20:f7Z6WVCpPb83LxzRuYzg/WosIYcnjIoXrxAZ46XtdZurgnTlZed6HJu2on9FrQcrNhgIt9zqANnyDelifyW3B8/0ldHyTWE4AvSzI++pzL4tJ22W0oi8wre6QxgnXcQltAca3dYzIm/pg3xFA1Mnv1uHL4+jFlCcfBb6JxaUib0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10940E7EFD4731559F03C045FBB70@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(346002)(376002)(39860400002)(39380400002)(199004)(189003)(51444003)(377424004)(54534003)(4326008)(5250100002)(68736007)(93886005)(316002)(10290500003)(33896004)(186003)(72206003)(478600001)(66066001)(76176011)(14454004)(59450400001)(54906003)(25786009)(22452003)(8676002)(81156014)(486006)(86362001)(446003)(6506007)(8936002)(99286004)(81166006)(102836004)(476003)(5660300001)(11346002)(229853002)(9686003)(6512007)(2900100001)(2906002)(86612001)(7736002)(305945005)(53936002)(6486002)(3660700001)(7416002)(1076002)(3846002)(33716001)(6116002)(33656002)(3280700002)(10090500001)(6246003)(39060400002)(26005)(105586002)(106356001)(6916009)(97736004)(6436002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ld/op8NJXcRi5Os920ISbOTXqnzMPoN1pEspD/32E6c5074rOSLBDA/UR7bg9KhABHUJBVJT6G/6lXlr/x1vT8gO6wmfeuPhkttFqqKBUNJlAaHxfvLWk0VTTivLsLfBMMktlxsMs9G1GME7+Fr8aUX5jueD1NPTAkyTKfIvbvrBeNMjBU9mbY1hYS8/9FMt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDB4D67F80816D4F92AF9F804A992590@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ff48794b-fabc-4b81-529d-08d5a46c2759
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff48794b-fabc-4b81-529d-08d5a46c2759
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 14:04:36.4130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 01:07:17PM +0200, Michal Hocko wrote:
>On Tue 17-04-18 12:39:36, Greg KH wrote:
>> On Mon, Apr 16, 2018 at 11:28:44PM +0200, Jiri Kosina wrote:
>> > On Mon, 16 Apr 2018, Sasha Levin wrote:
>> >
>> > > I agree that as an enterprise distro taking everything from -stable
>> > > isn't the best idea. Ideally you'd want to be close to the first
>> > > extreme you've mentioned and only take commits if customers are aski=
ng
>> > > you to do so.
>> > >
>> > > I think that the rule we're trying to agree upon is the "It must fix
>> > > a real bug that bothers people".
>> > >
>> > > I think that we can agree that it's impossible to expect every singl=
e
>> > > Linux user to go on LKML and complain about a bug he encountered, so=
 the
>> > > rule quickly becomes "It must fix a real bug that can bother people"=
.
>> >
>> > So is there a reason why stable couldn't become some hybrid-form union=
 of
>> >
>> > - really critical issues (data corruption, boot issues, severe securit=
y
>> >   issues) taken from bleeding edge upstream
>> > - [reviewed] cherry-picks of functional fixes from major distro kernel=
s
>> >   (based on that very -stable release), as that's apparently what peop=
le
>> >   are hitting in the real world with that particular kernel
>>
>> It already is that :)
>>
>> The problem Sasha is trying to solve here is that for many subsystems,
>> maintainers do not mark patches for stable at all.
>
>The way he is trying to do that is just wrong. Generate a pressure on
>those subsystems by referring to bug reports and unhappy users and I am
>pretty sure they will try harder... You cannot solve the problem by
>bypassing them without having deep understanding of the specific
>subsytem. Once you have it, just make sure you are part of the review
>process and make sure to mark patches before they are merged.

I think we just don't agree on how we should "pressure".

Look at the discussion I had with the XFS folks who just don't want to
deal with this -stable thing because they have to much work upstream.

There wasn't a single patch in -stable coming from XFS for the past 6+
months. I'm aware of more than one way to corrupt an XFS volume for any
distro that uses a kernel older than 4.15.

Sure, please buy them a beer at LSF/MM (I'll pay) and ask them to be
better about it, but I don't see this changing.

The solution to this, in my opinion, is to automate the whole selection
and review process. We do selection using AI, and we run every possible
test that's relevant to that subsystem.

At which point, the amount of work a human needs to do to review a patch
shrinks into something far more managable for some maintainers.

>> So real bugfixes
>> that do hit people are not getting to those kernels, which force the
>> distros to do extra work to triage a bug, dig through upstream kernels,
>> find and apply the patch.
>
>I would say that this is the primary role of the distro. To hide the
>jungle of the upstream work and provide the additional of bug filtering
>and forwarding them the right direction.

More often than triaging, you'll just be asked to upgrade to the latest
version. What sort of user experience does that provide?

[snip]

>> So nothing "new" is happening here, EXCEPT we are actually starting to
>> get a better kernel-wide coverage for stable fixes, which we have not
>> had in the past.  That's a good thing!  The number of patches applied to
>> stable is still a very very very tiny % compared to mainline, so nothing
>> new is happening here.
>
>yes I do agree, the stable process is not very much different from the
>past and I would tend both processes broken because they explicitly try
>to avoid maintainers which is just wrong.

Avoid maintainers?! We send so much "spam" trying to get maintainers
more involved in the process. How is that avoiding them?

If you're a maintainer who has specific requirements for the -stable
flow, or you have any automated testing you'd like to be run on these
commits, or you want these mails to come in a different format, or
pretty much anything else at all just shoot me a mail!

It's been almost impossible to get maintainers involved in this process.

We don't sneak anything past maintainers, there are multiple mails over
multiple weeks for each commit that would go in. You don't have to
review it right away either, just reply with "please don't merge until
I'm done reviewing" and it'll get removed from the queue.

>> Oh, and if you do want to complain about huge new features being
>> backported, look at the mess that Spectre and Meltdown has caused in the
>> stable trees.  I don't see anyone complaining about those massive
>> changes :)
>
>Are you serious? Are you going the compare the biggest PITA that the
>community had to undergo because of HW issues with random pattern
>matching in changelog/diffs? Come on!

HW Issues are irrelevant here. You had a bug that allowed arbitrary
kernel memory access. I can easily list quite a few commits, that are
not tagged for stable, that fix exactly the same thing.=
