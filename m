Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D2B222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407511AbfBNPQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:16:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389467AbfBNPQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:16:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7457C80D;
        Thu, 14 Feb 2019 07:16:51 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 402D03F575;
        Thu, 14 Feb 2019 07:16:50 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:16:48 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] tracing: Fix number of entries in trace header
Message-ID: <20190214151646.dsmekrclnrpjzjzx@queper01-lin>
References: <20190214150130.3162-1-quentin.perret@arm.com>
 <CAJWu+oq=Jrh4wUE=v_ihsHUiDZPzDzv1L57qmiRypZWaD60fmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oq=Jrh4wUE=v_ihsHUiDZPzDzv1L57qmiRypZWaD60fmg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 Feb 2019 at 10:12:52 (-0500), Joel Fernandes wrote:
> On Thu, Feb 14, 2019 at 10:01 AM Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > The following commit
> >
> >   441dae8f2f29 ("tracing: Add support for display of tgid in trace output")
> >
> > removed the call to print_event_info() from print_func_help_header_irq()
> > which results in the ftrace header not reporting the number of entries
> > written in the buffer. As this wasn't the original intent of the patch,
> > re-introduce the call to print_event_info() to restore the orginal
> > behaviour.
> 
> Needs a "Fixes:" tag, and a CC to stable.

Hrmpf, good point, I always forget those, sorry about that :/
I'll send a v2 shortly.

> Acked-by: Joel Fernandes <joelaf@google.com>

Thanks !
Quentin
