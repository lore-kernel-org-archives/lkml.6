Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CACC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFD52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFD52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeIKNFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:05:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeIKNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:05:03 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74B16BE0;
        Tue, 11 Sep 2018 08:06:55 +0000 (UTC)
Date:   Tue, 11 Sep 2018 10:06:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: fix compile warning
Message-ID: <20180911080651.GB8316@kroah.com>
References: <20180911075413.GA20870@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911075413.GA20870@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 02:54:13AM -0500, Gustavo A. R. Silva wrote:
> Fix the following compile warning:
> 
> warning: unused variable ‘flags’ [-Wunused-variable]
>   unsigned long flags;
> 
> Fixes: ed194d136769 ("usb: core: remove local_irq_save() around ->complete() handler")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/usb/core/hcd.c | 1 -
>  1 file changed, 1 deletion(-)

I can't believe I missed this :(

Someone else sent this right before you, I'll add your s-o-b to that
patch as well.

thanks,

greg k-h
