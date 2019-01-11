Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20607C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E659F20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547190581;
	bh=1DkYafFXfMIX69gNMzX0Yy9uyrr7GLTYTIJyItOnrks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=umfHlxL/HkQgLfTVFjzpgJw72/kqJhRxjpUdxe7DDMAlTCvpdvZWXGg9BjvOA9Ndw
	 ruT34tknpNzi9hAuIOZ9aP47WacacnY6u01ETrCKSz5+2aG85KM892jsLp4iSXDDca
	 AzYiN0ZG2mEwrJ54E+5eprR5tTv90w2zzJX8oEnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfAKHJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:09:40 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36145 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfAKHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:09:39 -0500
Received: by mail-wm1-f53.google.com with SMTP id p6so1287688wmc.1;
        Thu, 10 Jan 2019 23:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yXXJR2k7BkPE9cXHh5TruFsxgDYpyyyhOKTAXbRFNME=;
        b=YHuz5CRxpgjbh/4bMoV5YMoV4lHCV32OXVI0MfKMFb0KDspNyfd1mT6sSPmAyZjZKw
         ZwjmAjdRgwFXDo3V6E2JrQBEiJueJ0apvLHAaOiC8TMIO+YWiLTPWRAFlUwG0i0ibE25
         lrLZJDBcVZxrhwbi890DPOcIYkEVahc1fPg4hJU+K+ifoM2aBEvSujj0AWu3EM50dCPc
         wTumQsTDTQG6+SYQ9iIDDxDZT08SZ/EweuXJIV6LTPdqp3R0zDFSeiEPW8XjbZT2CsJh
         POfKb6b2qWcxiUQ0zJQlwza3G0TQbFnAMFB0i4UFqfqa0l4W3omj7qJX6AmOklg3yyCL
         VVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXXJR2k7BkPE9cXHh5TruFsxgDYpyyyhOKTAXbRFNME=;
        b=O59x7PoGb0nr2YwX2CRQzWHUexzpng3/93BIKai3W1ebsWjtZ4OqbuxUvdumqDq7g2
         fVIpv2zvlkv3/bth00L8ySYFfgB2bD4GJy3LXLSn/pZ2qUnqFyFxWLoSXGNkAf/OSFcH
         H+Dt7hiZ95f8p57r0xw43EzLb9IcsY06xLlQoZ8FU0nndg5gabGY+cXsl3VzZvidXPsT
         zFihtXYR3IEpEC2md8UnkJn1sEOnRClC3KMtGOGVpUhuAIHXw7RqAGNVHcxGZWnENbfs
         MWOHNtKwogCpbM2la4/V5fg5ul8EL3b3Wg9PIras9/+7pvs4KniEz1zlKkAh+WJtPePg
         5mCg==
X-Gm-Message-State: AJcUukdMPTu4EXR5JIQGgn58J8o3VXsVe3a+O53ipheoQtitzhX0pPVX
        nWCtbp3thq2SdJsvHgMTkuI=
X-Google-Smtp-Source: ALg8bN7ND50Qul7gnmerUDxxDUeC+jrZwzswChxXpKkQIZLF7mp1c+UMXYjW90ShUEE1gxlCtifhyg==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr1070958wmi.37.1547190577942;
        Thu, 10 Jan 2019 23:09:37 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 143sm33143526wml.14.2019.01.10.23.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 23:09:36 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:09:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] seccomp: build fix for v5.0-rc2
Message-ID: <20190111070934.GA92116@gmail.com>
References: <alpine.LRH.2.21.1901090803120.24546@namei.org>
 <CAGXu5j+wvi9t-oHf4cX999aYWMhmTJ1zA1mKuNQEB_n5ixiC5w@mail.gmail.com>
 <20190109065916.GA29753@gmail.com>
 <20190110031839.GD28330@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110031839.GD28330@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tycho Andersen <tycho@tycho.ws> wrote:

> On Wed, Jan 09, 2019 at 07:59:16AM +0100, Ingo Molnar wrote:
> > 
> > * Kees Cook <keescook@chromium.org> wrote:
> > 
> > > This was already picked up by x86-urgent...
> > > 
> > > -Kees
> > 
> > I'm fine with both routes - if Linus pulls this I'll zap the x86/urgent 
> > one.
> 
> The patches are different actually. I've confirmed the one in
> x86/urgent is correct, and this one is from the initial thread where I
> was just guessing. The difference is HOSTCFLAGS vs. HOSTLDFLAGS for .o
> files. So I think we should drop this and just keep the one in
> x86/urgent.

Ok - will send this to Linus now.

Thanks,

	Ingo
