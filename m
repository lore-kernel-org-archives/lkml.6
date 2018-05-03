Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2576527-1525354265-2-5816797870407787081
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
    1525354265; b=Ed5M1n1QeNb0IX8yTWNQ27Nl04I1CquzmFKtPIXu7jd4JPvDl9
    yTYwAxeuNVGV9WQ/6+nSJa8NZgtukC9fcTXA/DAt4tVS3CXz7TXYyz2wOxkFAkI7
    rlcUvsdCvOLgEwi1/kbPFNZGlvDefcko1l49KDVhD5ta68CwtpMMkpgHqvuSL15Q
    W1dFj77t4H0aAaXgHvKDBa0woPiu0+DXg3w+bxmLx78ejYS+87yUWek4kckfXp8E
    9MMqJ4ctBM0QfSnSzAZZQhm02C3sjLa+B1yqR90a9mgkLmZBfvNWUajGWo65LjsM
    ouTbbyPsSbqo+T0pw40la9+kbK4kMU66ESSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1525354265; bh=RcITnKUzaKi09Q3s/xDN3MXvIOMouirjOOpfLC4Cfso=; b=
    e5ktoPIG/SfyCGgaYqL6N8Qhacln9pWTCQ8KvrXhq+8wwPVLn+JBRFU/8/Ppn08C
    Ad0lSlzH8+W6AY6eZjUyEGeOkDrtQl2fSr0d0BMeqEIojq9Skgqw4poxzG02mFNU
    Vu5H4OTMHFBg3kwCdrfDoH/A8OyUQ6vUgqKuCQ4UOOQzLY6ymYCpVJT+M5le7T1Q
    cQcEYLT/T6RstXTBVocY/vo/bzLbMAH+ojQZRhkavEVdnsTfPvfs/JMtVJ1MiDT8
    HKd5Zxx0oIB/HCOuXRzJDXJ38kFyuTt3EVdaS1pB18RoFUs2EFa7vAU3mg/OVhIG
    aFqHLoEgv0rXY1O/MJFliw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com
    header.i=@microsoft.com header.b=B1rwBSRb x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com
      header.i=@microsoft.com header.b=B1rwBSRb x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB94fj7o1XD7uVxsG4ezBRRwCFZ5VWu3XF0H9/OHsD990l5mtMCvH1dqFXG7iT+yPfM+X0LStK0NOh0+WzuPqLAJLrIBGq9ehtH8034anT37wMEzQFWq
    3Z3koCg+2C1SRvZJRuWmKugnXFNxA8Y0Arf5ufWkPTGyTiceE+DH+m8OPAJ73BuNqQY3NGSA2OAHKYMQ2DTe/MtYSWcuvrW97W08tnZMXcY8huLBKT5FW4FF
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=Lf-vpJhqX20A:10 a=wOqk_BPhYUlbpd4x53QA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750965AbeECNbC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 09:31:02 -0400
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:41664
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750922AbeECNbB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 3 May 2018 09:31:01 -0400
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YCAAAMcgIAAAh8AgAAH3gCAAATcgIAaM/uAgABCrIA=
Date: Thu, 3 May 2018 13:30:57 +0000
Message-ID: <20180503133053.GI18390@sasha-vm>
References: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home> <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd> <20180416172327.GK2341@sasha-vm>
 <20180503093214.GB32180@amd>
In-Reply-To: <20180503093214.GB32180@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1131;7:d3JLOCchaArvmisnH7DpMozK9cGLeNOnceokmo5knrdNfEAIRZ9JVHfdt0LES4+M0KKEHcqSFNltNXdQju0R4meb19yufDpKT1UYDTVzmfdlhPVxiv8dQKrzm4mTOIOyrnV+8GaAWe5U41G1cc9wLF1wAY2NBBEhnuGCs9fpHYSlWU8jk+wsRKQ9u4i4PuWnQHXhfh6yFLF/sCObx1qrdGZuKLDPjvDOX79o25b1EuZX1dyiCmGvdzORhf2T4xXf;20:iM0Lg+H/CqRZ0aoKysnumIx7tl68dSwLFhVLUKD6ygR3Bvh8gzX2zlkmCp/RYx79NvTBDA7Ywl8qlI+iHo2IBMQcjL1uAI2z/XZVOisqwLS8gqD1DIwll19fkAfzr7JyVFnK6+CH4gbqez7PXRzbvsZkA6VOnZIGeC6laaA40UM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1131;
x-ms-traffictypediagnostic: MW2PR2101MB1131:
x-microsoft-antispam-prvs: <MW2PR2101MB1131B4C1EDDC4F23ED67BEC9FB870@MW2PR2101MB1131.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1131;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1131;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(396003)(39380400002)(376002)(346002)(366004)(189003)(199004)(105586002)(8676002)(81166006)(106356001)(81156014)(11346002)(478600001)(446003)(476003)(10090500001)(6486002)(39060400002)(7736002)(14454004)(486006)(5250100002)(1076002)(72206003)(4326008)(8936002)(2900100001)(229853002)(6436002)(6916009)(6116002)(33716001)(66066001)(3846002)(97736004)(3660700001)(102836004)(68736007)(26005)(6346003)(33896004)(9686003)(6512007)(76176011)(33656002)(53936002)(54906003)(59450400001)(86612001)(2906002)(3280700002)(316002)(305945005)(6506007)(186003)(86362001)(93886005)(6246003)(25786009)(99286004)(10290500003)(5660300001)(22452003)(7416002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1131;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ZHYjgLnVHPwP74zFKBsoN+YxDNoWDVFqIpkHBlsYgdWzb7TMoVX7axnyyOGHkXE3a6juXng0v9uy6I4SzdO/GOdxON+y/p5bLD848or9rSzjBWyj5axZIloXRIMvJA00cYc5NxFNv5ojWZ6X8RE9SeXzzKZUJw6Ab6q6IvWX+HSDl08OJUw3PQPKRvaUdlXO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <752880930140F24481B3BCAF2318E19D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7cb30c05-3f67-45e7-1de7-08d5b0fa1a70
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb30c05-3f67-45e7-1de7-08d5b0fa1a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 13:30:57.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1131
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 11:32:15AM +0200, Pavel Machek wrote:
>Hi!
>
>> >- It must be obviously correct and tested.
>> >
>> >If it introduces new bug, it is not correct, and certainly not
>> >obviously correct.
>>
>> As you might have noticed, we don't strictly follow the rules.
>
>Yes, I noticed. And what I'm saying is that perhaps you should follow
>the rules more strictly.

Again, this was stated many times by Greg and others, the rules are not
there to be strictly followed.

>> Take a look at the whole PTI story as an example. It's way more than 100
>> lines, it's not obviously corrent, it fixed more than 1 thing, and so
>> on, and yet it went in -stable!
>>
>> Would you argue we shouldn't have backported PTI to -stable?
>
>Actually, I was surprised with PTI going to stable. That was clearly
>against the rules. Maybe the security bug was ugly enough to warrant
>that.
>
>But please don't use it as an argument for applying any random
>patches...

How about this: if a -stable maintainer has concerns with how I follow
the -stable rules, he's more than welcome to reject my patches. Sounds
like a plan?=
