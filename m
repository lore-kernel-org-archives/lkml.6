Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523896768-2-5430735400350920300
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
    1523896767; b=I5xTfbPrJmiKB6bGTHVnaLWRHQ5t056s7WI3fs7pqq9qIGC1JK
    N83J8LWmbeOnBlOwgGLJlFbeGYCQ6k+jVIl1unK1nOAwXQguIJen0Axkpx/gMNyD
    1FswUT9pUNBaVM/B7oHeIGQn5xo/DCXT3hXH7CX58JLyZYnbbiWC9ZfCbN2pFMJS
    6Ov3EFq/2jm28wllWLsYksBHHmDxMc6ujVKshLSTj3+892xP+f7Mwzs3ZEIerpM0
    eXylcKASVM+pxp1thtBdVCL6q5Wq1c3NCl+zl6izGPTklw2WGlXqhSJWsqwVqeOl
    XRMbd1vm5SvoWMjj+LpFDo/E6m27xNXDzXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523896767; bh=GgHcToY9EvVTZ+hf9OKpHNGuwi5A2aowmla38IJu/WA=; b=
    tm+l22eXD44kLpmn+ZvWqMCY8uQpROTOxcdEY9zavXbITSJMB6F7woa8jWwW8+t0
    wUlPb6PIjLwrKwRJe41+kR3GQc7yVtG7Z9+f7jsmae7CVIamUoIXgEwJGisHz1hK
    haVdkyaSjtHxVAtaqN1M7SU1LRStkHixYUUr8sXT6JNC5PyC5cFpt/yIBBTasHcy
    HlInVb61Kj/XFKNuw0xGjGBdTvk1+59LP6khr+jzrSfRQmPnlE35IAbPLLC30Y6L
    PEjpBwCYPIAbZSpGfbxKARq2wz/fd4LKqSpoFyMvB1CrSsc6pBt0ZLJqwJ4F6bY1
    88jmrTYbzX8XgxOJFzBTCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZPqxJOld x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZPqxJOld x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBDhf9xAYCUV6mmQNMwZ4oSym0p7zTsnyxxq83bahnKgl3kgNyXAhOEaKuKgwRh/cIqtL3o4mYy714gQuQJKvKiU+W9CMdCT7CViZleGtVUMGlYm5/S1
    j+ZzMuqCkZFTiptwWoYSxbPoTfmfEMVnPQkI7uiV7skP7uDmGCFVrxRJgK5BDcsELdX3C9Qu033Z/4bN0ks2uhVfXz/Cuf+1pl5jg9v9saxMooH0Mm3d+yNr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zXgViuNbOfGlvFm-578A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeDPQj0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:39:26 -0400
Received: from mail-by2nam01on0127.outbound.protection.outlook.com ([104.47.34.127]:44597
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751002AbeDPQjZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:39:25 -0400
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAAQXAIAAAuyA
Date: Mon, 16 Apr 2018 16:39:20 +0000
Message-ID: <20180416163917.GE2341@sasha-vm>
References: <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416162850.GA7553@amd>
In-Reply-To: <20180416162850.GA7553@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:qKP8DtScGdKaX4JukNPZ8sLntD/YK944LEbt5aZJDC2EtlKVXIDkuhH0AW6Pt+EyKmzsKPrnw1ZJROf4OgyqCT5MLoqNmFkkiAt2IyWWSwaXRzMgaER9yN8hFSDuMr5o7Z757hWcSHAtD4pgj708t9SY5c6jnOhSTdnf6p9iRVzGPMAuIOzsi4EmS6l4nUa7ALrHrnB8d6Hu9zlbkCd5wm5GMOBBeRcjHee4icS9BsDxJyiuLtTTudqtq1YzJAmL;20:sEWYglG1A8v0fkwyERn4OgKzaXuc7X9q9qZ8aXBik4d+x3Gh2jzIgCpfoR2OPPB9ueydTBfu2TO01TcMeVJvkN2vx6+3baOturu+CnHByMs0WjovOoZXij24e+Mi2vTdM1cZnHAuLbcfM7l5Y9xHudaYtLx7GrHxLVm9JIvyT2I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088836563383FA8E1ED426A2FBB00@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501347)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(10090500001)(66066001)(7736002)(446003)(11346002)(305945005)(6512007)(54906003)(9686003)(97736004)(33896004)(6486002)(229853002)(6436002)(316002)(7416002)(68736007)(76176011)(186003)(86612001)(72206003)(106356001)(86362001)(6116002)(3846002)(5660300001)(476003)(93886005)(8936002)(81156014)(81166006)(8676002)(2906002)(33656002)(26005)(25786009)(99286004)(1076002)(5250100002)(22452003)(2900100001)(105586002)(6506007)(4326008)(14454004)(478600001)(10290500003)(102836004)(33716001)(3280700002)(59450400001)(39060400002)(3660700001)(486006)(53936002)(6916009)(6246003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: opvXDHwOYAmYrcmeHdu+c4VczdHy5iiU3BIc/+KeoDkJJLG9o1Np/4gNzFyD3bRHIiFFOLblbQQ+vkkwdPQ9w9HnTz0x6ZIg/rcaoooxEA7PLt9IkLe0LlOn/EBMXaejHar8ApcmmsXbXoSlJNNt3iUYDa1i+Y6jCPO33WrWvinM9qSrAe3OKNe3nkiONoDt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <72CFA7D0500218408DD130DE38BEB7B7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cdff0b17-df62-4cbc-d20a-08d5a3b89a65
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdff0b17-df62-4cbc-d20a-08d5a3b89a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 16:39:20.1326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 06:28:50PM +0200, Pavel Machek wrote:
>
>> >> Is there a reason not to take LED fixes if they fix a bug and don't
>> >> cause a regression? Sure, we can draw some arbitrary line, maybe
>> >> designate some subsystems that are more "important" than others, but
>> >> what's the point?
>> >
>> >There's a tradeoff.
>> >
>> >You want to fix serious bugs in stable, and you really don't want
>> >regressions in stable. And ... stable not having 1000s of patches
>> >would be nice, too.
>>
>> I don't think we should use a number cap here, but rather look at the
>> regression rate: how many patches broke something?
>>
>> Since the rate we're seeing now with AUTOSEL is similar to what we were
>> seeing before AUTOSEL, what's the problem it's causing?
>
>Regression rate should not be the only criteria.
>
>More patches mean bigger chance customer's patches will have a
>conflict with something in -stable, for example.

Out of tree patches can't be a consideration here. There are no
guarantees for out of tree code, ever.
