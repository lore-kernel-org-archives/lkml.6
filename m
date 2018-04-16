Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523900567-2-13648000620704296418
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
    1523900566; b=h+yo/aF8qu6wT8t2Am0fJMY2hW/wpKFAoHLyd6eqb/bRcQrVv9
    HAVxUBO8/X5nFPkDHngfCRBcsn9Sw5mZgIadB8Xi6tmv4yJIDtN4+7Jb5B7TtVBa
    kbn0AOXILEZosPdV45PGpibjlzKPg5501NzTT8ewkt186dkVBMdaYBNQ3fHJ8SEC
    lVKO7D9ovWotfCi8xXRd685UARgHIki3uYO6Pmq+R1svkwadOUs5/wko/0QYAOIe
    5DwgK2C4F/NIZ2ZYSt1hA16VuDh5B7iYUaZMhYV73hVADkFYlMIToHQa+bEVj4jl
    Un6TJ5FFnWvOvmbbJfjIICwCCKtPfBXe0IEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523900566; bh=vyUvjDmQZ4JLabdzO5cSY/Rs4TRpQK0Sn+VwrviaKiY=; b=
    IvrMUEeEIGzaipeC/fPMXjOP9Id7oXNPy2usTCmZ1YLmw0Nxzz6Vmam1JR3aZSGR
    hJheUDnTdVLlQxyYh9Q6moahiwb+Y1lgdS7fzsElYO72aMxVB3Lwk0LGxU5a4dvv
    RY/dsWBsxZXULbVJB6QUQ5fPuAEYC2dW5ClAn7H2blVcTeJ9zwqJHt2kmYp5mvLy
    FpwoVyR84+wxYn781tV+cWP5Qs3Y6peXzR2ikLcBgFRWT49w1kn8u0FOYhRBEjfp
    93SLbcHvyj07H8rdxJKqPI4N/MCpIpWubfjj45FR476H25qKkaxOScJHvjM+5YES
    Rew6ja+yL5b1f7CmsABK9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e0NaeHYn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e0NaeHYn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDY1TLDnarO9Q7IAv4FrZ4vVmpAVgo/1uIFEpU762xIP6hGMxh2zqJNyvEIqBROG/mN5X0KTK4G209XEoTmUNAW++eSR3MHpnNDNQwbDr/kBKj7DngGu
    FJybfHE9/rfT8AnKmFU6rQG5z7Uj5auFlkKyxI+x4oKIJ5bc5Xb8bJ22EOH4Kc3FToVXYRWYzXL01h6wc7binG4LvKownY9Ey9VXit4fXPD0Oy8qQNX5vXLV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=7Xwk0pq_iSxaCemaFr4A:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeDPRmo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:42:44 -0400
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:57751
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752557AbeDPRmm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 13:42:42 -0400
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
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAAD94CAAAIigIAAA1WAgAAA7ICAAALHgIAABJsAgAAGo4CAAAKVAA==
Date: Mon, 16 Apr 2018 17:42:38 +0000
Message-ID: <20180416174236.GL2341@sasha-vm>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
 <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home>
