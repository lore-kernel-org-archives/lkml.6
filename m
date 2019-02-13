Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2893C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E660222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550044484;
	bh=nAs1znfgXCNC7pOnW/bPVF86SyyDLLj1Lumugf6VPy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LJ5rC6Y8GgHhA0xoAJaO0Jj3Y6m2GEza22T2yJzkOyTd6EGGQOS9Zlr5QwI++Fs1C
	 l6YvyrbFAAgAjhN1/KJEFBEFMMoQBx1VptbajAhZ7r+l3oZTmvSlQ12/VVct+AQVUU
	 OHLEl03GQPRQ8q9vg+jzroCeoWTAjbzMHasVF55s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbfBMHym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:54:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45184 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfBMHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:54:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so1297682wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RwAZVk/ymJ6eVsNECuYJw8phNbIcdwJvFYWEgKleoco=;
        b=c04t5D5HJ+QqcRZrm+GfOPCcEd48mUPDF6Tqw4ODFZr5UpVJ4VEJxz42xnnysHnkXY
         86DMcJ1Rqh+ouRX2UmgZJo6iGj4jHCsIJ5jYp8x+yKmy5ufUXapH9a0vwh4wAJq9hh/d
         RqoJzgTNUcmem5eSEpWmS+YwfIUjGfuVDAeeIk2vgpp2DqCSq97laStNd+bjtYwhdc9y
         w9OlkTbEp9UBYJYvlY64XqOu7H2E874GhzWStX4XPeBinmwynvaY+4WSpZZEBviNVaNL
         LTvuHssQKRtH2W1ZgozyKv7x0oqfyzZUTFxnDZg7U7WEzliiubSH+mWvk5HxYtlp70Xy
         WgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RwAZVk/ymJ6eVsNECuYJw8phNbIcdwJvFYWEgKleoco=;
        b=WRhWhV0CwDkbeminu5XOnm5DOOiWB2oYZh12B+kH8Rro8Z+s5S+0C1FLbxtz0iLXph
         zQcY0upqtckHfeC/dl4+tZkj9Drxf7KYwypet6z+KdINl1/2JB+CDJaztIYEEa6qutu8
         PqMjNvqJy6nEBEAF7r6247rcYnHawD8oeC3bRj4pmqefXxYHMWICA5rdY3Zghz1s10TP
         atfxMzFoLOXw7OtVfHQJJlIPHMuLs5q1zRDX1IoUMENj026yK8yXiDMWe2Ujbk5LiFP8
         RMH+Z0n1rbAtYosoRLTdVfOWUP10wQrhHq3dVyUdgtniJYjnqtqdVb9eNbU31mWkzOU+
         8gcQ==
X-Gm-Message-State: AHQUAuaUJlz1Xz8oKdtM5wVoMoVzQkjrUvjaolw7pAw59xGZ2c2umjlL
        +by2YGhgVUBkT5Ev7nD/J28=
X-Google-Smtp-Source: AHgI3IZU6pWKPxdME/mJkz8YKCixNXLIgKmyP9YhxkLtS/hWKtbbQSYwjiNUfZWrxYnBW79/WNA20w==
X-Received: by 2002:adf:de83:: with SMTP id w3mr5715315wrl.56.1550044480595;
        Tue, 12 Feb 2019 23:54:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v19sm258833wmj.36.2019.02.12.23.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:54:39 -0800 (PST)
Date:   Wed, 13 Feb 2019 08:54:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/atomic_t: Clarify signed vs unsigned
Message-ID: <20190213075437.GA101458@gmail.com>
References: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> 
> Clarify the whole signed vs unsigned issue for atomic_t.
> 
> There has been enough confusion on this topic to warrant a few explicit
> words I feel.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/atomic_t.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index 913396ac5824..dca3fb0554db 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -56,6 +56,23 @@ The 'full' API consists of (atomic64_ and atomic_long_ prefixes omitted for
>    smp_mb__{before,after}_atomic()
>  
>  
> +TYPES (signed vs unsigned)

s/vs/vs.

> +-----
> +
> +While atomic_t, atomic_long_t and atomic64_t use int, long and s64
> +respectively (for hysterical raisins), the kernel uses -fno-strict-overflow
> +(which implies -fwrapv) and defines signed overflow to behave like
> +2s-complement.
> +
> +Therefore, an explicitly unsigned variant of the atomic ops is strictly
> +unnecessary and we can simply cast, there is no UB.

s/UB/Undefined Behavior

Had to read that twice. Acronyms Seriously Suck.

> +
> +There was a bug in UBSAN prior to GCC-8 that would generate UB warnings for
> +signed types.
> +
> +With this we also conform to the C/C++ _Atomic behaviour and things like
> +P1236R1.

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
