Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51014C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFFD2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Adm+OmBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfAXByV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:54:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37896 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfAXByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:54:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so1938108pgc.5;
        Wed, 23 Jan 2019 17:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fGw38w0NLEFxt7pmwWcdHBPcNhpfKxwTVMKVh1KjCPg=;
        b=Adm+OmBcaNQ/kJz54w7aWtxShQwK7WlAGIb9n17md+t5AX7HhyTXcZCb6iCUviS/xa
         pxVDy/E5GEW8+VoV9M3eeJVdmLhVjM0bN/Q8rgKZRIaW5fs3CVy9zf9y2gOjgBbbb6re
         5ATqWFo5K2UG85mLN5hH2oyFTHs8KhykOJg2Vx6KYargqCKaWefK0uGYN+30HldsBLpj
         xsdAoeW+lu1C95GWhEdhYVBGWS4e4JbMOlxPgO9Dl9988RsXRXQtcnPo/XUtPl9LPNhn
         TeU9oQyxfWo+xd/d8pL+M3VakMx7lS2WMJgMdOjqhzHbqYc/OB5MDE28ZacmWhaAiESu
         9yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fGw38w0NLEFxt7pmwWcdHBPcNhpfKxwTVMKVh1KjCPg=;
        b=E41O8gL0SuAy+zGKbrW4kdLJEgQgeYO4tvt5Ld0rEqye9S3Fsn4dPVete2zuD7uXQU
         H5rxIQfEabH9CE40nSQ4lgXNUdVkIiQcVh9EF1vJadGLsGNpp3xmS2xcTmqiz6R7iCm5
         G55rZ01jEsMp3g2r4k6vTK5Wao7WPFIYuMXaDXrCnXTINXA2NZJOc+0eZa4oSuEgc5Fr
         cnMA+WK0RDhylTQC/HWNpct17sMjhUs8NcREprrInm67QrASuX1HTRYtALJyFEUIJPwr
         3c8KUOvm6vdiMuVItoXC8WEezwGbZaxhqh6RAEC6/tJAAAfc07epVVwM4P7Y7YALQRwm
         9ZzA==
X-Gm-Message-State: AJcUukf9TwcgtX7QzaES+dch4vODu/jOtT7pE6itrpkzdgM8WaqwJB2t
        cJkBAqEpmsf0X7+TPZhmR9Q=
X-Google-Smtp-Source: ALg8bN6LjYY7FfAEr1faUL6hiDAAL9kvLBR7z1NtZwl9ng1J/nNzqZQHSmgIwNVnznZokSj+ql1S+w==
X-Received: by 2002:a62:28c9:: with SMTP id o192mr4545656pfo.57.1548294860302;
        Wed, 23 Jan 2019 17:54:20 -0800 (PST)
Received: from [192.168.43.97] ([121.90.236.7])
        by smtp.gmail.com with ESMTPSA id g136sm26823820pfb.154.2019.01.23.17.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 17:54:19 -0800 (PST)
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
Date:   Thu, 24 Jan 2019 02:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 8:09 AM, Mason Yang wrote:
> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

> +#define RPC_CMNCR		0x0000	// R/W

Is there any reason for using those horrible C++ comments ?

[...]

> +module_platform_driver(rpc_spi_driver);

RPC is not a SPI controller, it's a SPI and HF controller.

Also, how difficult will it be to add the HF support ?

> +MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
> +MODULE_DESCRIPTION("Renesas R-Car Gen3 RPC-IF SPI controller driver");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best regards,
Marek Vasut
