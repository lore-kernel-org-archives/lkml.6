Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3009BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97FF208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra+uOmMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97FF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeJPOOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:14:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39300 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeJPOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:14:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so21820718wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DM9zYIVpkZAIfc8YobApt6ydPWGh5zutXIAa16u1t1w=;
        b=Ra+uOmMpNeU0+d51cciExVjP12qFZBkqezFoGhdx/8Y9/AkC628XNBwyCQedfKQ7Wj
         w17HRh7p50h6XbTXZmwgKxtiy/8bYUnSHP4MPdK7HSHvT/9yIZ6zdPHx4M6VHitbZGhZ
         VpLJYm9Vt57QAGRVwls1gToI+Np2qHPmtM1608mXLnSbQgXI3jBU52Fu5CxFbspqbTuV
         8TAOmeGdBpz3PjBAPBoGCiqMCWlrdtMF5DGr5wsqQWo0ZgDaXrLuFm0i8Acz02JnnnM3
         ikJ2tAkhT9pBorcICYFjWzeFBpEi1wl9SCniae0/Xu0JwrddegNFS+UK53aiWN1oGgv6
         x4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DM9zYIVpkZAIfc8YobApt6ydPWGh5zutXIAa16u1t1w=;
        b=dNXHpI9pQRhannD5ASI3VKOejylzxW05kgBI4AgyVfqL2rYi2FjXsCpinX95MK70Ba
         +O/XczfLLGjPX8ak6kTyW9FA3bTln+l+f4iRQxx+LaOwBuFaY9A/LbuB4Y1tWvzYoVe1
         nAZQuNNDcJZ+yIG4umSuV7A9Z/MIOtvpMrUaBcx8KPEPiyISlIxJ6XL0G1LTYXs/Fp1n
         8bH12c1qezdqZH9r88VtZpOxQxeOONrwUBdJtQPNGA2oMkMPLnqIbhArZcOPqeWKFf3Q
         0TNtQsrLdWNpuRDoSlNM+hMXzzBRgcBpl79cxqG5KO6bD850Cql6rXzjXb1//Qsq6+du
         S30g==
X-Gm-Message-State: ABuFfogVFGnChzo+b62P+ir9fgS8SBNzwT9jA7vkOdzKwe0vmBG/7VjH
        NAwQOFRmtvgoVwbUbLBDoXE=
X-Google-Smtp-Source: ACcGV60sLsPAqLws87MTMK/0rC8oiskhsAIajVy3VQnQOUbOailjD5u4KBgVRn2vDLFkjmAk2LnBOA==
X-Received: by 2002:a1c:d105:: with SMTP id i5-v6mr14855683wmg.69.1539671159179;
        Mon, 15 Oct 2018 23:25:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r8-v6sm11119066wrm.14.2018.10.15.23.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 23:25:58 -0700 (PDT)
Date:   Tue, 16 Oct 2018 08:25:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH] x86: modify inline asm constraints in __cmpxchg_double()
Message-ID: <20181016062556.GA56841@gmail.com>
References: <20181015084802.30934-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015084802.30934-1-jgross@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> Some gcc versions seem to have problems with the constraints in
> __cmpxchg_double() as they suddenly issue a build error when random
> parts of sources calling __cmpxchg_double() are modified, like e.g.
> slub.c. This has been observed on Debian systems only so far.
> 
> Using "0" instead of "a" in the input constraints has the same
> semantics while avoiding that build error.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> I should note that I have observed gcc hangs instead sometimes. Not
> taking any patches modifying users of __cmpxchg_double() due to a gcc
> bug which seems to be distro-specific is a bad move IMO.
> 
> I'd rather make it clear from build behavior that this is a bug in gcc
> by letting the build hang instead of throwing error warnings not in any
> way related to changes in the code.
> 
> The gcc bug is filed under:
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908154
> ---
>  arch/x86/include/asm/cmpxchg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
> index a55d79b233d3..b3b4d61a8969 100644
> --- a/arch/x86/include/asm/cmpxchg.h
> +++ b/arch/x86/include/asm/cmpxchg.h
> @@ -245,7 +245,7 @@ extern void __add_wrong_size(void)
>  	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
>  		     : "=a" (__ret), "+d" (__old2),			\
>  		       "+m" (*(p1)), "+m" (*(p2))			\
> -		     : "i" (2 * sizeof(long)), "a" (__old1),		\
> +		     : "i" (2 * sizeof(long)), "0" (__old1),		\
>  		       "b" (__new1), "c" (__new2));			\

This got changed to +a in -tip:

  c808c09b527c: x86/asm: Use CC_SET()/CC_OUT() in __cmpxchg_double()

Mind sending a patch on top of -tip?

Thanks,

	Ingo
