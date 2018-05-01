Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZodo+iFQdcqyP3/VYZekRgSlXFhZL9+zxVSZu6hMIvpXyqlXaBHBb9xuisaUz4ZwOVs5G8O
ARC-Seal: i=1; a=rsa-sha256; t=1525212152; cv=none;
        d=google.com; s=arc-20160816;
        b=SZSxnxgPNV2uugBWLnb496SBs1BK1T6KC5dsX2+wE/xH19GaXHYElOufjASFaPTAvg
         WidhDnYWjuR4dn8nfzoPxV3v+ikQnAK9cvth4OdPhOCNIBYsOi6rMILBm/gPjnEOcZyO
         k9yXYKehqcsmPR9Pkwwzf4XcidR+IDKHdEL+pqYrpEqxKWqmbWif8x/XuBiB780VTJnr
         P8YmRFfbcTMxSIjwXLbJuwkGZ4hSscTybXYaSwdq4A0jiaJo7F0unQOvXK0TjKU8Wjla
         3gY2Xk41XIJMGQ1RvWPy8SF9yUfpmg5OWyL2qwuWjniU5C9+KFvPVq8xFYzFTec/NQR8
         Ddbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=RqDyQ00PNMIAYXg5+xT8J7pRJmJJZqOWs9eu3WVZvEY=;
        b=XrlTNYmOnG9Q7hmX5O9qGDnUl57kzb0OY+2QjK/mD3yD8AClk4Q2DRWrD05RPhKx+6
         pk6idQM7mpQiYj6bYfSqvXL+ozLs6BL6Yuia98/4ZXOkOww2z7qgQ5E2KIAFVTMb9XtU
         Ew9GZ3aIKw6M2TgxyIp3yN1kqNC3s0DiEijlzQvN4mDtfhC2RlLk4zGLdXowRttoZ+cZ
         +WKmvzzrE+4QIOc29+eOxUvx+NjjKQTrpLez2WpoWFsfS74vbXGTLX0z6+nLEnHcYjZX
         zl8fDz5pMXibvut7jT3ubMk9+QVe6FN64xwbr1eWt+ZboJ1Cnhzw52FuEipA43SlCs2j
         leWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=BCqBwXuH;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.136 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=BCqBwXuH;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.136 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, Greg KH
	<gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>, "julia.lawall@lip6.fr"
	<julia.lawall@lip6.fr>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Thread-Topic: bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAAEugA
