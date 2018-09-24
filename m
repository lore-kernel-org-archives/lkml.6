Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1882086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1882086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeIXQyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:54:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeIXQyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:54:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F7A01057;
        Mon, 24 Sep 2018 10:53:11 +0000 (UTC)
Date:   Mon, 24 Sep 2018 12:53:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [char-misc v4.4.y 2/2] mei: bus: type promotion bug in
 mei_nfc_if_version()
Message-ID: <20180924105307.GB16476@kroah.com>
References: <20180903224304.15989-1-tomas.winkler@intel.com>
 <20180903224304.15989-2-tomas.winkler@intel.com>
 <20180913123553.GJ2268@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9B4CF9@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9B4CF9@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 05:49:02AM +0000, Winkler, Tomas wrote:
> > 
> > On Tue, Sep 04, 2018 at 01:43:04AM +0300, Tomas Winkler wrote:
> > > From: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > commit b40b3e9358fbafff6a4ba0f4b9658f6617146f9c upstream
> > >
> > > We accidentally removed the check for negative returns without
> > > considering the issue of type promotion.
> > > The "if_version_length" variable is type size_t so if __mei_cl_recv()
> > > returns a negative then "bytes_recv" is type promoted to a high
> > > positive value and treated as success.
> > >
> > > Cc: <stable@vger.kernel.org> # 4.4
> > 
> > I also need a version of this patch for 4.18.y, 4.14.y, and 4.9.y before I will
> > consider adding it to 4.4.y, as we do not want anyone to ever get a
> > regression moving to a new kernel.
> 
> Right, I've started from the wrong end. 
> Now I've posted the patches for the rest of the required long running versions.

Thanks for all of these, now queued up.

greg k-h
