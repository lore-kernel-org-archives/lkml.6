Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeCUTB7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752527AbeCUTB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:01:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA7421770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 21 Mar 2018 15:01:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        "Luis Claudio R. =?UTF-8?B?R29uw6dhbHZlcw==?=" <lclaudio@redhat.com>,
        Clark Williams <williams@redhat.com>, target-devel@vger.kernel.org
Subject: Re: [PATCH] target: Use WARNON_NON_RT(!irqs_disabled())
Message-ID: <20180321150154.282ce8d7@gandalf.local.home>
In-Reply-To: <20180321185001.GB11249@infradead.org>
References: <20180321153854.GB24312@kernel.org>
        <20180321185001.GB11249@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 11:50:01 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Mar 21, 2018 at 12:38:54PM -0300, Arnaldo Carvalho de Melo wrote:
> >  	assert_spin_locked(&cmd->t_state_lock);
> > -	WARN_ON_ONCE(!irqs_disabled());
> > +	WARN_ON_ONCE_NONRT(!irqs_disabled());  
> 
> I can't find where WARN_ON_ONCE_NONRT is defined.

It's only in the RT patch set. But that may be changing soon.

> 
> That being said I think we can just kill these asserts.  If we have irqs
> disabled spin_unlock_irq a few lines below should already warn.

I agree with Linus. This should just be some kind of
lockdep_assert_held_irqs_disabeld() or something like that.

-- Steve
