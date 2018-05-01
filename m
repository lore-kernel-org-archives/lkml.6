Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZqhGcXE4EGCUoWvQ5GYNtSu4pe3xwjj+HAkIyldA5qocV0y0uld4tupDjyJGE+1YLBxr7Zv
ARC-Seal: i=1; a=rsa-sha256; t=1525191577; cv=none;
        d=google.com; s=arc-20160816;
        b=P54DXC0rZ7XMoZfPfyQSUfjosq2RRAoxwoGxfCCfVSHqz5Whf7youl2GZ4XQCUwt/V
         du3/LZ6yc2TMxJYwn57+0pmzCVP3ojNBElonHGIWenZp9J1KfbVX8Ff5nNVAOBg/rmhe
         PFR3sU7orqpadaGeaYGAJEx9apyTWFp2q4DCJq57poaygVKmilbmunbVkb7NIGeS37CK
         4KbNgq28rGJm+VPLWII6MQCvCxT3Z4LIP1tyeduxcRNGJLU8alfefKdWOziRpKeNhMkT
         oeo8G1823edOfG6PkhMTnUc7ju1YXK53vEeSRU23SYntZGtFI9lyGo3dk+p7DgEqTKED
         8qRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9AkMJFQtqlBc874fG+AJawSa3PYPQOQLMP0snLkUR1U=;
        b=ZTwjL2/7sVu1JvM38UGfrTf7NYaA7/R0htjoJPLyC+cWc35XsP/2XsHtnE3Yi4VCbC
         C8FVrN4pUcbDANShQlup2ZN6U1EfWJiraBFtK3csy/Wmc1DDi9SnR7WTBCKeZII0rCED
         9aTnbTlIkWI/hRC8+pKlmipa+0Sz9ZEbXLs4JrIpT6A6sDwtpeHcpJuqYKE//rftNwrc
         5AvNpq4v3JuhId6imKiYxefM6xBWZEra8Yph/NbyfZ3U2ckHa33SbxnOvSpGROn3LtMI
         waBAWuiKCOZxv8I4FCVzcrg1zKOh/j11slxAOT1Mx/ACGv6RA/BF7aXiyMLnHEF9eueH
         uxqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=SWuzazWf;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.107 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=SWuzazWf;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.107 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Willy Tarreau <w@1wt.eu>
CC: Greg KH <gregkh@linuxfoundation.org>, "julia.lawall@lip6.fr"
	<julia.lawall@lip6.fr>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches (or: -rc cycles suck)
Thread-Topic: bug-introducing patches (or: -rc cycles suck)
Thread-Index: AQHT4KzY5hZ/zYBxbECTHPKrktWH/qQZrB8AgAFi6IA=
Date: Tue, 1 May 2018 16:19:35 +0000
Message-ID: <20180501161933.GB1468@sasha-vm>
References: <20180430175829.GB1544@sasha-vm> <20180430190918.GA8718@1wt.eu>
In-Reply-To: <20180430190918.GA8718@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:GpmWfEewvNavi+vf3NLuMtwqKm3zbNU+4N1y1j0oiY6GU48vpNJ9sx8Sb6vK9s0DsfsejGRrTDvFYYlApU54uQk06RcxZkk+X+3oyKliYUwH5AC3wmp8ka1D4Qq051rqE5yUfqfUoprOFwWDccvCrQUqo7VLWJ6MRKjl7c2ryavTSQQZMg8enFpBjKBHvdFR+zNCmau5heqyh/252aUx9v88Nlq8X8U4rhxVUu59asiaFt+bKsTqW9BCnn5uPnsY;20:iRQg8ZwBMzQypwgWxZyb8XPTpBnpel2YVjGZeQQg1uxpPxmsIYCSGGiJiQ4dvW+lZ6rLlfulu8Ug0BxDjaYMWzOFK+mHMwe3KSXIXsai2YDbG1ESrs288sJQzODlz7IKGsUpPhQBLh8wW2cTaAp4ssB8k5II5ReRAks1uLTixcs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
x-microsoft-antispam-prvs: <DM5PR2101MB087251027B591DB83C6CA6A4FB810@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39860400002)(376002)(346002)(39380400002)(51444003)(189003)(199004)(3846002)(305945005)(9686003)(5660300001)(229853002)(97736004)(1076002)(6512007)(10090500001)(2906002)(68736007)(33656002)(6306002)(2900100001)(105586002)(53936002)(106356001)(6116002)(6436002)(561944003)(6246003)(6506007)(11346002)(14454004)(486006)(5250100002)(446003)(66066001)(476003)(72206003)(8936002)(6346003)(966005)(7736002)(6916009)(86612001)(99286004)(186003)(54906003)(81166006)(33896004)(81156014)(8676002)(3660700001)(10290500003)(33716001)(22452003)(86362001)(478600001)(76176011)(4326008)(6486002)(25786009)(26005)(316002)(3280700002)(59450400001)(102836004)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 4FiiXuj78+QV+giNkaY3wILn4QGeARcv2jektxtB4v0f3lncSxBwBh/gEhBElT+jDWo4LNi0/8imObzLDbmzNtRupZ8pgsmeHn5xNLGeE17WL89GNcznu9qVCDW9JI/SzYtK6wyG/WgYyMWZQ+8BoejIah8hq9T/ikJtkElpfjwiFKBjtMBbZdeKJyMSsC5Y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D46F000F53D42C4DB00C1B51A427B075@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c5c0f24d-103c-47a8-4139-08d5af7f549c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c0f24d-103c-47a8-4139-08d5af7f549c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 16:19:35.6135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599194910340136485?=
X-GMAIL-MSGID: =?utf-8?q?1599279283701935529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 09:09:18PM +0200, Willy Tarreau wrote:
>Hi Sasha,
>
>On Mon, Apr 30, 2018 at 05:58:30PM +0000, Sasha Levin wrote:
>>  - For some reason, the odds of a -rc commit to be targetted for -stable=
 is
