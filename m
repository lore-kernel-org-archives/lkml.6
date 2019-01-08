Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75688C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A73C2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546933549;
	bh=bnIORv9ytTHxfULsM6MdZ6GsdnDuLjHPyVSZPSToEcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FRMJ9WBX0xMMljdKMo0NhRapdF/cQNVgrEv8v4NhJ/nh3d2FCvhT4nyAO+8YwBOyQ
	 UaXSYnvlIQ8nbnWSZBhRqSWnnQNhZQISJkmTbZoJahOJiTzfYZPi974TT/k1T36XFE
	 RElLpNTc5frMHD3TJ/GaxsUd6JpwyxIPwUEe6bJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfAHHps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfAHHps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:45:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323E420700;
        Tue,  8 Jan 2019 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546933547;
        bh=bnIORv9ytTHxfULsM6MdZ6GsdnDuLjHPyVSZPSToEcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4WOqoqKWYCVFECgLT0lXgL+J7/Ox7p/TNyYjtwC6PyCQTgrfmH2I9zlEc0UAz/IT
         CaFFSnGiNgBmmOLcb++UeS2sy03zxVX40uwthMWyY+830gR5DuQy+qn4dKxFfbKN6F
         wCet64244WaB5l/wuCuryrED3xRw1jzv+v+xI5T4=
Date:   Tue, 8 Jan 2019 08:45:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190108074545.GG2102@kroah.com>
References: <20190107104437.308206189@linuxfoundation.org>
 <27bbc7b0-2fb8-8f40-53a5-2a2d82f37f8e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27bbc7b0-2fb8-8f40-53a5-2a2d82f37f8e@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:36:48PM -0700, shuah wrote:
> On 1/7/19 5:30 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.1 release.
> > There are 145 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.1-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

thanks for testing all of these and letting me know.

greg k-h
