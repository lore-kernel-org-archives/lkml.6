Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F70CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27A420850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMxY37O9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfARHKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:10:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41449 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfARHKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:10:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so5929475plm.8;
        Thu, 17 Jan 2019 23:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ieSd4tJvQpH/Zh+ShMVdXd0xFUuzbkCtoalJTuqaM0s=;
        b=kMxY37O93xsvj9Fpzo+qgODrD/kYzqNxgXhyUBY53+kN/mxCDqLEEq3sVVJ6IpxmBf
         XIP3h2HJRYRuTE+avO19/tTHKqXccucubfGtLMpzuscXLaP0hGh0O/vrXDV8tqMlXRVP
         8I6vH7jZ8fOE2i77UbAljWYZgzf7GeKKHotiZYkgpBymu9m54grEx4MRv94GpK9OhbVm
         8tAK0rJvOGJmNphMfDRwFDRtz5suqUDwQOJLENrb2Ib3ER2b8oKjrBO9owyvaZv7/Vnj
         h9QBwng0yMcNxxnN1DxyBqStWOjmoWNr1/E5gG8/fjbEkUec9NdfPKPR2ndxeuAxYlVj
         jJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ieSd4tJvQpH/Zh+ShMVdXd0xFUuzbkCtoalJTuqaM0s=;
        b=EB5npcIrBJF9dg68dix4Dns74SZvNpUpaf8N3XyAkTzs2nfEJRj5o0lx3rPO75QaQ/
         ALoQ9bHHGx0ZYGFWfxovxlokXQybnV2oxSMWH7VOfR9hbVBt7lqi6mejUYNq3CdwYi2S
         /UV0Fe8vyyeTw7rCpEyZ2h80K4RwT4QMELbRe2EcmyvesG+1nrvdtcVZe1b9A+RS72ql
         J9ZSm9o+wOAt6MbW3jO9FJ+ZEu01ZNFwHq/4oasg6YpdvwGExa+CglKtzbQ/WO7JuQIZ
         TKQ5vqjYsYRq4RV4sPAxUycr2/wsoCm5V5Vs9KroLtEJ4kbzT3qfdD3Qj/xs4Fjwl0U6
         7RoQ==
X-Gm-Message-State: AJcUukcyoAm8YAgfoyiKsJtmD9xmO2bUVZ5J2WFI7CTDNVLkAzB70iH3
        AwlMn8xTZKyzNHNnFy9ZTnQ=
X-Google-Smtp-Source: ALg8bN7YPAlEUbXQdHszBgarjYwvZ/x1+a9hKn5FGzwVpUoH7bR0dynaLJ0g4QFeNB6YRutRLCn9nA==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4mr18185565plb.191.1547795398868;
        Thu, 17 Jan 2019 23:09:58 -0800 (PST)
Received: from [192.168.42.184] ([103.44.164.150])
        by smtp.gmail.com with ESMTPSA id g3sm5951429pfe.37.2019.01.17.23.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:09:58 -0800 (PST)
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8367577a-9717-92e3-cbc8-8dee52876bcb@gmail.com>
Date:   Fri, 18 Jan 2019 07:16:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 6:54 AM, Mason Yang wrote:
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
> index 0000000..9b5001e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +----------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,rcar-gen3-rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain three register areas:
> +	first for the base address of rpc-if registers,
> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clock-names: should contain "rpc"
> +- clocks: should contain 1 entries for the module's clock
> +
> +Example:
> +
> +	rpc: rpc@ee200000 {
> +		compatible = "renesas,rcar-gen3-rpc";
> +		reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,

0x7fff should be 0x8000 , right ?

> +		      <0 0xee208000 0 0x100>;

Isn't the write buffer part of the RPC-IF register set ?

> +		reg-names = "regs", "dirmap", "<wbuf>;
> +		clocks = <&cpg CPG_MOD 917>;
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		clock-names = "rpc";
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
