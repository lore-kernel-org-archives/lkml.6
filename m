Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3BFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D15217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549392177;
	bh=/uZJsZQOx7NxlXrfevR1SSxhR1PBFj8ekns+vQF1bWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D6HTfFjlCr8PLcagNL1MSqeq8ZNXfAb5GdzaSDrDN1fwqSV8wTfUpo4Iv4YicG/Ym
	 H6XveU2bzSYz/b4i/HzyoJw73m4/fGWTOhtPho+t+XstcSo7z45mFe0q9bP+i+vKt9
	 zWMLXSEHaBgTVmcpaxW7TyFmIXpPTUrieUxYDEzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfBESmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfBESmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:42:53 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 598AC217D6;
        Tue,  5 Feb 2019 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549392173;
        bh=/uZJsZQOx7NxlXrfevR1SSxhR1PBFj8ekns+vQF1bWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OF/rOfnQHXkkabNVGbZl8XguQTilDlRL3r+rzFAk9sD+6Xej1xyB8kVZCZm3ea1mP
         fM9bn3s2ARlf2W+ZWvEH81AnYkFZfxosRyQqYYm6/W6M0WuYm9YRUdcVdPVxfOL3hg
         Mn84v07nB0ALX7T3ovToLO8/xNsJjz1xtf3VLdYA=
Date:   Tue, 5 Feb 2019 19:42:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
Message-ID: <20190205184250.GB22198@kroah.com>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:57:11PM +0000, Kees Cook wrote:
> On Mon, Feb 4, 2019 at 10:09 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> >
> > I think there _might_ be potential use-after-free issues on module unload.

There are loads of issues with module unloading, which is why it pretty
much is a "best effort" type of thing.  It never happens automatically
and the only way you can do it is if you have root access, at which
point, there are loads of other things you can do that are much worse :)

thanks,

greg k-h
