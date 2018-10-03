Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FBEC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9547213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXZ0NKdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9547213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeJCOjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:39:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54764 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJCOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:39:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so4684455wma.4;
        Wed, 03 Oct 2018 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0BXvJoixoQPY3vUjrygvnNB0S4N2O8vQDKpOru/C0ts=;
        b=tXZ0NKdg8JIkKf2I26Gl7q/l1PUkjtUvnhorh0j1WeizJH56oXJKem9GHZxx3UuHDz
         l9Nl9n7qUAy1zjNtIUgL0NBZV5zF5e00WfzX/UOZhFT9PVLVYQgVYigu/oTJPZDPpaTG
         upXdc0hG6vSKs86351ZsOFJoJFP/pZMhsvU85k3/ZYh1LCkzEqTsDsHlSYkhd2exs2mf
         JVvvSBhl7kgHa9IMNYbMR3bBHfkLTBFPvJXHQIef+aVT4uiGEbeyyCUhlFOrenFZ/pNu
         kgtHnZ3L+piEEYYiSotyPdj/w6T2+3mwdHx8fWm43slvhTwJk1/53NIc3HAiwVBqs3Cb
         xfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0BXvJoixoQPY3vUjrygvnNB0S4N2O8vQDKpOru/C0ts=;
        b=uZj5vsfFW+n+Rm6NI1vnMvd65QQSIAUM7xtUZ3/VrFLAkvUVkZSivVeOJl3dXUOkBe
         gUlzih4g52QsisEWD3CEMCq8YbiotsIrUEm7CxM/Kx1TWuARTQIm0CqEW66CAMej66Dn
         E87n/d3yHKgALYkavao8Hs7F9McqVl2xjFayP/6hlVyblNhDS11AYbPTiUte05/lkbTw
         XU6Q7+QO2MqpfdYV8rDB4p+RY2PrwYVkq+Cir/GT3f1kVggd0L8vzUDvj+yyeJYeM/3e
         gd2KI0m22QSAlc0F3eJbkmLuY+xydmcSWxfoz8EmRhk7tSsp0qYc9UhUpn3VtxXCzcae
         0sDg==
X-Gm-Message-State: ABuFfojnxsPW8+4diPvjHCWe0f2j0FA7nKlyOBY1eiJKqtyIrcjt8Dn6
        i2J4uOjEpjUKY0ishX+x+Lk=
X-Google-Smtp-Source: ACcGV629TAmvFRADUHzqyfrgiQOxEsRJDRZIu/pLBlPV2k85r/D89rl0ewZCSYU4wUtcj7e1789vHA==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr552784wmh.124.1538553148395;
        Wed, 03 Oct 2018 00:52:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e67-v6sm1111722wmd.41.2018.10.03.00.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 00:52:25 -0700 (PDT)
Date:   Wed, 3 Oct 2018 09:52:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, thgarnie@google.com,
        corbet@lwn.net
Subject: Re: [PATCH v2 1/3] x86/KASLR: Update document about KERNEL_IMAGE_SIZE
Message-ID: <20181003075223.GA3029@gmail.com>
References: <20180926235823.3567-1-bhe@redhat.com>
 <20180926235823.3567-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926235823.3567-2-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> Currently CONFIG_RANDOMIZE_BASE=y is default set, update the relevant
> document about KERNEL_IMAGE_SIZE.

Suggested wording:

  x86/KASLR: Update KERNEL_IMAGE_SIZE description
  
  Currently CONFIG_RANDOMIZE_BASE=y is set by default, which makes some of the
  old comments above the KERNEL_IMAGE_SIZE definition out of date. Update them
  to the current state of affairs.

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/include/asm/page_64_types.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index 6afac386a434..2288ceabdb9c 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -61,9 +61,10 @@
>  /*
>   * Kernel image size is limited to 1GiB due to the fixmap living in the
>   * next 1GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S). Use
> - * 512MiB by default, leaving 1.5GiB for modules once the page tables
> - * are fully set up. If kernel ASLR is configured, it can extend the
> - * kernel page table mapping, reducing the size of the modules area.
> + * 1 GiB by default, leaving 1 GiB for modules once the page tables are
> + * fully set up. If kernel ASLR is not configured, it can shrink the
> + * kernel page table mapping to decrease the size of kernel area to 512
> + * MiB, increase the size of the modules area to 1.5 GiB.
>   */

I've prettified that comment some more:

 /*
  * Maximum kernel image size is limited to 1 GiB, due to the fixmap living
  * in the next 1 GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S).
  *
  * On KASLR use 1 GiB by default, leaving 1 GiB for modules once the
  * page tables are fully set up.
  *
  * If KASLR is disabled we can shrink it to 0.5 GiB and increase the size
  * of the modules area to 1.5 GiB.
  */

>  #if defined(CONFIG_RANDOMIZE_BASE)
>  #define KERNEL_IMAGE_SIZE	(1024 * 1024 * 1024)

BTW., while at it, shouldn't we make that:

   #ifdef CONFIG_RANDOMIZE_BASE

?

Thanks,

	Ingo
