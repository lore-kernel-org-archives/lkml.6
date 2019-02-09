Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B3C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE3C21929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXBm4LbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfBIQwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:52:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35804 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfBIQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:52:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so3180667plo.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HCt0q6/pkcEB8YVJZU/dl0RyXRnuCIsWpGUBVL3gDlY=;
        b=VXBm4LbCWn1wEr3yeLJ0nqsWZMUqe4ognp7mhaLqm1DVndWfO/Jvtcx3bjEEmKQWQY
         zV7RaNwlyW+GJl/lEP9ePFnGX/MLEu4Y8UygZsXWwQWbpbsYDOcCm6rMAFZzxyn/MBj0
         7L/BSfG2kBsVMmlTkw1p+gvEMrQSHoy7lMprQkdbXUyAPtUulI2fjnk20ioMrFjfZr/n
         cNdo14d3hgneVYrlsQ+j58tbfFGYH1WCHvitLTD7qHlzaUptQC82mR5cB+wMCM1ihRCv
         X8r1Hqpdyy5VC2USI2FJBoZfaunQ3FXcHqd8tNC3ISsR6kazK+pDKOy6st2T6C+x+hMR
         wgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HCt0q6/pkcEB8YVJZU/dl0RyXRnuCIsWpGUBVL3gDlY=;
        b=aU0agv+uMTf5rC73CPF1iwY5txRfsRXPh9Vp1b+SNiYhHUdmknqiajcZR97VLO10Cz
         VBWFFjNvvk6o4YT1KxSk8ciZ0SC6X0nhoCbvQ7FHjQdyXC5jyu3bH7RQKOuq2lIlGBEx
         cAOTO/XlEfhfXFZLwTG73zvrJHCqHsmGbaCCi5A3Uj/LP6FW5N1pYQWPJv4cxEs5hEKN
         FQwnSvAKi7sJhDp+CnsoUP9lJ8t0iw4mspYrnZbbX8c8nVBiddT0gy+nrc7lhJnPDZkO
         bL5RCJuteZvnRcrVUHpdMDx7PwwAdAm7Kwntqj7eU2FUAvTXF4KOssMTaaN8ybgMFC6S
         qrug==
X-Gm-Message-State: AHQUAub6VHxa5vND6r9McVzPEkaCEwR82i6XAbvTwMjGgSwVuZFq1YBx
        tnUNk8oW6Ba1IjsAY/QbJ5Q=
X-Google-Smtp-Source: AHgI3IYMenMKgSISVGD7KAoyDLYTeQFoRtKJVyqzpoy5Z7ZDGvUaCF3HQSzuIiw8xCQbLR0CD5rY1g==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr28478493pls.68.1549731173482;
        Sat, 09 Feb 2019 08:52:53 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k71sm9814214pga.44.2019.02.09.08.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 08:52:52 -0800 (PST)
Date:   Sat, 9 Feb 2019 08:52:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: ht16k33: fix potential user-after-free on
 module unload
Message-ID: <20190209165251.GC197782@dtor-ws>
References: <20190209001522.GA11769@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209001522.GA11769@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 01:15:22AM +0100, Miguel Ojeda wrote:
> On module unload/remove, we need to ensure that work does not run
> after we have freed resources. Concretely, cancel_delayed_work()
> may return while the callback function is still running.
> 
> From kernel/workqueue.c:
> 
>     The work callback function may still be running on return,
>     unless it returns true and the work doesn't re-arm itself.
>     Explicitly flush or use cancel_delayed_work_sync() to wait on it.
> 
> Link: https://lore.kernel.org/lkml/20190204220952.30761-1-TheSven73@googlemail.com/
> Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/auxdisplay/ht16k33.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index a43276c76fc6..21393ec3b9a4 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -509,7 +509,7 @@ static int ht16k33_remove(struct i2c_client *client)
>  	struct ht16k33_priv *priv = i2c_get_clientdata(client);
>  	struct ht16k33_fbdev *fbdev = &priv->fbdev;
>  
> -	cancel_delayed_work(&fbdev->work);
> +	cancel_delayed_work_sync(&fbdev->work);
>  	unregister_framebuffer(fbdev->info);
>  	framebuffer_release(fbdev->info);
>  	free_page((unsigned long) fbdev->buffer);
> -- 
> 2.17.1
> 

-- 
Dmitry
