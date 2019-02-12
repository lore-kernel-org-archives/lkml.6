Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDB5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5932080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549962096;
	bh=WzFQ+3a7dvtqrg45hRTHTld0jYX/llWzkh8PpjVgQJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LVTtUw0DECeo59bEf/EiaPV0zTpo3LtYklJI4ndGvJz8cS0ij26sUEPEQtwybZ+k9
	 y2yCl8oOIxrBSW2JECdA9ElO5fJzkfmYIRM1IcS7pxD45F9/+4507vl0T8zzzv5sZ4
	 GKz+kWKRfycMM6t64D845mPyJ1j+jMRWM1l6fcJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfBLJBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfBLJBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:01:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304BF2073D;
        Tue, 12 Feb 2019 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549962093;
        bh=WzFQ+3a7dvtqrg45hRTHTld0jYX/llWzkh8PpjVgQJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pHQmmPb+5ckkPYqly8Jsy6DrrLVNyYtrMx4sZ2D1aKlZhVqRjrWSEvgNOlwn+jgPi
         w/JdCmVPEr/Rzle8Zfbql7FkCSSHyPooUU24ruafLqMBk7eYten3uBU+ry1EMbrCwL
         z9LiNhA/lmzZ9NjZxenCbXPoIY7denIicMaudNlo=
Date:   Tue, 12 Feb 2019 10:01:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] chardev: fix an overlap misjudgement case in
 __register_chrdev_region()
Message-ID: <20190212090131.GD31657@kroah.com>
References: <20190212084739.27602-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212084739.27602-1-cgxu519@gmx.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:47:38PM +0800, Chengguang Xu wrote:
> Current overlap check of minor range cannot correctly
> handle a case which is baseminor < existing baseminor &&
> baseminor + minorct > existing baseminor + minorct.
> Fix it and meanwhile do some code cleanups.

Ick, don't do a fix and "code cleanups" in the same patch, that makes it
almost impossible to see what the "fix" really was.

That should be two separate patches, please break this up.

thanks,

greg k-h
