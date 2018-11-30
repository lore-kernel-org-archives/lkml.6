Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D436C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84802146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnA1Nc4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84802146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeK3WaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbeK3WaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:30:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912EE206B7;
        Fri, 30 Nov 2018 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543576872;
        bh=+fMfenf3ZjeAdShtG9XsaqkYVxPmLUzBsYGb8TLvua0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnA1Nc4Gpd8iteVU6wm7ctd/p4WgLY4xT7luYvgXleV5t3fNrPKfEcw0MscO/R4Yt
         dkWG1S5kLhMio9WCSBiaK7h71h2qPzAM2OSI5wy2x1j/8RpT0Gk7tyM0g+MHsQ2qUq
         7fVK+kPfzPM92kIGnZJ+/lSVEEHLjOcx0i7GFx8s=
Date:   Fri, 30 Nov 2018 12:21:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Carmeli Tamir <carmeli.tamir@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Parenthesis fix and temp vars
Message-ID: <20181130112109.GA14718@kroah.com>
References: <1543274351-25762-1-git-send-email-sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543274351-25762-1-git-send-email-sicilia.cristian@gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 12:19:07AM +0100, Cristian Sicilia wrote:
> In the first patch there is a fix of some parenthesis that terminate
> on end of line and some parameters that are not aligned with
> previous parenthesis.
> 
> The second patch is a proposal that avoid the long line refactoring
> code and using a temporary parameter that will be passed to the
> function on next line.

Note, please, in the future put "staging:" in your 0/X emails so they
sort properly in my inbox and it doesn't look odd...

thanks,

greg k-h
