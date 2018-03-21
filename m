Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeCUSuN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:50:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeCUSuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:50:10 -0400
Date: Wed, 21 Mar 2018 11:50:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-scsi@vger.kernel.org,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        Luis Claudio =?iso-8859-1?Q?R=2E_Gon=E7alves?=
        <lclaudio@redhat.com>,
        Clark Williams <williams@redhat.com>, target-devel@vger.kernel.org
Subject: Re: [PATCH] target: Use WARNON_NON_RT(!irqs_disabled())
Message-ID: <20180321185001.GB11249@infradead.org>
References: <20180321153854.GB24312@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321153854.GB24312@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 12:38:54PM -0300, Arnaldo Carvalho de Melo wrote:
>  	assert_spin_locked(&cmd->t_state_lock);
> -	WARN_ON_ONCE(!irqs_disabled());
> +	WARN_ON_ONCE_NONRT(!irqs_disabled());

I can't find where WARN_ON_ONCE_NONRT is defined.

That being said I think we can just kill these asserts.  If we have irqs
disabled spin_unlock_irq a few lines below should already warn.
