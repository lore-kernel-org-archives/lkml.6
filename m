Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D56C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E0323F0D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E0323F0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbeFVIfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:35:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:60222 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754253AbeFVIfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:35:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 01:35:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,256,1526367600"; 
   d="gz'50?scan'50,208,50";a="66298127"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2018 01:35:12 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fWHXD-0008KM-Ia; Fri, 22 Jun 2018 16:35:11 +0800
Date:   Fri, 22 Jun 2018 16:34:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     kbuild-all@01.org, jiangshanlai@gmail.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Message-ID: <201806221642.HoutHCRt%fengguang.wu@intel.com>
References: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Byungchul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rcu/rcu/next]
[also build test WARNING on v4.18-rc1 next-20180622]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Byungchul-Park/rcu-Refactor-rcu_-nmi-irq-_-enter-exit/20180622-141334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
>> kernel/rcu/tree.c:778: warning: Function parameter or member 'irq' not described in 'rcu_nmi_exit_common'
>> kernel/rcu/tree.c:938: warning: Function parameter or member 'irq' not described in 'rcu_nmi_enter_common'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4216: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
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
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >
   include/net/mac80211.h:2083: warning: bad line: >

vim +778 kernel/rcu/tree.c

19dd1591f kernel/rcutree.c  Frederic Weisbecker 2012-06-04  765  
19dd1591f kernel/rcutree.c  Frederic Weisbecker 2012-06-04  766  /**
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  767   * rcu_nmi_exit_common - inform RCU of exit from NMI context
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  768   *
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  769   * If we are returning from the outermost NMI handler that interrupted an
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  770   * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  771   * to let the RCU grace-period handling know that the CPU is back to
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  772   * being RCU-idle.
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  773   *
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  774   * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  775   * with CONFIG_RCU_EQS_DEBUG=y.
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  776   */
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  777  static __always_inline void rcu_nmi_exit_common(bool irq)
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02 @778  {
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  779  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  780  
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  781  	/*
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  782  	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  783  	 * (We are exiting an NMI handler, so RCU better be paying attention
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  784  	 * to us!)
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  785  	 */
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  786  	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting <= 0);
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  787  	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  788  
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  789  	/*
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  790  	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  791  	 * leave it in non-RCU-idle state.
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  792  	 */
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  793  	if (rdtp->dynticks_nmi_nesting != 1) {
dec98900e kernel/rcu/tree.c Paul E. McKenney    2017-10-04  794  		trace_rcu_dyntick(TPS("--="), rdtp->dynticks_nmi_nesting, rdtp->dynticks_nmi_nesting - 2, rdtp->dynticks);
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  795  		WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* No store tearing. */
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  796  			   rdtp->dynticks_nmi_nesting - 2);
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  797  		return;
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  798  	}
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  799  
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  800  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
dec98900e kernel/rcu/tree.c Paul E. McKenney    2017-10-04  801  	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  802  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  803  
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  804  	if (irq)
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  805  		rcu_prepare_for_idle();
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  806  
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  807  	rcu_dynticks_eqs_enter();
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  808  
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  809  	if (irq)
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  810  		rcu_dynticks_task_enter();
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  811  }
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  812  
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  813  /**
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  814   * rcu_nmi_exit - inform RCU of exit from NMI context
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  815   */
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  816  void rcu_nmi_exit(void)
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  817  {
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  818  	rcu_nmi_exit_common(false);
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  819  }
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  820  
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  821  /**
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  822   * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  823   *
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  824   * Exit from an interrupt handler, which might possibly result in entering
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  825   * idle mode, in other words, leaving the mode in which read-side critical
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  826   * sections can occur.  The caller must have disabled interrupts.
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  827   *
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  828   * This code assumes that the idle loop never does anything that might
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  829   * result in unbalanced calls to irq_enter() and irq_exit().  If your
58721f5da kernel/rcu/tree.c Paul E. McKenney    2017-10-03  830   * architecture's idle loop violates this assumption, RCU will give you what
58721f5da kernel/rcu/tree.c Paul E. McKenney    2017-10-03  831   * you deserve, good and hard.  But very infrequently and irreproducibly.
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  832   *
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  833   * Use things like work queues to work around this limitation.
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  834   *
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  835   * You have been warned.
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  836   *
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  837   * If you add or remove a call to rcu_irq_exit(), be sure to test with
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  838   * CONFIG_RCU_EQS_DEBUG=y.
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  839   */
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  840  void rcu_irq_exit(void)
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  841  {
b04db8e19 kernel/rcu/tree.c Frederic Weisbecker 2017-11-06  842  	lockdep_assert_irqs_disabled();
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  843  	rcu_nmi_exit_common(true);
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  844  }
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  845  
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  846  /*
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  847   * Wrapper for rcu_irq_exit() where interrupts are enabled.
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  848   *
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  849   * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  850   * with CONFIG_RCU_EQS_DEBUG=y.
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  851   */
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  852  void rcu_irq_exit_irqson(void)
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  853  {
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  854  	unsigned long flags;
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  855  
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  856  	local_irq_save(flags);
7c9906ca5 kernel/rcu/tree.c Paul E. McKenney    2015-10-31  857  	rcu_irq_exit();
23b5c8fa0 kernel/rcutree.c  Paul E. McKenney    2010-09-07  858  	local_irq_restore(flags);
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  859  }
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  860  
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  861  /*
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  862   * Exit an RCU extended quiescent state, which can be either the
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  863   * idle loop or adaptive-tickless usermode execution.
51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  864   *
51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  865   * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  866   * allow for the possibility of usermode upcalls messing up our count of
51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  867   * interrupt nesting level during the busy period that is just now starting.
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  868   */
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  869  static void rcu_eqs_exit(bool user)
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  870  {
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  871  	struct rcu_dynticks *rdtp;
84585aa8b kernel/rcu/tree.c Paul E. McKenney    2017-10-04  872  	long oldval;
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  873  
b04db8e19 kernel/rcu/tree.c Frederic Weisbecker 2017-11-06  874  	lockdep_assert_irqs_disabled();
c9d4b0af9 kernel/rcutree.c  Christoph Lameter   2013-08-31  875  	rdtp = this_cpu_ptr(&rcu_dynticks);
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  876  	oldval = rdtp->dynticks_nesting;
1ce46ee59 kernel/rcu/tree.c Paul E. McKenney    2015-05-05  877  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  878  	if (oldval) {
51a1fd30f kernel/rcu/tree.c Paul E. McKenney    2017-10-03  879  		rdtp->dynticks_nesting++;
9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  880  		return;
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  881  	}
9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  882  	rcu_dynticks_task_exit();
9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  883  	rcu_dynticks_eqs_exit();
9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  884  	rcu_cleanup_after_idle();
9dd238e28 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  885  	trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
e68bbb266 kernel/rcu/tree.c Paul E. McKenney    2017-10-05  886  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
2342172fd kernel/rcu/tree.c Paul E. McKenney    2017-10-05  887  	WRITE_ONCE(rdtp->dynticks_nesting, 1);
6136d6e48 kernel/rcu/tree.c Paul E. McKenney    2017-10-03  888  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
3a5924052 kernel/rcu/tree.c Paul E. McKenney    2013-10-04  889  }
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  890  
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  891  /**
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  892   * rcu_idle_exit - inform RCU that current CPU is leaving idle
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  893   *
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  894   * Exit idle mode, in other words, -enter- the mode in which RCU
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  895   * read-side critical sections can occur.
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  896   *
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  897   * If you add or remove a call to rcu_idle_exit(), be sure to test with
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  898   * CONFIG_RCU_EQS_DEBUG=y.
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  899   */
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  900  void rcu_idle_exit(void)
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  901  {
c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  902  	unsigned long flags;
c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  903  
c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  904  	local_irq_save(flags);
cb349ca95 kernel/rcutree.c  Paul E. McKenney    2012-09-04  905  	rcu_eqs_exit(false);
c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  906  	local_irq_restore(flags);
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  907  }
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  908  
d1ec4c34c kernel/rcu/tree.c Paul E. McKenney    2015-05-13  909  #ifdef CONFIG_NO_HZ_FULL
9b2e4f188 kernel/rcutree.c  Paul E. McKenney    2011-09-30  910  /**
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  911   * rcu_user_exit - inform RCU that we are exiting userspace.
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  912   *
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  913   * Exit RCU idle mode while entering the kernel because it can
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  914   * run a RCU read side critical section anytime.
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  915   *
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  916   * If you add or remove a call to rcu_user_exit(), be sure to test with
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  917   * CONFIG_RCU_EQS_DEBUG=y.
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  918   */
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  919  void rcu_user_exit(void)
adf5091e6 kernel/rcutree.c  Frederic Weisbecker 2012-06-28  920  {
91d1aa43d kernel/rcutree.c  Frederic Weisbecker 2012-11-27  921  	rcu_eqs_exit(1);
c5d900bf6 kernel/rcutree.c  Frederic Weisbecker 2012-07-11  922  }
d1ec4c34c kernel/rcu/tree.c Paul E. McKenney    2015-05-13  923  #endif /* CONFIG_NO_HZ_FULL */
19dd1591f kernel/rcutree.c  Frederic Weisbecker 2012-06-04  924  
19dd1591f kernel/rcutree.c  Frederic Weisbecker 2012-06-04  925  /**
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  926   * rcu_nmi_enter_common - inform RCU of entry to NMI context
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  927   *
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  928   * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  929   * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  930   * that the CPU is active.  This implementation permits nested NMIs, as
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  931   * long as the nesting level does not overflow an int.  (You will probably
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  932   * run out of stack space first.)
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  933   *
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  934   * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
c0da313e0 kernel/rcu/tree.c Paul E. McKenney    2017-09-22  935   * with CONFIG_RCU_EQS_DEBUG=y.
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  936   */
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  937  static __always_inline void rcu_nmi_enter_common(bool irq)
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18 @938  {
c9d4b0af9 kernel/rcutree.c  Christoph Lameter   2013-08-31  939  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
84585aa8b kernel/rcu/tree.c Paul E. McKenney    2017-10-04  940  	long incby = 2;
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  941  
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  942  	/* Complain about underflow. */
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  943  	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting < 0);
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  944  
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  945  	/*
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  946  	 * If idle from RCU viewpoint, atomically increment ->dynticks
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  947  	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  948  	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  949  	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  950  	 * to be in the outermost NMI handler that interrupted an RCU-idle
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  951  	 * period (observation due to Andy Lutomirski).
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  952  	 */
02a5c550b kernel/rcu/tree.c Paul E. McKenney    2016-11-02  953  	if (rcu_dynticks_curr_cpu_in_eqs()) {
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  954  
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  955  		if (irq)
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  956  			rcu_dynticks_task_exit();
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  957  
2625d469b kernel/rcu/tree.c Paul E. McKenney    2016-11-02  958  		rcu_dynticks_eqs_exit();
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  959  
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  960  		if (irq)
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  961  			rcu_cleanup_after_idle();
1e8a49734 kernel/rcu/tree.c Byungchul Park      2018-06-22  962  
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  963  		incby = 1;
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  964  	}
bd2b879a1 kernel/rcu/tree.c Paul E. McKenney    2017-10-04  965  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
bd2b879a1 kernel/rcu/tree.c Paul E. McKenney    2017-10-04  966  			  rdtp->dynticks_nmi_nesting,
dec98900e kernel/rcu/tree.c Paul E. McKenney    2017-10-04  967  			  rdtp->dynticks_nmi_nesting + incby, rdtp->dynticks);
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  968  	WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* Prevent store tearing. */
fd581a91a kernel/rcu/tree.c Paul E. McKenney    2017-10-02  969  		   rdtp->dynticks_nmi_nesting + incby);
734d16801 kernel/rcu/tree.c Paul E. McKenney    2014-11-21  970  	barrier();
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  971  }
64db4cfff kernel/rcutree.c  Paul E. McKenney    2008-12-18  972  

