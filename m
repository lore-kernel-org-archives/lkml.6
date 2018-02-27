Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeB0CSw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:18:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:27878 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbeB0CSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:18:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="gz'50?scan'50,208,50";a="30893860"
Date: Tue, 27 Feb 2018 10:18:28 +0800
From: kbuild test robot <lkp@intel.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: kbuild-all@01.org, maxime.ripard@free-electrons.com, wens@csie.org,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 12/15] drm/sun4i: Allow building on arm64
Message-ID: <201802271003.S2PF7sfl%fengguang.wu@intel.com>
References: <20180224214545.3740-13-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20180224214545.3740-13-jernej.skrabec@siol.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jernej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on next-20180226]
[cannot apply to robh/for-next v4.16-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/Implement-H3-H5-HDMI-driver/20180227-054135
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu//drm/sun4i/sun8i_dw_hdmi.h:12:0,
                    from drivers/gpu//drm/sun4i/sun8i_hdmi_phy.c:9:
   drivers/gpu//drm/sun4i/sun8i_hdmi_phy.c: In function 'sun8i_hdmi_phy_config_h3':
>> drivers/gpu//drm/sun4i/sun8i_hdmi_phy.c:188:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
          ~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK, pll_cfg2_init);
          ^
   include/linux/regmap.h:75:36: note: in definition of macro 'regmap_update_bits'
     regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
                                       ^~~~

vim +188 drivers/gpu//drm/sun4i/sun8i_hdmi_phy.c

