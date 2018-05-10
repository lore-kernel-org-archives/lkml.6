Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZpHFHZuuVUsbIsnSNZgiLhedcIT4jqj2+18fTJR9ChCsr5gLzVd9oT1rYx523DDosVM46t0
ARC-Seal: i=1; a=rsa-sha256; t=1525970362; cv=none;
        d=google.com; s=arc-20160816;
        b=WYzQCpLeOSySosHa9hmBqPllmQ8PKNKwAOlzmW4bY7Jm3BBGutkbh3WfZJohrBBkQ9
         RKZJucA/GHhuwBSc8S1pAaKXtKdcvnwPZ0ceL1rc/H0OkD4Gjcq7syBS0lvDNvRy2i/c
         kjNbHktJO+AB40W31brYKYXeKVP/PL+mTQuqiKAqgZBZiT+LcW0pF1dVpkFqUZrn++4h
         kDo7XiTPeS+Z4eEfV4jbO64S+3m7s6RZKBMke36Sm8YE/FjXlGqMK25CNeI4r3f6zQBA
         AYNs5iv2BZN5nxKpwlzHGbBwrPwC2Bv1rQVYe5VhsO7hwiltHwL6nggvTvruDmPTTva3
         OVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=YPO+B4823jTC56j4lMVCV/GgJcK4kC2QxqdklL4soOA=;
        b=IyNfWLDrWxYPSVavcH38U16fJsina9pUu2dOMPRz7Ziqb5GZexJHNTUVC3D5Dji97x
         ZGnAGPgklgeEFe3MD1ASOUeNHXuVgRsGg/lS0CqkQqZ+L6slec0aR1ma9d1QcShhAJaG
         pZsWgCglcg5Np9EuunESfNFMSu0iVBR1OcbXd7DD+zYmHaTwgFTBBRdrrNIDrImjrOr5
         wZHt3mBzdUY3SopFJJlaB9iNHuDOH4DfqRTq57UEURDws3JoZlXaBRUwIcf01acM/vMm
         Ei/d92o1mfAzz5YQWB6FNRBJkjjRkkSg0+TD5FAmUevE5THvxNh3EoBFyFUe0UvOmUAf
         /D/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=hc38lKIR;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.128 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=hc38lKIR;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.128 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Tony Lindgren <tony@atomide.com>, Greg
 KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAABeKAgAC3HQCAAMJDAIAAafoAgAAR7QCAAAvfgIABO6qAgAAHfYCABoLCgIAAFJYAgAEXpACAAB24AIACxrWA
Date: Thu, 10 May 2018 16:39:18 +0000
Message-ID: <20180510163917.GG8514@sasha-vm>
References: <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk> <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm> <20180508034820.GE999@thunk.org>
 <20180508202912.GC8514@sasha-vm> <20180508221534.GC28388@thunk.org>
