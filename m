Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92119C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F37920870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbC9rhhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F37920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeKTANQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:13:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52368 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbeKTANQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:13:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so5398859wmb.2;
        Mon, 19 Nov 2018 05:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qa4xC7rYAsHzxj8UuSkp3SNl2WJ8DKWZKlTSh3yiF0s=;
        b=UbC9rhhNd8h8dJ/4qEvOC8dVy5hooKHlsJ+zz2c9qYYJG1U0GLDILfQit0pGvu1g7p
         i4eYBJDUDoWwfoh3SWEMoqEVFh7GiXCr+rgo8FgVC1ma2z4lWXJmBTtsWyWO/izFX0aD
         uc2iDzE7i41DpR/GrJorzgofe6OAbFzlYXjcFffVgSpAJzD6cHzUjWw7rF4/gAqtA0BG
         x5gDZYwd8UY06zdgXaX6Ok6wZ2hXWrtn2PL390cxjwwZkMccMFg41NHPU1mTaCsHF+TH
         GFiGRRhsJPlYWNFIUK0j4gdn9K19zer+3fPT6WoJC5eEMz1kC7cqhKhsudXiMTNcV76/
         b8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qa4xC7rYAsHzxj8UuSkp3SNl2WJ8DKWZKlTSh3yiF0s=;
        b=MiIBFFQRonaPRpHy8UoWNkzMnXyQnrws1dXDC5Fq1no19nb8TYYzxxf/9mKBjKPNrg
         vWVCf4HVMO++3l/60zL4UjwYcm9G5LUhViKTBPY4RjDROqad9U+0QNJBZmj3qufxykKw
         eqNfhvxqa2S9+Z/LevLnZ3a5DwWP7uxkFgAH6MoeiatvmyAQZ8yFUAfyANeFWkDXpyYI
         hhvV/xa/zKcpvDijDoZuSsMQ21UuJXoq2myXZ61xBnkKSnk4NQSqum5yVCdzjacqQgCi
         Udal8tzBvdnkDAZuatj+/5BhrgJa/XXInBalHA5MjeMivNtNlUgEe3tjULokfok0K1oc
         +xaQ==
X-Gm-Message-State: AA+aEWaknFPlSvvsdtJAjmLO+/RdFUdKmmKXkfwivTa2CMgOnIA+l8R5
        XkuO5nG0KHMMkOy1aU61Y5o=
X-Google-Smtp-Source: AJdET5e4lQDNTplJfMZdfWLGkq8Xme3kTcBLLLY3JcMqBHo6QByBfgTTdsa/8h88o5E5hEy7oNftIw==
X-Received: by 2002:a1c:b94b:: with SMTP id j72mr6732843wmf.58.1542635373259;
        Mon, 19 Nov 2018 05:49:33 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id h127sm19045820wmd.31.2018.11.19.05.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 05:49:32 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
Date:   Mon, 19 Nov 2018 14:49:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 11:01 AM, Mason Yang wrote:
> Document the bindings used by the Renesas R-Car D3 RPC controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..8286cc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,33 @@
> +Renesas R-Car D3 RPC controller Device Tree Bindings
> +----------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,rpc-r8a77995"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "rpc_regs" and "dirmap"
> +- interrupts: interrupt line connected to the RPC SPI controller

Do you also plan to support the RPC HF mode ? And if so, how would that
look in the bindings ? I'd like to avoid having to redesign the bindings
later to handle both the SPI and HF modes.

The HF is roughly a CFI flash with different bus interface.

btw U-Boot has drivers for both the HF and SPI mode:
http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/mtd/renesas_rpc_hf.c
http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/spi/renesas_rpc_spi.c

> +- clock-names: should contain "clk_rpc"
> +- clocks: should contain 1 entries for the CPG Module 917 clocks
> +
> +Example:
> +
> +	rpc: spi@ee200000 {
> +		compatible = "renesas,rpc-r8a77995";
> +		reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
> +		reg-names = "rpc_regs", "dirmap";
> +		clocks = <&cpg CPG_MOD 917>;
> +		clock-names = "clk_rpc";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <1>;
> +		};
> +	};
> 


-- 
Best regards,
Marek Vasut
