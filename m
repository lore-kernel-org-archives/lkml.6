Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D332C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FD220652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRd+94Mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FD220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeJOVqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeJOVqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:46:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D90120652;
        Mon, 15 Oct 2018 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539612080;
        bh=b68ghKJ0HmCV0lPxHK5DXXgD18fR/iBQ+X1bapRSZ6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRd+94MvKeVlGSFlxnuo8PfPVYJPY00GsF/7NAHV23TqGXXuLyo7oPGHtnrN8gHKN
         PqzimOy3KJUF/q5m/8rX6avueR2+chAgFvKVX8bQsexiNzjJpT4by+duFDTegbvDk+
         zXSv+pRZuk/F4xJ4ByTFptRRFqhl6aAKAe87Bkp8=
Date:   Mon, 15 Oct 2018 16:01:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/1] serial: imx - Add dma buffer confugration via
 sysfs
Message-ID: <20181015140118.GA16234@kroah.com>
References: <1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:25:03AM +0200, Fabien Lahoudere wrote:
> In order to optimize serial communication on imx53 and imx6, we may
> need to tweak DMA period and buffer length per period.

Why can you not just automatically determine this information?  What is
userspace going to know that the kernel can not just learn now?

Having tunables is nice, but it is even better to not need them at all.

thanks,

greg k-h
