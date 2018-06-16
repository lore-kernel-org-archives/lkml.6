Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5233C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D85208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd2/tsS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D85208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756828AbeFPAT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:19:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34037 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbeFPAT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:19:28 -0400
Received: by mail-pg0-f67.google.com with SMTP id q4-v6so5093886pgr.1;
        Fri, 15 Jun 2018 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nz1+MuUmOT74Uva9CTHx54b1Dy0LskJ4oLX32m3Gq4w=;
        b=Jd2/tsS7KS4ABRISd6N6UxUaYGxIFQzgTqMXFcBldMhlWN7zbauw3Cp21CoSKezmM0
         t+1tA59SeLrKAjM17RNY/sOtd4RP6B63bqNOk4Y3M7EzDaSLAdqOWlYBWZfJgzWrwnVy
         9Z0XFm+zzFW2RSByFXCQkH3fPiLZvq0cX7wa5BwyPZP/bEsJPnbIkz0NZtj7UkXgYGRb
         fJgJwtfSz4p0iqQ77cc2RMTmz/JJKHjGB70GjhxJTQ/RwFIJnXfeQGK/h41riR+U8zh9
         gdDkM9ETV2nB+usstum1GNkzeHvSBMhPaLEBlDdbnOMovcOyvXh8q4f5IXyrtC5hWqjW
         cdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nz1+MuUmOT74Uva9CTHx54b1Dy0LskJ4oLX32m3Gq4w=;
        b=ButelxwH+8ksqAcTV1y9m/z2J7OYA6ePnkxlgAiKy19o9OIRutMJzwmxSfRTuyC9cD
         xrhuli/3DFs4Tm9zsEo+L7WFhvHizLPpQwbDZPDaMCUQ6XwD/4Rtwn6nypd0vR54eXzS
         i4pcK92TAHQLSipdfDfb/OhttUbOI8Y0xI6kFrt5sNzrJViGTOvF35oLW9GCHkLQ7uLL
         hus437rTK4e5OUkMRaI6iMwv55CSTNbre6btVqzdl6eHsLwUMv7DAsk069ns0r3iqfFc
         hFPTphFBb1LBC5AuANaFymXfAL9VPYx+kDNxfR5OT6fX0PJOBKD5r/RavEJKPYqwivnc
         zKHg==
X-Gm-Message-State: APt69E0mxL4M8b72461Rge7g52V2aakFAmNPMblexynpAWLwI1S84rJt
        Xi5J2sPQzVwFxicXOdWsW3M=
X-Google-Smtp-Source: ADUXVKJA3iwrnADNmKQvxc4vle6V3vQGymMUKJ2OfXQp97PvRrIur7OWdgDD1e5DGMvtoTVh5q38tg==
X-Received: by 2002:a63:be4f:: with SMTP id g15-v6mr3528006pgo.115.1529108367059;
        Fri, 15 Jun 2018 17:19:27 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id m5-v6sm24890117pfa.93.2018.06.15.17.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 17:19:25 -0700 (PDT)
Date:   Fri, 15 Jun 2018 17:19:23 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb: dwc2: host: do not schedule delayed QH
 unnecessarily
Message-ID: <20180616001923.GA84824@dtor-ws>
References: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
 <20180615220131.65402-3-dmitry.torokhov@gmail.com>
 <CAD=FV=V_5W7U-vo-HosN6bfBjqMkAs2hNG=o26soXn3H54YDzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V_5W7U-vo-HosN6bfBjqMkAs2hNG=o26soXn3H54YDzA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 05:00:03PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 15, 2018 at 3:01 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > When we are ready to retry the delayed QH, we do not need to manually
> > scan queues and schedule them if controller is already running; we only
> > need to do that if SOF interrupt is masked, otherwise we'll pick them up
> > at the next frame.
> 
> Just to confirm: this patch fixes no known issues, right?  It's based
> on code inspection?

That is correct.

> 
> 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/usb/dwc2/hcd_queue.c | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> > index e34ad5e653501..db9e7c9d31554 100644
> > --- a/drivers/usb/dwc2/hcd_queue.c
> > +++ b/drivers/usb/dwc2/hcd_queue.c
> > @@ -1468,6 +1468,8 @@ static void dwc2_wait_timer_fn(struct timer_list *t)
> >  {
> >         struct dwc2_qh *qh = from_timer(qh, t, wait_timer);
> >         struct dwc2_hsotg *hsotg = qh->hsotg;
> > +       enum dwc2_transaction_type tr_type;
> > +       u32 intr_mask;
> >         unsigned long flags;
> >
> >         spin_lock_irqsave(&hsotg->lock, flags);
> > @@ -1476,19 +1478,22 @@ static void dwc2_wait_timer_fn(struct timer_list *t)
> >          * We'll set wait_timer_cancel to true if we want to cancel this
> >          * operation in dwc2_hcd_qh_unlink().
> >          */
> > -       if (!qh->wait_timer_cancel) {
> > -               enum dwc2_transaction_type tr_type;
> > +       if (qh->wait_timer_cancel)
> > +               goto out_unlock;
> >
> > -               qh->want_wait = false;
> 
> The removal of this "want_wait = false" isn't mentioned in the commit
> message and seems unrelated.  Did you decide that setting this to
> false is not important and thus you're removing it?  Could you move
> this part to a separate patch?

Yes I will. My opinion is that we set/reset the flag in hcd_intr.c when
we receive a NAK. Scheduling a transfer does not really affect the state
of "NAKiness" of the QH, so it is not right to remove the flag.

> 
> 
> > +       list_move(&qh->qh_list_entry, &hsotg->non_periodic_sched_inactive);
> >
> > -               list_move(&qh->qh_list_entry,
> > -                         &hsotg->non_periodic_sched_inactive);
> > +       /* See if we should kick the controller if it was idle */
> > +       intr_mask = dwc2_readl(hsotg->regs + GINTMSK);
> > +       if (intr_mask & GINTSTS_SOF)
> > +               goto out_unlock;
> >
> > -               tr_type = dwc2_hcd_select_transactions(hsotg);
> > -               if (tr_type != DWC2_TRANSACTION_NONE)
> > -                       dwc2_hcd_queue_transactions(hsotg, tr_type);
> > -       }
> > +       /* The controller was idle, let's try queue our postponed work */
> > +       tr_type = dwc2_hcd_select_transactions(hsotg);
> > +       if (tr_type != DWC2_TRANSACTION_NONE)
> > +               dwc2_hcd_queue_transactions(hsotg, tr_type);
> >
> > +out_unlock:
> >         spin_unlock_irqrestore(&hsotg->lock, flags);
> >  }
> >
> > @@ -1722,10 +1727,6 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
> >
> >         /* Add the new QH to the appropriate schedule */
> >         if (dwc2_qh_is_non_per(qh)) {
> > -               /* Schedule right away */
> > -               qh->start_active_frame = hsotg->frame_number;
> > -               qh->next_active_frame = qh->start_active_frame;
> 
> Where do we set start_active_frame and next_active_frame in the
> "want_wait" case now?  Shouldn't you be doing that in
> "dwc2_wait_timer_fn()" now that you've removed it from here?  ...or is
> it just not important for non-periodic transfers (in which case you
> probably don't need to add it to the "not want_wait" case below)?
> 

Hmm, I thought that we would adjust qh->start_active_frame and
qh->next_active_frame as needed when we schedule QH again, similarly to
the initial transfer request for a given URB. But I do not have strong
opinion so I'll simply drop this change.

Thanks!

-- 
Dmitry
