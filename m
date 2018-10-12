Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAD9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF8E213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRcHMNZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF8E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeJLRvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbeJLRvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:51:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACFB2087D;
        Fri, 12 Oct 2018 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539339606;
        bh=HfL1CFc0uCS65pyYo/o3hBj42eoV+5Q/ddaFpl+KJB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRcHMNZVagiI8fm3EkCHEyhtvlMMTiC1vuVWNoKu8gaOs65SgwwZznw2cxrpaZaDd
         SQazSxFIs3rpU8UGw0+/Ec4KH7sGxDku80RMprmPmMdGz2xryQJOWxTBv9RMNstQk2
         zGyUxWG6AkM0H57v/3wEwbVHVGXWgYxQbJuUFz5s=
Date:   Fri, 12 Oct 2018 12:20:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, bjorn@mork.no,
        steve.glendinning@shawell.net
Subject: Re: [PATCH 4/7] net: qmi_wwan: add usbnet -> priv function
Message-ID: <20181012102003.GB27607@kroah.com>
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
 <20181012091642.21294-5-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012091642.21294-5-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:16:39AM +0100, Ben Dooks wrote:
> There are a number of places in the qmi_wwan driver where it gets the
> private-data from the usbnet passed in. It would be sensible to have
> one inline function to convert it and change all points in the driver
> to use that.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

