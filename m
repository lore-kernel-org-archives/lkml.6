Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD4C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF6F20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF6F20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJCFP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:15:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:15:59 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4A964D94;
        Tue,  2 Oct 2018 22:30:22 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:30:21 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH 01/15] platform: goldfish: pipe: Remove the
 goldfish_interrupt_tasklet global variable
Message-ID: <20181002223021.GA30567@kroah.com>
References: <20181002221903.19476-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:18:49PM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> This is a series of patches to remove mutable global variables
> to introduce another version of the pipe driver for the older
> host interface. I don't want to have two driver states where only
> one is used.

I don't see a "global" variable here, what are you referring to.

This one:

> -static DECLARE_TASKLET(goldfish_interrupt_tasklet, goldfish_interrupt_task, 0);

?

That looks static to this file to me.

what am I missing here?

greg k-h
