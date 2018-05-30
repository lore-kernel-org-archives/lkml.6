Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4069958-1527694298-2-10697911500960343492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527694298; b=RaVjWT3wNuD6UwHSB2TVsierJwxpbhqAZGMruIjqSJlWDnIaoE
    t+hLKtkjpbZTrFgcY2mUiu+Y+w81YsY3Sp5QwB9SXbb5OkNpyPK3+pdB9oiBg4Hy
    5Qn6Vg8BawvGZJH/mzGpfWbSE/Ypz5TyC7OXY1VYFBfT6n5Fs7QtvCQYToUt3IbA
    ff8Re5xgUZ59fYCcfR44VZnqS1Tpsce/tj0Q6pP5rr3F7DhNruZx1E0aZLhsu5Ik
    N81o8ntZ4ejvY8F0U7+3iNlNXCl97TVwQYrc0C+eDxkqJdaUV4aNXv4GWjUFIWtp
    4A06VKJrleu82+hD/q4QJGH/xNEu3qk+dQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527694298;
    bh=V3wTQRv2DhWogKceKlOyWyglax8ojQIU8SadD5JPiHs=; b=StH4cbvXUQdb
    w1VjJjJ8ApAnR2l+pBgmqAB0vr1gUy7p4Ac9O9WkYtCWA5+KFDaioGfKCnKoeq87
    9su6o2AClgjTawy+YFWA9vtyCa61JuLRxxru+xFznzUm+nys9ubIKjTDwXinD11O
    bnavGfv+KCNCkGYsy9bzVh9TaD5axMWU+4T3qaNxzrAGkaO5zUdH9Ppk3NdNSnkk
    aC5X74PnurFdqtO1y4NqDS7+4CH1PFGoThNlLJSVJP9q6MboDQh78iDe3UrBec7O
    MtOc6V5J+fIl9rQEIxj96TS4J6Cyjefm2sJknA2xqXrEErSgMvz3AJigsP1hMYWb
    DchyccsGmw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=rWc/YWDX
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ueACFo+J;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=rWc/YWDX
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ueACFo+J;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBPZqkQmM7pme6wYctvu5A/JMLFDvj0QYJxw56aLSwnglyqNHkT07a5q9d048snsp0X3i0giocnoHRLCCxqAnKRnNFVwqkUL5HN7nqwKy4sM7tnoscTS
    ITjXD8QhVNWRv06lkRf7i8XuHbzT0bNRXIUXevB770O/IR69k3BVtDQu+spZK4wj33DJ8RJmzZiATOBitIOVqtS6cYe6gBNJQsnjCcEBZL3ghU2kka3pS5G4
    qMskJmZ8mnLyKKWu8Df1LA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=-D8JF9SoA4BN9egLdTEA:9 a=OrP5R8UTLDdWUCeq:21 a=63tcP6qVVJnMNHCE:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeE3Pbe (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 11:31:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33751 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeE3Pbd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 11:31:33 -0400
X-Google-Smtp-Source: ADUXVKJ92a5k/Bd4guoVIoJpTeCGMcqN0oN8FjmBqLJP5jhZe1yZd4Ci0+aPrRP/WL2qc8FNypIlUL1SzgqRDilTeUo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <0aac0a96-8565-1d9e-c53a-38bd5c861fd4@tycho.nsa.gov>
References: <1527237099-9728-1-git-send-email-sgrover@codeaurora.org>
 <CAHC9VhQui+U1wzms2=XSW7MeRZg-faAzZyG8XU8wc+bWAoVzJg@mail.gmail.com> <0aac0a96-8565-1d9e-c53a-38bd5c861fd4@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 May 2018 11:31:31 -0400
Message-ID: <CAHC9VhQ0RGyiv8TbRw_hfyp9u1Hz6R1thGQKaTCzCzWxz1Ghpg@mail.gmail.com>
Subject: Re: [PATCH] selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Sachin Grover <sgrover@codeaurora.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 30, 2018 at 11:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote=
:
> On 05/30/2018 11:19 AM, Paul Moore wrote:
>> On Fri, May 25, 2018 at 4:31 AM, Sachin Grover <sgrover@codeaurora.org> =
wrote:
>>> Call trace:
>>>  [<ffffff9203a8d7a8>] dump_backtrace+0x0/0x428
>>>  [<ffffff9203a8dbf8>] show_stack+0x28/0x38
>>>  [<ffffff920409bfb8>] dump_stack+0xd4/0x124
>>>  [<ffffff9203d187e8>] print_address_description+0x68/0x258
>>>  [<ffffff9203d18c00>] kasan_report.part.2+0x228/0x2f0
>>>  [<ffffff9203d1927c>] kasan_report+0x5c/0x70
>>>  [<ffffff9203d1776c>] check_memory_region+0x12c/0x1c0
>>>  [<ffffff9203d17cdc>] memcpy+0x34/0x68
>>>  [<ffffff9203d75348>] xattr_getsecurity+0xe0/0x160
>>>  [<ffffff9203d75490>] vfs_getxattr+0xc8/0x120
>>>  [<ffffff9203d75d68>] getxattr+0x100/0x2c8
>>>  [<ffffff9203d76fb4>] SyS_fgetxattr+0x64/0xa0
>>>  [<ffffff9203a83f70>] el0_svc_naked+0x24/0x28
>>>
>>> If user get root access and calls security.selinux setxattr() with an
>>> embedded NUL on a file and then if some process performs a getxattr()
>>> on that file with a length greater than the actual length of the string=
,
>>> it would result in a panic.
>>>
>>> To fix this, add the actual length of the string to the security contex=
t
>>> instead of the length passed by the userspace process.
>>>
>>> Signed-off-by: Sachin Grover <sgrover@codeaurora.org>
>>> ---
>>>  security/selinux/ss/services.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Thanks for reporting this and providing a patch.  It's small enough,
>> and passes all the regular tests, so I've merged it into
>> selinux/stable-4.17 (adding the stable metadata) and I'm going to send
>> it up to Linus today.
>>
>> If Linus doesn't pull the fix in time for v4.17 I'll send it up during
>> the upcoming merge window.
>
> NB Such a setxattr() call can only be performed by a process with CAP_MAC=
_ADMIN that is also allowed mac_admin permission in SELinux policy. Consequ=
ently, this is never possible on Android (no process is allowed mac_admin p=
ermission, always enforcing) and is only possible in Fedora/RHEL for a few =
domains (if enforcing).

Yes the risk is small, and if it wasn't such a trivial and
self-contained patch I probably would have just deferred it for the
merge window, but considering everything I think there is value in
getting this in for v4.17.  If Linus decides not to merge this into
v4.17 I think that is okay too.

> Fixes: 9a59daa03df72526d234b91dd3e32ded5aebd3ef ("SELinux: fix sleeping a=
llocation in security_context_to_sid")
>
>>
>>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
>>> index 66ea81c..d17f5b4 100644
>>> --- a/security/selinux/ss/services.c
>>> +++ b/security/selinux/ss/services.c
>>> @@ -1434,7 +1434,7 @@ static int security_context_to_sid_core(const cha=
r *scontext, u32 scontext_len,
>>>                                       scontext_len, &context, def_sid);
>>>         if (rc =3D=3D -EINVAL && force) {
>>>                 context.str =3D str;
>>> -               context.len =3D scontext_len;
>>> +               context.len =3D strlen(str) + 1;
>>>                 str =3D NULL;
>>>         } else if (rc)
>>>                 goto out_unlock;
>>> --
>>> 1.9.1

--=20
paul moore
www.paul-moore.com
