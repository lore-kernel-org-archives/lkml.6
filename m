Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B2EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365AA2583C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 22:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYVGd8gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365AA2583C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.pub.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeGAWH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 18:07:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45641 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeGAWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 18:07:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id g15-v6so5993942edr.12;
        Sun, 01 Jul 2018 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TddsCyw25/bvo/HCNN4DeeoMAWbsthu0+peHDNEMYQ8=;
        b=tYVGd8gI3Bwxu33+aRf0nUT+7YLLmiF8yCYOrOieoqldsv8yBOJg/9QerEqO/lvpVR
         Eg8oNb2x34+VC24DnvjASfInhJ9oQKNrgiXnKAqn0fOmRf9b9LENePeQ/8HrTTEDAKmz
         vIsju84Ta2EpNiBN5ERbJtm3x9c9E5rAq6EhH/ubfcPgN0JqNnao4/DRU2LuJ+h+xcma
         uIxBkmBF6KPkhoPUle3MIZgISYxbI4GPj17Sdj0/Zkd98sOGKzRQ8rcIwlGa8n0evaRP
         j49Avg1DdAg4JHQgzRyS2ed1SD8zjBOI4YgU3d0rTb4TAjhCNcltzwUZ7jzqZaorHIHA
         2ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TddsCyw25/bvo/HCNN4DeeoMAWbsthu0+peHDNEMYQ8=;
        b=EUVO9jfdSUL64zMXOa7aL3+wtC3YzPtouS1sUA/AhlWiR4w8+0ru12TLvCMvV4yL8x
         INDV5x+fkf0RBW5fCDXhLlVUkNmeC/e6cVd+HsbDFEEyWUv9aeTSgpC9nDP0cXAyLw32
         KC2bAKmuNzrguAR/k4WGBqVGPbdyxH9OQqY4G00GdbfGQrnivH970pWP8BgxzoS3XOqd
         VAocmAZb4ifinWiYjqU3XDjOILKQCKnT5xt7wpkcVIQ1FI49rId4b70DZmCP78uJxCum
         0Chhabb6i+A01kQ9MTH00KUuRVrgHS3TsMWRcZYzzuLrFq7IVnml37T+bH1AWd7cRCLm
         twqA==
X-Gm-Message-State: APt69E1jAD4LiOk53dsN7f9Jpz7fnN7u24KC/Mak3/ipQqj9iDFGRfHQ
        hEP0w+l6VdjpgHoufynwCaRkOBLq/SuHlpkGVaU=
X-Google-Smtp-Source: AAOMgpci97RYaTf/nt8mWf5EuqrbJUuIhbH7asAUK3EED2wNjYsJLmKwh1/4ODCfLkY+ep/Z/TeMTIt4jjHL3eQWrzM=
X-Received: by 2002:a50:8f86:: with SMTP id y6-v6mr21682050edy.290.1530482843447;
 Sun, 01 Jul 2018 15:07:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:c54a:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 15:07:22 -0700 (PDT)
In-Reply-To: <20180701154108.13233-1-bigeasy@linutronix.de>
References: <20180701154108.13233-1-bigeasy@linutronix.de>
From:   Octavian Purdila <tavi@cs.pub.ro>
Date:   Mon, 2 Jul 2018 00:07:22 +0200
X-Google-Sender-Auth: pblH6oEOtxLA2IxX6vOyX5wMNqA
Message-ID: <CAMoF9u0ZxNqKLV6FEjpHkGGuh8_V7zFQ_VpK-Y-fmbkSwL31Rg@mail.gmail.com>
Subject: Re: [PATCH REPOST] mfd: dln2: use irqsave() in USB's complete callback
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        tglx@linutronix.de, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 5:41 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> The USB completion callback does not disable interrupts while acquiring
> the lock. We want to remove the local_irq_disable() invocation from
> __usb_hcd_giveback_urb() and therefore it is required for the callback
> handler to disable the interrupts while acquiring the lock.
> The callback may be invoked either in IRQ or BH context depending on the
> USB host controller.
> Use the _irqsave() variant of the locking primitives.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Octavian Purdila <octavian.purdila@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/mfd/dln2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index 704e189ca162..1ef3c92f32e0 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -194,6 +194,7 @@ static bool dln2_transfer_complete(struct dln2_dev *dln2, struct urb *urb,
>         struct device *dev = &dln2->interface->dev;
>         struct dln2_mod_rx_slots *rxs = &dln2->mod_rx_slots[handle];
>         struct dln2_rx_context *rxc;
> +       unsigned long flags;
>         bool valid_slot = false;
>
>         if (rx_slot >= DLN2_MAX_RX_SLOTS)
> @@ -206,13 +207,13 @@ static bool dln2_transfer_complete(struct dln2_dev *dln2, struct urb *urb,
>          * context elsewhere in this driver. This function (or its callers) are
>          * also not exported to other modules.
>          */
> -       spin_lock(&rxs->lock);
> +       spin_lock_irqsave(&rxs->lock, flags);


I don't think disabling the IRQ is necessary, please see the comment
above and also this discussion:

https://www.spinics.net/lists/linux-usb/msg115214.html
