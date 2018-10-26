Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D5C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A34020848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A34020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJZKyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:54:38 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:34056 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeJZKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:54:38 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gFrih-00010s-I4 from Jiada_Wang@mentor.com ; Thu, 25 Oct 2018 19:19:27 -0700
Received: from [172.30.112.85] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 25 Oct
 2018 19:19:23 -0700
Subject: Re: [PATCH linux-next v1 3/4] arm64: ulcb: Add avb counter clock
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20181025072349.15173-1-jiada_wang@mentor.com>
 <20181025072349.15173-4-jiada_wang@mentor.com>
 <CAMuHMdUciu+SJR+CsrwzkdUtX3L82xAzqgtrybYmcq--sR7Wig@mail.gmail.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <1aff414d-14d4-9d94-1a42-b58a0ce48230@mentor.com>
Date:   Fri, 26 Oct 2018 11:19:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUciu+SJR+CsrwzkdUtX3L82xAzqgtrybYmcq--sR7Wig@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert

Thanks for your comment


On 2018/10/26 5:22, Geert Uytterhoeven wrote:
> Hi Jiada,
>
> On Thu, Oct 25, 2018 at 9:24 AM <jiada_wang@mentor.com> wrote:
>> From: Jiada Wang <jiada_wang@mentor.com>
>>
>> Add avb counter clock node to R-Car ULCB boards
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> Thanks for your patch!
>
>> --- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
>> @@ -32,6 +32,12 @@
>>                  clock-frequency = <12288000>;
>>          };
>>
>> +       clk_avb: avb-clock@ec5a011c {
>> +               compatible = "renesas,clk-avb";
>> +               reg = <0 0xec5a011c 0 0x24>;
>> +               #clock-cells = <1>;
>> +       };
>> +
>>          hdmi0-out {
>>                  compatible = "hdmi-connector";
>>                  type = "a";
> Why would this belong in the board .dtsi, not in the SoC .dtsi?
> (same for salvator-common.dtsi)
right, it belongs to Soc .dtsi, I will move it to each Soc .dtsi
> How is this intended to be used by the AVB?
R-Car audio can use AVB clock to support continuous clock rate,
with out AVB clock, currently only limited rates are supports by R-Car audio

Thanks,
Jiada
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

