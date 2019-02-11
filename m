Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C52C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D3F2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw7ugLkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfBKWsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:48:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45200 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfBKWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:48:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so244646pls.12;
        Mon, 11 Feb 2019 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+ebh/JLjqecjcJaYuZzLOgJ3lD0OPjhRaCM/qfNfEoI=;
        b=Mw7ugLktMiwQQkXgMy+f5k+k11RxBvvYNHcK9GSXSNFXMtsIqF1IpI7YYdLlffCrqz
         EDmMvC13ClMHsJIOo0F2QSgZ+LLa7n1DCIVKcRFg4SyyUSRedyl+CSByaw7K5XesOtfj
         nE1Rtu47z7mv/xtKWNaabUvvTmy35ozMa4JhdC3zgH/BUW/wpjQOO9mhbOX87aMiGUvk
         C1YHezAB4bRd+KkZjuDJPNtoFEZReSHgBepVQ5e6Vh5+BxQkt+YVSGAWdZfB7hz2rlDz
         j7BauJ0wEySCVkJiKVEwCVeuFz0hU75OiEtix3MB+9h91CZGOQPJLXeBdQjbbpBMnpDH
         sEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+ebh/JLjqecjcJaYuZzLOgJ3lD0OPjhRaCM/qfNfEoI=;
        b=eZuw2t4VqtWgTOa4WtNSI2/WSMPv+E3DK+zcF81beWAN7ZdNOsB5FG1J+Fe0J+yk2f
         Dr8hdzf5EvzSrMsRyXNoA1bav5ZlzZkWjCo06tof5r69IfUBhaD0ODYERyQsE6AGEFh+
         ydAuckLrm4rc1EOTxrqEZAa0QxfHDy6dRcaKWpUzMciz/uqKveOwTxElezfy2Tp8jDP/
         xqfIHRIyXbsDwFCqR/EhBTdc0p6ZlUbCk2pwiTeJ4re24TKA77rwUqzkGcxkOwgllRqa
         YxSv1ymg/Q1U7Pz4o9VSOKfN72hh9im3tNBCrNe6drPFhW9KJaZiVPD3UoKMtHfyRjai
         6f4A==
X-Gm-Message-State: AHQUAuZxNvxlVhmmLUHekXc6JPMQhCyeRyEC1XcG6tca+sCC9F7/3cj3
        fvbKIUKoMavvF9dNl0yBvIQ=
X-Google-Smtp-Source: AHgI3IbFgpLZQYT+w2ETVaUQcZYcVZERna9K2KFKSrqY5ww5ZgleUu0kCK+PYfzLnjR4VDdIbIpNnA==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr653846plb.70.1549925298357;
        Mon, 11 Feb 2019 14:48:18 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f10sm2031188pfn.11.2019.02.11.14.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:48:17 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:48:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Input: mark expected switch fall-through
Message-ID: <20190211224816.GE149505@dtor-ws>
References: <20190211222555.GA5472@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211222555.GA5472@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:25:55PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/input/joystick/db9.c: In function ‘db9_saturn_read_packet’:
> drivers/input/joystick/db9.c:256:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (tmp == 0xff) {
>       ^
> drivers/input/joystick/db9.c:263:2: note: here
>   default:
>   ^~~~~~~
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/joystick/db9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index 804b1b80a8be..5a52b65bef9a 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -259,7 +259,7 @@ static unsigned char db9_saturn_read_packet(struct parport *port, unsigned char
>  			db9_saturn_write_sub(port, type, 3, powered, 0);
>  			return data[0] = 0xe3;
>  		}
> -		/* else: fall through */
> +		/* fall through */
>  	default:
>  		return data[0];
>  	}
> -- 
> 2.20.1
> 

-- 
Dmitry