b7c7436a Jernej Skrabec 2018-02-14    8  
b7c7436a Jernej Skrabec 2018-02-14   @9  #include "sun8i_dw_hdmi.h"
b7c7436a Jernej Skrabec 2018-02-14   10  
b7c7436a Jernej Skrabec 2018-02-14   11  /*
b7c7436a Jernej Skrabec 2018-02-14   12   * Address can be actually any value. Here is set to same value as
b7c7436a Jernej Skrabec 2018-02-14   13   * it is set in BSP driver.
b7c7436a Jernej Skrabec 2018-02-14   14   */
b7c7436a Jernej Skrabec 2018-02-14   15  #define I2C_ADDR	0x69
b7c7436a Jernej Skrabec 2018-02-14   16  
322900e8 Jernej Skrabec 2018-02-24   17  static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
322900e8 Jernej Skrabec 2018-02-24   18  				      struct sun8i_hdmi_phy *phy,
322900e8 Jernej Skrabec 2018-02-24   19  				      unsigned int clk_rate)
b7c7436a Jernej Skrabec 2018-02-14   20  {
b7c7436a Jernej Skrabec 2018-02-14   21  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
b7c7436a Jernej Skrabec 2018-02-14   22  			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
b7c7436a Jernej Skrabec 2018-02-14   23  			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
b7c7436a Jernej Skrabec 2018-02-14   24  
b7c7436a Jernej Skrabec 2018-02-14   25  	/* power down */
b7c7436a Jernej Skrabec 2018-02-14   26  	dw_hdmi_phy_gen2_txpwron(hdmi, 0);
b7c7436a Jernej Skrabec 2018-02-14   27  	dw_hdmi_phy_gen2_pddq(hdmi, 1);
b7c7436a Jernej Skrabec 2018-02-14   28  
b7c7436a Jernej Skrabec 2018-02-14   29  	dw_hdmi_phy_reset(hdmi);
b7c7436a Jernej Skrabec 2018-02-14   30  
b7c7436a Jernej Skrabec 2018-02-14   31  	dw_hdmi_phy_gen2_pddq(hdmi, 0);
b7c7436a Jernej Skrabec 2018-02-14   32  
b7c7436a Jernej Skrabec 2018-02-14   33  	dw_hdmi_phy_i2c_set_addr(hdmi, I2C_ADDR);
b7c7436a Jernej Skrabec 2018-02-14   34  
b7c7436a Jernej Skrabec 2018-02-14   35  	/*
b7c7436a Jernej Skrabec 2018-02-14   36  	 * Values are taken from BSP HDMI driver. Although AW didn't
b7c7436a Jernej Skrabec 2018-02-14   37  	 * release any documentation, explanation of this values can
b7c7436a Jernej Skrabec 2018-02-14   38  	 * be found in i.MX 6Dual/6Quad Reference Manual.
b7c7436a Jernej Skrabec 2018-02-14   39  	 */
322900e8 Jernej Skrabec 2018-02-24   40  	if (clk_rate <= 27000000) {
b7c7436a Jernej Skrabec 2018-02-14   41  		dw_hdmi_phy_i2c_write(hdmi, 0x01e0, 0x06);
b7c7436a Jernej Skrabec 2018-02-14   42  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x15);
b7c7436a Jernej Skrabec 2018-02-14   43  		dw_hdmi_phy_i2c_write(hdmi, 0x08da, 0x10);
b7c7436a Jernej Skrabec 2018-02-14   44  		dw_hdmi_phy_i2c_write(hdmi, 0x0007, 0x19);
b7c7436a Jernej Skrabec 2018-02-14   45  		dw_hdmi_phy_i2c_write(hdmi, 0x0318, 0x0e);
b7c7436a Jernej Skrabec 2018-02-14   46  		dw_hdmi_phy_i2c_write(hdmi, 0x8009, 0x09);
322900e8 Jernej Skrabec 2018-02-24   47  	} else if (clk_rate <= 74250000) {
b7c7436a Jernej Skrabec 2018-02-14   48  		dw_hdmi_phy_i2c_write(hdmi, 0x0540, 0x06);
b7c7436a Jernej Skrabec 2018-02-14   49  		dw_hdmi_phy_i2c_write(hdmi, 0x0005, 0x15);
b7c7436a Jernej Skrabec 2018-02-14   50  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
b7c7436a Jernej Skrabec 2018-02-14   51  		dw_hdmi_phy_i2c_write(hdmi, 0x0007, 0x19);
b7c7436a Jernej Skrabec 2018-02-14   52  		dw_hdmi_phy_i2c_write(hdmi, 0x02b5, 0x0e);
b7c7436a Jernej Skrabec 2018-02-14   53  		dw_hdmi_phy_i2c_write(hdmi, 0x8009, 0x09);
322900e8 Jernej Skrabec 2018-02-24   54  	} else if (clk_rate <= 148500000) {
b7c7436a Jernej Skrabec 2018-02-14   55  		dw_hdmi_phy_i2c_write(hdmi, 0x04a0, 0x06);
b7c7436a Jernej Skrabec 2018-02-14   56  		dw_hdmi_phy_i2c_write(hdmi, 0x000a, 0x15);
b7c7436a Jernej Skrabec 2018-02-14   57  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
b7c7436a Jernej Skrabec 2018-02-14   58  		dw_hdmi_phy_i2c_write(hdmi, 0x0002, 0x19);
b7c7436a Jernej Skrabec 2018-02-14   59  		dw_hdmi_phy_i2c_write(hdmi, 0x0021, 0x0e);
b7c7436a Jernej Skrabec 2018-02-14   60  		dw_hdmi_phy_i2c_write(hdmi, 0x8029, 0x09);
b7c7436a Jernej Skrabec 2018-02-14   61  	} else {
b7c7436a Jernej Skrabec 2018-02-14   62  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x06);
b7c7436a Jernej Skrabec 2018-02-14   63  		dw_hdmi_phy_i2c_write(hdmi, 0x000f, 0x15);
b7c7436a Jernej Skrabec 2018-02-14   64  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x10);
b7c7436a Jernej Skrabec 2018-02-14   65  		dw_hdmi_phy_i2c_write(hdmi, 0x0002, 0x19);
b7c7436a Jernej Skrabec 2018-02-14   66  		dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x0e);
b7c7436a Jernej Skrabec 2018-02-14   67  		dw_hdmi_phy_i2c_write(hdmi, 0x802b, 0x09);
b7c7436a Jernej Skrabec 2018-02-14   68  	}
b7c7436a Jernej Skrabec 2018-02-14   69  
b7c7436a Jernej Skrabec 2018-02-14   70  	dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x1e);
b7c7436a Jernej Skrabec 2018-02-14   71  	dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x13);
b7c7436a Jernej Skrabec 2018-02-14   72  	dw_hdmi_phy_i2c_write(hdmi, 0x0000, 0x17);
b7c7436a Jernej Skrabec 2018-02-14   73  
b7c7436a Jernej Skrabec 2018-02-14   74  	dw_hdmi_phy_gen2_txpwron(hdmi, 1);
b7c7436a Jernej Skrabec 2018-02-14   75  
b7c7436a Jernej Skrabec 2018-02-14   76  	return 0;
2175cff9 Jernej Skrabec 2018-02-24   77  }
2175cff9 Jernej Skrabec 2018-02-24   78  
2175cff9 Jernej Skrabec 2018-02-24   79  static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
2175cff9 Jernej Skrabec 2018-02-24   80  				    struct sun8i_hdmi_phy *phy,
2175cff9 Jernej Skrabec 2018-02-24   81  				    unsigned int clk_rate)
2175cff9 Jernej Skrabec 2018-02-24   82  {
2175cff9 Jernej Skrabec 2018-02-24   83  	u32 pll_cfg1_init;
2175cff9 Jernej Skrabec 2018-02-24   84  	u32 pll_cfg2_init;
2175cff9 Jernej Skrabec 2018-02-24   85  	u32 ana_cfg1_end;
2175cff9 Jernej Skrabec 2018-02-24   86  	u32 ana_cfg2_init;
2175cff9 Jernej Skrabec 2018-02-24   87  	u32 ana_cfg3_init;
2175cff9 Jernej Skrabec 2018-02-24   88  	u32 b_offset = 0;
2175cff9 Jernej Skrabec 2018-02-24   89  	u32 val;
2175cff9 Jernej Skrabec 2018-02-24   90  
2175cff9 Jernej Skrabec 2018-02-24   91  	/* bandwidth / frequency independent settings */
2175cff9 Jernej Skrabec 2018-02-24   92  
2175cff9 Jernej Skrabec 2018-02-24   93  	pll_cfg1_init = SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN |
2175cff9 Jernej Skrabec 2018-02-24   94  			SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN |
2175cff9 Jernej Skrabec 2018-02-24   95  			SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(7) |
2175cff9 Jernej Skrabec 2018-02-24   96  			SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(1) |
2175cff9 Jernej Skrabec 2018-02-24   97  			SUN8I_HDMI_PHY_PLL_CFG1_PLLDBEN |
2175cff9 Jernej Skrabec 2018-02-24   98  			SUN8I_HDMI_PHY_PLL_CFG1_CS |
2175cff9 Jernej Skrabec 2018-02-24   99  			SUN8I_HDMI_PHY_PLL_CFG1_CP_S(2) |
2175cff9 Jernej Skrabec 2018-02-24  100  			SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(63) |
2175cff9 Jernej Skrabec 2018-02-24  101  			SUN8I_HDMI_PHY_PLL_CFG1_BWS;
2175cff9 Jernej Skrabec 2018-02-24  102  
2175cff9 Jernej Skrabec 2018-02-24  103  	pll_cfg2_init = SUN8I_HDMI_PHY_PLL_CFG2_SV_H |
2175cff9 Jernej Skrabec 2018-02-24  104  			SUN8I_HDMI_PHY_PLL_CFG2_VCOGAIN_EN |
2175cff9 Jernej Skrabec 2018-02-24  105  			SUN8I_HDMI_PHY_PLL_CFG2_SDIV2;
2175cff9 Jernej Skrabec 2018-02-24  106  
2175cff9 Jernej Skrabec 2018-02-24  107  	ana_cfg1_end = SUN8I_HDMI_PHY_ANA_CFG1_REG_SVBH(1) |
2175cff9 Jernej Skrabec 2018-02-24  108  		       SUN8I_HDMI_PHY_ANA_CFG1_AMP_OPT |
2175cff9 Jernej Skrabec 2018-02-24  109  		       SUN8I_HDMI_PHY_ANA_CFG1_EMP_OPT |
2175cff9 Jernej Skrabec 2018-02-24  110  		       SUN8I_HDMI_PHY_ANA_CFG1_AMPCK_OPT |
2175cff9 Jernej Skrabec 2018-02-24  111  		       SUN8I_HDMI_PHY_ANA_CFG1_EMPCK_OPT |
2175cff9 Jernej Skrabec 2018-02-24  112  		       SUN8I_HDMI_PHY_ANA_CFG1_ENRCAL |
2175cff9 Jernej Skrabec 2018-02-24  113  		       SUN8I_HDMI_PHY_ANA_CFG1_ENCALOG |
2175cff9 Jernej Skrabec 2018-02-24  114  		       SUN8I_HDMI_PHY_ANA_CFG1_REG_SCKTMDS |
2175cff9 Jernej Skrabec 2018-02-24  115  		       SUN8I_HDMI_PHY_ANA_CFG1_TMDSCLK_EN |
2175cff9 Jernej Skrabec 2018-02-24  116  		       SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK |
2175cff9 Jernej Skrabec 2018-02-24  117  		       SUN8I_HDMI_PHY_ANA_CFG1_TXEN_ALL |
2175cff9 Jernej Skrabec 2018-02-24  118  		       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDSCLK |
2175cff9 Jernej Skrabec 2018-02-24  119  		       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS2 |
2175cff9 Jernej Skrabec 2018-02-24  120  		       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS1 |
2175cff9 Jernej Skrabec 2018-02-24  121  		       SUN8I_HDMI_PHY_ANA_CFG1_BIASEN_TMDS0 |
2175cff9 Jernej Skrabec 2018-02-24  122  		       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS2 |
2175cff9 Jernej Skrabec 2018-02-24  123  		       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS1 |
2175cff9 Jernej Skrabec 2018-02-24  124  		       SUN8I_HDMI_PHY_ANA_CFG1_ENP2S_TMDS0 |
2175cff9 Jernej Skrabec 2018-02-24  125  		       SUN8I_HDMI_PHY_ANA_CFG1_CKEN |
2175cff9 Jernej Skrabec 2018-02-24  126  		       SUN8I_HDMI_PHY_ANA_CFG1_LDOEN |
2175cff9 Jernej Skrabec 2018-02-24  127  		       SUN8I_HDMI_PHY_ANA_CFG1_ENVBS |
2175cff9 Jernej Skrabec 2018-02-24  128  		       SUN8I_HDMI_PHY_ANA_CFG1_ENBI;
2175cff9 Jernej Skrabec 2018-02-24  129  
2175cff9 Jernej Skrabec 2018-02-24  130  	ana_cfg2_init = SUN8I_HDMI_PHY_ANA_CFG2_M_EN |
2175cff9 Jernej Skrabec 2018-02-24  131  			SUN8I_HDMI_PHY_ANA_CFG2_REG_DENCK |
2175cff9 Jernej Skrabec 2018-02-24  132  			SUN8I_HDMI_PHY_ANA_CFG2_REG_DEN |
2175cff9 Jernej Skrabec 2018-02-24  133  			SUN8I_HDMI_PHY_ANA_CFG2_REG_CKSS(1) |
2175cff9 Jernej Skrabec 2018-02-24  134  			SUN8I_HDMI_PHY_ANA_CFG2_REG_CSMPS(1);
2175cff9 Jernej Skrabec 2018-02-24  135  
2175cff9 Jernej Skrabec 2018-02-24  136  	ana_cfg3_init = SUN8I_HDMI_PHY_ANA_CFG3_REG_WIRE(0x3e0) |
2175cff9 Jernej Skrabec 2018-02-24  137  			SUN8I_HDMI_PHY_ANA_CFG3_SDAEN |
2175cff9 Jernej Skrabec 2018-02-24  138  			SUN8I_HDMI_PHY_ANA_CFG3_SCLEN;
2175cff9 Jernej Skrabec 2018-02-24  139  
2175cff9 Jernej Skrabec 2018-02-24  140  	/* bandwidth / frequency dependent settings */
2175cff9 Jernej Skrabec 2018-02-24  141  	if (clk_rate <= 27000000) {
2175cff9 Jernej Skrabec 2018-02-24  142  		pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
2175cff9 Jernej Skrabec 2018-02-24  143  				 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
2175cff9 Jernej Skrabec 2018-02-24  144  		pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
2175cff9 Jernej Skrabec 2018-02-24  145  				 SUN8I_HDMI_PHY_PLL_CFG2_S(4);
2175cff9 Jernej Skrabec 2018-02-24  146  		ana_cfg1_end |= SUN8I_HDMI_PHY_ANA_CFG1_REG_CALSW;
2175cff9 Jernej Skrabec 2018-02-24  147  		ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4) |
2175cff9 Jernej Skrabec 2018-02-24  148  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_RESDI(phy->rcal);
2175cff9 Jernej Skrabec 2018-02-24  149  		ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(3) |
2175cff9 Jernej Skrabec 2018-02-24  150  				 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(5);
2175cff9 Jernej Skrabec 2018-02-24  151  	} else if (clk_rate <= 74250000) {
2175cff9 Jernej Skrabec 2018-02-24  152  		pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
2175cff9 Jernej Skrabec 2018-02-24  153  				 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
2175cff9 Jernej Skrabec 2018-02-24  154  		pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
2175cff9 Jernej Skrabec 2018-02-24  155  				 SUN8I_HDMI_PHY_PLL_CFG2_S(5);
2175cff9 Jernej Skrabec 2018-02-24  156  		ana_cfg1_end |= SUN8I_HDMI_PHY_ANA_CFG1_REG_CALSW;
2175cff9 Jernej Skrabec 2018-02-24  157  		ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4) |
2175cff9 Jernej Skrabec 2018-02-24  158  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_RESDI(phy->rcal);
2175cff9 Jernej Skrabec 2018-02-24  159  		ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(5) |
2175cff9 Jernej Skrabec 2018-02-24  160  				 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(7);
2175cff9 Jernej Skrabec 2018-02-24  161  	} else if (clk_rate <= 148500000) {
2175cff9 Jernej Skrabec 2018-02-24  162  		pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33 |
2175cff9 Jernej Skrabec 2018-02-24  163  				 SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(32);
2175cff9 Jernej Skrabec 2018-02-24  164  		pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(4) |
2175cff9 Jernej Skrabec 2018-02-24  165  				 SUN8I_HDMI_PHY_PLL_CFG2_S(6);
2175cff9 Jernej Skrabec 2018-02-24  166  		ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSWCK |
2175cff9 Jernej Skrabec 2018-02-24  167  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSW |
2175cff9 Jernej Skrabec 2018-02-24  168  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(2);
2175cff9 Jernej Skrabec 2018-02-24  169  		ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(7) |
2175cff9 Jernej Skrabec 2018-02-24  170  				 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(9);
2175cff9 Jernej Skrabec 2018-02-24  171  	} else {
2175cff9 Jernej Skrabec 2018-02-24  172  		b_offset = 2;
2175cff9 Jernej Skrabec 2018-02-24  173  		pll_cfg1_init |= SUN8I_HDMI_PHY_PLL_CFG1_CNT_INT(63);
2175cff9 Jernej Skrabec 2018-02-24  174  		pll_cfg2_init |= SUN8I_HDMI_PHY_PLL_CFG2_VCO_S(6) |
2175cff9 Jernej Skrabec 2018-02-24  175  				 SUN8I_HDMI_PHY_PLL_CFG2_S(7);
2175cff9 Jernej Skrabec 2018-02-24  176  		ana_cfg2_init |= SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSWCK |
2175cff9 Jernej Skrabec 2018-02-24  177  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_BIGSW |
2175cff9 Jernej Skrabec 2018-02-24  178  				 SUN8I_HDMI_PHY_ANA_CFG2_REG_SLV(4);
2175cff9 Jernej Skrabec 2018-02-24  179  		ana_cfg3_init |= SUN8I_HDMI_PHY_ANA_CFG3_REG_AMPCK(9) |
2175cff9 Jernej Skrabec 2018-02-24  180  				 SUN8I_HDMI_PHY_ANA_CFG3_REG_AMP(13);
2175cff9 Jernej Skrabec 2018-02-24  181  	}
2175cff9 Jernej Skrabec 2018-02-24  182  
2175cff9 Jernej Skrabec 2018-02-24  183  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
2175cff9 Jernej Skrabec 2018-02-24  184  			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
2175cff9 Jernej Skrabec 2018-02-24  185  
2175cff9 Jernej Skrabec 2018-02-24  186  	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
2175cff9 Jernej Skrabec 2018-02-24  187  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
2175cff9 Jernej Skrabec 2018-02-24 @188  			   ~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK, pll_cfg2_init);
2175cff9 Jernej Skrabec 2018-02-24  189  	usleep_range(10000, 15000);
2175cff9 Jernej Skrabec 2018-02-24  190  	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG3_REG,
2175cff9 Jernej Skrabec 2018-02-24  191  		     SUN8I_HDMI_PHY_PLL_CFG3_SOUT_DIV2);
2175cff9 Jernej Skrabec 2018-02-24  192  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
2175cff9 Jernej Skrabec 2018-02-24  193  			   SUN8I_HDMI_PHY_PLL_CFG1_PLLEN,
2175cff9 Jernej Skrabec 2018-02-24  194  			   SUN8I_HDMI_PHY_PLL_CFG1_PLLEN);
2175cff9 Jernej Skrabec 2018-02-24  195  	msleep(100);
2175cff9 Jernej Skrabec 2018-02-24  196  
2175cff9 Jernej Skrabec 2018-02-24  197  	/* get B value */
2175cff9 Jernej Skrabec 2018-02-24  198  	regmap_read(phy->regs, SUN8I_HDMI_PHY_ANA_STS_REG, &val);
2175cff9 Jernej Skrabec 2018-02-24  199  	val = (val & SUN8I_HDMI_PHY_ANA_STS_B_OUT_MSK) >>
2175cff9 Jernej Skrabec 2018-02-24  200  		SUN8I_HDMI_PHY_ANA_STS_B_OUT_SHIFT;
2175cff9 Jernej Skrabec 2018-02-24  201  	val = min(val + b_offset, (u32)0x3f);
2175cff9 Jernej Skrabec 2018-02-24  202  
2175cff9 Jernej Skrabec 2018-02-24  203  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
2175cff9 Jernej Skrabec 2018-02-24  204  			   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD1 |
2175cff9 Jernej Skrabec 2018-02-24  205  			   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD,
2175cff9 Jernej Skrabec 2018-02-24  206  			   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD1 |
2175cff9 Jernej Skrabec 2018-02-24  207  			   SUN8I_HDMI_PHY_PLL_CFG1_REG_OD);
2175cff9 Jernej Skrabec 2018-02-24  208  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
2175cff9 Jernej Skrabec 2018-02-24  209  			   SUN8I_HDMI_PHY_PLL_CFG1_B_IN_MSK,
2175cff9 Jernej Skrabec 2018-02-24  210  			   val << SUN8I_HDMI_PHY_PLL_CFG1_B_IN_SHIFT);
2175cff9 Jernej Skrabec 2018-02-24  211  	msleep(100);
2175cff9 Jernej Skrabec 2018-02-24  212  	regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG, ana_cfg1_end);
2175cff9 Jernej Skrabec 2018-02-24  213  	regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG2_REG, ana_cfg2_init);
2175cff9 Jernej Skrabec 2018-02-24  214  	regmap_write(phy->regs, SUN8I_HDMI_PHY_ANA_CFG3_REG, ana_cfg3_init);
2175cff9 Jernej Skrabec 2018-02-24  215  
2175cff9 Jernej Skrabec 2018-02-24  216  	return 0;
2175cff9 Jernej Skrabec 2018-02-24  217  }
b7c7436a Jernej Skrabec 2018-02-14  218  

:::::: The code at line 188 was first introduced by commit
:::::: 2175cff9150f7944c01f90b9354f35b976362d0b drm/sun4i: Add support for H3 HDMI PHY variant

:::::: TO: Jernej Skrabec <jernej.skrabec@siol.net>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
xZD6Zc2s2q21OxmZ/w/G9j/Y06kDAA==

--gKMricLos+KVdGMg--
