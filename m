Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3595654-1523895572-2-8312911766115402645
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
    1523895572; b=FRRtX+dqTy1uMWDsRHe10+VnREyPVT31ha096ZQNCMJEVX1IjL
    kDzXdwdU7yd/wp9WoydCD6AsxgQmBfdrhQu9eow59HG3THPuOaiQOrZvZm57SYH/
    BB34BJIrqn3p0Vyd52zUJEv2qd44gx/Slj16s4g6l3888QZ0uPifqVMiRI/kHWxQ
    ipKqKlZ5tN8Pbf0L0tkNgyZYGuFIWUOk5MurHqrlls83rt+L9yhe5rh/J5yRiY1p
    LZYwI98Cay6SWXpGxl39Ci86WxDd0yhpNvlstZupsEoMok20GqEqgsgQKZIPW7KY
    d7jhYxSWvBPmljgWSQHMOZp8mn3SScHj49pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523895572; bh=mwYxkdgxDdE1Asn7+yAd/nfDjr37nBRnfKKoN2NA9gc=; b=
    Jov6+EFVOc0DKKvgyyUGQYFJLNvA9FTwjGNlxFISW3KpBSAR3KUx82VpkSdT2Hqc
    KFsuplocdti94FdSk1bMnz9R5qP0Ob0hCG96VSneCfef66JQk2dCESrF/vi7aMU9
    tJ5A/X8kvXn+Ci8eV19y0McwrKZbjU23icLZ9om6cnjQprbkp02p7Tei5frr7IsA
    D2DFiBSR939rhaRpilya1YoWKZaHn1byifR+Ubz8BCOCDiSTbwpPU/2KZOm4rboW
    QhUKjs8SaXHgTto78ffG9f2vY/09POjHmqyVadrmwdllV79czWf62pFvkjEjLlFA
    sO1GZmVvj/W9cbIjtZuGAQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EBmrTatl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EBmrTatl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOTXwD2otXUnXoIZ8fweVWjSoeHeWF3v8pMlIPo1ROs2WA50EDzdtzBfbRYc6YsJ5COxttI+fcmcF/ekUC1CQBa0P76/qqlIXMSswgqh1TRGPAVWlVRc
    PNPg6YWz17jn5FK5tS7MBtk+2xMfFCDm9zVYqFCSp+i3Y99n57MoJqrJyWQCFAynmTj3KvNLHfybHC+BnSfEfn8wCDW1zjz0Uj4HXlJLyElAbpr5nOD407eM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=nFZsQa-v2jaCq1odiDMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDPQTT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:19:19 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:53186
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752786AbeDPQTR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:19:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
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
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YA=
Date: Mon, 16 Apr 2018 16:19:14 +0000
Message-ID: <20180416161911.GA2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home>
In-Reply-To: <20180416121224.2138b806@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:wEUpt89hXqYgYtgdCieDWHw9KoclvzgbtPaGYk4TCea53O1oLAb9E4kkGdymtYfA76S50G5IamXCP+ZqiaEnSohrNbTN1oRkDrArqT93k1RvDZ25FncL9G8PHOc03/ODb+XBWjWQ8RWpRF7LdSdVf8dfVoO559OZYesFJe0Vt0iAFLvNUSFWnmUWDdauakl1A8RAN6GxiLs+yF1BgtK9izBlkh+Wf3LOpjtG1ZpxUhSQaekgAbjUD8v+1TE20qmX;20:hRXB4I1/0jJ8wp/cqSuKLTXqSQPeFIyjJib8doIhDTJTzexXzjaviTgVHQorKL60YpfJ8U/rGeZvk0iu2WUc6+gYzOt/ef20Of70XrjckHu6vBO3IO+dIjZhKSj/pDBrkkSVY3M5CQLEWf8IkObYhRc9Z47/NATC6YezSVQLZ1U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09830748B6D803CC2AB84FFEFBB00@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501347)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(5250100002)(6506007)(7736002)(229853002)(102836004)(6512007)(9686003)(99286004)(305945005)(6916009)(76176011)(33896004)(2906002)(1076002)(86362001)(3660700001)(53936002)(2900100001)(106356001)(33656002)(3280700002)(105586002)(86612001)(39060400002)(6246003)(486006)(11346002)(446003)(22452003)(10090500001)(476003)(14454004)(93886005)(72206003)(26005)(25786009)(6116002)(33716001)(478600001)(68736007)(3846002)(6486002)(186003)(5660300001)(316002)(66066001)(10290500003)(54906003)(7416002)(97736004)(81166006)(8676002)(81156014)(4326008)(6436002)(8936002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gay74AjbAldG1EKPfBri77kdPndFxcpauv0dJsY3z0FnVcGOgc0hq71GVvq87ZOPHEXBIDHMd97bnkJezzOl5hJ51IbkOS86jYTybp3fxxTiYuvyiPmYsuKGXayYdH4Wc/dUgXe7TcYvSNsBjf8VoEONwDZCMDVg7kS2vVL2uzEBtUZD2W+t0KFQs47eZfSd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB8C4AF0D5C5FB49A87D67FEF8EE2DB7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dc21e5aa-97c7-43fb-d9f1-08d5a3b5cbd6
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc21e5aa-97c7-43fb-d9f1-08d5a3b5cbd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:19:14.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:12:24PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 16:02:03 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> One of the things Greg is pushing strongly for is "bug compatibility":
>> we want the kernel to behave the same way between mainline and stable.
>> If the code is broken, it should be broken in the same way.
>
>Wait! What does that mean? What's the purpose of stable if it is as
>broken as mainline?

This just means that if there is a fix that went in mainline, and the
fix is broken somehow, we'd rather take the broken fix than not.

In this scenario, *something* will be broken, it's just a matter of
what. We'd rather have the same thing broken between mainline and
stable.=
