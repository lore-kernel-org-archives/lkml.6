Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B00C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A19C20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfEyRic7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A19C20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJHVNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeJHVNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:13:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA5122077C;
        Mon,  8 Oct 2018 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539007273;
        bh=8BLk2tgEXubovYTyC7avk28+CpQaTO1MoUdo7G0eSGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfEyRic7tJDmK73Sd4RE9mYg7NVGp6N5mBk359DKCfsi0dsCEMQkbEdjmBwCxvnFs
         XccMJGyRWWwGxIoQgmgW+i5HnS1f/U7L0XzZSjwXKa+cO7XjfzymFqssmRpUdld+Ge
         2S17KE/bLaCcUN+2gSqBe9xE+xJW8UNKPl8T3xzY=
Date:   Mon, 8 Oct 2018 15:19:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/defconfig: Enable CONFIG_USB_XHCI_HCD
Message-ID: <20181008131944.GB20703@kroah.com>
References: <20181008103223.15362-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008103223.15362-1-kilobyte@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 12:32:23PM +0200, Adam Borowski wrote:
> A spanking new machine I just got has all but one USB ports wired as 3.0.
> Booting defconfig resulted in no keyboard or mouse, which was pretty
> uncool.  Let's enable that -- USB3 is ubiquitous rather than an oddity.
> As 'y' not 'm' -- recovering from initrd problems needs a keyboard.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  arch/x86/configs/x86_64_defconfig | 1 +
>  1 file changed, 1 insertion(+)

defconfig for x86 actually still works?  That's amazing in itself :)

> diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
> index e32fc1f274d8..ac9ae487cfeb 100644
> --- a/arch/x86/configs/x86_64_defconfig
> +++ b/arch/x86/configs/x86_64_defconfig
> @@ -243,6 +243,7 @@ CONFIG_USB_HIDDEV=y
>  CONFIG_USB=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_MON=y
> +CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_TT_NEWSCHED=y
>  CONFIG_USB_OHCI_HCD=y

You can probably turn ehci and ohci off if you have xhci in the
"default" system now.

thanks,

greg k-h
