Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E5C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E603D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551106045;
	bh=bbI21qzMq9+BmFRVS2XOjkfRmIjb1UsE0IGeAoPXTWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cO9QnwUAKeQC7ucfnD6nodmrGt23LvPfSw0yiicMx9OFUtDcFu+V6Q/LNqGQO0ajJ
	 eDNfKFINxyANZhJvcm1l9g2xEEu4vn/P/F5/TQvLEo5PPmYog6jzhfvzg370XCjOk2
	 fT64fZKxH8xaA366FYplwDtcTPWd8eTv7n/50Hps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfBYOrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfBYOrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:47:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F09220643;
        Mon, 25 Feb 2019 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551106042;
        bh=bbI21qzMq9+BmFRVS2XOjkfRmIjb1UsE0IGeAoPXTWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtMOx4bmIecFQtM8B2mTZfKYEdmE8fXumqLT+HhRGkA4eScR67IUIbrYFdBUB+vpa
         Mc8ZRwaKFj73Dq091qpfJTitVt0qts0VZ5IIbCI1RXZhYqH+gIqevK6s2cS9SqlxlO
         72bYmtrw50xv0amoUWh4Qp7D5NdyscoFGttsMrc8=
Date:   Mon, 25 Feb 2019 15:47:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Clang patches for 4.9
Message-ID: <20190225144719.GA14597@kroah.com>
References: <20190225061301.GA23411@archlinux-ryzen>
 <20190225144513.GA14055@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225144513.GA14055@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 03:45:13PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 24, 2019 at 11:13:01PM -0700, Nathan Chancellor wrote:
> > Hi Greg and Sasha,
> > 
> > Attached are three mbox files containing patches that bring the Clang
> > backports that Nick did in 4.9.139 up to date with what is currently in
> > 4.14 and mainline, as well as fix warnings that are present in the arm64
> > and x86_64 defconfigs here and in AOSP (cuttlefish_defconfig). All of
> > these warnings are fixed in 4.14 so there will be no regressions from
> > upgrading.
> 
> Really?  I see a number of these only showing up in much newer kernels.
> Specifically these patches:
>   1f60652dd586 ("pinctrl: max77620: Use define directive for max77620_pinconf_param values")
>   a0dd6773038f ("phy: tegra: remove redundant self assignment of 'map'")
>   a9903f04e0a4 ("sched/sysctl: Fix attributes of some extern declarations")
> 
> from the "arm" mbox you provided.  Why shouldn't the above patches go
> into 4.14.y and in some cases, also 4.19.y and 4.20.y?

Also, why are you wanting 238bcbc4e07f ("kbuild: consolidate Clang
compiler flags") to be in 4.9?  You put it as the last patch in the
series, nothing depends on it, which seems odd...

greg k-h
