Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4150847-1523911000-2-16255692286414859199
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
    1523910999; b=S0AHpjLoBb1Q15jwNPJu704IxeIHFP6Nu1WTz6vuc9aG7psBjU
    J/mG6wM4OMBTh+58CxsY1kIAwcM4Sd4/e4fOwImDS2y+fiNd97YjOK+ZGrvyGHVB
    JDhsTZWtoO1DoZp18aVlnARxq1839H5BxYyGWHSo1ZkhtNFFlt5vcINzMKpYojzB
    VdhecNT5dWTru6VjzauTkNUrG3wgoX53ttXUGMG4/DVtts7S4IMOpoU+IG05YNUh
    zIxpibPrteWga+7rhf5i+l71hbY83wonq3WaptOCeX5ntuyy0SvaAvU1D8ADUTEj
    W66ATY4BD2At33vlpOypHn0DlBt/U2y2DwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523910999; bh=pfQ5FNsHG8lPpBdMZRXa5MOXN9JbdfzB5axixz6iQUM=; b=
    HnbTpzZ26Ybaq+t/lbJV2x9/L0qGjcmHtsfp4Pv9PmBvAAfcxwVJQlG0ULN+7uOF
    febzoKh+zsQOgjJjHylryZEICa+RqNhJfYqF1yyiGKJnpSxdbFs1xhRB568bRD+P
    mrKFE8ukteKuoZ+yDRHq2yPe1Wv/YM+ZEll6Ivjiu+4O3tCvPyerjY/Yz6fJZJ5S
    Q9tpbitBL4T41RzR6xDIkya+1ePl1OqIILejmgp29FA7k+NXXLp4KrHpBdMjSzVq
    9uXaqrPlwRsP9olVITlm1Z1Yt3vmbP7jexDtDkkywVzrXY09l690N9xrav+7K9FH
    9gVr6YlqCIibgVA4Nv2/aQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QRh1yjRd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QRh1yjRd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF5y5w27bG6EaaEPI4GlhLQGlg6hy62E+Rw84frK0TP5PxUoiBx+9dHuZfet6SC+3mzwUy8LHpvZUcNQm444VwLqAgVsiT2c6A6Z6wiXtwOdthX9CSau
    1eyJiUvLhvr503nWtXSApzpRMH4AAUamT/iRsleJ2ssyiicO/cHZtFsDfnI/g0wQbh+sNc98oK68q4L6343ZRGKiyEQwjkSVaGftFXUnBwT8gK+GHtG5ql0B
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=AyxPHQl6951Nz1WkH-8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeDPUgh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 16:36:37 -0400
Received: from mail-sn1nam01on0096.outbound.protection.outlook.com ([104.47.32.96]:5504
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750972AbeDPUgg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 16:36:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Jiri Kosina <jikos@kernel.org>
CC: Pavel Machek <pavel@ucw.cz>,
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqAgAAynoCAAAVdgA==
Date: Mon, 16 Apr 2018 20:36:32 +0000
Message-ID: <20180416203629.GO2341@sasha-vm>
References: <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416170501.GB11034@amd> <20180416171607.GJ2341@sasha-vm>
 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
In-Reply-To: <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:au1Vu69n55Vns7NCBE20fWjGuRVo6E9Iuz8ops8NIwVHVc+G9uXacTF06g1XY5EEq1ia0ARJnz5WDMpwzgjxRpQ5yYNYRVcUmSFKcs0YU7GE/oycdsXpRhkNirbipvk31+B6u9r6Cy1Mej5U+IcRIfFXDxjij6F54/HhEV7i3/UBVoi/YGV8mD6F/KKvuUHuqcV4buxCdfX5OyMBdxFRfMJKe/hRNSPPe+Fd+vm6g9xk3fNUkX7EgeNo75aJMeCy;20:Fdrn3TZ7fYQLGhnYxONXubSmqEFOnJ/3GpBNAPFyQ2d9/O3EsBdWokkMnEQ54Lkes4zzyP1OdoiE+NOKLe2MLLLGnuyguTIL96IEnNRkh3BKPSko5nagS/JbdpbiJ9zrxZ+QXmopA9dewBZgVGCM0XWxDjDjGlkxkQls4WspF30=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09652C59A6D20AE183E21B17FBB00@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501347)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(39860400002)(346002)(39380400002)(376002)(189003)(199004)(51444003)(3846002)(10090500001)(3660700001)(3280700002)(2900100001)(1076002)(6916009)(68736007)(72206003)(105586002)(106356001)(6486002)(229853002)(6116002)(486006)(86612001)(5250100002)(102836004)(86362001)(476003)(11346002)(446003)(2906002)(14454004)(97736004)(6436002)(6506007)(5660300001)(7736002)(81166006)(33716001)(81156014)(8676002)(33656002)(66066001)(33896004)(8936002)(305945005)(76176011)(9686003)(6512007)(53936002)(4326008)(54906003)(6246003)(39060400002)(26005)(186003)(99286004)(7416002)(93886005)(316002)(10290500003)(478600001)(22452003)(25786009)(507254003)(556444002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: daeFmC9GQqcqF5qkcMVTayqn+A0EP1RwQuJDdU6Gr0eTa6J30dOKafXogjBVBidHUYd3qhokoI7VT2oWr5twCHtSnQvqu88h+RsHeH8a6L2Mixx+iU2xQxwy8C3kZM/EXLGMb48UMoWM4aHiSYNf9oAUhfYlHa+pEP63ym3L8vheWJx0+yzamWrNccVnow3y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD73776144F18247B8761508E6580A5C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 22b2171e-1bfb-4551-70f4-08d5a3d9bda8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b2171e-1bfb-4551-70f4-08d5a3d9bda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 20:36:32.7066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:17:17PM +0200, Jiri Kosina wrote:
>On Mon, 16 Apr 2018, Sasha Levin wrote:
>
>> So if a user is operating a nuclear power plant, and has 2 leds: green
>> one that says "All OK!" and a red one saying "NUCLEAR MELTDOWN!", and
>> once in a blue moon a race condition is causing the red one to go on and
>> cause panic in the little province he lives in, we should tell that user
>> to fuck off?
>>
>> LEDs may not be critical for you, but they can be critical for someone
>> else. Think of all the different users we have and the wildly different
>> ways they use the kernel.
>
>I am pretty sure that for almost every fix there is a person on a planet
>that'd rate it "critical". We can't really use this as an argument for
>inclusion of code into -stable, as that'd mean that -stable and Linus'

So I think that Linus's claim that users come first applies here as
well. If there's a user that cares about a particular feature being
broken, then we go ahead and fix his bug rather then ignoring him.

>tree would have to be basically the same.

Basically the same minus all new features/subsystems/arch/etc. But yes,
ideally we'd want all bugfixes that go in mainline. Who not?

Instead of keeping bug fixes out, we need to work on improving our
testing story. Instead of ignoring that "person that'd rate it critical"
we should add his usecase into our testing matrix.=
