Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBC0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E0020859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfAIRJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:09:38 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56939 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfAIRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:09:38 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghHMF-0005M3-IR; Wed, 09 Jan 2019 18:09:35 +0100
Date:   Wed, 9 Jan 2019 18:09:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109165235.GA8151@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-09 17:52:35 [+0100], Greg Kroah-Hartman wrote:
> If there are no in-kernel users, the symbols should not be exported
> anymore.  That's nothing new, we have always done this.

The thing is that we had
  EXPORT_SYMBOL(__kernel_fpu_begin)
  EXPORT_SYMBOL_GPL(kernel_fpu_begin)

and now __kernel_fpu_begin() is no longer exported and static only.
All in kernel user (including the kvm module) use kernel_fpu_begin()
which is not available to proprietary modules. Hence Marc's mail.

> > On the other hand could we just drop EXPORT_SYMBOL_GPL? I doubt this
> > helps in any way yet please correct me if I am wrong. 
> 
> Yes, it helps, please leave it as-is.

As you say. I only notice that certain things used to work and then no
longer do because due to $rework it somehow become EXPORT_SYMBOL_GPL
only and people complain and we tend to switch the export back to
EXPORT_SYMBOL. I'm not aware of a case where it actually helped in
anyway.

> thanks,
> 
> greg k-h

Sebastian
