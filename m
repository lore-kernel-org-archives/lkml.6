Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C369DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702E120857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qPM7XavF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y918wK+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702E120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeGZQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:50:19 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:57329 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730179AbeGZQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:50:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id B3C0F343;
        Thu, 26 Jul 2018 11:32:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 26 Jul 2018 11:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=fjUOqpIKgD586qq1NqyO2RsuRRXES4UAbazI4qNSpPM=; b=qPM7XavF
        qI9QLel3QXh0xwR2k2+6TsjBfzrqrJ1+lSZgT0kK6FOlE9KMW81oh71IZWpugJCt
        RYnHffAzVS2awo3I/LOY3c5tVlhHksmrCIzL7yImaOGlFTbbydxMMSHJUPtgE0Bj
        MNKudEnAochkOTKi/1L0OParywbuOBToK+rVGfRDeRIHOtmRiHSZGJjPxxrG0CEE
        5Dc+1/kj/eLibcV6EdAcfJF9NLhLZ/wU3XJrfcJ3cpVlXkOvxt//oGbNy1wVXPdX
        z0lLnFamlGaqeOtHeUxsMJnvuuc0j2DpyeIS4Gvce6oazVLdVTzqNZjBfvzpLdf7
        qq+dw/vJgPjOZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=fjUOqpIKgD586qq1NqyO2RsuRRXES
        4UAbazI4qNSpPM=; b=Y918wK+JuJkCssampHW8UTc2Gyv70CjD3JDnbTAey6XCg
        bY7+/r2Pca2UgJqLeHGRculgUT70wlarvsCYJB8R1wvNJFjSgjdcFCLXweYYFuo7
        oXcsHc0LJllEewtWnyKBtYADDg7BH9D8vWt0STj3T4PscYN9oUhtLKUMllflkZGY
        U+VbfbXzjzblSznuMb5cnMqweYB0UMHGO7QHH1muf+Dz0R3JuXHC0AhxdGhIbS9V
        fGQmgdRteiBXtO4Z7btPrZPY5soC8PkviDuRWER/SXIl9YlmoFvs7cV+xyKZ5JRA
        kO3u10cg35mBh5LEsgNg7h9IgDlguMbEMhxC/IKtQ==
X-ME-Proxy: <xmx:pulZW3rZVCKjoKtUoTuvX25MT1ryYT8EHpZJ4eaWo-mZNUllj7osDA>
    <xmx:pulZW7FWj1BTNbWkpJO48-UU_pHfrRYAZsP5_0trn9n_14IqPtL0Ug>
    <xmx:pulZW_ZA9ukfrnqzg5E5IBuRlnekAbbs5SCx4dOqI52PMxClkRc-Vw>
    <xmx:pulZWx3RJUDk02Jd9DCWZBXGwzQmuTRto1Ph6I85T2qwlwIEYVZ5cA>
    <xmx:pulZW4_byMUpAADpldCh4J5EoPnB3756-iGLs05sBU-j1YAagkKWfQ>
    <xmx:p-lZWxSVhYcV9ilJ1mprINxsg5PmAh2dOxRbDEs3ZWPuAYael9RsKdGxKkA>
X-ME-Sender: <xms:pulZW_O6JfSDJ-8dMW19pVP5gWF4cB_VlFMEldGjv98XKsLEPrlJuQ>
Received: from localhost (unknown [62.119.166.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12825E4AB8;
        Thu, 26 Jul 2018 11:32:51 -0400 (EDT)
Date:   Thu, 26 Jul 2018 17:32:43 +0200
From:   Greg KH <greg@kroah.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     stable@vger.kernel.org, jbrunet@baylibre.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
Message-ID: <20180726153243.GB8327@kroah.com>
References: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
 <5153040b-1f38-a17a-d78d-fec833c1c223@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5153040b-1f38-a17a-d78d-fec833c1c223@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 05:24:09PM +0200, Neil Armstrong wrote:
> Hi Stable Team,
> 
> On 13/06/2018 14:20, Neil Armstrong wrote:
> > On Amlogic Meson GXBB & GXL platforms, the SCPI Cortex-M4 Co-Processor
> > seems to be dependent on the FCLK_DIV2 to be operationnal.
> > 
> > The issue occured since v4.17-rc1 by freezing the kernel boot when
> > the 'schedutil' cpufreq governor was selected as default :
> > 
> >   [   12.071837] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
> >   domain-0 init dvfs: 4
> >   [   12.087757] hctosys: unable to open rtc device (rtc0)
> >   [   12.087907] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> >   [   12.102241] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > 
> > But when disabling the MMC driver, the boot finished but cpufreq failed to
> > change the CPU frequency :
> > 
> >   [   12.153045] cpufreq: __target_index: Failed to change cpu frequency: -5
> > 
> > A bisect between v4.16 and v4.16-rc1 gave the 05f814402d61 commit to be
> > the first bad commit.
> > This commit added support for the missing clock gates before the fixed PLL
> > fixed dividers (FCLK_DIVx) and the clock framework basically disabled
> > all the unused fixed dividers, thus disabled a critical clock path for
> > the SCPI Co-Processor.
> > 
> > This patch simply sets the FCLK_DIV2 gate as critical to ensure
> > nobody can disable it.
> > 
> > Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> 
> This patch hit linux master with commit id c987ac6f1f088663b6dad39281071aeb31d450a8
> 
> Could this be backported to the next 4.17 stable release ?

Now queued up, thanks,

greg k-h
