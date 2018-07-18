Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70649ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C332084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3a2mCgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C332084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeGRSHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:07:54 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43344 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeGRSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:07:54 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so10253865oib.10;
        Wed, 18 Jul 2018 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MJlNltGzC/wjwmw3YIKZejxyy63JBCKAfvQtb4Twwzo=;
        b=d3a2mCggI3iTpsvPzyUXY+M9Z92RxNdCf/YjJa7w8vVNKFqC5WquslRl8HIRYawig7
         I9dHVRxDBkjx7Vmnn/DqWrHwG4q7TjwiXKDETfEuVIMBJtVJdHTnXhg1wYJeoDXLI/IR
         oo4d9FxCi8Us/MZKt0EWz3gpKEvYUkWvUcF+kfB7LiE6myq5OBXDEeun6a6gOP0Gw1Bf
         uvBTVbPGRZIBEiTrg5Ol/4bX10eSEGki+Mu8a1cPQMuRidw6yoHsTmFGoJ6IMiQxXw+b
         9GrDhrGFa2yBxSwrNDgak6L9j1E2OSays59CAV18/EhQNxiBoriZwq8j+JwrBe6doF4u
         W/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MJlNltGzC/wjwmw3YIKZejxyy63JBCKAfvQtb4Twwzo=;
        b=nwtLEINR+FM9lzYkHlcK6nuAxPD+50nyVG/2mB972z9Tj0Ru0lgpMqLMwpe2QGIPvk
         ih7xG3xT7hfJJYTCjMTjGs8ahEvGx+N9L5gFyqtGMs3yox3VisjVw6pAdpsyJ+S7f4P4
         gXL7NPSnm/NvLVFzBM4Hk4eAmaWGQKJTsvJtbne17cwMoRss08EuYeNCFTAXNktnYqpV
         XNH1PtO6IKjXqe4q643pfXdVbWV9W1OIph14QE6SPFiqUkcvTRB5giHmdK+TaflqLOiE
         brb1wsdv7a7fNiVR1CJqC9etRPzDCjgi80kag96HDKvvwfxqxkcHD/6rXSw/d1kcchAr
         Ii1g==
X-Gm-Message-State: AOUpUlEN3K+EopWxOXdrW0wW/YO+VC/lv9gmaap//1UQSy6niosq3wYd
        ZBPPpTcInP6bR6H4nN39pdA37PJl
X-Google-Smtp-Source: AAOMgpfYA95HYLfxwpTKOe+2IjS/zQFF+cQmpZv1wdV7buOl/CbPKEqKD9uklCilEsTcJ0/W+zyklQ==
X-Received: by 2002:aca:4083:: with SMTP id n125-v6mr7867325oia.167.1531934938998;
        Wed, 18 Jul 2018 10:28:58 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id d191-v6sm2427953oig.16.2018.07.18.10.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:28:57 -0700 (PDT)
Date:   Wed, 18 Jul 2018 17:28:49 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add Lenovo LaVie Z to the i8042 reset list
Message-ID: <20180718172849.qvfv3s3jyzf3jf6o@penguin>
References: <20180705130849.10479-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705130849.10479-1-wens@csie.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:08:49PM +0800, Chen-Yu Tsai wrote:
> The Lenovo LaVie Z laptop requires i8042 to be reset in order to
> consistently detect its Elantech touchpad. The nomux and kbdreset
> quirks are not sufficient.
> 
> It's possible the other LaVie Z models from NEC require this as well.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index b353d494ad40..136f6e7bf797 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -527,6 +527,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
>  		},
>  	},
> +	{
> +		/* Lenovo LaVie Z */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
> +		},
> +	},
>  	{ }
>  };
>  
> -- 
> 2.18.0
> 

-- 
Dmitry
