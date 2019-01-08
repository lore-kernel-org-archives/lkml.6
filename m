Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E0C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABF32087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546933457;
	bh=UFcqA0U1hNN++wTzMTG3WHjvimRmRLeh348xL8/3pP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1P7AkzB0IjP6/jM5hxmXpfVaDCCkXTA2HkhVh4Z1hfGe4skT0GxAHb2EltKxtCeJF
	 UqFCDYAA4U58wQE8DlRCEdlZSUQkeZuoFBr+9+e3WV9Hzj2yPc5QyVTng9L35uWL3J
	 62h64FKLnASCBHdESrC/8koWBpoznM7tS2D9gvck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfAHHoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHHoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:44:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB102087E;
        Tue,  8 Jan 2019 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546933455;
        bh=UFcqA0U1hNN++wTzMTG3WHjvimRmRLeh348xL8/3pP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=veKZZ72WScIMaublUf33eucT520bmZ5AOJOkKAOAStOSJ8fJV0DcvxEnwU1pUJsUm
         BL+kQgMiMFVgfdpulVDxZfGTV2Wd+UD3w0j0u3ZQY727Ik9htCYO+N+uB00lRLHVN+
         YbQZlQt2rDcwDp9pgjOdn4UqnvW+2QZ/RmGxbv+M=
Date:   Tue, 8 Jan 2019 08:44:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     sudipm.mukherjee@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH 4.14 002/101] net: core: Fix Spectre v1 vulnerability
Message-ID: <20190108074413.GE2102@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <20190107105330.528127680@linuxfoundation.org>
 <CADVatmOxZngMs8foHj0mOTjC5NhAZvZyxRJXREkEsKvG-6z6Ug@mail.gmail.com>
 <20190107.163626.191499249014206114.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107.163626.191499249014206114.davem@davemloft.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:36:26PM -0800, David Miller wrote:
> From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Date: Mon, 7 Jan 2019 21:13:06 +0000
> 
> > Hi Greg,
> > 
> > On Mon, Jan 7, 2019 at 1:00 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> 4.14-stable review patch.  If anyone has any objections, please let me know.
> >>
> >> ------------------
> >>
> >> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> >>
> >> [ Upstream commit 50d5258634aee2e62832aa086d2fb0de00e72b91 ]
> > 
> > This has been reverted upstream by f2ab95814103 ("net: Revert recent
> > Spectre-v1 patches.")
> 
> Greg please drop this too.
> 
> Thanks Sudip for spotting this.

Now dropped from everywhere, thanks.

greg k-h
