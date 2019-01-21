Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F95C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43F20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548083425;
	bh=S3rl4NBoVXn2x6OU2Yjr6LxkZzo2VZ5ssJkW7j6T9Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MALypnEgtALBKjHWFCjn6PNbYVBOBEUKdfCX538Mr8M4eDwKTIRIxQAhoRXN0NCA8
	 Anxf+vsnpQ0ga43s0uTddMlQcxV7pkGt+EUN0cNT2IGagd+TE6UjUMmaoxNci4khlw
	 Pi+05DBzocifGYNfsFwkmtDROxb3ZZXGUrfJGNyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfAUPKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbfAUPKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:10:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C93420823;
        Mon, 21 Jan 2019 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548083423;
        bh=S3rl4NBoVXn2x6OU2Yjr6LxkZzo2VZ5ssJkW7j6T9Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3Mupe93pgxu06LdjWmf5BfoAhZIISaLiCwpnZchysjOY8pQMmrLvdsD4PAnjYLS1
         QPMMkxSdgFa5wIgZOq28+WWxW0vLh46vnNiJX1BchkIhanD5FkAEaUIfnckz20n1qW
         Q+7Lieaagop/H2xdtyGn8s4rKCetYPaMpbFQ2uf0=
Date:   Mon, 21 Jan 2019 16:10:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
Message-ID: <20190121151020.GB4717@kroah.com>
References: <CAA85sZs98K62OE6er2ysBSJ2MQC=1xWapCw_tw458Z_K4BjMDA@mail.gmail.com>
 <20190121144657.GA27366@kroah.com>
 <CAA85sZum33M+1NRcfWkua+66CBTxM8ope+hoGASv6mR8NrwPTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZum33M+1NRcfWkua+66CBTxM8ope+hoGASv6mR8NrwPTg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:56:24PM +0100, Ian Kumlien wrote:
> On Mon, Jan 21, 2019 at 3:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 21, 2019 at 03:44:24PM +0100, Ian Kumlien wrote:
> > > Hi,
> > >
> > > IMHO you are missing: 41d1c8839e5f8cb781cc635f12791decee8271b7
> > >
> > > Which should be marked for stable, it fixes:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=202235
> >
> > The networking maintainer handles sending those patches to me.  It
> > wasn't part of the last set of patches, so perhaps it will be in the
> > next one?
> 
> I thought it would be in the next one after it's in the rc but perhaps not...
> 
> I suspected that it could have been a slip up, since:
> https://marc.info/?l=linux-netdev&m=154726015506044&w=2
> 
> And i know that there are people waiting for it ;)

Well, ask David and if he says I can queue it up now, I'll be glad to do
so.

thanks,

greg k-h
