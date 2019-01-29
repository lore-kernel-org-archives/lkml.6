Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4916AC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054402175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhbDSTGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfA2A0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:26:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40315 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA2A0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:26:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so7952425pgp.7;
        Mon, 28 Jan 2019 16:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sGAsU05C3PyG3eEOF3MjpKkLqSwUI9qgZBxz9Zz1xiA=;
        b=hhbDSTGoT42fxyu0wbbAiRcu5iMfv7kW3H2WsNAmUYekpSV0ie8w7bvxTtAaWbOZri
         oJnGehJ2OrrMtkhe/m1S+I1SXzUQvXTahTiDUeqlV9OZZZjeEPg/ha48o4XrUc4gmqBT
         OTAeOLcFrs8RYqhWoF84ZpgZOVBPtV2IcMS6+mASoP70sDLM3YQ5D2ampFnkMFS4vyTp
         WLM6LdOZUbdlFRSxs+d/zjUyQadQ3IQvOHZ754ydgfsBjGRG5FSXz2mUTyEcEUvDIQWD
         KiLoYh+47wM+A4YYr5Xl8Wq2/H/SU9kfci8Mvlh/9tSv542N6cWRK9/wZ0tI5cchblMr
         KyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGAsU05C3PyG3eEOF3MjpKkLqSwUI9qgZBxz9Zz1xiA=;
        b=CWodpkyLtLEmKpwWHzKlS0aRX+uZLPAWunYZivFPAAePPh6RN/U/44BgLxNCnGFC0c
         m7TW17sApcbrfQxJRyqDfEQUfdjL1CcZ27Pb6uAuLjiAHXg6yRgVPL1F9ni7EOS+Y8a0
         g6MBzYeVpuoe9f6B9CiACI0q0MLB752vo2MTn0lkxtnrw06KAqRzx6P3HG8FwQIJ1cnh
         bTLf/RADlwhMCiTJ4DNbkbjwPLu73dYOituJaM98w8Bzchx4g13R4PpkjxX/T1C3VE6b
         xeQQIHgHsiQnu9pBm9mOOfz3gZopwrflJ63frjHfRm0tFioz+OFVwJWaesoOFTS4sRYD
         DLvg==
X-Gm-Message-State: AJcUuke6iSm95GC7i3j/1azMhI2Jvb0de9zvn44hJgYuOxF0SEBV6loy
        9vUnemeGNojOaxlLKrCFLL4=
X-Google-Smtp-Source: ALg8bN5ZlnRd/UAe5ZhKUV5+2hdRo8XAea+5eHiAYDjibAUYPW7wvvKIJXZ92Hq6AohNnd/83xuE+Q==
X-Received: by 2002:a65:6215:: with SMTP id d21mr21722024pgv.289.1548721589661;
        Mon, 28 Jan 2019 16:26:29 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h82sm69522253pfa.105.2019.01.28.16.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 16:26:29 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:26:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 4/8] Input: sx8654 - add sx8655 and sx8656 to
 compatibles
Message-ID: <20190129002627.GK34692@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218083606.25795-5-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218083606.25795-5-richard.leitner@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:36:02AM +0100, Richard Leitner wrote:
> As the sx865[456] share the same datasheet and differ only in the
> presence of a "capacitive proximity detection circuit" and a "haptics
> motor driver for LRA/ERM" add them to the compatbiles. As the driver
> doesn't implement these features it should be no problem.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/sx8654.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index 238f56b1581b..afa4da138fe9 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -293,6 +293,8 @@ static int sx8654_probe(struct i2c_client *client,
>  #ifdef CONFIG_OF
>  static const struct of_device_id sx8654_of_match[] = {
>  	{ .compatible = "semtech,sx8654", },
> +	{ .compatible = "semtech,sx8655", },
> +	{ .compatible = "semtech,sx8656", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, sx8654_of_match);
> @@ -300,6 +302,8 @@ MODULE_DEVICE_TABLE(of, sx8654_of_match);
>  
>  static const struct i2c_device_id sx8654_id_table[] = {
>  	{ "semtech_sx8654", 0 },
> +	{ "semtech_sx8655", 0 },
> +	{ "semtech_sx8656", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, sx8654_id_table);
> -- 
> 2.11.0
> 

-- 
Dmitry
