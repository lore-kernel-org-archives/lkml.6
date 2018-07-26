Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBDC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9F020647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kjkpfylD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nC2EHJwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9F020647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeGZP3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:29:37 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44817 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729923AbeGZP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:29:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 8DD3529F;
        Thu, 26 Jul 2018 10:12:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 26 Jul 2018 10:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=RmXg3cLDpDethyhD3b9tD2gyH/IFVsNSNgWyMoKtLO4=; b=kjkpfylD
        Ko3jYECPY25rSgkUH8j2J4Uvqo49/9H9HHy60LIMj4ub/mCzZ+nm9s21nSon9gaR
        7UAG284nCVTAHwO0IEvvjo0fdDMDbGf+oe/qsNB4++58iOSf4xMWwxqcA01Dy3tc
        1TtWZ3Kh33WfHsj4klnZydZLE5UZp97Ze9KxNoBKXg8XE7tDPxF+4ZOuFf75Q9tc
        mTfXU5DB4+mv92qP0F59Jse50HENwVXxgr/LJeeW8UPWGK8SQCBcdf1GVtWVSbeG
        JD/+7sH3JSL9nX6KLW8yji3ShRGBM8jzWM7rQgpTaZtimYF3VWJBW4EJSOu7lp0J
        TG/8SmHUk1v2lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=RmXg3cLDpDethyhD3b9tD2gyH/IFV
        sNSNgWyMoKtLO4=; b=nC2EHJwgNlenYOlzgE2RP7BID7CD0TZC83WaD+I8a4agQ
        GWhVLBtKW/75eTTVdY1egKA9rN4oqgYv0H/O1asOj2tibdThiJjSuJG3ssNJ8I5X
        PE+tL+LHJ2yJUPNJEHwDZyzwBma2sRSgKWh256lBmRWh+x9OwsvzDBeU/y4bYXOv
        B62dv7yIU1IptBtgNPrF0aZm1E2ZcIl2ECONAJ6mzHrmsbiCt0Rysr6V/3PwjqMT
        r+nNcN5UMj+P6Sb63YgJ6hFAvyoWdquVMbfLVlAq+5roJtNoDzZJk8XKq9C/7sY3
        wjJTvUocMpR24UY5eUC3YO0UGMemQJmfpQb9ixH1A==
X-ME-Proxy: <xmx:0NZZW8zii0kji49IrRK_SCJT3N_gSomraaxeQ6HHulT40Y32FHYsdA>
    <xmx:0NZZWzi5Ty-duQlI7ZFhDZKvO45IeypJe74vEgtKtEG2C_UMkPwo0g>
    <xmx:0NZZW08jPF0HWyYRCpwI0NiuZtNCe-XaUNc6mnYpwHEbnd7DT3DuTg>
    <xmx:0NZZW91FIc59IYFPMrrplMSbA5BYCkLy0Moji2dXYMHc36Cl9nn5_g>
    <xmx:0NZZW68S8WC0fnp4itMq6o6xYjA1Tf3JEGsoDHNVhXNW2UNUr8d5dQ>
    <xmx:0dZZW5qHJAR5YM3HwOwkpsTBF7PFSe4wb7x_RUjMC33bW5wMWkbQ5qt5tr4>
X-ME-Sender: <xms:0NZZW52qu_QO-Zz2EjzEgIkpDr82oMdqDpQtlCdk2RIcjv9FqJ2TfA>
Received: from localhost (unknown [62.119.166.9])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49BA0E4BDA;
        Thu, 26 Jul 2018 10:12:29 -0400 (EDT)
Date:   Thu, 26 Jul 2018 16:12:27 +0200
From:   Greg KH <greg@kroah.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     oleg.drokin@intel.com, andreas.dilger@intel.com,
        jsimmons@infradead.org, paf@cray.com, namit@vmware.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lustre-devel@lists.lustre.org
Subject: Re: [BUG] staging: lustre: Possible null function pointer in
 ctx_refresh_timeout()
Message-ID: <20180726141227.GA12445@kroah.com>
References: <6920e093-ad62-56dc-6f58-36cf8d7ed3b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6920e093-ad62-56dc-6f58-36cf8d7ed3b4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:02:22PM +0800, Jia-Ju Bai wrote:
> In Linux-4.16, drivers/staging/lustre/lustre/ptlrp/sec.c,

Please look at the 4.18-rc6 release for this file.

In short, nothing to worry about anymore :)

thanks,

greg k-h
