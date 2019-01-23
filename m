Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E83C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F6C21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548244933;
	bh=B6CP/kAM3zVC+ixAXucPC95pBO33kwPIitzhDE+zcIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NMj9T7vTyEdaGxe2oP3+QJEhBLOo3h5rPXKBSsa3i9KXiwbMebT/q4VFynaMfED0A
	 RL2+i6wQeQ6i7xiKPy9n9xrpy1QQO+uWr4Dsg74ybltvYxRNTpTBmz4B0HolvPzNLI
	 YROjZG118+QGowMHON+twy9SXX6Rxb2+zygrWUNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfAWMCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAWMCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:02:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B20420870;
        Wed, 23 Jan 2019 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548244930;
        bh=B6CP/kAM3zVC+ixAXucPC95pBO33kwPIitzhDE+zcIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/DhBMeUdEB/DjiDgkSfPd+D+EAUWqtqViqAf3uUfKWc00UOl39LROjXyiTkkOLtX
         U6uwGFVfjEqZtp/u2LunCfM3glPe98MBTkaevSRoIvsnKxdFQtIcqedY+PW/g/viEd
         msKYhF+7nlreCj9iJJI/Kop0oJhETKLxuZTs2J5k=
Date:   Wed, 23 Jan 2019 13:02:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wen.yang99@zte.com.cn
Cc:     arnd@arndb.de, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/rtc: fix object reference leaks in rtc_init
Message-ID: <20190123120208.GB31385@kroah.com>
References: <201901231822458570930@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901231822458570930@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 06:22:45PM +0800, wen.yang99@zte.com.cn wrote:
> The device node iterators perform an of_node_get on each iteration, so a
> jump out of the loop requires an of_node_put.
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we also should release that reference.
> This patch fixes those 2 issues.
> Fixes: 75081322c ("sparc32: Convert PC RTC probing to pure OF driver")
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>

Your "From:" line in your email does not match this :(

Please fix up your email client to have it match and resend.

thanks,

greg k-h
