Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD57C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAB821871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545208091;
	bh=qFah7wcz7kGF5Z1DeuprXLW3kHTjzz6UatETtPnk9cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y8HfLEFneidqKQtIet96o+yH7yXIqAu2QT/DundqvfRVW/hitw0xx4yQcPSFVN8v/
	 QlhvYAmY7wy8SOjLNNsKnoJUvatWRbQvTBPeYUmGWs7/SNh2cZNq7HkYzIHUB1UsJs
	 FzstHxllw0ObI0W9/jJSrzEJRCWX+LjzVdE0j5fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeLSI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbeLSI2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:28:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8311A20675;
        Wed, 19 Dec 2018 08:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545208089;
        bh=qFah7wcz7kGF5Z1DeuprXLW3kHTjzz6UatETtPnk9cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mSlG/mdJwU0AA/5SPxhI3BdAMbU172vIuNbPg1Fn6XvlFZYkrUG6ZQuex8sfDuik4
         yCcg4HlZ7idN2GnVS/woYFHLTlBCWYqooDGR/bitNm5ipe0Jpbc51dlhYfhxQwbg0+
         oxxfFkaydK4BVWPN1vDlr7UTY/RIxhFagtTsh4YQ=
Date:   Wed, 19 Dec 2018 09:28:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/3]  misc/pvpanic: return 0 for empty body register
 function
Message-ID: <20181219082806.GA31421@kroah.com>
References: <1545206692-32183-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545206692-32183-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 04:04:50PM +0800, Peng Hao wrote:
> Return 0 for empty body register function normally.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
> v4 --> v5 : handle all typo "drvier/driver" in funtion name. 
> 
> v3 --> v4 : use pcim* function instead of pci* function.
>             handle typo "drvier/driver" in funtion name. 
> 
> v2 --> v3 : handle a uninitialized variable in some path.
> 
> v2 --> v1 : arch=sh don't support pci, adjust  CONFIG_PCI macro. 
> 
> v1 : QEMU community requires additional PCI devices to simulate PVPANIC devices
> so that some architectures can not occupy precious less than 4G of memory 
> space.

Have you also fixed the kbuild issues that keep getting reported?

thanks,

greg k-h
