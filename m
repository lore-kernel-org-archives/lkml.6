Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94486C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3A22084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544521386;
	bh=aIcEkkhNlcKbrQBNe9VU1OQXv8faUp2xmhrX9FJeFRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zh+3O3afXD+Nvfp63Zuy8mAQUL8UIUCZEuuXh0+NVK4831Wqx6qDUao2HsJh++elL
	 dJRlyvUJaSsyXiHf60bB/W/pXyITUZSegg3c3vXcKXBQtoLOqvppJkio2nGY6bvRxB
	 NK8jv+GXz+9bAgYvUQOMqOxlLGexTm2vLWDCyDmo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3A22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLKJnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:43:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKJnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:43:04 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BDB20811;
        Tue, 11 Dec 2018 09:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544521384;
        bh=aIcEkkhNlcKbrQBNe9VU1OQXv8faUp2xmhrX9FJeFRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ywJOsOjROIeudqZs4fB1TMHFPBUkPFSC26CrYrUgLO6LGZ0lT9h3ZFOynvRc9kSHT
         Z2CLFbymuRh+MbG+ej/DTQlt796CrmuL+AQNdSvemNUq7Xn+PmvQrzWtr1aUfiW+1y
         rxrlNd5t++ehpKYW5SHKW8nBwK9v+zB/9FCfNfg8=
Date:   Tue, 11 Dec 2018 18:43:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes/x86/xen: blacklist non-attachable xen interrupt
 functions
Message-Id: <20181211184300.810577f6087339bb0781068c@kernel.org>
In-Reply-To: <20181210151256.GA1977@Dell>
References: <20181210151256.GA1977@Dell>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 16:12:57 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> Blacklist symbols in Xen probe-prohibited areas, so that user can see
> these prohibited symbols in debugfs.
> 
> See also: a50480cb6d61.

Looks good to me, thanks!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> ---
>  arch/x86/xen/xen-asm_64.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
> index bb1c2da0381d..1e9ef0ba30a5 100644
> --- a/arch/x86/xen/xen-asm_64.S
> +++ b/arch/x86/xen/xen-asm_64.S
> @@ -12,6 +12,7 @@
>  #include <asm/segment.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/thread_info.h>
> +#include <asm/asm.h>
>  
>  #include <xen/interface/xen.h>
>  
> @@ -24,6 +25,7 @@ ENTRY(xen_\name)
>  	pop %r11
>  	jmp  \name
>  END(xen_\name)
> +_ASM_NOKPROBE(xen_\name)
>  .endm
>  
>  xen_pv_trap divide_error
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
