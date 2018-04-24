Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDXOjA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:39:00 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:40065 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbeDXOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:38:47 -0400
X-Google-Smtp-Source: AB8JxZqFelefAxGyiY7Ihhw6WB0IDAgGqOOm1k1NY2X08TnVzTJJln5hLXjjdyNchTDtaGNXqVf6QA==
Subject: Re: [PATCH] ARM: tegra: fix ulpi regression on tegra20
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "marvin24@gmx.de" <marvin24@gmx.de>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20180219151252.29289-1-marcel@ziswiler.com>
 <6600596.BijQW1iq1K@ax5200p> <4f2ac009-8618-4b4d-e137-a5fd4907a56f@gmail.com>
 <1524521136.4493.70.camel@toradex.com>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <c0cb2620-91b5-8043-bb74-306dca0331eb@gmail.com>
Date: Tue, 24 Apr 2018 17:38:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524521136.4493.70.camel@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 24.04.2018 01:05, Marcel Ziswiler wrote:
> Hi Dmitry
> 
> On Fri, 2018-04-20 at 13:50 +0300, Dmitry Osipenko wrote:
>> ...
>> I managed to find CDEV clocks in TRM this time.
> 
> And where exactly in which TRM? In all my attempts at finding anything
> CDEV2 is just a pad group which includes the DAP_MCLK2 pad in question. 

That's the DEV2 clock you're talking about below.

>> Seems assigning CDEV2 clock to
>> "ulpi-link" was correct
> 
> Sorry, but I do really not see how you can get to any such conclusion.
> 
> Whatever that CDEV2 clock exactly is. Its offset 93 points towards the
> CLK_RST_CONTROLLER_CLK_OUT_ENB_U_0 register which has CLK_ENB_DEV2_OUT
> at bit position 29 reading "Enable clock to DEV2 pad". While the TRM
> misses further documenting what exactly that DEV2 pad should be I guess
> it may point towards our suspected DAP_MCLK2. So for some reason
> besides PLL_P_OUT4 which is what that pad is actually muxed to also
> some additional DEV2 pad clock needs enabling. In addition there would
> be a CLK_RST_CONTROLLER_MISC_CLK_ENB_0 register where one could also
> specify a DEV2_OSC_DIV_SEL but I would assume that one only applies if
> the pad in question being muxed to OSC which is not the case at least
> in all device trees I have looked at.
> 
>> and both CDEV2 and PLL_P_OUT4 should be enabled,
> 
> Agreed, basically the DAP_MCLK2 pad seems gated by an additional enable
> called CLK_ENB_DEV2_OUT.
> 
>> CDEV2
>> should gate the PLL_P_OUT4 that feeds USB HW and PLL_P_OUT4 should be
>> always-enabled because it is enabled by init_table, but apparently it
>> is getting
>> disabled erroneously.
> 
> At least that was the case back when I had trouble getting ULPI to work
> on T20. Strangely latest -next right now does no longer seem to suffer
> from that same issue even if my patch is reverted but as mentioned
> before nobody stops the required PLL_P_OUT4 which is what is actually
> driving DAP_MCLK2 to not be changed behind the scenes breaking the
> whole thing again.
> 
>> Marcel, could you please revert your patch, add
>> "trace_event=clk_enable,clk_disable,clk_set_parent tp_printk" to
>> kernels cmdline
>> and post the log?
> 
> Yes, the only difference in those traces is whether or not that non-
> existent CDEV2 clock is enabled or not:
> 
> [    1.897521] clk_enable: cdev2_fixed
> [    1.901008] clk_enable: cdev2
> 
> I also do have an explanation why it kept working in my case. Probably
> the boot ROM or U-Boot is already setting that bit.
> 
>> It looks like there is some clk framework bug,
> 
> My conclusion is that there should be a DAP_MCLK2 clock which is gated
> by that CLK_ENB_DEV2_OUT but really outputs a T20 internal clock
> according to its pin muxing which if set to OSC may be further divided
> down by DEV2_OSC_DIV_SEL.

Could be that DEV2_OSC_DIV_SEL is only relevant when DAP_MCLK2 is mux'ed to OSC.
Maybe Peter could clarify everything.

