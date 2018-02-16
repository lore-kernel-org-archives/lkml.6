Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1149420-1518817631-2-10112240262247661963
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
    t=1518817631; b=aKNXYwjkaMBTitHppLTK/GDsT0BUW3FxtQPFAzK+3p6yDV1
    O5yzFKUO5CYIKsEKF54VpbORYDZcPLb1Vft0PMnxOhPgl3bvhwAeMQXG0UcW1Loh
    rUwdlR1gT/jQrfaOA2Ol/BXT22g7KFUIHpo2JJqqlZHMA6OOuk12MNVZKWxabMur
    6Z2HpNHjehEGsltEhEnxe6btfrlnE7OSR8OztzMzDu4+PcmdvCxdmACQJPiFwI9S
    W5I7WDO97vvP6ZlbVcThj9uKG5OmG3qkW4QHEvercbbXRmowZuXxs5oth1+nAiIy
    AWQdSne+l5R1JsVL8djKZQa6wNFRVn7NCMI5maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=arctest;
    t=1518817631; bh=5MFelqprKiufQBThwk9V+1KgfqKPQDUtP1rFirRLq0g=; b=
    iv7n+hDtOfMQIE8gYD9BDULiaQ+fAh54ZuezNaQafHpcnO0cuc1O050UcxaYGMwY
    1TjDpbvosWcE3+08jq/eQCfj9H8jy4JVtI5FZZx6szyc7U+GXpQmvYvMMqgiX+14
    I3tHPW+0Lrz2XbPQkO7dmicT5tuScKvPFZaWKkVV3Yb27ur2iH786lx09t/fksWm
    NKIrrlYPgTNnLL176E8KiyiB9sR7ba4a+VS0Wm7uG5AN6cO//IXQiiUUmaHuUyfc
    zgrRjPQDX20tp4iBBouMJWhL80b/RBpDXUWH8HYk13uWoFUk4P/4+58nQW6jxFVZ
    MTIDwOgIA+a7b74TF75xqQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbeBPVqn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 16:46:43 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:54912 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1750819AbeBPVqm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 16:46:42 -0500
Date: Fri, 16 Feb 2018 16:46:41 -0500 (EST)
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
In-Reply-To: <20180216203808.23mvv4mtz6khhwfv@linutronix.de>
Message-ID: <Pine.LNX.4.44L0.1802161623550.1402-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018, Sebastian Andrzej Siewior wrote:

> On 2018-02-16 13:29:01 [-0500], Alan Stern wrote:
> > We originally used tasklets because we didn't want to incur the delays 
> > associated with running in a process context.  It seems odd to be 
> > reversing that decision now.
> 
> The theaded interrupt runs SCHED_FIFO priority 50 by default. The only
> thing that can interrupt it are interrupts, a softirq (not ksoftirqd)
> and other tasks with a higher priority than 50.
> There should be no downside performance wise.

Maybe.  It would be nice to see some real measurements.

> > > The URBs from the root-hub never create an interrupt so I currently
> > > process them in a workqueue (I'm not sure if an URB-enqueue in the
> > > completion handler would break something).
> > 
> > It worked okay before we changed over to using tasklets.
> 
> Ah okay. I've seen that HCDs were no longer dropping their internal lock
> and I wasn't sure if such a change was also applied in RH-code.

Oh... my memory was faulty.  After going back and looking at the old
source, I see that before we switched to tasklets the code _did_ drop
the hcd_root_hub_lock when giving back root-hub URBs.  Now it doesn't.

(It's also worth noticing that the current code gives back root-hub 
URBs in a tasklet even for HCDs that don't support using tasklets for 
non-root-hub URBs.)

In any case, latency doesn't matter much for root-hub URBs.

Alan Stern

