Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE47C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57A72083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhY2iKTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57A72083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJYVB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeJYVB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:01:29 -0400
Received: from localhost (unknown [178.225.94.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8AA920831;
        Thu, 25 Oct 2018 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540470536;
        bh=eVWayPB5clUq5GpfyMBdL0CPpBgYLjBxSw5y1uatdv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhY2iKTn1AUDdFd4kEq2QwQ9zOVvijdLAS1pi5vkDHPmm6JUGgR9uU3CcDf5xzH6M
         0ejrFPugRD9sou2L9n/sZNyyFjTpD7gqNATcBtHxZn9InIc2eEajjopQAy+OJmes/H
         X6CaiJ7v1ICWVvI8NrAm4WaJhlQAvyRJ3y4vrH0A=
Date:   Thu, 25 Oct 2018 13:28:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bin Liu <b-liu@ti.com>,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dominik Bozek <dominikx.bozek@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: USB-C device hotplug issue
Message-ID: <20181025122851.GA19541@kroah.com>
References: <7d444d00-5144-452d-4229-e77d38a991f5@secunet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d444d00-5144-452d-4229-e77d38a991f5@secunet.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 02:20:50PM +0200, Dennis Wassenberg wrote:
> The code change for Kernel 4.14 look as follows:

4.14 is a year old now, can you try 4.19 to see if it works better?
Lots of good xhci fixes and features have been added since then.

thanks,

greg k-h
