Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEC220821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Gw+k2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEC220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeLJXSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:18:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56024 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJXSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:18:44 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so670313itg.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 15:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZeKzG0rq+OwDUq77h0PCqKPkscSqV9vbz/akwP1/Zc=;
        b=S7Gw+k2PxLiTsmg+UiS8lBcud7uHqtNnXAuU6LqCQD+VZeKd0UEP7MhS2x6hZ6hKO6
         lcjtWKVnvSaoucp4CE58PCoYf249CSySYyiE3WSGa6P6FBYmcVL5kp1LbApMT2YbvWz6
         QIxYEHcNXGeomAsN8I4Od1mjqvP9vvoPVygUgdN7L7ZO95DSftNYl5JIET1G38My0IgH
         8sIL+o5+lHxe6vypEnqU+QlE8rgXXI0DENjn9IKVocojZcdH86ySiCB4gLbpZy/9LDY6
         izqjFqwYtU05KIIlmqnBzcrLm/m9LVy6c2U7uiZbJYHkBRKoug599f4UQ2W3jrmif/RU
         HoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZeKzG0rq+OwDUq77h0PCqKPkscSqV9vbz/akwP1/Zc=;
        b=iorP20EgTXKCl2EyDASQdXnAXbzbI1SVlUALvCQnnQfwx1qEBpO8ZutwGCkrhuSenQ
         9I6mM4p0t5UAjNNZfec/n6/rZydF/CZSxKzBLA5LBk9k/jiLCmLws+L44yYSFa0XInuD
         zHx1bedlv3oniJqhUAwxN5EdmQydXRGP990P941sK/lcCAR8Y4d2ySp+lt3FS4k9FVB0
         12PiIvZTqi9YfJb/IhqisFSQdV3uHb5H0xdjmiK+2ap9tE2O72TQHmgHYiNc1MsaZxyl
         /Cllom+eMeXlgm6JgCacvcrMek42abXoEJ8VIXKmeUFzRnmpvz86/CZZsVZ56uDkLF0e
         uXDA==
X-Gm-Message-State: AA+aEWYbDhCgZKNsj4N/rG9omUlTp+yOYFyRXFfEA7Dq13HwQ/2n53uE
        Qx+Dn9cPir/KXhDzgd7Xmp6AZQGKpFqE3fR6Ac8=
X-Google-Smtp-Source: AFSGD/W66olXv/neSxyusWeZajxoJMfLo70gWqQfj5dwWMxjLtgW42Gg0t6UXV95Yh8J3jnJXO4J+K2qlibn/3UVg6I=
X-Received: by 2002:a02:5618:: with SMTP id o24mr14015831jab.111.1544483922856;
 Mon, 10 Dec 2018 15:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20181210215203.1936171-1-arnd@arndb.de>
In-Reply-To: <20181210215203.1936171-1-arnd@arndb.de>
From:   Oliver <oohall@gmail.com>
Date:   Tue, 11 Dec 2018 10:18:31 +1100
Message-ID: <CAOSf1CHqxaGdz_F0EifqHmD+0ZgKVno7aRZEXUG1880C5YvHGQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: eeh_event: convert semaphore to completion
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 8:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> For this use case, completions and semaphores are equivalent,
> but semaphores are an awkward interface that should generally
> be avoided, so use the completion instead.

IIRC Sam has been reworking the locking used inside of EEH so this is
probably going to clash with his changes. Converting to a completion
is probably a good idea, but we might want to do it as a part of his
series since it's going to collide with this anyway.

Sam, what do you think?

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/kernel/eeh_event.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
> index 61c9356bf9c9..227e57f980df 100644
> --- a/arch/powerpc/kernel/eeh_event.c
> +++ b/arch/powerpc/kernel/eeh_event.c
> @@ -35,7 +35,7 @@
>   */
>
>  static DEFINE_SPINLOCK(eeh_eventlist_lock);
> -static struct semaphore eeh_eventlist_sem;
> +static DECLARE_COMPLETION(eeh_eventlist_event);
>  static LIST_HEAD(eeh_eventlist);
>
>  /**
> @@ -55,7 +55,7 @@ static int eeh_event_handler(void * dummy)
>         struct eeh_pe *pe;
>
>         while (!kthread_should_stop()) {
> -               if (down_interruptible(&eeh_eventlist_sem))
> +               if (wait_for_completion_interruptible(&eeh_eventlist_event))
>                         break;
>
>                 /* Fetch EEH event from the queue */
> @@ -102,9 +102,6 @@ int eeh_event_init(void)
>         struct task_struct *t;
>         int ret = 0;
>
> -       /* Initialize semaphore */
> -       sema_init(&eeh_eventlist_sem, 0);
> -
>         t = kthread_run(eeh_event_handler, NULL, "eehd");
>         if (IS_ERR(t)) {
>                 ret = PTR_ERR(t);
> @@ -142,7 +139,7 @@ int eeh_send_failure_event(struct eeh_pe *pe)
>         spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
>
>         /* For EEH deamon to knick in */
> -       up(&eeh_eventlist_sem);
> +       complete(&eeh_eventlist_event);
>
>         return 0;
>  }
> --
> 2.20.0
>
