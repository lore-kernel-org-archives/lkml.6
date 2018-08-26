Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721FC208DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721FC208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeHZUrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 16:47:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeHZUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 16:47:40 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2523F9F0;
        Sun, 26 Aug 2018 17:04:33 +0000 (UTC)
Date:   Sun, 26 Aug 2018 19:04:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     QIANJUN <hangdianqj@163.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: spin_lock instead of spin_lock_irqsave in imx uart interuput
Message-ID: <20180826170430.GA12776@kroah.com>
References: <20180826150042.GA7972@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826150042.GA7972@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 08:00:42AM -0700, QIANJUN wrote:
> spin_lock instead of spin_lock_irqsave in imx uart interuput

What does that mean?

> >From 6580790d7be51a78d1376b90df49b04019a1f944 Mon Sep 17 00:00:00 2001
> From: jun qian <hangdianqj@163.com>
> Date: Sun, 26 Aug 2018 06:58:35 -0700
> Subject: [PATCH] before the programe into the uart interuput's handler, the
>  system has already disabled the local cpu interuput. so the spin_lock
>  interface is More suitable for here.

Why is this here?  The changelog text belongs in the changelog, not in
the subject line :(

can you fix this all up and resend?

thanks,

greg k-h
