Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BA7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1BE20821
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Cg1l6b4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfBHSzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:55:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45081 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfBHSza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:55:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so3281636lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XiteZo8Dtisf9sBZ5R33A8wf4o38A0lZEBIHXvTzJ9g=;
        b=Cg1l6b4JeF9uMd+SPEbccXJpaiL/4eUCyXBa9z+8oVhMPGcVliWFeJcD9KdoIX2qtw
         eNcvEWFH4JAtHX1Qo9zmIyAK00dqJDoaQvFCL9G5A/uD9PJKFG161rNFoCzynzud4mHn
         V5SFhqzwELlDLu55y0k/jmv0z5fkYGmVnfPd6DcWvN7TPbKS0PvVPBIXnjC1ddO4VMxs
         pETfZAkabwzIA3GTpTOXubU2UDvp77l8VAGlXW2WlpIRhzNKDyuemQD3AJ+iU390/Cgh
         fUn3UarG9c5I9tqmZNHKh0a9KqQJzWnwHJf9KkBTiiqQFLYCrpfqahRfZW1xANpnxRuO
         HUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XiteZo8Dtisf9sBZ5R33A8wf4o38A0lZEBIHXvTzJ9g=;
        b=p44pqLc3KMCcFgPbHhAMsQ0SzPkrNn/qOxjJocmdzarw4TsO2WURb7pjrIutt0XuDa
         yv6ULLtfO0PIkQwNsdebTNdzJuGSFh8feyxS0iFQ8qoF/ehFGWGrAfiCXnlibJjhvD77
         aoT09iTH2wbetxX2MROa4+7TQ7u8MEYz+zIjdU+7Vv2GfWm3YFyX5m2U0HAJvS0xU9Zi
         C6PDD7Y616XW6GjyihsvGL8Eaczqk69tTBdJdKMSQevwFipGCzdMsfc0ie3viQYsWgK+
         qpdJKHUoSy5bgGaRNdv4GAnsJAGWAv0y2cDGgrr0qVuMgBdajzbi5mcMa3gw5ZRxIJut
         K+lw==
X-Gm-Message-State: AHQUAuYvx9+EOTt/OqdKPLY68D6S3ulfzyKr8yS8bILTZatTAhU9bg1N
        qSFYbWephepUq0Q+YB4xs+AxBG0bkdI=
X-Google-Smtp-Source: AHgI3Ib8vk/f8Tk+5uCSgXDU26DWtFjBJcQfx8VKUihWbf2UJQf3Fw9q2XybnZxziBDXoVhEohrG6w==
X-Received: by 2002:ac2:41cf:: with SMTP id d15mr14236373lfi.14.1549652128101;
        Fri, 08 Feb 2019 10:55:28 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.160])
        by smtp.gmail.com with ESMTPSA id m10-v6sm545895ljj.34.2019.02.08.10.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:55:27 -0800 (PST)
Subject: Re: [PATCH][next] can: at91_can: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190208184444.GA28484@embeddedor>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <8402d6f6-dff1-eb99-3bd1-051b4f6f24f0@cogentembedded.com>
Date:   Fri, 8 Feb 2019 21:55:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190208184444.GA28484@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02/08/2019 09:44 PM, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> Notice that, in this particular case, the /* fall through */
> comments are placed at the bottom of the case statement, which
> is what GCC is expecting to find.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/can/at91_can.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index d98c69045b17..1718c20f9c99 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  				CAN_ERR_CRTL_TX_WARNING :
>  				CAN_ERR_CRTL_RX_WARNING;
>  		}
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */

   Why do we need this comment at all? Just remove it, that's all.

> +	case CAN_STATE_ERROR_WARNING:
>  		/*
>  		 * from: ERROR_ACTIVE, ERROR_WARNING
>  		 * to  : ERROR_PASSIVE, BUS_OFF
> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  		netdev_dbg(dev, "Error Active\n");
>  		cf->can_id |= CAN_ERR_PROT;
>  		cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */

   Again, we don;t need it here.

> +	case CAN_STATE_ERROR_WARNING:
>  		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>  		reg_ier = AT91_IRQ_ERRP;
>  		break;

MBR, Serfei