>>  over 20%, while for merge window commits it's about 3%. I can't quite
>>  explain why that happens, but this would suggest that -rc commits end u=
p
>>  hurting -stable pretty badly.
>
>Often, merge window collects work that has been done during the previous
>cycle and which is prepared to target this merge window. Fixes that happen
>during this period very likely tend to either be remerged with the patches
>before they are submitted if they concern the code to be submitted, or are
>delayed to after the work gets merged. As a result few of the pre-rc1 patc=
hes
>get backported while the next ones mostly contain fixes. By the way, you
>probably also noticed it when backporting patches to your stable releases,
>the mainline commit almost never comes from a merge window.

I'm not sure I understand/agree with this explanation. You're saying
that commits that fix issues in newly introduced features got folded in
the feature before it was sent during the merge window, so then there
was no need for them to be tagged for stable?

This would be also true for -rc cycle patches if they fix a commit that
was introduced in that merge window: patches that fix a feature that got
in that same merge window don't need to be tagged for stable either
since the feature didn't exist in a previous release.

The way I see it is that -stable commits fix a bug that was introduced
in a feature that exists in a kernel that was already released. At that
point, the fix can come in at any point in time, whether the fix was
created during the merge window, or during an -rc cycle.

It also appears that pretty much the same ratio of commits are tagged
for -stable accross all -rc cycles, so there are no spikes at any point
during the cycle, which seems to suggest that there is no particular
relationship between when a -stable commit is created to the stage in a
release cycle of the current kernel.

>> 2. Maintainers need to stop writing patches, commiting them, and pushing=
 them
>> in without reviews. In -rc cycles there is quite a large number of commi=
ts
>> that were either written by maintainers, commited, and merged upstream t=
he
>> same day. These patches are very likely to introduce a new bug.
>
>Developers are humans before anything else. We probably all address most
>bug reports the same way : "ah, of course, stupid me, now that's fixed".
>Keep in mind that for the developer, the pressure has lowered now that
>the code got merged, and that mentally the fix is "on top" of the initial
>work and no more part of it. It often means a narrower mental image of
>how the fix fits in the whole code.
>
>I think that you'll also notice that fixes that address bugs introduced
>during the merge window of the same version will more often introduce
>bugs than the ones which address 6-months old bugs which require some
>deeper thinking. In short it indicates that we tend to believe we are
>better than we really are, especially very late at night.

I very much agree. I also think that "upper-level" maintainers, and
Linus in particular have to stop this behavior. Yes, folks who do these
patches are often very familiar with the subsystem, but this doesn't
mean that they don't make mistakes.

It's as if during -rc cycles all rules are void and bug fixes are now
no be collected and merged in as fast as humanly possible without any
regard to how well these fixes were tested.

With merge window stuff, Linus will make lots of noise if commits didn't
spend any time in -next (see https://lkml.org/lkml/2017/2/23/611) for
example. But it seems that -rc commits don't have that requirement.

>> I don't really have a proposal beyond "tighten up -rc cycles", but I thi=
nk
>> it's a discussion worth having. We have enough data to show what parts o=
f
>> kernel development work, and what parts are just hurting us.
>
>I'm inclined to believe that making individuals aware of their own
>mistakes can help. I personally like to try to understand how I managed
>to introduce a bug, it's always useful. Very often it's around "I was
>pretty sure it didn't require testing, the change was so obvious". We
>all know this feeling when you write 100 lines in a new file, you
>compile, and it builds without any warning and apparently works, and
>suddenly you think "uh oh, what did I do wrong?" and you have no idea
>where to start to look for possible mistakes.
>
>Probably that some statistics on mistake classifications and maybe some
>affected subsystems (if that doesn't blame anyone) could be useful.=
