Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2500718-1523989775-2-12219502922989788552
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
    1523989774; b=eZ19ELyOacY61RXY6LqmmGBWMsS5RPEw+g2Z/QNsgmXB3qxoG3
    tCvqhgIHKtyoBtaV0gMoz/rfdxyfKOpybMeGriYF9LR8sxrf7SsrTRBkq+ubqSee
    cTt7ybGxtunYQbj/eTG966UX7nT7anZVDAOjw5nNP9OssrQIqz3+4rIbJTfD5Yhx
    dDrjOUYjRmE0cE45HmkCupQE1VhL2wCVjW/i9GpBl7YwAkGzruCJ0r6MnTIZ1xhl
    rjZnbtLJzoYV7fNpeBqOt5SIkgNF2dM/zgr5Pzm7J+Bu21Qn7G7Emuk2qume5CU0
    GY/CqEDejVRV5UCvR+mclhW/gRH8CJwfYCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523989774; bh=Q8SsMPlnz8Rt82Sqjet1G/M6mX7ieZI+D7z7M3iIXIM=; b=
    gTeQ4gfUwB4di3FTfAy3AkA2zfF0oRaZ1gqFKgraCTgWQAfjCKYGYrYMKjD2a+rL
    y4oZSrqUvzOCSZf2/atS+gMdZrd1DeZG7t/z/P544bdJY+VbxTEwFP38Y1Eap3FD
    lZp+ep/e779hGqP6KspBYrRsY2GJdSQwDjHtoAjs6/EBtG/YGYqVk5GNnZyK7DSd
    +9iIONZCdbbubLNN0QxOre7I7S7A853zMBoox8Oe54oECQ2CZ0/ZhocA8AfAr/77
    RYtMwgHKokffAPfEN3RxCd74eeCxxu92ADj+/jk5DYvIreMx+NSe9mkBQ6zJHSPT
    BOeqsNofLRZBm+OVAAtiyQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LUVkAmTc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LUVkAmTc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGn9UxmGy2FzLroxZpt813lqLLYnv04blhHx0s8HTrgHrXK5etY2TTWqn49Swz6a8hht49Iv4wOkuQeJp8my7Acnl0Ripnyb5I2KxNi8UqkrATEGIUyU
    rf8y0XPwl8Kqv3iSLM3IpppGq9JtirdOQZwhdflciumlhYe13D4BNYyic9j7TCgXSI0ciYCaIhBB/I1tgR+Vsa14SKtoeijLWtCso4afGZjmKetSzGYeUcyE
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=qqUoZokZANNlDEwOpfwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeDQS3b (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 14:29:31 -0400
Received: from mail-cys01nam02on0129.outbound.protection.outlook.com ([104.47.37.129]:11307
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752086AbeDQS3a (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 14:29:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Jan Kara <jack@suse.cz>
CC: Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YCAAAMcgIAAAh8AgAAH3gCAAATcgIABMtsAgAAewoCAACg7gIAABqKAgAAbegCAAAiHgA==
Date: Tue, 17 Apr 2018 18:28:27 +0000
Message-ID: <20180417182825.GA2341@sasha-vm>
References: <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home> <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd> <20180416172327.GK2341@sasha-vm>
 <20180417114144.ov27khlig5thqvyo@quack2.suse.cz>
 <20180417133149.GR2341@sasha-vm>
 <20180417155549.6lxmoiwnlwtwdgld@quack2.suse.cz>
 <20180417161933.GY2341@sasha-vm>
 <20180417175754.w4slhmwtf46hq3hm@quack2.suse.cz>
In-Reply-To: <20180417175754.w4slhmwtf46hq3hm@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:qG8b288mK46tLy2Kp5U9G1Ljk1BILZPc8Az1qQUSFcpYefEWAOjx967nrO8wd+BT5QpGNx/SGkA5r0XZAi3Dn1ldSnkUnznqso8xlUuWLcrUOiHPGgVFP2gnON8j5izWXyN2tQJweh60UN6DIroKpRm/NOGxo11c4+tFxqUyywIvIKJrqAq8qmN2Id6unv55BKg/jZaVofh+GazvC+FHJcIGzYnh1n2xOTipUWq1gSmGS4c51LQd0KIwneANhp9b;20:YR7DHRx3jVn4NXEpMW1iFKP0OOHDWs2snk/ds7jIOEiO6XewyOugEED3E2wUosYnTzrmws/QERO/m7jbNBOTk1nWnpKWNfvHyzMEWglv1sKd8MliP5EbGzSZdzwKZLM3k8z9YLugmE3V9g199jtazzVszLZvSw7NUUd67IjVQNs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1096A56D5BBB12C306537166FBB70@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501361)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39380400002)(366004)(376002)(396003)(39860400002)(189003)(199004)(86362001)(305945005)(6512007)(3846002)(99286004)(10090500001)(10290500003)(9686003)(7736002)(6916009)(229853002)(3280700002)(72206003)(6116002)(8936002)(4326008)(7416002)(478600001)(476003)(14454004)(102836004)(86612001)(97736004)(5250100002)(39060400002)(486006)(6436002)(316002)(81156014)(25786009)(33656002)(54906003)(11346002)(5660300001)(6246003)(93886005)(6486002)(105586002)(68736007)(81166006)(66066001)(76176011)(106356001)(33896004)(33716001)(2906002)(3660700001)(6506007)(446003)(22452003)(1076002)(26005)(2900100001)(186003)(53936002)(8676002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: OrFzHz4O/0bbq4ixWLabqzaLUUkrJrHNwHzqhAcEa2+bxvIJx3fMaFjPi4O3+sMcH2aLd+b0P0pUiT2QPDYTcMFAe7zOCA6jZFldUOFFFOHyacn/Of+iGofvsHBi4ND7fqlKiwpVyGuiqKRYg/xO8SBDGSS7yW1NqzFM7wB+GYFNxKWQHNaqGEE17IzusTLj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC88667098D4EE4F8F033392BB9E4532@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 53f35f80-24ff-443c-a826-08d5a4910342
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f35f80-24ff-443c-a826-08d5a4910342
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 18:28:27.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 07:57:54PM +0200, Jan Kara wrote:
>Actually I was careful enough to include only commits that got merged as
>part of the stable process into 4.14.x but got later reverted in 4.14.y.
>That's where the 0.4% number came from. So I believe all of those cases
>(13 in absolute numbers) were user visible regressions during the stable
>process.

I looked at them, and there are 2 things in play here:

 - Quite a few of those reverts are because of the PTI work. I'm not
   sure how we treat it, but yes - it skews statistics here.
 - 2 of them were reverts for device tree changes for a device that
   didn't exist in 4.14, and shouldn't have had any user visible
   changes.=
