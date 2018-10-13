Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7935EC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2871B2087D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZgQHeqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2871B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbeJMOkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbeJMOkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:40:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4349420877;
        Sat, 13 Oct 2018 07:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539414262;
        bh=oK4mTvXoqjefuYbMUI0tDpZ1U1873JqN4awcSrdk5z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZgQHeqSE1ciW/ZnWoyjlrB9+AyJTfh6PjhNni7uwDc+TA3/XCwmuaM1FUfrWLzYU
         5WUADEgxZdqZnCyEsvueQJH65ybtOiM8kmneGxfbR1JmqWQETSI/V/UiIPMBdx1U9X
         0nSNaBeYxZgdvpaE42ogKW2drrUEeUZKtu0QGC+4=
Date:   Sat, 13 Oct 2018 09:04:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH] bit_spinlock: introduce smp_cond_load_relaxed
Message-ID: <20181013070420.GA29914@kroah.com>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 02:47:29PM +0800, Gao Xiang wrote:
> It is better to use smp_cond_load_relaxed instead
> of busy waiting for bit_spinlock.

Why?  I think we need some kind of "proof" that this is true before
being able to accept a patch like this, don't you agree?

thanks,

greg k-h
