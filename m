Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A896C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0620F21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548154901;
	bh=TF88CO53nMwZgCdVd6XfDcmudxGfuXMQ5I8RmDQpPLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iPZfnMLOkAnhDMWRvUjs1HWB1qzp/1q0No4yhTJEibKD4zH4b+8Dv2bIpborjusS2
	 WwgO+6kTG4FUn/a1d+hsPDNafPzFXYlicMxECeHCEotgemvGlfu8i2AKGvaBiA7gBQ
	 uwssiss2Kss69qBajWmpQb++LFuAr9/Da9u2ro8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfAVLBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfAVLBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:01:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F216420879;
        Tue, 22 Jan 2019 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548154898;
        bh=TF88CO53nMwZgCdVd6XfDcmudxGfuXMQ5I8RmDQpPLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nP5a6qBvCTx1URIPZxuygVg+ouG4vYSJNBQKk36TxPqkz68CX62jPpVkocvTsXMTQ
         HzliX7RPGtKEBCBoj9lcLd76A/0j551fRx5j2Pd5rvPr+4Lb2UzSvaV/5BkNMRmYT3
         HXFTx/LKobCqhItmw+k1bgj+YPsNdDO5o0PaMgTg=
Date:   Tue, 22 Jan 2019 12:01:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liu Jian <liujian56@huawei.com>
Cc:     xiubli@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] driver: uio: fix possible memory leak in uio_open
Message-ID: <20190122110136.GD21034@kroah.com>
References: <1546954723-197902-1-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546954723-197902-1-git-send-email-liujian56@huawei.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:38:43PM +0800, Liu Jian wrote:
> If 'idev->info' is NULL, we need to  free 'listerner'

"listener", right?

Please fix up and resend.

thanks,

greg k-h
