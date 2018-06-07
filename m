Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BoylIvo/GVu7XgAAmS7hNA
	; Thu, 07 Jun 2018 14:23:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6A269608BA; Thu,  7 Jun 2018 14:23:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdA66D0q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,TVD_SUBJ_WIPE_DEBT,
	T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D2B08602FC;
	Thu,  7 Jun 2018 14:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2B08602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeFGOXw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932859AbeFGOXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:23:49 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B1B2086E;
        Thu,  7 Jun 2018 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528381428;
        bh=6XqSk6Mkohqwo2pQWtrptz5FIPsPP3xxzmx7Rx8GFp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YdA66D0q28Y9lFQxyzFNhrOCxYhpkyw1lYS4Z17R86fq/0PJQhWD8yfcaXY9sdofx
         T99wc395xSaCvr9uRinf7mMb62ARtMAE6IAQrXP4gqhwCtoxerNDOyPMBy4uW5tGLo
         o2UercB98bGh120wTYlfq0wI7ooi8RG5LfYUmwgc=
Date: Thu, 7 Jun 2018 23:23:44 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH -tip v5 07/27] powerpc/kprobes: Remove jprobe
 powerpc implementation
Message-Id: <20180607232344.31785bad5ebcbe82dd381284@kernel.org>
In-Reply-To: <1528370755.shi1gq6h7g.naveen@linux.ibm.com>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812751377.10068.6090934299713110701.stgit@devbox>
        <1528370755.shi1gq6h7g.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jun 2018 17:01:23 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > Remove arch dependent setjump/longjump functions
> > and unused fields in kprobe_ctlblk for jprobes
> > from arch/powerpc. This also reverts commits
> > related __is_active_jprobe() function.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> >  arch/powerpc/include/asm/kprobes.h             |    2 -
> >  arch/powerpc/kernel/kprobes-ftrace.c           |   15 -------
> >  arch/powerpc/kernel/kprobes.c                  |   54 ------------------------
> >  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 ++---------------
> >  4 files changed, 5 insertions(+), 105 deletions(-)
> 
> LGTM.
> 
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks Naveen!

> 
> - Naveen
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
