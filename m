Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZqkrhP+X5jzBu9sGP1XF0Kovtz9XoYRlLlxJqXlqWLmkFttzHUM8uQuvH3RwD/s7hZsvDQT
ARC-Seal: i=1; a=rsa-sha256; t=1525195289; cv=none;
        d=google.com; s=arc-20160816;
        b=YK9yC4nav2aaODpbvxtjLQQ2HEkIuVz5/LMWaMkSAOMpv7vJ8yTdT8cxdU9Kq274eF
         mzhlYZUmjf7hqsXmT4bY5DCMnK/WvC4BBupGEoyPRUHBFbaVVsJIL6tD12H4mNOKEDvQ
         /NTZ0AZeReW+1OnVTMBYlZJgzjs9EsCnrm0OTDdU2hUvPFQ8Hs8uCgviklE98xsYaait
         H0/rRL+vddVV2EbjVNoJ7l3nULfQkST9FrVolip7gu2/z7JsCaK1Dz9IzTlnw0/sGZ8p
         1N2VpXGCvSIp/11nl2zDkP2qdmMznMaLYBy4KP0Ld+oEQs1J1DL/kt8jHJijCH2OQTeY
         lLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=YehN/jVAn9M0Nt8bSdGgZQnNuFlRNFNFN5rtoilIxPk=;
        b=ILiBtu/o7rJ3jEM4m56mL/C83ZDcg8mOgOSqI0epPakrqanwG5WnMDK3R7scACiA/7
         sA5SHPJnpV6aY4atdFb9EbhP+eQVlx5nOSvqYs9MFFURrUywum5zjBJDsYyzWkaQFCb4
         y85/MCV5oDyxEGYETa7tFYojMBlHrgYLjzoNRgrIr+whpsbqSkPtqasmGUkguNlJyGRo
         JkAe5mW+j66ni/KwJWGs+vmRhmknkX5Sif4O5Q+XsGucmcUj4Vr/F/KwQpLhYQ4qPJbY
         XxGgMFUruP6IQTXDYv3IV12WJqWna85jM/BC8Lf83Jgna2U39CMQrE50z705nEN3h4gx
         Hj6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=g1KgGkhU;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.120 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=g1KgGkhU;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.120 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Willy Tarreau <w@1wt.eu>
CC: Greg KH <gregkh@linuxfoundation.org>, "julia.lawall@lip6.fr"
	<julia.lawall@lip6.fr>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches (or: -rc cycles suck)
Thread-Topic: bug-introducing patches (or: -rc cycles suck)
Thread-Index: AQHT4KzY5hZ/zYBxbECTHPKrktWH/qQZrB8AgAFi6ICAAAi/gIAACIqA
Date: Tue, 1 May 2018 17:21:27 +0000
Message-ID: <20180501172125.GE1468@sasha-vm>
References: <20180430175829.GB1544@sasha-vm> <20180430190918.GA8718@1wt.eu>
 <20180501161933.GB1468@sasha-vm> <20180501165051.GA11221@1wt.eu>
