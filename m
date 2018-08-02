Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E22FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE06215A5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE06215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeHCAj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:39:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:6206 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeHCAjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:39:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 15:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="gz'50?scan'50,208,50";a="76860359"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2018 15:46:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1flMM8-0008b0-Ia; Fri, 03 Aug 2018 06:46:04 +0800
Date:   Fri, 3 Aug 2018 06:45:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Venkat Reddy Talla <vreddytalla@nvidia.com>
Cc:     kbuild-all@01.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, vivek.gautam@codeaurora.org,
        p.zabel@pengutronix.de, thierry.reding@gmail.com,
        mperttunen@nvidia.com, mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, avienamo@nvidia.com,
        talho@nvidia.com, ldewangan@nvidia.com, vreddytalla@nvidia.com
Subject: Re: [PATCH 1/3]  soc/tegra: pmc: set IO pad power state and voltage
 via pinctrl fw
Message-ID: <201808030656.vNDTkuBk%fengguang.wu@intel.com>
References: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Venkat,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on v4.18-rc7 next-20180802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Venkat-Reddy-Talla/soc-tegra-pmc-set-IO-pad-power-state-and-voltage-via-pinctrl-fw/20180803-043413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

Note: the linux-review/Venkat-Reddy-Talla/soc-tegra-pmc-set-IO-pad-power-state-and-voltage-via-pinctrl-fw/20180803-043413 HEAD ab02915682b2d61932e12e719422af7bc05b1eef builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/gpu//drm/tegra/sor.c: In function 'tegra_sor_edp_disable':
>> drivers/gpu//drm/tegra/sor.c:1550:8: error: implicit declaration of function 'tegra_io_pad_power_disable'; did you mean 'tegra_pmc_io_pad_low_power_disable'? [-Werror=implicit-function-declaration]
     err = tegra_io_pad_power_disable(sor->pad);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
           tegra_pmc_io_pad_low_power_disable
   drivers/gpu//drm/tegra/sor.c: In function 'tegra_sor_edp_enable':
>> drivers/gpu//drm/tegra/sor.c:1710:8: error: implicit declaration of function 'tegra_io_pad_power_enable'; did you mean 'tegra_io_rail_power_on'? [-Werror=implicit-function-declaration]
     err = tegra_io_pad_power_enable(sor->pad);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
           tegra_io_rail_power_on
   cc1: some warnings being treated as errors

vim +1550 drivers/gpu//drm/tegra/sor.c

