Return-Path: <Alexander.Levin@microsoft.com>
X-Cyrus-Session-Id: sloti22d1t05-1882471-1523972765-2-6018422707301814463
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.36.133',
  Host='mail-sn1nam02on0133.outbound.protection.outlook.com', Country='US',
  FromHeader='com', MailFrom='com', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: Alexander.Levin@microsoft.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523972764; b=LiSvdmFJOXXrWt/ld0NdVNXfWWGGR7RT15S8lB8m9zo9G1e4z/
    VchjF8VbXY495d2Vqq3LR96rhE9cxMLmL4fDtFIzLeI5PsgfgKn3Ku1U8PDiXZM/
    v+/2tqLFjN0Fks15IzvrVOisQkdzycb0216+14Heho21UD9xjNvvccQjj4FN30ip
    RbRX0Yeoq/wm+0OAnBvfJEw1+K+aOqB2OT6GlA3Ki3XKMKfRbWfpX5pxjL2yoGgy
    zBFVEPNNH2SidE4JnVhdP91MlU/lbGQUR51d6rmfJZOms8x47iWCL1vK9rLprkW8
    412e2HU7MYph2xlkKqIg0mtLPKlaYtLYPhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version; s=fm2; t=1523972764;
    bh=slmUis8PlVrHGy/xcOIB9F3/Dnw2YCVy+/18J5rhOD0=; b=JtIxrMSdCRFh
    fOqY97JWrUHgjjCThaZBKPgbcu3Pb0yde9LjjKIN+/6kvqmwbipmN8rU4QfQ5jmq
    MEHMTVvuPJEwGkOFPxVc4Lsww/KScJn/fHBzf+wQdhAw6Ji2l0Dekm8OMjj9b9gN
    WzWxkxAn+fniHwQVdFuk3HeBSgaKWNeI+LePq85tPEWKtAGHBFyCQVaRdAZWmUhA
    UUJFLd7B8/9Fg8hNzRkank+IdaIskp38+637ja/rycJ76qFZlxZ3f3MUB3G/RlcL
    123st9A8z52vbExIZv88Tig/0PXuTjrafRc9FdSvjydDoskZ/INZXYc/fO8jDjgi
    cHy1XGbmzQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BAApbxBd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.36.133 (mail-sn1nam02on0133.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM02-SN1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM02-SN1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-sn1nam02on0133.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BAApbxBd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=104.47.36.133 (mail-sn1nam02on0133.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=Alexander.Levin@microsoft.com smtp.helo=NAM02-SN1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=NAM02-SN1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-sn1nam02on0133.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=microsoft.com smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPTZCXAg9LIuRojupkzRn5MsiMranU6qD0F0EUezbq/IQOSBvUeHZmv4fYQvfYl5BA1FdcGMAAWbT0XUWGcKRzrV/7dMqYpfvAtAPuV38eHtBDLAd5iO
    P2CIwbRS7zj/DVj+fOa3KvwQKNof40UVvNe+LHXrdbn1qJF7STtMUgnnLwvHMcU0e2ZheeTKdz5yd1rMEmAjpL6hpUNML0aArEnZuEVx0Btwh/sYjlFE1xM0
    QjY0S7MpHMhRgMrqXy4klQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=HZIoQI8HRjtbiEVY8eQdjQ==:117
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8
    a=UqCG9HQmAAAA:8 a=D19gQVrFAAAA:8 a=XAkUbBkwOWRh1b69ndMA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Petr Mladek <pmladek@suse.com>
CC: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt
	<rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen
	<dave.hansen@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman
	<mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, Vlastimil Babka
	<vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Jan Kara
	<jack@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tetsuo
 Handa <penguin-kernel@i-love.sakura.ne.jp>, Byungchul Park
	<byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAAJjAIAAAleAgAAEfoCAAAGdAIAAAgMAgAEp94CAABt1AIAAFqaA
Date: Tue, 17 Apr 2018 13:45:59 +0000
Message-ID: <20180417134557.GT2341@sasha-vm>
References: <20180416155031.GX2341@sasha-vm> <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm> <20180416122244.146aec48@gandalf.local.home>
 <20180416163107.GC2341@sasha-vm> <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm> <20180416170010.GA11034@amd>
 <20180417104637.GD8445@kroah.com>
 <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
In-Reply-To: <20180417122454.rwkwpsfvyhpzvvx3@pathway.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:pMgsX6o31OiQtfZ9q7jFJsRtSYIDZOS9TWQlzjAkxJpkXytiW/UVeZPZgfUE6VONIgmqz/RCVmvDEaE+mbXl+QxBhvh6V5a2e/3XL4m1s7f5tlvte628sJv9+262KMKCX84+v1n/AFWmtk9++PFtQ0KRVKdTvKLdwoi41kw7nrGvrWbJw+Zvp3ZK7dFX/EmPF/OrLTYdq5/Yrv/cPgXB2SohWEhfDKvRxVXkeTc0i2cfKfmLOKzLgNck9nunrNtj;20:TfB9CdRmzNZxp9DoNhpto9hbooriIc0+dOuVB88dLgJH/9xkHtFuMa79hyTbF1mqo0/MldTvYiyQVrX16pNs6NoFt61dAanRvGEv2cAf7r1JD6C1JBD2+ceOiv3rCfS/UkgW/yRXPr249LJooP0NLBHL7dXdyqIqlqaFhi9uqjc=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046755F6BF34D9F53B5D598FBB70@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(346002)(39380400002)(396003)(376002)(366004)(199004)(189003)(106356001)(68736007)(446003)(11346002)(476003)(7736002)(305945005)(5660300001)(26005)(575784001)(6306002)(5250100002)(9686003)(93886005)(186003)(39060400002)(86612001)(6436002)(66066001)(7416002)(72206003)(6246003)(99286004)(53936002)(6512007)(10090500001)(86362001)(3846002)(6116002)(25786009)(33716001)(102836004)(316002)(6486002)(6506007)(8936002)(81166006)(76176011)(10290500003)(4326008)(478600001)(22452003)(33656002)(33896004)(3660700001)(54906003)(105586002)(3280700002)(2900100001)(59450400001)(97736004)(2906002)(229853002)(14454004)(486006)(6916009)(966005)(81156014)(1076002)(8676002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vxS6WHXww9uP++1gkodGAlG9QKYliGDWNphmsKZX0yjgxbR5XsO1f+0xC3teV/gdcJ+DGQYxN0VQ2YOe4YnlBexYAsDQ4ILcs6aR5UyjgMCGrQ41V1cSmKECPyZSHMujHbwyRZZ7k4BVaf7dyX2BXysQ0SFtStJJMMZMLUuKhHAI3AY0IrtM4L0czvOPudbc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B492D29AE9069C41B15865E8EF17093B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5fe89ce8-b3cc-4990-1666-08d5a4698de4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe89ce8-b3cc-4990-1666-08d5a4698de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 13:45:59.9618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 02:24:54PM +0200, Petr Mladek wrote:
>Back to the trend. Last week I got autosel mails even for
>patches that were still being discussed, had issues, and
>were far from upstream:
>
> https://lkml.kernel.org/r/DM5PR2101MB1032AB19B489D46B717B50D4FBBB0@DM5PR2=
101MB1032.namprd21.prod.outlook.com
> https://lkml.kernel.org/r/DM5PR2101MB10327FA0A7E0D2C901E33B79FBBB0@DM5PR2=
101MB1032.namprd21.prod.outlook.com
>
>It might be a good idea if the mail asked to add Fixes: tag
>or stable mailing list. But the mail suggested to add the
>unfinished patch into stable branch directly (even before
>upstreaming?).

I obviously didn't suggest that this patch will go in -stable before
it's upstream.

I've started doing those because some folks can't be arsed to reply to a
review request for a patch that is months old. I found that if I send
these mails while the discussion is still going on I'd get a much better
response rate from people.

If you think any of these patches should go in stable there were two
ways about it:

 - You end up adding the -stable tag yourself, and it would follow the
   usual route where Greg picks it up.
 - You reply to that mail, and the patch would wait in a list until my
   script notices it made it upstream, at which point it would get
   queued for stable.

>Now, there are only hand full of printk patches in each
>release, so it is still doable. I just do not understand
>how other maintainers, from much more busy subsystems,
>could cope with this trend.
>
>By other words. If you want to automatize patch nomination,
>you might need to automatize also patch review. Or you need
>to keep the patch rate low. This might mean to nominate
>only important and rather trivial fixes.

I also have an effort to help review the patches. See what I'm working
on for the xfs folks:

	https://lkml.org/lkml/2018/3/29/1113

Where in addition to build tests I'd also run each commit, for each
stable kernel through a set of xfstests and provide them along with the
mail.

So yes, I'm aware that the volume of patches is huge, but there's not
much I can do about it because it's just a subset of the kernel's patch
volume and since the kernel gets more and more patches each release, the
volume of stable commits is bound to grow as well.=
