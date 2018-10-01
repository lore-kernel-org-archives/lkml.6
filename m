Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992C2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2B8208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QX9fKgxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2B8208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeJAUyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:54:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43232 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbeJAUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:54:07 -0400
Received: by mail-yw1-f67.google.com with SMTP id j75-v6so584480ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFsVf1hjk21KEGWzBCcZQj1ytvQfsWQJodLue9dAGo0=;
        b=QX9fKgxHDr/yj7d5Ct8E8Cjk4AgMTSTgUG2qrrNRqskiVNgFbg+/OuW+dtaLLlp6x7
         shBxGNnEY2N4ssgSTWKxUIOAt7IsVLy9YAhrnnYit1GgQfao6jMS5C6WJ4hAqY5nWZQO
         ZCqFsdZ7j2rw3MbXE3kIbKr6PXnMG+edjapfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFsVf1hjk21KEGWzBCcZQj1ytvQfsWQJodLue9dAGo0=;
        b=tQ3Y0x16M7r31BAlS51zlCGO1DUhS3OB2RLGRBsyLRipUruIdG0MdDMWMdghdpdct2
         Y+dDhKWrPItIm6FIfakbKv2hk+nFXQAjepFVBZ7icWuYqGdHJ/P6K2HpMusTBCG81XOL
         6yDyUj52To0lmUFzPiDNdZlIr4u9mQDOqyFO5+fhsvG6iDHCLXLr2BHQImV3mEVx2pkJ
         IrCws3D3Z/wrt5xK1wqiznw/p+b/M74pl4FJK8kS6gbPIQd0XgX5Yl5fTPAwTCA7gpLa
         WgdUb5EFFRaO0m++j031qP1yXZv3wpAGt35eWl77+lkk3beEGPzL/+nUP6CX/45grHB8
         9wHg==
X-Gm-Message-State: ABuFfoia8+X9Bcf3yWHfpmZfzxuqLwuJPS8ADOO705DFR/iggs4/kHIr
        ROeehqTgrD/as1vOZYPaYUAE4SUyIwFWEFvm36PnYQ==
X-Google-Smtp-Source: ACcGV62HNCizRg43eQ7g4ZJuBbyeyd4x/6mKONYNRB8ffVnomf65k1vh9xDmkobEQFwYfhk0pTR8zNYoDknGO9wZ0OM=
X-Received: by 2002:a81:1b85:: with SMTP id b127-v6mr4073204ywb.381.1538403365660;
 Mon, 01 Oct 2018 07:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
 <1538057720-3392-7-git-send-email-firoz.khan@linaro.org> <CAK8P3a3YkR7Qr=XnqvQTOn=v34rCBfW1+dqU5xpV4ysar+C4yg@mail.gmail.com>
In-Reply-To: <CAK8P3a3YkR7Qr=XnqvQTOn=v34rCBfW1+dqU5xpV4ysar+C4yg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 1 Oct 2018 19:45:54 +0530
Message-ID: <CALxhOnjrjF1XuwGd_F5xFz97noTvebhzdCvN51v93zOTuQqDiA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ia64: uapi header and system call table file generation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, 28 Sep 2018 at 17:40, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 27, 2018 at 4:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> > +#include <asm/syscall_table.h>
> >         .org sys_call_table + 8*NR_syscalls     // guard against failures to increase NR_syscalls
> > +#undef __SYSCALL
>
> This part looks odd: according to the comment, this should only guard against
> the table getting out of sync. However, with the script, that will never happen.

Thanks for pointing it out this error.

- Firoz
>
>       Arnd