In-Reply-To: <20180501165051.GA11221@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:FYbfmGzXessmWR+JvcPH7adI3zx4aXCdrW0/Vss4foiKW1lORvMM88VHa6IRiAMdqPgRpRW2mKMEhzhhP6DDjiR/awrQZy+e8sMciURZ9zu9A/h2cXqHGcPfBVgpLBXWw5kDxFPZS0f0N1JxecINwxk5aPcuJU67oQ6zBRR1VsnCYxa3bwm9cBKd1FVvI9R7Ci9g5PiuD3tyGm+LvlI7Qn1JaTE6ylWp6N/TebWvJ5Jgo3GyDguQ2sAwF/y9Dj8z;20:mmDpItBgarI6xpxoq71iJ8ZdjVTyEfcpVT/uAtcAOkGvwRcKJ1hA5LKDlh6lcA4or9O94iSWbbMUBeqW3ht646dhSMEItf5wDoYUjVSwLB7FMnP/Ubs755bgfEmioXm6lkZgPCvTlJT8h3XgPRW+ZmlmbqdBCqhxLLXzFRnsIbU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104573F2CD9EE0A9FBED4901FB810@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(51444003)(189003)(199004)(66066001)(6246003)(97736004)(59450400001)(76176011)(316002)(93886005)(33896004)(99286004)(22452003)(86362001)(33716001)(476003)(486006)(86612001)(446003)(102836004)(11346002)(68736007)(9686003)(6512007)(5660300001)(53936002)(33656002)(105586002)(106356001)(3280700002)(3660700001)(6436002)(25786009)(10090500001)(229853002)(81166006)(6116002)(3846002)(6486002)(2900100001)(2906002)(1076002)(81156014)(8936002)(72206003)(7736002)(305945005)(6506007)(186003)(26005)(8676002)(478600001)(5250100002)(14454004)(6916009)(10290500003)(54906003)(4326008)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ABj5gKrIc3ES0+w+ir+vyGZv7ds5tOsGCeGj9QQn48xz8UMgcCpHAeY4iiMs6Z2Bqs2OAZOqNqT5CQZrumKTelYC8xtojrtUy7sDeMetRER0PUyf9zEkdX0SbaWK5hy3qDH4SsvfRKfRFfILjrIagbaSCDUl9/6dO50cVrFvkonxBsbdx5JGeWYQPUlFySDq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB6962BBF2C1D84297BACD67B4674610@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 04e3fb90-59da-4485-2f03-08d5af87f946
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e3fb90-59da-4485-2f03-08d5af87f946
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 17:21:27.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599194910340136485?=
X-GMAIL-MSGID: =?utf-8?q?1599283175970537040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 06:50:51PM +0200, Willy Tarreau wrote:
>On Tue, May 01, 2018 at 04:19:35PM +0000, Sasha Levin wrote:
>> On Mon, Apr 30, 2018 at 09:09:18PM +0200, Willy Tarreau wrote:
>> >Hi Sasha,
>> >
>> >On Mon, Apr 30, 2018 at 05:58:30PM +0000, Sasha Levin wrote:
>> >>  - For some reason, the odds of a -rc commit to be targetted for -sta=
ble is
>> >>  over 20%, while for merge window commits it's about 3%. I can't quit=
e
>> >>  explain why that happens, but this would suggest that -rc commits en=
d up
>> >>  hurting -stable pretty badly.
>> >
>> >Often, merge window collects work that has been done during the previou=
s
>> >cycle and which is prepared to target this merge window. Fixes that hap=
pen
>> >during this period very likely tend to either be remerged with the patc=
hes
>> >before they are submitted if they concern the code to be submitted, or =
are
>> >delayed to after the work gets merged. As a result few of the pre-rc1 p=
atches
>> >get backported while the next ones mostly contain fixes. By the way, yo=
u
>> >probably also noticed it when backporting patches to your stable releas=
es,
>> >the mainline commit almost never comes from a merge window.
>>
>> I'm not sure I understand/agree with this explanation. You're saying
>> that commits that fix issues in newly introduced features got folded in
>> the feature before it was sent during the merge window, so then there
>> was no need for them to be tagged for stable?
>
>No, what I mean is that often a developer is either in development mode
>or in bug-fixing mode but it's often quite hard to quickly switch between
>the two. So when you're finishing what you were doing to meet the merge
>window deadline and you receive bug fixes, it's natural to hold on a few
>fixes because it's hard to switch to the review mode. However, if some
>fixes concern the code you're about to submit, it's not bug fixing but
>fixes for your development in progress and that doesn't require as much
>effort, so these updates can often be remerged before being submitted.

I see. But then, wouldn't there be a spike of -stable patches for -rc1
and -rc2?

[snip]
>> It also appears that pretty much the same ratio of commits are tagged
>> for -stable accross all -rc cycles, so there are no spikes at any point
>> during the cycle, which seems to suggest that there is no particular
>> relationship between when a -stable commit is created to the stage in a
>> release cycle of the current kernel.
>
>Not much surprising to me. After all, -rc are "let's observe and fix",
>and it's expected that bugs are randomly met and fixed during that
>period.

So for bugs found and fixed during -rc6+, those fixes should be merged
around the next merge window (time for reviews + time to bake in
stable), but this doesn't seem to happen. Maybe the lack of -stable
commits during merge windows is a symptom of the problem?

