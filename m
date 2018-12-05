Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD6EC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C0620879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C0620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeLERDh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:37 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36528 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLERDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:35 -0500
Received: from ip-109-41-128-139.web.vodafone.de ([109.41.128.139] helo=[100.77.124.75])
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gUaZo-0000og-3I; Wed, 05 Dec 2018 18:03:14 +0100
Date:   Wed, 05 Dec 2018 18:03:00 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <201812052253.koYbL44I%fengguang.wu@intel.com>
References: <20181125175603.30592-1-katsuhiro@katsuster.net> <201812052253.koYbL44I%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] clk: rockchip: add clock gate of ACODEC for rk3328
To:     kbuild test robot <lkp@intel.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
CC:     kbuild-all@01.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Heiko Stuebner <heiko@sntech.de>
Message-ID: <9EB35BFB-8836-42F2-BB56-DFF3756D2B6C@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 5. Dezember 2018 15:18:40 MEZ schrieb kbuild test robot <lkp@intel.com>:
>Hi Katsuhiro,
>
>Thank you for the patch! Yet something to improve:
>
>[auto build test ERROR on rockchip/for-next]
>[also build test ERROR on v4.20-rc5]
>[cannot apply to next-20181204]
>[if your patch is applied to the wrong git tree, please drop us a note
>to help improve the system]
>
>url:   
>https://github.com/0day-ci/linux/commits/Katsuhiro-Suzuki/clk-rockchip-add-clock-gate-of-ACODEC-for-rk3328/20181126-085855
>base:  
>https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
>for-next
>config: arm64-defconfig (attached as .config)
>compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>reproduce:
>wget
>https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>-O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # save the attached .config to linux build tree
>        GCC_VERSION=7.2.0 make.cross ARCH=arm64 
>
>All errors (new ones prefixed by >>):
>
>   In file included from drivers/clk/rockchip/clk-rk3328.c:21:0:
>>> drivers/clk/rockchip/clk-rk3328.c:807:7: error: 'PCLK_ACODECPHY'
>undeclared here (not in a function); did you mean 'PCLK_HDMIPHY'?
>GATE(PCLK_ACODECPHY, "pclk_acodecphy", "pclk_phy_pre", 0,
>RK3328_CLKGATE_CON(17), 5, GFLAGS),
>          ^
> drivers/clk/rockchip/clk.h:666:10: note: in definition of macro 'GATE'
>      .id  = _id,    \
>             ^~~
>
There was a separate patch adding the id sent before this one, but Not part of a mail series. I have already applied both anyway ;-).

