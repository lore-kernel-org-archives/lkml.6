Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE71C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FAE20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="VdgxIfo8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xha4IkyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FAE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbeGYXj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:39:57 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50663 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731259AbeGYXj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:39:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BDFCF2CC;
        Wed, 25 Jul 2018 18:26:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 Jul 2018 18:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+lMdV8H3tQ7auYXMW9MELMiLoDZDBwTyRcMpBamdNYs=; b=VdgxIfo8
        hl8wZ3awmlTgdwQUDfGg8F5WF58YtWe6KQoKWolKmr+AeRI3RSWeGi9hivb17lJ5
        +QsZUwvomGIUlaRiSz0elNmnqWnzZoeoi6c16VNOR+FmHVzKi02nhgiJo7USVqFE
        YSzqNmt6vmWyVADqzZ+ScxsXkZPaYlQw6PL8oKRnZc9Jo1ZVnWggnch83WxyTe84
        V3w3xfNWlkuuybpayZf57Bh6LcPfkDpXiv7UbTciV9bWQv4ncNev2p9xgRrfyROx
        UqlSiV9A3/oKzuh7li0GmBg6Y2Hj9pQXfQjpcKrrh32xDCbVH2d4gScnqKTKYWPH
        v5F8jh9G2qKopw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=+lMdV8H3tQ7auYXMW9MELMiLoDZDB
        wTyRcMpBamdNYs=; b=Xha4IkyRbWY3i7q64AJ4CxGcgFGXMFSuF41pvPH98Sn/8
        DkSJzTNrl00FdTbXAjK63lcF7P1vwTa82lmnR2k1Ds9HQhPEGzRiHl9NontCXJom
        YLxf3qR1iPswnYpyW00Y1l71BEN0MRYKZx/WOhPWje4SXOnOajnIydVjGuFL1t20
        H17w8y2mgQRLlxi46zQRN6a5WVFDUKXetgQ4+Yz8scYLb/gFPLpQ5G7AGO5rkWim
        j15nrLHA7Z7dW34Fzo02WxrZHNppSxEwKOsC8CBOEjNkFYmifBZaRhBbPXd2IkdE
        qFReUVuQ+ezKs4RanpOHl+GL8VdrowG5W3QXuV19g==
X-ME-Proxy: <xmx:AvlYW7NGVcsptIPrKp4eX3xv_qowu00wcppFRyD6f4bIQ720SkCrPQ>
    <xmx:AvlYWzg4Gh1FK1zG_T0dXwFGGgGpPJBdzMkeG0wkhCoaQTSP-LbSzw>
    <xmx:AvlYWzxR4e0HMWObk6G2K_qaJElq5_y8DJNioOruHbCPvLRvd9Fncw>
    <xmx:AvlYW4qKCkpDM-gpy_ZrTaojwb0muylMKRy8nNzrhkoDtTM4zUkaeQ>
    <xmx:AvlYWy8mGwz9xCOlA5Jlxg-AX0o8BJZphiIHnwkNw67QdsW8KwJyow>
    <xmx:A_lYWwPNg4DTcVpClY33K5Q86bep7esHt9EzuA2qUBWikpNgK5ZXiQ>
X-ME-Sender: <xms:AvlYW-ftLBQvV-DeKskblLm86bUS5E4waC18bmxsQ2CTz8UPwxg2bQ>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE36CE435C;
        Wed, 25 Jul 2018 18:26:09 -0400 (EDT)
Date:   Thu, 26 Jul 2018 08:26:06 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Edward Cree <ecree@solarflare.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] docs: Add rest label
 the_canonical_path_format
Message-ID: <20180725222606.GC6067@eros>
References: <20180725025005.14332-1-me@tobin.cc>
 <20180725025005.14332-2-me@tobin.cc>
 <010bd587-6e4d-549e-e613-cb785f614463@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010bd587-6e4d-549e-e613-cb785f614463@solarflare.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 03:36:55PM +0100, Edward Cree wrote:
> On 25/07/18 03:50, Tobin C. Harding wrote:
> > In preparation to convert Documentation/network/netdev-FAQ.rst to
> > restructured text format we would like to be able to reference 'the
> > canonical patch format' section.
> >
> > Add rest label: 'the_canonical_path_format'.
> Here and in the Subject, 'patch' is typoed as 'path'.


Thanks for the review Edward, will fix for next spin.


	Tobin
