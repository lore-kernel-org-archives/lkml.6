Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D8C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCB92070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfADGEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:04:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:57709 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfADGEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:04:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 22:04:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="gz'50?scan'50,208,50";a="123993967"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Jan 2019 22:04:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gfIaW-0003hI-D4; Fri, 04 Jan 2019 14:04:08 +0800
Date:   Fri, 4 Jan 2019 14:03:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c:609: undefined
 reference to `ieee80211_channel_to_frequency'
Message-ID: <201901041428.39bKoNFs%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   645ff1e8e704c4f33ab1fcd3c87f95cb9b6d7144
commit: aca432f06b8a60a92b27fb46e6518a19b28ca93f iwlwifi: make MVM and DVM depend on MAC80211
date:   2 weeks ago
config: x86_64-randconfig-x018-01041209 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout aca432f06b8a60a92b27fb46e6518a19b28ca93f
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.o: In function `iwl_init_channel_map':
>> drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c:609: undefined reference to `ieee80211_channel_to_frequency'
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.o: In function `iwl_init_channel_map':
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:353: undefined reference to `ieee80211_channel_to_frequency'
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.o: In function `iwl_parse_nvm_mcc_info':
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1050: undefined reference to `ieee80211_channel_to_frequency'
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1099: undefined reference to `reg_query_regdb_wmm'
   drivers/net/wireless/intel/iwlwifi/pcie/tx.o: In function `iwl_trans_pcie_tx':
>> drivers/net/wireless/intel/iwlwifi/pcie/tx.c:2317: undefined reference to `ieee80211_hdrlen'
   drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.o: In function `iwl_pcie_gen2_build_tfd':
>> drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c:550: undefined reference to `ieee80211_hdrlen'
   drivers/net/wireless/intel/iwlwifi/iwl-devtrace.o: In function `iwl_rx_trace_len':
>> drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:81: undefined reference to `ieee80211_hdrlen'

vim +609 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c