>> but just in case please also try
>> to apply this patch:
>>
>> diff --git a/drivers/clk/tegra/clk-tegra-periph.c
>> b/drivers/clk/tegra/clk-tegra-periph.c
>> index 2acba2986bc6..407bd0c0ac2f 100644
>> --- a/drivers/clk/tegra/clk-tegra-periph.c
>> +++ b/drivers/clk/tegra/clk-tegra-periph.c
>> @@ -1024,7 +1024,7 @@ static void __init init_pllp(void __iomem
>> *clk_base, void
>> __iomem *pmc_base,
>>                 if (dt_clk) {
>>                         clk =
>> tegra_clk_register_pll_out("pll_p_out4",
>>                                         "pll_p_out4_div", clk_base +
>> PLLP_OUTB,
>> -                                       17, 16, CLK_IGNORE_UNUSED |
>> +                                       17, 16, CLK_IS_CRITICAL |
>>                                         CLK_SET_RATE_PARENT, 0,
>>                                         &PLLP_OUTB_lock);
>>                         *dt_clk = clk;
> 
> I did not have to do any such but maybe that would at least prevent any
> further issues on PLL_P_OUT4. However I still believe this is kind of
> wrong as PLL_P_OUT4 is what drives DAP_MCLK2 in its current muxing
> which is connected to the ULPI transceivers REFCLK pin.
> 
> BTW: That pin is usually to be driven at 24 MHz and not 26 MHz which
> CDEV2 claims to be at.

Pin is driven by the PLL_P_OUT4, which is set to 24 MHz via the init_table. The
clock tree is invalid in that regards because Tegra's clock driver defines
non-existent "cdev2_fixed" 26 MHz clock source and sets it as a parent for the
"cdev2" clock, while "cdev2" should be a gate (and maybe divider?) for the real
parent clock (PLL_P_OUT4 in our case).

> What do you think?

It looks to me that a clock signal coming from the mux'ed CDEV2 pin is routed to
the DEV2 of CLK controller (which can gate it) and then it goes out to DAP_MCLK2.

PLL_P_OUT4 ---> PINMUX_CDEV2 ---> CLK_DEV2 ---> DAP_MCLK2

But it also could be that CLK_ENB_DEV2_OUT is indeed some internal
pinmux-related clock-gate. I think Peter should have a clue.

Anyway the implementation details do not really matter for us, what matters is
that PLL_P_OUT4 clk and DEV2 clk-gate must be enabled.

Seems indeed ideally would be to have DAP_MCLK2 for the USB controller's
"ulpi-link" clock and then DEV2 will be enable bit for the DAP_MCLK2. But also
information about parent clock of the DAP_MCLK2 needs to be conducted to the clk
driver via DT, that probably would require backward-incompatible change of the
binding which is undesirable.

One tolerable solution could be to remove fake "cdev2_fixed" clock in the driver
and hardcode PLL_P_OUT4 for the parent of "cdev2". (Note that cdev1 also has a
fake parent)

index 0ee56dd04cec..4708653dedeb 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -838,8 +838,7 @@ static void __init tegra20_periph_clk_init(void)
        clks[TEGRA20_CLK_CDEV1] = clk;

        /* cdev2 */
-       clk = clk_register_fixed_rate(NULL, "cdev2_fixed", NULL, 0, 26000000);
-       clk = tegra_clk_register_periph_gate("cdev2", "cdev2_fixed", 0,
+       clk = tegra_clk_register_periph_gate("cdev2", "pll_p_out4", 0,
                                    clk_base, 0, 93, periph_clk_enb_refcnt);
        clks[TEGRA20_CLK_CDEV2] = clk;


Now the real problem is that PLL_P_OUT4 was getting disabled. We had CDEV2 clock
in the DT for "ulpi-link" and PLL_P_OUT4 was permanently enabled (supposedly) by
the Tegra's clock driver using init_table. Apparently PLL_P_OUT4 was disabled on
SCLK re-parenting, as you mentioned in the commit description. This should be
considered as a bug because one of two purposes (permanently enable and setup
default clock rate) of the init_table is defeated.

Could you please try to bisect to the point when erroneous PLL_P_OUT4 disable
issue is fixed->broken? It is quite important to know what commit changed the
behaviour. If it was some common clk issue that got fixed - that should be a
good case for us, if it was some unrelated change that obscured the issue -
that's not good and we should go back and fix the real bug.
