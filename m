Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2B52184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551198880;
	bh=CZ2cgZ1ZqKkOYDTgVY2ELC9joIZm1lxkZnRbA1/lWQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EddClm5XUI0BzH1xxQG44IT4el/G/D8zk1HKgZMETm3FvFsHCAAHJtf+oDkNjN40g
	 hSt8oHBjNg7sBHNDfDVjrgqVQlxj0rmIB18xsoMvLmW8yHA2PlIj6o06bEb9ZQRGPZ
	 u1ZHGkOpxQF9wo5yuqK9IAfpQLLXVV7+IqN1cURU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfBZQej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfBZQei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:34:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D435220C01;
        Tue, 26 Feb 2019 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551198878;
        bh=CZ2cgZ1ZqKkOYDTgVY2ELC9joIZm1lxkZnRbA1/lWQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pr5qTgcrAdlmQKgf8hdPuG4oMKc+q/iY8v9BFUKgY2CfT9sNpoc6yjoWsDyqbSFBF
         WjR7oMtuKD2hmejd2zyZMdQPFoOFTPBujEJLOwHeNGzaDtHt5oIjgUBP/pZwxuNtWM
         yDDcYd76ascE0yYbr03upco/GFV1c7LS0QyXzoUo=
Date:   Tue, 26 Feb 2019 17:34:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/183] 4.20.13-stable review
Message-ID: <20190226163435.GA12491@kroah.com>
References: <20190225195054.748060397@linuxfoundation.org>
 <552a28aa-1cee-fa0e-c6a0-ea24fd2c1626@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552a28aa-1cee-fa0e-c6a0-ea24fd2c1626@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:51:17AM -0700, shuah wrote:
> On 2/25/19 2:09 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.13 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.13-rc1.gz
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

Thanks for testing all of these and letting me know.

greg k-h
