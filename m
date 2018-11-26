Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8D020855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgI66LSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8D020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeK0Gsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:48:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeK0Gsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:48:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6212C20664;
        Mon, 26 Nov 2018 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543262013;
        bh=390FLo16MMai6qiX6S53UudkZs89w8NRd9mkGsht81s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WgI66LSuPkHe4xBLxhnwkAsK7kV3SWXhdwa1+0eIH+bpb4u01+MD7y2G/YoNo3bVE
         6o96WUroqMhiKp2HVwOrpG5W4MeH5lKBpd3XH/8wt1M6nF0PFFtmY3gzWMiRjsmj0Z
         lDlm+uiB384Q1hBs2d1pDk/QhloUNmzKsSVX2hAE=
Date:   Mon, 26 Nov 2018 20:53:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  misc/pvpanic: resolve compile errors for arch=um
Message-ID: <20181126195331.GA1720@kroah.com>
References: <1542366806-81521-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542366806-81521-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 07:13:26PM +0800, Peng Hao wrote:
> Resolve compile error for arch=um
> pvpanic.c:(.text+0xb6): undefined reference to `devm_ioremap_resource'
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What commit is this fixing?  What broke and when did it break?

thanks,

greg k-h
