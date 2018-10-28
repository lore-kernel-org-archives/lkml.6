Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D33C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DB020843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DB020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJ2Cyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:32928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeJ2Cyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:54:50 -0400
Received: from vmware.local.home (unknown [95.87.249.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A072082D;
        Sun, 28 Oct 2018 18:09:23 +0000 (UTC)
Date:   Sun, 28 Oct 2018 14:09:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
Message-ID: <20181028140911.21d49629@vmware.local.home>
In-Reply-To: <20181028130945.23581-2-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
        <20181028130945.23581-2-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018 13:09:42 +0000
Changbin Du <changbin.du@gmail.com> wrote:

> The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> So declare check_la57_support() as inline to make sure the code
> referring to level4_kernel_pgt is optimized out. This is a preparation
> for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>  arch/x86/kernel/head64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 5dc377dc9d7b..5ae682f2aa83 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -98,7 +98,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>  	return true;
>  }
>  #else
> -static bool __head check_la57_support(unsigned long physaddr)
> +static inline bool __head check_la57_support(unsigned long physaddr)
>  {
>  	return false;
>  }

