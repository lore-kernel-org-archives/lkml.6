Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1751440-1524711791-2-4527003421422431305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524711790; b=Tx5jWBxxQjei3lvHC73sWyFg7/kISmW0pbGWbRiKEbkzX6TnUq
    4he95fyfsjeU3n4PCDr3h7LcAt9VxjAPIl0dyAzVPQiCrljAtccqmsrl34tRLwZK
    u1O5RekEG9ciM/tgLN5YJRmdAXk1a/MCWAZF2dV8UQ0FMM6jVGTijOUPFW/FdDgT
    tinrw/7GLOPREF/+E98CbVOZs1MJ8XaZi3wlivOwQn9Z7q8DLKV/b+TpCUNxve8Z
    IWeMy45ATnWLOzVNB/x/4am/PZCN/dYFEzyKTyXTY7BKGE3mWeIyxhEG0Mbsj0kb
    X0mC7EkOeu1owVKdHtAP4VyPmY2gNiWcU8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524711790; bh=XeX1djmNStB6tKTsPsqWo2Mu1MlFQUEhY8IzsJ9F3M
    k=; b=HV/1hfA2rzf0Xqxt00xxpNDunRcc0nwu3Gg8IYvZDAB4D5tR+MO9UeyJqP
    OCg9Gyp0PmxotO5bbkZXK0VN+nx0WEDXc8sFDlwwJDSEWNmxwQh9ATc4C3jPCRji
    Tc32j/wusnahT2I38dbdoTM3pqxfF8OBQrtuiGQMp0GrnKQ/KFHngJMZM/vdSBbh
    mAhKAqOdopMsDtGUcgnWovHbA6T+rpzSpaeXtxWvOuQMZMUMOrrY/Auk1bDu5TiI
    0LFAAjBGAzBrz8b30QkVfEDSk6zK6jyN5TgJ9sUd+hVpA35aeQBBuGwJbzjFZT5M
    WT2QDsuJEOMEhgSu0FP/eWRJLWkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gKrAvNJI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Vz/GlhVq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gKrAvNJI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Vz/GlhVq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIVIRfZ21KaiZKtMc08Z4CUUOHOHrDP+aQPQJJnqIvStZjqJ+SEbFbO0thOZF9fK+Z2fAr00bCrAgT6PHjpPD/bxf7uqVLbbfrI3hGZ5pyBWgXsi7ntL
    9c/3AFDMnHLjY9LVzi05rwCix0ooN88xTh0pl3zTgT+Q8WornHiHaDuFgPoL9t5rTTL0zIbcm1MrgEhgoHr3W1kMNXk4+aKe847xjY5xKUkyC1pXMPhGKG2d
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=0kg-JoMdhM4A:10 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=EslCdyIu4b4Hk3CLRQcA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeDZDC5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 23:02:57 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46404 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeDZDC4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 23:02:56 -0400
X-Google-Smtp-Source: AB8JxZqNHnJp9q/P9OTU0ioQG2gHuk0bdtf6DU6NVDfcCcJuQfv1kz+SobvO3eUKjsINHtEsgxvsUQjXI/dcbEmlCco=
MIME-Version: 1.0
In-Reply-To: <87in8fuuva.fsf_-_@xmission.com>
References: <878t9ilmhv.fsf@xmission.com> <20180420010408.24438-5-ebiederm@xmission.com>
 <CAJsyPhyDeafwUQxXgnZ9Rfj6nwYrU_Kgyfv8DQ2q0BkwW25BBw@mail.gmail.com> <87in8fuuva.fsf_-_@xmission.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Thu, 26 Apr 2018 11:02:54 +0800
Message-ID: <CAJsyPhzSgPebAtP7m8Dsidy+2Lj6mKb7J-dPqHmFVzWv6Q55YQ@mail.gmail.com>
Subject: Re: [PATCH] signal/nds32: More information in do_revinsn
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-26 0:13 GMT+08:00 Eric W. Biederman <ebiederm@xmission.com>:
>
> While reviewing f6ed1ecad56f ("signal/nds32: Use force_sig(SIGILL) in do_revisn")
> Vincent Chen asked if it was possible to provide more information in do_revinsn
> with force_sig_fault.
>
> That seems reasonable and the appropirate si_code appears to be
> ILL_ILLOPC (illegal opcode) as the printk indicates this code path
> is triggered when a reserved instruction is exectured.
>

I think error code is set as ILL_ILLOPC is a good choice for normal
reserved instruction
but it seems a little bit inappropriate for nds32. For nds32 reserved
exception, It is possibly
triggered by illegal opcode, operand and immediate. Unfortunately,
do_revisn() can not
identify the actual reason now. Therefore, I chose ILLTRAP to avoid
confusing user when
the reserved exception is cauesd by wrong immediate or operand.



> So update do_revinsn to use force_sig_fault(SIGILL, ILL_ILLOPC, ...).
> Giving userspace a much better experience when soemone attempts
> to execute a reserved instruction.
>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Suggested-by: Vincent Chen <deanbo422@gmail.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>
> Vincent I have updated this from your suggestion to use
> ILL_ILLOPC as that appears the more appropriate si_code.
> Normally I expect you could just update your nds32 tree and
> make this kind of change but since I am touching this code anyway I will
> be happy to take this change along with the others.
>
> Does this look good to you?
>

It is fine to commit this change along with the others.

Vincent Chen


>  arch/nds32/kernel/traps.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
> index a6205fd4db52..5c2f61835ab9 100644
> --- a/arch/nds32/kernel/traps.c
> +++ b/arch/nds32/kernel/traps.c
> @@ -349,7 +349,8 @@ void do_revinsn(struct pt_regs *regs)
>         show_regs(regs);
>         if (!user_mode(regs))
>                 do_exit(SIGILL);
> -       force_sig(SIGILL, current);
> +       force_sig_fault(SIGILL, ILL_ILLOPC,
> +                       (void __user *)instruction_pointer(regs), current);
>  }
>
>  #ifdef CONFIG_ALIGNMENT_TRAP
> --
> 2.14.1
>
