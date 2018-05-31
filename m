Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1205368-1527757492-2-4421357222018560598
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527757492; b=StfH7JiZ8n+j2QkJ17lxix3F+J//JSVbFOU9qBYGgQy1+9l4xS
    t3jG2MCOucaA1T//dAHqGMN5OQTsQj04c4dntSuUd2rPGEUVV6DgGVtzztPPLQfk
    mOU2QSy1jZ92qJl0YeVp5GOtEAU0cjgUE/OmiEMInpIHP+I5GvofMNe9OlbB2Qti
    ZYOUmcgcQRQknpq5b8Bl64vaKms/5U0r7h14F/Q0Wy8aJrZZc3Br43+ipLunMNxX
    usVF9SyqaFgTuMcMrWRMKrg2cotH0xsh2KJmCfvPnYtyVpw3NTcXf+KN3izdjH0d
    SMRqQ0c0HAfZV+vXtCM0YrFQdVxmlcQ/H90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527757492;
    bh=65fbaCKQdhqEW7uARq07FaLVli1qsyPFaf73/kpCcSA=; b=II9oSOP2ooz3
    LGwdA/pg+tjU9gMU0lNLgRVRaL+5dylDDJElonCHY9yCRpwP4VgwcGuEF/dahLWW
    JHiGQ2NeBiyAXhmKaepAnMFN8voMIWXcNG8t/3QnLmJgURCMMLgH9GYvG06krR93
    IkCYAUpAr3H5Jo0T6ER4ppexk+XovBrbkEHmzq4t2v//9UdXMOT0tdGQ5r40G/pz
    1WKiANBMEmlvzETPhwuh4RvHwMte3w6hvGkczJC5VxeI1rXkd3ZF+q+RAZHi6BIF
    RE0Az1mQK0bNWuhdThKQTLBL6/Ovck19Pp+7vySKN69nQqMuflQpE30727MtiS7I
    pmdYujkOig==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfN5i63ozmbuTs5HDJN3BUMynD4rXDWnvEoXqwiDHfK3M0zwnH9vPiw++1j3eUUMB4v+cBi90TBf4HE8IjxrCkBR65cNF6GM7Tp9Wj1RHh24v8P/4q/Jo
    SbQEoRTc8ftSW236R6VczcaPq3plzAquY0a6UWktWHzIftSKHzg9spbhNF0+u7KZ2Njdkr9CDMqazhQb5qGQJq267lnakqxa3nuQMQn8GmgSH0W9PcMFS1fi
    ix5PY0KjWg4Y4t4r1sluhA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=UbxuYF6J-PaP87X-4tQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeEaJEs convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Thu, 31 May 2018 05:04:48 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:19267 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754026AbeEaJEr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 05:04:47 -0400
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
From: peter enderborg <peter.enderborg@sony.com>
Message-ID: <1cf240b9-57ee-eee3-228f-5ad4a3a39e57@sony.com>
Date: Thu, 31 May 2018 11:04:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8bbb095e-31c3-0062-d17c-662e4832cc17@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/30/2018 10:34 PM, Stephen Smalley wrote:
> On 05/30/2018 10:10 AM, Peter Enderborg wrote:
>> The boolean change becomes a lot more heavy with this patch,
>> but it is a very rare usage in compare with read only operations.
>> The lock held during a policydb_copy is about 1ms on a XEON.
> This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
> That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
> In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?
That one did not make it, so I went for a other path. Make it simple, using the same serialisation that exist. That also make it easier to maintain.
We do not  use the booleans in android since they are not allowed so im not aware of any use case where this administrative function are
used in such frequent manner that it would have an impact. And it must be some other large overhead with interprocess communication and
a multiple writes to sysfs during a boolean settings?  However my concern is/was memory pressure, setting booleans will generate pressure
with lot of atomic allocation and large vmallocs. But my goal is the fast path for real time critical functions such as audio, and it will be a cost for
administrative tasks. On the xeon it takes about ~98 ms to run the security_set_bools compared to about ~8 ms without the overhead
of copying the policydb.  About ~6 ms is rcu sync and ~8 ms is the same as the original update of selinux statuses, and about ~25 ms
is policydb_destroy() of the old copy.
>

