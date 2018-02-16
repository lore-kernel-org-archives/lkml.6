Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-772761-1518805748-2-11927301487755466684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518805747; b=N8u7uAvj0QpOVlenMIY+2FWaNUSi5hsnEozvOyxf4hBx2Ab
    6tJ4dWWBVOeEiW6AqtXaxlrSEFAeBajJ4dwMwl41PZepjRFHrGrVmip2RmOW0bDz
    y7QFEkP6TFanL7wkKo7VoeviKFXOAQhI5UlBOgtbp1h01r2XClIluDltHRiF5pLR
    4hBVUB58zYMrQNW4bigns1Tq1h3S99QT9z4wrLZCbN3Gftpssu6ffY0ZIzykVrsG
    Qtqq86b6aCy8I3SlhEqjSNJIBz7kG8BXYibyQehFt5FuQj9PN/EawOw8eJUtafa0
    D+J0GJtE3IknCEtjuIVDda8VQY2S/9h5DjXIYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=arctest;
    t=1518805747; bh=BwUOqSMOZcDkp47jCXgSl9pAfzh+ugu95oZls7vUcQI=; b=
    U+LnO4JPxkwgW0QuzxV5b+Enpcyfik6YnvKiQ0idr/DwvE3ukrRMTbrT+GTIV/ug
    2N1TsaCGB+Tj2gYOd3WjRGngwwfpDrRbwRC0BI8s+7iXDEDgGobF8KnAX/CSYll5
    jXEaak8Dy4lScAzxkR+5BeRYMilXCXYfL4FBwT46m5l55Hv8JfuTBmPGCJsB4NJW
    +e0s0pHTvp8YptiHVspMxF7TY6ulXWOMYw5cjV00YKAoPVnWiTbvzmKFaeyo03CG
    c9uwy3fVA5bqc8OglRHdZ9YxATSm9GNCclMuMoTJqQ0s6MqpwZFYgP/f+ifJH43w
    Y19PXY+mqq/giM1WN5pnSw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeBPS3E (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 13:29:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:54584 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751459AbeBPS3D (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 13:29:03 -0500
Date: Fri, 16 Feb 2018 13:29:01 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: hcd: complete URBs in threaded-IRQ context
 instead of tasklet
In-Reply-To: <20180216170450.yl5owfphuvltstnt@breakpoint.cc>
Message-ID: <Pine.LNX.4.44L0.1802161325050.1402-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018, Sebastian Andrzej Siewior wrote:

> I've been going over Frederic's softirq patches and it seems that there
> were two problems. One was network related, the other was Mauro's USB
> dvb-[stc] device which was not able to stream properly over time.
> 
> Here is an attempt to let the URB complete in the threaded handler
> instead of going to the tasklet. In case the system is SMP then the
> patch [0] would be required in order to have the IRQ and its thread on
> the same CPU.
> 
> Mauro, would you mind giving it a shot?
> 
> [0] genirq: Let irq thread follow the effective hard irq affinity
>     https://git.kernel.org/tip/cbf8699996a6e7f2f674b3a2a4cef9f666ff613e
> 
> ---
> 
> The urb->complete callback was initially invoked in IRQ context after
> the HCD dropped its lock because the callback could re-queue the URB
> again. Later this completion was deferred to the tasklet allowing the
> HCD hold the lock. Also the BH handler can be interrupted by the IRQ
> handler adding more "completed" requests to its queue.
> While this batching is good in general, the softirq defers its doing for
> short period of time if it is running constantly without a break. This
> breaks some use cases where constant USB throughput is required.
> As an alternative approach to tasklet handling, I defer the URB
> completion to the HCD's threaded handler. There are two lists for
> "high-prio" proccessing and lower priority (to mimic current behaviour).
> The URBs in the high-priority list are always preffered over the URBs
> in the low-priority list.

We originally used tasklets because we didn't want to incur the delays 
associated with running in a process context.  It seems odd to be 
reversing that decision now.

> The URBs from the root-hub never create an interrupt so I currently
> process them in a workqueue (I'm not sure if an URB-enqueue in the
> completion handler would break something).

It worked okay before we changed over to using tasklets.

Alan Stern

