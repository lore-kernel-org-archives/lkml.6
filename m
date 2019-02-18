Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4306C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BC0217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXYpNmJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfBRGqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:46:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43372 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBRGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:46:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id f90so8264473plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 22:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TXB7jt4NvFlkCJ/z1zjL8wfAZckZKg1Q4gS8BvR9WpI=;
        b=aXYpNmJoDwx4gdhoE55d217A/1hcA1Hg6b+v0JrDuv8Mx0CQBnuHoExHBDJld3TF36
         AQjBRrtmbMQtHCo2yRRLmMIAwQCC4ip5dY6vpVdCyJCw8iSGaYp3hoYBj6H/VMskWWLU
         875fHLAHrx4nw6yfmlJdarF63EGgAdtM0Hf4qsSwsGctDaUJ4U6Vwzc3dFy5IR32Jk+t
         nNsC4Xykw1cBtZ179+gu3ccjzyKYF59+jurDKIL6910atvoM2F0ReX+QT3+GLY78XlTk
         wm6ChdqUhNtnbmX7lIJmaK8HFaBA9eXfMaU0+VsYiHyzXHaWKYZQikjp5sH3t82BuH/s
         uerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TXB7jt4NvFlkCJ/z1zjL8wfAZckZKg1Q4gS8BvR9WpI=;
        b=W5KMxTDdiQEVyGh6BG+TGpVKH1lq6nUB4rNYbRgC2IKP529F6CjHe96SmhUNOXoLRW
         yr2/2ZYEPtIrkC6kNWCspp/hYu00RuYbps91T83/pDs05MecM5w3QK2zbrto0hFxiImc
         85brOOMei6eTKFmsqTmfejHGbtoxwOe73G5QtTDQJPsCDL6LrO5NqcKVBKOv3E/6GkkS
         91A84NL9oRoywHHiQkHH/IX8TBFABXx1W3HJYf1ANAAqGGqYUwdC9wHCQH9AjnEoSnbu
         7M+bxBC6QMQEIgE+aCo9r2Hpa4P20TPyd3iG53udQeJtS5ad3kzTPej3XlRfDg7ljrsR
         HwwQ==
X-Gm-Message-State: AHQUAuZv10dWtPghgeVLUeQhh8Q1JMLfk2f4euidzVlKbz1ks6f+bNdH
        iKMqdn5G3rLKYfrytd1m8WE=
X-Google-Smtp-Source: AHgI3IY0gLKvTiSEHnKHPDT8NxwYn6wIbP838XB03e81ovdoRnO8AVfkA0NaaHLX67ADQoEDMo2iEg==
X-Received: by 2002:a17:902:a7:: with SMTP id a36mr23675732pla.295.1550472391559;
        Sun, 17 Feb 2019 22:46:31 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 64sm28856175pfl.83.2019.02.17.22.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 22:46:30 -0800 (PST)
Date:   Sun, 17 Feb 2019 22:46:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - Allow uinput_request to be interrupted
Message-ID: <20190218064629.GB242714@dtor-ws>
References: <20190218004305.339758-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218004305.339758-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcos,

On Sun, Feb 17, 2019 at 09:42:52PM -0300, Marcos Paulo de Souza wrote:
> Commit 8e009118a45a ("Input: uinput - allow FF requests to time out")
> sets a timeout of 30 seconds to wait for force feedback interaction with
> userspace, but also made it impossible to interrupt the event handling of
> uinput code.

No, the original code was using wait_for_completion() and therefore did
not allow interrupting FF requests either. I'll apply the patch, but
will drop the "Fixes" reference.

Thanks.

> Make it interrutible by changing from
> wait_for_completion_timeout to wait_for_completion_interruptible_timeout.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193741
> 
> Fixes: 8e009118a45a ("Input: uinput - allow FF requests to time out")
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/input/misc/uinput.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 26ec603fe220..b7bdf332ef4c 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -191,7 +191,8 @@ static int uinput_request_submit(struct uinput_device *udev,
>  	if (retval)
>  		goto out;
>  
> -	if (!wait_for_completion_timeout(&request->done, 30 * HZ)) {
> +	if (!wait_for_completion_interruptible_timeout(&request->done,
> +							30 * HZ)) {
>  		retval = -ETIMEDOUT;
>  		goto out;
>  	}
> -- 
> 2.16.4
> 

-- 
Dmitry
