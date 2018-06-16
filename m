Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3393D208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fx3j/VSh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XfUSST4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3393D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756812AbeFPAAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:00:08 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33892 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753723AbeFPAAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:00:06 -0400
Received: by mail-vk0-f66.google.com with SMTP id q135-v6so6625532vkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 17:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WFzQPFxYsHnMhHVYfXECY5MZ7aiJH6k39JqV1dFsDP0=;
        b=fx3j/VShzlbKBfETrBThDlymkoPw6ItD+GFiAc4ffVzt2M+XwJvF4HvEMO6HZKbNn0
         /GPClCbAgRi3Yt95u8H9L2d7m5dUmz7xX8KjRVmLbVn0HW6EWIC4ouC2c/+TdcrPmpPK
         EJuBg8wgjrs6hMK8BjTGoXDS7IhagxbbYpY/Owi3vo1iQyQ/zKdydqh+WLgSGFrlh4gG
         23RneADAHYSeQARnPIzVs/u1ucNZ8XvcTT4oexYgI6OJYV40X8kxQ9qepk9RG1ng5iBX
         rr6aQxZnZ2eCy54DNX6uPhYCcwE9Nsp4N0XMQKzdyjtiaeIo0cVBXKQf2ocEPueg7reD
         mqrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WFzQPFxYsHnMhHVYfXECY5MZ7aiJH6k39JqV1dFsDP0=;
        b=XfUSST4ODjw/S8o2owRvv/BvWvtR4kT7plVJ3p1zPkukDcnnq5OEiQI+KMW2xdEK8I
         d+vWGwbHvc0HVcRS7LBaKd/RnO9bUz3vK07nAgfEQ7lKUEoQ2HmNYI1Tn+j5AmJ+Jnpi
         gImIfLrvQY7vMYkBXbqIqpY5FvI28Zhdpia3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WFzQPFxYsHnMhHVYfXECY5MZ7aiJH6k39JqV1dFsDP0=;
        b=Dqweio7nCiPl+L2YFLkqAz1VNiy/938ue0DKqh+lW1RobBzY1kgYUhvR//wpGV/O7c
         Fj1CS2KwBTqNa/DcJUsoBl6uiP+8y+GYWRog08tepl7CFi9IZ2eot3YRRP98F8QwPjoG
         o9zR1K/bA44+aynT00RSmFBOa463uNd4QIWKqlG2oqwsXiqDWtYjRBu0LgvQXCZmexOW
         7SXgezrZLiIEuM8haWZT5zAD45fm2jwvTQstXaXNda7HIBiTJmYoi3pLydIjJuOMHV43
         rXqE8ZxtbMLjrVgJSpXoitE4FJvrZDyOf8kt3eNpWy5Gq6az3eY5yK/EUDgYCcSxYQmx
         morQ==
X-Gm-Message-State: APt69E1pJwtZHtCUxIVUlxlxTPHO4o5a1yB7qs5T/npe9iRXvfAgDyyE
        cNoLuecAq8yfSSb1E+4+Pp0DoF8qJcm21oCdX5Z2Hw==
X-Google-Smtp-Source: ADUXVKL8m6k+oysvJmXLveiz1HgrFbrBJQq3LbtwwY/11J9YqnnwqwTROmhvMTkpwgFv59brsuD4XlDSYo0yB1+pKqA=
X-Received: by 2002:a1f:2758:: with SMTP id n85-v6mr2220850vkn.117.1529107204716;
 Fri, 15 Jun 2018 17:00:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 17:00:03
 -0700 (PDT)
In-Reply-To: <20180615220131.65402-3-dmitry.torokhov@gmail.com>
References: <20180615220131.65402-1-dmitry.torokhov@gmail.com> <20180615220131.65402-3-dmitry.torokhov@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jun 2018 17:00:03 -0700
X-Google-Sender-Auth: -TbpLREwc9-SGBuT1mrEadW6XF0
Message-ID: <CAD=FV=V_5W7U-vo-HosN6bfBjqMkAs2hNG=o26soXn3H54YDzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: dwc2: host: do not schedule delayed QH unnecessarily
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 15, 2018 at 3:01 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> When we are ready to retry the delayed QH, we do not need to manually
> scan queues and schedule them if controller is already running; we only
> need to do that if SOF interrupt is masked, otherwise we'll pick them up
> at the next frame.

