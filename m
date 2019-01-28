Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ED2C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65862173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694406;
	bh=mIiFjEFbxvOCOd13hH2gfBHzs7USu5K2gZZrYFjCWK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MrJLOyTzy6qrz91HfUOiYM+hiH+mw6hHWAg+e4XYMGujKVDqoP7q6AVbRMYzfRF1G
	 Wh9VD3D6kzffeQFenMTJpac0FljKmTtS3g0UIqBA2sf774q6EbgBkp3zd6h7izfrkw
	 Y2Fby8P9LxKECGL5HayB6IxRKaRhMRTNkNU+BfiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbfA1QxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388410AbfA1QxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:53:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9282173C;
        Mon, 28 Jan 2019 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548694400;
        bh=mIiFjEFbxvOCOd13hH2gfBHzs7USu5K2gZZrYFjCWK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbL9fAsKrTecNMLjqZyWQNK048ai0fBFyZaVuzt+AOalxiAsIMZ6oNm/9B+r8UpLH
         hUnyPzEgBept5TtjkYiyH0CGhLLJ0eEa7654bfj565APq6qK6xPQyP+oxkS3i3a3//
         a6qrVt4sbILBF4nhJlgFE9uhWCs40BHwDfYH4zoY=
Date:   Mon, 28 Jan 2019 17:53:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH] tty: increase the default flip buffer limit to 2*640K
Message-ID: <20190128165318.GA16213@kroah.com>
References: <20190128163843.688-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128163843.688-1-martink@posteo.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:38:43PM +0100, Martin Kepplinger wrote:
> From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> 
> The default value for this was 64K. We increase this by a factor of
> 10 to 640K to prevent data loss when using fast serial interfaces.

What fast serial interface are you using where you run into this limit?

> Since this value is only a maximum limit for allocation and isn't used
> by default, this change has minimal effect on systems with slow interfaces.

So what systems does it affect?

> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> Is there any reason for this _limit_ to be as small as 64K?

Historical mostly from what I can tell.

thanks,

greg k-h
