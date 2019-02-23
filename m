Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F36C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC4920855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550919324;
	bh=dZwuel7jzWuV1YzBjASaybFRyrUAqRLJ5mIWLgozO5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fXZx1I3R6Pmjcyzn+QBpAws3BQyVnT42qu1xpXoYz+dcnQSs4ssfV/oxs/O1Ps3Bh
	 GblX0f14FnQvu7ZqeVv4vADZ0hhKvVq2upHMICbgbs0Pg9V4vh+PvGSwkqazUAs//T
	 dsFjObTM/v/jJF9S/Br7bSsqWhFiHtykqUDoTWnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfBWKzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfBWKzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:55:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C778C206BA;
        Sat, 23 Feb 2019 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550919322;
        bh=dZwuel7jzWuV1YzBjASaybFRyrUAqRLJ5mIWLgozO5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTvLu/7M+mrljULit9v898ZUTrpIa11olwpsV71m0rcKkU/GzGkA91FmELuL1ajwz
         9P1lyE91rzCMl3gljp5k54Oizo+3GCUsTrONEMTTWrvAB8uIOH8DKBxSvRQfKKKMjB
         pv09JrVgbsri8lil3yHbzDqmi1ZzEo/aAt7mA86E=
Date:   Sat, 23 Feb 2019 11:55:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 4.14 62/62] pinctrl: msm: fix gpio-hog related boot issues
Message-ID: <20190223105519.GA6614@kroah.com>
References: <20190218133505.801423074@linuxfoundation.org>
 <20190218133511.112652987@linuxfoundation.org>
 <4323375.xCQYxFPVKo@debian64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4323375.xCQYxFPVKo@debian64>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 05:57:11PM +0100, Christian Lamparter wrote:
> On Monday, February 18, 2019 2:44:08 PM CET Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> 
> 
> Wait! There's a problem! This patch "alone" is not enough to fix "the gpio-hog
> kills system" bug. The series also included the necessary dts change:
> 
> "[v6,2/2] ARM: dts: qcom: add gpio-ranges property"
> <https://patchwork.kernel.org/patch/10432105/>
> 
> This patch is still set to "Awaiting upstream". But, from what I can tell
> "linux-arm-msm" is the upstream, right?

I have no idea :)

I need it in Linus's tree, is it there yet?  If so, what is the git
commit id?

thanks,

greg k-h
