Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0174AC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9301214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548056788;
	bh=l63nBS2gjJ48hqmkwSApX9yNbn29J8WNxsdrZ56boRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fpKbDU2U08NRIog0Wr0WX9UjbzL9ZYr7IxvYayDooLNXnJZNTo8IIX5qhqVf7OPxI
	 wf7EHe1mzii+yJQl/JhwJNzbgH1M3L4lgWueMarIT101zIIYNick118IhnUIyPhIl6
	 6djjxBc4r2xeFS1oL+K+Tj6XQm1NqEMGJbKVdAMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfAUHq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:46:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfAUHq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:46:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16A72084A;
        Mon, 21 Jan 2019 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548056786;
        bh=l63nBS2gjJ48hqmkwSApX9yNbn29J8WNxsdrZ56boRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRBCr4Gu2TIgZIC96Zup1x4KprX1vE12Rn/8UoPKmtZU9SycBoyOXg//beZyxhMBs
         zJSTf0LnZ6yT0O8QhVo/D0feU+Xkcx+9BygONrC8KjsJR58Yx6nLO/Rw796a3htZ8v
         svPkjAnKRY+LsUmLBCj3EKCJSnFpjAyTmQ7KabGk=
Date:   Mon, 21 Jan 2019 08:46:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, xiaobo.xie@nxp.com,
        jerry.huang@nxp.com, ran.wang_1@nxp.com,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] usb: host: Stops USB controller init if PLL fails
 to lock
Message-ID: <20190121074623.GA4651@kroah.com>
References: <20190121031304.31161-1-yinbo.zhu@nxp.com>
 <20190121031304.31161-3-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121031304.31161-3-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:13:01AM +0800, Yinbo Zhu wrote:
> From: yinbo.zhu <yinbo.zhu@nxp.com>

This should read:
	From: Yinbo Zhu <yinbo.zhu@nxp.com>

right?

> USB erratum-A006918 workaround tries to start internal PHY inside
> uboot (when PLL fails to lock). However, if the workaround also
> fails, then USB initialization is also stopped inside Linux.
> Erratum-A006918 workaround failure creates "fsl,erratum_a006918"
> node in device-tree. Presence of this node in device-tree is
> used to stop USB controller initialization in Linux
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

Same here, don't use your email alias as your signed-off-by name.

thanks,

greg k-h
