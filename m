Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yghAKmtMGlujXwAAmS7hNA
	; Fri, 08 Jun 2018 09:29:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D4486607E4; Fri,  8 Jun 2018 09:29:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aekt5PnE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4782A60275;
	Fri,  8 Jun 2018 09:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4782A60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeFHJ3d (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:29:33 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45615 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHJ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:29:30 -0400
Received: by mail-vk0-f65.google.com with SMTP id l64-v6so250874vkl.12;
        Fri, 08 Jun 2018 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xgQ0eoSrGw9rUA7o3+AnSS2W0bhCaBt43cOOWFcM3fo=;
        b=aekt5PnE73XpDajkNBZUhb/fyFDyD+ILGHa8dT5U/4G9fC4F/EbgQqFRgC5MiSbgCW
         timfzFJ4kMU0wAxRsfGLhuEi/UOQH9gPo/g+aGy8UqKv/k6GcxfhdErU8APvSCnnAwJy
         6/qu+25Nzi3aOPqvFTAyMvms0sQ6GNwkucPF50Hb+R8OhyRRhfyeAWlkCJ6YY7zANxnz
         1y2s6UwHOulybVcfFl1fBHcFK44Dw8qx+1RVdQS+i3pfDdKIyAk1KbzpMvbyqErGC8q1
         2Q38GzsWoC1memaa0mt50lK/cwixY/yWk3+fe/UL4W6Wdk6UF+wDlowyeF/XGDa4mSS8
         7GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xgQ0eoSrGw9rUA7o3+AnSS2W0bhCaBt43cOOWFcM3fo=;
        b=K2/hLD+0AyPFW8zqobM2enAizd70iZHK+RJKLZ6pmwEgiXo5yo0ovGYDonZNAAILg/
         oNrR8ws7wxw0aij/5DnAOqAVrYxLhTe86NCcjwdRPjyEKWiBbaR/Cexiu5drInyQyXTw
         6+dwYNBCN+2xva7kXaUA8Wu9lzCseZ136yOJirjBlzYMH2qjBSGjFBg29x5LK/NKgsoX
         tb6IgPeQvCE1cLKuN0Oi5jzhmTQx2ux2i28zU6z3dOMdT6WwdwWKMgpwPTZ5NdSwq7/w
         ZT3zQ64Frn8TEIG4UO9bZX3L/uSuItKBw3rTVjZnGNlo8hflwo1JQmZykMSa4dzeV1yW
         oZPQ==
X-Gm-Message-State: APt69E2d2NTeUsA0lo1RihrVG+N1ThIfb3TpaorMfbwgpkq9aorlTysY
        vjuCeBziBeuO3uwzUcrxCB0ASvYqwuWgVW9QBMY=
X-Google-Smtp-Source: ADUXVKLVo9hCwTsdwWzuZzTIJgBHFsS/hly6rVIztuJOE7YyidmHZPpcARV7IKdSxGeSBhs9/4pAfCRVZzmYueRef0E=
X-Received: by 2002:a1f:2cc6:: with SMTP id s189-v6mr3345092vks.106.1528450169675;
 Fri, 08 Jun 2018 02:29:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 02:29:29 -0700 (PDT)
In-Reply-To: <1787243.JuNJAuBqMb@avalon>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-12-kieran.bingham+renesas@ideasonboard.com> <1787243.JuNJAuBqMb@avalon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Jun 2018 11:29:29 +0200
X-Google-Sender-Auth: LYp1hNzyawo6IN5bwvsyHJ4d2H8
Message-ID: <CAMuHMdU7OyUvgNqbkjtHyb0LPjgTdPp_BBcGNbjiqfQUgCdMuw@mail.gmail.com>
Subject: Re: [PATCH 11/17] arm64: dts: r8a77965: Add VSP instances
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

CC Sergei (for V3H/V3M)

On Thu, Apr 26, 2018 at 11:11 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday, 26 April 2018 19:53:40 EEST Kieran Bingham wrote:
>> The r8a77965 has 4 VSP instances.
>>
>> Based on a similar patch of the R8A7796 device tree
>> by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> [Kieran: Rebased to top of tree, fixed sort orders]
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 44 +++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a77965.dtsi index
>> 1f44ed7c1b1c..e92e6b03333a 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi

>> @@ -1025,6 +1047,17 @@
>>                       resets = <&cpg 611>;
>>               };
>>
>> +             vspd0: vsp@fea20000 {
>> +                     compatible = "renesas,vsp2";
>> +                     reg = <0 0xfea20000 0 0x4000>;
>
> RFP2 has a CLUT so the register range needs to be extended. I'd recommend
> covering the entire space (0x8000) even if no LUT or CLU module is present.

Even on V3H/V3M, which have some part of the CLUT, and could do
with 0x5000?

Note that this makes it overlap with fcpvd0 on all R-Car Gen3 SoCs,
as mentioned by Simon on IRC.

>> +                     interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
>> +                     clocks = <&cpg CPG_MOD 623>;
>> +                     power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
>> +                     resets = <&cpg 623>;
>> +
>> +                     renesas,fcp = <&fcpvd0>;
>> +             };
>> +
>>               fcpvd0: fcp@fea27000 {
>>                       compatible = "renesas,fcpv";
>>                       reg = <0 0xfea27000 0 0x200>;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
