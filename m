Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE6C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D7C20883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B4Z6rjvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D7C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbeKQHKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:10:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33275 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeKQHKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:10:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so15212059oib.0;
        Fri, 16 Nov 2018 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJaDY7bho0mtzTpBEkaK76jCU4w8wyT1x8uGBFWl6cQ=;
        b=B4Z6rjvK8XP+OQhB2n62SDU49+d6MfGke5C0Awo+Qi0dVqEJJq0k0jbd6slvTa5OdK
         HLQre+h1u+keD3Tjk7PPeE/Vm4rI78S5qaojK7ychwlEfe7YqTBxzprnF0nSfIEM0MKw
         +GxXdK99xVD6nWUETyXgFYxrvcsmVRhDPYC9Fd9eizWEgXSVbcGijonQo2/l33AVLHSY
         RkmWuxM6Rt/CGrH6VEv6Ie0JlKcbUTuxQ/pdfCG31fdJVTQszrR0vIAxz/uMEX6hpOc2
         SfiJEp5sWnNpt6W1v2NIOQBsPVwKWIkwLaNRYXr5nvVN/lLlVNKCetwFeu06SrD4Vkkh
         NsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJaDY7bho0mtzTpBEkaK76jCU4w8wyT1x8uGBFWl6cQ=;
        b=QTnBKHRo+Yhkgk6TD/xhxW+8Rlz+VZREJUKjbT/8PD4ZyDJhlKh6ODv2I/5y40RZSX
         UtTnyZLfyO1LPdCSJMxbg5axZdvgJs2+eUsU8vKVuHz3hH081TNPPPwz8trn5cBx5wGR
         mL3lT743CjKhQIqztNvCGVesmIahDXAzYbAP9tzZa4JfhO8v4+xVHEbWUvum7t9pfcHx
         Y844/fxn5Fyg51Hl/tfI71J0nkInjp8umI+uXE13lx6s42sgVtMCObTjXLY5PW/npmbx
         ckv8+M4jcLAtRT9gRtPVzhFOft+o8pkmLBya56uyvAaNtGxs4GID1sH+BN39d58MzbsT
         X/Zw==
X-Gm-Message-State: AGRZ1gL2Zty5in+4sIMbvLZiPzahBJGQIm0UsP7yw12hAhz2OTKl3lPp
        gUnnsdqWxJSEtxYINOrUSXomrJ2EhfdAYHqAP/o=
X-Google-Smtp-Source: AJdET5cEsIbzbYm08nezqsE4SCEH9E4LiAsLl2w1JSfzbKjWG/Z+hHg0WtfL3zEzkqJRhRcBJQY6NzZD2QR+k+y8Z3Y=
X-Received: by 2002:aca:6c87:: with SMTP id h129-v6mr1948456oic.140.1542401762323;
 Fri, 16 Nov 2018 12:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181116205303.6354-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 16 Nov 2018 21:55:51 +0100
