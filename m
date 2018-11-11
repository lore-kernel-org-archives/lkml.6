Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7435C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F4620866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CmY0bn7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F4620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeKLAyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:54:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeKLAyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0ovwV35Xn0e0qGMt+qUC2132b33I1s8tGmrH3ihBEv8=; b=CmY0bn7qzTsuSq+yYNo/A0Uck
        CFdb3Ux7TU2WaRjCk5UiLI00RvzqvSwQsb6japUhYGLGmtln4DWKQEaaARM6F+/DXbNT/7W27ugaY
        9xg4UdXREN4Xj3XwYkxbW3SxTFcWSognXzIhiu0yb/WRlUsvQgIybl/EXsePSWPMaDY/AwZSMhCtS
        EEWk9EV1QRuNetlrLWIr3yxge3B5Hnj5ZV6gaZbaDU6jIBI7XkfB/kyrLHK7N40WNwjDRAkeBjZU2
        Tg4jIMmNcr7kWC8/oacdJgWln+SUBQkiFcMPkU4hFlvgtkNu6mTBTa8mEoL+Nu5vCJRdRFiZgJujV
        J0LX18KSw==;
Received: from [64.114.255.97] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLrJC-0003Rl-Mn; Sun, 11 Nov 2018 15:05:54 +0000
Received: by worktop (Postfix, from userid 1000)
        id F09876E03B0; Sun, 11 Nov 2018 16:05:53 +0100 (CET)
Date:   Sun, 11 Nov 2018 16:05:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 09/10] x86/jump-label: remove support for custom poker
Message-ID: <20181111150553.GB3021@worktop>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-10-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110231732.15060-10-namit@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 03:17:31PM -0800, Nadav Amit wrote:
> There are only two types of poking: early and breakpoint based. The use
> of a function pointer to perform poking complicates the code and is
> probably inefficient due to the use of indirect branches.

Right; we used to have a 3rd way, but that is long gone.

Nice cleanup!
