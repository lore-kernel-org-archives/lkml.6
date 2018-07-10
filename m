Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623B3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190542089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="thtA8IIG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OL49zCNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190542089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933647AbeGJN7S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:59:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55643 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933410AbeGJN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:59:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8DE1921B2A;
        Tue, 10 Jul 2018 09:59:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Jul 2018 09:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=WOLzH6v2B+3MHnvXH9/CxhAEOtk42tJJvKDMhQ6YZs0=; b=thtA8IIG
        uJJ5Ov2IYhp73F20ME/kEDLrac9SpP/Oa8/VshaOBmdULdT0pvrMUXW/x3OsfF5z
        Hos7uLQOW8Z8fCA6A7WGwxKaOBS3IrFMG/0YgTkpdlybpaDfNioeAz3dyBPYUks0
        hy81llzc1A1aMMcnS1fLuMosThI7zsNhvjtwpbk0hEROMjh2qJzCX6HGJZvuvhkk
        v45rhmQIieYzlauqgAtrVbZzA47C2Fs2UCkQGZ6CLeUvSwq+Jvzz52BSGdGRllhw
        H1o7i6HO+Ga4M0G4CAFXf929MMivkRP7R79nLmT9xsESrA3hFo7HpsXF89OKEidQ
        yn041oA6gr1AUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=WOLzH6v2B+3MHnvXH9/CxhAEOtk42
        tJJvKDMhQ6YZs0=; b=OL49zCNfqjzZ1Ka84fwrPKdVzWHE6XtkzGOPW2L0SBHuk
        eXpxtBLAvYcqRBs6KxfAfpEVSKOo1pWmxbSRoYf7oInAV5Rh31TToiKQc0OWiuzW
        AWYor5upEoUwgQ95NvEJ+P/fOnDIRVx6Yj7i4fuYtiVx6T/1FvkFXEV6QLFKfHDS
        gbLOxY17PW9y6skxv4mWsxqlsXm42IFjlXO8Kf5pQVlxp/5bn2tsc4uPuaPUNChR
        MgW9LZKqzhaP14ZxSfXUjGelDI2ACh2PCD8kJicxHbxHJbR5i9tvahCK+xBgO4OA
        hUutlmZGYsLgWb0CTELMEdm1Ok8at6oTb4Gre2trA==
X-ME-Proxy: <xmx:sbtEW66hJ3BJye_GWszDRrigQE4x65vytEgzckzcPTjhI_vhdoQNHQ>
    <xmx:sbtEWyLjcVYGO86Jm3HAjSavkScD3WC0dvcP7PlAKZjGBt_evshnBw>
    <xmx:sbtEW2nCdeOA5y-gcJOCv_PrqACFdta-WSPL_IME4Sn_3c_HsbnzeA>
    <xmx:sbtEW59nePcJCdEZAx-JQSeZKBnksx1iCXmDD8SDR8fNITI0bIXiTQ>
    <xmx:sbtEW94URrHBcUIt5YjexM7usK_ngnLMCEwMSQzTxlAexmhNOYgXnw>
    <xmx:srtEW7PcsKADd5SgabxtMadM39WjDS1f175KchamK3pPl_UkDGqg9w>
X-ME-Sender: <xms:sbtEWyO5II_rQeeBl2O0AupLidynT-Y-DpM4MT5brRgb-6fIiXNaGA>
Received: from localhost (lfbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id 92AC7E45C9;
        Tue, 10 Jul 2018 09:59:13 -0400 (EDT)
Date:   Tue, 10 Jul 2018 15:59:12 +0200
From:   Greg KH <greg@kroah.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>,
        "4 . 6+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4.9] PM / OPP: Update voltage in case freq == old_freq
Message-ID: <20180710135912.GI1123@kroah.com>
References: <3717ee50c1f1f48cffcb1a2e41c04e28881776d1.1530521347.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3717ee50c1f1f48cffcb1a2e41c04e28881776d1.1530521347.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:19:47PM +0530, Viresh Kumar wrote:
> From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
> 
> Original commit c5c2a97b3ac7 ("PM / OPP: Update voltage in case freq ==
> old_freq").
> 
> This commit fixes a rare but possible case when the clk rate is updated
> without update of the regulator voltage.
> 
> At boot up, CPUfreq checks if the system is running at the right freq. This
> is a sanity check in case a bootloader set clk rate that is outside of freq
> table present with cpufreq core. In such cases system can be unstable so
> better to change it to a freq that is preset in freq-table.
> 
> The CPUfreq takes next freq that is >= policy->cur and this is our
> target_freq that needs to be set now.
> 
> dev_pm_opp_set_rate(dev, target_freq) checks the target_freq and the
> old_freq (a current rate). If these are equal it returns early. If not,
> it searches for OPP (old_opp) that fits best to old_freq (not listed in
> the table) and updates old_freq (!).
> 
> Here, we can end up with old_freq = old_opp.rate = target_freq, which
> is not handled in _generic_set_opp_regulator(). It's supposed to update
> voltage only when freq > old_freq  || freq > old_freq.
> 
> if (freq > old_freq) {
> 		ret = _set_opp_voltage(dev, reg, new_supply);
> [...]
> if (freq < old_freq) {
> 		ret = _set_opp_voltage(dev, reg, new_supply);
> 		if (ret)
> 
> It results in, no voltage update while clk rate is updated.
> 
> Example:
> freq-table = {
> 	1000MHz   1.15V
> 	 666MHZ   1.10V
> 	 333MHz   1.05V
> }
> boot-up-freq        = 800MHz   # not listed in freq-table
> freq = target_freq  = 1GHz
> old_freq            = 800Mhz
> old_opp = _find_freq_ceil(opp_table, &old_freq);  #(old_freq is modified!)
> old_freq            = 1GHz
> 
> Fixes: 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()")
> Cc: 4.6+ <stable@vger.kernel.org> # v4.6+
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Sending it for stable kernels from 4.6 until 4.9.

Always give me a hint as to what the original commit is, otherwise I
have to go dig for it :(

greg k-h