26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  563  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  564  #define CHECK_AND_PRINT_I(x)	\
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  565  	((eeprom_ch_info[ch_idx].flags & EEPROM_CHANNEL_##x) ? # x " " : "")
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  566  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  567  static int iwl_init_channel_map(struct device *dev, const struct iwl_cfg *cfg,
b7998c8b drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Eytan Lifshitz    2012-12-01  568  				struct iwl_nvm_data *data,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  569  				const u8 *eeprom, size_t eeprom_size)
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  570  {
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  571  	int band, ch_idx;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  572  	const struct iwl_eeprom_channel *eeprom_ch_info;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  573  	const u8 *eeprom_ch_array;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  574  	int eeprom_ch_count;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  575  	int n_channels = 0;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  576  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  577  	/*
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  578  	 * Loop through the 5 EEPROM bands and add them to the parse list
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  579  	 */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  580  	for (band = 1; band <= 5; band++) {
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  581  		struct ieee80211_channel *channel;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  582  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  583  		iwl_init_band_reference(cfg, eeprom, eeprom_size, band,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  584  					&eeprom_ch_count, &eeprom_ch_info,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  585  					&eeprom_ch_array);
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  586  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  587  		/* Loop through each band adding each of the channels */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  588  		for (ch_idx = 0; ch_idx < eeprom_ch_count; ch_idx++) {
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  589  			const struct iwl_eeprom_channel *eeprom_ch;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  590  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  591  			eeprom_ch = &eeprom_ch_info[ch_idx];
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  592  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  593  			if (!(eeprom_ch->flags & EEPROM_CHANNEL_VALID)) {
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  594  				IWL_DEBUG_EEPROM(dev,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  595  						 "Ch. %d Flags %x [%sGHz] - No traffic\n",
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  596  						 eeprom_ch_array[ch_idx],
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  597  						 eeprom_ch_info[ch_idx].flags,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  598  						 (band != 1) ? "5.2" : "2.4");
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  599  				continue;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  600  			}
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  601  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  602  			channel = &data->channels[n_channels];
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  603  			n_channels++;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  604  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  605  			channel->hw_value = eeprom_ch_array[ch_idx];
57fbcce3 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c Johannes Berg     2016-04-12  606  			channel->band = (band == 1) ? NL80211_BAND_2GHZ
57fbcce3 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c Johannes Berg     2016-04-12  607  						    : NL80211_BAND_5GHZ;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  608  			channel->center_freq =
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21 @609  				ieee80211_channel_to_frequency(
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  610  					channel->hw_value, channel->band);
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  611  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  612  			/* set no-HT40, will enable as appropriate later */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  613  			channel->flags = IEEE80211_CHAN_NO_HT40;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  614  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  615  			if (!(eeprom_ch->flags & EEPROM_CHANNEL_IBSS))
8fe02e16 drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Luis R. Rodriguez 2013-10-21  616  				channel->flags |= IEEE80211_CHAN_NO_IR;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  617  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  618  			if (!(eeprom_ch->flags & EEPROM_CHANNEL_ACTIVE))
8fe02e16 drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Luis R. Rodriguez 2013-10-21  619  				channel->flags |= IEEE80211_CHAN_NO_IR;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  620  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  621  			if (eeprom_ch->flags & EEPROM_CHANNEL_RADAR)
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  622  				channel->flags |= IEEE80211_CHAN_RADAR;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  623  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  624  			/* Initialize regulatory-based run-time data */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  625  			channel->max_power =
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  626  				eeprom_ch_info[ch_idx].max_power_avg;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  627  			IWL_DEBUG_EEPROM(dev,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  628  					 "Ch. %d [%sGHz] %s%s%s%s%s%s(0x%02x %ddBm): Ad-Hoc %ssupported\n",
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  629  					 channel->hw_value,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  630  					 (band != 1) ? "5.2" : "2.4",
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  631  					 CHECK_AND_PRINT_I(VALID),
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  632  					 CHECK_AND_PRINT_I(IBSS),
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  633  					 CHECK_AND_PRINT_I(ACTIVE),
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  634  					 CHECK_AND_PRINT_I(RADAR),
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  635  					 CHECK_AND_PRINT_I(WIDE),
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  636  					 CHECK_AND_PRINT_I(DFS),
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  637  					 eeprom_ch_info[ch_idx].flags,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  638  					 eeprom_ch_info[ch_idx].max_power_avg,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  639  					 ((eeprom_ch_info[ch_idx].flags &
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  640  							EEPROM_CHANNEL_IBSS) &&
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  641  					  !(eeprom_ch_info[ch_idx].flags &
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  642  							EEPROM_CHANNEL_RADAR))
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  643  						? "" : "not ");
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  644  		}
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  645  	}
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  646  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  647  	if (cfg->eeprom_params->enhanced_txpower) {
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  648  		/*
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  649  		 * for newer device (6000 series and up)
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  650  		 * EEPROM contain enhanced tx power information
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  651  		 * driver need to process addition information
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  652  		 * to determine the max channel tx power limits
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  653  		 */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  654  		iwl_eeprom_enhanced_txpower(dev, data, eeprom, eeprom_size,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  655  					    n_channels);
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  656  	} else {
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  657  		/* All others use data from channel map */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  658  		int i;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  659  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  660  		data->max_tx_pwr_half_dbm = -128;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  661  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  662  		for (i = 0; i < n_channels; i++)
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  663  			data->max_tx_pwr_half_dbm =
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  664  				max_t(s8, data->max_tx_pwr_half_dbm,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  665  				      data->channels[i].max_power * 2);
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  666  	}
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  667  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  668  	/* Check if we do have HT40 channels */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  669  	if (cfg->eeprom_params->regulatory_bands[5] ==
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  670  				EEPROM_REGULATORY_BAND_NO_HT40 &&
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  671  	    cfg->eeprom_params->regulatory_bands[6] ==
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  672  				EEPROM_REGULATORY_BAND_NO_HT40)
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  673  		return n_channels;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  674  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  675  	/* Two additional EEPROM bands for 2.4 and 5 GHz HT40 channels */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  676  	for (band = 6; band <= 7; band++) {
57fbcce3 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c Johannes Berg     2016-04-12  677  		enum nl80211_band ieeeband;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  678  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  679  		iwl_init_band_reference(cfg, eeprom, eeprom_size, band,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  680  					&eeprom_ch_count, &eeprom_ch_info,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  681  					&eeprom_ch_array);
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  682  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  683  		/* EEPROM band 6 is 2.4, band 7 is 5 GHz */
57fbcce3 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c Johannes Berg     2016-04-12  684  		ieeeband = (band == 6) ? NL80211_BAND_2GHZ
57fbcce3 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c Johannes Berg     2016-04-12  685  				       : NL80211_BAND_5GHZ;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  686  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  687  		/* Loop through each band adding each of the channels */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  688  		for (ch_idx = 0; ch_idx < eeprom_ch_count; ch_idx++) {
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  689  			/* Set up driver's info for lower half */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  690  			iwl_mod_ht40_chan_info(dev, data, n_channels, ieeeband,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  691  					       eeprom_ch_array[ch_idx],
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  692  					       &eeprom_ch_info[ch_idx],
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  693  					       IEEE80211_CHAN_NO_HT40PLUS);
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  694  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  695  			/* Set up driver's info for upper half */
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  696  			iwl_mod_ht40_chan_info(dev, data, n_channels, ieeeband,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  697  					       eeprom_ch_array[ch_idx] + 4,
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  698  					       &eeprom_ch_info[ch_idx],
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  699  					       IEEE80211_CHAN_NO_HT40MINUS);
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  700  		}
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  701  	}
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  702  
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  703  	return n_channels;
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  704  }
26a7ca9a drivers/net/wireless/iwlwifi/iwl-eeprom-parse.c       Johannes Berg     2012-05-21  705  

:::::: The code at line 609 was first introduced by commit
:::::: 26a7ca9a71a3f7e1826de96b1a1e907123e11b07 iwlwifi: refactor EEPROM reading/parsing

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Bz7OAQA=

--6c2NcOVqGQ03X4Wi--