6fad8f66d Thierry Reding     2014-11-28  1509  
850bab448 Thierry Reding     2015-07-29  1510  static void tegra_sor_edp_disable(struct drm_encoder *encoder)
6fad8f66d Thierry Reding     2014-11-28  1511  {
850bab448 Thierry Reding     2015-07-29  1512  	struct tegra_output *output = encoder_to_output(encoder);
850bab448 Thierry Reding     2015-07-29  1513  	struct tegra_dc *dc = to_tegra_dc(encoder->crtc);
850bab448 Thierry Reding     2015-07-29  1514  	struct tegra_sor *sor = to_sor(output);
850bab448 Thierry Reding     2015-07-29  1515  	u32 value;
850bab448 Thierry Reding     2015-07-29  1516  	int err;
850bab448 Thierry Reding     2015-07-29  1517  
850bab448 Thierry Reding     2015-07-29  1518  	if (output->panel)
850bab448 Thierry Reding     2015-07-29  1519  		drm_panel_disable(output->panel);
850bab448 Thierry Reding     2015-07-29  1520  
850bab448 Thierry Reding     2015-07-29  1521  	err = tegra_sor_detach(sor);
850bab448 Thierry Reding     2015-07-29  1522  	if (err < 0)
850bab448 Thierry Reding     2015-07-29  1523  		dev_err(sor->dev, "failed to detach SOR: %d\n", err);
850bab448 Thierry Reding     2015-07-29  1524  
850bab448 Thierry Reding     2015-07-29  1525  	tegra_sor_writel(sor, 0, SOR_STATE1);
850bab448 Thierry Reding     2015-07-29  1526  	tegra_sor_update(sor);
850bab448 Thierry Reding     2015-07-29  1527  
850bab448 Thierry Reding     2015-07-29  1528  	/*
850bab448 Thierry Reding     2015-07-29  1529  	 * The following accesses registers of the display controller, so make
850bab448 Thierry Reding     2015-07-29  1530  	 * sure it's only executed when the output is attached to one.
850bab448 Thierry Reding     2015-07-29  1531  	 */
850bab448 Thierry Reding     2015-07-29  1532  	if (dc) {
850bab448 Thierry Reding     2015-07-29  1533  		value = tegra_dc_readl(dc, DC_DISP_DISP_WIN_OPTIONS);
c57997bce Thierry Reding     2017-10-12  1534  		value &= ~SOR_ENABLE(0);
850bab448 Thierry Reding     2015-07-29  1535  		tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
850bab448 Thierry Reding     2015-07-29  1536  
850bab448 Thierry Reding     2015-07-29  1537  		tegra_dc_commit(dc);
6fad8f66d Thierry Reding     2014-11-28  1538  	}
6fad8f66d Thierry Reding     2014-11-28  1539  
850bab448 Thierry Reding     2015-07-29  1540  	err = tegra_sor_power_down(sor);
850bab448 Thierry Reding     2015-07-29  1541  	if (err < 0)
850bab448 Thierry Reding     2015-07-29  1542  		dev_err(sor->dev, "failed to power down SOR: %d\n", err);
850bab448 Thierry Reding     2015-07-29  1543  
9542c2376 Thierry Reding     2015-07-08  1544  	if (sor->aux) {
9542c2376 Thierry Reding     2015-07-08  1545  		err = drm_dp_aux_disable(sor->aux);
850bab448 Thierry Reding     2015-07-29  1546  		if (err < 0)
850bab448 Thierry Reding     2015-07-29  1547  			dev_err(sor->dev, "failed to disable DP: %d\n", err);
6fad8f66d Thierry Reding     2014-11-28  1548  	}
6fad8f66d Thierry Reding     2014-11-28  1549  
c57997bce Thierry Reding     2017-10-12 @1550  	err = tegra_io_pad_power_disable(sor->pad);
850bab448 Thierry Reding     2015-07-29  1551  	if (err < 0)
c57997bce Thierry Reding     2017-10-12  1552  		dev_err(sor->dev, "failed to power off I/O pad: %d\n", err);
850bab448 Thierry Reding     2015-07-29  1553  
850bab448 Thierry Reding     2015-07-29  1554  	if (output->panel)
850bab448 Thierry Reding     2015-07-29  1555  		drm_panel_unprepare(output->panel);
850bab448 Thierry Reding     2015-07-29  1556  
aaff8bd2e Thierry Reding     2015-08-07  1557  	pm_runtime_put(sor->dev);
6fad8f66d Thierry Reding     2014-11-28  1558  }
6fad8f66d Thierry Reding     2014-11-28  1559  
459cc2c68 Thierry Reding     2015-07-30  1560  #if 0
459cc2c68 Thierry Reding     2015-07-30  1561  static int calc_h_ref_to_sync(const struct drm_display_mode *mode,
459cc2c68 Thierry Reding     2015-07-30  1562  			      unsigned int *value)
459cc2c68 Thierry Reding     2015-07-30  1563  {
459cc2c68 Thierry Reding     2015-07-30  1564  	unsigned int hfp, hsw, hbp, a = 0, b;
459cc2c68 Thierry Reding     2015-07-30  1565  
459cc2c68 Thierry Reding     2015-07-30  1566  	hfp = mode->hsync_start - mode->hdisplay;
459cc2c68 Thierry Reding     2015-07-30  1567  	hsw = mode->hsync_end - mode->hsync_start;
459cc2c68 Thierry Reding     2015-07-30  1568  	hbp = mode->htotal - mode->hsync_end;
459cc2c68 Thierry Reding     2015-07-30  1569  
459cc2c68 Thierry Reding     2015-07-30  1570  	pr_info("hfp: %u, hsw: %u, hbp: %u\n", hfp, hsw, hbp);
459cc2c68 Thierry Reding     2015-07-30  1571  
459cc2c68 Thierry Reding     2015-07-30  1572  	b = hfp - 1;
459cc2c68 Thierry Reding     2015-07-30  1573  
459cc2c68 Thierry Reding     2015-07-30  1574  	pr_info("a: %u, b: %u\n", a, b);
459cc2c68 Thierry Reding     2015-07-30  1575  	pr_info("a + hsw + hbp = %u\n", a + hsw + hbp);
459cc2c68 Thierry Reding     2015-07-30  1576  
459cc2c68 Thierry Reding     2015-07-30  1577  	if (a + hsw + hbp <= 11) {
459cc2c68 Thierry Reding     2015-07-30  1578  		a = 1 + 11 - hsw - hbp;
459cc2c68 Thierry Reding     2015-07-30  1579  		pr_info("a: %u\n", a);
459cc2c68 Thierry Reding     2015-07-30  1580  	}
459cc2c68 Thierry Reding     2015-07-30  1581  
459cc2c68 Thierry Reding     2015-07-30  1582  	if (a > b)
459cc2c68 Thierry Reding     2015-07-30  1583  		return -EINVAL;
459cc2c68 Thierry Reding     2015-07-30  1584  
459cc2c68 Thierry Reding     2015-07-30  1585  	if (hsw < 1)
459cc2c68 Thierry Reding     2015-07-30  1586  		return -EINVAL;
459cc2c68 Thierry Reding     2015-07-30  1587  
459cc2c68 Thierry Reding     2015-07-30  1588  	if (mode->hdisplay < 16)
459cc2c68 Thierry Reding     2015-07-30  1589  		return -EINVAL;
459cc2c68 Thierry Reding     2015-07-30  1590  
459cc2c68 Thierry Reding     2015-07-30  1591  	if (value) {
459cc2c68 Thierry Reding     2015-07-30  1592  		if (b > a && a % 2)
459cc2c68 Thierry Reding     2015-07-30  1593  			*value = a + 1;
459cc2c68 Thierry Reding     2015-07-30  1594  		else
459cc2c68 Thierry Reding     2015-07-30  1595  			*value = a;
459cc2c68 Thierry Reding     2015-07-30  1596  	}
459cc2c68 Thierry Reding     2015-07-30  1597  
459cc2c68 Thierry Reding     2015-07-30  1598  	return 0;
459cc2c68 Thierry Reding     2015-07-30  1599  }
459cc2c68 Thierry Reding     2015-07-30  1600  #endif
459cc2c68 Thierry Reding     2015-07-30  1601  
850bab448 Thierry Reding     2015-07-29  1602  static void tegra_sor_edp_enable(struct drm_encoder *encoder)
6fad8f66d Thierry Reding     2014-11-28  1603  {
850bab448 Thierry Reding     2015-07-29  1604  	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
6fad8f66d Thierry Reding     2014-11-28  1605  	struct tegra_output *output = encoder_to_output(encoder);
6fad8f66d Thierry Reding     2014-11-28  1606  	struct tegra_dc *dc = to_tegra_dc(encoder->crtc);
6b6b60421 Thierry Reding     2013-11-15  1607  	struct tegra_sor *sor = to_sor(output);
34fa183ba Thierry Reding     2014-06-05  1608  	struct tegra_sor_config config;
c31efa7a3 Thierry Reding     2015-09-08  1609  	struct tegra_sor_state *state;
34fa183ba Thierry Reding     2014-06-05  1610  	struct drm_dp_link link;
01b9bea0c Thierry Reding     2015-11-11  1611  	u8 rate, lanes;
2bd1dd399 Thierry Reding     2015-08-03  1612  	unsigned int i;
86f5c52dc Thierry Reding     2014-03-26  1613  	int err = 0;
28fe20760 Thierry Reding     2015-01-26  1614  	u32 value;
86f5c52dc Thierry Reding     2014-03-26  1615  
c31efa7a3 Thierry Reding     2015-09-08  1616  	state = to_sor_state(output->connector.state);
6b6b60421 Thierry Reding     2013-11-15  1617  
aaff8bd2e Thierry Reding     2015-08-07  1618  	pm_runtime_get_sync(sor->dev);
6b6b60421 Thierry Reding     2013-11-15  1619  
6fad8f66d Thierry Reding     2014-11-28  1620  	if (output->panel)
6fad8f66d Thierry Reding     2014-11-28  1621  		drm_panel_prepare(output->panel);
6fad8f66d Thierry Reding     2014-11-28  1622  
9542c2376 Thierry Reding     2015-07-08  1623  	err = drm_dp_aux_enable(sor->aux);
6b6b60421 Thierry Reding     2013-11-15  1624  	if (err < 0)
6b6b60421 Thierry Reding     2013-11-15  1625  		dev_err(sor->dev, "failed to enable DP: %d\n", err);
34fa183ba Thierry Reding     2014-06-05  1626  
9542c2376 Thierry Reding     2015-07-08  1627  	err = drm_dp_link_probe(sor->aux, &link);
34fa183ba Thierry Reding     2014-06-05  1628  	if (err < 0) {
01b9bea0c Thierry Reding     2015-11-11  1629  		dev_err(sor->dev, "failed to probe eDP link: %d\n", err);
850bab448 Thierry Reding     2015-07-29  1630  		return;
34fa183ba Thierry Reding     2014-06-05  1631  	}
6b6b60421 Thierry Reding     2013-11-15  1632  
25bb2cec8 Thierry Reding     2015-08-03  1633  	/* switch to safe parent clock */
25bb2cec8 Thierry Reding     2015-08-03  1634  	err = tegra_sor_set_parent_clock(sor, sor->clk_safe);
6b6b60421 Thierry Reding     2013-11-15  1635  	if (err < 0)
6b6b60421 Thierry Reding     2013-11-15  1636  		dev_err(sor->dev, "failed to set safe parent clock: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1637  
34fa183ba Thierry Reding     2014-06-05  1638  	memset(&config, 0, sizeof(config));
c31efa7a3 Thierry Reding     2015-09-08  1639  	config.bits_per_pixel = state->bpc * 3;
34fa183ba Thierry Reding     2014-06-05  1640  
a198359e3 Thierry Reding     2015-07-21  1641  	err = tegra_sor_compute_config(sor, mode, &config, &link);
34fa183ba Thierry Reding     2014-06-05  1642  	if (err < 0)
a198359e3 Thierry Reding     2015-07-21  1643  		dev_err(sor->dev, "failed to compute configuration: %d\n", err);
34fa183ba Thierry Reding     2014-06-05  1644  
6b6b60421 Thierry Reding     2013-11-15  1645  	value = tegra_sor_readl(sor, SOR_CLK_CNTRL);
6b6b60421 Thierry Reding     2013-11-15  1646  	value &= ~SOR_CLK_CNTRL_DP_CLK_SEL_MASK;
6b6b60421 Thierry Reding     2013-11-15  1647  	value |= SOR_CLK_CNTRL_DP_CLK_SEL_SINGLE_DPCLK;
6b6b60421 Thierry Reding     2013-11-15  1648  	tegra_sor_writel(sor, value, SOR_CLK_CNTRL);
6b6b60421 Thierry Reding     2013-11-15  1649  
880cee0b7 Thierry Reding     2017-10-12  1650  	value = tegra_sor_readl(sor, sor->soc->regs->pll2);
a9a9e4fd7 Thierry Reding     2015-04-27  1651  	value &= ~SOR_PLL2_BANDGAP_POWERDOWN;
880cee0b7 Thierry Reding     2017-10-12  1652  	tegra_sor_writel(sor, value, sor->soc->regs->pll2);
6b6b60421 Thierry Reding     2013-11-15  1653  	usleep_range(20, 100);
6b6b60421 Thierry Reding     2013-11-15  1654  
880cee0b7 Thierry Reding     2017-10-12  1655  	value = tegra_sor_readl(sor, sor->soc->regs->pll3);
a9a9e4fd7 Thierry Reding     2015-04-27  1656  	value |= SOR_PLL3_PLL_VDD_MODE_3V3;
880cee0b7 Thierry Reding     2017-10-12  1657  	tegra_sor_writel(sor, value, sor->soc->regs->pll3);
6b6b60421 Thierry Reding     2013-11-15  1658  
a9a9e4fd7 Thierry Reding     2015-04-27  1659  	value = SOR_PLL0_ICHPMP(0xf) | SOR_PLL0_VCOCAP_RST |
a9a9e4fd7 Thierry Reding     2015-04-27  1660  		SOR_PLL0_PLLREG_LEVEL_V45 | SOR_PLL0_RESISTOR_EXT;
880cee0b7 Thierry Reding     2017-10-12  1661  	tegra_sor_writel(sor, value, sor->soc->regs->pll0);
6b6b60421 Thierry Reding     2013-11-15  1662  
880cee0b7 Thierry Reding     2017-10-12  1663  	value = tegra_sor_readl(sor, sor->soc->regs->pll2);
a9a9e4fd7 Thierry Reding     2015-04-27  1664  	value |= SOR_PLL2_SEQ_PLLCAPPD;
a9a9e4fd7 Thierry Reding     2015-04-27  1665  	value &= ~SOR_PLL2_SEQ_PLLCAPPD_ENFORCE;
a9a9e4fd7 Thierry Reding     2015-04-27  1666  	value |= SOR_PLL2_LVDS_ENABLE;
880cee0b7 Thierry Reding     2017-10-12  1667  	tegra_sor_writel(sor, value, sor->soc->regs->pll2);
6b6b60421 Thierry Reding     2013-11-15  1668  
a9a9e4fd7 Thierry Reding     2015-04-27  1669  	value = SOR_PLL1_TERM_COMPOUT | SOR_PLL1_TMDS_TERM;
880cee0b7 Thierry Reding     2017-10-12  1670  	tegra_sor_writel(sor, value, sor->soc->regs->pll1);
6b6b60421 Thierry Reding     2013-11-15  1671  
6b6b60421 Thierry Reding     2013-11-15  1672  	while (true) {
880cee0b7 Thierry Reding     2017-10-12  1673  		value = tegra_sor_readl(sor, sor->soc->regs->pll2);
a9a9e4fd7 Thierry Reding     2015-04-27  1674  		if ((value & SOR_PLL2_SEQ_PLLCAPPD_ENFORCE) == 0)
6b6b60421 Thierry Reding     2013-11-15  1675  			break;
6b6b60421 Thierry Reding     2013-11-15  1676  
6b6b60421 Thierry Reding     2013-11-15  1677  		usleep_range(250, 1000);
6b6b60421 Thierry Reding     2013-11-15  1678  	}
6b6b60421 Thierry Reding     2013-11-15  1679  
880cee0b7 Thierry Reding     2017-10-12  1680  	value = tegra_sor_readl(sor, sor->soc->regs->pll2);
a9a9e4fd7 Thierry Reding     2015-04-27  1681  	value &= ~SOR_PLL2_POWERDOWN_OVERRIDE;
a9a9e4fd7 Thierry Reding     2015-04-27  1682  	value &= ~SOR_PLL2_PORT_POWERDOWN;
880cee0b7 Thierry Reding     2017-10-12  1683  	tegra_sor_writel(sor, value, sor->soc->regs->pll2);
6b6b60421 Thierry Reding     2013-11-15  1684  
6b6b60421 Thierry Reding     2013-11-15  1685  	/*
6b6b60421 Thierry Reding     2013-11-15  1686  	 * power up
6b6b60421 Thierry Reding     2013-11-15  1687  	 */
6b6b60421 Thierry Reding     2013-11-15  1688  
6b6b60421 Thierry Reding     2013-11-15  1689  	/* set safe link bandwidth (1.62 Gbps) */
6b6b60421 Thierry Reding     2013-11-15  1690  	value = tegra_sor_readl(sor, SOR_CLK_CNTRL);
6b6b60421 Thierry Reding     2013-11-15  1691  	value &= ~SOR_CLK_CNTRL_DP_LINK_SPEED_MASK;
6b6b60421 Thierry Reding     2013-11-15  1692  	value |= SOR_CLK_CNTRL_DP_LINK_SPEED_G1_62;
6b6b60421 Thierry Reding     2013-11-15  1693  	tegra_sor_writel(sor, value, SOR_CLK_CNTRL);
6b6b60421 Thierry Reding     2013-11-15  1694  
6b6b60421 Thierry Reding     2013-11-15  1695  	/* step 1 */
880cee0b7 Thierry Reding     2017-10-12  1696  	value = tegra_sor_readl(sor, sor->soc->regs->pll2);
a9a9e4fd7 Thierry Reding     2015-04-27  1697  	value |= SOR_PLL2_SEQ_PLLCAPPD_ENFORCE | SOR_PLL2_PORT_POWERDOWN |
a9a9e4fd7 Thierry Reding     2015-04-27  1698  		 SOR_PLL2_BANDGAP_POWERDOWN;
880cee0b7 Thierry Reding     2017-10-12  1699  	tegra_sor_writel(sor, value, sor->soc->regs->pll2);
6b6b60421 Thierry Reding     2013-11-15  1700  
880cee0b7 Thierry Reding     2017-10-12  1701  	value = tegra_sor_readl(sor, sor->soc->regs->pll0);
a9a9e4fd7 Thierry Reding     2015-04-27  1702  	value |= SOR_PLL0_VCOPD | SOR_PLL0_PWR;
880cee0b7 Thierry Reding     2017-10-12  1703  	tegra_sor_writel(sor, value, sor->soc->regs->pll0);
6b6b60421 Thierry Reding     2013-11-15  1704  
880cee0b7 Thierry Reding     2017-10-12  1705  	value = tegra_sor_readl(sor, sor->soc->regs->dp_padctl0);
6b6b60421 Thierry Reding     2013-11-15  1706  	value &= ~SOR_DP_PADCTL_PAD_CAL_PD;
880cee0b7 Thierry Reding     2017-10-12  1707  	tegra_sor_writel(sor, value, sor->soc->regs->dp_padctl0);
6b6b60421 Thierry Reding     2013-11-15  1708  
6b6b60421 Thierry Reding     2013-11-15  1709  	/* step 2 */
c57997bce Thierry Reding     2017-10-12 @1710  	err = tegra_io_pad_power_enable(sor->pad);
850bab448 Thierry Reding     2015-07-29  1711  	if (err < 0)
c57997bce Thierry Reding     2017-10-12  1712  		dev_err(sor->dev, "failed to power on I/O pad: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1713  
6b6b60421 Thierry Reding     2013-11-15  1714  	usleep_range(5, 100);
6b6b60421 Thierry Reding     2013-11-15  1715  
6b6b60421 Thierry Reding     2013-11-15  1716  	/* step 3 */
880cee0b7 Thierry Reding     2017-10-12  1717  	value = tegra_sor_readl(sor, sor->soc->regs->pll2);
a9a9e4fd7 Thierry Reding     2015-04-27  1718  	value &= ~SOR_PLL2_BANDGAP_POWERDOWN;
880cee0b7 Thierry Reding     2017-10-12  1719  	tegra_sor_writel(sor, value, sor->soc->regs->pll2);
6b6b60421 Thierry Reding     2013-11-15  1720  
6b6b60421 Thierry Reding     2013-11-15  1721  	usleep_range(20, 100);
6b6b60421 Thierry Reding     2013-11-15  1722  
6b6b60421 Thierry Reding     2013-11-15  1723  	/* step 4 */
880cee0b7 Thierry Reding     2017-10-12  1724  	value = tegra_sor_readl(sor, sor->soc->regs->pll0);
a9a9e4fd7 Thierry Reding     2015-04-27  1725  	value &= ~SOR_PLL0_VCOPD;
a9a9e4fd7 Thierry Reding     2015-04-27  1726  	value &= ~SOR_PLL0_PWR;
880cee0b7 Thierry Reding     2017-10-12  1727  	tegra_sor_writel(sor, value, sor->soc->regs->pll0);
6b6b60421 Thierry Reding     2013-11-15  1728  
880cee0b7 Thierry Reding     2017-10-12  1729  	value = tegra_sor_readl(sor, sor->soc->regs->pll2);
a9a9e4fd7 Thierry Reding     2015-04-27  1730  	value &= ~SOR_PLL2_SEQ_PLLCAPPD_ENFORCE;
880cee0b7 Thierry Reding     2017-10-12  1731  	tegra_sor_writel(sor, value, sor->soc->regs->pll2);
6b6b60421 Thierry Reding     2013-11-15  1732  
6b6b60421 Thierry Reding     2013-11-15  1733  	usleep_range(200, 1000);
6b6b60421 Thierry Reding     2013-11-15  1734  
6b6b60421 Thierry Reding     2013-11-15  1735  	/* step 5 */
880cee0b7 Thierry Reding     2017-10-12  1736  	value = tegra_sor_readl(sor, sor->soc->regs->pll2);
a9a9e4fd7 Thierry Reding     2015-04-27  1737  	value &= ~SOR_PLL2_PORT_POWERDOWN;
880cee0b7 Thierry Reding     2017-10-12  1738  	tegra_sor_writel(sor, value, sor->soc->regs->pll2);
6b6b60421 Thierry Reding     2013-11-15  1739  
30b494355 Thierry Reding     2015-08-03  1740  	/* XXX not in TRM */
30b494355 Thierry Reding     2015-08-03  1741  	for (value = 0, i = 0; i < 5; i++)
30b494355 Thierry Reding     2015-08-03  1742  		value |= SOR_XBAR_CTRL_LINK0_XSEL(i, sor->soc->xbar_cfg[i]) |
30b494355 Thierry Reding     2015-08-03  1743  			 SOR_XBAR_CTRL_LINK1_XSEL(i, i);
30b494355 Thierry Reding     2015-08-03  1744  
30b494355 Thierry Reding     2015-08-03  1745  	tegra_sor_writel(sor, 0x00000000, SOR_XBAR_POL);
30b494355 Thierry Reding     2015-08-03  1746  	tegra_sor_writel(sor, value, SOR_XBAR_CTRL);
30b494355 Thierry Reding     2015-08-03  1747  
25bb2cec8 Thierry Reding     2015-08-03  1748  	/* switch to DP parent clock */
25bb2cec8 Thierry Reding     2015-08-03  1749  	err = tegra_sor_set_parent_clock(sor, sor->clk_dp);
6b6b60421 Thierry Reding     2013-11-15  1750  	if (err < 0)
25bb2cec8 Thierry Reding     2015-08-03  1751  		dev_err(sor->dev, "failed to set parent clock: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1752  
899451b78 Thierry Reding     2014-06-05  1753  	/* power DP lanes */
880cee0b7 Thierry Reding     2017-10-12  1754  	value = tegra_sor_readl(sor, sor->soc->regs->dp_padctl0);
899451b78 Thierry Reding     2014-06-05  1755  
899451b78 Thierry Reding     2014-06-05  1756  	if (link.num_lanes <= 2)
899451b78 Thierry Reding     2014-06-05  1757  		value &= ~(SOR_DP_PADCTL_PD_TXD_3 | SOR_DP_PADCTL_PD_TXD_2);
899451b78 Thierry Reding     2014-06-05  1758  	else
899451b78 Thierry Reding     2014-06-05  1759  		value |= SOR_DP_PADCTL_PD_TXD_3 | SOR_DP_PADCTL_PD_TXD_2;
899451b78 Thierry Reding     2014-06-05  1760  
899451b78 Thierry Reding     2014-06-05  1761  	if (link.num_lanes <= 1)
899451b78 Thierry Reding     2014-06-05  1762  		value &= ~SOR_DP_PADCTL_PD_TXD_1;
899451b78 Thierry Reding     2014-06-05  1763  	else
899451b78 Thierry Reding     2014-06-05  1764  		value |= SOR_DP_PADCTL_PD_TXD_1;
899451b78 Thierry Reding     2014-06-05  1765  
899451b78 Thierry Reding     2014-06-05  1766  	if (link.num_lanes == 0)
899451b78 Thierry Reding     2014-06-05  1767  		value &= ~SOR_DP_PADCTL_PD_TXD_0;
899451b78 Thierry Reding     2014-06-05  1768  	else
899451b78 Thierry Reding     2014-06-05  1769  		value |= SOR_DP_PADCTL_PD_TXD_0;
899451b78 Thierry Reding     2014-06-05  1770  
880cee0b7 Thierry Reding     2017-10-12  1771  	tegra_sor_writel(sor, value, sor->soc->regs->dp_padctl0);
6b6b60421 Thierry Reding     2013-11-15  1772  
a9a9e4fd7 Thierry Reding     2015-04-27  1773  	value = tegra_sor_readl(sor, SOR_DP_LINKCTL0);
6b6b60421 Thierry Reding     2013-11-15  1774  	value &= ~SOR_DP_LINKCTL_LANE_COUNT_MASK;
0c90a1846 Thierry Reding     2014-06-05  1775  	value |= SOR_DP_LINKCTL_LANE_COUNT(link.num_lanes);
a9a9e4fd7 Thierry Reding     2015-04-27  1776  	tegra_sor_writel(sor, value, SOR_DP_LINKCTL0);
6b6b60421 Thierry Reding     2013-11-15  1777  
6b6b60421 Thierry Reding     2013-11-15  1778  	/* start lane sequencer */
6b6b60421 Thierry Reding     2013-11-15  1779  	value = SOR_LANE_SEQ_CTL_TRIGGER | SOR_LANE_SEQ_CTL_SEQUENCE_DOWN |
6b6b60421 Thierry Reding     2013-11-15  1780  		SOR_LANE_SEQ_CTL_POWER_STATE_UP;
6b6b60421 Thierry Reding     2013-11-15  1781  	tegra_sor_writel(sor, value, SOR_LANE_SEQ_CTL);
6b6b60421 Thierry Reding     2013-11-15  1782  
6b6b60421 Thierry Reding     2013-11-15  1783  	while (true) {
6b6b60421 Thierry Reding     2013-11-15  1784  		value = tegra_sor_readl(sor, SOR_LANE_SEQ_CTL);
6b6b60421 Thierry Reding     2013-11-15  1785  		if ((value & SOR_LANE_SEQ_CTL_TRIGGER) == 0)
6b6b60421 Thierry Reding     2013-11-15  1786  			break;
6b6b60421 Thierry Reding     2013-11-15  1787  
6b6b60421 Thierry Reding     2013-11-15  1788  		usleep_range(250, 1000);
6b6b60421 Thierry Reding     2013-11-15  1789  	}
6b6b60421 Thierry Reding     2013-11-15  1790  
a4263fed2 Thierry Reding     2014-06-05  1791  	/* set link bandwidth */
6b6b60421 Thierry Reding     2013-11-15  1792  	value = tegra_sor_readl(sor, SOR_CLK_CNTRL);
6b6b60421 Thierry Reding     2013-11-15  1793  	value &= ~SOR_CLK_CNTRL_DP_LINK_SPEED_MASK;
a4263fed2 Thierry Reding     2014-06-05  1794  	value |= drm_dp_link_rate_to_bw_code(link.rate) << 2;
6b6b60421 Thierry Reding     2013-11-15  1795  	tegra_sor_writel(sor, value, SOR_CLK_CNTRL);
6b6b60421 Thierry Reding     2013-11-15  1796  
402f6bcd9 Thierry Reding     2015-07-21  1797  	tegra_sor_apply_config(sor, &config);
402f6bcd9 Thierry Reding     2015-07-21  1798  
402f6bcd9 Thierry Reding     2015-07-21  1799  	/* enable link */
a9a9e4fd7 Thierry Reding     2015-04-27  1800  	value = tegra_sor_readl(sor, SOR_DP_LINKCTL0);
6b6b60421 Thierry Reding     2013-11-15  1801  	value |= SOR_DP_LINKCTL_ENABLE;
6b6b60421 Thierry Reding     2013-11-15  1802  	value |= SOR_DP_LINKCTL_ENHANCED_FRAME;
a9a9e4fd7 Thierry Reding     2015-04-27  1803  	tegra_sor_writel(sor, value, SOR_DP_LINKCTL0);
6b6b60421 Thierry Reding     2013-11-15  1804  
6b6b60421 Thierry Reding     2013-11-15  1805  	for (i = 0, value = 0; i < 4; i++) {
6b6b60421 Thierry Reding     2013-11-15  1806  		unsigned long lane = SOR_DP_TPG_CHANNEL_CODING |
6b6b60421 Thierry Reding     2013-11-15  1807  				     SOR_DP_TPG_SCRAMBLER_GALIOS |
6b6b60421 Thierry Reding     2013-11-15  1808  				     SOR_DP_TPG_PATTERN_NONE;
6b6b60421 Thierry Reding     2013-11-15  1809  		value = (value << 8) | lane;
6b6b60421 Thierry Reding     2013-11-15  1810  	}
6b6b60421 Thierry Reding     2013-11-15  1811  
6b6b60421 Thierry Reding     2013-11-15  1812  	tegra_sor_writel(sor, value, SOR_DP_TPG);
6b6b60421 Thierry Reding     2013-11-15  1813  
6b6b60421 Thierry Reding     2013-11-15  1814  	/* enable pad calibration logic */
880cee0b7 Thierry Reding     2017-10-12  1815  	value = tegra_sor_readl(sor, sor->soc->regs->dp_padctl0);
6b6b60421 Thierry Reding     2013-11-15  1816  	value |= SOR_DP_PADCTL_PAD_CAL_PD;
880cee0b7 Thierry Reding     2017-10-12  1817  	tegra_sor_writel(sor, value, sor->soc->regs->dp_padctl0);
6b6b60421 Thierry Reding     2013-11-15  1818  
9542c2376 Thierry Reding     2015-07-08  1819  	err = drm_dp_link_probe(sor->aux, &link);
850bab448 Thierry Reding     2015-07-29  1820  	if (err < 0)
01b9bea0c Thierry Reding     2015-11-11  1821  		dev_err(sor->dev, "failed to probe eDP link: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1822  
9542c2376 Thierry Reding     2015-07-08  1823  	err = drm_dp_link_power_up(sor->aux, &link);
850bab448 Thierry Reding     2015-07-29  1824  	if (err < 0)
01b9bea0c Thierry Reding     2015-11-11  1825  		dev_err(sor->dev, "failed to power up eDP link: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1826  
9542c2376 Thierry Reding     2015-07-08  1827  	err = drm_dp_link_configure(sor->aux, &link);
850bab448 Thierry Reding     2015-07-29  1828  	if (err < 0)
01b9bea0c Thierry Reding     2015-11-11  1829  		dev_err(sor->dev, "failed to configure eDP link: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1830  
6b6b60421 Thierry Reding     2013-11-15  1831  	rate = drm_dp_link_rate_to_bw_code(link.rate);
6b6b60421 Thierry Reding     2013-11-15  1832  	lanes = link.num_lanes;
6b6b60421 Thierry Reding     2013-11-15  1833  
6b6b60421 Thierry Reding     2013-11-15  1834  	value = tegra_sor_readl(sor, SOR_CLK_CNTRL);
6b6b60421 Thierry Reding     2013-11-15  1835  	value &= ~SOR_CLK_CNTRL_DP_LINK_SPEED_MASK;
6b6b60421 Thierry Reding     2013-11-15  1836  	value |= SOR_CLK_CNTRL_DP_LINK_SPEED(rate);
6b6b60421 Thierry Reding     2013-11-15  1837  	tegra_sor_writel(sor, value, SOR_CLK_CNTRL);
6b6b60421 Thierry Reding     2013-11-15  1838  
a9a9e4fd7 Thierry Reding     2015-04-27  1839  	value = tegra_sor_readl(sor, SOR_DP_LINKCTL0);
6b6b60421 Thierry Reding     2013-11-15  1840  	value &= ~SOR_DP_LINKCTL_LANE_COUNT_MASK;
6b6b60421 Thierry Reding     2013-11-15  1841  	value |= SOR_DP_LINKCTL_LANE_COUNT(lanes);
6b6b60421 Thierry Reding     2013-11-15  1842  
6b6b60421 Thierry Reding     2013-11-15  1843  	if (link.capabilities & DP_LINK_CAP_ENHANCED_FRAMING)
6b6b60421 Thierry Reding     2013-11-15  1844  		value |= SOR_DP_LINKCTL_ENHANCED_FRAME;
6b6b60421 Thierry Reding     2013-11-15  1845  
a9a9e4fd7 Thierry Reding     2015-04-27  1846  	tegra_sor_writel(sor, value, SOR_DP_LINKCTL0);
6b6b60421 Thierry Reding     2013-11-15  1847  
6b6b60421 Thierry Reding     2013-11-15  1848  	/* disable training pattern generator */
6b6b60421 Thierry Reding     2013-11-15  1849  
6b6b60421 Thierry Reding     2013-11-15  1850  	for (i = 0; i < link.num_lanes; i++) {
6b6b60421 Thierry Reding     2013-11-15  1851  		unsigned long lane = SOR_DP_TPG_CHANNEL_CODING |
6b6b60421 Thierry Reding     2013-11-15  1852  				     SOR_DP_TPG_SCRAMBLER_GALIOS |
6b6b60421 Thierry Reding     2013-11-15  1853  				     SOR_DP_TPG_PATTERN_NONE;
6b6b60421 Thierry Reding     2013-11-15  1854  		value = (value << 8) | lane;
6b6b60421 Thierry Reding     2013-11-15  1855  	}
6b6b60421 Thierry Reding     2013-11-15  1856  
6b6b60421 Thierry Reding     2013-11-15  1857  	tegra_sor_writel(sor, value, SOR_DP_TPG);
6b6b60421 Thierry Reding     2013-11-15  1858  
6b6b60421 Thierry Reding     2013-11-15  1859  	err = tegra_sor_dp_train_fast(sor, &link);
01b9bea0c Thierry Reding     2015-11-11  1860  	if (err < 0)
01b9bea0c Thierry Reding     2015-11-11  1861  		dev_err(sor->dev, "DP fast link training failed: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1862  
6b6b60421 Thierry Reding     2013-11-15  1863  	dev_dbg(sor->dev, "fast link training succeeded\n");
6b6b60421 Thierry Reding     2013-11-15  1864  
6b6b60421 Thierry Reding     2013-11-15  1865  	err = tegra_sor_power_up(sor, 250);
850bab448 Thierry Reding     2015-07-29  1866  	if (err < 0)
6b6b60421 Thierry Reding     2013-11-15  1867  		dev_err(sor->dev, "failed to power up SOR: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1868  
6b6b60421 Thierry Reding     2013-11-15  1869  	/* CSTM (LVDS, link A/B, upper) */
143b1df23 Stéphane Marchesin 2014-05-22  1870  	value = SOR_CSTM_LVDS | SOR_CSTM_LINK_ACT_A | SOR_CSTM_LINK_ACT_B |
6b6b60421 Thierry Reding     2013-11-15  1871  		SOR_CSTM_UPPER;
6b6b60421 Thierry Reding     2013-11-15  1872  	tegra_sor_writel(sor, value, SOR_CSTM);
6b6b60421 Thierry Reding     2013-11-15  1873  
2bd1dd399 Thierry Reding     2015-08-03  1874  	/* use DP-A protocol */
2bd1dd399 Thierry Reding     2015-08-03  1875  	value = tegra_sor_readl(sor, SOR_STATE1);
2bd1dd399 Thierry Reding     2015-08-03  1876  	value &= ~SOR_STATE_ASY_PROTOCOL_MASK;
2bd1dd399 Thierry Reding     2015-08-03  1877  	value |= SOR_STATE_ASY_PROTOCOL_DP_A;
2bd1dd399 Thierry Reding     2015-08-03  1878  	tegra_sor_writel(sor, value, SOR_STATE1);
2bd1dd399 Thierry Reding     2015-08-03  1879  
c31efa7a3 Thierry Reding     2015-09-08  1880  	tegra_sor_mode_set(sor, mode, state);
2bd1dd399 Thierry Reding     2015-08-03  1881  
6fad8f66d Thierry Reding     2014-11-28  1882  	/* PWM setup */
6fad8f66d Thierry Reding     2014-11-28  1883  	err = tegra_sor_setup_pwm(sor, 250);
850bab448 Thierry Reding     2015-07-29  1884  	if (err < 0)
6fad8f66d Thierry Reding     2014-11-28  1885  		dev_err(sor->dev, "failed to setup PWM: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1886  
666cb8733 Thierry Reding     2014-12-08  1887  	tegra_sor_update(sor);
666cb8733 Thierry Reding     2014-12-08  1888  
6fad8f66d Thierry Reding     2014-11-28  1889  	value = tegra_dc_readl(dc, DC_DISP_DISP_WIN_OPTIONS);
c57997bce Thierry Reding     2017-10-12  1890  	value |= SOR_ENABLE(0);
6fad8f66d Thierry Reding     2014-11-28  1891  	tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
6b6b60421 Thierry Reding     2013-11-15  1892  
666cb8733 Thierry Reding     2014-12-08  1893  	tegra_dc_commit(dc);
6b6b60421 Thierry Reding     2013-11-15  1894  
6fad8f66d Thierry Reding     2014-11-28  1895  	err = tegra_sor_attach(sor);
850bab448 Thierry Reding     2015-07-29  1896  	if (err < 0)
6fad8f66d Thierry Reding     2014-11-28  1897  		dev_err(sor->dev, "failed to attach SOR: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1898  
6fad8f66d Thierry Reding     2014-11-28  1899  	err = tegra_sor_wakeup(sor);
850bab448 Thierry Reding     2015-07-29  1900  	if (err < 0)
6fad8f66d Thierry Reding     2014-11-28  1901  		dev_err(sor->dev, "failed to enable DC: %d\n", err);
6b6b60421 Thierry Reding     2013-11-15  1902  
6fad8f66d Thierry Reding     2014-11-28  1903  	if (output->panel)
6fad8f66d Thierry Reding     2014-11-28  1904  		drm_panel_enable(output->panel);
a82752e19 Thierry Reding     2014-01-31  1905  }
a82752e19 Thierry Reding     2014-01-31  1906  

:::::: The code at line 1550 was first introduced by commit
:::::: c57997bce423fb71334a1fefa524569e48a1718f drm/tegra: sor: Add Tegra186 support

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9Lmv2e8bGzzKyKzk6wEr/t6W0kE2BGRuXFXIi0N6q3h/vD79j7ErW24cR7a/oqeJ7pjpaC6i
RN2IeoC4iWVuRVAy7ReF2lZVOcK2KmR7evrvLxLgApJI0A9ll3EOFmJNAIlM8OFaHG9jGqhS
lIkhiUthGEdZ46ooYNUKXINgZhkVUZo7sCTJPdRqYRsPL5WCqP1OIMB7lSP6aEVmqj9LQRx9
TN+OXrFX9SOhvN0AymL4wSEsg28qzqSb7YV9rz5XbiNOkW17fazN+Vtexrp8u5vKNgPZdoFH
Sl1UgNmQsKXCNVCj8duH9+M3zip7adSgrn59UZnhSqubccTt9XJ6fLi8KCJ1hW3UpTXlbS5W
pS/tox4zOs6Unl7ePl5/4AVtlEhH0bJD7MdkUZ1/XE+68gqFQpp7PL6qR3RPM1Vt0yvYVgFj
kISU6gM4+Z5QUTe8SN8+Ts+selX1K2dXwUQr90Ch9aap8k6Nb9JDbknl7fw8moa0r6O7XDog
y2/JXb5X3SF3HGHr5MhvY4UfXV+Z1kS3jFfE7en94efj5cfUk1C/2ORh1SWjrnE4p9Qybn1S
gbVmJdjY5dEmcB/HJbym1JL4yXgBRj7naVtK9Kzm5Z+S1M5TUCJqe2ynbijaV4H08+OtPneu
iKynwNGUXc/UWzdlallxWlto84hhqY3PB8sofluATtuzr4eRJ3spvC9344tRV/2to3iWsVy1
bXB5T7BPaoaxJu1uHKsaj78A1HexJE7XbLuGVmq8sg0joFuk1tq5ffRpLHht2C6aagquMiw8
11rYTJ/MAoUX//HX6e382M8H3un6OJgGwDKqNzPIq5H5hVbBaDZxxlEnPpykiuv5/enlfPl4
X0QXNk+9Xsau9ZrJju2j4MVYvufCmmqTCk7uc0rj7cgCmNJDL6t3oqQDMCkut9zz/eP1AR6m
tQ7vpqt+6E8mfggjXuVulg7i7yZsHUlFBeZIiidC7TWyA2xh5CBePGcEtUbkGofHJ5Xlrg38
2ToncSPjYRLUHvL+vWftEk/zNdzNkKFUkOVwq3Y4rUpTaVWZY1xfZRJDaLGo/dtIhFJ+FcFb
snOjNQ0cWpCSASrrjstAaxzqZdQwPtkYtvoCAKID7Fjog3KJgnpCainqXXQLIxeXHazepjcw
ZlGew0mmMtECUCN9JgWhA4NjgKWeaYOiku7LWw7euLt4tWSzZ/OAawg4Tj152bWrwDgGjT31
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

--+HP7ph2BbKc20aGI--
