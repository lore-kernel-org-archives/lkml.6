Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA67AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838062086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfARKkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:40:11 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36273 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARKkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:40:10 -0500
Received: by mail-ua1-f66.google.com with SMTP id j3so4526604uap.3;
        Fri, 18 Jan 2019 02:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NInJqGK5FOZEq8/Hj+ANjVwEmKzT6Ap6V44J2ZJdnsk=;
        b=tYeRKE2ZKqIH882fSdgHJ2Xdbn9d28RPAo8x+7Co3PiZrgDrdF2ykRVykRtxBPkKG1
         Fehbi21G0Kw1bJkEgGf48MK47tOOxhYk7wnsJzf0Q29NssEcPWi1PBtfY+fe8FK166kR
         muoMxFNZTflSw95XeNTxRKe10l41EHpnGs7a0t5bqKxTOMEsD7xx/gRo0hiBI2cSaLvN
         jJ2RiGXATnsBjA2PxPxSmgX7SyjQpvBVFem5RtlgWXuW6QUmJkOaSJlK/r8lkzjnTzrI
         usdHlQ5DXzTAeiH1pBt1j4oE0PAFJTm6WXl0uuwG0lXaNfT0/8xnPl2Y/wad38lhsWL2
         pcHw==
X-Gm-Message-State: AJcUukcK1jYIYPQ2pSK5sCNEMBB87p2yJU5pxBWXp+TQ8yN9LzWdS0Hm
        /zNW9zZKAhLKgRpjxNVeGrH/K33FWQ4J1nKr7tQ=
X-Google-Smtp-Source: ALg8bN47KWZjdo+pFrls6qfk5oxM7fmGcpQsUyqddCgNKa6IOT53Z5Ohyy2m117OnlQ1oz1+u+/tQ0A6b0jH+CJwvf0=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr7180308uae.75.1547808009337;
 Fri, 18 Jan 2019 02:40:09 -0800 (PST)
MIME-Version: 1.0
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com> <OFBD5366C8.433ADACB-ON48258386.00336667-48258386.00340E20@mxic.com.tw>
In-Reply-To: <OFBD5366C8.433ADACB-ON48258386.00336667-48258386.00340E20@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Jan 2019 11:39:57 +0100
Message-ID: <CAMuHMdXeYubQPJrDE_hUf-5hAVA7rMrDynbg3rCW3TpXEpVu+Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Fri, Jan 18, 2019 at 10:28 AM <masonccyang@mxic.com.tw> wrote:
> I modified this dts to:
>
> Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>  --------------------------------------------------------------------
>
>  Required properties:
>  - compatible: should be an SoC-specific compatible value, followed by
>                "renesas,rcar-gen3-rpc" as a fallback.

Please list the supported SoC-specific compatible values, so
scripts/checkpatch.pl
can validate patches adding RPC device nodes to DTS files.

>  - #address-cells: should be 1
>  - #size-cells: should be 0
>  - reg: should contain three register areas:
>          first for the base address of rpc-if registers,
>          second for the direct mapping read mode and
>          third for the write buffer area.
>  - reg-names: should contain "regs", "dirmap" and "wbuf"
>  - clock-names: should contain "rpc"
>  - clocks: should contain 1 entries for the module's clock

Please revert the order of clocks and clock-names, cfr. reg and reg-names.

>  Example:
>
>          rpc: rpc@ee200000 {
>                  compatible = "renesas,r8a7795-rpc", "renesas,rcar-gen3-rpc";
>                  reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>                        <0 0xee208000 0 0x100>;
>                  reg-names = "regs", "dirmap", "wbuf";
>                  clocks = <&cpg CPG_MOD 917>;
>                  power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>                  resets = <&cpg 917>;
>                  clock-names = "rpc";

Please move clock-names just below clocks.

>                  #address-cells = <1>;
>                  #size-cells = <0>;
>
>                  flash@0 {
>                          compatible = "jedec,spi-nor";
>                          reg = <0>;
>                          spi-max-frequency = <40000000>;
>                          spi-tx-bus-width = <1>;
>                          spi-rx-bus-width = <1>;
>                  };
>          };
>
>
> If it is ok and I will submit it in [PATCH v7 2/2].

Looks good, with the above changes made.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