Just to confirm: this patch fixes no known issues, right?  It's based
on code inspection?


> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/usb/dwc2/hcd_queue.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> index e34ad5e653501..db9e7c9d31554 100644
> --- a/drivers/usb/dwc2/hcd_queue.c
> +++ b/drivers/usb/dwc2/hcd_queue.c
> @@ -1468,6 +1468,8 @@ static void dwc2_wait_timer_fn(struct timer_list *t)
>  {
>         struct dwc2_qh *qh = from_timer(qh, t, wait_timer);
>         struct dwc2_hsotg *hsotg = qh->hsotg;
> +       enum dwc2_transaction_type tr_type;
> +       u32 intr_mask;
>         unsigned long flags;
>
>         spin_lock_irqsave(&hsotg->lock, flags);
> @@ -1476,19 +1478,22 @@ static void dwc2_wait_timer_fn(struct timer_list *t)
>          * We'll set wait_timer_cancel to true if we want to cancel this
>          * operation in dwc2_hcd_qh_unlink().
>          */
> -       if (!qh->wait_timer_cancel) {
> -               enum dwc2_transaction_type tr_type;
> +       if (qh->wait_timer_cancel)
> +               goto out_unlock;
>
> -               qh->want_wait = false;

The removal of this "want_wait = false" isn't mentioned in the commit
message and seems unrelated.  Did you decide that setting this to
false is not important and thus you're removing it?  Could you move
this part to a separate patch?


> +       list_move(&qh->qh_list_entry, &hsotg->non_periodic_sched_inactive);
>
> -               list_move(&qh->qh_list_entry,
> -                         &hsotg->non_periodic_sched_inactive);
> +       /* See if we should kick the controller if it was idle */
> +       intr_mask = dwc2_readl(hsotg->regs + GINTMSK);
> +       if (intr_mask & GINTSTS_SOF)
> +               goto out_unlock;
>
> -               tr_type = dwc2_hcd_select_transactions(hsotg);
> -               if (tr_type != DWC2_TRANSACTION_NONE)
> -                       dwc2_hcd_queue_transactions(hsotg, tr_type);
> -       }
> +       /* The controller was idle, let's try queue our postponed work */
> +       tr_type = dwc2_hcd_select_transactions(hsotg);
> +       if (tr_type != DWC2_TRANSACTION_NONE)
> +               dwc2_hcd_queue_transactions(hsotg, tr_type);
>
> +out_unlock:
>         spin_unlock_irqrestore(&hsotg->lock, flags);
>  }
>
> @@ -1722,10 +1727,6 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>
>         /* Add the new QH to the appropriate schedule */
>         if (dwc2_qh_is_non_per(qh)) {
> -               /* Schedule right away */
> -               qh->start_active_frame = hsotg->frame_number;
> -               qh->next_active_frame = qh->start_active_frame;

Where do we set start_active_frame and next_active_frame in the
"want_wait" case now?  Shouldn't you be doing that in
"dwc2_wait_timer_fn()" now that you've removed it from here?  ...or is
it just not important for non-periodic transfers (in which case you
probably don't need to add it to the "not want_wait" case below)?

...this change also seems unrelated and the motivation is not included
in the commit description.  Should it too be a separate change?


> -
>                 if (qh->want_wait) {
>                         list_add_tail(&qh->qh_list_entry,
>                                       &hsotg->non_periodic_sched_waiting);
> @@ -1733,6 +1734,10 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
>                         mod_timer(&qh->wait_timer,
>                                   jiffies + DWC2_RETRY_WAIT_DELAY + 1);
>                 } else {
> +                       /* Schedule right away */
> +                       qh->start_active_frame = hsotg->frame_number;
> +                       qh->next_active_frame = qh->start_active_frame;
> +
>                         list_add_tail(&qh->qh_list_entry,
>                                       &hsotg->non_periodic_sched_inactive);
>                 }
> --
> 2.18.0.rc1.244.gcf134e6275-goog
>
