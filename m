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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3086C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A3A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSW1Vur3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A3A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJPCIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:08:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeJPCIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:08:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id 78-v6so7721771pfq.0;
        Mon, 15 Oct 2018 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M3PkoqrYXVsHXcZtLOpXeemToy6CU1KRtxboHD9L3lQ=;
        b=dSW1Vur3C73NlWQyuaQQ6cxovAfhUIYipsCXC65eTctqCLQSEdH7gfwI6kAqJn9/H/
         RY0ZVTrQW+VmX6NyZazkkjrCf4CAsUaj6qu3g4fV2O1qZsLaTGMbPznjy0xW7S9mokPa
         0buAuyO6ahC81EyKERSLGCu2keuhE5W0rclfewWY1HPi4GUPggrteKveQNzF3EqY5J+f
         P7yRh6oX4v6vurL6M0RdnOcK1CU/uAyX721QxFPB0K5QD9U3LjXVMZImbxWPl7aRGZcn
         kI3mhQsyfI6DaSA4r6OxIYFxYMd1VD/bAqRALfpTmLc/TNSDNJZsrLnhYObSw04qpqVE
         5Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M3PkoqrYXVsHXcZtLOpXeemToy6CU1KRtxboHD9L3lQ=;
        b=T/TxAyBBQAAO/xodTB2eujF3qQECRlHBghItyS7LAQj2OBZ4un5pC2C57nfztohQeP
         3gsA7h2WqDIp6sOJP1Wp7+vAHm7A4E6W36BpibpZAPCs784e29bzTbVumKoICabCbsMT
         BJlsFibhx46b1T+apH1u3KZ9K1/nxvKVTpFyO1ErrqMDyua0ZVTIb+8lyNad3zKkH001
         XcViS2n4/foumpeaN79VRCZ8riyk6Vo54ZZBlN0KbLsq7a4f0JsczaSE5sdukj8y7YXn
         5v3zWl3r4JLneYh69IQ76ew2EP7pqZrgOGzscP0L6GLRVT5rC94zgO6sJWOpai+vQVfT
         yQCw==
X-Gm-Message-State: ABuFfoit8Q1sWK9vLjvt0OCDTBF8JTV4k+a8vgu/nhzT+VFVtfhdIIdv
        YVMSU75KAvp0v47KWSBKapmuftqDqGg=
X-Google-Smtp-Source: ACcGV629fJO2IHSGRaKPVw7nrbnYEUekmT71ONPNm+RAG/ahLmeY6HP6CgprLFsXtZv2JBp03A90NA==
X-Received: by 2002:a63:f64f:: with SMTP id u15-v6mr17250719pgj.258.1539627719413;
        Mon, 15 Oct 2018 11:21:59 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i69-v6sm10890317pfe.106.2018.10.15.11.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:21:58 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:21:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atmel_mxt_ts - mark expected switch fall-through
Message-ID: <20181015182156.GD127224@dtor-ws>
References: <20181008170355.GA18107@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008170355.GA18107@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 07:03:55PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index bbc122f..d3aacd5 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -488,7 +488,7 @@ static int mxt_lookup_bootloader_address(struct mxt_data *data, bool retry)
>  			bootloader = appmode - 0x24;
>  			break;
>  		}
> -		/* Fall through for normal case */
> +		/* Fall through - for normal case */
>  	case 0x4c:
>  	case 0x4d:
>  	case 0x5a:
> -- 
> 2.7.4
> 

-- 
Dmitry
