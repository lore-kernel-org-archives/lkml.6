Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98503C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551B020870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnqbg2m2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551B020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeJ3P0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeJ3P0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:26:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2EEA20870;
        Tue, 30 Oct 2018 06:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540881244;
        bh=j9BkGSSQzipUrUT5eBSTiIe8ddg+ZiftYzjm7+alrmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vnqbg2m2Ns7Y6/z3lPyTehBmcqjhlW3sCzw2Q1KRqEDlbdzH6nJXh+a2TNiTHlinF
         AHeEy4HU/wIloO4MK/D2h7JPIVSoMb6mCFnwcTuOUX1sFpjVbNjHeQcQjGgn0xpCNH
         zurJVfjoIXI3Wy55b5QuG0AudxQtnd4tLH3E7ybM=
Date:   Tue, 30 Oct 2018 07:34:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] kernel/SRCU: Fix ctags
Message-ID: <20181030063426.GB26627@kroah.com>
References: <20181029200920.28901-1-semen.protsenko@linaro.org>
 <CAKaJLVsgFABhXx-MeOinV0obS9DBt7CsQ-TvDhgf0yGCTsd+rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKaJLVsgFABhXx-MeOinV0obS9DBt7CsQ-TvDhgf0yGCTsd+rA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:11:36PM +0200, Sam Protsenko wrote:
> Hi Greg,
> 
> On Mon, Oct 29, 2018 at 10:09 PM, Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> > ctags indexing ("make tags" command) throws this warning:
> >
> >     ctags: Warning: include/linux/notifier.h:125:
> >     null expansion of name pattern "\1"
> >
> > This is the result of DEFINE_PER_CPU() macro exapansion. Fix that by
> > getting rid of line break.
> >
> > Similar fix was already done in commit 25528213fe9f ("tags: Fix
> > DEFINE_PER_CPU expansions"), but this one probably wasn't noticed.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> 
> This one was sent some time ago, but there wasn't any response. Can
> you please review it and merge if applicable?

As before, why ask me?

thanks,

greg k-h
