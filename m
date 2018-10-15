Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7880DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D8208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiMC1ae7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6D8208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeJPCIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:08:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38909 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeJPCIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:08:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so6623946pll.5;
        Mon, 15 Oct 2018 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9iMDJBoNLkEq2zrC/We7Dd0Vy7ooSSY3bLsv1ZX+trc=;
        b=aiMC1ae7upl4844r9dGEqBG8xsbUMCcQl8S0VXR7yqA24JS4H+q2Nlvzg1e8kHNDSz
         rYE6Ucvk7VEoF1rzz6lJ8h+Qaqsk0mYcMxqm7SptZwNgyqr+2o7Xt3rNi441u1qePF5t
         Jl4NAE73eBg/kxITMcvsRf0sOIzaX2HDzJPorBSoS1l1u2r7uhhIgwpArtQgxjyVY/eM
         4kvVg3Ig+jqQ7PT6OxjzO+axsCdKbyikeiy6svXtrzFJpf15uPvg944CWeq7ob19SNwP
         BF9DKbDQUo7hHZFTgwKmswdfoGwhQhySbACQ/IJd8k2FFMOl4h26nYuHYEj0VYqK2i+h
         LwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9iMDJBoNLkEq2zrC/We7Dd0Vy7ooSSY3bLsv1ZX+trc=;
        b=PCj/kb0sX1IeccdfKQRMtNyIKVEucFwDaC8oNes49hZznIViJ6fSY8cAY2nIWWEphu
         FL4XAHyBwoW0NFRFnU26fgxAa3XK2t70vDxxDefL/to0EZI8g7nQ6Gi3sLX4xKmAn9iT
         q9RgJ4pHIon/w5wleR7Krr+wicfNeO84QQJcjJtorZwtYHRr2aCyekQN2wfbc5se8ePw
         JllFU/0uBWMUJIEXK9K6hq90TJJzD31/YGOQrA6PyLlbjb56enEzzofEcITfnpMFIELE
         iUAXLPS97Uyk/uif4AoS9UhjGEAQl21NN7xL6QFCx2WYrgjtINpow9tTk07B+ve2Xmic
         0Bkg==
X-Gm-Message-State: ABuFfoga9qAO79NBLMrntXuoOon9Tn96yOAntVQwVBwjEQ2y69Cf+D74
        OqpnQUUPHV14GIzL/hLPN70=
X-Google-Smtp-Source: ACcGV60T+NqnRvYAhwR1A1sdQDNts6uaW5bUspQY2MhwtRob6GGjoPLzmFLrnjXKSLtiyjMxpMEjIQ==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr18135448pls.217.1539627698159;
        Mon, 15 Oct 2018 11:21:38 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v189-v6sm14395486pfb.54.2018.10.15.11.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:21:37 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:21:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cyapa - mark expected switch fall-throughs
Message-ID: <20181015182134.GC127224@dtor-ws>
References: <20181008153824.GA14336@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008153824.GA14336@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 05:38:24PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I replaced the "Fallthrough state"
> commern with a proper "Fall through", which is what GCC is expecting to
> find.
> 
> Addresses-Coverity-ID: 114758 ("Missing break in switch")
> Addresses-Coverity-ID: 114759 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/mouse/cyapa_gen3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index 076dda4..00e395d 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -1067,7 +1067,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
>  			return error;
>  		}
>  
> -	/* Fallthrough state */
> +	/* Fall through */
>  	case CYAPA_STATE_BL_IDLE:
>  		/* Try to get firmware version in bootloader mode. */
>  		cyapa_gen3_bl_query_data(cyapa);
> @@ -1078,7 +1078,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
>  			return error;
>  		}
>  
> -	/* Fallthrough state */
> +	/* Fall through */
>  	case CYAPA_STATE_OP:
>  		/*
>  		 * Reading query data before going back to the full mode
> -- 
> 2.7.4
> 

-- 
Dmitry