>> >I think that you'll also notice that fixes that address bugs introduced
>> >during the merge window of the same version will more often introduce
>> >bugs than the ones which address 6-months old bugs which require some
>> >deeper thinking. In short it indicates that we tend to believe we are
>> >better than we really are, especially very late at night.
>>
>> I very much agree. I also think that "upper-level" maintainers, and
>> Linus in particular have to stop this behavior.
>
>Well it's easier said than done. You don't really choose when you can
>become creative or efficient. For some people it's when everyone else
>is asleep, for others it's when they can have 8 uninterrupted hours
>in front of them to work on a complex bug. I think it's more efficient
>to let people be aware of their limits than to try to overcome them.
>The typical thought "I'm too stupid now, let's go to bed" followed the
>next morning with a review starting to think "what did I break last
>night" is already quite profitable provided people are humble enough
>to think like this.

I'm not saying that patches should be rejected, they should just be told
to spend more time in -next gathering reviews and tests.

Linus would basically say "resend this once the patch has been in -next
for 21 days". That's all.

Heck, we could automate this and check pull requests send to Linus and
warn about "new" patches.

>> Yes, folks who do these
>> patches are often very familiar with the subsystem, but this doesn't
>> mean that they don't make mistakes.
>
>But we all do mistakes all the time. And quite frankly I find that the
>recent kernels quality in the early stages after the release is much
>better than what it used to be. Kernels build fine, boot fine on most
>hardware, and after a few stable versions you can really start to
>forget to update them because you don't meet the crashes anymore. Just
>a simple example (please don't reproduce, I'm not proud of it), when
>I replaced my PC, it came with 4.4.6. I thought "I'll have to upgrade
>next week". But I had so many trouble with its crappy bogus BIOS that
>I was afraid to reboot it. Then I had hundreds of xterms spread over
>multiple displays and it was never the best moment to reboot. Finally
>it happened 550 days later. Yes, the 6th maintenance release of 4.4
>lasted 550 days on a developers machine doing all sort of stuff without
>even a scary message in dmesg. Of course in terms of security it's
>terrible. But we didn't see this level of stability in 2.6.x nor in
>the early 3.x versions.
>
>> It's as if during -rc cycles all rules are void and bug fixes are now
>> no be collected and merged in as fast as humanly possible without any
>> regard to how well these fixes were tested.
>
>These stages are supposed to serve to collect fixes, and fixes are
>supposed to be tested. Often it's worse to let a fix rot somewhere
>than to get it. At the very least by merging it you expose it more
>quickly and you have more chances to know if you missed anything.

Linus's tree isn't a testing tree anymore. In reality, it's just a
cadence/sync point for kernel devs.

Integration and testing happen in -next. The various bots we have run on
-next, most folks are doing their custom testing on -next (we do...).

Linus's tree is was "demoted" as a result of the significant improvement
in testing automation and the capacity to be able to test a fast
changing tree such as -next.

So keeping patches out of Linus's tree isn't really equals to "letting
them rot", it just means "let them get more testing".

>I remember in the past some people arguing that we shouldn't backport
>fixes that haven't experienced a release yet, but that would make the
>situation even worse, with no stable fix for the 3 months following a
>release. The overall amount of reverts in stable kernels remains very
>low, which indicates to me that the overall quality is quite good,
>eventhough the process causes gray hair to the involved people (well
>for those still having hair).

Right, the statistics didn't support the policy change. The -stable
kernel is better at not introducing bugs because (IMO) the commits get
even more reviews.

Countless times my requests for reviews of -stable commits have
uncovered a bug in mainline.

>That's overall why I think that your work can be useful to raise
>awareness of what behaviours decrease the level of quality so that
>everyone can try to improve a bit, but I don't think there is that
>much to squeeze without hitting the wall of what a human brain can
>reasonably deal with. And extra process is a mental pressure just
>like dealing with bugs, so comes a point where process competes
>with quality.

I'm trying to come up with a way where, similar to AUTOSEL, humans won't
need to do much more work.

I'm also not advocating for *more* process, I'm advocating for a
*different* process.

Linus, as he already stated himself, is looking at how long a patch
spent in -next before he pulls it. I'm suggesting to improve and build
on that. Look at how long a patch was in -next, how many people reviewed
it, how much mailing list discussion it triggered, etc.

What I want to end up with is a tool to make maintainer's life easier by
highlighting "dangerous" patches that require more careful review. It's
much more time efficient to keep bugs out than deal with them later.=
