Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZrYEq3lTkGRq8j30qYWLaAcfge6Zl8329x9mPLDWYN+/kDbWVDxNFJyL63ZudFKWSzSsWAI
ARC-Seal: i=1; a=rsa-sha256; t=1525207339; cv=none;
        d=google.com; s=arc-20160816;
        b=x23CawSrjctwaRc2Vj5/x5nxQH4mX3YBeOAF924CKYg4DLvm9/K+TLCGHR0B1FgQJX
         Ct+gUbNobGItJm+qJlznNJKNV2u2ZHr3TP+gYzkjpwssUZHMbBVQEXwowcl5pq+JRV/m
         C+HG51RQ0SN1EkG4yV3HJjAOrycHfmAwOFKqgJdHnz9Bn3rYXPPR1uKQFjE3QjCF+ZKf
         lySz8FC/3GgiVZt5MRI0dABbVUB84FgTHMrbclaV+MxpFZRu4Jj4T6mEqx16oRpIK+Tb
         cdu5KCXSgfVmjTtSiXpceReBfH/RwPFNtEoOqF2Okyf5aOn/RZRMoLGkGC9P5kaezirL
         CK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=59DEa4doJA6XXhKa5EftZYByD0bSJFdB0UhktVHC3xU=;
        b=nH4tZsquVswSxrNcWuMimOwzUHL2gUUrQiK6b8gimv05MzCEKjveCIfpJxhgRM2BVo
         PK+4WTTsCWntaSPBkdxeC6jGdzWxvV3XH0BuPbNk1/f+Cylq4MDvZszL5j8Wm2vufIQC
         kRidK+vBoQUod8j/HN+Xqjnrm10WRpb6IYCSOp6B64cKbY1DdxoLwRowdcqkKDOEKNcA
         8fIQhGdkBwkX3Os9dLaRgMLUKKi6/JKHeBpwDKbKxilQ/iMHpjlDyP+Chmi6npWSzkYp
         29kvbMOtILBxIH5PjZ64K1D1m7pqrpl0FZDXJHzTH/1COIpc2y44B5J8h272O8lZysbz
         PgWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Ma79ICBy;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.130 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Ma79ICBy;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.130 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Willy Tarreau <w@1wt.eu>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, Greg KH
	<gregkh@linuxfoundation.org>, "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Thread-Topic: bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAAlAgIAAAnkA
Date: Tue, 1 May 2018 20:42:18 +0000
Message-ID: <20180501204216.GC7397@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
 <20180501203325.GB11618@1wt.eu>
In-Reply-To: <20180501203325.GB11618@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:B20y621XsElsbBd+SvuHBvhLH6IZS68vxsKXR5gwK/GkCFXmHqRBRXYqZ1/xsiw2lyb4IHmlm2EJeES9MYlNt2cRR6fTUpRfS8XIwyKDzfHCCDk5KRSyC6OUJB7D0TcJnc2pMAS+8PyDis82P9K3S/5ISPTSVC0aN+KS/UtQg6SSLnJdWzssKhi0L+hmx+OM1GiUeuyJfLnAGCM1UfzX4bOswsNJ7lY14oL788wDTl0yigEO2Dcc8F3v4TnJbi6U;20:WEFvkpw2+ONtgMZOWVOGtRTIWlEMgYP/BDZlUlbm3jGT25PAidAjmMxXW9fFHAcEoUjYNJgyngxJZOngGeYTBASUyUfeCbhFlAZzFy8pWjioz3wATHvsKHf9+iViooeyaSKp4GSeAqubCGGkPErhOOeanhbOyguNLQKhpcpWybU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
x-microsoft-antispam-prvs: <DM5PR2101MB07251518C3C2DBFBDD565AE2FB810@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(51444003)(6116002)(6486002)(3846002)(54906003)(106356001)(86362001)(1076002)(486006)(3280700002)(7736002)(53936002)(229853002)(3660700001)(2906002)(5660300001)(97736004)(10090500001)(5250100002)(4326008)(26005)(22452003)(3480700004)(68736007)(72206003)(102836004)(476003)(316002)(66066001)(81166006)(25786009)(10290500003)(2900100001)(6512007)(9686003)(478600001)(11346002)(105586002)(446003)(6436002)(305945005)(8676002)(6916009)(33656002)(76176011)(81156014)(6246003)(186003)(86612001)(6506007)(14454004)(93886005)(33716001)(33896004)(6346003)(99286004)(8936002)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: pKJpbbhcktnhELKYyC+FA+uk4Jl7etQ+jb9mfMu1JLo/1tdHzGDF9KyMI98Ef1nmp53B1Ko8cep42kLlTXDPux/gDVU6psgh3ewyyhgZC8/DY56Yo1z7aUO9RxGOwAxzfLrPUQXNPm7Viz4mT/zrrOdjalMbrirJmrAL3RSFDO44tbWjavIF/OY1f1LngutR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD3E65A34FA69740A06DEE1EFE41E883@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fe71940b-966c-48dd-19da-08d5afa407ce
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe71940b-966c-48dd-19da-08d5afa407ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 20:42:18.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599295811484759270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 10:33:25PM +0200, Willy Tarreau wrote:
>On Tue, May 01, 2018 at 08:00:21PM +0000, Sasha Levin wrote:
>> What's worse is that that commit is tagged for stable, which means
>> that (given Greg's schedule) it may find it's way to -stable users
>> even before some -next users/bots had a chance to test it out.
>
>But it's a difficult trade-off. I think that -next is mostly used by
>developers and that as such the audience remains limited. On the
>opposite, -stable is used by many users. So how many days of -next
>does it take to get the equivalent coverage of one day of -stable,
>I don't know but it's probably a lot. Also server workloads are
>almost exclusively on -stable. So a bug affecting only server users
>will not benefit from -next exposition.
>
>In the end it's all about responding to users' expectations to see
>the bugs fixed. In -stable we regularly see users asking to backport
>certain fixes. Sometimes they have to wait one or two extra versions
>before they get their fix, and they are really not happy at all. If
>the fix is rushed too fast and doesn't work, they won't be happy
>either. Making them happy means backporting the right fix the quickest
>possible. Too little test can result in a wrong fix, but too much test
>results in a slow backport.
>
>Again, I really don't find the -stable situation bad nowadays, quite
>the opposite. I often suggest to people who don't follow too closely
>to stick to latest LTS minus 1 or 2 releases. This way they don't get
>the very latest fixes and have a chance that if something breaks very
>badly, it gets fixed quickly. It works pretty well apparently.
>
>I suspect that some of the issues that really need to be improved are
>the fixes to recently merged code. That's never easy by definition
>because if the code is young, it's not yet very well known even by
>its author.
>
>What *could* possibly be done (though I'm not fond of this) would be
>to state a rule that past a certain number of stacked fixes for a
>recently merged code, an extra review delay will be enforced on the
>subsystem or on patches coming from the submitter. But I really doubt
>it would significantly improve the situation.

I think that this discussion has shifted to -stable issues, which is not
what I was aiming for.

I tried to present a statistic from the recent kernel commits showing
that per changed line of code, an -rc commit has more than 3 times the
likelyhood to introduce a bug rather than a merge window one.

Is this something the community sees as an issue, or do we expect a
significantly higher odds of introducing bugs in -rc commits?

Feed free to ignore any proposals I've made. If you see this as an
issue, what could we do to address it?

Let's leave -stable out of this for now.=
