Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932091AbeBGOS4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:18:56 -0500
Received: from osg.samsung.com ([64.30.133.232]:39399 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754337AbeBGOSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:18:53 -0500
Date: Wed, 7 Feb 2018 12:18:44 -0200
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20180207121844.0282138d@vento.lan>
In-Reply-To: <1516376774-24076-1-git-send-email-frederic@kernel.org>
References: <1516376774-24076-1-git-send-email-frederic@kernel.org>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 19 Jan 2018 16:46:10 +0100
Frederic Weisbecker <frederic@kernel.org> escreveu:

> As per Linus suggestion, this take doesn't limit the number of occurences
> per jiffy anymore but instead defers a vector to workqueues as soon as
> it gets re-enqueued on IRQ tail.
> 
> No tunable here, so testing should be easier.

Sorry for taking so long to test it. Just returned this week from a 2
weeks travel, and had first to submit media patches for the merge window.

Didn't work. With this patch series, it still lose frames with
usb bulk transfers, while recording DVB programs with tvheadend.

Thanks,
Mauro
