Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2D0C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8412F2174C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8412F2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbeGGPxM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:53:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbeGGPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:53:11 -0400
Received: from localhost (unknown [37.168.185.56])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13D08DB6;
        Sat,  7 Jul 2018 15:53:09 +0000 (UTC)
Date:   Sat, 7 Jul 2018 17:53:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 treewide] headers: separate linux/mod_devicetable.h
 from linux/platform_device.h
Message-ID: <20180707155306.GA23729@kroah.com>
References: <7baed3cc-cb9c-66d2-b179-517877324407@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7baed3cc-cb9c-66d2-b179-517877324407@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:47:28PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> At over 4000 #includes, <linux/platform_device.h> is the 9th most
> #included header file in the Linux kernel.  It does not need
> <linux/mod_devicetable.h>, so drop that header and explicitly add
> <linux/mod_devicetable.h> to source files that need it.
> 
>    4146 #include <linux/platform_device.h>
> 
> After this patch, there are 225 files that use <linux/mod_devicetable.h>,
> for a reduction of around 3900 times that <linux/mod_devicetable.h>
> does not have to be read & parsed.
> 
>     225 #include <linux/mod_devicetable.h>
> 
> This patch was build-tested on 20 different arch-es.
> 
> It also makes these drivers SubmitChecklist#1 compliant.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kbuild test robot <lkp@intel.com> # drivers/media/platform/vimc/
> Reported-by: kbuild test robot <lkp@intel.com> # drivers/pinctrl/pinctrl-u300.c
> ---
> v3: add fix for drivers/pinctrl/pinctrl-u300.c
> v2: add fixes for drivers/media/platform/vimc/

I've queued this up now, let's see what else breaks!  :)

greg k-h
