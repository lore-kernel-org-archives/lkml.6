Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9980FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477E7206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477E7206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeIZAhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:37:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeIZAhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:37:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63629106E;
        Tue, 25 Sep 2018 18:28:25 +0000 (UTC)
Date:   Tue, 25 Sep 2018 20:28:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/21] platform: goldfish: pipe: Fix allmodconfig build
Message-ID: <20180925182821.GA21572@kroah.com>
References: <20180914175122.21036-1-rkir@google.com>
 <20180914175122.21036-21-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914175122.21036-21-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:51:22AM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> The changes fixes these errors:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/platform/goldfish/goldfish_pipe_v1.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/platform/goldfish/goldfish_pipe_v2.o
> see include/linux/module.h for more information
> ERROR: "goldfish_pipe_device_v2_init" [drivers/platform/goldfish/goldfish_pipe.ko] undefined!
> ERROR: "goldfish_pipe_device_v1_init" [drivers/platform/goldfish/goldfish_pipe.ko] undefined!
> scripts/Makefile.modpost:92: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
> Makefile:1206: recipe for target 'modules' failed
> make: *** [modules] Error 2
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  drivers/platform/goldfish/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

You can not break the build on one patch, and then fix it up on a later
one.  Each patch has to be self-contained and able to be built with no
errors or warnings.  So please redo this in the proper place where the
error happened.

thanks,

greg k-h
