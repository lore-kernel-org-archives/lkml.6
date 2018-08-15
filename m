Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992A3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917A320BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqwu0Knt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917A320BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeHPBb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:31:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32908 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbeHPB21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eCmegPHgSq1zArLsmVg1mJflFIPzB0hpJYjBKd59agc=; b=vqwu0KnttvDY5SBn68XIec8CKK
        d0m2jzkhHufIjF/G6GIB6F4Mb3zDl5nU/EpwEUVr3ibtJiknKNHzG7FonxcLrN3eHzpbxj1pyX7R1
        dq0Lar8g5IifvVXsK1e5ojgML5WW6DacSr1M7zEfsgsHC+mKUrQr4P26nGtfSmbUWHWIdUlmH1b2k
        KgxGshEEIKNCvOJo1Sh6r9UmxBh7PRVoh5/brhnNiJj24SuKXto4mZnNbL/AwqGSTwRu9Q3D0eyf4
        0pt4nUUJetLgQGUAIiRpz+CLXpMl4N4WdX1yfUOCDhBeEgnfR4sq2wRF7h/qQOlBRcx7fnJGdakmO
        w2tYBUeg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fq4Mn-0005G6-J1; Wed, 15 Aug 2018 22:34:13 +0000
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
To:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20180815220958.3606-1-atull@kernel.org>
 <20180815220958.3606-2-atull@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9043a69f-47d8-0ffe-ca15-77c9c73c085f@infradead.org>
Date:   Wed, 15 Aug 2018 15:34:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815220958.3606-2-atull@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 03:09 PM, Alan Tull wrote:
> From: Alan Tull <atull@opensource.altera.com>
> 
> Implement DebugFS for the FPGA Manager Framework for
> debugging and developmental use.
> 
> Enabled by CONFIG_FPGA_MGR_DEBUG_FS

Hi Alan,

for your v2 changes:

> Each FPGA gets its own directory such as
>  <debugfs>/fpga_manager/fpga0 and three files:

s/three/four/

> 
>  * [RW] flags          = flags as defined in fpga-mgr.h
>  * [RW] firmware_name  = write/read back name of FPGA image
>                          firmware file to program
>  * [WO] image          = write-only file for directly writing
>                          fpga image w/o firmware layer
>  * [RW] config_complete_timeout_us = maximum for the FPGA to
>                          go to the operating state after
> 			 programming
> 
> The debugfs is implemented in a separate fpga_mgr_debugfs.c

      debugfs interface is

> file, but the FPGA manager core is still built as one
> module.  Note the name change from fpga-mgr.ko to fpga_mgr.ko.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/Kconfig            |   7 ++
>  drivers/fpga/Makefile           |   4 +-
>  drivers/fpga/fpga-mgr-debugfs.c | 221 ++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/fpga-mgr-debugfs.h |  22 ++++
>  drivers/fpga/fpga-mgr.c         |   8 ++
>  include/linux/fpga/fpga-mgr.h   |   3 +
>  6 files changed, 264 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.c
>  create mode 100644 drivers/fpga/fpga-mgr-debugfs.h
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 1ebcef4..600924d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -9,6 +9,13 @@ menuconfig FPGA
>  	  kernel.  The FPGA framework adds a FPGA manager class and FPGA
>  	  manager drivers.
>  
> +config FPGA_MGR_DEBUG_FS
> +       bool "FPGA Manager DebugFS"
> +       depends on FPGA && DEBUG_FS
> +       help
> +         Say Y here if you want to expose a DebugFS interface for the
> +	 FPGA Manager Framework.

Use tab indentation for bool, depends, and help lines.

Use tab +2 spaces for help text.

> +
>  if FPGA
>  
>  config FPGA_MGR_SOCFPGA

thanks,
-- 
~Randy
