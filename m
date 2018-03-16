Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3887703-1521232429-2-11564376997779625061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: .config.gz
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521232428; b=f06lIM0E4ENyibTDskqqHXTBY7luEvAWB00bWv1HjXYedg7
    AAMqIk5VtDf3lfQ+ji3vS9oKRd6CBuhvzfrnmUKgnPueUGkIOvrXtlahaO1ETl2c
    LcsTJC+LvnUZEHP0AVn43mOBz+V/Fiw2b0jC0RWRuMibRGnup6JLOJ50eyhHrRb1
    lorPD+elmACddWU6JltS5JZ+Rqph5LZpIThkBg1sy9Yy55mVE0//XHu0ggt2F22k
    Wcj7LZPY7E10xVkYwXShNabQVtIuVyFROceKHfoaNumoI1V8pnQVgVr/qsMES9Dp
    7U0JOBF9AlqtuRpIx6Dr1pk9grvoPDCeD/KlW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521232428; bh=TnVgYlWgLGiNshdsdb0KT2Lflv
    DK6IQ729qRTi+H2L0=; b=Wu655gwc+IZ7XinzndTdq3jUOZAY6j9FSEvMgQ6MXX
    f86CVoMu6ZBCHn2vHbaQTz+CZZCInqS20l90uPHbtrKldomrPTydhL1wud45IexR
    hdVNyDOATKpYaGYuHv25e3uXp/8US8+MfB+LMTEE+QeBWJUlGBqGEMqtuQm2FeB/
    97taIlzMiPQ+1f5XO2qWiBeyEQo/LZ/zyI2C98eJ51wOHSpCyHqEV8CEeg6qVZfk
    ckSmLOElAo/jA74I2A0rzbcJnanAaW0fWnCQj/MUkLjdRBsdqIaSioVHHuOPfrx4
    07lQTP5WTudDAVPZXf0c+PsMq1hqearpzDY6JpwVQRQw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeCPUdT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 16:33:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:19531 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751495AbeCPUdR (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Mar 2018 16:33:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="gz'50?scan'50,208,50";a="39614874"
Date: Sat, 17 Mar 2018 04:33:12 +0800
From: kbuild test robot <lkp@intel.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: kbuild-all@01.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] usb: dwc3: add clock and resets
Message-ID: <201803170423.9Kx2iKEA%fengguang.wu@intel.com>
References: <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/usb-dwc3-use-local-copy-of-resource-to-fix-up-register-offset/20180317-011715
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.ablkcipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.blkcipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.cipher' not described in 'crypto_alg'
   include/linux/crypto.h:477: warning: Function parameter or member 'cra_u.compress' not described in 'crypto_alg'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.prev_bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4129: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2259: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2259: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:950: warning: Function parameter or member 'rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:950: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:584: warning: Function parameter or member 'msdu' not described in 'sta_info'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.sign' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.realbits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.storagebits' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.shift' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.repeat' not described in 'iio_chan_spec'
   include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.endianness' not described in 'iio_chan_spec'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/device.h:294: warning: Function parameter or member 'coredump' not described in 'device_driver'
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/mtd/rawnand.h:709: warning: Function parameter or member 'timings.sdr' not described in 'nand_data_interface'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf.in' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:774: warning: Function parameter or member 'buf.out' not described in 'nand_op_data_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.cmd' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.data' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:820: warning: Function parameter or member 'ctx.waitrdy' not described in 'nand_op_instr'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:967: warning: Function parameter or member 'ctx.data' not described in 'nand_op_parser_pattern_elem'
   include/linux/mtd/rawnand.h:1281: warning: Function parameter or member 'manufacturer.desc' not described in 'nand_chip'
   include/linux/mtd/rawnand.h:1281: warning: Function parameter or member 'manufacturer.priv' not described in 'nand_chip'
   include/linux/regulator/driver.h:221: warning: Function parameter or member 'resume_early' not described in 'regulator_ops'
   drivers/regulator/core.c:4299: warning: Excess function parameter 'state' description in 'regulator_suspend_late'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
