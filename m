Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CA120855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="x6WZj4Ci";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vjS8fS3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfBULsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:48:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50313 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbfBULsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:48:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0EC673360;
        Thu, 21 Feb 2019 06:48:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Feb 2019 06:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Q3mxO+cQXm+bkyOyVpU65K3iO8+
        qv4XhqICwAmnej4U=; b=x6WZj4Ci/LCHWieXNKLbpI8fupRBFBCemBpMQ/QttEk
        njMt3CXnl3aUM66GvcZ5qiy8VqENnVRjP7L2IPP6qgCBuRRxE8VWjjrhnlqgNone
        iI/NOYLeSwaHzfTeJ6JKl/ZofVQCttCSq7eABwg2bxW0IhI3GHuufqK1id4bJ34T
        cVGmSFy3u0iQ98gYxX2erqFZc1AIXqX4JiIN/Keroum56wQGuKUoXw5PlpEFJ3ZU
        VGy43BC+Q54MEgIBVXNpvivLIjtJckTY2494xtqGYr7yXcDH20+7OpeXsTEQYEMX
        x32Th86yDuHNEVUuBZNZSghf0v5VLylTi5pPRjuhEog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Q3mxO+
        cQXm+bkyOyVpU65K3iO8+qv4XhqICwAmnej4U=; b=vjS8fS3f5sJwaaXIS3wQnp
        RESHT79IMdVvTvjvqL0nXaWeBfvJR7yuSomdscyUnV8SYICxWsbFSGU+EJqyiMs/
        5qkbTkBnw5lL5A7G0I4bLLs6xiz69ceA/x7nolE/0yfMkUppdIo0L/RLr7pOR6Ih
        xYq5CbZaThchM8jooz/oqkccdbwNICjuZYQqjRnALzBAZxjDlFBZIwsQD1QsITWO
        wIY8oq1l37HMBh2F0n29caWTFIfOkdQ1ZhVL3DhPVyMiRsqUQpwGViisHHoOR+iK
        qrwIsVoX8rXsJA6VJDkO9M1S8cyRha6AmIdXBKXfi/U1lEPOIeSGoU7AA3B2XxiA
        ==
X-ME-Sender: <xms:G5BuXIAK0G6cs1iyVmSMBZqsrdemiWjXdZwb98ZaEOy87ukdjT9hgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdekgdeffeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:G5BuXByC4t0ljjKe6qJmZxNu0GQjklkrGWuyiBOhF75T2qUTY_-n7g>
    <xmx:G5BuXAQNLgrErCHBXoH2lnHOuPVqLm1fxFXLBZchcsHZoojHUctd9Q>
    <xmx:G5BuXLcCWdY-UZ3nadV-vOht_-gYPQOXkHz4SuAhXZ87A57Uqm1q1g>
    <xmx:G5BuXE59dWn_9QfRwFLsGn2b9JnlUvRUEK4hIx7p_csh8zF5SZzgfA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0239E10331;
        Thu, 21 Feb 2019 06:48:42 -0500 (EST)
Date:   Thu, 21 Feb 2019 12:48:41 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     martin.blumenstingl@googlemail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "mmc: meson-gx: fix interrupt name" has been added to the
 4.20-stable tree
Message-ID: <20190221114841.GG10737@kroah.com>
References: <20190221054326.7AAED21734@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221054326.7AAED21734@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:43:25AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     mmc: meson-gx: fix interrupt name
> 
> to the 4.20-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mmc-meson-gx-fix-interrupt-name.patch
> and it can be found in the queue-4.20 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 2f7d5e26da383aca9f3a1270138d033e2a0e7be2
> Author: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Date:   Sat Feb 9 01:58:50 2019 +0100
> 
>     mmc: meson-gx: fix interrupt name
>     
>     [ Upstream commit 83e418a805d880a8b18add07f94d19b2a5a80307 ]
>     
>     Commit bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
>     changed the _probe code to use request_threaded_irq() instead of
>     devm_request_threaded_irq().
>     Unfortunately this removes a fallback for the interrupt name:
>     devm_request_threaded_irq() uses the device name as fallback if the
>     given IRQ name is NULL. request_threaded_irq() has no such fallback,
>     thus /proc/interrupts shows "(null)" instead.
>     
>     Explicitly pass the dev_name() so we get the IRQ name shown in
>     /proc/interrupts again.
>     While here, also fix the indentation of the request_threaded_irq()
>     parameter list.
>     
>     Fixes: bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
>     Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index ef9deaa361c73..ddd98cdd33bcd 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1286,7 +1286,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	       host->regs + SD_EMMC_IRQ_EN);
>  
>  	ret = request_threaded_irq(host->irq, meson_mmc_irq,
> -			meson_mmc_irq_thread, IRQF_SHARED, NULL, host);
> +				   meson_mmc_irq_thread, IRQF_SHARED,
> +				   dev_name(&pdev->dev), host);
>  	if (ret)
>  		goto err_init_clk;
> 

This also looks like it is needed in 4.19.y, any reason you didn't add
it there?

now queued up.

greg k-h
