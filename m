Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3578680-1523893843-2-13981469214355738856
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
    1523893842; b=CuXhAW825opiaA5eYdgPtfy0lTj/zptn+rfA7rrLVc//gkswG5
    /KySdK1BvuoABsqZrJfyfMlwHTclVS3PiutXFNG14gboK8r9q1GaR6i3CqHbKgsq
    K/qPn77dPAFRJ3czvlbr0Fx6xr7b+as2WR4bhFXobZaHPR0RQRYOvWmJfiAI9E4x
    TU7JNevN4Ph67P/YoWff9XQt/i5K0U9Fq5RA7npV/3iF9jfjyW7hAw63/5uEkrjr
    hfJnoChvA2FzHq7zA7e6yO9fy/6KNCgY7J1ZnyJjZ4gRJLqK3+9+6QPY9QzjepZx
    enbz+CID9GuP+6WPz/Ce/JwbX18lkHZ/Z4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523893842; bh=hg+7mBcp/q3KgnTvQqs5WebNBfYMRZSpCgxP8zYgzfU=; b=
    BAfi05dJfxRVS1dgbKKGt2+qtgQMytLATs8KIJHMfqpHR0GgXw9YRhl4eYeJH+2W
    LRyKpGaGTWNuyYBtkUw3+4Q+jAeaLscq74uD9GHx8Tb74/Mb4Di/k4I/iZ+KyjyW
    EqyU4WuAqR3bGLc6dAvJBUR3B+f5CAphSdtYX5qD8qB9nQgNSp1+vwKL4WzWekX6
    74nrIegtvG+uuJUgtemGCbdv3cB58SMK+Af+m47cq4kCRvyvBPi5V7VplZ43kUbQ
    LhpFySC7qjPCab8frdZli0a540PcKV6Pcf0oGyULy8l7GsfuUiqvMQWG/lS5HkeP
    stbZO7ewtLQaWfIijshEqg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DVpsN23W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DVpsN23W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJfu0TMn0fyuPCVTPl6GfMsc+IU9jhYluOxHcE/v0Or/m2hZZQZkyKiw/x74AL43p5K1AW5vUPcbzpoCDNyEPVoAjFWnilDRqTXnyXBdBKjL571xf1Af
    z7NasLk4age76BlgyblNRtCY8qs9hZOJE8yZfx5xhbaXrVUSYJNraqYkOjdG7lYDo8zyX1q0OpCmtNOql2OHfIYZ6i3nwDNYluxff0WD3bE9wMxCV8V+ww4Q
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=-cydwaLqUaiSCpc7fKsA:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750732AbeDPPuj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 11:50:39 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:14402
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750708AbeDPPui (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 11:50:38 -0400
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgA==
Date: Mon, 16 Apr 2018 15:50:34 +0000
Message-ID: <20180416155031.GX2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
In-Reply-To: <20180416153031.GA5039@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:g6QiRsOBT+kBT9HQDCMKl02rdLVlVSX/HQG1lM/L1iHQn8CVsmILIns4bnZmubW9t05tCww3zFhOc1aJ7C4eItYNUD2FaQVJbKl1OP9XOx4UUafJzB/wf5wi+L7urKoYNEX+1ROXDGmyV5sngvqqRMgIwwGnomOSXx+aGY3y4xL0tiyu6cqrr1rI1LvaNr+FHVcFcPqtctmD7je1rcChG1+LQo06LTR0Ci5HTPs43l1vEf0qwFJAt12jjqbRrZIt;20:26o/5H2qK5H/easASKJTTEYc6O1LIH6SffvA/tRFxJ0vn0uaEiUoiIwJ8AADYi38Hu5tVswovh6kws8PCPqROQbR6tZegYZt3TiUdMBS4VRTUIThn4VGOYyVSZy7IC08MZazaz3axxxcnPhCPk+UV1x81UM5hS+6USFgKUwvOT4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1079CE648C897AEF8AE9539AFBB00@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501347)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(377424004)(54094003)(189003)(199004)(68736007)(6246003)(33896004)(59450400001)(81156014)(1076002)(39060400002)(25786009)(14454004)(4326008)(8676002)(102836004)(53546011)(81166006)(6116002)(3660700001)(10090500001)(5250100002)(22452003)(5660300001)(8936002)(106356001)(97736004)(3846002)(86362001)(76176011)(6916009)(11346002)(9686003)(33716001)(6506007)(486006)(6436002)(476003)(6512007)(446003)(229853002)(186003)(99286004)(54906003)(6486002)(478600001)(72206003)(3280700002)(7736002)(305945005)(26005)(53936002)(33656002)(10290500003)(66066001)(93886005)(2900100001)(7416002)(86612001)(316002)(2906002)(105586002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: OV8YSYgpfEEmuas+BaN4YmGPJU8mpg4Gzr5abob+hOwA1QDlN+oF7GSbjdy8hZu29IyxEAfO3U28o2h4N6JkJY9WgExvqyRVvwsDZ68a9NjRcaakqlvx9RFHyt44wgqjQO4urUjfB8i+UTDgDhJtIqBhk5/WxlbxofBzNFiDftTi2hkwB5LMru3aKuAAXrAH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0FE53AA5F1E3943A62B6A5ED90CC075@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 86352526-8b17-4f72-9f32-08d5a3b1ca9a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86352526-8b17-4f72-9f32-08d5a3b1ca9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 15:50:34.5021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 05:30:31PM +0200, Pavel Machek wrote:
>On Mon 2018-04-16 08:18:09, Linus Torvalds wrote:
>> On Mon, Apr 16, 2018 at 6:30 AM, Steven Rostedt <rostedt@goodmis.org> wr=
ote:
>> >
>> > I wonder if the "AUTOSEL" patches should at least have an "ack-by" fro=
m
>> > someone before they are pulled in. Otherwise there may be some subtle
>> > issues that can find their way into stable releases.
>>
>> I don't know about anybody else, but I  get so many of the patch-bot
>> patches for stable etc that I will *not* reply to normal cases. Only
>> if there's some issue with a patch will I reply.
>>
>> I probably do get more than most, but still - requiring active
>> participation for the steady flow of normal stable patches is almost
>> pointless.
>>
>> Just look at the subject line of this thread. The numbers are so big
>> that you almost need exponential notation for them.
>
>Question is if we need that many stable patches? Autosel seems to be
>picking up race conditions in LED state and W+X page fixes... I'd
>really like to see less stable patches.

Why? Given that the kernel keeps seeing more and more lines of code in
each new release, tools around the kernel keep evolving (new fuzzers,
testing suites, etc), and code gets more eyes, this guarantees that
you'll see more and more stable patches for each release as well.

Is there a reason not to take LED fixes if they fix a bug and don't
cause a regression? Sure, we can draw some arbitrary line, maybe
designate some subsystems that are more "important" than others, but
what's the point?=
