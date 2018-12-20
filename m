Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CD2217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbeLTODT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:03:19 -0500
Received: from ms.lwn.net ([45.79.88.28]:53184 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732864AbeLTODT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:03:19 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A2530182;
        Thu, 20 Dec 2018 14:03:18 +0000 (UTC)
Date:   Thu, 20 Dec 2018 07:03:17 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hunter Lannon <kindlehl@osuosl.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Easy Kernel Patch
Message-ID: <20181220070317.5403f546@lwn.net>
In-Reply-To: <CAPdqyfnAJf1dMCAL4SFFM40p_zn5tmUTkdfvVknCHeGLSUEPLQ@mail.gmail.com>
References: <CAPdqyfnAJf1dMCAL4SFFM40p_zn5tmUTkdfvVknCHeGLSUEPLQ@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 22:47:18 -0800
Hunter Lannon <kindlehl@osuosl.org> wrote:

> This is my first patch submitted. I hope I can finally say I have a
> commit in the Linux source code :)

I expect you'll get there, but this patch won't be the one that crosses
the bar for you.  Here's some suggestions for how to do it successfully
next time:

 - Read Documentation/process/submitting-patches.rst all the way through.
   There's a lot of information there that would have helped you to avoid
   the errors made here.

 - Use scripts/get_maintainer.pl to be sure that you direct your patches
   to the correct maintainer(s) and lists.  A patch just sent to LKML is
   unlikely to come to the attention of the people who need to see it.

 - Please send patches inline rather than as attachments.

With regard to the patch itself:

> From 1ce6365d07c734cea9965d3135dd64e2641021ef Mon Sep 17 00:00:00 2001
> From: kindlehl <kindlehl@osuosl.org>
> Date: Wed, 19 Dec 2018 22:36:22 -0800
> Subject: [PATCH] Removed twin forward-declaration of struct device

Patches should always have an informative changelog saying *why* your
change improves the kernel.  Removing a redundant declaration certainly
does that, but you need to say so.

> Signed-off-by: kindlehl <kindlehl@osuosl.org>

The signoff line needs your full and real name.

> ---
>  include/linux/pm.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e723b78d8357..d33147db9400 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -51,8 +51,6 @@ static inline void pm_vt_switch_unregister(struct device *dev)
>   * Device power management
>   */
>  
> -struct device;
> -
>  #ifdef CONFIG_PM
>  extern const char power_group_name[];		/* = "power" */
>  #else
> -- 
> 2.19.1

Fix those up and submit the patch properly, and I see no reason why it
would not be accepted.

Thanks for working to improve the kernel!

jon
