Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB576C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC2A21A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqKMiD5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfBQHPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 02:15:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45896 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBQHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 02:15:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so3969042pfm.12
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 23:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RzQj1NGmKPBMIQT5kWb4j66t8myM+09reZU6Hsr4BOU=;
        b=RqKMiD5W92BgljRqKwTDquAqF5RuHVNMDp6mbOfOEfjhsk+pl6L/AnCq0wwOhhLJfw
         6FphS0isJPrczBxuymDuoqfDdiWdLG1THH0emSx3ubaAMlphQXkyLzE45Z7NwuywL51f
         3keUix1JrToRuiDy6AXtRJvb7sxRrW7HggfB+XvTmlYtfIvPdFEPk6ZTh3l/DBQgByKT
         P+42RmxWYLshobjFmtl7k0QfyVILoR8laBdfco9ixr549c19TDRPydG7Zsb24kdsXb3t
         DioDjz7nCofLD1rJDJqPGHbXJkJEpxJng8BJXmoOPTGQNcPUK+EXUJxVpx8tLGQ+cYnn
         lPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzQj1NGmKPBMIQT5kWb4j66t8myM+09reZU6Hsr4BOU=;
        b=WggWKAoiR2y+jwyFMkfw0p+XmtmHjhcmTuZgtudvxOKuBjmYqS4tnr7g2VwQ61tVNU
         sf+UlkeH8oVRadcf1ppid4qmtaMBp9i1UIP2POLnjBOSKMqPqyFCg/cFcBrOUDz7h3Vn
         bILfIE0mGnLX93lB6YQwgC3HE/cdTqiCcUJidglY9QZ0x0qcNj0o2hT3CrjiBuDd/A4A
         GxitT6PLvENRAqlXIh68DZZAul+53NAZ5o4n5COMtF5XhOaYqa4HagbyyunfTgC5n/Zw
         v05xkjIwLXZFxhu3gOtpwblcSzzXrYkiRUVhq4nI//o+5+/ZkolzjxT68ZSPetve7Sd7
         CisA==
X-Gm-Message-State: AHQUAuZ8O8tmpTOIVwtBo1JI4nPO6bC2qEbEIyPaQOEIHE/u2g1uDsK2
        /MzXbxfOn/ioQOK3aI3KIfTVWg==
X-Google-Smtp-Source: AHgI3IaX4Jp2znCwdCqcg9rEq1GGnapziDR8CACNkMzmTrItVX+YXw7tac6XtJg6LyTz4JeVR2FOFA==
X-Received: by 2002:a63:981:: with SMTP id 123mr13226992pgj.444.1550387704676;
        Sat, 16 Feb 2019 23:15:04 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e21sm42542773pfh.45.2019.02.16.23.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 23:15:03 -0800 (PST)
Date:   Sat, 16 Feb 2019 23:14:55 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: msm_serial: Remove __init from
 msm_console_setup()
Message-ID: <20190217071455.GH2173@tuxbook-pro>
References: <1550379952-19457-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550379952-19457-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 16 Feb 21:05 PST 2019, Jeffrey Hugo wrote:

> Due to the complexities of modern Qualcomm SoCs, about a half dozen drivers
> must successfully probe before the clocks for the console are present, and
> the console can successfully probe.  Depending on several random factors
> such as probe order and modules vs builtin, msm_serial may not be able to
> successfully probe for some, at which point, __init annotated functions
> may become unmapped.  If this occurs, msm_console_setup() will be called
> from the probe path, but will no longer exist, resulting in a kernel
> panic.
> 
> Resolve this issue by removing the __init annotation from
> msm_console_setup().

I'm pretty sure I've stumbled upon this several times without knowing
what hit me.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/tty/serial/msm_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 736b74f..1090960 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1634,7 +1634,7 @@ static void msm_console_write(struct console *co, const char *s,
>  	__msm_console_write(port, s, count, msm_port->is_uartdm);
>  }
>  
> -static int __init msm_console_setup(struct console *co, char *options)
> +static int msm_console_setup(struct console *co, char *options)
>  {
>  	struct uart_port *port;
>  	int baud = 115200;
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
