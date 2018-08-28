Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1988C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D31208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D31208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH1JC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:02:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1JC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:02:59 -0400
Received: from localhost (smbcdgpass.hotspot.hub-one.net [213.174.99.145])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 86837891;
        Tue, 28 Aug 2018 05:13:04 +0000 (UTC)
Date:   Tue, 28 Aug 2018 07:13:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, stable@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/irqflags: mark native_restore_fl extern inline
Message-ID: <20180828051300.GB2107@kroah.com>
References: <20180827214011.55428-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827214011.55428-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:40:09PM -0700, Nick Desaulniers wrote:
> Fixes commit 208cbb325589 ("x86/irqflags: Provide a declaration for
> native_save_fl")
> 
> This should have been marked extern inline in order to pick up the out
> of line definition in arch/x86/kernel/irqflags.S.
> 
> Cc: stable@vger.kernel.org # 4.18, 4.14, 4.9, 4.4
> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/x86/include/asm/irqflags.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index c14f2a74b2be..15450a675031 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -33,7 +33,8 @@ extern inline unsigned long native_save_fl(void)
>  	return flags;
>  }
>  
> -static inline void native_restore_fl(unsigned long flags)
> +extern inline void native_restore_fl(unsigned long flags);
> +extern inline void native_restore_fl(unsigned long flags)

This looks odd to me, but my coffee hasn't kicked in yet this morning.
Why do you need both lines here?  Shouldn't the actual function be
sufficient?  If not, a comment explaining this would be nice.

thanks,

greg k-h
