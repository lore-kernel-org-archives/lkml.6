Return-Path: <Alexander.Levin@microsoft.com>
X-Cyrus-Session-Id: sloti22d1t05-2055735-1523976940-2-3765356192650441044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.36.121',
  Host='mail-sn1nam02on0121.outbound.protection.outlook.com', Country='US',
  FromHeader='com', MailFrom='com', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Alexander.Levin@microsoft.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523976939; b=ufFm95Bo9oLXZGMchpFRE3EA6NiZQIEwXi1JgwRfEsPdwREB1j
    n09FRwXAzojZSkB4qIxEqBHBkR5L2s20eSnclYhDFiAK807q20KMOoBdNoCmGVh6
    yVEa0fKMd/7y9kYAGaWn5GGC5ag/S0Fo7bWXkG9C3Ym9ebD7K4W7Bi21XamZ+FqF
    zAJxRRFmYclHFkQ5vrzNcfFaBOocwO2yDxmOe16HUUj5WJL4276jxMwBTR2Oq7HX
    KTxfaT8PpcsEnMMhhzz/R/YkfXuI46MghG8k2F/5ABX6BA0MjE/cK9GIeGHQOa7c
    MDmXQX+EG0ikgUT2lctGhMH49n6R5ejPpgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=fm2; t=1523976939;
    bh=uZDvOB7I2Llb8R/yIUJFfRdtlbzq9uGklUXjdxlQV1s=; b=ZWTNy3kPb0PK
    p7SR/ZLK8fCdI7Z56y4ydCaYhU+PezB57MZXv/3TJta441goSGxxhe42UUNzw9j3
    7KQdH1HuVjhDTm7GhN64uugf6XROJnfexyEjou0TcoR9DbH/yuUG632MEDZ94YIq
    7y8phYGu2fyG7eCDlBHFTlgrzC5VYnqfNENrk0vYy+QoVKzunaeRDbbEjDnA83TS
    I/6H9lrfcjeLA58mCQn3G24Gj1y5zBBYvMbLWhWAKdq87niMu4LbeXutRVU+yjtp
    ACNVfboR/MlfG5bugfeT1g22bq/B0vJ59C17NjgCFYpCWrHq8SnDipG4qNmPuF1c
    Bjo1azr9AA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WlZl32NK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.36.121 (mail-sn1nam02on0121.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM02-SN1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM02-SN1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-sn1nam02on0121.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WlZl32NK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.36.121 (mail-sn1nam02on0121.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM02-SN1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM02-SN1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-sn1nam02on0121.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfED8NUts2Gdb7pp8DgpoFePlp7iqSvgXzFFrtsYRyMzmZI7T5/7Qts3DABvn51BAu56PuXaZMsR8rKXAc3OS3zBWMvmVXFdtIm9+v70nKgFZ0kheZfcl
    +FzKWqAogA7UoKMyeCtzAYmAyL53HrCDplAXO8jeZysQl2OFyXl66dFcGGRbp3eqx20Alc5t6GoxyYhozbD6vaxPM99WRftF7DF/9aPNWAQAmXugbuWr/zMc
    RRbF5SNGdkViDeASF8+2zQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=YQajcJ8a6+lYxhuKwZsdow==:117
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=fLRwCtfgFNIO9MbtFPgA:9
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqAgAAynoCAAAVdgIAAAfQAgAAJ3ICAAALKAIAA3PcAgAAHvICAADGIAIAACO2AgAAFT4A=
Date: Tue, 17 Apr 2018 14:55:34 +0000
Message-ID: <20180417145531.GW2341@sasha-vm>
References: <20180416171607.GJ2341@sasha-vm>
 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
 <20180416203629.GO2341@sasha-vm>
 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
 <20180416211845.GP2341@sasha-vm>
 <nycvar.YFH.7.76.1804162326210.28129@cbobk.fhfr.pm>
 <20180417103936.GC8445@kroah.com> <20180417110717.GB17484@dhcp22.suse.cz>
 <20180417140434.GU2341@sasha-vm> <20180417143631.GI17484@dhcp22.suse.cz>
In-Reply-To: <20180417143631.GI17484@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1061;7:2lamG/9uP3/KlZ/5rGK+OqVl4dA1j3zlo4GNQWPzExoKL6w3xNzcDdcY0aYTLVQ91kOOB4VLrPgq1jkPVRVpRsy83VchYdHLyCVCjljBMSg6R3ca/vZozOgc3tuVMlBxwXVcB18h6TDxR5n6voow11gDsi6km/TSJJgxmxP1LAAMS+AzN6DBMTacAy1MRbMvcxJyFPnbbhx8ID/jdMzqlNxZRLiboMiHyxspYRy/+qd+6WD/95S4025qqy1pgHqD;20:+rbOyUH9LqN7kBvFF7hGtAyVzejQEM4ZGcMoInsR4sSs+RrPIRR9I8xy9RzIxphmafKj9uF2hGhbEoHQmwK3ROOky1Wdq7q5rCZJsE/qbvBP4KZSQCOtvgXeaN/OqZo9I92msrM1Ae61CU3rSCU2rSqPxXu1yqYu2BNXf/xghcM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1061;
x-ms-traffictypediagnostic: DM5PR2101MB1061:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1061A13A84BB566F1D14F2C7FBB70@DM5PR2101MB1061.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501359)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1061;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1061;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(51444003)(189003)(199004)(54534003)(377424004)(97736004)(2906002)(229853002)(59450400001)(6486002)(99286004)(105586002)(102836004)(33896004)(11346002)(33656002)(6916009)(33716001)(476003)(86362001)(186003)(86612001)(6506007)(5250100002)(76176011)(93886005)(5660300001)(446003)(7736002)(72206003)(2900100001)(6436002)(54906003)(6512007)(66066001)(9686003)(53936002)(6246003)(7416002)(8676002)(81166006)(10090500001)(14454004)(39060400002)(68736007)(3280700002)(3660700001)(10290500003)(22452003)(8936002)(478600001)(316002)(25786009)(305945005)(81156014)(106356001)(4326008)(3846002)(486006)(6116002)(26005)(1076002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1061;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nqSk8IuAT8Q/LPU7/V4pR6WDCF6Bq9Lap4lphDZRcNHdp/xs1JhuStSRkLQPgfmjQvNpJx8b/846aLnwHqefMClgFtTH10d5Xw4yQXITD0MS0oHlkTal6+h0IY8rXWEPxpcpWUv6Z1BNbD7M2ZOdds/LuyfbvUuZGPAlJet0hqnIWtrA6qQb3TnIW83h04Ku
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C08B4818BA49D444A7D894418E0365F4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3b723e26-9b58-44a7-ce54-08d5a473462a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b723e26-9b58-44a7-ce54-08d5a473462a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 14:55:34.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 04:36:31PM +0200, Michal Hocko wrote:
>On Tue 17-04-18 14:04:36, Sasha Levin wrote:
>> On Tue, Apr 17, 2018 at 01:07:17PM +0200, Michal Hocko wrote:
>> >On Tue 17-04-18 12:39:36, Greg KH wrote:
>> >> On Mon, Apr 16, 2018 at 11:28:44PM +0200, Jiri Kosina wrote:
>> >> > On Mon, 16 Apr 2018, Sasha Levin wrote:
>> >> >
>> >> > > I agree that as an enterprise distro taking everything from -stab=
le
>> >> > > isn't the best idea. Ideally you'd want to be close to the first
>> >> > > extreme you've mentioned and only take commits if customers are a=
sking
>> >> > > you to do so.
>> >> > >
>> >> > > I think that the rule we're trying to agree upon is the "It must =
fix
>> >> > > a real bug that bothers people".
>> >> > >
>> >> > > I think that we can agree that it's impossible to expect every si=
ngle
>> >> > > Linux user to go on LKML and complain about a bug he encountered,=
 so the
>> >> > > rule quickly becomes "It must fix a real bug that can bother peop=
le".
>> >> >
>> >> > So is there a reason why stable couldn't become some hybrid-form un=
ion of
>> >> >
>> >> > - really critical issues (data corruption, boot issues, severe secu=
rity
>> >> >   issues) taken from bleeding edge upstream
>> >> > - [reviewed] cherry-picks of functional fixes from major distro ker=
nels
>> >> >   (based on that very -stable release), as that's apparently what p=
eople
>> >> >   are hitting in the real world with that particular kernel
>> >>
>> >> It already is that :)
>> >>
>> >> The problem Sasha is trying to solve here is that for many subsystems=
,
>> >> maintainers do not mark patches for stable at all.
>> >
>> >The way he is trying to do that is just wrong. Generate a pressure on
>> >those subsystems by referring to bug reports and unhappy users and I am
>> >pretty sure they will try harder... You cannot solve the problem by
>> >bypassing them without having deep understanding of the specific
>> >subsytem. Once you have it, just make sure you are part of the review
>> >process and make sure to mark patches before they are merged.
>>
>> I think we just don't agree on how we should "pressure".
>>
>> Look at the discussion I had with the XFS folks who just don't want to
>> deal with this -stable thing because they have to much work upstream.
>
>So do you really think that you or any script decide without them? My
>recollection from that discussion was quite opposite. Dave was quite
>clear that most of fixes are quite hard to evaluate and most of them
>are simply not worth risking the backport.

No, *some* fixes are hard, not most.

I'm not trying to decide for them, I'm trying to help them decide.

>> There wasn't a single patch in -stable coming from XFS for the past 6+
>> months. I'm aware of more than one way to corrupt an XFS volume for any
>> distro that uses a kernel older than 4.15.
>
>Then try to poke/bribe somebody to have it fixed. But applying
>_something_ is just not a solution. You should also evaluate whether "I
>am able to corrupt" is something that "people see in the wild". Sure
>there are zillions of bugs hidden in the large code base like the
>kernel. People just do not tend to hit them and this will likely not
>change very much in the future.

We can't ignore bugs just because people don't notice.

Data corruption bugs in particular are a pain to report as well, the
corruption might have happened months before and there's not much to
report at that point.

There's quite a few bug classes like that.

>> Sure, please buy them a beer at LSF/MM (I'll pay) and ask them to be
>> better about it, but I don't see this changing.
>
>I can surely have one or two and discuss this. I am pretty sure xfs guys
>are not going to pretend older kernels do not exist.
>
>> The solution to this, in my opinion, is to automate the whole selection
>> and review process. We do selection using AI, and we run every possible
>> test that's relevant to that subsystem.
>>
>> At which point, the amount of work a human needs to do to review a patch
>> shrinks into something far more managable for some maintainers.
>
>I really disagree. I am pretty sure maintainers are very well aware of
>how the patch is important. Some do no care about stable and I agree you
>should poke those. But some have really good reasons to not throw many
>patches that direction because they do not feel the patch is important
>enough.
>
>Remember this is not about numbers. The more is not always better.

So what is "important"? Look at the XFS issues, they were important
enough to get fixed upstream, and have an appropriate test added to
xfstests.

Why didn't they go back to -stable?

>> >> So real bugfixes
>> >> that do hit people are not getting to those kernels, which force the
>> >> distros to do extra work to triage a bug, dig through upstream kernel=
s,
>> >> find and apply the patch.
>> >
>> >I would say that this is the primary role of the distro. To hide the
>> >jungle of the upstream work and provide the additional of bug filtering
>> >and forwarding them the right direction.
>>
>> More often than triaging, you'll just be asked to upgrade to the latest
>> version. What sort of user experience does that provide?
>>
>> [snip]
>>
>> >> So nothing "new" is happening here, EXCEPT we are actually starting t=
o
>> >> get a better kernel-wide coverage for stable fixes, which we have not
>> >> had in the past.  That's a good thing!  The number of patches applied=
 to
>> >> stable is still a very very very tiny % compared to mainline, so noth=
ing
>> >> new is happening here.
>> >
>> >yes I do agree, the stable process is not very much different from the
>> >past and I would tend both processes broken because they explicitly try
>> >to avoid maintainers which is just wrong.
>>
>> Avoid maintainers?! We send so much "spam" trying to get maintainers
>> more involved in the process. How is that avoiding them?
>
>Just read what your wrote again. I am pretty sure AUTOSEL is on filter
>list on many people. We have a good volume of email traffic already and
>seeing more automatic one just doesn't help. At all!
>
>> If you're a maintainer who has specific requirements for the -stable
>> flow, or you have any automated testing you'd like to be run on these
>> commits, or you want these mails to come in a different format, or
>> pretty much anything else at all just shoot me a mail!
>>
>> It's been almost impossible to get maintainers involved in this process.
>
>The whole stable history was that about not bothering maintainers and
>here is the result.
>
>> We don't sneak anything past maintainers, there are multiple mails over
>> multiple weeks for each commit that would go in. You don't have to
>> review it right away either, just reply with "please don't merge until
>> I'm done reviewing" and it'll get removed from the queue.
>
>I am not talking about sneaking or pushing behind the backs. I am just
>saying that you cannot do this without direct involvement of
>maintainers. If they do not respond to bug reports should at them and I
>am pretty sure that those subsystems will get a bigger pressure to find
>their way to select _important_ fixes to users who are not running the
>bleeding edge because those users _matter_ as well (maybe even more
>because they are a much larger group).
>
>> >> Oh, and if you do want to complain about huge new features being
>> >> backported, look at the mess that Spectre and Meltdown has caused in =
the
>> >> stable trees.  I don't see anyone complaining about those massive
>> >> changes :)
>> >
>> >Are you serious? Are you going the compare the biggest PITA that the
>> >community had to undergo because of HW issues with random pattern
>> >matching in changelog/diffs? Come on!
>>
>> HW Issues are irrelevant here. You had a bug that allowed arbitrary
>> kernel memory access. I can easily list quite a few commits, that are
>> not tagged for stable, that fix exactly the same thing.
>
>Those are important fixes and if you are aware of them then you should
>be involving the respective maintainer. I haven't heard about _any_
>maintainer who would refuse to help.

Let's do it this way: let's assume my AUTOSEL project is bad and I'll
get rid of it tomorrow.

How do I get the XFS folks to send their stuff to -stable? (we have
quite a few customers who use XFS)

How do I get the KVM folks to be more consistent about tagging patches
for -stable? (we support nested KVM!)

How Do I get people who are not aware of how the -stable project to tag
their commits properly? (there's quite a long tail of authors sending 1
important bugfix and disappearing forever)

We can agree that just asking them nicely doesn't work: Greg has been
poking maintainers for years, the -stable project got bunch of
publicity, and the instructions for including a patch in -stable are
pretty straightforward.

You're saying that AUTOSEL doesn't work, so let's ignore that too.

How should we proceed?=
