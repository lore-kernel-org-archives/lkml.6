Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TC0aIHFuGFsmGgAAmS7hNA
	; Wed, 06 Jun 2018 23:29:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6715C608BA; Wed,  6 Jun 2018 23:29:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="hP5tdN9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jHb+ZBil"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B6812607E4;
	Wed,  6 Jun 2018 23:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6812607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932143AbeFFX3u (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:29:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33401 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932081AbeFFX3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:29:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0759E21B6B;
        Wed,  6 Jun 2018 19:29:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Jun 2018 19:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rdGgd0UcjP9uU8fGTwwpXAAAvhDa9Kz7JNJb+HOgIQE=; b=hP5tdN9C
        8+GwYmPbYsoxDy8wtUXMIngc9sl10+/ZUSJElJlCsjLsm+j6bB9rGvJgdZ62ncBk
        jbMjcSHXm+bVK3dEDUBogLIsZOHFwwqL5qKIi3uSsU00kDojYgVsK1G9Uv1ctwzX
        00yhH3XuJmbNyKbaZQlGCWYYhO5LB7LrQpGwL7SVL8bufOAq856vkUltOK8c5Vph
        LzAvwtY/TOHInXZFchLSsFDeCJii0i4zkSjCtsbon8TMf+UpWbPQOKqh+1+r05Pr
        F9d0buZnWZ8e7N8KI78cQEMJBUgwMcFpskJZ0LxaJqt9TCOB9by6ygtUMF8H1QXE
        kB0P0rYSEttz2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=rdGgd0UcjP9uU8fGTwwpXAAAvhDa9
        Kz7JNJb+HOgIQE=; b=jHb+ZBilbKireKdb+g/E9oki6NvXOqG3SSA3tP3mA6sLm
        C58dshGrcNat3X35Kcjo0NRhFNwiX6aAj8nSQuYpKaSFxqVxcss7w1OiNGcQL5r1
        bGI2HgPNgmIXPKRgj4uUa5mgEwY+fDT4ZSurB9uumlPjOvwyht0Zlqfkz3h2C64r
        ezpmdZiKLFI9SCRE30zoQsaMBnU1FVqngaKK3Irg3lkgTDSOuyU80c6oYPOPtYOD
        OSHSGNoF+sbW43p8+YAYhIBH3B8mAAWdBrUrZbc7VPTlM7vdLRaMiA3OUoBPHK41
        LzoEXwWNWyB79FUDmtEoQb4peTBc3DPaKQQZTGwVQ==
X-ME-Proxy: <xmx:a24YW0F4J3z9DuHDGWxCm472t4FdxDAlWF4alhbY8Zae0y1e6dqNUQ>
X-ME-Proxy: <xmx:a24YWw1_hvO1ONptSGvCdzeW0jxtx-kHc3INuiEr0bDQnxCH5-c7rg>
X-ME-Proxy: <xmx:a24YW2ptd7JuLSzobf7R9MmQK5F9cVq0DY_u3yYRFVt3MLZTmZQZHw>
X-ME-Proxy: <xmx:a24YW45u2eC8yDE5GQMq2hsGdR7irOrxKkUr6pk8LhX3M59diD-67w>
X-ME-Proxy: <xmx:a24YW-yZICe1xkE4IzKSnPRz2Lo_UVnA282antvRiOCP9qgUXHqvdQ>
X-ME-Proxy: <xmx:a24YW_PL1oRsyGFOSVIWSyqyygANfCmUmnubmioEvFkr5kEyFOIYyw>
X-ME-Sender: <xms:a24YW1Eiy2yK1v7esAQPXhpRPyEp4Nu4kc7HMFyoDjiuW6t9ETn9HA>
Received: from localhost (124-169-155-53.dyn.iinet.net.au [124.169.155.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0C1CDE41E6;
        Wed,  6 Jun 2018 19:29:46 -0400 (EDT)
Date: Thu, 7 Jun 2018 09:29:43 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 0/4] enable early printing of hashed pointers
Message-ID: <20180606232943.GA21148@eros>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
 <20180531145253.02daa5d4@vmware.local.home>
 <alpine.DEB.2.20.1806051621070.2789@hypnos.tec.linutronix.de>
 <alpine.DEB.2.20.1806061504130.2718@hypnos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1806061504130.2718@hypnos.tec.linutronix.de>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:08:25PM +0200, Anna-Maria Gleixner wrote:
> On Tue, 5 Jun 2018, Anna-Maria Gleixner wrote:
> 
> > On Thu, 31 May 2018, Steven Rostedt wrote:
> > 
> > > On Mon, 28 May 2018 11:46:38 +1000
> > > "Tobin C. Harding" <me@tobin.cc> wrote:
> > > 
> > > > Steve,
> > > 
> > > Hi Tobin,
> > > 
> > > Sorry for the late reply, I'm currently at a conference and have had
> > > little time to read email.
> > > 
> > > > 
> > > > Could you please take a quick squiz at the final 2 patches if you get a
> > > > chance.  I assumed we are in preemptible context during early_init based
> > > > on your code (and code comment) and called static_branch_disable()
> > > > directly if hw RNG returned keying material.  It's a pretty simple
> > > > change but I'd love to get someone else to check I've not noob'ed it.
> > > 
> > > I can take a look, and perhaps do some tests. But it was Anna-Maria
> > > that originally triggered the issue. She's on Cc, perhaps she can try
> > > this and see if it works.
> > 
> > I'll test it today - sorry for the delay.
> > 
> 
> I tested it with command line option enabled. This works early enough
> because it works right after early_trace_init().

Awesome, thanks Anna-Maria!

	Tobin
