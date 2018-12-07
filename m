Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74373C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A41F20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bMpQ1qHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A41F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLGQDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:03:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38274 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:03:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so3393943lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijcZ0IholacCWuSpndwu2LN3v0n3A7Dq+GW+yywTvVE=;
        b=bMpQ1qHZZy4mSbuAlrba317aposYGpOLNebPz13yufiMHRkOV5Aduu9gdw9GRVVvXi
         FMpRq+hU9Ax/ciLT5uXO0utXbHD9JE9uYJpquDmG0AbsrJqusq1q4LDcp/oExbT9qZCM
         44S93dX3TfgVVzfrLw+ykGlpNN2DJcJTx6G+ebZfOdA52Z6sIQxRgOQ3tMITpRi7+y53
         bzIH9+DipNMIzvXQ400t7QIGitsAN7BoziuElk/zu3k/EuPEoP+d2BbdzPtwrgqGl3GW
         tBM89wvfZ4DKewPwV6NSyyhqHJNieD2ATowIdFS6UkD4qNs17JERR1qXv0MwlWeqogTi
         N0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ijcZ0IholacCWuSpndwu2LN3v0n3A7Dq+GW+yywTvVE=;
        b=FUblLym8jCLPgWyhQTKMiMI6oRFghyrM4bUwycvVRdgw4nYzuAWZzl8cBcjIVojI0A
         tKznKrwsUXT8+cCtPMEQxOSIzcoDDwAuKNfOOKydPvgMQrCXm253vTyaInp5Ou33OHnR
         u6fXxeVfgTKM75gKJI+Dcymiw6OaoU3zW7cT0BD8oVMp1+tz1gh5dMVkbc/O7N6hu3KT
         4p/+MbmHg9uPDZXYNbKbnOnd/LIw8C317LDE4D34y3DtARL7njfj30UTgXvjnpEgXCVa
         W5rXJOK77/9X/aGY2exJ060y/UTp+LXUIeORA2s3X7yYDUE1BGsVUaqVVdYFdPQf3GjM
         ky2A==
X-Gm-Message-State: AA+aEWa73WtlYOZ1pd3PnGgbp3UV2iAvOuXL1kshZkIEbVJHQwSG08Xh
        Us79t0fxIOba0RjZTKQrvxhlbg==
X-Google-Smtp-Source: AFSGD/UNcYyj5krSEA2Si6EUXAOi/TUh93L2GTxh3yNwv5DU+hjQQB9IHT6a1q62NVDvHEe7KfuPhQ==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr1773592lfe.73.1544198593536;
        Fri, 07 Dec 2018 08:03:13 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.111])
        by smtp.gmail.com with ESMTPSA id x11sm737414lfd.81.2018.12.07.08.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 08:03:11 -0800 (PST)
Subject: Re: [PATCH v3 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b89fb13a-4fe2-d3ca-7e12-7ac6b11455f6@cogentembedded.com>
Date:   Fri, 7 Dec 2018 19:03:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/07/2018 02:13 PM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..a191f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,38 @@
> +Renesas R-Car Gen3 RPC controller Device Tree Bindings
> +------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,r8a77995-rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "rpc_regs" and "dirmap"

   Please drop this "rpc_" thing, I think "regs" should be enough.

> +- interrupts: interrupt line connected to the RPC controller
> +- clock-names: should contain "clk_rpc"

   Please drop this "clk_" thing. BTW, what's with the RPCD2 clock?

> +- clocks: should contain 1 entries for the module's clock
> +- rpc-mode: should contain "rpc-spi-flash" for rpc spi mode or
> +			   "rpc-hyperflash" for rpc hyerflash mode.

   I think the prop should be called "renesas,rpc-mode" and the values should be
just "spi" and "hyperflash". 

[...]

MBR, Sergei
