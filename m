Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BFAC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2240208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TmQRIKr1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7qZ6ZSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2240208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeKHUwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:52:34 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45389 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726938AbeKHUwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:52:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A678520782;
        Thu,  8 Nov 2018 06:17:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Nov 2018 06:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=iXRzE7Z1JIyAHOt/KvY1XaxanNZ
        CnBvJEWJx98dmpr8=; b=TmQRIKr1L8dlbbs4RFDaPPV+EcH2bLMiKSdcJpuZA+1
        BX143w5oiZ5Frn3t+j6bSfa+hUgBBFhuTinxaq5awt5fkb9quvhWATm2K9kEerUr
        Lc/ph7vZbDsyyKEalmXu/eNekwQDmgxwduwvmitP3XjQmCbkUultEcBq4mQegiBa
        lqaG7alz2R5R35fOa1M1qp34vLT2RJJBpxXmlxWJwYfZRrLI5Pm2Bxn1sRuE2GhK
        /TILzPjYtdUD6E2orjovkkCzfORStl7s+h9qX/ea4SXw9cuO+3Eoi0r412tiUQB2
        MUokFwMs3rn3OMlNU+N3AFSNJnYkrR6G6ffx+kXv8lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iXRzE7
        Z1JIyAHOt/KvY1XaxanNZCnBvJEWJx98dmpr8=; b=p7qZ6ZSK4d0uWPCFkhQ/me
        S7LyzyrGjaho1/y58b5UvOL00J8AXajlkmvWfyn+qcjszbhQ15ZpRimf01R003F5
        A1O1fTmhDXNVKSIc4tdH7Rtc8m9mf5ZCN1mrBMqcPqXVpwc/tqqeRqTNvXRXOrNM
        Dg4FntI7SmOaJX/GqBQaNwUUPJD5P5Xvn+YLLsawI+RxpTlXVALXADBfkj83R8uj
        UAi7MA8YVSBmYmc9hDjlv89R3/GPfQ4+hpjL5f3fixumE60Z3KYnlPZVaSZ41N4K
        6kuvaYYf8Z3lnuzo0MCibyACsW/lG4fzGbhpgTcMDXCPTD+xpQ3b2HPmQ/5xv0VA
        ==
X-ME-Sender: <xms:TBvkW0wX5cTnf2-2rLEgDZtpYs29jqPkAxnnSF1R17YNQH5ox4WJgg>
X-ME-Proxy: <xmx:TBvkW6c-ocywe7_yW69vRO8cf6wf9X3NqGZ7NAFZr4zZuszRTbRkYw>
    <xmx:TBvkW-_HEetlIoNYktS_wJw7qbxw464ldzs6CEoOvUqeyPUfzwEK9A>
    <xmx:TBvkW6aqKa8yWE-HZohCarMnSjW4CQMmed-2gLlwJAxQhYhXVJ1RQQ>
    <xmx:TBvkW-slX-Xh3YFntZTT7gEmxI_bi_VWRUvWVJPbxvYrBdm_4-PNqA>
    <xmx:TBvkW3aOYrLoXihsOABDEBb2TT3Rqgi65wM_bIPRqXvapFLZL6xYBQ>
    <xmx:TRvkW5GVenjhqIZuNcc4P44BI5xzU5hC-YF9hllTaMa4dTj75ayI2A>
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        by mail.messagingengine.com (Postfix) with ESMTPA id 64AF2103F6;
        Thu,  8 Nov 2018 06:17:32 -0500 (EST)
Date:   Thu, 8 Nov 2018 03:17:31 -0800
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ioannis Valasakis <code@wizofe.uk>
Subject: Re: linux-next: build warning after merge of the staging tree
Message-ID: <20181108111731.GA32115@kroah.com>
References: <20181108133307.5cca74cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108133307.5cca74cb@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:33:07PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the staging tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> In file included from include/linux/printk.h:336,
>                  from include/linux/kernel.h:14,
>                  from include/linux/clk.h:16,
>                  from drivers/staging/media/tegra-vde/tegra-vde.c:12:
> drivers/staging/media/tegra-vde/tegra-vde.c: In function 'tegra_vde_setup_iram_tables':
> drivers/staging/media/tegra-vde/tegra-vde.c:265:5: warning: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int' [-Wformat=]
>      "\tFrame %d: frame_num = %d B_frame = %d\n",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>                                        ^~~
> include/linux/device.h:1463:23: note: in expansion of macro 'dev_fmt'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                        ^~~~~~~
> drivers/staging/media/tegra-vde/tegra-vde.c:264:4: note: in expansion of macro 'dev_dbg'
>     dev_dbg(vde->miscdev.parent,
>     ^~~~~~~
> 
> Introduced by commit
> 
>   42e764d05712 ("staging: tegravde: replace bit assignment with macro")

I saw this warning, and ignored it, my fault.  Colin just sent a patch
for this so I'll queue that up now, thanks.

greg k-h
