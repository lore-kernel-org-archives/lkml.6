Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F41C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0665820866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zC+QVcOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0665820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbeKVVjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387883AbeKVVjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:39:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD7720820;
        Thu, 22 Nov 2018 11:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542884447;
        bh=FsxL85XlakklSkWTE4Ut+Q44G5xI3vdrqhcvO1RYGa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zC+QVcOyqnMiYaaTilCGun3YPn1Jkrd4r1ulO4hw8c2QRgDXstnefpO1Tt8qgy1Ed
         GaBMq5hqeZsPTy52mzXMCB97v9ZP7Mxdqgkhc7ZkAYb0TY/6pkFHtwsHQQejv5ORLY
         wC1R3WOuj8ksdF9JpzUfzrvXrpov05QtUYu0eogg=
Date:   Thu, 22 Nov 2018 12:00:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 01/10] staging: erofs: fix `trace_erofs_readpage' position
Message-ID: <20181122110044.GA5287@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-2-gaoxiang25@huawei.com>
 <20181122101941.GC3189@kroah.com>
 <fcf5c088-6025-171f-bc24-0e698c68bbb7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf5c088-6025-171f-bc24-0e698c68bbb7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:49:53PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/11/22 18:19, Greg Kroah-Hartman wrote:
> > On Tue, Nov 20, 2018 at 10:34:16PM +0800, Gao Xiang wrote:
> >> `trace_erofs_readpage' should be placed in .readpage()
> >> rather than in the internal `z_erofs_do_read_page'.
> > Why?  What happens with the code today?
> trace_erofs_readpage is used to trace .readpage() interface (it represents sync read)
> hook rather than its internal implementation z_erofs_do_read_page (which both .readpage()
> and .readpages() uses it). Chen Gong places the tracepoint to a wrong place by mistake.
> And we found it by our internal test using this tracepoint.

Ok, you should put this in the changelog text when you redo this series.

thanks,

greg k-h
