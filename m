Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE14C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235B020663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551105919;
	bh=RSSPIGGr+Vs8r5rLMNtRLQy0tjQ/iqhoAvECGlz4heU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KVnZO7DJ9xncBGBMR/O9qUIZLjLWBnWjMHP7WO7l1hduhXa+J06Pgl8zie7N2FAqa
	 LbWspM7VCX/7O86gF8Hv62TZNB/cUj97rMmptuqlViMcFpX6ta8Zx6H5rVzr3C1qX7
	 9Ikp0UZLf6QFNsE8vN9O3yJJJPBO7jNWzRoG8DKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfBYOpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfBYOpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:45:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6715720643;
        Mon, 25 Feb 2019 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551105915;
        bh=RSSPIGGr+Vs8r5rLMNtRLQy0tjQ/iqhoAvECGlz4heU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+BY0ksUpdGnfcZI4cPlVaaIW8rvL1VORzDTkKwE/An9g79b/CoqxE3ZZAoJ/5vye
         HVLhMBwQwVa9X7c7z/aUqZvMYxvmGX9W9WT3DpGvlY+f4u59WmfGfIgi/jz+Kc4fCT
         JnReJYdzjkMjyTuvxbIcSaiCfTqsei7JiEHe+EOA=
Date:   Mon, 25 Feb 2019 15:45:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Clang patches for 4.9
Message-ID: <20190225144513.GA14055@kroah.com>
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

Really?  I see a number of these only showing up in much newer kernels.
Specifically these patches:
  1f60652dd586 ("pinctrl: max77620: Use define directive for max77620_pinconf_param values")
  a0dd6773038f ("phy: tegra: remove redundant self assignment of 'map'")
  a9903f04e0a4 ("sched/sysctl: Fix attributes of some extern declarations")

from the "arm" mbox you provided.  Why shouldn't the above patches go
into 4.14.y and in some cases, also 4.19.y and 4.20.y?

thanks,

greg k-h
