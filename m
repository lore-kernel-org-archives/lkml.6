Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D55C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981782082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQiBgT/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981782082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeLDLJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbeLDLJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C566B2146D;
        Tue,  4 Dec 2018 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921788;
        bh=VsIrmYqIsFjb+v1He7hvPYCeX+28dDfZnRdlYopbR1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQiBgT/G+I1rNPwzbGxa4ppZLcjo2bwe75AMUlbW3DTxl4Ng1UqteSG/ZtS7HpSUi
         ZwynaqP8j2oz/KKIojYyP871zWUrKViSEqn8pmKuX80dFaY5yaDAULpvev4KSIctwl
         0jYaezwvVxTeZqdQt9POGjh7r4mxVQjEnH7qEGx0=
Date:   Tue, 4 Dec 2018 11:54:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181204105414.GA23254@kroah.com>
References: <20181130163252.e6z33t23j3qud57z@localhost>
 <20181203105506.GA21127@unbuntlaptop>
 <20181204044257.grk3na2wyrx6nssg@localhost>
 <20181204070033.GG3073@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204070033.GG3073@unbuntlaptop>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:00:33AM +0300, Dan Carpenter wrote:
> Hi Greg,
> 
> I meant to CC you but I screwed up and added you to the From header
> instead... :(
> 
> Why did you commit 3b1ad360acad ("pps: using ERR_PTR instead of NULL
> while pps_register_source fails")?  You're not listed as a maintainer so
> I wouldn't have known to CC you.

The maintainer told me to do so, see this email thread:
	https://lore.kernel.org/lkml/44edc27b-e679-24e8-aef1-fe5b7570f982@enneenne.com/

> The back story is that the last chunk which changes drivers/ptp/ptp_clock.c
> was dropped by mistake and it's not there in linux-next.  I wrote a
> patch which adds it, but everyone is super confused now...  Here is
> YueHaibing's original patch btw, for reference.
> https://www.spinics.net/lists/netdev/msg535929.html

If you want me to take a fixup patch for this, I will be glad to.  I can
also drop it from my tree as well, just let me know.

Sorry for the confusion.

greg k-h
