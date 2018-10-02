Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41338C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB762082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB762082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJCASq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:18:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeJCASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:18:45 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 71B54CAD;
        Tue,  2 Oct 2018 17:34:16 +0000 (UTC)
Date:   Tue, 2 Oct 2018 10:34:14 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tobias Herzog <t-herzog@gmx.de>
Cc:     oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cdc-acm: correct counting of UART states in serial
 state notification
Message-ID: <20181002173414.GA7850@kroah.com>
References: <1537647071-2691-1-git-send-email-t-herzog@gmx.de>
 <1537647071-2691-2-git-send-email-t-herzog@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537647071-2691-2-git-send-email-t-herzog@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 10:11:11PM +0200, Tobias Herzog wrote:
> The usb standard ("Universal Serial Bus Class Definitions for Communication
> Devices") distiguishes between "consistent signals" (DSR, DCD), and
> "irregular signals" (break, ring, parity error, framing error, overrun).
> The bits of "irregular signals" are set, if this error/event occurred on
> the device side and are immeadeatly unset, if the serial state notification
> was sent.
> Like other drivers of real serial ports do, just the occurence of those
> events should be counted in serial_icounter_struct (but no 1->0
> transitions).
> 
> Signed-off-by: Tobias Herzog <t-herzog@gmx.de>
> ---
>  drivers/usb/class/cdc-acm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Oliver, any thoughts about this patch series?

thanks,

greg k-h