Date: Tue, 1 May 2018 22:02:30 +0000
Message-ID: <20180501220228.GD7397@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
In-Reply-To: <20180501205448.GE10479@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:31JdO9gBsq2JJxjRVFlHrV55C+l4BxuvtPI63t+8i2ycJa5XLmsfGz2/yvsPJCJXBLgRN8b7DKsvmfgnvXQFuN3Occ9p1b5YjTY89UX4PZGXrLvYELWOlOi7a7nDZca901eTBl4G/eorPIRNOoNtJYpQdmbQ+mg1n8MxXpsxCgfdeozJiDszs6L1zt2Itkvi5uTIUpALPy6fWsObh25Z21V4H9QyvCd43RmjNoOw6bi76TZYv/4IehH8OTWRzBvF;20:+LlMH8yGVS4amXgKCCk9XZ44dQySsga9DikkxROzT1mRQKZmb7H9hjGVPkNSlwZ1TX2TaAq4mtyCcEQ9ldrJKoU8gEW5Pz46HOmInN9LSdSe2e8Q72EIABfgI3WXapQ2ha+716oEM4oEqXMKSnE6iMyfJKCia2u+yxOTCeUmBck=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
x-microsoft-antispam-prvs: <DM5PR2101MB110942E9D22AB007A189A487FB810@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39380400002)(366004)(396003)(346002)(39860400002)(189003)(199004)(11905935001)(72206003)(6246003)(97736004)(3660700001)(446003)(476003)(8936002)(105586002)(2501003)(33656002)(6436002)(81156014)(8676002)(68736007)(5250100002)(81166006)(11346002)(10290500003)(2171002)(3480700004)(25786009)(5660300001)(53936002)(26005)(186003)(6116002)(3846002)(478600001)(229853002)(22452003)(2900100001)(6306002)(10090500001)(6486002)(110136005)(66066001)(99286004)(486006)(3280700002)(1076002)(86362001)(33716001)(93886005)(316002)(2201001)(6512007)(14454004)(86612001)(9686003)(6506007)(33896004)(305945005)(76176011)(106356001)(102836004)(7736002)(59450400001)(6346003)(2906002)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: /mWUwyZgaqtLcDRDbb9qbTg5c5m9OMpiXHj4UhzYE9eF0hR+8SuPyJi0WvXqLuhpxZFGXboPqvExZNU+TSARJmEy/vuQ0oTngZC6tMEUgvORAMgNZYEkRcNCCGo8KRnldEjRgPGim0cyNMJguVr6riQY58W4EK7+9zSLI752GYGKZFKD9ugwnQaIQSM8J/0f
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4AB6CBEB2FA1642976733C2B3C754AB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 62a8fa2e-869e-4bb3-cd64-08d5afaf3c4d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a8fa2e-869e-4bb3-cd64-08d5afaf3c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 22:02:30.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599300858335434275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 04:54:48PM -0400, Theodore Y. Ts'o wrote:
>On Tue, May 01, 2018 at 08:00:21PM +0000, Sasha Levin wrote:
>>
>> Yes, linux-next users want it fixed *now* and I completely agree it
>> should be done that way, but the fix should not be immediately pushed to
>> Linus as well.
>
>I should have linux-head/linux-rc said testers, sorry.  The fact that
>we have very few live users testing linux-next is a separate problem,
>which I accidentally conflated.  But if a user who is testing -rc2
>finds a problem, it is highly desirable to send a fix for -rc3,
>instead of making that user wait to -rc4 or -rc5.  And *that* is more
>important than AUTOSEL.
>
>> I've just finished reading an interesting article on LWN about the
>> PostgreSQL fsync issues (https://lwn.net/Articles/752952/). If you
>> look at Willy's commit, he wrote the final version of it about 5 days
>> ago, Jeff merged it in 3 days ago, and Linus merged it in the tree
>> today. Did it spend any time getting -next testing? nope.
>
>I agree that having the errseq patch go straight into Linus's tree is
>certainly unfortunate.  The justification was this was a regression
>fix, which I don't think it qualifies, since errseq_t went in some 9+
>months ago.
>
>It might be a good thing to quantify whether the patches you are
>talking about are new features, bug fixes, or fixing a bug that was
>introduced during the merge window or subsequently (e.g., a
>regression).

I see. So something like the following?

 - New feature: 2+ weeks of -next without any code changes/fixes
 - Merge window regression fix: immediate if < -rc3, 2+ weeks of next if
   < -rc6, otherwise consider reverting new feature.
 - bug fix in earlier release: 2+ weeks of -next

>> What's worse is that that commit is tagged for stable, which means
>> that (given Greg's schedule) it may find it's way to -stable users
>> even before some -next users/bots had a chance to test it out.
>
>Well, it used to be that things tagged for stable most-merge window
>are *supposed* to marinate for at least a week or before they would
>get pulled into a stable release.  Part of the whole problem is that
>people are wanting to be a lot more aggressive (both in time and
>volume) in shovelling things into stable.
>
>> This is less about AUTOSEL, and more about asking maintainers to
>> improve the testing commits get before they are sent to Linus.
>> Linus would rant about commits during merge window that didn't go
>> through -next, but for -rc commits this rule is somehow forgiven,
>> which is what I'm trying to change.
>
>I do think it's about AUTOSEL, because when I'm dealing with a
>regression, I want to get it fixed fast.  Because the alternative is
>the merge-window commit getting reverted.  AUTOSEL seems wants perfect
>patches that it can cherry pick once, as opposed to a case where if the
>user confirms that it fixes the regression, I want to send it to Linus
>quickly.  I do *not* want it to marinate in linux-next for 1-2 weeks.
>I would much rather that *stable* hold off on picking up the patch for
>1-2 weeks, but get it fixed in Linux HEAD sooner.  If that means that
>the regression fix needs a further clean up, so be it.

For AUTOSEL, most of the commits that went in so far were from the
v4.9..v4.14 range. Only last week I've sent greg commits picked from
v4.15..v4.16. AUTOSEL is at least a month behind -stable (on average,
9.7 months).

>Post -rc3 or -rc4, in my opinion bug fixes should wait until the next
>merge window before they get merged at all.  (And certainly features
>bugs should be Right Out.)  And sure, bug fixes should certainly get
>more testing.  So I guess my main objection is your making a blanket
>statement about all fixes, instead of breaking out regression fixes
>versus bug fixes.  Since in my opinion they are very different animals...

I understant your point, you want to make fixes available to testers as
soon as possible. This might make sense, as you've mentioned, in < -rc3.

So yes, maybe the solution isn't to force -next, but rather add more
"quiet time" at the end of the cycle? Make special rules for -rc7/8? Or
even add a "test"/"beta" release at the end of the cycle?

>From what I see, the same number of bugs-per-line-of-code applies for
commits accross all -rc releases, so while it makes sense to get a fix
in quickly at -rc1 to allow testing to continue, the same must not
happen during -rc8, but unfourtenately it does now.=