In-Reply-To: <20180508221534.GC28388@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1019;7:NyKg3PrHsV6HSFB9nozskEhwCO7H0gj9eX0xkMgPwlZZG7t4Fh4hQcY+hfJezsGNPpDHYGT/nEzP8ulF9vgy5PGdTAbz2243TyejdiYQl0/ivZ9Uot9Rrmxxbl51y8BBs9w0vdfTdH2uLHaa4+BFM77j6Fr2nN3PLV0oETCZCQSEi9hYKcNQXQzWxiDfTpD261+Ov9TLT77Nts22n4+VvVuprxw8CXCPH/TyEs/4DfNxM/hQPCDub+NKUjH07luX;20:tf8cuDzQfy5epnINYdWfajJ4CsgmxFNIvdPOO5LkngMVqm/ynM0VuJLq4JdF9JqYwZdWhPsTAQKIcKcTNDHAjn6fQM6/mEvWQVTxw0c+AVgWIBw8b6GDbgZqqALvrYwZdSrxzkAhOmJlCiw9yeDrt8Puw5lufrHYpjAbqfW3ChA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1019;
x-ms-traffictypediagnostic: MW2PR2101MB1019:
x-microsoft-antispam-prvs: <MW2PR2101MB1019722F1A5F9A2D89F9690FFB980@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1019;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1019;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(346002)(39860400002)(376002)(39380400002)(199004)(189003)(6246003)(81156014)(6116002)(316002)(33716001)(3846002)(8936002)(8676002)(53936002)(486006)(93886005)(81166006)(5250100002)(2501003)(6346003)(5660300001)(6512007)(1076002)(305945005)(7736002)(22452003)(2171002)(110136005)(446003)(561944003)(86362001)(86612001)(33656002)(99286004)(66066001)(6436002)(33896004)(2201001)(102836004)(72206003)(229853002)(106356001)(97736004)(11346002)(26005)(2906002)(9686003)(6506007)(186003)(105586002)(10290500003)(10090500001)(14454004)(2900100001)(6486002)(476003)(25786009)(478600001)(68736007)(76176011)(3280700002)(3660700001)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1019;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: vr6a+zRQBgzX/JrXKg3WbQtsPsnE1qBtlm7WkQZnaUMFBJELuRpahThe33BXPSG7CpvFdPL9BtXWd/h1uzJEE1qXPFFNfKkNLRI/F7lD3D+TC2+ICKjO0Qf6hq3G2keQjBMiTeTE6UOj5/9Hteuh9/O+lg8SPj42Lq4YAAEwm6q4G30sVcjtI7OiT6QGIk9T
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E7FC0FF0E497045B8B5D81BA546005C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8ddd497f-4a2e-49c7-9364-08d5b69493a3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddd497f-4a2e-49c7-9364-08d5b69493a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 16:39:18.9929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600095898983297478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 06:15:34PM -0400, Theodore Y. Ts'o wrote:
>On Tue, May 08, 2018 at 08:29:14PM +0000, Sasha Levin wrote:
>>
>> This is interesting. We have a group of power users who are testing out
>> -rc releases, who are usually happy to test out a fast moving target and
>> provide helpful reports back. We also have a group who run a -stable
>> kernel (-stable build/distro/android/etc) who want to avoid having to
>> report bugs to us.
>>
>> What we don't have is a group of people who use Linus's actual releases
>> (not the -rc stuff, but the actual point releases). Power users will
>> move on to the next kernel, and -stable folks won't touch that release
>> until there's a corresponding -stable.
>
>Linus doesn't release the point releases.  Those are done by the Greg
>K-H and use the same process as does the stable kernels.  The only
>difference is that the life point release doesn't last very long; just
>until the next kernel release from Linus.
>
>There are probably fewer people who use the point releases compared to
>the stable kernels.  But I'd hesitate to call it zero.  We once
>assumed that companies were all using Distro kernels, and very few
>people used the stable kernels except for distribution channels
>(enterprise kernels, BSP kernels, etc.).  Then we discovered that
>there are people who use the stable kernel and don't go through the
>enterprise distro vendors at all.  It wouldn't surprise me if there
>are also a silent (and perhaps large) set of users who take Linus's
>releases, and then follow along on the dot releases until the next
>release from Linus.

I was referring to Linus's non-rc releases (4.15, 4.16, etc). While many
users start with, for example, 4.16, most users will either switch to
Greg's releases which start about a week after Linus's release, or
they'll move on to test the 4.17 -rc releases.

There are pretty much no users who pick 4.16, stay with it for 3 months,
switch to 4.17, stay with that for 3 months, and so on.

>> What if, instead, Linus doesn't actually ever release a point
>> release?  We can make the merge window open more often, and since
>> there's no actual release, people won't rush to push fixes in later
>> -rc cycles.
>
>I dont' understand your proposal.  Linus doesn't actually release
>point releases.  Those happen during the -rcX cycle for those people
>who are too chicken to follow Linus's tree, and just want the bug
>fixes.

What I'm suggesting is that "4.16" never gets released. When 4.16-rc8 is
closing and Linus would have tagged 4.16, he'd just open the merge
window and start merging in new features.

At this point Greg could either release 4.16.0 or wait a week and do
4.16.1. This effectively puts the kernel on a weekly release schedule.

>Getting rid of the point releases isn't going to change how frequently
>the merge window opens.  What would do that is being much more strict
>about when we only allow regression fixes only into the tree, so
>hopefully the tree stablizes itself by -rc5 or -rc6.
>
>> Merge window will happen more often, so there's no real reason to
>> rush things in a particular window, and since -stable releases every
>> week there's no rush to push a fix in since the next release is just
>> a week away.
>
>Huh?
>
>I can see shortening the release cycle to a six weeks, instead of our
>current 8-9 week cycle.  But after the each cycle where we introduce
>new features, during the merge window / integration phase, we do need
>to have a time when are fixing regression bugs.

What I'm suggesting is that most of the commits in -rc6/7/8 actually fix
bugs introduced in older kernels rather than the current merge window.
Thus, they don't have much value in "stabilizing" the release.

On the other hand, for some odd reason, folks will try squeezing poorly
tested commits into these late -rc cycles because "Linus is about to
release and we must make it in time for the release", even though in
practice there's no big rush to make it to a particular release since
most folks will just keep updating via -stable or distro kernels.

So since there's not much value in -rc6/7/8, just cancel them.=
