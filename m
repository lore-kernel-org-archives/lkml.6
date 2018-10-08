Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5DFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174232085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUH/IuDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174232085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJHVzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJHVzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:55:41 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF705204EC;
        Mon,  8 Oct 2018 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539009818;
        bh=720IENbXcqxURIU4OAuMD1kEhRQcdnCDFr9E2jjaOl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUH/IuDiCWHteh1lAiETnZQHks4PW3HNjCIzrpzueljYMmoMuK2CP1D0YXMltHFZm
         7oMcQio6R3gnPcOJXPO+VThxXoVuq6C3auU2csvlxQeIwDlT6l2X7LgXjI0A7+sy81
         IncsMq/DqOo+s+Sh7lyDQE16aWmoxdDw8yHyWzJQ=
Date:   Mon, 8 Oct 2018 16:43:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        Loic Tourlonias <loic.tourlonias.lkml@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: erofs: add SPDX identifer
Message-ID: <20181008144335.GA15968@kroah.com>
References: <20181008141409.2624-1-loic.tourlonias.lkml@gmail.com>
 <20181008142228.GB13359@kroah.com>
 <e9620bf6-5f3f-108d-b9f1-91af1ad603d6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9620bf6-5f3f-108d-b9f1-91af1ad603d6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:36:39PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/10/8 22:22, Greg Kroah-Hartman wrote:
> > Why delete that line?
> > 
> > But wait, why do we even have this file at all?  What's wrong with the
> > lib/lz4/ code that we have in the kernel today?  Shouldn't the code
> > using these files be moved over to use the lib/ code instead and this
> > file be deleted?
> 
> EROFS uses customized LZ4 decompression code for now (which has been offically
> supported in lz4 1.8.3, I have updated it in
> https://ozlabs.org/~akpm/mmots/broken-out/lib-lz4-update-lz4-decompressor-module.patch
> if it is shown up in Linux 4.20, I will remove all the customized LZ4 decompression code),
> but lib/ code lz4def.h isn't export to include/.

It should show up in 4.20, so you should be able to remove this all
then.

thanks,

greg k-h
