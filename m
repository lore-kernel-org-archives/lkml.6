Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEF7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D40120874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D40120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbeGWIW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:22:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:15766 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387796AbeGWIW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:22:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 00:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,392,1526367600"; 
   d="gz'50?scan'50,208,50";a="73641955"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2018 00:06:18 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fhUvB-000Kdn-8F; Mon, 23 Jul 2018 15:06:17 +0800
Date:   Mon, 23 Jul 2018 15:05:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pengbo Mu <pengbo.mu@nxp.com>
Cc:     kbuild-all@01.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        ran.wang_1@nxp.com, pengbo.mu@nxp.com
Subject: Re: [PATCH] usb: dwc3: call set incr burst type func()
Message-ID: <201807231412.97HYMoRm%fengguang.wu@intel.com>
References: <1532316853-29184-1-git-send-email-pengbo.mu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <1532316853-29184-1-git-send-email-pengbo.mu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pengbo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on balbi-usb/next]
[also build test ERROR on v4.18-rc6 next-20180720]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pengbo-Mu/usb-dwc3-call-set-incr-burst-type-func/20180723-132027
base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
config: i386-randconfig-s1-201829 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/core.c: In function 'dwc3_core_init':
>> drivers/usb/dwc3/core.c:843:2: error: implicit declaration of function 'dwc3_set_incr_burst_type' [-Werror=implicit-function-declaration]
     dwc3_set_incr_burst_type(dwc);
     ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/dwc3_set_incr_burst_type +843 drivers/usb/dwc3/core.c

   780	
   781	/**
   782	 * dwc3_core_init - Low-level initialization of DWC3 Core
   783	 * @dwc: Pointer to our controller context structure
   784	 *
   785	 * Returns 0 on success otherwise negative errno.
   786	 */
   787	static int dwc3_core_init(struct dwc3 *dwc)
   788	{
   789		u32			reg;
   790		int			ret;
   791	
   792		if (!dwc3_core_is_valid(dwc)) {
   793			dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
   794			ret = -ENODEV;
   795			goto err0;
   796		}
   797	
   798		/*
   799		 * Write Linux Version Code to our GUID register so it's easy to figure
   800		 * out which kernel version a bug was found.
   801		 */
   802		dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
   803	
   804		/* Handle USB2.0-only core configuration */
   805		if (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
   806				DWC3_GHWPARAMS3_SSPHY_IFC_DIS) {
   807			if (dwc->maximum_speed == USB_SPEED_SUPER)
   808				dwc->maximum_speed = USB_SPEED_HIGH;
   809		}
   810	
   811		ret = dwc3_phy_setup(dwc);
   812		if (ret)
   813			goto err0;
   814	
   815		if (!dwc->ulpi_ready) {
   816			ret = dwc3_core_ulpi_init(dwc);
   817			if (ret)
   818				goto err0;
   819			dwc->ulpi_ready = true;
   820		}
   821	
   822		if (!dwc->phys_ready) {
   823			ret = dwc3_core_get_phy(dwc);
   824			if (ret)
   825				goto err0a;
   826			dwc->phys_ready = true;
   827		}
   828	
   829		ret = dwc3_core_soft_reset(dwc);
   830		if (ret)
   831			goto err0a;
   832	
   833		dwc3_core_setup_global_control(dwc);
   834		dwc3_core_num_eps(dwc);
   835	
   836		ret = dwc3_setup_scratch_buffers(dwc);
   837		if (ret)
   838			goto err1;
   839	
   840		/* Adjust Frame Length */
   841		dwc3_frame_length_adjustment(dwc);
   842	
 > 843		dwc3_set_incr_burst_type(dwc);
   844	
   845		usb_phy_set_suspend(dwc->usb2_phy, 0);
   846		usb_phy_set_suspend(dwc->usb3_phy, 0);
   847		ret = phy_power_on(dwc->usb2_generic_phy);
   848		if (ret < 0)
   849			goto err2;
   850	
   851		ret = phy_power_on(dwc->usb3_generic_phy);
   852		if (ret < 0)
   853			goto err3;
   854	
   855		ret = dwc3_event_buffers_setup(dwc);
   856		if (ret) {
   857			dev_err(dwc->dev, "failed to setup event buffers\n");
   858			goto err4;
   859		}
   860	
   861		/*
   862		 * ENDXFER polling is available on version 3.10a and later of
   863		 * the DWC_usb3 controller. It is NOT available in the
   864		 * DWC_usb31 controller.
   865		 */
   866		if (!dwc3_is_usb31(dwc) && dwc->revision >= DWC3_REVISION_310A) {
   867			reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
   868			reg |= DWC3_GUCTL2_RST_ACTBITLATER;
   869			dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
   870		}
   871	
   872		if (dwc->revision >= DWC3_REVISION_250A) {
   873			reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
   874	
   875			/*
   876			 * Enable hardware control of sending remote wakeup
   877			 * in HS when the device is in the L1 state.
   878			 */
   879			if (dwc->revision >= DWC3_REVISION_290A)
   880				reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
   881	
   882			if (dwc->dis_tx_ipgap_linecheck_quirk)
   883				reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
   884	
   885			dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
   886		}
   887	
   888		/*
   889		 * Must config both number of packets and max burst settings to enable
   890		 * RX and/or TX threshold.
   891		 */
   892		if (dwc3_is_usb31(dwc) && dwc->dr_mode == USB_DR_MODE_HOST) {
   893			u8 rx_thr_num = dwc->rx_thr_num_pkt_prd;
   894			u8 rx_maxburst = dwc->rx_max_burst_prd;
   895			u8 tx_thr_num = dwc->tx_thr_num_pkt_prd;
   896			u8 tx_maxburst = dwc->tx_max_burst_prd;
   897	
   898			if (rx_thr_num && rx_maxburst) {
   899				reg = dwc3_readl(dwc->regs, DWC3_GRXTHRCFG);
   900				reg |= DWC31_RXTHRNUMPKTSEL_PRD;
   901	
   902				reg &= ~DWC31_RXTHRNUMPKT_PRD(~0);
   903				reg |= DWC31_RXTHRNUMPKT_PRD(rx_thr_num);
   904	
   905				reg &= ~DWC31_MAXRXBURSTSIZE_PRD(~0);
   906				reg |= DWC31_MAXRXBURSTSIZE_PRD(rx_maxburst);
   907	
   908				dwc3_writel(dwc->regs, DWC3_GRXTHRCFG, reg);
   909			}
   910	
   911			if (tx_thr_num && tx_maxburst) {
   912				reg = dwc3_readl(dwc->regs, DWC3_GTXTHRCFG);
   913				reg |= DWC31_TXTHRNUMPKTSEL_PRD;
   914	
   915				reg &= ~DWC31_TXTHRNUMPKT_PRD(~0);
   916				reg |= DWC31_TXTHRNUMPKT_PRD(tx_thr_num);
   917	
   918				reg &= ~DWC31_MAXTXBURSTSIZE_PRD(~0);
   919				reg |= DWC31_MAXTXBURSTSIZE_PRD(tx_maxburst);
   920	
   921				dwc3_writel(dwc->regs, DWC3_GTXTHRCFG, reg);
   922			}
   923		}
   924	
   925		return 0;
   926	
   927	err4:
   928		phy_power_off(dwc->usb3_generic_phy);
   929	
   930	err3:
   931		phy_power_off(dwc->usb2_generic_phy);
   932	
   933	err2:
   934		usb_phy_set_suspend(dwc->usb2_phy, 1);
   935		usb_phy_set_suspend(dwc->usb3_phy, 1);
   936	
   937	err1:
   938		usb_phy_shutdown(dwc->usb2_phy);
   939		usb_phy_shutdown(dwc->usb3_phy);
   940		phy_exit(dwc->usb2_generic_phy);
   941		phy_exit(dwc->usb3_generic_phy);
   942	
   943	err0a:
   944		dwc3_ulpi_exit(dwc);
   945	
   946	err0:
   947		return ret;
   948	}
   949	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--AqsLC8rIMeq19msA--
