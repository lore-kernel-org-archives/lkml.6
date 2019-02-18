Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC4DC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA23A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfBRPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:39:03 -0500
Received: from netrider.rowland.org ([192.131.102.5]:37373 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732238AbfBRPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:39:03 -0500
Received: (qmail 24570 invoked by uid 500); 18 Feb 2019 10:39:02 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Feb 2019 10:39:02 -0500
Date:   Mon, 18 Feb 2019 10:39:02 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, <stable@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 026/143] usb: hub: delay hub autosuspend if USB3 port
 is still link training
In-Reply-To: <20190218133530.107708512@linuxfoundation.org>
Message-ID: <Pine.LNX.4.44L0.1902181036520.24068-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019, Greg Kroah-Hartman wrote:

> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> [ Upstream commit e86108940e541febf35813402ff29fa6f4a9ac0b ]
> 
> When initializing a hub we want to give a USB3 port in link training
> the same debounce delay time before autosuspening the hub as already
> trained, connected enabled ports.
> 
> USB3 ports won't reach the enabled state with "current connect status" and
> "connect status change" bits set until the USB3 link training finishes.
> 
> Catching the port in link training (polling) and adding the debounce delay
> prevents unnecessary failed attempts to autosuspend the hub.
> 
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

We should be careful with this commit; it has caused problems for some
people.  Mathias has been working to fix them, but this commit
shouldn't go into -stable until the fixes are also ready to go.

Alan Stern

