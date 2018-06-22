Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1431C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917CB2403B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917CB2403B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeFVKUm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:20:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:50274 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753270AbeFVKUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:20:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 03:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,256,1526367600"; 
   d="gz'50?scan'50,208,50";a="66318615"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2018 03:20:38 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fWJBG-00017k-8K; Fri, 22 Jun 2018 18:20:38 +0800
Date:   Fri, 22 Jun 2018 18:35:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     kbuild-all@01.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
Message-ID: <201806221730.XI4SSWE9%fengguang.wu@intel.com>
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20180622071542.61569-1-xlpang@linux.alibaba.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Xunlei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on v4.18-rc1 next-20180622]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Xunlei-Pang/sched-cputime-Ensure-correct-utime-and-stime-proportion/20180622-153720
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   mm/mempool.c:228: warning: Function parameter or member 'pool' not described in 'mempool_init'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.avg_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
>> include/linux/sched.h:259: warning: Function parameter or member 'cputime' not described in 'prev_cputime'
   kernel/sched/fair.c:3760: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
   include/linux/device.h:93: warning: bad line: this bus.
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/device.h:94: warning: bad line: this bus.
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/regulator/driver.h:227: warning: Function parameter or member 'resume_early' not described in 'regulator_ops'
   drivers/regulator/core.c:4465: warning: Excess function parameter 'state' description in 'regulator_suspend_late'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/usb/dwc3/gadget.c:510: warning: Excess function parameter 'dwc' description in 'dwc3_gadget_start_config'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   drivers/gpu/drm/i915/i915_vma.h:48: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   include/drm/tinydrm/tinydrm.h:34: warning: Function parameter or member 'fb_dirty' not described in 'tinydrm_device'
   drivers/gpu/drm/tinydrm/mipi-dbi.c:272: warning: Function parameter or member 'crtc_state' not described in 'mipi_dbi_enable_flush'
   drivers/gpu/drm/tinydrm/mipi-dbi.c:272: warning: Function parameter or member 'plane_state' not described in 'mipi_dbi_enable_flush'

vim +259 include/linux/sched.h

d37f761db Frederic Weisbecker 2012-11-22 @259  

:::::: The code at line 259 was first introduced by commit
:::::: d37f761dbd276790f70dcf73a287fde2c3464482 cputime: Consolidate cputime adjustment code

:::::: TO: Frederic Weisbecker <fweisbec@gmail.com>
:::::: CC: Frederic Weisbecker <fweisbec@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wLkznaYa6LO+GjQg/VFcmf+34nGX6lkAAA==

--lrZ03NoBR/3+SXJZ--