Heiko
>vim +807 drivers/clk/rockchip/clk-rk3328.c
>
>   242	
> 243	static struct rockchip_clk_branch rk3328_i2s0_fracmux __initdata =
>   244		MUX(0, "i2s0_pre", mux_i2s0_p, CLK_SET_RATE_PARENT,
>   245				RK3328_CLKSEL_CON(6), 8, 2, MFLAGS);
>   246	
> 247	static struct rockchip_clk_branch rk3328_i2s1_fracmux __initdata =
>   248		MUX(0, "i2s1_pre", mux_i2s1_p, CLK_SET_RATE_PARENT,
>   249				RK3328_CLKSEL_CON(8), 8, 2, MFLAGS);
>   250	
> 251	static struct rockchip_clk_branch rk3328_i2s2_fracmux __initdata =
>   252		MUX(0, "i2s2_pre", mux_i2s2_p, CLK_SET_RATE_PARENT,
>   253				RK3328_CLKSEL_CON(10), 8, 2, MFLAGS);
>   254	
>255	static struct rockchip_clk_branch rk3328_spdif_fracmux __initdata =
>   256		MUX(SCLK_SPDIF, "sclk_spdif", mux_spdif_p, CLK_SET_RATE_PARENT,
>   257				RK3328_CLKSEL_CON(12), 8, 2, MFLAGS);
>   258	
>259	static struct rockchip_clk_branch rk3328_uart0_fracmux __initdata =
>   260		MUX(SCLK_UART0, "sclk_uart0", mux_uart0_p, CLK_SET_RATE_PARENT,
>   261				RK3328_CLKSEL_CON(14), 8, 2, MFLAGS);
>   262	
>263	static struct rockchip_clk_branch rk3328_uart1_fracmux __initdata =
>   264		MUX(SCLK_UART1, "sclk_uart1", mux_uart1_p, CLK_SET_RATE_PARENT,
>   265				RK3328_CLKSEL_CON(16), 8, 2, MFLAGS);
>   266	
>267	static struct rockchip_clk_branch rk3328_uart2_fracmux __initdata =
>   268		MUX(SCLK_UART2, "sclk_uart2", mux_uart2_p, CLK_SET_RATE_PARENT,
>   269				RK3328_CLKSEL_CON(18), 8, 2, MFLAGS);
>   270	
>271	static struct rockchip_clk_branch rk3328_clk_branches[] __initdata
>= {
>   272		/*
>   273		 * Clock-Architecture Diagram 1
>   274		 */
>   275	
>   276		DIV(0, "clk_24m", "xin24m", CLK_IGNORE_UNUSED,
>   277				RK3328_CLKSEL_CON(2), 8, 5, DFLAGS),
>   278		COMPOSITE(SCLK_RTC32K, "clk_rtc32k", mux_2plls_xin24m_p, 0,
>   279				RK3328_CLKSEL_CON(38), 14, 2, MFLAGS, 0, 14, DFLAGS,
>   280				RK3328_CLKGATE_CON(0), 11, GFLAGS),
>   281	
>   282		/* PD_MISC */
>   283		MUX(HDMIPHY, "hdmiphy", mux_hdmiphy_p, CLK_SET_RATE_PARENT,
>   284				RK3328_MISC_CON, 13, 1, MFLAGS),
>   285		MUX(USB480M, "usb480m", mux_usb480m_p, CLK_SET_RATE_PARENT,
>   286				RK3328_MISC_CON, 15, 1, MFLAGS),
>   287	
>   288		/*
>   289		 * Clock-Architecture Diagram 2
>   290		 */
>   291	
>   292		/* PD_CORE */
>   293		GATE(0, "apll_core", "apll", CLK_IGNORE_UNUSED,
>   294				RK3328_CLKGATE_CON(0), 0, GFLAGS),
>   295		GATE(0, "gpll_core", "gpll", CLK_IGNORE_UNUSED,
>   296				RK3328_CLKGATE_CON(0), 2, GFLAGS),
>   297		GATE(0, "dpll_core", "dpll", CLK_IGNORE_UNUSED,
>   298				RK3328_CLKGATE_CON(0), 1, GFLAGS),
>   299		GATE(0, "npll_core", "npll", CLK_IGNORE_UNUSED,
>   300				RK3328_CLKGATE_CON(0), 12, GFLAGS),
>   301		COMPOSITE_NOMUX(0, "pclk_dbg", "armclk", CLK_IGNORE_UNUSED,
>   302				RK3328_CLKSEL_CON(1), 0, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
>   303				RK3328_CLKGATE_CON(7), 0, GFLAGS),
>   304		COMPOSITE_NOMUX(0, "aclk_core", "armclk", CLK_IGNORE_UNUSED,
>   305				RK3328_CLKSEL_CON(1), 4, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
>   306				RK3328_CLKGATE_CON(7), 1, GFLAGS),
>   307		GATE(0, "aclk_core_niu", "aclk_core", 0,
>   308				RK3328_CLKGATE_CON(13), 0, GFLAGS),
>   309		GATE(0, "aclk_gic400", "aclk_core", CLK_IGNORE_UNUSED,
>   310				RK3328_CLKGATE_CON(13), 1, GFLAGS),
>   311	
>   312		GATE(0, "clk_jtag", "jtag_clkin", CLK_IGNORE_UNUSED,
>   313				RK3328_CLKGATE_CON(7), 2, GFLAGS),
>   314	
>   315		/* PD_GPU */
>   316		COMPOSITE(0, "aclk_gpu_pre", mux_4plls_p, 0,
>   317				RK3328_CLKSEL_CON(44), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   318				RK3328_CLKGATE_CON(6), 6, GFLAGS),
>   319		GATE(ACLK_GPU, "aclk_gpu", "aclk_gpu_pre", CLK_SET_RATE_PARENT,
>   320				RK3328_CLKGATE_CON(14), 0, GFLAGS),
>   321		GATE(0, "aclk_gpu_niu", "aclk_gpu_pre", 0,
>   322				RK3328_CLKGATE_CON(14), 1, GFLAGS),
>   323	
>   324		/* PD_DDR */
>   325		COMPOSITE(0, "clk_ddr", mux_ddrphy_p, CLK_IGNORE_UNUSED,
>326				RK3328_CLKSEL_CON(3), 8, 2, MFLAGS, 0, 3, DFLAGS |
>CLK_DIVIDER_POWER_OF_TWO,
>   327				RK3328_CLKGATE_CON(0), 4, GFLAGS),
>   328		GATE(0, "clk_ddrmsch", "clk_ddr", CLK_IGNORE_UNUSED,
>   329				RK3328_CLKGATE_CON(18), 6, GFLAGS),
>   330		GATE(0, "clk_ddrupctl", "clk_ddr", CLK_IGNORE_UNUSED,
>   331				RK3328_CLKGATE_CON(18), 5, GFLAGS),
>   332		GATE(0, "aclk_ddrupctl", "clk_ddr", CLK_IGNORE_UNUSED,
>   333				RK3328_CLKGATE_CON(18), 4, GFLAGS),
>   334		GATE(0, "clk_ddrmon", "xin24m", CLK_IGNORE_UNUSED,
>   335				RK3328_CLKGATE_CON(0), 6, GFLAGS),
>   336	
>   337		COMPOSITE(PCLK_DDR, "pclk_ddr", mux_2plls_hdmiphy_p, 0,
>   338				RK3328_CLKSEL_CON(4), 13, 2, MFLAGS, 8, 3, DFLAGS,
>   339				RK3328_CLKGATE_CON(7), 4, GFLAGS),
>   340		GATE(0, "pclk_ddrupctl", "pclk_ddr", CLK_IGNORE_UNUSED,
>   341				RK3328_CLKGATE_CON(18), 1, GFLAGS),
>   342		GATE(0, "pclk_ddr_msch", "pclk_ddr", CLK_IGNORE_UNUSED,
>   343				RK3328_CLKGATE_CON(18), 2, GFLAGS),
>   344		GATE(0, "pclk_ddr_mon", "pclk_ddr", CLK_IGNORE_UNUSED,
>   345				RK3328_CLKGATE_CON(18), 3, GFLAGS),
>   346		GATE(0, "pclk_ddrstdby", "pclk_ddr", CLK_IGNORE_UNUSED,
>   347				RK3328_CLKGATE_CON(18), 7, GFLAGS),
>   348		GATE(0, "pclk_ddr_grf", "pclk_ddr", CLK_IGNORE_UNUSED,
>   349				RK3328_CLKGATE_CON(18), 9, GFLAGS),
>   350	
>   351		/*
>   352		 * Clock-Architecture Diagram 3
>   353		 */
>   354	
>   355		/* PD_BUS */
>   356		COMPOSITE(ACLK_BUS_PRE, "aclk_bus_pre", mux_2plls_hdmiphy_p, 0,
>   357				RK3328_CLKSEL_CON(0), 13, 2, MFLAGS, 8, 5, DFLAGS,
>   358				RK3328_CLKGATE_CON(8), 0, GFLAGS),
>  359		COMPOSITE_NOMUX(HCLK_BUS_PRE, "hclk_bus_pre", "aclk_bus_pre", 0,
>   360				RK3328_CLKSEL_CON(1), 8, 2, DFLAGS,
>   361				RK3328_CLKGATE_CON(8), 1, GFLAGS),
>  362		COMPOSITE_NOMUX(PCLK_BUS_PRE, "pclk_bus_pre", "aclk_bus_pre", 0,
>   363				RK3328_CLKSEL_CON(1), 12, 3, DFLAGS,
>   364				RK3328_CLKGATE_CON(8), 2, GFLAGS),
>   365		GATE(0, "pclk_bus", "pclk_bus_pre", 0,
>   366				RK3328_CLKGATE_CON(8), 3, GFLAGS),
>   367		GATE(0, "pclk_phy_pre", "pclk_bus_pre", 0,
>   368				RK3328_CLKGATE_CON(8), 4, GFLAGS),
>   369	
>   370		COMPOSITE(SCLK_TSP, "clk_tsp", mux_2plls_p, 0,
>   371				RK3328_CLKSEL_CON(21), 15, 1, MFLAGS, 8, 5, DFLAGS,
>   372				RK3328_CLKGATE_CON(2), 5, GFLAGS),
>   373		GATE(0, "clk_hsadc_tsp", "ext_gpio3a2", 0,
>   374				RK3328_CLKGATE_CON(17), 13, GFLAGS),
>   375	
>   376		/* PD_I2S */
>   377		COMPOSITE(0, "clk_i2s0_div", mux_2plls_p, 0,
>   378				RK3328_CLKSEL_CON(6), 15, 1, MFLAGS, 0, 7, DFLAGS,
>   379				RK3328_CLKGATE_CON(1), 1, GFLAGS),
>380		COMPOSITE_FRACMUX(0, "clk_i2s0_frac", "clk_i2s0_div",
>CLK_SET_RATE_PARENT,
>   381				RK3328_CLKSEL_CON(7), 0,
>   382				RK3328_CLKGATE_CON(1), 2, GFLAGS,
>   383				&rk3328_i2s0_fracmux),
>   384		GATE(SCLK_I2S0, "clk_i2s0", "i2s0_pre", CLK_SET_RATE_PARENT,
>   385				RK3328_CLKGATE_CON(1), 3, GFLAGS),
>   386	
>   387		COMPOSITE(0, "clk_i2s1_div", mux_2plls_p, 0,
>   388				RK3328_CLKSEL_CON(8), 15, 1, MFLAGS, 0, 7, DFLAGS,
>   389				RK3328_CLKGATE_CON(1), 4, GFLAGS),
>390		COMPOSITE_FRACMUX(0, "clk_i2s1_frac", "clk_i2s1_div",
>CLK_SET_RATE_PARENT,
>   391				RK3328_CLKSEL_CON(9), 0,
>   392				RK3328_CLKGATE_CON(1), 5, GFLAGS,
>   393				&rk3328_i2s1_fracmux),
>   394		GATE(SCLK_I2S1, "clk_i2s1", "i2s1_pre", CLK_SET_RATE_PARENT,
>   395				RK3328_CLKGATE_CON(0), 6, GFLAGS),
>   396		COMPOSITE_NODIV(SCLK_I2S1_OUT, "i2s1_out", mux_i2s1out_p, 0,
>   397				RK3328_CLKSEL_CON(8), 12, 1, MFLAGS,
>   398				RK3328_CLKGATE_CON(1), 7, GFLAGS),
>   399	
>   400		COMPOSITE(0, "clk_i2s2_div", mux_2plls_p, 0,
>   401				RK3328_CLKSEL_CON(10), 15, 1, MFLAGS, 0, 7, DFLAGS,
>   402				RK3328_CLKGATE_CON(1), 8, GFLAGS),
>403		COMPOSITE_FRACMUX(0, "clk_i2s2_frac", "clk_i2s2_div",
>CLK_SET_RATE_PARENT,
>   404				RK3328_CLKSEL_CON(11), 0,
>   405				RK3328_CLKGATE_CON(1), 9, GFLAGS,
>   406				&rk3328_i2s2_fracmux),
>   407		GATE(SCLK_I2S2, "clk_i2s2", "i2s2_pre", CLK_SET_RATE_PARENT,
>   408				RK3328_CLKGATE_CON(1), 10, GFLAGS),
>   409		COMPOSITE_NODIV(SCLK_I2S2_OUT, "i2s2_out", mux_i2s2out_p, 0,
>   410				RK3328_CLKSEL_CON(10), 12, 1, MFLAGS,
>   411				RK3328_CLKGATE_CON(1), 11, GFLAGS),
>   412	
>   413		COMPOSITE(0, "clk_spdif_div", mux_2plls_p, 0,
>   414				RK3328_CLKSEL_CON(12), 15, 1, MFLAGS, 0, 7, DFLAGS,
>   415				RK3328_CLKGATE_CON(1), 12, GFLAGS),
>416		COMPOSITE_FRACMUX(0, "clk_spdif_frac", "clk_spdif_div",
>CLK_SET_RATE_PARENT,
>   417				RK3328_CLKSEL_CON(13), 0,
>   418				RK3328_CLKGATE_CON(1), 13, GFLAGS,
>   419				&rk3328_spdif_fracmux),
>   420	
>   421		/* PD_UART */
>   422		COMPOSITE(0, "clk_uart0_div", mux_2plls_u480m_p, 0,
>   423				RK3328_CLKSEL_CON(14), 12, 2, MFLAGS, 0, 7, DFLAGS,
>   424				RK3328_CLKGATE_CON(1), 14, GFLAGS),
>   425		COMPOSITE(0, "clk_uart1_div", mux_2plls_u480m_p, 0,
>   426				RK3328_CLKSEL_CON(16), 12, 2, MFLAGS, 0, 7, DFLAGS,
>   427				RK3328_CLKGATE_CON(2), 0, GFLAGS),
>   428		COMPOSITE(0, "clk_uart2_div", mux_2plls_u480m_p, 0,
>   429				RK3328_CLKSEL_CON(18), 12, 2, MFLAGS, 0, 7, DFLAGS,
>   430				RK3328_CLKGATE_CON(2), 2, GFLAGS),
>431		COMPOSITE_FRACMUX(0, "clk_uart0_frac", "clk_uart0_div",
>CLK_SET_RATE_PARENT,
>   432				RK3328_CLKSEL_CON(15), 0,
>   433				RK3328_CLKGATE_CON(1), 15, GFLAGS,
>   434				&rk3328_uart0_fracmux),
>435		COMPOSITE_FRACMUX(0, "clk_uart1_frac", "clk_uart1_div",
>CLK_SET_RATE_PARENT,
>   436				RK3328_CLKSEL_CON(17), 0,
>   437				RK3328_CLKGATE_CON(2), 1, GFLAGS,
>   438				&rk3328_uart1_fracmux),
>439		COMPOSITE_FRACMUX(0, "clk_uart2_frac", "clk_uart2_div",
>CLK_SET_RATE_PARENT,
>   440				RK3328_CLKSEL_CON(19), 0,
>   441				RK3328_CLKGATE_CON(2), 3, GFLAGS,
>   442				&rk3328_uart2_fracmux),
>   443	
>   444		/*
>   445		 * Clock-Architecture Diagram 4
>   446		 */
>   447	
>   448		COMPOSITE(SCLK_I2C0, "clk_i2c0", mux_2plls_p, 0,
>   449				RK3328_CLKSEL_CON(34), 7, 1, MFLAGS, 0, 7, DFLAGS,
>   450				RK3328_CLKGATE_CON(2), 9, GFLAGS),
>   451		COMPOSITE(SCLK_I2C1, "clk_i2c1", mux_2plls_p, 0,
>   452				RK3328_CLKSEL_CON(34), 15, 1, MFLAGS, 8, 7, DFLAGS,
>   453				RK3328_CLKGATE_CON(2), 10, GFLAGS),
>   454		COMPOSITE(SCLK_I2C2, "clk_i2c2", mux_2plls_p, 0,
>   455				RK3328_CLKSEL_CON(35), 7, 1, MFLAGS, 0, 7, DFLAGS,
>   456				RK3328_CLKGATE_CON(2), 11, GFLAGS),
>   457		COMPOSITE(SCLK_I2C3, "clk_i2c3", mux_2plls_p, 0,
>   458				RK3328_CLKSEL_CON(35), 15, 1, MFLAGS, 8, 7, DFLAGS,
>   459				RK3328_CLKGATE_CON(2), 12, GFLAGS),
>   460		COMPOSITE(SCLK_CRYPTO, "clk_crypto", mux_2plls_p, 0,
>   461				RK3328_CLKSEL_CON(20), 7, 1, MFLAGS, 0, 7, DFLAGS,
>   462				RK3328_CLKGATE_CON(2), 4, GFLAGS),
>   463		COMPOSITE_NOMUX(SCLK_TSADC, "clk_tsadc", "clk_24m", 0,
>   464				RK3328_CLKSEL_CON(22), 0, 10, DFLAGS,
>   465				RK3328_CLKGATE_CON(2), 6, GFLAGS),
>   466		COMPOSITE_NOMUX(SCLK_SARADC, "clk_saradc", "clk_24m", 0,
>   467				RK3328_CLKSEL_CON(23), 0, 10, DFLAGS,
>   468				RK3328_CLKGATE_CON(2), 14, GFLAGS),
>   469		COMPOSITE(SCLK_SPI, "clk_spi", mux_2plls_p, 0,
>   470				RK3328_CLKSEL_CON(24), 7, 1, MFLAGS, 0, 7, DFLAGS,
>   471				RK3328_CLKGATE_CON(2), 7, GFLAGS),
>   472		COMPOSITE(SCLK_PWM, "clk_pwm", mux_2plls_p, 0,
>   473				RK3328_CLKSEL_CON(24), 15, 1, MFLAGS, 8, 7, DFLAGS,
>   474				RK3328_CLKGATE_CON(2), 8, GFLAGS),
>   475		COMPOSITE(SCLK_OTP, "clk_otp", mux_2plls_xin24m_p, 0,
>   476				RK3328_CLKSEL_CON(4), 6, 2, MFLAGS, 0, 6, DFLAGS,
>   477				RK3328_CLKGATE_CON(3), 8, GFLAGS),
>   478		COMPOSITE(SCLK_EFUSE, "clk_efuse", mux_2plls_xin24m_p, 0,
>   479				RK3328_CLKSEL_CON(5), 14, 2, MFLAGS, 8, 5, DFLAGS,
>   480				RK3328_CLKGATE_CON(2), 13, GFLAGS),
>481		COMPOSITE(SCLK_PDM, "clk_pdm", mux_cpll_gpll_apll_p,
>CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>   482				RK3328_CLKSEL_CON(20), 14, 2, MFLAGS, 8, 5, DFLAGS,
>   483				RK3328_CLKGATE_CON(2), 15, GFLAGS),
>   484	
>   485		GATE(SCLK_TIMER0, "sclk_timer0", "xin24m", 0,
>   486				RK3328_CLKGATE_CON(8), 5, GFLAGS),
>   487		GATE(SCLK_TIMER1, "sclk_timer1", "xin24m", 0,
>   488				RK3328_CLKGATE_CON(8), 6, GFLAGS),
>   489		GATE(SCLK_TIMER2, "sclk_timer2", "xin24m", 0,
>   490				RK3328_CLKGATE_CON(8), 7, GFLAGS),
>   491		GATE(SCLK_TIMER3, "sclk_timer3", "xin24m", 0,
>   492				RK3328_CLKGATE_CON(8), 8, GFLAGS),
>   493		GATE(SCLK_TIMER4, "sclk_timer4", "xin24m", 0,
>   494				RK3328_CLKGATE_CON(8), 9, GFLAGS),
>   495		GATE(SCLK_TIMER5, "sclk_timer5", "xin24m", 0,
>   496				RK3328_CLKGATE_CON(8), 10, GFLAGS),
>   497	
>   498		COMPOSITE(SCLK_WIFI, "clk_wifi", mux_2plls_u480m_p, 0,
>   499				RK3328_CLKSEL_CON(52), 6, 2, MFLAGS, 0, 6, DFLAGS,
>   500				RK3328_CLKGATE_CON(0), 10, GFLAGS),
>   501	
>   502		/*
>   503		 * Clock-Architecture Diagram 5
>   504		 */
>   505	
>   506		/* PD_VIDEO */
>   507		COMPOSITE(ACLK_RKVDEC_PRE, "aclk_rkvdec_pre", mux_4plls_p, 0,
>   508				RK3328_CLKSEL_CON(48), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   509				RK3328_CLKGATE_CON(6), 0, GFLAGS),
>510		FACTOR_GATE(HCLK_RKVDEC_PRE, "hclk_rkvdec_pre", "aclk_rkvdec_pre",
>0, 1, 4,
>   511				RK3328_CLKGATE_CON(11), 0, GFLAGS),
>512		GATE(ACLK_RKVDEC, "aclk_rkvdec", "aclk_rkvdec_pre",
>CLK_SET_RATE_PARENT,
>   513				RK3328_CLKGATE_CON(24), 0, GFLAGS),
>514		GATE(HCLK_RKVDEC, "hclk_rkvdec", "hclk_rkvdec_pre",
>CLK_SET_RATE_PARENT,
>   515				RK3328_CLKGATE_CON(24), 1, GFLAGS),
>   516		GATE(0, "aclk_rkvdec_niu", "aclk_rkvdec_pre", 0,
>   517				RK3328_CLKGATE_CON(24), 2, GFLAGS),
>   518		GATE(0, "hclk_rkvdec_niu", "hclk_rkvdec_pre", 0,
>   519				RK3328_CLKGATE_CON(24), 3, GFLAGS),
>   520	
>   521		COMPOSITE(SCLK_VDEC_CABAC, "sclk_vdec_cabac", mux_4plls_p, 0,
>   522				RK3328_CLKSEL_CON(48), 14, 2, MFLAGS, 8, 5, DFLAGS,
>   523				RK3328_CLKGATE_CON(6), 1, GFLAGS),
>   524	
>   525		COMPOSITE(SCLK_VDEC_CORE, "sclk_vdec_core", mux_4plls_p, 0,
>   526				RK3328_CLKSEL_CON(49), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   527				RK3328_CLKGATE_CON(6), 2, GFLAGS),
>   528	
>   529		COMPOSITE(ACLK_VPU_PRE, "aclk_vpu_pre", mux_4plls_p, 0,
>   530				RK3328_CLKSEL_CON(50), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   531				RK3328_CLKGATE_CON(6), 5, GFLAGS),
>532		FACTOR_GATE(HCLK_VPU_PRE, "hclk_vpu_pre", "aclk_vpu_pre", 0, 1, 4,
>   533				RK3328_CLKGATE_CON(11), 8, GFLAGS),
>   534		GATE(ACLK_VPU, "aclk_vpu", "aclk_vpu_pre", CLK_SET_RATE_PARENT,
>   535				RK3328_CLKGATE_CON(23), 0, GFLAGS),
>   536		GATE(HCLK_VPU, "hclk_vpu", "hclk_vpu_pre", CLK_SET_RATE_PARENT,
>   537				RK3328_CLKGATE_CON(23), 1, GFLAGS),
>   538		GATE(0, "aclk_vpu_niu", "aclk_vpu_pre", 0,
>   539				RK3328_CLKGATE_CON(23), 2, GFLAGS),
>   540		GATE(0, "hclk_vpu_niu", "hclk_vpu_pre", 0,
>   541				RK3328_CLKGATE_CON(23), 3, GFLAGS),
>   542	
>   543		COMPOSITE(ACLK_RKVENC, "aclk_rkvenc", mux_4plls_p, 0,
>   544				RK3328_CLKSEL_CON(51), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   545				RK3328_CLKGATE_CON(6), 3, GFLAGS),
>   546		FACTOR_GATE(HCLK_RKVENC, "hclk_rkvenc", "aclk_rkvenc", 0, 1, 4,
>   547				RK3328_CLKGATE_CON(11), 4, GFLAGS),
>   548		GATE(0, "aclk_rkvenc_niu", "aclk_rkvenc", 0,
>   549				RK3328_CLKGATE_CON(25), 0, GFLAGS),
>   550		GATE(0, "hclk_rkvenc_niu", "hclk_rkvenc", 0,
>   551				RK3328_CLKGATE_CON(25), 1, GFLAGS),
>   552		GATE(ACLK_H265, "aclk_h265", "aclk_rkvenc", 0,
>   553				RK3328_CLKGATE_CON(25), 0, GFLAGS),
>   554		GATE(PCLK_H265, "pclk_h265", "hclk_rkvenc", 0,
>   555				RK3328_CLKGATE_CON(25), 1, GFLAGS),
>   556		GATE(ACLK_H264, "aclk_h264", "aclk_rkvenc", 0,
>   557				RK3328_CLKGATE_CON(25), 0, GFLAGS),
>   558		GATE(HCLK_H264, "hclk_h264", "hclk_rkvenc", 0,
>   559				RK3328_CLKGATE_CON(25), 1, GFLAGS),
>560		GATE(ACLK_AXISRAM, "aclk_axisram", "aclk_rkvenc",
>CLK_IGNORE_UNUSED,
>   561				RK3328_CLKGATE_CON(25), 0, GFLAGS),
>   562	
>   563		COMPOSITE(SCLK_VENC_CORE, "sclk_venc_core", mux_4plls_p, 0,
>   564				RK3328_CLKSEL_CON(51), 14, 2, MFLAGS, 8, 5, DFLAGS,
>   565				RK3328_CLKGATE_CON(6), 4, GFLAGS),
>   566	
>   567		COMPOSITE(SCLK_VENC_DSP, "sclk_venc_dsp", mux_4plls_p, 0,
>   568				RK3328_CLKSEL_CON(52), 14, 2, MFLAGS, 8, 5, DFLAGS,
>   569				RK3328_CLKGATE_CON(6), 7, GFLAGS),
>   570	
>   571		/*
>   572		 * Clock-Architecture Diagram 6
>   573		 */
>   574	
>   575		/* PD_VIO */
>   576		COMPOSITE(ACLK_VIO_PRE, "aclk_vio_pre", mux_4plls_p, 0,
>   577				RK3328_CLKSEL_CON(37), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   578				RK3328_CLKGATE_CON(5), 2, GFLAGS),
>   579		DIV(HCLK_VIO_PRE, "hclk_vio_pre", "aclk_vio_pre", 0,
>   580				RK3328_CLKSEL_CON(37), 8, 5, DFLAGS),
>   581	
>   582		COMPOSITE(ACLK_RGA_PRE, "aclk_rga_pre", mux_4plls_p, 0,
>   583				RK3328_CLKSEL_CON(36), 14, 2, MFLAGS, 8, 5, DFLAGS,
>   584				RK3328_CLKGATE_CON(5), 0, GFLAGS),
>   585		COMPOSITE(SCLK_RGA, "clk_rga", mux_4plls_p, 0,
>   586				RK3328_CLKSEL_CON(36), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   587				RK3328_CLKGATE_CON(5), 1, GFLAGS),
>   588		COMPOSITE(ACLK_VOP_PRE, "aclk_vop_pre", mux_4plls_p, 0,
>   589				RK3328_CLKSEL_CON(39), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   590				RK3328_CLKGATE_CON(5), 5, GFLAGS),
>   591		GATE(SCLK_HDMI_SFC, "sclk_hdmi_sfc", "xin24m", 0,
>   592				RK3328_CLKGATE_CON(5), 4, GFLAGS),
>   593	
>   594		COMPOSITE_NODIV(0, "clk_cif_src", mux_2plls_p, 0,
>   595				RK3328_CLKSEL_CON(42), 7, 1, MFLAGS,
>   596				RK3328_CLKGATE_CON(5), 3, GFLAGS),
>597		COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cif_out", mux_sclk_cif_p,
>CLK_SET_RATE_PARENT,
>   598				RK3328_CLKSEL_CON(42), 5, 1, MFLAGS, 0, 5, DFLAGS),
>   599	
>   600		COMPOSITE(DCLK_LCDC_SRC, "dclk_lcdc_src", mux_gpll_cpll_p, 0,
>   601				RK3328_CLKSEL_CON(40), 0, 1, MFLAGS, 8, 8, DFLAGS,
>   602				RK3328_CLKGATE_CON(5), 6, GFLAGS),
>   603		DIV(DCLK_HDMIPHY, "dclk_hdmiphy", "dclk_lcdc_src", 0,
>   604				RK3328_CLKSEL_CON(40), 3, 3, DFLAGS),
>605		MUX(DCLK_LCDC, "dclk_lcdc", mux_dclk_lcdc_p,  CLK_SET_RATE_PARENT
>| CLK_SET_RATE_NO_REPARENT,
>   606				RK3328_CLKSEL_CON(40), 1, 1, MFLAGS),
>   607	
>   608		/*
>   609		 * Clock-Architecture Diagram 7
>   610		 */
>   611	
>   612		/* PD_PERI */
>   613		GATE(0, "gpll_peri", "gpll", CLK_IGNORE_UNUSED,
>   614				RK3328_CLKGATE_CON(4), 0, GFLAGS),
>   615		GATE(0, "cpll_peri", "cpll", CLK_IGNORE_UNUSED,
>   616				RK3328_CLKGATE_CON(4), 1, GFLAGS),
>   617		GATE(0, "hdmiphy_peri", "hdmiphy", CLK_IGNORE_UNUSED,
>   618				RK3328_CLKGATE_CON(4), 2, GFLAGS),
>619		COMPOSITE_NOGATE(ACLK_PERI_PRE, "aclk_peri_pre",
>mux_aclk_peri_pre_p, 0,
>   620				RK3328_CLKSEL_CON(28), 6, 2, MFLAGS, 0, 5, DFLAGS),
>621		COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_pre",
>CLK_IGNORE_UNUSED,
>   622				RK3328_CLKSEL_CON(29), 0, 2, DFLAGS,
>   623				RK3328_CLKGATE_CON(10), 2, GFLAGS),
>624		COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_pre",
>CLK_IGNORE_UNUSED,
>   625				RK3328_CLKSEL_CON(29), 4, 3, DFLAGS,
>   626				RK3328_CLKGATE_CON(10), 1, GFLAGS),
>627		GATE(ACLK_PERI, "aclk_peri", "aclk_peri_pre", CLK_IGNORE_UNUSED |
>CLK_SET_RATE_PARENT,
>   628				RK3328_CLKGATE_CON(10), 0, GFLAGS),
>   629	
>   630		COMPOSITE(SCLK_SDMMC, "clk_sdmmc", mux_2plls_24m_u480m_p, 0,
>   631				RK3328_CLKSEL_CON(30), 8, 2, MFLAGS, 0, 8, DFLAGS,
>   632				RK3328_CLKGATE_CON(4), 3, GFLAGS),
>   633	
>   634		COMPOSITE(SCLK_SDIO, "clk_sdio", mux_2plls_24m_u480m_p, 0,
>   635				RK3328_CLKSEL_CON(31), 8, 2, MFLAGS, 0, 8, DFLAGS,
>   636				RK3328_CLKGATE_CON(4), 4, GFLAGS),
>   637	
>   638		COMPOSITE(SCLK_EMMC, "clk_emmc", mux_2plls_24m_u480m_p, 0,
>   639				RK3328_CLKSEL_CON(32), 8, 2, MFLAGS, 0, 8, DFLAGS,
>   640				RK3328_CLKGATE_CON(4), 5, GFLAGS),
>   641	
>642		COMPOSITE(SCLK_SDMMC_EXT, "clk_sdmmc_ext", mux_2plls_24m_u480m_p,
>0,
>   643				RK3328_CLKSEL_CON(43), 8, 2, MFLAGS, 0, 8, DFLAGS,
>   644				RK3328_CLKGATE_CON(4), 10, GFLAGS),
>   645	
>646		COMPOSITE(SCLK_REF_USB3OTG_SRC, "clk_ref_usb3otg_src",
>mux_2plls_p, 0,
>   647				RK3328_CLKSEL_CON(45), 7, 1, MFLAGS, 0, 7, DFLAGS,
>   648				RK3328_CLKGATE_CON(4), 9, GFLAGS),
>   649	
>650		MUX(SCLK_REF_USB3OTG, "clk_ref_usb3otg", mux_ref_usb3otg_src_p,
>CLK_SET_RATE_PARENT,
>   651				RK3328_CLKSEL_CON(45), 8, 1, MFLAGS),
>   652	
>   653		GATE(SCLK_USB3OTG_REF, "clk_usb3otg_ref", "xin24m", 0,
>   654				RK3328_CLKGATE_CON(4), 7, GFLAGS),
>   655	
>656		COMPOSITE(SCLK_USB3OTG_SUSPEND, "clk_usb3otg_suspend",
>mux_xin24m_32k_p, 0,
>   657				RK3328_CLKSEL_CON(33), 15, 1, MFLAGS, 0, 10, DFLAGS,
>   658				RK3328_CLKGATE_CON(4), 8, GFLAGS),
>   659	
>   660		/*
>   661		 * Clock-Architecture Diagram 8
>   662		 */
>   663	
>   664		/* PD_GMAC */
>   665		COMPOSITE(ACLK_GMAC, "aclk_gmac", mux_2plls_hdmiphy_p, 0,
>   666				RK3328_CLKSEL_CON(35), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   667				RK3328_CLKGATE_CON(3), 2, GFLAGS),
>   668		COMPOSITE_NOMUX(PCLK_GMAC, "pclk_gmac", "aclk_gmac", 0,
>   669				RK3328_CLKSEL_CON(25), 8, 3, DFLAGS,
>   670				RK3328_CLKGATE_CON(9), 0, GFLAGS),
>   671	
>   672		COMPOSITE(SCLK_MAC2IO_SRC, "clk_mac2io_src", mux_2plls_p, 0,
>   673				RK3328_CLKSEL_CON(27), 7, 1, MFLAGS, 0, 5, DFLAGS,
>   674				RK3328_CLKGATE_CON(3), 1, GFLAGS),
>   675		GATE(SCLK_MAC2IO_REF, "clk_mac2io_ref", "clk_mac2io", 0,
>   676				RK3328_CLKGATE_CON(9), 7, GFLAGS),
>   677		GATE(SCLK_MAC2IO_RX, "clk_mac2io_rx", "clk_mac2io", 0,
>   678				RK3328_CLKGATE_CON(9), 4, GFLAGS),
>   679		GATE(SCLK_MAC2IO_TX, "clk_mac2io_tx", "clk_mac2io", 0,
>   680				RK3328_CLKGATE_CON(9), 5, GFLAGS),
>   681		GATE(SCLK_MAC2IO_REFOUT, "clk_mac2io_refout", "clk_mac2io", 0,
>   682				RK3328_CLKGATE_CON(9), 6, GFLAGS),
>   683		COMPOSITE(SCLK_MAC2IO_OUT, "clk_mac2io_out", mux_2plls_p, 0,
>   684				RK3328_CLKSEL_CON(27), 15, 1, MFLAGS, 8, 5, DFLAGS,
>   685				RK3328_CLKGATE_CON(3), 5, GFLAGS),
>686		MUXGRF(SCLK_MAC2IO, "clk_mac2io", mux_mac2io_src_p,
>CLK_SET_RATE_NO_REPARENT,
>   687				RK3328_GRF_MAC_CON1, 10, 1, MFLAGS),
>688		MUXGRF(SCLK_MAC2IO_EXT, "clk_mac2io_ext", mux_mac2io_ext_p,
>CLK_SET_RATE_NO_REPARENT,
>   689				RK3328_GRF_SOC_CON4, 14, 1, MFLAGS),
>   690	
>   691		COMPOSITE(SCLK_MAC2PHY_SRC, "clk_mac2phy_src", mux_2plls_p, 0,
>   692				RK3328_CLKSEL_CON(26), 7, 1, MFLAGS, 0, 5, DFLAGS,
>   693				RK3328_CLKGATE_CON(3), 0, GFLAGS),
>   694		GATE(SCLK_MAC2PHY_REF, "clk_mac2phy_ref", "clk_mac2phy", 0,
>   695				RK3328_CLKGATE_CON(9), 3, GFLAGS),
>   696		GATE(SCLK_MAC2PHY_RXTX, "clk_mac2phy_rxtx", "clk_mac2phy", 0,
>   697				RK3328_CLKGATE_CON(9), 1, GFLAGS),
>698		COMPOSITE_NOMUX(SCLK_MAC2PHY_OUT, "clk_mac2phy_out",
>"clk_mac2phy", 0,
>   699				RK3328_CLKSEL_CON(26), 8, 2, DFLAGS,
>   700				RK3328_CLKGATE_CON(9), 2, GFLAGS),
>701		MUXGRF(SCLK_MAC2PHY, "clk_mac2phy", mux_mac2phy_src_p,
>CLK_SET_RATE_NO_REPARENT,
>   702				RK3328_GRF_MAC_CON2, 10, 1, MFLAGS),
>   703	
>   704		FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
>   705	
>   706		/*
>   707		 * Clock-Architecture Diagram 9
>   708		 */
>   709	
>   710		/* PD_VOP */
>711		GATE(ACLK_RGA, "aclk_rga", "aclk_rga_pre", 0,
>RK3328_CLKGATE_CON(21), 10, GFLAGS),
>712		GATE(0, "aclk_rga_niu", "aclk_rga_pre", 0, RK3328_CLKGATE_CON(22),
>3, GFLAGS),
>713		GATE(ACLK_VOP, "aclk_vop", "aclk_vop_pre", 0,
>RK3328_CLKGATE_CON(21), 2, GFLAGS),
>714		GATE(0, "aclk_vop_niu", "aclk_vop_pre", 0, RK3328_CLKGATE_CON(21),
>4, GFLAGS),
>   715	
>716		GATE(ACLK_IEP, "aclk_iep", "aclk_vio_pre", 0,
>RK3328_CLKGATE_CON(21), 6, GFLAGS),
>717		GATE(ACLK_CIF, "aclk_cif", "aclk_vio_pre", 0,
>RK3328_CLKGATE_CON(21), 8, GFLAGS),
>718		GATE(ACLK_HDCP, "aclk_hdcp", "aclk_vio_pre", 0,
>RK3328_CLKGATE_CON(21), 15, GFLAGS),
>719		GATE(0, "aclk_vio_niu", "aclk_vio_pre", 0, RK3328_CLKGATE_CON(22),
>2, GFLAGS),
>   720	
>721		GATE(HCLK_VOP, "hclk_vop", "hclk_vio_pre", 0,
>RK3328_CLKGATE_CON(21), 3, GFLAGS),
>722		GATE(0, "hclk_vop_niu", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21),
>5, GFLAGS),
>723		GATE(HCLK_IEP, "hclk_iep", "hclk_vio_pre", 0,
>RK3328_CLKGATE_CON(21), 7, GFLAGS),
>724		GATE(HCLK_CIF, "hclk_cif", "hclk_vio_pre", 0,
>RK3328_CLKGATE_CON(21), 9, GFLAGS),
>725		GATE(HCLK_RGA, "hclk_rga", "hclk_vio_pre", 0,
>RK3328_CLKGATE_CON(21), 11, GFLAGS),
>726		GATE(0, "hclk_ahb1tom", "hclk_vio_pre", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(21), 12, GFLAGS),
>727		GATE(0, "pclk_vio_h2p", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21),
>13, GFLAGS),
>728		GATE(0, "hclk_vio_h2p", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(21),
>14, GFLAGS),
>729		GATE(HCLK_HDCP, "hclk_hdcp", "hclk_vio_pre", 0,
>RK3328_CLKGATE_CON(22), 0, GFLAGS),
>730		GATE(0, "hclk_vio_niu", "hclk_vio_pre", 0, RK3328_CLKGATE_CON(22),
>1, GFLAGS),
>731		GATE(PCLK_HDMI, "pclk_hdmi", "hclk_vio_pre", 0,
>RK3328_CLKGATE_CON(22), 4, GFLAGS),
>732		GATE(PCLK_HDCP, "pclk_hdcp", "hclk_vio_pre", 0,
>RK3328_CLKGATE_CON(22), 5, GFLAGS),
>   733	
>   734		/* PD_PERI */
>735		GATE(0, "aclk_peri_noc", "aclk_peri", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(19), 11, GFLAGS),
>736		GATE(ACLK_USB3OTG, "aclk_usb3otg", "aclk_peri", 0,
>RK3328_CLKGATE_CON(19), 4, GFLAGS),
>   737	
>738		GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0,
>RK3328_CLKGATE_CON(19), 0, GFLAGS),
>739		GATE(HCLK_SDIO, "hclk_sdio", "hclk_peri", 0,
>RK3328_CLKGATE_CON(19), 1, GFLAGS),
>740		GATE(HCLK_EMMC, "hclk_emmc", "hclk_peri", 0,
>RK3328_CLKGATE_CON(19), 2, GFLAGS),
>741		GATE(HCLK_SDMMC_EXT, "hclk_sdmmc_ext", "hclk_peri", 0,
>RK3328_CLKGATE_CON(19), 15, GFLAGS),
>742		GATE(HCLK_HOST0, "hclk_host0", "hclk_peri", 0,
>RK3328_CLKGATE_CON(19), 6, GFLAGS),
>743		GATE(HCLK_HOST0_ARB, "hclk_host0_arb", "hclk_peri",
>CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(19), 7, GFLAGS),
>744		GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK3328_CLKGATE_CON(19),
>8, GFLAGS),
>745		GATE(HCLK_OTG_PMU, "hclk_otg_pmu", "hclk_peri", 0,
>RK3328_CLKGATE_CON(19), 9, GFLAGS),
>746		GATE(0, "hclk_peri_niu", "hclk_peri", 0, RK3328_CLKGATE_CON(19),
>12, GFLAGS),
>747		GATE(0, "pclk_peri_niu", "hclk_peri", 0, RK3328_CLKGATE_CON(19),
>13, GFLAGS),
>   748	
>   749		/* PD_GMAC */
>750		GATE(ACLK_MAC2PHY, "aclk_mac2phy", "aclk_gmac", 0,
>RK3328_CLKGATE_CON(26), 0, GFLAGS),
>751		GATE(ACLK_MAC2IO, "aclk_mac2io", "aclk_gmac", 0,
>RK3328_CLKGATE_CON(26), 2, GFLAGS),
>752		GATE(0, "aclk_gmac_niu", "aclk_gmac", 0, RK3328_CLKGATE_CON(26),
>4, GFLAGS),
>753		GATE(PCLK_MAC2PHY, "pclk_mac2phy", "pclk_gmac", 0,
>RK3328_CLKGATE_CON(26), 1, GFLAGS),
>754		GATE(PCLK_MAC2IO, "pclk_mac2io", "pclk_gmac", 0,
>RK3328_CLKGATE_CON(26), 3, GFLAGS),
>755		GATE(0, "pclk_gmac_niu", "pclk_gmac", 0, RK3328_CLKGATE_CON(26),
>5, GFLAGS),
>   756	
>   757		/* PD_BUS */
>758		GATE(0, "aclk_bus_niu", "aclk_bus_pre", 0, RK3328_CLKGATE_CON(15),
>12, GFLAGS),
>759		GATE(ACLK_DCF, "aclk_dcf", "aclk_bus_pre", 0,
>RK3328_CLKGATE_CON(15), 11, GFLAGS),
>760		GATE(ACLK_TSP, "aclk_tsp", "aclk_bus_pre", 0,
>RK3328_CLKGATE_CON(17), 12, GFLAGS),
>761		GATE(0, "aclk_intmem", "aclk_bus_pre", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(15), 0, GFLAGS),
>762		GATE(ACLK_DMAC, "aclk_dmac_bus", "aclk_bus_pre",
>CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(15), 1, GFLAGS),
>   763	
>764		GATE(0, "hclk_rom", "hclk_bus_pre", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(15), 2, GFLAGS),
>765		GATE(HCLK_I2S0_8CH, "hclk_i2s0_8ch", "hclk_bus_pre", 0,
>RK3328_CLKGATE_CON(15), 3, GFLAGS),
>766		GATE(HCLK_I2S1_8CH, "hclk_i2s1_8ch", "hclk_bus_pre", 0,
>RK3328_CLKGATE_CON(15), 4, GFLAGS),
>767		GATE(HCLK_I2S2_2CH, "hclk_i2s2_2ch", "hclk_bus_pre", 0,
>RK3328_CLKGATE_CON(15), 5, GFLAGS),
>768		GATE(HCLK_SPDIF_8CH, "hclk_spdif_8ch", "hclk_bus_pre", 0,
>RK3328_CLKGATE_CON(15), 6, GFLAGS),
>769		GATE(HCLK_TSP, "hclk_tsp", "hclk_bus_pre", 0,
>RK3328_CLKGATE_CON(17), 11, GFLAGS),
>770		GATE(HCLK_CRYPTO_MST, "hclk_crypto_mst", "hclk_bus_pre", 0,
>RK3328_CLKGATE_CON(15), 7, GFLAGS),
>771		GATE(HCLK_CRYPTO_SLV, "hclk_crypto_slv", "hclk_bus_pre", 0,
>RK3328_CLKGATE_CON(15), 8, GFLAGS),
>772		GATE(0, "hclk_bus_niu", "hclk_bus_pre", 0, RK3328_CLKGATE_CON(15),
>13, GFLAGS),
>773		GATE(HCLK_PDM, "hclk_pdm", "hclk_bus_pre", 0,
>RK3328_CLKGATE_CON(28), 0, GFLAGS),
>   774	
>775		GATE(0, "pclk_bus_niu", "pclk_bus", 0, RK3328_CLKGATE_CON(15), 14,
>GFLAGS),
>776		GATE(0, "pclk_efuse", "pclk_bus", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(15), 9, GFLAGS),
>777		GATE(0, "pclk_otp", "pclk_bus", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(28), 4, GFLAGS),
>778		GATE(PCLK_I2C0, "pclk_i2c0", "pclk_bus", 0,
>RK3328_CLKGATE_CON(15), 10, GFLAGS),
>779		GATE(PCLK_I2C1, "pclk_i2c1", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 0, GFLAGS),
>780		GATE(PCLK_I2C2, "pclk_i2c2", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 1, GFLAGS),
>781		GATE(PCLK_I2C3, "pclk_i2c3", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 2, GFLAGS),
>782		GATE(PCLK_TIMER, "pclk_timer0", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 3, GFLAGS),
>783		GATE(0, "pclk_stimer", "pclk_bus", 0, RK3328_CLKGATE_CON(16), 4,
>GFLAGS),
>784		GATE(PCLK_SPI, "pclk_spi", "pclk_bus", 0, RK3328_CLKGATE_CON(16),
>5, GFLAGS),
>785		GATE(PCLK_PWM, "pclk_rk_pwm", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 6, GFLAGS),
>786		GATE(PCLK_GPIO0, "pclk_gpio0", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 7, GFLAGS),
>787		GATE(PCLK_GPIO1, "pclk_gpio1", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 8, GFLAGS),
>788		GATE(PCLK_GPIO2, "pclk_gpio2", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 9, GFLAGS),
>789		GATE(PCLK_GPIO3, "pclk_gpio3", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 10, GFLAGS),
>790		GATE(PCLK_UART0, "pclk_uart0", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 11, GFLAGS),
>791		GATE(PCLK_UART1, "pclk_uart1", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 12, GFLAGS),
>792		GATE(PCLK_UART2, "pclk_uart2", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 13, GFLAGS),
>793		GATE(PCLK_TSADC, "pclk_tsadc", "pclk_bus", 0,
>RK3328_CLKGATE_CON(16), 14, GFLAGS),
>794		GATE(PCLK_DCF, "pclk_dcf", "pclk_bus", 0, RK3328_CLKGATE_CON(16),
>15, GFLAGS),
>795		GATE(PCLK_GRF, "pclk_grf", "pclk_bus", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(17), 0, GFLAGS),
>796		GATE(0, "pclk_cru", "pclk_bus", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(17), 4, GFLAGS),
>797		GATE(0, "pclk_sgrf", "pclk_bus", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(17), 6, GFLAGS),
>798		GATE(0, "pclk_sim", "pclk_bus", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(17), 10, GFLAGS),
>799		GATE(PCLK_SARADC, "pclk_saradc", "pclk_bus", 0,
>RK3328_CLKGATE_CON(17), 15, GFLAGS),
>800		GATE(0, "pclk_pmu", "pclk_bus", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(28), 3, GFLAGS),
>   801	
>802		GATE(PCLK_USB3PHY_OTG, "pclk_usb3phy_otg", "pclk_phy_pre", 0,
>RK3328_CLKGATE_CON(28), 1, GFLAGS),
>803		GATE(PCLK_USB3PHY_PIPE, "pclk_usb3phy_pipe", "pclk_phy_pre", 0,
>RK3328_CLKGATE_CON(28), 2, GFLAGS),
>804		GATE(PCLK_USB3_GRF, "pclk_usb3_grf", "pclk_phy_pre",
>CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 2, GFLAGS),
>805		GATE(PCLK_USB2_GRF, "pclk_usb2_grf", "pclk_phy_pre",
>CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 14, GFLAGS),
>806		GATE(0, "pclk_ddrphy", "pclk_phy_pre", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(17), 13, GFLAGS),
>> 807		GATE(PCLK_ACODECPHY, "pclk_acodecphy", "pclk_phy_pre", 0,
>RK3328_CLKGATE_CON(17), 5, GFLAGS),
>808		GATE(PCLK_HDMIPHY, "pclk_hdmiphy", "pclk_phy_pre",
>CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 7, GFLAGS),
>809		GATE(0, "pclk_vdacphy", "pclk_phy_pre", CLK_IGNORE_UNUSED,
>RK3328_CLKGATE_CON(17), 8, GFLAGS),
>810		GATE(0, "pclk_phy_niu", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(15),
>15, GFLAGS),
>   811	
>   812		/* PD_MMC */
>   813		MMC(SCLK_SDMMC_DRV, "sdmmc_drv", "clk_sdmmc",
>   814		    RK3328_SDMMC_CON0, 1),
>   815		MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "clk_sdmmc",
>   816		    RK3328_SDMMC_CON1, 0),
>   817	
>   818		MMC(SCLK_SDIO_DRV, "sdio_drv", "clk_sdio",
>   819		    RK3328_SDIO_CON0, 1),
>   820		MMC(SCLK_SDIO_SAMPLE, "sdio_sample", "clk_sdio",
>   821		    RK3328_SDIO_CON1, 0),
>   822	
>   823		MMC(SCLK_EMMC_DRV, "emmc_drv", "clk_emmc",
>   824		    RK3328_EMMC_CON0, 1),
>   825		MMC(SCLK_EMMC_SAMPLE, "emmc_sample", "clk_emmc",
>   826		    RK3328_EMMC_CON1, 0),
>   827	
>   828		MMC(SCLK_SDMMC_EXT_DRV, "sdmmc_ext_drv", "clk_sdmmc_ext",
>   829		    RK3328_SDMMC_EXT_CON0, 1),
>   830		MMC(SCLK_SDMMC_EXT_SAMPLE, "sdmmc_ext_sample", "clk_sdmmc_ext",
>   831		    RK3328_SDMMC_EXT_CON1, 0),
>   832	};
>   833	
>
>---
>0-DAY kernel test infrastructure                Open Source Technology
>Center
>https://lists.01.org/pipermail/kbuild-all                   Intel
>Corporation

-- 
Diese Nachricht wurde von meinem Android-Gerät mit K-9 Mail gesendet.
