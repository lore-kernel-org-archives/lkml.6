Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B37C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDCC20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546950346;
	bh=N9CQnCnBPEGNUcGn7kk7AuLYLm1uZwh3hvsxPI+Ve1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gy7f8RQqyj2vTezV2dxz9MmTRB7kBR3X6yBYDRin6XaYm+/AwvQK/7wkpERgUMEzj
	 a98yhtphUxWaQovQq7vCI6eiw5/UHIQXlbNCk5tQNHjSyEaiDiukQPL/WY9hScRPlO
	 +9vr/yQrcK2oF8KfyNEGjNRAUJnTzJp1AYlbpujI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfAHMZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:25:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfAHMZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:25:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4D6206BB;
        Tue,  8 Jan 2019 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546950345;
        bh=N9CQnCnBPEGNUcGn7kk7AuLYLm1uZwh3hvsxPI+Ve1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4wTnaelZvWo1YAZzDpmAies2nw+lcNmJjAMQ5aoUYrWFLCDZ2RgnHrgG9xDWriF3
         vmxzkvWqs38VIWtkpXId06cb8JM+xK3mCX2iwy8qbVkjTD/WmO6KGD/ZyeELnDUCNV
         RFBMYBcYmMFRP5e+Pigd+YhO4rhT6AVaIjBhJbEo=
Date:   Tue, 8 Jan 2019 13:25:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
Message-ID: <20190108122542.GA4801@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <d86ef960-dd47-b282-5432-4ecbdd4e0daf@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d86ef960-dd47-b282-5432-4ecbdd4e0daf@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 08:59:12PM -0800, Guenter Roeck wrote:
> On 1/7/19 4:31 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.92 release.
> > There are 101 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> For v4.14.91-100-g31e3578310df:
> 
> Build results:
> 	total: 171 pass: 167 fail: 4
> Failed builds:
> 	arm:allmodconfig
> 	mips:allmodconfig
> 	parisc:allmodconfig
> 	xtensa:allmodconfig
> Qemu test results:
> 	total: 317 pass: 316 fail: 1
> Failed tests:
> 	mipsel64:fuloong2e_defconfig:fulong2e:rootfs
> 
> Failures are reported earlier for other releases.

Should all now be fixed up.

I hope, this set of releases has been a pain...

greg k-h