:::::: The code at line 778 was first introduced by commit
:::::: fd581a91ac16187625ec509414d08d37827472c4 rcu: Move rcu_nmi_{enter,exit}() to prepare for consolidation

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--y0ulUmNC+osPPQO6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICA+sLFsAAy5jb25maWcAjFxbj+O2kn4/v0JIgMUE2EymL9PpYNEPtERZjCVRESnb3S+C
49b0GOm2e31JZv79VpGSdSs6e4BzzjSrSPFS9dWFRf/4nx89djru3lbHzXr1+vrde6m21X51
rJ69L5vX6n+8QHqp1B4PhP4IzPFme/r2y+bm/s67/Xj168dPP+/XV96s2m+rV8/fbb9sXk7Q
fbPb/ufH//gyDcW0XN7flTfXD987f7d/iFTpvPC1kGkZcF8GPG+JstBZoctQ5gnTDz9Ur19u
rn/Gj//QcLDcj6BfaP98+GG1X3/95dv93S9rM5eDmWr5XH2xf5/7xdKfBTwrVZFlMtftJ5Vm
/kznzOdjWpIU7R/my0nCsjJPg3IitCoTkT7cX6Kz5cPVHc3gyyRj+l/H6bH1hks5D0o1LYOE
lTFPpzpq5zrlKc+FXwrFkD4mRAsuppEero49lhGb8zLzyzDwW2q+UDwpl340ZUFQsngqc6Gj
ZDyuz2IxyZnmcEYxexyMHzFV+llR5kBbUjTmR7yMRQpnIZ54y2EmpbgusjLjuRmD5byzLrMZ
DYknE/grFLnSpR8V6czBl7Epp9nsjMSE5ykzkppJpcQk5gMWVaiMwyk5yAuW6jIq4CtZAmcV
wZwpDrN5LDacOp6MvmGkUpUy0yKBbQlAh2CPRDp1cQZ8UkzN8lgMgu9iK7JcTrhqyaFYlpzl
8SP8XSa8c77ZVDNYHwjanMfq4fqszfkf5ULmna2bFCIOYKK85EvbR/V0SkdwcLiEUML/lJop
7Azg8aM3NVD06h2q4+m9hZNJLmc8LWFKKsm6QCJ0ydM5LArUG3ZGP9yc5+XncCJGeQScyg8/
wOgNxbaVmivtbQ7ednfED3ZwgsVznis49V6/LqFkhZZEZyOmMxAaHpfTJ5ENBLimTIByTZPi
p66ydinLJ1cP6SLctoT+nM5r6k6ou5whA07rEn35dLm3vEy+JbYSIJ4VMWiPVDplCZzhh+1u
W/3UORH1qOYi88mx7fmDCMv8sWQaMD4i+QrFAbBcR2nUhRVgCuFbcPxxI6kg9t7h9Ofh++FY
vbWSeoZd0AqjWwQiA0lFckFTcq54PreQk4Bp7Eg7UMEs+qD9VoN66q8yliuOTG2bjyZPyQL6
AMxoPwrkEDC6LAHTjO48B0wPENJjhkj56MfEuozGz9ttGtoFHA+wI9XqIhFNYcmC3wulCb5E
ImjhXJqD0Ju3an+gziJ6QpwXMhB+V+RTiRQRxJyUB0MmKRHYSzwfs9JcdXnMTMCg/KJXh7+8
I0zJW22fvcNxdTx4q/V6d9oeN9uXdm5a+DNrxHxfFqm2Z3n+FJ612c+WPPpc7heeGq8aeB9L
oHWHgz8Bi2EzKLxTlrnbXQ36i5n9h0tLCvDoLNCD9Q7saVJmboJCCAxFis4NGLoyjAsVdT/l
T3NZZIo8ADs6Iq9hInnQsXgkKZN4BpgyN1YjD4il+P7ZwKKiofAYNzT1eW+GAzb0U4jRWAoa
LFJQYTWA50IEVx13GDVGx3A+Ps+M2htXdNAn81U2gynFTOOcWqo91u78EgBNAaiW03sIDkYC
FresFZVmelShusgRRix1aRC4QuBFjJWkZchFqmf0IRVTukt//XRfBgAYFq4ZF5ovSQrPpGsf
xDRlcRiQRLNAB81AmYOmIjBKJIUJ2kyyYC5gafV50HsKY05YngvHsYPm+LNMwr4jgmmZ00c3
w/EfE/oTkyy8KBMoc8Zkh5R2nV38dqYwWgqYLrs+sfHcAx4M5R+GLs/WoyMWV59uR8hYx6ZZ
tf+y27+ttuvK439XW4BiBqDsIxiDyWgh0zF47UMjEZZWzhPjSpNLnye2f2nQ2iX3TSSX07Kv
Ykb5ISouJt1pqVhOnP1hd/Mpb3wnN1uYc3B7wJjnoMeSFsc+I4QuAVhhWqbB1QlFPLBS3fOT
lqNz0E1LmSbC6lJ3kb8XSQbexoTHrhF5GApf4J4XoKOgqGgafJ8rNbA8eHYYkoBlKydqwYY+
uQD5Q3ME89ED0mwYHtnWnGuSAGaB7mBbMX4JKXAPi9RmQ3ieg0ER6e/c/D1gg40atJj1mREj
KWcDImYF4G8tpoUsCJ8LQinjBdXeJBGMA9JqEYI7YLxAggHi8drDJidm4zyb7CkXkdBGkgjH
AOLVR3Dx0Yk0psn0GAyZ86kCoxrYdE191CXLhnuCy4ZWq70DWrQA5ePMAuGAloglSFBLVuaL
Q9MNEAftushTcBRhc0Q3dzVEKuLEUIvQOyoymKCGY679DGoQ4vsNGOX1LgRFMhRns6mt+gx3
ETxB66qhYo+O1EpZqVjIwdfOMN0zHL5WtfpUMcMw4Kj72XDZQQtk4ciVQDhX2lCmCcGJ5Snu
I5aWgB96dABTcNCyuJiKtIfmnWYXpACH2VZEAnM0A7evTwQBSGkrOmaFoyxi5jDNI27YW0lC
6ZgVnWFqhxZCR4B3VkrCHMLnoSgRIYYDXVKMLXmdxyIOHMLU+lgy7oNKdLJNQCpiQD7EYB6j
SMcEjBiKsUPjlN84pzpg4EuhaQjr97rvH7XMHhuA0nFnTIhdUrAXsG0LUNUOQcYB+oN1vu9m
RGADyG5BUgPa6ibXkS86ac8LpGF3u5MOnhyz4UXaCwOatpFHbBNtvpz//OfqUD17f1lv6X2/
+7J57QWp5/GRu2zsdS+6txpXWxRrcSKOwtJJB6JbrtB5erjq+KtWMgghb2RGA0ABiEjAyu66
JgifRDeTEYUPZSD2RYpM/WRITTcnbumXaGTfRQ4mzNW5S+z37qdcmZZo6PJkMeBAHfmj4AWC
KyzCpF/cLPmCYjAC0zjV5YSH+H9oL+pUkjn7bL9bV4fDbu8dv7/bRMWXanU87auDzWPYAZ9Q
EQJH2g+cB7IdL35CzsBAgiVB1CG5pqAzoVB0Qg69K4lbSlLBMqOqBLRvi5/nSw0Kikn+S8Gi
vaGCgxKXcg1wVNrCZ2mcAkd0FT2CYYYYDQB5WtBZ5VSWEym1Tam3WnB7f0eHc58vELSioxCk
JcmS0qk7cwHXcgKGaVEkQtADncmX6fTWNtRbmjpzLGz2q6P9nm7380JJWkgSExxwmdLUhUj9
CBwNx0Rq8g0d6iQ8Zo5xpxy0bLq8ukAtYzoHkfiPuVg693sumH9T0hl6Q3TsHcKAoxfikFMz
akQnJAmpRhEws1Vf16lIhPrhc5clvnLTEMUysCY2KaGKTjYLySDd/Ybaaby7HTbLeb8lEalI
isTkVUMIJ+LHh7su3YQEvo4T1fPsYCoYS6DjxWNwqyjHC0YEBLfo03EW6mZzeL0L74bCkoBg
B/1gRT4mGGcr4ZqRYxWJb9tb3MkgADOxM3mSQSIoJDJXnwo9rinaCPCIwTCTRMDRManOLYwI
bUMGljvJtHGQ+xtt2+cyBseE5XSetuZyyibuaiZoBDRS4PdAwZq8TirobbfdHHd76+m0X+2E
bXBoAPcLx64a8ebg7z2W88SB0lqC3E9o0ynu6fQPjptzNBKhWLpS4OA6gLSC6rmXr9zThmMS
NKqlEm83BonJRsos5bZ3Q1E33t1Scco8UVkMlvOm16VtxUyJI49mWa7pLHBL/tcRrqh5met+
GYaK64dP3/xP9j+DdRIuFbSCLvj5YzbMXoTgY1gqI2oDTCDrJhu0aa4o0UPrQIuIUcbixu3A
K7iCP5znerFvM6mEpYUJwVuv5jwjSyP2qO7cH600aG/7dRIO7XAQaOpu4GcDQ55M+r5yr7ke
dJSQa8KJaZENdiwQyoeojBjYHnqmzbgGjW4HeVcTnlGyKnLAUPDOil66YKYoVWjupE1oaS8q
g/zh9tNvdx3dJyJmCoa7dSiznlfox5ylxnzSCQOHT/6USUln5p8mBa32T2qc1G589PoUTDVI
kyTtoTnPjWWCk3d4+YDUE1CbKGGOjDdqXKbdWGYcBAjfJRZy5HmROc7QQidenGPEuHi46xx+
onMaEI1EXUh/46CwPe44x4Yi4CXTLHWSil74U3n16ROFtU/l9edPPaB9Km/6rINR6GEeYJiO
NPMld5VJMBWZPCKFl9GjEj6gEBxyjpB5VSNm97pV+sxkFC/1N1lD6H896F7fiMwDRd98+Ulg
guuJS7IB+TBDHQeauprqnrSF4AYxI6kxGXgOiXf/VHsP/IPVS/VWbY8mKGZ+JrzdO1Y29gLj
OgVEOy+Oq5Sw54k15QJeuK/+91Rt19+9w3r1OnBJjBub8z/InuL5tRoyD2saDH1yOjSL8D5k
vvCq4/rjTz3Xx6fcRGg1JZMxN2VU2Nbslr96rtCTApbKW++2x/3u9dUWYby/7/awbssXVIfN
y3ax2htWz9/BP1SfBdv59vl9t9keB3NC79NYP9qLUgwhm0oE2YrH+mqg28ER6KNUkiQZO2qL
QJzpMC7l+vPnT3QAmPlou9xQ86jCyej0+LdqfTqu/nytTHGuZ7zY48H7xeNvp9fVSDYnIg0T
jRlV+grXkpWfi4yKc2zKVRa9TGLdCZsvDZoIR1oCg1AHwNT6fzMshquTZEIObA7s72iLgurv
DQhjsN/8bW9120rCzbpu9uRYjQt7YxvxOHPFT3yukyx0JIg0mA4Wu+4AIIoxw4ciTxYst1eQ
9OmHC1A0FjgmgfZ5YQpXqH3szBUvq4NczJ2LMQx8njuScpYBiyLrYQDcIcSmcP1cjoUFTIWW
jko3JM+LGEtbJwL8M2EuIc6o9GwOrncmiaa3SIYuWE+wiPlcsgxuV12/3R6EbRqJTTpP+BCN
ks1hTU0Ldj15xKQuOTlwcWKpMOOJHojwHfurckYbB/+anCDnsK1JB1PbDxpK+duNv7wbddPV
t9XBE9vDcX96M0UPh6+AwM/ecb/aHnAoDwxN5T3DWjfv+M9m9ez1WO1XXphNGYDN/u0fBO7n
3T/b193qGcLm5xMA0Ae0WJt9BZ+49n9quortsXr1QGW9//L21at5TDAwBi0Lnr1Vy4amfBES
zXOZEa3tQNHucHQS/dX+mfqMk3/3fs6LqyOswEtad+CDL1Xy0xBjcH7n4drT8SNnZbBos/DK
V6KWtc5WnY2SEujb9HK2zAdjKNFbM+o5LkAU2/fTcTxmJ3eeFWM5i2CjzFGLX6SHXfrODlZQ
/v+Uz7D2rlxZwknR9kEiV2uQNkrZtKbzQgBdrsIpIM1cNJwVeKAIoAN/od2XLBGlLWhz5PcX
lwKFdO7S7My///Xm7ls5zRyVXany3USY0dRGQO4Un/bhvw6nE6ITf3hZZuXk2ifF45q23yqj
s9IqS2hCpOj2LBvLbKYzb/26W/81xAu+NV4PhBBYno3+OBh/fGiAUYXZEbDASYY1R8cdjFd5
x6+Vt3p+3qClX73aUQ8fe16lSH2d05EEHsOgEPxMWzg8OswRlmzuqHI0VAxLabfJ0vFeMKYF
PlokjhsMHfE8YfQ6mkJvQmeVmnTfqbQHqai6s4kPTjTFPhkkIKzpPL0eN19O2zXufoNBz2e8
bFEsDExpfumIRyONVhyixhs63oPuM55kDlcKyYm+u/nNcR8CZJW4HHQ2WX7+9Mm4We7eEGS6
rpWArEXJkpubz0u8xWABvURbDKIlrdEJDwRrrotH2zzdr96/btYHSn+D/lWntel+5n1gp+fN
Dgzc+eL3p9G7PcucBF68+XO/2n/39rvTEXyDs60L96u3yvvz9OULoHYwRu2Q1hwspIiNlYj9
gFpVK4SySKm60QKEVkYYjAqtY3MnIVinzgLpo2d72HjO3kZ+z44WahxmYZtxjZ77Fh7bs6/f
D/hS0otX39FijWU6lZn54tLnYk4uDqlTFkwdUKAfM4c6YMcizoTTdhULeuOTxHFHzBOFjw8c
4SuEIjygv2Qr7oTx5B+Jg+IB85vADQLMovOKzZBGh5SDqgPi9hsS/+r27v7qvqa0SqPxlQhT
jtglgfhp5Hrb8DBhkyIk8zhYKIElLfRyi2UgVOZ6TVA4jLZJJxMOWo9BSDiHtBiD6Ga93x12
X45e9P292v88915OFfi4hLKD8ZsO6m176YSm+KEk9qWNPCKII/iZ11VZHscslcvL9RTRoila
GXt7xryr3WnfMwnNHOKZyiHUv7/+3CmqglYIvonWSRycWzuusYgnkk7JCJkkhRNP8+ptd6zQ
86cUGwNgjcGWP+74/nZ4IftkiWpO2Q10C5GPU3UKvvNBmfc8ntyCl7x5/8k7vFfrzZdzJuMM
TeztdfcCzWrnD1FrsoeAbb17o2ibj8mSav/jtHqFLsM+nVnjC6/RlJdYMvbN1WmJNeHLcu4X
5E5kRjqHKc42kFpqp601WVz6vB3bni3G1hEj+jXs8jgAY6A5UwCyhC3LNO8WrokMSypdcGzc
PVN2ncvYFU6EyViewKntveZq/dI6mYIMpIX1k3ImU4am4trJhT5ztmTl9X2aoH9OG4ceF47n
dlx9x8VI4o+tK3H7TkFazsbozbbP+93mucsGgVguHdfYAXPkZYeho418F5gUWW+2LzTC0khn
r300Xbxmkiek1gsHPqlYJANpsg5Xk4EJxnrFA0cmsUk2wmpdN1cBwHmZT2iNDPxgwlw1e3Ia
8/MniLzTy37VyRv10iwh5q6tbHegP7AlQhDUdZ5udNQfETtUtuKzlI6KCFOTihwuawgj1Hf3
woEmgSnld8CJpZXOB3Uhu9D7j0JqWh4wbRqq29KRXQ6xSMpBk+BbgFsyINc3M+uvA79cjS6S
rU4eqtPzzlwqtOfSqjiYPNfnDc2PRBzknN5P83yQ9hLs7xs4qPb/4LwcdLxhMOcNH9Dc4a6k
8Xhb6gdhX1frv/qvcM2PfoAVCGM2VR0P1fR632+2x79M6uH5rQJr3/qQ7YSVNOI3NT+LcK6N
+vVceAlCjUUnI47b+sB2b+9wBD+bJ8Nwduu/DuaDa9u+p/xWm6jHn09wpKPNRScoKf68SpZz
n2nHs63mTrQwv3/BybpqW/2Koz1cfbq+7eJjLrKSqaR0vhjEgmrzBaZoLC1SkHOMqpOJdDxs
tDU7i/TitUZIXQRGHC9VlF3Z+GGfso+sUKoSzJk4sod9JrutMo2pCKhXKDz+oHm8Xy44mzV1
H7SUM3Q8QMT71w29oeyLgUZQE3BiIWQPqj9PLy/DujbcPlMSrZzw1/+tEPcpwMqUTF04a4fJ
Jf6MwOi3NQZccoJP3JwPcepFghWLYbfGO9lQLnzBvnwp1KD4ZsA1p4p8zomDmgdc+UEZVY9w
Yfi62ABfnF/gulB5126GWQ8ifxibn46gltuQL21LNLjFqq9QQXK8GMK007vFn2i1fRn4/6Ee
PFyjEX78wM0xHSSCQUin5tEfncv8g0xndqQyBVUB9ZQD74CiD0voLBETyXjf3SlKsaX/VoDw
p31GyDjYUxxixnlG/UgD7mmrmN6Hw/tma/LS/+29nY7Vtwr+gQUZH01JRj2s8XfM2Bjid8xS
1wbPL3s9ZgyszbokDETEPpRgfDV/8cJ4sbBM+C55kTGHX2x5zaTcIGOZmhRSDFv6L2Ph7uBb
T8XjEBGHnqf5KsiheZTiBKZ2HfVgtD04/1YYPcj/FXLt2gnDMPSXoCxdjQlUpySkielrydDT
oWtPO/TvK8mPxI5kRpAS8COypNx76XTAAZIiRtMQCaXy3ijEMh8LayOFaizt4ZbHWAvYkcZa
W2M74Fg6B0bIrUiGRDx5iGrKqGp1MpmMemtd2EmdcFY2eQqhurZLg3bONOgHb5yJkoatpP2E
AxV9Ym6TaLqKtlzO/WanksuarKfB9A+yT6ROi9Ty3Mi0UIlXHMytZwxiyoglWeES4HX+P3iG
dEnuDRe2kYu4yLKVOHbUVzbjcctrT6zV1m8dun/ZUl12i9TtxdlIx9pHCsZ0fvZN28uUxZmp
+ng6ZG1r+lxLMa770XR4Z8wQSE/Gcyvn9Jis9QyFGhsTjB4m1GQvOqgNjBnB/jIygNIpijke
4FvRZOF2sruBPHqRuxue6K2LUYQTFEtCEgLSprZt4aI8RHDxOoP8DmXavN5v5hO+tDULNktu
u3qtwjvZyjyW3crGP7ZEGM4Gpd5KHv736j4lvTzNWAg9y7+4TF9sbyoPTZIuigqClWXBkK80
WRObajrmwTTVdS/QYfGll0TJgwiT61Nl/Pz4/f76+ZPq38fmTUFYNfY6gHvD2NGM3Itl7nTV
V64co1QDCZ5wIGe+OGcuptAFWLnJx0UmpaGlFg4jdWTrrnGJxQaYR2sWxIvSmisfUhdMly18
zlgIobyBd1NGRJ/Zrl8UhwuTwIgbOovTdiSwGg1rjRAkl3PTKdYj7pCgzrkHQQ2OQMIRIlqY
iq9nSRMSsGOFrP4M+Y60g52sBSfvF7RuZa4XXee2mwPIkFsyg8McRrPu5C47WmQCLRpkdMMZ
9nw7DehvZSKtz1B3d/XE9/WdtHrFrTPSbC8ZQ/4ritMlu2fMtWjpjD/AQIUgFmjZYmAeAUqV
cJArSpZcvOgEAObG0ztPA12GfsEg0Z3E0f8DbXo1CCxZAAA=

--y0ulUmNC+osPPQO6--
