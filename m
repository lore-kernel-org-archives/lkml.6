Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-816892-1527744919-2-9700297172796468203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527744919; b=JH5Hi4a594gxQHMopEapRJ0oBb0iVjCuCktquky3RUUt4ecFg3
    +a/cDF1rzTJsVQVWqUjCnBjhjD88bTh5gZLqtzsGE41Y/mfoiqtcYayrLW4b+WGD
    VINR/qus41qDRWA+UebHA5oTATI3UMqpSdC+jOCJZ93Y5wnu+7cmWjhtSg9UL+qc
    tyCFRfa3kaKTRmWgApzDTzlo3X/HkJNKN7jcW1baQXMpBq13wzxjLbbS70D5PBsk
    nJpWfV11YtUcfhr1mCvb7B2TrTtc83rWhdBRtZTMKz+FHTHQ5JKLs3G+Bf7qhzV+
    +RBxQOSaiLFcCjv5FxK7V8Bo6Oc8onIVHj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527744919;
    bh=Q+S4I4zkGYe6PgIPfbPvkFibh88t5uCokjJ8EU2h/D0=; b=P8wPAzDBzgRE
    kit3nw8ifrbGOdX13NMaCShwddFk5qBPho7WU/nlMK9phTFOYZQ/WO7nqrxshkGv
    0OsG4EqZpzCXXXg0N4uGV5CaRS770DEbt8wIU8zzyzWuRPqivaws2J7RYzgJlsdP
    yvYEKoacnXfsfjD3e7f3nxsiy/gHK5gMw6bkBqqiBnJv53uaspue2wKunOXmnFce
    l0u05GAoGtrl3tuwS22udy//lvzkg/ipNZSloB2s3h/yoa+ivVungeas6vzAUpjp
    DRB8VQE/jLvHGNrJdDAFksHnLQWFyhZvOb2XIq05BTuhuJV1Ik3dvvp8n9iZggQA
    y68cWwNiWw==
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
X-CM-Envelope: MS4wfF7u1W84Z9Ews9LAXyO0x+R8GYok+wRK0Z7KoEF1CNnl5rw69gU7UzVJK3t3H7gamjvViVOq1RVQIw+0c6lvqkMTxT5qIJx8i4aWvXfR3+lvMJv4Qm7t
    HjtoMwD9zq30lQH4BOCStTbQlYL9qzM5gSP4CGDCi1N3onBLhFI9BM4y1eoRYKN6CaBD9X+bZ0alKdsB+IjSJlKNrwTp+egAsTLi3tKhjAS0YrFZAqiq1/av
    rtoiv0+kFflUsyjQhIAsJg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=YA5P4JyXlLkQuagTDgcA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeEaFfP convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Thu, 31 May 2018 01:35:15 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:19160 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751037AbeEaFfP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 01:35:15 -0400
Subject: Re: [PATCH V3 3/5 selinux-next] selinux: sidtab_clone switch to use
 rwlock.
To: J Freyensee <why2jjj.linux@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
 <20180530141104.28569-4-peter.enderborg@sony.com>
 <c41e327f-9bf8-a2f1-bf6f-326357d5ed8b@gmail.com>
From: peter enderborg <peter.enderborg@sony.com>
Message-ID: <85176be7-360c-d823-c3b5-3651c74ca5a0@sony.com>
Date: Thu, 31 May 2018 07:35:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c41e327f-9bf8-a2f1-bf6f-326357d5ed8b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/30/2018 11:22 PM, J Freyensee wrote:
>
>>   +int sidtab_clone(struct sidtab *s, struct sidtab *d)
>> +{
>> +    int i, rc = 0;
> If s or d are NULL (see if() below), why would we want rc, the return value, to be 0?  How about defaulting rc to an error value (-EINVAL)?
Oops! Thanks, will fix in next set.
>> +    struct sidtab_node *cur;
>> +
>> +    if (!s || !d)
>> +        goto errout;
>> +
>> +    read_lock(&s->lock);
>> +    for (i = 0; i < SIDTAB_SIZE; i++) {
>> +        cur = s->htable[i];
>> +        while (cur) {
>> +            if (cur->sid > SECINITSID_NUM)
>> +                rc =  sidtab_insert(d, cur->sid, &cur->context);
>> +            if (rc)
>> +                goto out;
>> +            cur = cur->next;
>> +        }
>> +    }
>> +out:
>> +    read_unlock(&s->lock);
>> +errout:
>> +    return rc;
>> +}
>>
> Thanks,
> Jay
>

