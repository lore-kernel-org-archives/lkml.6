Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B220C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F49A20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F49A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeLEQdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeLEQdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:33:46 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF542084C;
        Wed,  5 Dec 2018 16:33:45 +0000 (UTC)
Date:   Wed, 5 Dec 2018 11:33:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>, mingo@redhat.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] tracing: add cond_resched to ftrace_replace_code()
Message-ID: <20181205113342.00ed69a5@vmware.local.home>
In-Reply-To: <CADYN=9+-z=_5Gn9hJcGi8UwbNxS2jK+OXe5DE0pGxscuZA_8tg@mail.gmail.com>
References: <20181204192903.8193-1-anders.roxell@linaro.org>
        <20181205095445.GA14317@arm.com>
        <CADYN=9+-z=_5Gn9hJcGi8UwbNxS2jK+OXe5DE0pGxscuZA_8tg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 11:43:12 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> > > +     schedulable = !irqs_disabled() && !preempt_count();  
> >
> > Is there a reason not to use preemptible() here?  
> 
> As I understand it preemptible() is defined to 0 if
> CONFIG_PREEMPT_COUNT is disabled.
> Thats no good right ?

No it's not, which means this isn't a good approach. I have a much
better idea on how to solve this. I'll post a small patch set in a bit.

-- Steve
