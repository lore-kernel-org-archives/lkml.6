Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeBHUPA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:15:00 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56270 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeBHUO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:14:59 -0500
X-Google-Smtp-Source: AH8x224SNSck6yY7IRM0EmUJbk3O5WoZEQiUWqge1oBYqFu/Wuu3PW3lmtbdrDcI8waVKjI1bXPT4A==
Message-ID: <1518120895.2849.14.camel@arista.com>
Subject: Re: [RFC PATCH 2/4] softirq: Per vector deferment to workqueue
From: Dmitry Safonov <dima@arista.com>
To: David Miller <davem@davemloft.net>, bigeasy@linutronix.de
Cc: frederic@kernel.org, linux-kernel@vger.kernel.org,
        alexander.levin@verizon.com, peterz@infradead.org,
        mchehab@s-opensource.com, torvalds@linux-foundation.org,
        hannes@stressinduktion.org, paulmck@linux.vnet.ibm.com,
        wanpeng.li@hotmail.com, tglx@linutronix.de, akpm@linux-foundation.org,
        pabeni@redhat.com, rrendec@arista.com, mingo@kernel.org,
        sgruszka@redhat.com, riel@redhat.com, edumazet@google.com
Date: Thu, 08 Feb 2018 20:14:55 +0000
In-Reply-To: <20180208.134506.1374787894560277876.davem@davemloft.net>
References: <1516376774-24076-1-git-send-email-frederic@kernel.org>
         <1516376774-24076-3-git-send-email-frederic@kernel.org>
         <20180208174450.qjvjy752jf4ngt2g@breakpoint.cc>
         <20180208.134506.1374787894560277876.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-08 at 13:45 -0500, David Miller wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Thu, 8 Feb 2018 18:44:52 +0100
> 
> > May I instead suggest to stick to ksoftirqd? So you run in softirq
> > context (after return from IRQ) and if takes too long, you offload
> the
> > vector to ksoftirqd instead. You may want to play with the metric
> on
> > which you decide when you want switch to ksoftirqd / account how
> long a
> > vector runs.
> 
> Having read over this stuff for the past few weeks this is how I feel
> as well.  Just make ksofbitrq do what we want (only execute the
> overloaded softirq vectors).
> 
> The more I look at the workqueue stuff, the more complications and
> weird behavioral artifacts we are getting for questionable gain.

What about creating several ksoftirqd threads per-cpu?
Like I did with boot parameter to specify how many threads and which
softirqs to serve.

-- 
Thanks,
             Dmitry
