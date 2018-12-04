Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E9B20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E9B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLDTie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:38:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeLDTie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:38:34 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F222081C;
        Tue,  4 Dec 2018 19:38:33 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:38:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: Strange hang with gcc 8 of kprobe multiple_kprobes test
Message-ID: <20181204143830.6c7f8910@vmware.local.home>
In-Reply-To: <20181204081506.GA73770@gmail.com>
References: <20181203211807.17e03384@vmware.local.home>
        <20181204164007.956a3458c9fd301b3d173eba@kernel.org>
        <20181204170229.4442d43ce956d48619c1d232@kernel.org>
        <20181204081506.GA73770@gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 09:15:06 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > I remember I have fixed this, and actually WE did it :-D
> > 
> > https://lkml.org/lkml/2018/8/23/1203
> > 
> > Ah, we hit a same bug...
> > 
> > Ingo, could you pick the patch? Should I resend it?  
> 
> Indeed: I just picked it up into tip:perf/urgent.
> 
> It's my bad: I missed the original submission due to Steve's feedback 
> which I mistook as a request for another iteration, while he only 
> commented on the reason for the original breakage and gave his 
> Reviewed-by ...
> 

Sorry for the confusion. The patch and code was quite complex, and I
was documenting what I thought of the patch (and the bug), so that my
Reviewed-by had a bit more meaning.

-- Steve