>> drivers/usb/dwc3/core.h:1028: warning: Function parameter or member 'clks' not described in 'dwc3'
>> drivers/usb/dwc3/core.h:1028: warning: Function parameter or member 'num_clks' not described in 'dwc3'
>> drivers/usb/dwc3/core.h:1028: warning: Function parameter or member 'resets' not described in 'dwc3'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.left' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.right' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.top' not described in 'drm_tv_connector_state'
   include/drm/drm_connector.h:370: warning: Function parameter or member 'margins.bottom' not described in 'drm_tv_connector_state'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.base' not described in 'drm_pending_vblank_event'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.vbl' not described in 'drm_pending_vblank_event'
   include/drm/drm_vblank.h:63: warning: Function parameter or member 'event.seq' not described in 'drm_pending_vblank_event'
   include/linux/skbuff.h:846: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'skb_mstamp' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__unused' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'pfmemalloc' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'offload_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'offload_mr_fwd_mark' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:846: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:234: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:234: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.rmem_alloc' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.len' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.head' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_backlog.tail' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:487: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'adj_list.upper' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'adj_list.lower' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'switchdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:1940: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   include/linux/rcupdate.h:570: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:574: ERROR: Unexpected indentation.
   include/linux/rcupdate.h:578: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:580: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/rcupdate.h:580: WARNING: Inline literal start-string without end-string.
   kernel/time/timer.c:1259: ERROR: Unexpected indentation.
   kernel/time/timer.c:1261: ERROR: Unexpected indentation.
   kernel/time/timer.c:1262: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:113: ERROR: Unexpected indentation.
   include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1113: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:327: WARNING: Inline literal start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   drivers/video/fbdev/core/modedb.c:647: WARNING: Inline strong start-string without end-string.
   include/linux/iio/iio.h:191: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:192: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:198: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/ata/libata-core.c:5920: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5052: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1901: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/mtd/rawnand.h:805: ERROR: Unexpected indentation.
   include/linux/mtd/rawnand.h:1391: WARNING: Inline strong start-string without end-string.
   include/linux/mtd/rawnand.h:1393: WARNING: Inline strong start-string without end-string.
   include/linux/regulator/driver.h:273: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   Documentation/driver-api/slimbus.rst:93: WARNING: Title underline too short.

vim +1028 drivers/usb/dwc3/core.h

72246da4 Felipe Balbi 2011-08-19 @1028  

:::::: The code at line 1028 was first introduced by commit
:::::: 72246da40f3719af3bfd104a2365b32537c27d83 usb: Introduce DesignWare USB3 DRD Driver

:::::: TO: Felipe Balbi <balbi@ti.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--rwEMma7ioTxnRzrJ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICG0irFoAAy5jb25maWcAjFxbc+M2sn7Pr2AlVacmD5nxbRynTvkBAkEJEUEyBCjJfmEp
sjyjGlvySnIy8+9PN0CKt4b2bFU2EboB4tKXrxsN//LTLwF7P+5el8fNavny8iP4st6u98vj
+il43rys/zcI0yBJTSBCaT4Cc7zZvn//tLm+uw1uPl7efrz4bb+6Cabr/Xb9EvDd9nnz5R26
b3bbn34Bdp4mkRyXtzcjaYLNIdjujsFhffypal/c3ZbXV/c/Wr+bHzLRJi+4kWlShoKnocgb
YlqYrDBllOaKmfuf1y/P11e/4bR+rjlYzifQL3I/739e7ldfP32/u/20srM82EWUT+tn9/vU
L075NBRZqYssS3PTfFIbxqcmZ1wMaUoVzQ/7ZaVYVuZJWMLKdalkcn93js4W95e3NANPVcbM
fx2nw9YZLhEiLPW4DBUrY5GMzaSZ61gkIpe8lJohfUiYzIUcT0x/deyhnLCZKDNeRiFvqPlc
C1Uu+GTMwrBk8TjNpZmo4bicxXKUMyPgjGL20Bt/wnTJs6LMgbagaIxPRBnLBM5CPoqGw05K
C1NkZSZyOwbLRWtddjNqklAj+BXJXJuST4pk6uHL2FjQbG5GciTyhFlJzVKt5SgWPRZd6EzA
KXnIc5aYclLAVzIFZzWBOVMcdvNYbDlNPBp8w0qlLtPMSAXbEoIOwR7JZOzjDMWoGNvlsRgE
38dWZHk6ErohR3JRCpbHD/C7VKJ1vtnYMFgfCNpMxPr+6qTN+V/lPM1bWzcqZBzCREUpFq6P
7uiUmcDB4RKiFP6vNExjZ2tWxtZIvaApeX+DlnrEPJ2KpIQpaZW1DYk0pUhmsChQb9gZc399
mhfP4USs8kg4lZ9/boxW1VYaoSnbBdvF4pnINZx6p1+bULLCpERnK6ZTEBoRl+NHmfUEuKKM
gHJFk+LHtrK2KYtHX4/UR7hpCN05ndbUnlB7OX0GnNY5+uLxfO/0PPmG2Eow8ayIQXtSbRKm
4Aw/bHfb9a+tE9EPeiYzTo7tzh9EOM0fSmbAxk9IvkILMFi+o7TqwgpwkvAtOP64llQQ++Dw
/vfhx+G4fm0k9WR2QSusbhEWGUh6ks5pSi60yGfO5ChwjS1pByq4RQ7a7zSoo/46Y7kWyNS0
cXR5Oi2gD5gZwydh2jcYbZaQGUZ3noFND9Gkxwwt5QOPiXVZjZ8129T3Czge2I7E6LNEdIUl
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

--rwEMma7ioTxnRzrJ--
