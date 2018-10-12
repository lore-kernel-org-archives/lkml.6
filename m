Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4296A2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJAtOpRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4296A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJLRwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbeJLRwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:52:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DF32098A;
        Fri, 12 Oct 2018 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539339636;
        bh=7Q1/IRMCHWMZGkX8XtmDB37c0l1JvDs2FptUxH4IUog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJAtOpRGJOiXxU83nCLDHgiLiJaNhmTf8c/vmmtpnbjIB9nV7/C2D/3/EeZ2PaHrs
         EpfQOcYFxHFQMerzL/ebTVZogY2rk0B7c9qfAMY6yti/Kjhha6qKfFzD6XRDzbwopj
         /loxAr5YmSg/oQcXPk2WtI8GQW8fN6HHtyWxHR3s=
Date:   Fri, 12 Oct 2018 12:20:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, bjorn@mork.no,
        steve.glendinning@shawell.net
Subject: Re: [PATCH 7/7] net: usb: sr9800: add usbnet -> priv function
Message-ID: <20181012102033.GG27607@kroah.com>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
 <20181012091642.21294-8-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012091642.21294-8-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:16:42AM +0100, Ben Dooks wrote:
> There are a number of places in the sr8900 driver where it gets the
> private-data from the usbnet passed in. It would be sensible to have
> one inline function to convert it and change all points in the driver
> to use that.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
