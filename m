Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523896276-2-16504317952623952701
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
    1523896276; b=UksoaqZC3JqGWghFbUmby71KsB7bmE1f+VT2O20J19L05PrMXS
    ncH1dVlpIRehoc5STvfREXMqqre9x95KUGjZVkOYKcMOLU8u8g04fe5oCbFa1TCV
    bsp1TN4b1XW5xZgP1N9ETQSgdiH5XOZPxc7C2Em8v591iBSIBjk9jYUSE2szlqzu
    6Ed6I2YrZz1mYOvMeMgONhJHM5S+HxP/Pcp03tUtP1mNIMRNXeXoSMM19HjJgxQL
    3IUat+XYSDaxa4xmjGcmpQ07H06YcqpC2VrRBVyySfg6svId65Lj6aLfWDmS/aeo
    eUB7vViZj5aLzaky0Kom8rTUZyiuKt/C5y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523896276; bh=p86L9JtzweaEJvDFgcb78KRNa7BZLtwuFcJ0a2TbOSo=; b=
    bgams92gRJvUJO8w5M0DtmyyGFXXLOkGt25FK+5hiyOlw1JeBKxn7018IjKYEcCL
    cy9kRmDRD9HrVi/GRyNxhBZIUTlHuK4hfVnGq0qrW9xh9Hbv8Q/KC4y5LBu6lMtl
    13PFpRDsVay02o8johxVt9JZMwrK0mkvC+wY6CHKPe46Auxq3JYc6dJU8CgbzBWo
    OKbhm187dYVpV6p0uPtG1FlsTsA6jESyWkLZhrKhpQW2HrNs12/dDI67YEnh9Cf7
    yxlhIjYp5u2hHimWwX/jmXWwF198FADIBTHsKU73A58MY1J4G9PWNyMQd7NaW8yC
    hnWLLqKPY2CpqhpLpkZy3Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kKNSOjZG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kKNSOjZG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHqt8Hn2dVyvhXBWpS8Y3LwMvTZfrRGZn3OPUJKbul1NoWjr1wQKZ4ocNjUPieMOPzadAt5Hdy8bQh70gAEwLY8dULvN9wgMHcp1EoeW3DdD5Nzykybh
    4O16qf8cT2J8pZSU8kZnt0fVQUEgeSbaMjwXaJkqo2C+uXbnfT7E85spoKDDc/9zYrmJUiMUMI+GljsXIkBSdxcJr+jlqplyUuqRWtrG72FpLjAK6NPW2/71
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=PSc6BtQw2yjPdLGRjEoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeDPQbN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:31:13 -0400
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:48955
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751151AbeDPQbM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:31:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAAJjAIAAAleA
Date: Mon, 16 Apr 2018 16:31:09 +0000
Message-ID: <20180416163107.GC2341@sasha-vm>
References: <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home>
In-Reply-To: <20180416122244.146aec48@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:buqyOXTlrJjUAYA6Z5JbDOF/eDBqm937GVnsCzTYOIJbjdZJRZJLqeBB6QWO5w1u77BzHLQ0JC1/R39D3PyPqJIbMvnlNu+0ezEoN+ORdaK0dTFWxExJFUAjetXY69UVRI27c8cOLOgiZfGodCJS5exhMWOEVQ95Ajjq8W/5ooN8NFWNyaubIO2YtQmSKBO33EgUZOwMu47RLelAxs8J5m8PiEkITThcaG9JQQX28GKllXvyOP82XKdf6uOpvspJ;20:Oc3KlSwh1ZhNy3H+a74PbWkdEWUoD1hTWkpEsFjAztVp2qUggqb9xaEIFxwcZRTufG88UpTT0pAdx0csBecYQPLN5PeCumd8o/BqY1N5g551Hwmd33iHIUdi7UrD0ZJRSGvEhcw7wMVNN4TlzV/9H5YyjF+9tHbeQVtiMjL9Itc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031B4AD654E760CAB75020FFBB00@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501347)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(346002)(39380400002)(366004)(376002)(396003)(189003)(199004)(305945005)(10290500003)(33656002)(76176011)(478600001)(105586002)(25786009)(22452003)(54906003)(72206003)(316002)(26005)(86612001)(33716001)(446003)(11346002)(33896004)(93886005)(102836004)(476003)(6506007)(486006)(7416002)(5660300001)(2900100001)(10090500001)(66066001)(6436002)(81166006)(6916009)(6486002)(2906002)(229853002)(5250100002)(99286004)(68736007)(186003)(8936002)(81156014)(8676002)(97736004)(6512007)(3846002)(106356001)(9686003)(6116002)(1076002)(6246003)(3280700002)(4326008)(86362001)(3660700001)(7736002)(14454004)(53936002)(39060400002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eVoR2GUw/F1rD/EXhdCay2PlQWy+oqzhqqHrBdBxm24N2azEmEN6xoC6zwjChIQJ7t1DxgPFd3IncmsvLgOyn/7H9BkPEss980LeowHfhaXtfW0bKJrRm2rC28HsqhoV/7yS3fyMZeBXKmzhKTFcpj7GXvUsnGBKpyhAC5IpBEBR54SdBSDa8koowAAUV4kQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D3EE2D0120A1F489CBC47A8BCC33396@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 935dfcf6-935a-4be5-902b-08d5a3b775d8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935dfcf6-935a-4be5-902b-08d5a3b775d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:31:09.2821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:22:44PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 16:14:15 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> Since the rate we're seeing now with AUTOSEL is similar to what we were
>> seeing before AUTOSEL, what's the problem it's causing?
>
>Does that mean we just doubled the rate of regressions? That's the
>problem.

No, the rate stayed the same :)

If before ~2% of stable commits were buggy, this is still the case with
AUTOSEL.

>>
>> How do you know if a bug bothers someone?
>>
>> If a user is annoyed by a LED issue, is he expected to triage the bug,
>> report it on LKML and patiently wait for the appropriate patch to be
>> backported?
>
>Yes.

I'm honestly not sure how to respond.

Let me ask my wife (who is happy using Linux as a regular desktop user)
how comfortable she would be with triaging kernel bugs...=
