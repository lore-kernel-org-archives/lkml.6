Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523465132-2-18228503897853995579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523465132; b=GbbA8ADLDZdcoeIb03LWuS3pkmgzM/lrHaju6y1u7wVSOZcUSy
    WoFHlAZkqPekVUzp30odQyTLzfWswUlqm/eMHDw/eDnifMEgbL2s5uGaN0LoVqhn
    BWRa12UT95Po36muYxWGLKYZ1H2/4/TPApBr5tL8qXLb2jPq9h0YCyRfqtidc33C
    xz5mHv1NteLCNcWH18ylSGlJwnbMAGDgPmrDUddo9AgDeDIRVXMxFd1zrg5SK/RP
    8YZBbXEvGb3i3Yl3Pvc7cU/6qMdg5qv5BkpMfMrzW+aWe10ltvowW9wCE22FLp39
    5qsj/uI1W2CiO18CK9q8/BL4qD7L/VUUK92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523465132; bh=9ny17eCqVpWY4ptITa0x46SrVZNqA3w30VJsze3K+z
    0=; b=pa7zlgB7dCu1b52B1GW0VztKuo+nHWpK/+VlmEjfog6BKwOlzuowWmVRHR
    XHYZ2MecGGR1IQ4OGL3+3ScPVcz4bk6glxAfXs9VvFYcHNNPW44XUbhwfQH3WKGa
    7Zf3hEhl9pXOI1YWcUEppQpP9WTlnmnf1SU4tOuLl79Ztf4kzmoQrjaQipFSKDok
    PqWESoJ2t59RdnKUhxIKfzH8HGui/PjNP7zKu/2qJ25/ecCLvJmCr+CvfStvlyTH
    zvvN9wvCz4DzFAUlnwkuJXUHY+ZHSASsCi1UrcL/jmUBoQlQ5/teS+vU4M/IqVx4
    A/NYlEjmMB2pNEb/Wuuk4eSG9W2g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=IE+E1XN3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b3NftUu0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=IE+E1XN3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b3NftUu0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdlNw91MjrOvNBMIEKEShukFRnPVj6IEz8ehopaMttDOZsxuruHOMW8azr6pYJq4ogLhWFIo22Tc+RaMEJt29VST1vpNcATrs2oFKbLX0scqNdWPH00
    qKpSC6UXUcPP8PIqfThIwhn18LXvYmw1UvsFWNjEZe1lUOidYA7pQtxUIJW4n5eFmRVDADP5QPGXda+ACBHYhvf/jDxITIGvgFs97+c6gHDzeo8UkBMjp6mG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=zK0Vt8FKDx1kDCpwVuQA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeDKQpR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:45:17 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45129 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752947AbeDKQpP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 12:45:15 -0400
X-Google-Smtp-Source: AIpwx4/j3krmlIeUGBv+bCIfJrXORaybwD8CQySnK5N3bBbqfCv4m5LjvB5Hbw7oppgt+SX/TKTbm5cE3Y6wHkpdUr4=
MIME-Version: 1.0
In-Reply-To: <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Apr 2018 18:44:54 +0200
Message-ID: <CAG48ez3U3pf4O8Yc1y-+T=Dcc-N-KP0Zd_1GS44p--zxockJ1Q@mail.gmail.com>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 6:24 PM, David Howells <dhowells@redhat.com> wrote:
> Provide a single call to allow kernel code to determine whether the system
> should be locked down, thereby disallowing various accesses that might
> allow the running kernel image to be changed, including:
>
>  - /dev/mem and similar
>  - Loading of unauthorised modules
>  - Fiddling with MSR registers
>  - Suspend to disk managed by the kernel
>  - Use of device DMA
>
> Two kernel configuration options are provided:
>
>  (*) CONFIG_LOCK_DOWN_KERNEL
>
>      This makes lockdown available and applies it to all the points that
>      need to be locked down if the mode is set.  Lockdown mode can be
>      enabled by providing:
>
>         lockdown=1
>
>      on the command line.
>
>  (*) CONFIG_LOCK_DOWN_MANDATORY
>
>      This forces lockdown on at compile time, overriding the command line
>      option.
>
> init_lockdown() is used as a hook from which lockdown can be managed in
> future.  It has to be called from arch setup code before things like ACPI
> are enabled.
>
> Note that, with the other changes in this series, if lockdown mode is
> enabled, the kernel will not be able to use certain drivers as the ability
> to manually configure hardware parameters would then be prohibited.  This
> primarily applies to ISA hardware devices.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
[...]
> diff --git a/security/lock_down.c b/security/lock_down.c
> new file mode 100644
> index 000000000000..f35ffdd096ad
> --- /dev/null
> +++ b/security/lock_down.c
[...]
> +/*
> + * Lock the kernel down from very early in the arch setup.  This must happen
> + * prior to things like ACPI being initialised.
> + */

Pedantic nit: I think this comment is wrong now? This function
actually just prints stuff.

> +void __init init_lockdown(void)
> +{
> +#ifdef CONFIG_LOCK_DOWN_MANDATORY
> +       pr_notice("Kernel is locked down from config; see man kernel_lockdown.7\n");
> +#endif
> +}
