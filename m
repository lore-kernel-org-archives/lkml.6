Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D2FC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906E820685
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN3m5lJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfAHMGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:06:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33818 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:06:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so8310868wmd.1;
        Tue, 08 Jan 2019 04:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bvH37TfwqoO2JLQdu07hHzOg/BejWk551fLqEumCMJ8=;
        b=TN3m5lJEVmkElAtQ4CTzSQenz4XD0V8v/5cBDQONc0Qf9HD1hABdqzRqwjtQZjBlmw
         LalMjQphWuZCvl/b3HHbSN8TpvWBm5vyopx9x+4dJW1cE7C+GymIfEDWE1r+aqXoykGI
         yGcgHtPUSWi19I9Z8Sxx4DILZaHZjfUp+XoEa7jW1cAMNa6YxZ0FH8F7lSXEEyM/uh5E
         SqJobS6e2mV/HxmajqceXuiW4CPkPVgk79LXCVuWcp5pAKs5x1LP4w8s/puWb08VFtEW
         WirGBt5brRop85LZH8bAK4J19HimGdZOepnT+GtCx3QV5CLV6DY/ybDc1H48VGsi5wQr
         SBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bvH37TfwqoO2JLQdu07hHzOg/BejWk551fLqEumCMJ8=;
        b=SRvSfQl3lJaEPrVUMr8zotU1vd3tQ4eKkfYjc0thK7Yjs4UXe2PpcawTPEQ68cafOy
         jYwq1kEe5rXWLjsX0S7QOfoWRBRJ2jXcB4THCoRQudYmdPAtCcxfpVi6XMpthTWYEFmC
         nUtSckep9aIr27+FqiNv8iZUcsRQEqpFvMfMKELG64ltqzfso7Sv7JPjj5Tqutfc9hGu
         +/TroCoC96Ug7L61A9vyFY82lQsP87cnU1yhs7LNZiXvF9lDAzYY7LZjMVIvq38wvOlD
         MLn7SwuqKdi274r2ybCyiMCIpAQsh0KYcrjeuEDmiXLXYYHKt91u6XQp4saOqkD2nJF2
         jlAw==
X-Gm-Message-State: AJcUukfzA6ytkq3KyxzIPMQSawh07Hh3v7QLLqUTodBgfnkAjar1QG2i
        CHp0tq2/irYZr40Gbk+0xLk=
X-Google-Smtp-Source: ALg8bN6ph7r4zyszpZ+e/Jc/xp3GXUsSSPuB4+9AtDZe8Ea/OpuXYNtm/gILzYQzJqMxKGORzlXjAg==
X-Received: by 2002:a1c:47:: with SMTP id 68mr1485525wma.89.1546949163351;
        Tue, 08 Jan 2019 04:06:03 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id k135sm11192867wmd.42.2019.01.08.04.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 04:06:02 -0800 (PST)
Subject: Re: [PATCH v5 2/2] dt-bindings: spi: Document Renesas R-Car RPC-IF
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-3-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <05c8e4ac-a9c8-7c24-289f-ce7a089dbc1e@gmail.com>
Date:   Tue, 8 Jan 2019 12:52:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1546921020-20436-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 5:17 AM, Mason Yang wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..5f96532
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +----------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,r8a77995-rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "regs" and "dirmap"
> +- clock-names: should contain "rpc"
> +- clocks: should contain 1 entries for the module's clock
> +- renesas,rpc-mode: should contain "spi" for rpc spi mode or
> +			   	   "hyperflash" for rpc hyperflash mode.

Why do we need this property ? I believe it is possible to detect the
configuration based on the type of child of the RPC node. If the driver
was properly designed, it could well behave as either CFI NOR driver or
SPI flash driver and all would be good, but it seems this is written
with it being SPI flash driver only and once the HF mode would need to
be added, it'd mean a tremendous undertaking to rework the entire driver.

-- 
Best regards,
Marek Vasut
