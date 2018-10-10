Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5804C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8985B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSCuO/5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8985B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJJNNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:13:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeJJNNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:13:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCE021479;
        Wed, 10 Oct 2018 05:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539150791;
        bh=NWpq+bQTT5GTfap/EoDclho+xViE1DGn5/6k1PNgzHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSCuO/5FnY4+x6EUizF9ZWUG7xFMhNt4DINvr5sPpWDJdLdOtCHfryJqv3XqVf3nl
         v4zp5Z/KGFcb5rhkMiazMY/fjCjP6Mk6fm8FBwrFWSqxENT+SAoCaVWWS6nZaCzRE3
         tY5lL5ZnZyYrocYMusc3zd3boOkzEQ5Bc6NUSLwo=
Date:   Wed, 10 Oct 2018 07:53:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/113] 4.4.160-stable review
Message-ID: <20181010055309.GB7134@kroah.com>
References: <20181008175530.864641368@linuxfoundation.org>
 <20181009210501.GA12203@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009210501.GA12203@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 02:05:01PM -0700, Guenter Roeck wrote:
> On Mon, Oct 08, 2018 at 08:30:01PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.160 release.
> > There are 113 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Oct 10 17:55:13 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 150 pass: 150 fail: 0
> Qemu test results:
> 	total: 286 pass: 286 fail: 0
> 
> The previously reported failure of
> powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> is no longer reported because CONFIG_OF_UNITTEST is now disabled.
> This applies to all reports.

That's one way to fix the failing test :)

Seriously, hopefully Rob's fix for this lands soon.

Thanks for testing all of these and letting me know,

greg k-h
