Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523899417-2-4512058226388041815
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
    1523899416; b=eAX4whNbteNkdcTzQIE1mT00OxzJNvp/pgmS8N5JMnEN1efuyM
    LOs1x5H/1WDweHozmBZA/QmwRhixt7ivz+QMGEywo0eg+lFdj65qISqHn6kfaAsu
    1589fwkf3rU9yo2KX3J675uYYffwro3rnMKc3hH7lj4YSgPC+4jFA2sURmQtsP4+
    epqpHxEiQEh4Ew5epnt8TPKRXKS6hBXYyq0+Q8owxa0wtP2oNxA8z15HUkgwm/SJ
    usDY9PHIYbQnNDk8o4TvPxJuXj7+0va64+doWwWvzHZn9YSF5tfNhm8rzXm9BUl3
    BO8BUgiu57FYt1HgdAY5I2gbvvx8RjgtDTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523899416; bh=t0J2VQ4cokhCB6bmZUUrOSx/h0oJxIlr798OLNYF/kg=; b=
    V14PXItpl/uFfqJxAj+ph6v+5QKu8MmHclvSmQfWo29fGAckO2QJMfoCO2xQBx/U
    iWlpY6ACcNBdJaCFXxTPbJF1GeM8xt+jA9iN9Fp4PlVi0IXxNpvv/ab2k4Ib6wNx
    OGWPjyJZyMF69KnyLhE492nIdOeC+CR1J/UZx7oQcSfHOSF3xyKd4SYSfy/zmB34
    W1yNMTHbVnbp18ECvizora3FiuZHh+1Vng7t268dHOo94o8DqApRVWf6uxmCNfUo
    +fFzj2xPoDPjri9UcTGdcG9+8UTQ3NpPEdi0H6fhZ8MVY/aiHqkutKEhno2DAg9Z
    38AmnuPIpjua3Mdsj2/Oug==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VIpHhMpU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VIpHhMpU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDh8sBDgyPPDpeZ+JxZALoOn8S2SY3tMCBdFxsGHZtDwhpu1JjgPAFcoNSjlZyIDFLXGBz9LZyTJxldvegOCNUg1KyKZlpy794Wq+sfCFnlXODwea67P
    m3OmKGqldbTGWxLSjyYbc4h/YbMVV0HGQdbGCA11QzbtLg8k1V5HJ9Lbe6h1lK8UEKDzcSjyg1i+gALpg8WgSpEf+DRMN8GnxhIFa4JIJpxhRkPQI2HF2Amj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=SRtG7gxO2Km64r4ENvUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeDPRXd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:23:33 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:62336
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751135AbeDPRXc (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 13:23:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Steven Rostedt <rostedt@goodmis.org>,
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YCAAAMcgIAAAh8AgAAH3gCAAATcgA==
Date: Mon, 16 Apr 2018 17:23:30 +0000
Message-ID: <20180416172327.GK2341@sasha-vm>
References: <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home> <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd>
In-Reply-To: <20180416170604.GC11034@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:7WvkA4w3/0O6uEABlPzwRVgyfTM8SkeiQezwBUh218iZJOEJWmBYEYEto2ete2mAjxR6T6iLSptK5fnyibr1PcgTEve+GAXdXBzYzb5uCws7kfom65AhrIIgZyNaS65Sc5Ycn6LX7IgftHuKveNlTck1CnrQHoyFL0rGG8VC/08/Svqe/5dPUyv+Nbvm3jI7Vw4VRCqS2sQu2Pa+1KTboWV6F6IttZPX/rqwVsp/DQAjL3PjaaO62h9z6zFyU0Tu;20:sDI47CPwK77yduvujd+Jh0DO0ha8e5MQyjw0W0xrOh20LX0aGhxUwSNrNvipurmkbX7+k98fv3+uA5AhCLvX+17EcPwFCkulZSV5rNDiLcUJiReMCt49Ak3NnHBcfTlq2zK3tSlfD1xQBz5ohgkFvPX6mlWBL0YHctBaSPW+ZAc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1096DE3A038293FC76303BABFBB00@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501347)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(377424004)(189003)(199004)(51444003)(6486002)(7416002)(8676002)(105586002)(81166006)(76176011)(81156014)(33716001)(446003)(33896004)(11346002)(8936002)(33656002)(6436002)(5660300001)(6246003)(6916009)(186003)(25786009)(2906002)(26005)(106356001)(4326008)(229853002)(10290500003)(9686003)(39060400002)(6512007)(6116002)(3846002)(3280700002)(68736007)(486006)(3660700001)(478600001)(7736002)(102836004)(14454004)(6506007)(10090500001)(5250100002)(22452003)(86612001)(53936002)(93886005)(66066001)(2900100001)(305945005)(86362001)(316002)(72206003)(99286004)(476003)(54906003)(97736004)(1076002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ynbqpEOEYxj0xSgNCCgkJygbe6HWK4nHKY4/y2K2aVTNTst1fjXp3Rfvlca/N2ahCEncaoq7VOLBV/cffRei6h1B5S6eUllx4Fq6qdgOMdfMLV0dGV5/Q3xCgNiQ/m5i4rssSmAxseIYSlAbTAgzw+qx1dqKqdW05v2eReXdrNnvRQGnMkkUCh0dIv3LZnPm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D765F417F57E84DB8B91271B39281FA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2d77e671-9330-4378-615b-08d5a3bec62b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d77e671-9330-4378-615b-08d5a3bec62b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 17:23:30.4757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 07:06:04PM +0200, Pavel Machek wrote:
>On Mon 2018-04-16 16:37:56, Sasha Levin wrote:
>> On Mon, Apr 16, 2018 at 12:30:19PM -0400, Steven Rostedt wrote:
>> >On Mon, 16 Apr 2018 16:19:14 +0000
>> >Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>> >
>> >> >Wait! What does that mean? What's the purpose of stable if it is as
>> >> >broken as mainline?
>> >>
>> >> This just means that if there is a fix that went in mainline, and the
>> >> fix is broken somehow, we'd rather take the broken fix than not.
>> >>
>> >> In this scenario, *something* will be broken, it's just a matter of
>> >> what. We'd rather have the same thing broken between mainline and
>> >> stable.
>> >
>> >Honestly, I think that removes all value of the stable series. I
>> >remember when the stable series were first created. People were saying
>> >that it wouldn't even get to more than 5 versions, because the bar for
>> >backporting was suppose to be very high. Today it's just a fork of the
>> >kernel at a given version. No more features, but we will be OK with
>> >regressions. I'm struggling to see what the benefit of it is suppose to
>> >be?
>>
>> It's not "OK with regressions".
>>
>> Let's look at a hypothetical example: You have a 4.15.1 kernel that has
>> a broken printf() behaviour so that when you:
>>
>> 	pr_err("%d", 5)
>>
>> Would print:
>>
>> 	"Microsoft Rulez"
>>
>> Bad, right? So you went ahead and fixed it, and now it prints "5" as you
>> might expect. But alas, with your patch, running:
>>
>> 	pr_err("%s", "hi!")
>>
>> Would show a cat picture for 5 seconds.
>>
>> Should we take your patch in -stable or not? If we don't, we're stuck
>> with the original issue while the mainline kernel will behave
>> differently, but if we do - we introduce a new regression.
>
>Of course not.
>
>- It must be obviously correct and tested.
>
>If it introduces new bug, it is not correct, and certainly not
>obviously correct.

As you might have noticed, we don't strictly follow the rules.

Take a look at the whole PTI story as an example. It's way more than 100
lines, it's not obviously corrent, it fixed more than 1 thing, and so
on, and yet it went in -stable!

Would you argue we shouldn't have backported PTI to -stable?=
