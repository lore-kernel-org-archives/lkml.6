Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5FDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A9221529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A9221529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbeITRPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:15:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbeITRPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:15:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E8FBF6F;
        Thu, 20 Sep 2018 11:32:28 +0000 (UTC)
Date:   Thu, 20 Sep 2018 13:32:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] serial: uartps: Change uart ID port allocation
Message-ID: <20180920113225.GA19956@kroah.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537282676.git.michal.simek@xilinx.com>
 <dcf1c72203baf2629492dce765ce2d555316be0c.1537282676.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf1c72203baf2629492dce765ce2d555316be0c.1537282676.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 04:57:59PM +0200, Michal Simek wrote:
> For IPs which have alias algorightm all the time using that alias and
> minor number. It means serial20 alias ends up as ttyPS20.
> 
> If alias is not setup for probed IP instance the first unused position is
> used but that needs to be checked if it is really empty because another
> instance doesn't need to be probed at that time. of_alias_get_alias_list()
> fills alias bitmap which exactly shows which ID is free.
> If alias pointing to different not compatible IP, it is free to use.
> 
> cdns_get_id() call is placed below structure allocation to simplify
> error path.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Add handle of return value from of_alias_get_alias_list
> 
> Needs to be applied on the top of
> https://lkml.org/lkml/2018/9/3/404
> https://lkml.org/lkml/2018/9/3/400 (minor that's why just in case)
> 
> Greg: Please apply it with
> "of: base: Introduce of_alias_get_alias_list() to check alias IDs
> Rob is ok with that.

I don't have that patch, can you resend the whole series?

thanks,

greg k-h
