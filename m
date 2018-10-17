Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151B5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF20214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ewySx2KB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlgA7nh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF20214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJQMzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:55:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40369 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbeJQMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:55:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 580D221BBA;
        Wed, 17 Oct 2018 01:01:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 17 Oct 2018 01:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=m1XufqSH1AkKgugh42Q8IjZeU9N
        kck9HxpAmpB4d438=; b=ewySx2KBwplqtVr6EfezfKq3NzWbgS2KvIfD/XqgJgf
        d7ZjNKwe1eh0MqRFl9hzLfqB61e4ZAQSOUgOV8gMUxvvuqaYSXYMgustB0wgIYT+
        nIdd1tdImxGvnRvLDnh84+DT1bi0OIKHsgPAR51iqPcnnhaV5slbQIlOwWhwT3HC
        qA7ufOQnIdIJDv/j1mpzCUefWa/cdYoa6M/ou8QIt3XGmeXyTwNHkJc9y0QPHPcw
        z/jS7L2tGS64B/pYB0V9YhnbnKdLBbQLCEYvLjwpTQs6K7+ZP3oGnKaPqTwRvhIY
        bAQ2zDyXQraVKvmFU8YJyLpxGu0xhmGfw81Bh6fWNxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=m1Xufq
        SH1AkKgugh42Q8IjZeU9Nkck9HxpAmpB4d438=; b=IlgA7nh2cI6a87Pw2rZmmj
        7HSMHaWT7Iy9Skcid8e4B1pd0cR6S84Nz87EJLQGkibyy3M5mQwN33A/8U5vybWE
        k48ioFe2T2U/PzcajBQ2NpfOmlF6ul9mM4aEnLlnjut50l8ykHDQSGIwyd5I2QQo
        MkRnCTWsCfusUOMdqp0S8e/MViFkD0TG/xpX/VgbJvCnc/upkNujEEx/ajNwUnd/
        bXqEqMJqy5FCUQxc9kex9rGEBhaNdUZBo7xVpuMLlt4POunqM61nslemqJPJUHtz
        kvNzo/sjUeBXPrOZYmr8ObKhM1hrSbdOGwhBu2kCz4oxpiq92/ogL8H4e3FQDYqA
        ==
X-ME-Sender: <xms:GsLGW-A3GqX0nEjmzVgwSrerjrFS3XnStdvhRfFTE-6Y48Z2XImdoQ>
X-ME-Proxy: <xmx:GsLGW0JLf3n99rSM2DEKl3PH-wMpQJusj7bggOs2TjbUpWUibWuiqQ>
    <xmx:GsLGW8urcBKDoNRaTywkqhsY7PyWN0hYxcV9GWr7rsbczJ8jULc-Lg>
    <xmx:GsLGW7wrbxpAyVGNy_j7Ky9_7fQBNSohzXE7X4a8_RVd_OiAPkeRmw>
    <xmx:GsLGW2fkw5h5vGZ11dJsnxeeorHnkgq_e8MPohaEvKXmN4w23gzZXQ>
    <xmx:GsLGW8LfvWT79PkwLSpKURY_TS_XHoX0nbYBCwTwtfZutuRUc7Ucog>
    <xmx:G8LGW7jlc-CuLG6zA8OO_XAcFGwly_d7cDoJKoN6D6LqUScEzZuiuA>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA208102EB;
        Wed, 17 Oct 2018 01:01:13 -0400 (EDT)
Date:   Wed, 17 Oct 2018 07:01:12 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: manual merge of the char-misc tree with the drm tree
Message-ID: <20181017050112.GA22447@kroah.com>
References: <20181017142257.5002799b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017142257.5002799b@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:22:57PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   fbb0de795078 ("Add udmabuf misc device")
> 
> from the drm tree and commit:
> 
>   9793c1fd1775 ("MAINTAINERS: Clarify UIO vs UIOVEC maintainer")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Looks good to me, thanks.

greg k-h