Message-ID: <CAFBinCB7i9QdCchqx1sV+cpD6b8Bp9rgK9Z+yv1UovdX3kasUA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Meson8b: add the CPU clock post-dividers
To:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 9:53 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> This is the successor to my previous series "meson8b: add the CPU_DIV16
> clock for the ARM TWD" from [0]. I decided to not send this as v2 of
> the original series because the PERIPH clock is not the CPU_DIV16 clock.
> It's not clear whether a CPU_DIV16 clock exists.
>
> With this series we get all the CPU_CLK post-dividers as listed in the
> public S805 datasheet [1] on pages 31 and 32:
> - ABP
> - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> - AXI
> - L2 DRAM
>
> Each of these clocks has a register called "..._CLK_DIS" which is
> documented as a "just in case" bit:
> "Set to 1 to manually disable the [...] clock when changing the mux
> selection. Typically this bit is set to 0 since the clock muxes can
> switch without glitches."
> Since we're not supposed to touch that register we're setting
> CLK_IS_CRITICAL for these clocks in the driver.
>
> The result of this is that we can use the PERIPH clock which clocks
> the ARM TWD timer. I will send a separate series to add the TWD timer.
>
>
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
> [1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
>
> Martin Blumenstingl (3):
>   dt-bindings: clock: meson8b: export the CPU post dividers
>   clk: meson: meson8b: rename cpu_div2/cpu_div3 to
>     cpu_in_div2/cpu_in_div3
>   clk: meson: meson8b: add the CPU clock post divider clocks
I ran various tests for the PERIPH clock by enabling the TWD timer
without specifying a clock. In that case the TWD driver will try to
auto-detect the PERIPH clock rate. my results confirm that this
implementation is correct:

case #1: EC-100 with it's default boot settings:

[    0.000252] smp_twd: clock not found -2
[    0.000736] Calibrating local timer... 197.86MHz.

# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
             cpu_scale_out_sel        1        1        0   792000000
        0     0  50000
                cpu_clk               4        4        0   792000000
        0     0  50000
...
                   cpu_clk_div4       2        2        0   198000000
        0     0  50000
                      axi_clk_sel       1        1        0
198000000          0     0  50000
                         axi_clk_dis       1        1        0
198000000          0     0  50000
                      periph_clk_sel       1        1        0
198000000          0     0  50000
                         periph_clk_dis       1        1        0
198000000          0     0  50000
...


case #2: switch the parent of the cpu_in_sel clock to xtal:

m8b_m201_1G#md.l 0xC110419C 1
c110419c: 000000b1    ....
m8b_m201_1G#mw.l 0xC110419C 0xb0 1
m8b_m201_1G#md.l 0xC110419C
c110419c: 000000b0    ....

[    0.007005] smp_twd: clock not found -2
[    0.022680] Calibrating local timer... 5.98MHz.

# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
 xtal                                 4        4        0    24000000
        0     0  50000
...
    cpu_in_sel                        1        1        0    24000000
        0     0  50000
       cpu_scale_out_sel              1        1        0    24000000
        0     0  50000
          cpu_clk                     4        4        0    24000000
        0     0  50000
...
             cpu_clk_div4             2        2        0     6000000
        0     0  50000
                axi_clk_sel           1        1        0     6000000
        0     0  50000
                   axi_clk_dis        1        1        0     6000000
        0     0  50000
                periph_clk_sel        1        1        0     6000000
        0     0  50000
                   periph_clk_dis       1        1        0
6000000          0     0  50000
...


case #3: set cpu_scale_div to cpu_in_sel/6 and use cpu_scale_div as
parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#md.l 0xC110415C 1
c110415c: 800016a2    ....
m8b_m201_1G#mw.l 0xC110415C 0x802016A2 1
m8b_m201_1G#mw.l 0xC110419C 0xbd 1

[    0.001317] smp_twd: clock not found -2
[    0.003907] Calibrating local timer... 32.93MHz.


# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
             cpu_scale_div            1        1        0   132000000
        0     0  50000
                cpu_scale_out_sel       1        1        0
132000000          0     0  50000
                   cpu_clk            4        4        0   132000000
        0     0  50000
...
                      cpu_clk_div4       2        2        0
33000000          0     0  50000
                         axi_clk_sel       1        1        0
33000000          0     0  50000
                            axi_clk_dis       1        1        0
33000000          0     0  50000
                         periph_clk_sel       1        1        0
33000000          0     0  50000
                            periph_clk_dis       1        1        0
 33000000          0     0  50000
...


case #4: set cpu_scale_div to cpu_in_sel/4 and use cpu_scale_div as
parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#md.l 0xC110415C 1
c110415c: 800016a2    ....
m8b_m201_1G#mw.l 0xC110415C 0x801016A2 1
m8b_m201_1G#mw.l 0xC110419C 0xbd 1

[    0.001317] smp_twd: clock not found -2
[    0.002636] Calibrating local timer... 49.42MHz.

# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
             cpu_scale_div            1        1        0   198000000
        0     0  50000
                cpu_scale_out_sel       1        1        0
198000000          0     0  50000
                   cpu_clk            4        4        0   198000000
        0     0  50000
...
                      cpu_clk_div4       2        2        0
49500000          0     0  50000
                         axi_clk_sel       1        1        0
49500000          0     0  50000
                            axi_clk_dis       1        1        0
49500000          0     0  50000
                         periph_clk_sel       1        1        0
49500000          0     0  50000
                            periph_clk_dis       1        1        0
 49500000          0     0  50000
...


case #5: set cpu_scale_div to cpu_in_sel/12 and use cpu_scale_div as
parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#md.l 0xC110415C 1
c110415c: 800016a2    ....
m8b_m201_1G#mw.l 0xC110415C 0x805016A2 1
m8b_m201_1G#mw.l 0xC110419C 0xbd 1

[    0.001317] smp_twd: clock not found -2
[    0.007728] Calibrating local timer... 16.44MHz.


# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
             cpu_scale_div            1        1        0    66000000
        0     0  50000
                cpu_scale_out_sel       1        1        0
66000000          0     0  50000
                   cpu_clk            4        4        0    66000000
        0     0  50000
...
                      cpu_clk_div4       2        2        0
16500000          0     0  50000
                         axi_clk_sel       1        1        0
16500000          0     0  50000
                            axi_clk_dis       1        1        0
16500000          0     0  50000
                         periph_clk_sel       1        1        0
16500000          0     0  50000
                            periph_clk_dis       1        1        0
 16500000          0     0  50000
...


case #6: use cpu_div2 as parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#mw.l 0xC110419C 0x34 1
m8b_m201_1G#mw.l 0xC110419C 0xb5 1

[    0.000534] smp_twd: clock not found -2
[    0.001487] Calibrating local timer... 98.91MHz.


# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
                  duty
   clock                          count    count    count        rate
 accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
    sys_pll_dco                       1        1        0  1584000000
        0     0  50000
       sys_pll                        1        1        0   792000000
        0     0  50000
          cpu_in_sel                  1        1        0   792000000
        0     0  50000
...
             cpu_div2                 1        1        0   396000000
        0     0  50000
                cpu_scale_out_sel       1        1        0
396000000          0     0  50000
                   cpu_clk            4        4        0   396000000
        0     0  50000
...
                      cpu_clk_div4       2        2        0
99000000          0     0  50000
                         axi_clk_sel       1        1        0
99000000          0     0  50000
                            axi_clk_dis       1        1        0
99000000          0     0  50000
                         periph_clk_sel       1        1        0
99000000          0     0  50000
                            periph_clk_dis       1        1        0
 99000000          0     0  50000
...


case #7: use cpu_div3 as parent of cpu_scale_out_sel

m8b_m201_1G#mw.l 0xC110419C 0x30 1
m8b_m201_1G#mw.l 0xC110419C 0x38 1
m8b_m201_1G#mw.l 0xC110419C 0xb9 1

test skipped, the system is not stable with this clock as parent
