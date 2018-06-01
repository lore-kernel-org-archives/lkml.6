Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3104510-1527851905-2-6956521426744313941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527851904; b=XUY5bl2hlWY6rnYwEYKsFPOmQtuo/Kaw/I/m2YyvkBmpH6qcxH
    8mP9bvuxJq1uacyNLbj5/8+069KWL/9HfZP7oOW/wEbjGLrZcdNRqxBlaLCFfugg
    i9tvhWMECo53HMu6chtyFnTEgUVW3PLn5zfaxvmiktEr1NBCIDTU/YzBsFkE9OLc
    JQO0pJZfNKQh9z1VT5g9ZvB3C1FKxGBEQigFOPWYnSy+2BSosQqPplgIi6eJOwW+
    iGj5lz+EChRiOm36FjsF1XSVu6Zre28fGPDOHymuB6Kg0Ei1Hg+T8WcXd6rLWWwq
    h+ukvVKBIGkQaD1ZlYXizbLZGhogpS7ueeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527851904;
    bh=1FhnmD+4UtjtsUZU/E8whwQkGS2w6Lkm+EKHEogYNms=; b=mmxmKZ+JZii8
    kipbLNdXR7B/EnEOEE3vomVo+fJUBXWzwYixdj2ccxcSHKagI/ytA5KMUs0Ezv+f
    ZuKJIpekkMrQa/2yyLnYOltSS17Q6byAD140PgVZ49zvZyrxqIbN4dy+QarefzZ+
    Bee0lom9Pgvk/JCFLXK5ZAMF8wFwGk259MhTYZeSP7R8lQ8+6TfevPtfZjlMy3J7
    e/O6DUofGY+q2bGQbBD+qBq9qkd1Bf6CVoAFXj9ZkWPDWIwbYScm1l6OGXLlTOPk
    LSB3bau00KsDxxwcFC8UeQq4M7hZv5Alj7ccvepBxo2Yi6JU6NQDELmArR2VYZVt
    yGRU/uUfeQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHTcLfoQ7vqR6pLCgNXOVrxWvuhGvzo6h33WGt8Bt/q7KZGkSQiRqQBmVWr+SCtq1kNgPKTqkY9RRNQIzIGJ/ar9dAv2yf/9x9KGHYfNzQj6z1ed2CLB
    6FVi8zyP86rQZv9GoRnqzGbcQKcu0L0vxE0h0stevbXhyHY5cwK0OqJa9vgTOLH1frvQcSrvc6ZmI0Uo9tRfJ2ZMvENZJ2daeXMXxtbvXjvGb3ihsiB+jJTD
    QtVo+L+IFLDNg8nDOrjtNw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=YMoOU55_PVpsFRh4C0wA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeFALSV convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Fri, 1 Jun 2018 07:18:21 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:2390 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751301AbeFALSV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Jun 2018 07:18:21 -0400
Subject: Re: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable
 holds
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
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
Message-ID: <4838bb4f-34bc-407e-343b-113d6bef4be0@sony.com>
Date: Fri, 1 Jun 2018 13:18:18 +0200
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

It maybe not needed atomic at the time. But the duplication holds a rcu_read_lock so it need to be atomic now.

>
>  But my goal is the fast path for real time critical functions such as audio, and it will be a cost for
>> administrative tasks. On the xeon it takes about ~98 ms to run the security_set_bools compared to about ~8 ms without the overhead
>> of copying the policydb.  About ~6 ms is rcu sync and ~8 ms is the same as the original update of selinux statuses, and about ~25 ms
>> is policydb_destroy() of the old copy.
>
>
>

