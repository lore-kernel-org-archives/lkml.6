Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031833AbeCAPVi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031659AbeCAPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:21:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E722177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 1 Mar 2018 16:21:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Levin Alexander <alexander.levin@verizon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Abeni <pabeni@redhat.com>, Radu Rendec <rrendec@arista.com>,
        Ingo Molnar <mingo@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Rik van Riel <riel@redhat.com>, Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 0/4] softirq: Per vector threading v3
Message-ID: <20180301152132.GB29639@lerouge>
References: <1516376774-24076-1-git-send-email-frederic@kernel.org>
 <20180207121844.0282138d@vento.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207121844.0282138d@vento.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 12:18:44PM -0200, Mauro Carvalho Chehab wrote:
> Em Fri, 19 Jan 2018 16:46:10 +0100
> Frederic Weisbecker <frederic@kernel.org> escreveu:
> 
> > As per Linus suggestion, this take doesn't limit the number of occurences
> > per jiffy anymore but instead defers a vector to workqueues as soon as
> > it gets re-enqueued on IRQ tail.
> > 
> > No tunable here, so testing should be easier.
> 
> Sorry for taking so long to test it. Just returned this week from a 2
> weeks travel, and had first to submit media patches for the merge window.
> 
> Didn't work. With this patch series, it still lose frames with
> usb bulk transfers, while recording DVB programs with tvheadend.

How can we reproduce this workload?
