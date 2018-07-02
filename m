Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3964C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7425724481
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmAVf3uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7425724481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeGBGYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:24:55 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38405 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbeGBGYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:24:52 -0400
Received: by mail-lf0-f67.google.com with SMTP id a4-v6so11072467lff.5;
        Sun, 01 Jul 2018 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NyfTUz7M+qPVVizTRv2zgOP2JJfuIM9sWRwslerlrtM=;
        b=lmAVf3uotadq/8R97ikwHSseQAgXBhWSA7HYQiaAe56ExSGkQDvUEa2gt9M4Uphoou
         uJHAVQROw+rYgFrbeaBF2vgN9rbg909BImcx63IdIobJ2aiHp4gkCoabM21OXNoFmcj2
         Fwqj3dhDNQqxLDXipYQ/PwEoHH9hGtKDTUBhp2a5jHGC2aKAmLqR/pGMRG3DKqEvTucX
         do8xFPZMLIuj9kgSAH04MaGz3Lu5AWJkub/FN/RJyJYhm2GwQWioanAK6qce+DsI/VBl
         e7n2bzMOpAFfFD8VRocqeKmE5VxL0T+nDuKoxZgT8MW34stR9zuZTQszhcNZFEJTOp9v
         acNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NyfTUz7M+qPVVizTRv2zgOP2JJfuIM9sWRwslerlrtM=;
        b=hUXIACo5Vc2glbfcTtOTn5mb9/qLPfqL5mOpcOSVam6pjYNbLAd+HnthlTHhrqXdD0
         Oa2nU+Vm4WiGWZ2OexZA52obt/YjID4lcOmOh0p8fsc6L2CjtBxWUYurLw7wlE2xTWMV
         OR4FNdLP4bvHOgnvmoWlcslM4T38Fzfik2yibhj1GjhgOXNI6C22wLNciIhHADwhErgI
         LnR4din1ae7fThMDHqn1xMYDT/qPw/n1OFkt838UsAh87ZAjEuWBhVpwaMoTBFWn9dTm
         tJM/lNcEynEFXxK8XfH9KxqzcPGc8uXm/ItMPsgGYDdGQv/2R0jlBaadimKJzi+3ApP0
         YIOA==
X-Gm-Message-State: APt69E3KfQqQpbCgkJFQ6idHuV38xkrlVNLLb4qzz8AAcQ2LFbDWdtXt
        b+uB+H0Sxv8H6DppPABnl9c=
X-Google-Smtp-Source: AAOMgpcUqWejqYBL07yqEpjXiGXxBPxYJ2Vv3h0xPt221AW2Xi/fBYzhxYYqQjAcnoUsikBmribi1Q==
X-Received: by 2002:a19:d60a:: with SMTP id n10-v6mr16395700lfg.27.1530512691247;
        Sun, 01 Jul 2018 23:24:51 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id 26-v6sm2480742lje.26.2018.07.01.23.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 23:24:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fZsGQ-00008Z-7O; Mon, 02 Jul 2018 08:24:42 +0200
Date:   Mon, 2 Jul 2018 08:24:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Octavian Purdila <tavi@cs.pub.ro>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        tglx@linutronix.de, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH REPOST] mfd: dln2: use irqsave() in USB's complete
 callback
Message-ID: <20180702062442.GD9802@localhost>
References: <20180701154108.13233-1-bigeasy@linutronix.de>
 <CAMoF9u0ZxNqKLV6FEjpHkGGuh8_V7zFQ_VpK-Y-fmbkSwL31Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMoF9u0ZxNqKLV6FEjpHkGGuh8_V7zFQ_VpK-Y-fmbkSwL31Rg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 12:07:22AM +0200, Octavian Purdila wrote:
> On Sun, Jul 1, 2018 at 5:41 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > The USB completion callback does not disable interrupts while acquiring
> > the lock. We want to remove the local_irq_disable() invocation from
> > __usb_hcd_giveback_urb() and therefore it is required for the callback
> > handler to disable the interrupts while acquiring the lock.
> > The callback may be invoked either in IRQ or BH context depending on the
> > USB host controller.
> > Use the _irqsave() variant of the locking primitives.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Octavian Purdila <octavian.purdila@intel.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  drivers/mfd/dln2.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> > index 704e189ca162..1ef3c92f32e0 100644
> > --- a/drivers/mfd/dln2.c
> > +++ b/drivers/mfd/dln2.c
> > @@ -194,6 +194,7 @@ static bool dln2_transfer_complete(struct dln2_dev *dln2, struct urb *urb,
> >         struct device *dev = &dln2->interface->dev;
> >         struct dln2_mod_rx_slots *rxs = &dln2->mod_rx_slots[handle];
> >         struct dln2_rx_context *rxc;
> > +       unsigned long flags;
> >         bool valid_slot = false;
> >
> >         if (rx_slot >= DLN2_MAX_RX_SLOTS)
> > @@ -206,13 +207,13 @@ static bool dln2_transfer_complete(struct dln2_dev *dln2, struct urb *urb,
> >          * context elsewhere in this driver. This function (or its callers) are
> >          * also not exported to other modules.
> >          */
> > -       spin_lock(&rxs->lock);
> > +       spin_lock_irqsave(&rxs->lock, flags);
> 
> 
> I don't think disabling the IRQ is necessary, please see the comment
> above and also this discussion:
> 
> https://www.spinics.net/lists/linux-usb/msg115214.html

It hasn't been necessary so far, but we want to get rid of the disabling
of interrupts before calling the completion handler so this patch is
correct.

The comment above the lock is not correct as it stands, and definitely
is not after the conversion, so Sebastian, could you please drop it as
part of this change?

With that you can add my:

Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan
