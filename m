Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4082281-1517503821-2-3938267775015050357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517503819; b=RF7icIcUojVp8zODukVeJAo92PsoZnab57i5yhicxQ+tB8c
    ZtSQoZEyb1Bn4GppVwkMtEaUnYGp1DzapFOi/UA3JCZcvP0IWfN6k3Hb/8c8ts3J
    CS5m2vJd7/mbdG9sBNqvAfKZwAcSIMa1ctTUWIE1aVtvC/cCY86uc9sDADF99Ole
    U69VYv2Yx+c4XJo4OhdUbiCJS6bLWFoY2rszRP0oO4u2UWBnHsezmLDL5R1By0Lr
    KcJ89whiiHhCVH5OPRLUDROLVLgqtU3IoCS6apxHMcghLytqE4mVJnnPF1yBE9gB
    411jN5zS0aF/WTpA3raxt4kwVDVpa6l61iVQB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517503819; bh=+UcvX1O+rMax7A+atNG6ZYbypjJPUypezJ9aWS
    ajeKI=; b=fhVaRe7XXWElwHmLH3/tiit9S3spu4stzeI7Hkp5Tcx9Gx9Xw4/JRe
    qCAGfGq8mtg09JYd6+cO84M7Z+H9/6PSKy94EkoW8Adzn6knv5ItVcvI9uPeszuQ
    9t2HbZu8/lnebVwa55WvR8vlJ7PhIbQwYtrpI66NsFWQ7JDjEfqXo3+cDawMWECT
    NanJYQr5eOWTo+WyxIeZcrZeR4POJ1U7nFSzlgPWT/viPuN8FRWIGaqwcoXRYlYy
    kLs2xnLoacHeontjBNBkii84nZHLJJCOwQaTprhC67bwvp7ymzOZqJTFz4aM663o
    7Y3TfPEdV7UIwj9wZM4jhxBbUWhiGMog==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=OeXM5mKD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jrmU4oaa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=OeXM5mKD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jrmU4oaa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeBAQuP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 11:50:15 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33356 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeBAQuM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 11:50:12 -0500
X-Google-Smtp-Source: AH8x227qfrLGXW9RAdkUKT8sbtQTZP4NhboQJwjscboC41LWd/+37/f/n4XvubZUXJeiQlpH3MD0L/ctG7RY9za0ERI=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
References: <20180201153708.63506-1-salyzyn@android.com> <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
 <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Feb 2018 11:50:10 -0500
Message-ID: <CAHC9VhT_gjjpq_ksX=DG2FvSav0uFMXtX-jJTcV7WhBgNC4ECQ@mail.gmail.com>
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
To: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        stable <stable@vger.kernel.org>, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 1, 2018 at 11:20 AM, Mark Salyzyn <salyzyn@android.com> wrote:
> On 02/01/2018 08:00 AM, Paul Moore wrote:
>>
>> On Thu, Feb 1, 2018 at 10:37 AM, Mark Salyzyn <salyzyn@android.com> wrote:
>>>
>>> In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE socket
>>> flag") and all the associated infrastructure changes to take advantage
>>> of a RCU grace period before freeing, there is a heightened
>>> possibility that a security check is performed while an ill-timed
>>> setsockopt call races in from user space.  It then is prudent to null
>>> check sk_security, and if the case, reject the permissions.
>>>
>>> . . .
>>> ---[ end trace 7b5aaf788fef6174 ]---
>>>
>>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>> Signed-off-by: Paul Moore <paul@linuxfoundation.org>
>>
>> No, in the previous thread I gave my ack, not my sign-off; please be
>> more careful in the future.  It may seem silly, especially in this
>> particular case, but it is an important distinction when things like
>> the DCO are concerned.
>>
>> Anyway, here is my ack again.
>>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>>
> Ok, both Greg KH and yours should be considered Acked-By. Been overstepping
> this boundary for _years_.

One more note, which I didn't realize until I hit reply and the email
bounced: you used a @linuxfoundation.org email address for me which is
clearly not right.  I'm sure it's just a typo, but it's another thing
that needs to be corrected.

> AFAIK Signed-off-by is still pending from Stephen
> Smalley <sds@tycho.nsa.gov> before this can roll in.

Obviously the more acks the better, but you've got mine which should
be sufficient in this case.  The MAINTAINER file currently lists three
people for SELinux: Stephen, Eric, and myself.  I'm responsible for
the traditional maintainer tasks: tree management, PRs to Linus, patch
review, emptying the waste bin at the end of the week, etc.  Stephen
maintains the deep historical knowledge and understanding that comes
with developing the technology/project from it's inception many, many
years ago; no matter how well I may understand SELinux, Stephen will
always have me beat.  Eric is basically my predecessor, having
ventured off to the brave new world of containers and Kubernetes; he
is listed out of respect for his contributions and also to safeguard
us against the all important "bus factor", while he is not as active
as he once was, he still holds a wealth of SELinux knowledge.

-- 
paul moore
www.paul-moore.com
