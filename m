Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF3C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F2C214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547017162;
	bh=A9w0LPu83gBFePHY+iqmHc55cvLL7i6bwgBMqxeWnEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHYf17wzr27VNe/dej03aZyHlFIgqjgY/+vKmRa3DAumqb1D4yBIywkfoetXmfQE+
	 D4zPz0vkKAvIfVwuPlv2xbYDzij0LvLov51O6+fGMvIbpjGF1h30jOGerbEk5oC7u2
	 wnFBG/LI0u2YEsOWgkWxMYkXwl3h+K4AnAR4752U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfAIG7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:59:21 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37436 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfAIG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:59:21 -0500
Received: by mail-wm1-f54.google.com with SMTP id g67so6886602wmd.2;
        Tue, 08 Jan 2019 22:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=27G32GgIx1P/0mBxkoRYgIgE3vqJB/3jc9Xyom0KbZA=;
        b=IljnuDGyGSzzQmeyMLa5yReVOhkD+jUUacNI/l/6Ols+83XtuHNF9Hq9J+u+r1CeJ7
         8NNTlLQdz9TkER73ESH0gGzsZODuRN36nvAmDj7Chtn7FHT3Gi+R08jnR3ixlhu/Q8U0
         3Fvn2IzKuQ9k8jbDyeH13BMg9spJ9MrQ0B06Xb5gGRB/xxPqttqucX6w0PkuT3msg5oF
         agbfsBra7s7pZUbpaTCCGOxJG72cu0DhyYeLzYC2rJpI3WGbmKymeiYj8ntdhlpDvMwc
         gxYKRJYuzMsgvihTpv63fyEBmhaJpZ/mL+t5u4x/yDrZyZSx6q6yrw1Bu96Mt4oFsx1g
         p/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=27G32GgIx1P/0mBxkoRYgIgE3vqJB/3jc9Xyom0KbZA=;
        b=WQouZCaMjeoni1paQoHyHc0a5rrs5B+0lkjZ6ccrhGHXgj5qpIrsobC8wcuK/OP0jc
         0nTfBf8ZSud0n6BBwFtJE5WVU5t6YcKw362zL3eHCYH9xhPjZZCyfSC9os6OrgAMstE7
         MVDwoE+dR/sYMKamUBs0qSYd0yBboSMMRIraooipk2v2+pm6mKdXQmPAjirihnF60B0n
         MftN9v+ScN0U4u78sjvydpSMLjejGqn5g52Mbpx+sYLhA5Xs8AOLdMjJelNP+yVu5tkv
         GkyDEgd/cQ4PDoXrDvYiHLiFU5y/RJm2m6vn/jt5u+wlrWajrmESla3NtgpOY2xs1Rna
         g66g==
X-Gm-Message-State: AJcUukc8hvyK9HgKxvZujnDTjdFdkSu/OwsNnPS/5/XUyZvWUxzIzMJR
        /jDtEkjbRMvvXTVTug0g5L0=
X-Google-Smtp-Source: ALg8bN6pFIbPrOLmsxsCjT3YBjGE0pEpmbiUgbZ80en+hlOObuTnhlEDpP8z3Ci70FEdo+uAz2EcwA==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr4111866wmc.21.1547017159445;
        Tue, 08 Jan 2019 22:59:19 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i192sm10535496wmg.7.2019.01.08.22.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 22:59:18 -0800 (PST)
Date:   Wed, 9 Jan 2019 07:59:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] seccomp: build fix for v5.0-rc2
Message-ID: <20190109065916.GA29753@gmail.com>
References: <alpine.LRH.2.21.1901090803120.24546@namei.org>
 <CAGXu5j+wvi9t-oHf4cX999aYWMhmTJ1zA1mKuNQEB_n5ixiC5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+wvi9t-oHf4cX999aYWMhmTJ1zA1mKuNQEB_n5ixiC5w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> This was already picked up by x86-urgent...
> 
> -Kees

I'm fine with both routes - if Linus pulls this I'll zap the x86/urgent 
one.

Thanks,

	Ingo
