Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1CAC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CD12147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551106507;
	bh=e5RPfY9hn90NJte8vzQmcpaPfJo2v1ChDJ8UQSnJVQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aGcpL2ox+Pu9Nx9eEUqPJcp8SoVB123p8pfkVkGzDPqeEb/P422/LMTdPMJnZZZeo
	 Ki3UiRrP0CfCxa2/3w1qBW6oac2QaRz4AZ7smVO/dJ6xCeF+lQWN7m+EUq1Wdeoa5x
	 ZUqKfXUMftrxv3CCWViRss5+ZOGDA/o8AvV6lPJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfBYOzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbfBYOzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:55:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D93B2146F;
        Mon, 25 Feb 2019 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551106505;
        bh=e5RPfY9hn90NJte8vzQmcpaPfJo2v1ChDJ8UQSnJVQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PE/nady6Y30kTTVD4EKfEk0pSu8cPrhtFtZGClGzl8iq0PEteSxxS00lDbDm8rN6q
         vxI97f/cXs0Lhr85HC+eZPkuVGNbsHEhwU3RIrUf3OGvZyGOXQrzNgIPmicEWzuYQr
         WkWt6+Wrn2l0GLFg7od0TvMYzfDdhLjBLrJ6Apmw=
Date:   Mon, 25 Feb 2019 15:55:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Clang patches for 4.9
Message-ID: <20190225145502.GA16015@kroah.com>
References: <20190225061301.GA23411@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225061301.GA23411@archlinux-ryzen>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 11:13:01PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Attached are three mbox files containing patches that bring the Clang
> backports that Nick did in 4.9.139 up to date with what is currently in
> 4.14 and mainline, as well as fix warnings that are present in the arm64
> and x86_64 defconfigs here and in AOSP (cuttlefish_defconfig). All of
> these warnings are fixed in 4.14 so there will be no regressions from
> upgrading.
> 
> They were tested with Arch Linux's GCC 8.2.1 and AOSP's clang-r349610 [1]
> and boot tested in QEMU 3.1.0 with our rootfs files [2].

I've included most of these now, except for the ones already pointed
out.

> Additionally, for Greg, I have provided a merge resolution for
> the Makefile conflict you will get when doing the android-4.9 merge.
> You will also get a conflict in arch/arm64/include/asm/arch_gicv3.h,
> just check out to MERGE_HEAD as the {read,write}_sysreg_s macros have
> the LTO workaround that causes the conflict in the first place. I
> tested this resolution by building and booting cuttlefish_defconfig
> for arm64 with CONFIG_LTO_CLANG and CONFIG_CFI_CLANG enabled.

Thanks for the merge resolution, I am guessing it is not going to be the
same now that I did not take all of your Makefile patches :)

greg k-h
