Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48230C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1682720844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549872037;
	bh=/fue+IZdfcxP+eVkJkwPCGm3BkCkxvRHOx7aA6QpFE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LblRl3fVA121OMJfbHMVVWyAWW8D/enm2HSf9X0V5FZrsSSMO7wZUIAfDlTE8ieIq
	 +T/VnR3UAxm+Zq9cTduqXJ1kApC152XQ1D7EZi4uIqkvsuMFLJM8enAD0wKP2pGgfL
	 WztHz5CPJL3QKn+QAAqgBRthEcHrLRgDrC8G4XZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfBKIAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:00:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34277 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfBKIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:00:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so13694749wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O1mZo6ozYXkjYdVu0bH8stA7+ruMRPCK+fn6qQLL0rg=;
        b=dwLdja1gRhd8LghSaTNewXcndglCHAuK4dxASnLvJ/k3yH63RP4iXRA8nQRuvHkId9
         Te3hHhAdv3/f54hwNjXuuusCzH74P/gONwIMBnxhODmePysuYWARpU8XCYtOe1TsnIuT
         Ivt6CrbX8epBSpsBPrIUkmLSRS/CF1rA3x5/RHDVQPVH7lEOdK4z655n7GBSJUS2w9iq
         5Vwk9srLPpLSCGrnnewvWzShMW3SMKT2pdSQPwhM16nF4Qx1MhN12NFlLeTpV7FCoAWm
         pQGU5Kylp4MfQWIwtzuSqr0Ew5qByQSVQBN2llTEvjZr6OwkSjIK+lrll2tBWT0BEQkq
         rRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O1mZo6ozYXkjYdVu0bH8stA7+ruMRPCK+fn6qQLL0rg=;
        b=IgcenecQpCBr3tbP4vzeC2Z3WCyQiZOPoH3gH8h01ix4LzBGDrF3LjLFUA8xklacLn
         rOVbAxucBp0ElL3cQzyG8tvmF2rVLqeKjr9BX/0x2SsradDAXPSy3QxDeXhuUEZozc+0
         iPlUTETCALGCxi+v6UoStoX/JtnS2mFWg9eITewZHKeLnCL5QxELp/bExhJxXzsui3LY
         Oxm9btV/TV6jNvCq1l2GxJ51voRHd9aI9nHW2eKieabxXzURRA5b4uOsvyGFl02PhZiA
         p/ThXpNzVdY26mBRgkbJNm0xyg46w5mtBvFEJDVClrKm6UGSrGNMZb8UQGaxkw08nZbm
         +Z1A==
X-Gm-Message-State: AHQUAubfENAHtskWAXfDyd71ABocTKWIgdmsPA5vLMykVEPVsjuOawsw
        zlcCmkYQLBPgVQt4sxeu/C0=
X-Google-Smtp-Source: AHgI3IZ2O7+bzDg+hLb5dfjVfCzINFwezjABdRsjU9kjyOP23jTjDryEBIfs19UjAyIKyKukLjdNBw==
X-Received: by 2002:a1c:342:: with SMTP id 63mr7873909wmd.34.1549872033203;
        Mon, 11 Feb 2019 00:00:33 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q9sm5661350wrv.26.2019.02.11.00.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 00:00:32 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:00:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86_64: tidy up KASAN_EXTRA
Message-ID: <20190211080030.GA80948@gmail.com>
References: <20190206045657.76020-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206045657.76020-1-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Qian Cai <cai@lca.pw> wrote:

> The commit 585a4c1f9978 ("kasan: remove use after scope bugs
> detection.") removed KASAN_EXTRA, so tidy up leftovers.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/include/asm/page_64_types.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index 0ce558a8150d..8f657286d599 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -7,11 +7,7 @@
>  #endif
>  
>  #ifdef CONFIG_KASAN
> -#ifdef CONFIG_KASAN_EXTRA
> -#define KASAN_STACK_ORDER 2
> -#else
>  #define KASAN_STACK_ORDER 1
> -#endif
>  #else
>  #define KASAN_STACK_ORDER 0
>  #endif

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
