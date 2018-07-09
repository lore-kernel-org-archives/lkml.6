Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C5BC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E160C208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E160C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeGIHBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:01:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeGIHBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:01:49 -0400
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1DB0CEB;
        Mon,  9 Jul 2018 07:01:48 +0000 (UTC)
Date:   Mon, 9 Jul 2018 09:01:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Janani Sankara Babu <jananis37@gmail.com>
Cc:     keescook@chromium.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging:fwserial Move LINUX_VENDOR_ID to firewire.h
Message-ID: <20180709070145.GA13285@kroah.com>
References: <1531151550-4918-1-git-send-email-jananis37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531151550-4918-1-git-send-email-jananis37@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:52:30AM -0400, Janani Sankara Babu wrote:
> This driver uses the same unregistered vendor id that the
> firewire core does (0xd00d1e). Hence it is exposed as a
> define in firewire.h.
> 
> Signed-off-by:Janani Sankara Babu <jananis37@gmail.com>
> ---
>  drivers/staging/fwserial/fwserial.c | 1 -
>  include/linux/firewire.h            | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)


staging drivers are supposed to be self-contained.  Please work to get
the fwserial driver out of the staging directory before adding stuff
like this to a .h file that everyone includes.

thanks,

greg k-h
