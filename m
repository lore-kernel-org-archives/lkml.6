Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1547530-1527775940-2-4339874536362323875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527775940; b=lnmAnUYUBJ46X0wK8oQCaeR94VqY+HGUjL1LcBKUD2RfFu7upS
    ViUd8wb95+x9IofmwCCHlsREUH26scDbP9fFAvd4ICKMkrAyBQnycxUqzRbhCA2r
    c+tq5xkxH4VmZpgWMq2s6/9mzX7G0QkbKNNBDz4RWuhKj/4G1CJpkZN5NiLohVHJ
    0F9PyiOmf/vP0Knd09XjuJQLQ0iYwoTb0ey4ecDYg6FoVAKfcFjRXDBnMB1zpR7N
    O/O/X/ZT1JCMZCId6jy7L08j3jquXuiRWgX76rd+EJzBqWuJv3ZwCpdNjv/C8muP
    NTTPG9H68rewGwjePElHzp8RlNTjDxrAzFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527775940;
    bh=/st8NL8N/Aai3CT1kuhSshMxchs7tRs2GzUJHNBJgWc=; b=CHpFHOIEIxxe
    Q3GhG9Q1pQ6mVOFjJ75uTVcjCtBcS4+BgXG9tYiE/zFVaQGtOgtYin5y0QkD8f+P
    LpUnrsWHmbrg/FLhiZNoax8QMhfcB6bbogEU1/ISJ5eYw50oTb7Vq9cTuOrIrxEM
    A11EnBzIvfoZxXGE7pkocPws9ihpeX/wprEbaxfItrNT6aTBucw1sg9e4FztV4jk
    BoqVyIiVXvFqOIrjK5bb52URoDtmvrRPe2MQ/2Kyj7xwZO5Sly9lClf1WkMo/fgL
    wdAauFL/IoQotzXRd5gobgY+gLuHFgmh0dPJQnsUoaeuwvQRX2MHLlrEvkinzJTt
    Un0Vmaza7w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sony.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=sony.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sony.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=sony.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXA5K/m+4+oaH33btJtwO2nDOz18FGE6qWEnkSIW8EirODfkYsEq3O3QPYIBv+cDT8WMcBNywNUMc33S6bCrQprj/b1nhwwwKq4i4zqPErzS0DX9MVC
    5PBtav+p9zprNgsmBD+lXXVmIuWhn4vbp39TLJXkwP71B6o2wJDd/HiCeljSDnDzQidTK+OaEY5KdadNq7lQokHuzoTS+gZt8Qt5mgVhSX8Tqm78D6qoqp2Q
    bF8sZ2G5TViHtEtNSH3paA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=YMoOU55_PVpsFRh4C0wA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755261AbeEaOMQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Thu, 31 May 2018 10:12:16 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:5389 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755202AbeEaOMO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 10:12:14 -0400
Subject: Re: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable
 holds
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
 <8bbb095e-31c3-0062-d17c-662e4832cc17@tycho.nsa.gov>
 <1cf240b9-57ee-eee3-228f-5ad4a3a39e57@sony.com>
 <9332801c-6102-2486-ab60-b48bb38ae207@tycho.nsa.gov>
From: peter enderborg <peter.enderborg@sony.com>
Message-ID: <71925d61-743e-76a1-b0dd-1948468e2773@sony.com>
Date: Thu, 31 May 2018 16:12:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9332801c-6102-2486-ab60-b48bb38ae207@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/31/2018 02:42 PM, Stephen Smalley wrote:
> On 05/31/2018 05:04 AM, peter enderborg wrote:
>> On 05/30/2018 10:34 PM, Stephen Smalley wrote:
>>> On 05/30/2018 10:10 AM, Peter Enderborg wrote:
>>>> The boolean change becomes a lot more heavy with this patch,
>>>> but it is a very rare usage in compare with read only operations.
>>>> The lock held during a policydb_copy is about 1ms on a XEON.
>>> This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
>>> That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
>>> In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?
>> That one did not make it, so I went for a other path. Make it simple, using the same serialisation that exist. That also make it easier to maintain.
>> We do not  use the booleans in android since they are not allowed so im not aware of any use case where this administrative function are
>> used in such frequent manner that it would have an impact. And it must be some other large overhead with interprocess communication and
>> a multiple writes to sysfs during a boolean settings?  However my concern is/was memory pressure, setting booleans will generate pressure
>> with lot of atomic allocation and large vmallocs.
> Yes, that is also a concern.  I would prefer to only duplicate the conditional policydb state as in KaiGai's patch.
> Keeping temporary setting of booleans lightweight is desirable for other use cases than Android.
>
> I'm also concerned by the implications of switching all of the allocations to atomic.  KaiGai's patch did not take that approach either, and it obviously could make policy reload more prone to transient failures.

On the version 2 of the patchset you pointed out that I did a shallow copy, so I did a "deap" copy. As I see it the KaiGai cond_policydb_dup also do a shallow copy.
You dont happend to know exactly why KaiGai's patch never was accepted?

>  But my goal is the fast path for real time critical functions such as audio, and it will be a cost for
>> administrative tasks. On the xeon it takes about ~98 ms to run the security_set_bools compared to about ~8 ms without the overhead
>> of copying the policydb.  About ~6 ms is rcu sync and ~8 ms is the same as the original update of selinux statuses, and about ~25 ms
>> is policydb_destroy() of the old copy.
>
>
>

