Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4062394-1527693589-2-10160536368128454050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527693589; b=a2I3zeeoOsVDL8h3z0a35Fj5tw/rn69JKQ81syOj/f9O2V4t6/
    aZkKoa3b/GykxWcK80l4N3QTAFUnV+mIBRhcozuBwT/fY0vV0Qdkz9FH1YBEHXRj
    hDIkdQGNBbYnoKMGCT1nCIDE8T6h9XjQBATSLfyh2QZCiy36pdQg8El6hKbihoUW
    Q6NeFqjurHR96JW1sPn4E1OuD73eYBfMXRT73NvACsEjb7ivlVitbeGuHh4MFICR
    8q7da1qtEyLk4CGsdbUfmtdYmqUdcy8ePYpbSkQAMx0rmDqLsz9C2o2/0zzyfnac
    wwn0kvcK1Q4tcFAKwIYfwF4PVPrYNUbbeUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527693589; bh=I4OdjhzIkx64L/OLjG+2v3bWPY1HHrUPsyKOl5hcVd
    A=; b=IEAVa7Inbaa2SVAxaSPyV9xix9/nXC65vXLm5kepb2IYJLLfuYjXTXWw1p
    z6lYFSIhh+eZutPEOLKcSRSlOR6Ng2cjArdATVT72eRXa4MpUgadmvabolpfFkge
    uRZ1dODUSa/KTgwHLUI6nPlY1+FkWIjNTjAk50JjvoXBviNcj/3BqeQgkotASxCV
    e+7noQSc7sHQsvsdtEJk0N1BWJNR0s1liH+ULSdwcTgfqxwfYeswfzuBnb8egRQ1
    kkjk/D1ZtL8lKAC2k62N5q0fiK1tGi5mASiWCGPSLhX+pLJ8LDYa68BwyIEpitsJ
    JLGJJ3K1PNIsyxZ2XoBn5Z+osJAw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=BqG0tWmz
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=mRCgQgfv;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=BqG0tWmz
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=mRCgQgfv;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKUTiI536KSg06fdiCB210TLolt3xv6Abc4H0gj8c3EAziIyMXPTBBjj5mKJisoL9YfEaZra/eS+uFACb7FS+6r7cVxv/sIPsy+M3I0D/8qpnyPP16J7
    TlhnNKK/J28PiQm4AHj+AqTKsfjAeXr5gPGhG7zi2/uIpvhwLjhtYwe8zGnqJs31nvfGZypC2OLcn/M9NFyDXAGas3vv+wOLVgUwHvnenJjs2gSx1Mk/59Py
    0hXME8qezBtzBZZhf83lQQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=noW-5PIvj9YXwDgHcLkA:9 a=6FeEzxY2Jop0i_de:21 a=hYNqvnsjFZqEr4oa:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeE3PTq (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 11:19:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45465 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeE3PTp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 11:19:45 -0400
X-Google-Smtp-Source: ADUXVKK1razWahrqIm29PKPirRrz//3TEKL6naUUE6ibYfCGJJ0TnwVzxUd3N/jQ5qKaVslAbiboOMCZks4gPaeEaYQ=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1527237099-9728-1-git-send-email-sgrover@codeaurora.org>
References: <1527237099-9728-1-git-send-email-sgrover@codeaurora.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 May 2018 11:19:42 -0400
Message-ID: <CAHC9VhQui+U1wzms2=XSW7MeRZg-faAzZyG8XU8wc+bWAoVzJg@mail.gmail.com>
Subject: Re: [PATCH] selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
To: Sachin Grover <sgrover@codeaurora.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 25, 2018 at 4:31 AM, Sachin Grover <sgrover@codeaurora.org> wrote:
> Call trace:
>  [<ffffff9203a8d7a8>] dump_backtrace+0x0/0x428
>  [<ffffff9203a8dbf8>] show_stack+0x28/0x38
>  [<ffffff920409bfb8>] dump_stack+0xd4/0x124
>  [<ffffff9203d187e8>] print_address_description+0x68/0x258
>  [<ffffff9203d18c00>] kasan_report.part.2+0x228/0x2f0
>  [<ffffff9203d1927c>] kasan_report+0x5c/0x70
>  [<ffffff9203d1776c>] check_memory_region+0x12c/0x1c0
>  [<ffffff9203d17cdc>] memcpy+0x34/0x68
>  [<ffffff9203d75348>] xattr_getsecurity+0xe0/0x160
>  [<ffffff9203d75490>] vfs_getxattr+0xc8/0x120
>  [<ffffff9203d75d68>] getxattr+0x100/0x2c8
>  [<ffffff9203d76fb4>] SyS_fgetxattr+0x64/0xa0
>  [<ffffff9203a83f70>] el0_svc_naked+0x24/0x28
>
> If user get root access and calls security.selinux setxattr() with an
> embedded NUL on a file and then if some process performs a getxattr()
> on that file with a length greater than the actual length of the string,
> it would result in a panic.
>
> To fix this, add the actual length of the string to the security context
> instead of the length passed by the userspace process.
>
> Signed-off-by: Sachin Grover <sgrover@codeaurora.org>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for reporting this and providing a patch.  It's small enough,
and passes all the regular tests, so I've merged it into
selinux/stable-4.17 (adding the stable metadata) and I'm going to send
it up to Linus today.

If Linus doesn't pull the fix in time for v4.17 I'll send it up during
the upcoming merge window.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 66ea81c..d17f5b4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1434,7 +1434,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
>                                       scontext_len, &context, def_sid);
>         if (rc == -EINVAL && force) {
>                 context.str = str;
> -               context.len = scontext_len;
> +               context.len = strlen(str) + 1;
>                 str = NULL;
>         } else if (rc)
>                 goto out_unlock;
> --
> 1.9.1

-- 
paul moore
www.paul-moore.com
