Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3665621-1523899002-2-7044026938912876098
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
    1523899001; b=Ho3TLR42uYKj3vcxvqlC+em4QXlkSj3Qo8NSiqU5S/DixKs1rj
    CdRJ3X3fN1/Cmp2N6BqQVEncs8tGCwJ8TezfqUEsbN2QXDBz+er56PG6g15tqX8O
    E6IPVre8N2SkMA62fut1Kaf/YCHKWJj2ElqxhpdqzkxQx0LR1vWianZsz44KQGmf
    X6ou3wIp+etkEPDI7GMAr2BmFRBa7Ri6vPDi1mVs7lhXSyAExLpEPRs1XEN2fiMx
    7+RMHBdWEaIjT5tr7DZx1nM4S/CyxKMEYrkT5vyjYDy57U8iPxtnj+XiLKn9TeDF
    N/GpvjQjYf8tHeH3+KaJng+AzzHf6jrMUExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523899001; bh=BHQ+KH7o79QwpgQAWtyDAa4PJMHaLI90ylANxVGmRlM=; b=
    akRP6duEd3kE34200nQ14LU2ggsBuNIOZH1Hw/+Jy8UaZ+oMGlpA0DkSTexDllvw
    dR2oXcV13IZeVOJ8Q53Aj75QoD46qAe6PmSPHWUoVVsZ+PuyJ3orJTjhTtHECWIw
    SPqHE09gDHBsqXOZV/g6CNyAFeMmUgpuGs6gzqwgrHL3LCK7lDv/8GGoolUjb6Te
    ekcRjYYMdvk/UeCS69+dJul4JxgHoo6j12X8hLi6QWvYutJOvw6TsYIm51GTrZLl
    FeGaQANo0L8hXvqOxA7NnH2HZLM0TX9JqbC2NkrDnVbAHLqtcVzexdR0sIkJmf7N
    w7OkPVUqBNty0itV/Ep5Vg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SoVwTKpT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SoVwTKpT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAOKNpJt3uAbZsoyG1lJnElGSNJXvzz948ABHyhoYao5zLz3DvWbtqdr24sT1yIsFB43Vi1Xa6hzW/bFTIhRjx4Ae9Lb6F1+aYpv3jJBR6SHboLwGpKr
    e1MgkIxtheGUwFZ5F2mgcUsp504WvDL7JsiW7gxMsR+7xNj14vtpD6rsDs0Xqe08Nzz4L5iNbSsOv06WHDpTzJ8ugChlz+GNA08ySHvwclrcZYAw1crEgyMY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=Y2xGAP4sZGl7fgLUY_wA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeDPRQP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:16:15 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:3124
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753178AbeDPRQM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 13:16:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqA
Date: Mon, 16 Apr 2018 17:16:10 +0000
Message-ID: <20180416171607.GJ2341@sasha-vm>
References: <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416170501.GB11034@amd>
In-Reply-To: <20180416170501.GB11034@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:6PUhBsaWN61NNSKVrhIck8duXryqgzacLK3vLYA1oRLiX9dBSGmrQOl+OU7xaNjyjNfcOrqlpuwQwmS+zu12KaF1mlKJVCGuzZguriLrIr+gZh9hSsLikLBjPvwAp46jl+qr979M929nlDwlie+oAEobyNqVm22PrVH1QEPYEI0hlSYH91WpwgDore37e6ganA/iffUOGqseyTYZPhCMInr9SSDvZ/UFuzevIovXLc4YPtFZCPTX6M+QkVpq5ffH;20:Eepubdubo6h2iLKTtBvxkEud0Me2mPM5kTGIGmrMgOOAM9QE6yfBDc0hscqNmRGUiczOJ4vgc8ckuVXySIDC6kbpC38ChCIi4m4Be1YPaKHSZqve7UFt1KhIuKChYTuhPwMT1uEKUnKqjKPD3GwsexSNC0jNrSUodKBTMPKJ5Dc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0968DD39FD85CA94799E30ADFBB00@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501347)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6116002)(6436002)(316002)(3846002)(93886005)(14454004)(7736002)(68736007)(54906003)(486006)(186003)(39060400002)(3660700001)(3280700002)(26005)(10090500001)(6246003)(6916009)(10290500003)(53936002)(6486002)(2906002)(478600001)(72206003)(102836004)(305945005)(99286004)(9686003)(6512007)(1076002)(4326008)(66066001)(229853002)(11346002)(476003)(446003)(5250100002)(25786009)(5660300001)(33656002)(76176011)(33716001)(22452003)(59450400001)(8676002)(33896004)(81156014)(81166006)(105586002)(97736004)(7416002)(6506007)(86362001)(86612001)(2900100001)(106356001)(8936002)(507254003)(556444002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YQbpWw/VdMxwC7o++Dnz7Sb7LgZVv0l5ModVKZkBP44HYN/VnidZtb7+B2BYeGoTapPGhaSDVGbx3v5KdnXVATMHe+JmYfdG3Dat4L+7kRGboySHCO0t2kVqPE2C7Tw5Ath4R0I+wRXpN2YqQ7eGnNPViWG6IWfoRRCzIRScZrQ7hM6jmfXssLu7QZNCwdyd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C3B5C414C03DB4A8A65FCFF3F66FA70@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 49647795-a7a6-48c4-5e97-08d5a3bdbfd9
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49647795-a7a6-48c4-5e97-08d5a3bdbfd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 17:16:10.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 07:05:01PM +0200, Pavel Machek wrote:
>Hi!
>
>> How do you know if a bug bothers someone?
>>
>> If a user is annoyed by a LED issue, is he expected to triage the bug,
>> report it on LKML and patiently wait for the appropriate patch to be
>> backported?
>
>If the user is annoyed by a LED issue, you are actually expected to
>tell him that it is not going to be fixed, because it is not on the list:
>
> - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>    security issue, or some "oh, that's not good" issue.  In short,
>    something critical.

So if a user is operating a nuclear power plant, and has 2 leds: green
one that says "All OK!" and a red one saying "NUCLEAR MELTDOWN!", and
once in a blue moon a race condition is causing the red one to go on and
cause panic in the little province he lives in, we should tell that user
to fuck off?

LEDs may not be critical for you, but they can be critical for someone
else. Think of all the different users we have and the wildly different
ways they use the kernel.=
