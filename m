Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E62DC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD8520861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD8520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeIMRpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:45:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeIMRpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:45:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2AC3ACB7;
        Thu, 13 Sep 2018 12:35:55 +0000 (UTC)
Date:   Thu, 13 Sep 2018 14:35:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        stable@vger.kernel.org
Subject: Re: [char-misc v4.4.y 2/2] mei: bus: type promotion bug in
 mei_nfc_if_version()
Message-ID: <20180913123553.GJ2268@kroah.com>
References: <20180903224304.15989-1-tomas.winkler@intel.com>
 <20180903224304.15989-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903224304.15989-2-tomas.winkler@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 01:43:04AM +0300, Tomas Winkler wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> commit b40b3e9358fbafff6a4ba0f4b9658f6617146f9c upstream
> 
> We accidentally removed the check for negative returns
> without considering the issue of type promotion.
> The "if_version_length" variable is type size_t so if __mei_cl_recv()
> returns a negative then "bytes_recv" is type promoted
> to a high positive value and treated as success.
> 
> Cc: <stable@vger.kernel.org> # 4.4

I also need a version of this patch for 4.18.y, 4.14.y, and 4.9.y before
I will consider adding it to 4.4.y, as we do not want anyone to ever get
a regression moving to a new kernel.

thanks,

greg k-h