In-Reply-To: <20180416133321.40a166a4@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5SPR01MB348;7:Iq8ajdE3x+6B3jXs1J6BHJMnmzU/+gOo46YJkqo+ckX0e7eR/nTF7AJwvzamIvCGyDQ/1r4mlhl0AAB+Q5PBAjgTQciialLJzt/il9JiRKj/prLZ9Xo6wQtYc1pNgEK/xBdhiGnQS2YWgSqqzS7Abya9dLaZe1vb7ak9AEdS5DwUO5NhO1sgoeVL8ngXpImV/irQPyctPAgy15EFLSnvdN156jXKO/6dm/Wqv8q8PxQJ+G2AJtfqdKZvyBHRmHvZ;20:iOoABrhXpp/kVxXp0GC2Svlq6suoYp1U0d/yIOm0HUtGDy42o61fK5rj20sOi1NR+pImqENDYjoKwH6it/zrZiE+Zwje+PS3gMBiPSf37cPTe74CF+FD407PTG2FgpCSAHludgaNewuuu91gJksBOiOXj0n2GCZPEqZadezuzA4=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5SPR01MB348;
x-ms-traffictypediagnostic: DM5SPR01MB348:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5SPR01MB348520A4C8F495B8D0820DCFBB00@DM5SPR01MB348.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501347)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5SPR01MB348;BCL:0;PCL:0;RULEID:;SRVR:DM5SPR01MB348;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(39860400002)(366004)(396003)(39380400002)(199004)(189003)(6246003)(59450400001)(93886005)(10090500001)(2900100001)(72206003)(97736004)(39060400002)(66066001)(22452003)(6916009)(10290500003)(54906003)(53936002)(86362001)(229853002)(575784001)(5660300001)(106356001)(1076002)(5250100002)(7736002)(6486002)(7416002)(305945005)(68736007)(102836004)(6506007)(99286004)(8676002)(6512007)(26005)(186003)(446003)(4326008)(105586002)(86612001)(3280700002)(6306002)(33896004)(2906002)(76176011)(8936002)(81156014)(25786009)(81166006)(9686003)(6436002)(3660700001)(3846002)(6116002)(478600001)(316002)(966005)(33656002)(486006)(33716001)(11346002)(14454004)(476003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5SPR01MB348;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gDD46yv67HgDtX6fxiKDiR01VSj10EYzuTN63JkzW2B1r/ZHymu/k/Ft6B29lvL9sTToGCjAra6KBgiDwa/fRvaLVw70V74ju0RBc7HhyxPBr+fmIxlK8nHbustXeu6+1lMVN++grr3CMn03lwmvvPGjTCE5MdgDKzz65VoM3xa7RpCXw/oa60YCaZvsaoSx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9262C86D82ADEB48ACEB473174B565E2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 01c802aa-4e31-43bc-af60-08d5a3c17296
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c802aa-4e31-43bc-af60-08d5a3c17296
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 17:42:38.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR01MB348
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 01:33:21PM -0400, Steven Rostedt wrote:
>On Mon, 16 Apr 2018 17:09:38 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> Let's play a "be the -stable maintainer" game. Would you take any
>> of the following commits?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/=
commit?id=3Dfc90441e728aa461a8ed1cfede08b0b9efef43fb
>
>No, not automatically, or without someone from KVM letting me know what
>side-effects that may have. Not stopping on a breakpoint is not that
>critical, it may be a bit annoying. I would ask the KVM maintainers if
>they feel it's critical enough for backporting, but without hearing
>from them, I would leave it be.

Fair enough.

>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/=
commit?id=3Da918d2bcea6aab6e671bfb0901cbecc3cf68fca1
>
>Sure. Even if it has a subtle regression, that's a critical bug being
>fixed.

This was later reverted, in -stable:

"""
Commit d63c7dd5bcb9 ("ipr: Fix out-of-bounds null overwrite") removed
the end of line handling when storing the update_fw sysfs attribute.
This changed the userpace API because it started refusing writes
terminated by a line feed, which broke the update tools we already have.
"""

>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/=
commit?id=3Db1999fa6e8145305a6c8bda30ea20783717708e6
>
>I would consider unlocking a mutex that one didn't lock a critical bug,
>so yes.
>
>Again, things that deal with locking or buffer overflows, I would take
>the fix, as those are critical. But other behavior issues where it's
>not critical, I would leave be unless told further by someone else.

This too, was reverted:

"""
It causes run-time breakage in the 4.4-stable tree and more patches are
needed to be applied first before this one in order to resolve the
issue.
"""

This is how fun it is reviewing AUTOSEL commits :)

Even the small "trivial", "obviously correct" patches have room for
errors for various reasons.

Also note that all of these patches were tagged for stable and actually
ended up in at least one tree.

This is why I'm basing a lot of my decision making on the rejection rate.
If the AUTOSEL process does the job well enough as the "regular"
process did before, why push it back?=
