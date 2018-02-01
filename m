Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4189458-1517505802-2-11665728650427717180
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517505801; b=oJZvqlw5mM07wIo2R8QJF/DfuWp8GYTuar67BRdqDbM2IhO
    qKZqiRdEfLTQ9NSd22SPCh2t0cOFURymF49L9t8C432vyu1MGmJm46S7zPiLSW7I
    5U32vrkdA8D1Z+1ZqYFO4lw0/VlX9zZKrqkD9CD/hIXlFF7GizvDpMQkJKTVK7QD
    MG1+6kc3TL5BeTgot4vT61p/Mf86R6gZ0OXH+s6ddJUsrEHTmON4MIdhNo0vxNbw
    nzFoB2eYkgQSylxKWp+L7XyY6y3TlKBEwd+d6LNiJ9UnotDw0z1LkYrRG4bOAev7
    QUk9yOoKdISJuIy6S2Agbu4yuTnb9npbTlwhbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517505801; bh=PZIXN6t6zWZxE9DIPhLTYL8lxgeMKeqCGq55aha6gmI=; b=G
    nJauKqfM1uv9oU/KZ2Ln5Z6ekoA1unreDL5GDIF2umnDz21DPmsmeAqgnq24HkwH
    dT/KZ2urY5+FVJgDhLsYocuBFsq+Bz0q4isE9kSKDGtU4JNAWCT5hCMIdYlQmcdE
    GIvB+w/pK25sOA59+eFR+0ozVqKlV4Z/ZzEyyr+oLcci3wsrDY0ec0+u5nf0JfAR
    QiVJiCZV8mxugxt3tg7cTeNe8KyxO8as+yhp6O519yjC7IwY0d8OEnSE5Y83/LIF
    mhJm95o01kEom4UNQUprE398IUYc24hO70fy0QpwwybkE77aEPXskmxULtxHRUk7
    4XtPSD/CtXT15tNPZIEgw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=rCL5WPh3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fIKHtPL6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=rCL5WPh3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fIKHtPL6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeBARXP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 12:23:15 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40894 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBARXM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 12:23:12 -0500
X-Google-Smtp-Source: AH8x226NcktvIpr7lMvLo9xG3UZNVgM+6V5yJzD2VhMutpG3YQLLPF4C/aACxPJxHgE9NDiBi6UY6Q==
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        stable <stable@vger.kernel.org>, James Morris <jmorris@namei.org>
References: <20180201153708.63506-1-salyzyn@android.com>
 <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
 <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
 <1517504530.1750.55.camel@tycho.nsa.gov>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <1445a6b4-1c4e-b684-62f6-1a6ff4af3fed@android.com>
Date: Thu, 1 Feb 2018 09:23:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517504530.1750.55.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/01/2018 09:02 AM, Stephen Smalley wrote:
> On Thu, 2018-02-01 at 08:20 -0800, Mark Salyzyn wrote:
>> On 02/01/2018 08:00 AM, Paul Moore wrote:
>>> On Thu, Feb 1, 2018 at 10:37 AM, Mark Salyzyn <salyzyn@android.com>
>>> wrote:
>>>> In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE
>>>> socket
>>>> flag") and all the associated infrastructure changes to take
>>>> advantage
>>>> of a RCU grace period before freeing, there is a heightened
>>>> possibility that a security check is performed while an ill-timed
>>>> setsockopt call races in from user space.  It then is prudent to
>>>> null
>>>> check sk_security, and if the case, reject the permissions.
>>>>
>>>> . . .
>>>> ---[ end trace 7b5aaf788fef6174 ]---
>>>>
>>>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>>> Signed-off-by: Paul Moore <paul@linuxfoundation.org>
>>> No, in the previous thread I gave my ack, not my sign-off; please
>>> be
>>> more careful in the future.  It may seem silly, especially in this
>>> particular case, but it is an important distinction when things
>>> like
>>> the DCO are concerned.
>>>
>>> Anyway, here is my ack again.
>>>
>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>
>> Ok, both Greg KH and yours should be considered Acked-By. Been
>> overstepping this boundary for _years_. AFAIK Signed-off-by is still
>> pending from Stephen Smalley <sds@tycho.nsa.gov> before this can roll
>> in.
>>
>> Lesson lurned
> No, Paul's Acked-by is sufficient, and at most, I would only add
> another Acked-by or Reviewed-by, not a Signed-off-by.  Signed-off-by is
> only needed when one had something to do with the writing of the patch
> or was in the path by which it was merged.
>
> I don't object to this patch but I have a hard time adding another ack
> because I don't truly understand the root cause or how this fixes it.
> Let's say sk_prot_free() calls security_sk_free() calls
> selinux_sk_free_security() which sets sk->sk_security to NULL, and then
> we proceed to free the sksec and then sk_prot_free() frees the sk
> itself.  Now another sock is allocated (or perhaps a different object
> altogether), reuses that memory, and whatever sk->sk_security happens
> to contain is set to non-NULL.  We'll just blithely proceed past your
> check and who knows what will happen from that point onward.
>
The way I read this is this is part of an RCU operation. Multiple 
readers are holding on to the object, but as soon as a new writer comes 
in it _immediately_ frees the sk_security of the 'old' reader copies in 
order to make the 'new' writer copy. Any pending readers continue 
operations until they get tripped on the too aggressively released NULL 
sk_security reference.

Commits came in between 4.4 and 4.9 (edumazet@google.com) to restructure 
and fix this and add the appropriate RCU grace period to the 'old' 
reader copies for the sk_security resource so that it would be freed 
after all the readers had exited. Problem goes away.

My proposal will break any 'old' readers by blocking their access during 
the transition rather than panic the kernel. New readers coming in after 
the writer will progress fine.

This is not a 'bug' in the security layer, this is a bandaid to the 
security layer regarding the bad behavior of the callers.

I have not analyzed the code enough to 100% prove my assertion above, in 
part because I can not duplicate the problem w/o kasan+fuzzing, so still 
treat this as a hunch.

-- Mark
