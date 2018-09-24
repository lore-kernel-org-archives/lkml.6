Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965A6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8552145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8552145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeIXNFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:05:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeIXNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:05:35 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4AC5E8E3;
        Mon, 24 Sep 2018 07:04:56 +0000 (UTC)
Date:   Mon, 24 Sep 2018 09:04:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Silesh C V <svellattu@mvista.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver core: add bus_find_device_by_fwnode
Message-ID: <20180924070453.GA7105@kroah.com>
References: <1537763755-28871-1-git-send-email-svellattu@mvista.com>
 <20180924051832.GB1974@kroah.com>
 <CALabi0Ho9w_6PcSe6D8PmGgLfw9sYWhBS-z=KebxCPqkaM8ibw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALabi0Ho9w_6PcSe6D8PmGgLfw9sYWhBS-z=KebxCPqkaM8ibw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:06:13PM +0530, Silesh C V wrote:
> Hello Greg,
> On Mon, Sep 24, 2018 at 10:48 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Sep 24, 2018 at 10:05:55AM +0530, Silesh C V wrote:
> > > Some drivers need to find the device on a bus having a specific firmware
> > > node. Currently, such drivers have their own implementations to do this.
> > > Provide a helper similar to bus_find_device_by_name so that each driver
> > > does not have to reinvent this.
> >
> > Is there a second patch that uses this function?  We don't add api calls
> > that are not used.
> 
> OK. If I change, say, of_find_i2c_device_by_node,
> of_find_i2c_adapter_by_node, of_phy_find_device and
> of_find_spi_device_by_node to use this API, will that be good enough?
> If that is OK, I will send this as a series in v2.

I have no idea.  Why would you want to create a new api call with no
users?  Let's see the patch series before being able to properly judge
it...

thanks,

greg k-h
