Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A15C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF5720020
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5IyJErA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF5720020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbeFUBGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:06:10 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38582 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754554AbeFUBGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:06:06 -0400
Received: by mail-vk0-f66.google.com with SMTP id b77-v6so877771vkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aT/6/8CNx/VsgAKH7AsRyP37G4rTMft3k0OoADdl2jE=;
        b=s5IyJErAkLB21P10jEeZDHow/9W9Ih5BnMUrKc61Ax5DRikf+8cyFVhV0UHQlzCQ2K
         P6lsLbk3CEjTgAqsdCJoddq0bxeRg4vch8Zg/PRa0mEX1q0GQqLCqWROcQYpoD8d9sxr
         jQ6jBBxh1opDTKLBWsQlVUVppMXpRNb+9Sm0KY7JUe3HRIOIWbKPjviwBKxZ/hEc1u3Y
         8TRhMbSPnwKfmekRNnA9i3Q7Wx5G2kMWMuLojbrq4MfNH8l2ENwbrCeU1uTZffi108EO
         siloVw0/Wo8+ySgLfbVwQTgOpKRDU6pZ0at3KAn/Zcr8+ysm1fwU5DIya/a6gvwGjdZS
         SEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aT/6/8CNx/VsgAKH7AsRyP37G4rTMft3k0OoADdl2jE=;
        b=nYpEGFiLJkPjc4V0vNT/jOMsITkOpynP5VSkFc4N7xgF/xCeZDDXnbjrIiJ4CL/1Qj
         Fag1ZPzz3sagHtQUQ7Z/fkf7HT3dcxFNCtMAUgaJzfZqRLt/Cz1UrrRQaYrnZP8UmNaV
         ykGnkHFi/1xLZVZbp975HE66C10HTn9hIUAvzhmaotqOo3USsOeIOfbyGl/6YCP+Hjs7
         791YIc7qInLe9KdZ5VTgl4VGJV4kXDlnVac0cVBB0RTJskXvleJx26p2xzNjNf0GZRec
         wO0i8KLR8S7ahY8l4kPWC+xaNotTHu33PCoDG2WY+wFfoW9e+zxIhuE1DzxtIc/lJz9M
         q5uQ==
X-Gm-Message-State: APt69E3QhQwa3db4f2B3mpWtZrh3EJLrxBdi0FONSLCpu6CufzXla5Je
        Y8+jvDJbd+HfrIleN7PuLVbh4OiN9PCzeb8fizQ=
X-Google-Smtp-Source: ADUXVKIEfaTk+jZS7fqKG5OZe1xlY3FmYhdGo2snSNC1JMiUOzGElhku39Yni5ahrk2091X7OgdlARiqhGSvmNmRONc=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr13776719vkd.15.1529543165766;
 Wed, 20 Jun 2018 18:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 18:06:05
 -0700 (PDT)
In-Reply-To: <20180620125540.228766-1-dvyukov@gmail.com>
References: <20180620125540.228766-1-dvyukov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jun 2018 04:06:05 +0300
Message-ID: <CAHp75VdR_gDBk7v9WDN1fHc=1q=j2mx3CkTz83SZZWm=pbnczA@mail.gmail.com>
Subject: Re: [PATCH] arch/x86: get rid of KERN_CONT in show_fault_oops()
To:     Dmitry Vyukov <dvyukov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 3:55 PM, Dmitry Vyukov <dvyukov@gmail.com> wrote:
> From: Dmitry Vyukov <dvyukov@google.com>
>
> KERN_CONT leads to split lines in kernel output
> and complicates useful changes to printk like
> printing context before each line.
>
> Only acceptable use of continuations is basically
> boot-time testing.
>
> Get rid of it.

> +       printk(KERN_ALERT "BUG: unable to handle kernel %s at %px\n",
> +               (address < PAGE_SIZE ? "NULL pointer dereference" :
> +               "paging request"), (void *) address);

Perhaps pr_alert() ?

Btw, parens are redundant for the first argument.

P.S. And personally I would rather do
if (address < PAGE_SIZE)
 pr_alert(...NULL pointer dereference...);
else
 pr_alert(...paging request...);

-- 
With Best Regards,
Andy Shevchenko
