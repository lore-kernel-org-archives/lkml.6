Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80F6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB8920866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeL3Kzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 05:55:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:52284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbeL3Kzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 05:55:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 429C0AA5C;
        Sun, 30 Dec 2018 10:55:48 +0000 (UTC)
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio to
 register as a clk provider
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        linux-kernel@vger.kernel.org, starnight@g.ncu.edu.tw,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
Date:   Sun, 30 Dec 2018 11:55:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-spi, LAKML

Am 29.12.18 um 21:16 schrieb Andreas Färber:
> Am 29.12.18 um 20:25 schrieb Andreas Färber:
>> Am 12.10.18 um 18:26 schrieb Ben Whitten:
>>> +static int sx125x_register_clock_provider(struct sx125x_priv *priv)
>>> +{
>>> +	struct device *dev = priv->dev;
>>> +	struct clk_init_data init;
>>> +	const char *parent;
>>> +	int ret;
>>> +
>>> +	/* Disable CLKOUT */
>>> +	ret = sx125x_field_write(priv, F_CLK_OUT, 0);
>>> +	if (ret) {
>>> +		dev_err(dev, "unable to disable clkout\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* Register clock provider if expected in DTB */
>>> +	if (!of_find_property(dev->of_node, "#clock-cells", NULL))
>>> +		return 0;
>>> +
>>> +	dev_info(dev, "registering clkout\n");
>>> +
>>> +	parent = of_clk_get_parent_name(dev->of_node, 0);
>>> +	if (!parent) {
>>> +		dev_err(dev, "Unable to find parent clk\n");
>>> +		return -ENODEV;
[snip]
> `sudo ip link set lora2 up` froze my system, with both
> lora1 and lora2 being sx1301. [...]
> 
> Investigating...

I've bisected and confirmed that it was indeed this patch that regresses
for one of my SX1301 concentrators.

I noticed that this patch changed the behavior from writing the enable
bit only on one radio to also writing zero to the other. Default value
for the bit was enabled, so a functional change in theory. I therefore
tried enabling radio A clock output on the hanging one. However ...

I've posted a fix for our regmap_bus that lead to the sx125x writes not
taking effect. I.e., no clk_out was ever disabled. Otherwise only the
XOSC register writes were reordered compared to clock output enable, so
I spot no change to SX125x or SX130x registers that could cause this.

I've amended error handling and debug output (cf. below) and verified:

We never return from the sx125x_clkout_enable() performing the
regmap_field_write() on our regmap_bus, which in turn uses a SPI regmap
in sx1301_regmap_bus_read().

A notable difference between my two concentrators is that the working
one is using spi-gpio driver, the regressing one spi-sun6i.

Two things stood out in spi-sun6i: It uses a completion (I do not run
into its timeout warning!), and it uses clk_{get,set}_rate().

Given that observed symptoms were CPU stalls, workqueue hangs and RCU
problems, requiring a power-cycle to recover, I wonder whether we are
running into some atomic/locking issue with clk_enable()? Is it valid at
all to use SPI/regmap for clk_enable()? If it is, is there a known issue
specific to spi-sun6i (A64) in 4.20.0?
I already tried setting .disable_locking = true in both regmap_configs.
Any suggestions how to further debug?

Thanks,
Andreas

> [  473.605058] sx1301 spi0.0: SX1301 module probed
> [  474.394760] sx1301 spi1.0: SX1301 module probed
> [  485.637333] sx125x_con spi0.0-b: SX125x version: 21
> [  485.645801] sx125x_con spi0.0-b: registering clkout
> [  485.656684] sx125x_con spi0.0-b: SX125x module probed
> [  485.663789] sx125x_con spi0.0-a: SX125x version: 21
> [  485.677570] sx125x_con spi0.0-a: SX125x module probed
> [  485.685713] sx125x_con spi1.0-b: SX125x version: 21
> [  485.692210] sx125x_con spi1.0-b: registering clkout
> [  485.701712] sx125x_con spi1.0-b: SX125x module probed
> [  485.708067] sx125x_con spi1.0-a: SX125x version: 21
> [  485.718707] sx125x_con spi1.0-a: SX125x module probed
> [...]
> [ 4603.171814] sx125x_con spi0.0-b: enabling clkout
> [ 4603.697489] sx1301 spi0.0: AGC calibration firmware version 2
> [ 4603.703782] sx1301 spi0.0: starting calibration...
> [ 4606.030617] sx1301 spi0.0: AGC status: 87
> [ 4607.034555] sx1301 spi0.0: AGC firmware version 4
> [ 4607.039666] sx1301 spi0.0: ARB firmware version 1
> [...]
> [ 4628.196884] sx125x_con spi1.0-b: enabling clkout

[ 4096.183451] sx1301 spi1.0: sx1301_regmap_bus_read: radio B addr 0x10

There it does not return from its first SPI-backed regmap_write().

> [ 4968.763990] systemd[1]: systemd-udevd.service: State 'stop-sigterm'
> timed out. Killing.
> [ 4968.772167] systemd[1]: systemd-udevd.service: Killing process 455
> (systemd-udevd) with signal SIGKILL.
> [ 4968.782479] systemd[1]: systemd-logind.service: State 'stop-sigterm'
> timed out. Killing.
> [ 4968.790732] systemd[1]: systemd-logind.service: Killing process 642
> (systemd-logind) with signal SIGKILL.
> [ 5058.761523] systemd[1]: systemd-journald.service: State
> 'stop-sigabrt' timed out. Terminating.
> [ 5059.011507] systemd[1]: systemd-udevd.service: Processes still around
> after SIGKILL. Ignoring.
> [ 5059.021610] systemd[1]: systemd-logind.service: Processes still
> around after SIGKILL. Ignoring.
> [ 5149.009055] systemd[1]: systemd-journald.service: State
> 'stop-sigterm' timed out. Killing.
> [ 5149.017475] systemd[1]: systemd-journald.service: Killing process 440
> (systemd-journal) with signal SIGKILL.
> [ 5149.259029] systemd[1]: systemd-udevd.service: State
> 'stop-final-sigterm' timed out. Killing.
> [ 5259.871913] watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
> [(md-udevd):4380]
> [ 5259.871918] watchdog: BUG: soft lockup - CPU#1 stuck for 22s!
> [(d-logind):4379]
> [ 5259.871926] Modules linked in: lora_sx125x(O) lora_sx1301(O)
> lora_sx128x(O) lora_sx1276(O) lora_rf1276ts(O) lora_mm002(O)
> lora_ting01m(O) lora_rak811(O) lora_usi(O) lora_wimod(O) lora_rn2483(O)
> lora_dev(O) nllora(O) lora(O) af_packet nls_iso8859_1 nls_cp437 vfat fat
> realtek aes_ce_blk crypto_simd cryptd dwmac_sun8i stmmac_platform
> snd_soc_simple_card snd_soc_spdif_tx snd_soc_simple_card_utils stmmac
> aes_ce_cipher snd_soc_core spi_sun6i mdio_mux ac97_bus snd_pcm_dmaengine
> snd_pcm sunxi_wdt snd_timer crct10dif_ce snd ghash_ce aes_arm64
> soundcore spi_gpio spi_bitbang uio_pdrv_genirq sha2_ce uio sha256_arm64
> sha1_ce btrfs libcrc32c xor zlib_deflate raid6_pq mmc_block
> ohci_platform ehci_platform ohci_hcd sunxi phy_generic ehci_hcd
> musb_hdrc i2c_mv64xxx udc_core usbcore phy_sun4i_usb sunxi_mmc mmc_core
> sun6i_dma axp20x_regulator axp20x_pek axp20x_rsb sunxi_rsb axp20x sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 5259.879226] Modules linked in: lora_sx125x(O) lora_sx1301(O)
> lora_sx128x(O) lora_sx1276(O) lora_rf1276ts(O) lora_mm002(O)
> lora_ting01m(O) lora_rak811(O) lora_usi(O) lora_wimod(O) lora_rn2483(O)
> lora_dev(O) nllora(O) lora(O) af_packet nls_iso8859_1 nls_cp437 vfat fat
> realtek aes_ce_blk crypto_simd cryptd dwmac_sun8i stmmac_platform
> snd_soc_simple_card snd_soc_spdif_tx snd_soc_simple_card_utils stmmac
> aes_ce_cipher snd_soc_core spi_sun6i mdio_mux ac97_bus snd_pcm_dmaengine
> snd_pcm sunxi_wdt snd_timer crct10dif_ce snd ghash_ce aes_arm64
> soundcore spi_gpio spi_bitbang uio_pdrv_genirq sha2_ce uio sha256_arm64
> sha1_ce btrfs libcrc32c xor zlib_deflate raid6_pq mmc_block
> ohci_platform ehci_platform ohci_hcd sunxi phy_generic ehci_hcd
> musb_hdrc i2c_mv64xxx udc_core usbcore phy_sun4i_usb sunxi_mmc mmc_core
> sun6i_dma axp20x_regulator axp20x_pek axp20x_rsb sunxi_rsb axp20x sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 5259.886531] CPU: 1 PID: 4379 Comm: (d-logind) Tainted: G           O
>      4.20.0-1.gba5c149-default #1 openSUSE Tumbleweed (unreleased)
> [ 5259.967929] CPU: 3 PID: 4380 Comm: (md-udevd) Tainted: G           O
>      4.20.0-1.gba5c149-default #1 openSUSE Tumbleweed (unreleased)
> [ 5260.049319] Hardware name: sunxi sunxi/sunxi, BIOS 2019.01-rc1 12/11/2018
> [ 5260.061466] Hardware name: sunxi sunxi/sunxi, BIOS 2019.01-rc1 12/11/2018
> [ 5260.073615] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [ 5260.080389] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [ 5260.087174] pc : smp_call_function_many+0x31c/0x370
> [ 5260.091944] pc : smp_call_function_many+0x31c/0x370
> [ 5260.096722] lr : smp_call_function_many+0x2d8/0x370
> [ 5260.101589] lr : smp_call_function_many+0x2d8/0x370
> [ 5260.106453] sp : ffff00000f11bc10
> [ 5260.111320] sp : ffff00000f123c10
> [ 5260.116187] x29: ffff00000f11bc10 x28: 0000000000000180
> [ 5260.119494] x29: ffff00000f123c10 x28: 0000000000000180
> [ 5260.122801] x27: ffff0000092cb380 x26: ffff80007ff8f3f8
> [ 5260.128101] x27: ffff0000092cb380 x26: ffff80007ffc13f8
> [ 5260.133400] x25: 0000000000000000 x24: ffff000008188608
> [ 5260.138701] x25: 0000000000000000 x24: ffff000008188608
> [ 5260.144001] x23: 0000000000000001 x22: ffff00000967a614
> [ 5260.149301] x23: 0000000000000001 x22: ffff00000967a614
> [ 5260.154601] x21: ffff000009679738 x20: ffff80007ff8f3c8
> [ 5260.159901] x21: ffff000009679738 x20: ffff80007ffc13c8
> [ 5260.165201] x19: ffff80007ff8f3c0 x18: 0000000000000000
> [ 5260.170501] x19: ffff80007ffc13c0 x18: ffff80007ffbdb80
> [ 5260.175800] x17: 0000000000000000 x16: 0000000000000000
> [ 5260.181100] x17: 0000000000000000 x16: ffff80007ffb1fe0
> [ 5260.186400] x15: 0000000000000000 x14: 0005006100000006
> [ 5260.191700] x15: 000000008287d0ce x14: 0000000026c4ee0b
> [ 5260.197000] x13: 0000000100010035 x12: 0140000000000000
> [ 5260.202299] x13: 000000003dddfe6f x12: 0000000021da966e
> [ 5260.207600] x11: 0040000000000001 x10: ffff0000017d2000
> [ 5260.212899] x11: 00000000c5ebf508 x10: 000000009b8ba2f7
> [ 5260.218199] x9 : 0000000000000000 x8 : 0000000000000006
> [ 5260.223499] x9 : 00000000644f2575 x8 : 0000000000000006
> [ 5260.228798] x7 : 0000000000000000 x6 : ffff80007ffcafe0
> [ 5260.234098] x7 : 0000000000000000 x6 : ffff7dffbffbfc40
> [ 5260.239399] x5 : ffff80007ffcafe0 x4 : 000000000000000d
> [ 5260.244698] x5 : ffff7dffbffbfc40 x4 : 0000000000000007
> [ 5260.249998] x3 : 0000000000000000 x2 : ffff80007ff7fff8
> [ 5260.255298] x3 : 0000000000000000 x2 : ffff7dffbff8dc58
> [ 5260.260598] x1 : 0000000000000003 x0 : 0000000000000000
> [ 5260.265897] x1 : 0000000000000003 x0 : 0000000000000000
> [ 5260.271197] Call trace:
> [ 5260.276496] Call trace:
> [ 5260.281799]  smp_call_function_many+0x31c/0x370
> [ 5260.284239]  smp_call_function_many+0x31c/0x370
> [ 5260.286680]  kick_all_cpus_sync+0x30/0x38
> [ 5260.291199]  kick_all_cpus_sync+0x30/0x38
> [ 5260.295722]  bpf_int_jit_compile+0x14c/0x420
> [ 5260.299720]  bpf_int_jit_compile+0x14c/0x420
> [ 5260.303721]  bpf_prog_select_runtime+0xec/0x138
> [ 5260.307979]  bpf_prog_select_runtime+0xec/0x138
> [ 5260.312243]  bpf_prepare_filter+0x468/0x520
> [ 5260.316760]  bpf_prepare_filter+0x468/0x520
> [ 5260.321280]  bpf_prog_create_from_user+0xe0/0x188
> [ 5260.325453]  bpf_prog_create_from_user+0xe0/0x188
> [ 5260.329628]  do_seccomp+0x2a0/0x6a0
> [ 5260.334319]  do_seccomp+0x2a0/0x6a0
> [ 5260.339012]  __arm64_sys_seccomp+0x28/0x38
> [ 5260.342492]  __arm64_sys_seccomp+0x28/0x38
> [ 5260.345974]  el0_svc_common+0x98/0x100
> [ 5260.350060]  el0_svc_common+0x98/0x100
> [ 5260.354145]  el0_svc_handler+0x38/0x78
> [ 5260.357885]  el0_svc_handler+0x38/0x78
> [ 5260.361625]  el0_svc+0x8/0xc
> [ 5260.365364]  el0_svc+0x8/0xc
> [ 5287.871131] watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
> [(md-udevd):4380]
> [ 5287.871135] watchdog: BUG: soft lockup - CPU#1 stuck for 22s!
> [(d-logind):4379]
> [ 5287.871139] Modules linked in: lora_sx125x(O) lora_sx1301(O)
> lora_sx128x(O) lora_sx1276(O) lora_rf1276ts(O) lora_mm002(O)
> lora_ting01m(O) lora_rak811(O) lora_usi(O) lora_wimod(O) lora_rn2483(O)
> lora_dev(O) nllora(O) lora(O) af_packet nls_iso8859_1 nls_cp437 vfat fat
> realtek aes_ce_blk crypto_simd cryptd dwmac_sun8i stmmac_platform
> snd_soc_simple_card snd_soc_spdif_tx snd_soc_simple_card_utils stmmac
> aes_ce_cipher snd_soc_core spi_sun6i mdio_mux ac97_bus snd_pcm_dmaengine
> snd_pcm sunxi_wdt snd_timer crct10dif_ce snd ghash_ce aes_arm64
> soundcore spi_gpio spi_bitbang uio_pdrv_genirq sha2_ce uio sha256_arm64
> sha1_ce btrfs libcrc32c xor zlib_deflate raid6_pq mmc_block
> ohci_platform ehci_platform ohci_hcd sunxi phy_generic ehci_hcd
> musb_hdrc i2c_mv64xxx udc_core usbcore phy_sun4i_usb sunxi_mmc mmc_core
> sun6i_dma axp20x_regulator axp20x_pek axp20x_rsb sunxi_rsb axp20x sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 5287.878433] Modules linked in: lora_sx125x(O) lora_sx1301(O)
> lora_sx128x(O) lora_sx1276(O) lora_rf1276ts(O) lora_mm002(O)
> lora_ting01m(O) lora_rak811(O) lora_usi(O) lora_wimod(O) lora_rn2483(O)
> lora_dev(O) nllora(O) lora(O) af_packet nls_iso8859_1 nls_cp437 vfat fat
> realtek aes_ce_blk crypto_simd cryptd dwmac_sun8i stmmac_platform
> snd_soc_simple_card snd_soc_spdif_tx snd_soc_simple_card_utils stmmac
> aes_ce_cipher snd_soc_core spi_sun6i mdio_mux ac97_bus snd_pcm_dmaengine
> snd_pcm sunxi_wdt snd_timer crct10dif_ce snd ghash_ce aes_arm64
> soundcore spi_gpio spi_bitbang uio_pdrv_genirq sha2_ce uio sha256_arm64
> sha1_ce btrfs libcrc32c xor zlib_deflate raid6_pq mmc_block
> ohci_platform ehci_platform ohci_hcd sunxi phy_generic ehci_hcd
> musb_hdrc i2c_mv64xxx udc_core usbcore phy_sun4i_usb sunxi_mmc mmc_core
> sun6i_dma axp20x_regulator axp20x_pek axp20x_rsb sunxi_rsb axp20x sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 5287.885735] CPU: 1 PID: 4379 Comm: (d-logind) Tainted: G           O
> L    4.20.0-1.gba5c149-default #1 openSUSE Tumbleweed (unreleased)
> [ 5287.967133] CPU: 3 PID: 4380 Comm: (md-udevd) Tainted: G           O
> L    4.20.0-1.gba5c149-default #1 openSUSE Tumbleweed (unreleased)
> [ 5288.048523] Hardware name: sunxi sunxi/sunxi, BIOS 2019.01-rc1 12/11/2018
> [ 5288.060670] Hardware name: sunxi sunxi/sunxi, BIOS 2019.01-rc1 12/11/2018
> [ 5288.072819] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [ 5288.079592] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [ 5288.086367] pc : smp_call_function_many+0x31c/0x370
> [ 5288.091147] pc : smp_call_function_many+0x31c/0x370
> [ 5288.095925] lr : smp_call_function_many+0x2d8/0x370
> [ 5288.100791] lr : smp_call_function_many+0x2d8/0x370
> [ 5288.105656] sp : ffff00000f11bc10
> [ 5288.110522] sp : ffff00000f123c10
> [ 5288.115389] x29: ffff00000f11bc10 x28: 0000000000000180
> [ 5288.118696] x29: ffff00000f123c10 x28: 0000000000000180
> [ 5288.122003] x27: ffff0000092cb380 x26: ffff80007ff8f3f8
> [ 5288.127303] x27: ffff0000092cb380 x26: ffff80007ffc13f8
> [ 5288.132602] x25: 0000000000000000 x24: ffff000008188608
> [ 5288.137902] x25: 0000000000000000 x24: ffff000008188608
> [ 5288.143202] x23: 0000000000000001 x22: ffff00000967a614
> [ 5288.148501] x23: 0000000000000001 x22: ffff00000967a614
> [ 5288.153802] x21: ffff000009679738 x20: ffff80007ff8f3c8
> [ 5288.159101] x21: ffff000009679738 x20: ffff80007ffc13c8
> [ 5288.164401] x19: ffff80007ff8f3c0 x18: 0000000000000000
> [ 5288.169701] x19: ffff80007ffc13c0 x18: ffff80007ffbdb80
> [ 5288.175000] x17: 0000000000000000 x16: 0000000000000000
> [ 5288.180300] x17: 0000000000000000 x16: ffff80007ffb1fe0
> [ 5288.185600] x15: 0000000000000000 x14: 0005006100000006
> [ 5288.190899] x15: 000000008287d0ce x14: 0000000026c4ee0b
> [ 5288.196200] x13: 0000000100010035 x12: 0140000000000000
> [ 5288.201500] x13: 000000003dddfe6f x12: 0000000021da966e
> [ 5288.206801] x11: 0040000000000001 x10: ffff0000017d2000
> [ 5288.212100] x11: 00000000c5ebf508 x10: 000000009b8ba2f7
> [ 5288.217400] x9 : 0000000000000000 x8 : 0000000000000006
> [ 5288.222700] x9 : 00000000644f2575 x8 : 0000000000000006
> [ 5288.228001] x7 : 0000000000000000 x6 : ffff80007ffcafe0
> [ 5288.233301] x7 : 0000000000000000 x6 : ffff7dffbffbfc40
> [ 5288.238601] x5 : ffff80007ffcafe0 x4 : 000000000000000d
> [ 5288.243901] x5 : ffff7dffbffbfc40 x4 : 0000000000000007
> [ 5288.249200] x3 : 0000000000000000 x2 : ffff80007ff7fff8
> [ 5288.254501] x3 : 0000000000000000 x2 : ffff7dffbff8dc58
> [ 5288.259800] x1 : 0000000000000003 x0 : 0000000000000000
> [ 5288.265100] x1 : 0000000000000003 x0 : 0000000000000000
> [ 5288.270399] Call trace:
> [ 5288.275699] Call trace:
> [ 5288.281002]  smp_call_function_many+0x31c/0x370
> [ 5288.283442]  smp_call_function_many+0x31c/0x370
> [ 5288.285881]  kick_all_cpus_sync+0x30/0x38
> [ 5288.290401]  kick_all_cpus_sync+0x30/0x38
> [ 5288.294921]  bpf_int_jit_compile+0x14c/0x420
> [ 5288.298921]  bpf_int_jit_compile+0x14c/0x420
> [ 5288.302920]  bpf_prog_select_runtime+0xec/0x138
> [ 5288.307180]  bpf_prog_select_runtime+0xec/0x138
> [ 5288.311441]  bpf_prepare_filter+0x468/0x520
> [ 5288.315961]  bpf_prepare_filter+0x468/0x520
> [ 5288.320481]  bpf_prog_create_from_user+0xe0/0x188
> [ 5288.324654]  bpf_prog_create_from_user+0xe0/0x188
> [ 5288.328827]  do_seccomp+0x2a0/0x6a0
> [ 5288.333520]  do_seccomp+0x2a0/0x6a0
> [ 5288.338213]  __arm64_sys_seccomp+0x28/0x38
> [ 5288.341694]  __arm64_sys_seccomp+0x28/0x38
> [ 5288.345175]  el0_svc_common+0x98/0x100
> [ 5288.349262]  el0_svc_common+0x98/0x100
> [ 5288.353349]  el0_svc_handler+0x38/0x78
> [ 5288.357089]  el0_svc_handler+0x38/0x78
> [ 5288.360827]  el0_svc+0x8/0xc
> [ 5288.364567]  el0_svc+0x8/0xc
> [ 5315.870363] watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
> [(md-udevd):4380]
> [ 5315.870367] watchdog: BUG: soft lockup - CPU#1 stuck for 22s!
> [(d-logind):4379]
> [ 5315.870371] Modules linked in: lora_sx125x(O) lora_sx1301(O)
> lora_sx128x(O) lora_sx1276(O) lora_rf1276ts(O) lora_mm002(O)
> lora_ting01m(O) lora_rak811(O) lora_usi(O) lora_wimod(O) lora_rn2483(O)
> lora_dev(O) nllora(O) lora(O) af_packet nls_iso8859_1 nls_cp437 vfat fat
> realtek aes_ce_blk crypto_simd cryptd dwmac_sun8i stmmac_platform
> snd_soc_simple_card snd_soc_spdif_tx snd_soc_simple_card_utils stmmac
> aes_ce_cipher snd_soc_core spi_sun6i mdio_mux ac97_bus snd_pcm_dmaengine
> snd_pcm sunxi_wdt snd_timer crct10dif_ce snd ghash_ce aes_arm64
> soundcore spi_gpio spi_bitbang uio_pdrv_genirq sha2_ce uio sha256_arm64
> sha1_ce btrfs libcrc32c xor zlib_deflate raid6_pq mmc_block
> ohci_platform ehci_platform ohci_hcd sunxi phy_generic ehci_hcd
> musb_hdrc i2c_mv64xxx udc_core usbcore phy_sun4i_usb sunxi_mmc mmc_core
> sun6i_dma axp20x_regulator axp20x_pek axp20x_rsb sunxi_rsb axp20x sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 5315.877665] Modules linked in: lora_sx125x(O) lora_sx1301(O)
> lora_sx128x(O) lora_sx1276(O) lora_rf1276ts(O) lora_mm002(O)
> lora_ting01m(O) lora_rak811(O) lora_usi(O) lora_wimod(O) lora_rn2483(O)
> lora_dev(O) nllora(O) lora(O) af_packet nls_iso8859_1 nls_cp437 vfat fat
> realtek aes_ce_blk crypto_simd cryptd dwmac_sun8i stmmac_platform
> snd_soc_simple_card snd_soc_spdif_tx snd_soc_simple_card_utils stmmac
> aes_ce_cipher snd_soc_core spi_sun6i mdio_mux ac97_bus snd_pcm_dmaengine
> snd_pcm sunxi_wdt snd_timer crct10dif_ce snd ghash_ce aes_arm64
> soundcore spi_gpio spi_bitbang uio_pdrv_genirq sha2_ce uio sha256_arm64
> sha1_ce btrfs libcrc32c xor zlib_deflate raid6_pq mmc_block
> ohci_platform ehci_platform ohci_hcd sunxi phy_generic ehci_hcd
> musb_hdrc i2c_mv64xxx udc_core usbcore phy_sun4i_usb sunxi_mmc mmc_core
> sun6i_dma axp20x_regulator axp20x_pek axp20x_rsb sunxi_rsb axp20x sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 5315.884967] CPU: 1 PID: 4379 Comm: (d-logind) Tainted: G           O
> L    4.20.0-1.gba5c149-default #1 openSUSE Tumbleweed (unreleased)
> [ 5315.966366] CPU: 3 PID: 4380 Comm: (md-udevd) Tainted: G           O
> L    4.20.0-1.gba5c149-default #1 openSUSE Tumbleweed (unreleased)
> [ 5316.047756] Hardware name: sunxi sunxi/sunxi, BIOS 2019.01-rc1 12/11/2018
> [ 5316.059904] Hardware name: sunxi sunxi/sunxi, BIOS 2019.01-rc1 12/11/2018
> [ 5316.072052] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [ 5316.078826] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [ 5316.085600] pc : smp_call_function_many+0x31c/0x370
> [ 5316.090379] pc : smp_call_function_many+0x31c/0x370
> [ 5316.095158] lr : smp_call_function_many+0x2d8/0x370
> [ 5316.100025] lr : smp_call_function_many+0x2d8/0x370
> [ 5316.104889] sp : ffff00000f11bc10
> [ 5316.109756] sp : ffff00000f123c10
> [ 5316.114623] x29: ffff00000f11bc10 x28: 0000000000000180
> [ 5316.117929] x29: ffff00000f123c10 x28: 0000000000000180
> [ 5316.121236] x27: ffff0000092cb380 x26: ffff80007ff8f3f8
> [ 5316.126536] x27: ffff0000092cb380 x26: ffff80007ffc13f8
> [ 5316.131835] x25: 0000000000000000 x24: ffff000008188608
> [ 5316.137135] x25: 0000000000000000 x24: ffff000008188608
> [ 5316.142435] x23: 0000000000000001 x22: ffff00000967a614
> [ 5316.147735] x23: 0000000000000001 x22: ffff00000967a614
> [ 5316.153035] x21: ffff000009679738 x20: ffff80007ff8f3c8
> [ 5316.158334] x21: ffff000009679738 x20: ffff80007ffc13c8
> [ 5316.163634] x19: ffff80007ff8f3c0 x18: 0000000000000000
> [ 5316.168934] x19: ffff80007ffc13c0 x18: ffff80007ffbdb80
> [ 5316.174234] x17: 0000000000000000 x16: 0000000000000000
> [ 5316.179533] x17: 0000000000000000 x16: ffff80007ffb1fe0
> [ 5316.184833] x15: 0000000000000000 x14: 0005006100000006
> [ 5316.190132] x15: 000000008287d0ce x14: 0000000026c4ee0b
> [ 5316.195432] x13: 0000000100010035 x12: 0140000000000000
> [ 5316.200732] x13: 000000003dddfe6f x12: 0000000021da966e
> [ 5316.206031] x11: 0040000000000001 x10: ffff0000017d2000
> [ 5316.211331] x11: 00000000c5ebf508 x10: 000000009b8ba2f7
> [ 5316.216630] x9 : 0000000000000000 x8 : 0000000000000006
> [ 5316.221930] x9 : 00000000644f2575 x8 : 0000000000000006
> [ 5316.227229] x7 : 0000000000000000 x6 : ffff80007ffcafe0
> [ 5316.232529] x7 : 0000000000000000 x6 : ffff7dffbffbfc40
> [ 5316.237829] x5 : ffff80007ffcafe0 x4 : 000000000000000d
> [ 5316.243128] x5 : ffff7dffbffbfc40 x4 : 0000000000000007
> [ 5316.248428] x3 : 0000000000000000 x2 : ffff80007ff7fff8
> [ 5316.253727] x3 : 0000000000000000 x2 : ffff7dffbff8dc58
> [ 5316.259027] x1 : 0000000000000003 x0 : 0000000000000000
> [ 5316.264327] x1 : 0000000000000003 x0 : 0000000000000000
> [ 5316.269626] Call trace:
> [ 5316.274926] Call trace:
> [ 5316.280228]  smp_call_function_many+0x31c/0x370
> [ 5316.282668]  smp_call_function_many+0x31c/0x370
> [ 5316.285107]  kick_all_cpus_sync+0x30/0x38
> [ 5316.289626]  kick_all_cpus_sync+0x30/0x38
> [ 5316.294146]  bpf_int_jit_compile+0x14c/0x420
> [ 5316.298145]  bpf_int_jit_compile+0x14c/0x420
> [ 5316.302144]  bpf_prog_select_runtime+0xec/0x138
> [ 5316.306405]  bpf_prog_select_runtime+0xec/0x138
> [ 5316.310665]  bpf_prepare_filter+0x468/0x520
> [ 5316.315185]  bpf_prepare_filter+0x468/0x520
> [ 5316.319705]  bpf_prog_create_from_user+0xe0/0x188
> [ 5316.323879]  bpf_prog_create_from_user+0xe0/0x188
> [ 5316.328051]  do_seccomp+0x2a0/0x6a0
> [ 5316.332744]  do_seccomp+0x2a0/0x6a0
> [ 5316.337438]  __arm64_sys_seccomp+0x28/0x38
> [ 5316.340918]  __arm64_sys_seccomp+0x28/0x38
> [ 5316.344400]  el0_svc_common+0x98/0x100
> [ 5316.348487]  el0_svc_common+0x98/0x100
> [ 5316.352573]  el0_svc_handler+0x38/0x78
> [ 5316.356313]  el0_svc_handler+0x38/0x78
> [ 5316.360051]  el0_svc+0x8/0xc
> [ 5316.363791]  el0_svc+0x8/0xc
> [ 5343.869595] watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
> [(md-udevd):4380]
> [ 5343.869599] watchdog: BUG: soft lockup - CPU#1 stuck for 22s!
> [(d-logind):4379]
> [ 5343.869603] Modules linked in: lora_sx125x(O) lora_sx1301(O)
> lora_sx128x(O) lora_sx1276(O) lora_rf1276ts(O) lora_mm002(O)
> lora_ting01m(O) lora_rak811(O) lora_usi(O) lora_wimod(O) lora_rn2483(O)
> lora_dev(O) nllora(O) lora(O) af_packet nls_iso8859_1 nls_cp437 vfat fat
> realtek aes_ce_blk crypto_simd cryptd dwmac_sun8i stmmac_platform
> snd_soc_simple_card snd_soc_spdif_tx snd_soc_simple_card_utils stmmac
> aes_ce_cipher snd_soc_core spi_sun6i mdio_mux ac97_bus snd_pcm_dmaengine
> snd_pcm sunxi_wdt snd_timer crct10dif_ce snd ghash_ce aes_arm64
> soundcore spi_gpio spi_bitbang uio_pdrv_genirq sha2_ce uio sha256_arm64
> sha1_ce btrfs libcrc32c xor zlib_deflate raid6_pq mmc_block
> ohci_platform ehci_platform ohci_hcd sunxi phy_generic ehci_hcd
> musb_hdrc i2c_mv64xxx udc_core usbcore phy_sun4i_usb sunxi_mmc mmc_core
> sun6i_dma axp20x_regulator axp20x_pek axp20x_rsb sunxi_rsb axp20x sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 5343.876897] Modules linked in: lora_sx125x(O) lora_sx1301(O)
> lora_sx128x(O) lora_sx1276(O) lora_rf1276ts(O) lora_mm002(O)
> lora_ting01m(O) lora_rak811(O) lora_usi(O) lora_wimod(O) lora_rn2483(O)
> lora_dev(O) nllora(O) lora(O) af_packet nls_iso8859_1 nls_cp437 vfat fat
> realtek aes_ce_blk crypto_simd cryptd dwmac_sun8i stmmac_platform
> snd_soc_simple_card snd_soc_spdif_tx snd_soc_simple_card_utils stmmac
> aes_ce_cipher snd_soc_core spi_sun6i mdio_mux ac97_bus snd_pcm_dmaengine
> snd_pcm sunxi_wdt snd_timer crct10dif_ce snd ghash_ce aes_arm64
> soundcore spi_gpio spi_bitbang uio_pdrv_genirq sha2_ce uio sha256_arm64
> sha1_ce btrfs libcrc32c xor zlib_deflate raid6_pq mmc_block
> ohci_platform ehci_platform ohci_hcd sunxi phy_generic ehci_hcd
> musb_hdrc i2c_mv64xxx udc_core usbcore phy_sun4i_usb sunxi_mmc mmc_core
> sun6i_dma axp20x_regulator axp20x_pek axp20x_rsb sunxi_rsb axp20x sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [ 5343.884200] CPU: 1 PID: 4379 Comm: (d-logind) Tainted: G           O
> L    4.20.0-1.gba5c149-default #1 openSUSE Tumbleweed (unreleased)
> [ 5343.965599] CPU: 3 PID: 4380 Comm: (md-udevd) Tainted: G           O
> L    4.20.0-1.gba5c149-default #1 openSUSE Tumbleweed (unreleased)
> [ 5344.046990] Hardware name: sunxi sunxi/sunxi, BIOS 2019.01-rc1 12/11/2018
> [ 5344.059138] Hardware name: sunxi sunxi/sunxi, BIOS 2019.01-rc1 12/11/2018
> [ 5344.071286] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [ 5344.078059] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [ 5344.084834] pc : smp_call_function_many+0x31c/0x370
> [ 5344.089614] pc : smp_call_function_many+0x31c/0x370
> [ 5344.094393] lr : smp_call_function_many+0x2d8/0x370
> [ 5344.099260] lr : smp_call_function_many+0x2d8/0x370
> [ 5344.104124] sp : ffff00000f11bc10
> [ 5344.108990] sp : ffff00000f123c10
> [ 5344.113858] x29: ffff00000f11bc10 x28: 0000000000000180
> [ 5344.117164] x29: ffff00000f123c10 x28: 0000000000000180
> [ 5344.120471] x27: ffff0000092cb380 x26: ffff80007ff8f3f8
> [ 5344.125771] x27: ffff0000092cb380 x26: ffff80007ffc13f8
> [ 5344.131071] x25: 0000000000000000 x24: ffff000008188608
> [ 5344.136371] x25: 0000000000000000 x24: ffff000008188608
> [ 5344.141670] x23: 0000000000000001 x22: ffff00000967a614
> [ 5344.146970] x23: 0000000000000001 x22: ffff00000967a614
> [ 5344.152270] x21: ffff000009679738 x20: ffff80007ff8f3c8
> [ 5344.157569] x21: ffff000009679738 x20: ffff80007ffc13c8
> [ 5344.162869] x19: ffff80007ff8f3c0 x18: 0000000000000000
> [ 5344.168169] x19: ffff80007ffc13c0 x18: ffff80007ffbdb80
> [ 5344.173469] x17: 0000000000000000 x16: 0000000000000000
> [ 5344.178768] x17: 0000000000000000 x16: ffff80007ffb1fe0
> [ 5344.184068] x15: 0000000000000000 x14: 0005006100000006
> [ 5344.189368] x15: 000000008287d0ce x14: 0000000026c4ee0b
> [ 5344.194668] x13: 0000000100010035 x12: 0140000000000000
> [ 5344.199967] x13: 000000003dddfe6f x12: 0000000021da966e
> [ 5344.205267] x11: 0040000000000001 x10: ffff0000017d2000
> [ 5344.210566] x11: 00000000c5ebf508 x10: 000000009b8ba2f7
> [ 5344.215866] x9 : 0000000000000000 x8 : 0000000000000006
> [ 5344.221165] x9 : 00000000644f2575 x8 : 0000000000000006
> [ 5344.226466] x7 : 0000000000000000 x6 : ffff80007ffcafe0
> [ 5344.231765] x7 : 0000000000000000 x6 : ffff7dffbffbfc40
> [ 5344.237065] x5 : ffff80007ffcafe0 x4 : 000000000000000d
> [ 5344.242365] x5 : ffff7dffbffbfc40 x4 : 0000000000000007
> [ 5344.247664] x3 : 0000000000000000 x2 : ffff80007ff7fff8
> [ 5344.252964] x3 : 0000000000000000 x2 : ffff7dffbff8dc58
> [ 5344.258265] x1 : 0000000000000003 x0 : 0000000000000000
> [ 5344.263564] x1 : 0000000000000003 x0 : 0000000000000000
> [ 5344.268863] Call trace:
> [ 5344.274164] Call trace:
> [ 5344.279467]  smp_call_function_many+0x31c/0x370
> [ 5344.281907]  smp_call_function_many+0x31c/0x370
> [ 5344.284346]  kick_all_cpus_sync+0x30/0x38
> [ 5344.288865]  kick_all_cpus_sync+0x30/0x38
> [ 5344.293386]  bpf_int_jit_compile+0x14c/0x420
> [ 5344.297385]  bpf_int_jit_compile+0x14c/0x420
> [ 5344.301384]  bpf_prog_select_runtime+0xec/0x138
> [ 5344.305644]  bpf_prog_select_runtime+0xec/0x138
> [ 5344.309905]  bpf_prepare_filter+0x468/0x520
> [ 5344.314426]  bpf_prepare_filter+0x468/0x520
> [ 5344.318946]  bpf_prog_create_from_user+0xe0/0x188
> [ 5344.323118]  bpf_prog_create_from_user+0xe0/0x188
> [ 5344.327291]  do_seccomp+0x2a0/0x6a0
> [ 5344.331985]  do_seccomp+0x2a0/0x6a0
> [ 5344.336678]  __arm64_sys_seccomp+0x28/0x38
> [ 5344.340158]  __arm64_sys_seccomp+0x28/0x38
> [ 5344.343638]  el0_svc_common+0x98/0x100
> [ 5344.347725]  el0_svc_common+0x98/0x100
> [ 5344.351812]  el0_svc_handler+0x38/0x78
> [ 5344.355551]  el0_svc_handler+0x38/0x78
> [ 5344.359290]  el0_svc+0x8/0xc
> [ 5344.363030]  el0_svc+0x8/0xc
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
