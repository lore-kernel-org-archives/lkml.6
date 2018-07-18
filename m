Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66C42075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Px5+n1MT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkA1lHtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66C42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbeGRD7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:59:04 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59559 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731232AbeGRD7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:59:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 07A87309;
        Tue, 17 Jul 2018 23:23:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 17 Jul 2018 23:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8h1bS4V2L6/I5lGwoqn/GmHND8IFZVlcPpckMLyVDZE=; b=Px5+n1MT
        M3HEP/XP0GkIxswXibd8s9PTjXnRf0DQnfjrjf+X+2lvlWIwvROfNC13cbkYPAQb
        +JUZLsxDQJNQCv5qE+G15EmOyrvyO8dlRyq69+yNDieOaCm8n6efvFPl0hyUu8MA
        /aP6EWX/Ati+Ps6tlZ7HMo7agpjuQH1mD0Apd9C9FytPLH5yd+UYGDtE9KDCgQuv
        6TLHshRLCk/ZXqrlwkENcVFYlDxiolSCXzeOmp7PUcdHYNaFI3GnGiUnYyYf0Xka
        K1fesMrgdt8mpKAzWsKsIHf2uAas3KGOksNVdOZ3NQkpR6finCJnKVQa4ZZFfqfH
        nnRaPoW53RZBcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=8h1bS4V2L6/I5lGwoqn/GmHND8IFZ
        VlcPpckMLyVDZE=; b=HkA1lHtcE6axv5BUAuafc0FkQu197RTVUjewlAmMBlJ6O
        Vx6hTAPOCdtZ85F7PUD1u0UP+r/heXuVM6o0GOE0ClirdyDRtzPTeDQKYevm+8wW
        XSYeqxmXrBvpjSW7TVAehOsNt2Qxgh0ThVVp/hLsWl0Rfi0B0OvkMTbYYAy/RHDz
        XdW7npDmEwlfof1+x78GImzpcbLrx9GpE+mxiXvj4mLwQQOJMApcM+fzaj8z4Puz
        O9bMzMBNiwWV4TetFsfiyK99lW0B6xUddhzn0E3kQEomP8eNbKTVdLFF75xCED3s
        wKejmGKyuMr7S13MxJrwJyCR4U3BDd3mgTKXqo6nQ==
X-ME-Proxy: <xmx:prJOW8pZIzcQWOHGf9lUkTARyu1Vaa58dYX1JdtvcrTx3thaFetllQ>
    <xmx:prJOWzEqm2KuYdxX0yLXn3YJ_LxB2d1y1zjXq3hVWJok_4zvp-VkTQ>
    <xmx:prJOWw9tCCjlFLqYh9faQY166qCEKOW4DP-xl3rADvBMIxzvSrzd7A>
    <xmx:prJOWwS5939PWBck71G5zvMUE8aFIJW2pEn2gFehC5qebVuBxjOSJw>
    <xmx:prJOW1ppDi_RPY6u3-ST20o-mzVflzsGXCHiqkMvqxOM361Hhbofww>
    <xmx:prJOW0nQodH-biriYcNbZxo4KD401RuRR_sNO3hpIXS7tscf7ZqDwA>
X-ME-Sender: <xms:prJOWx1gMT0kWX9dJxTDL6us_nssybGx9hQ39EhAbfZxC45zL0Ts_A>
Received: from localhost (124-169-0-210.dyn.iinet.net.au [124.169.0.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id B346110255;
        Tue, 17 Jul 2018 23:23:17 -0400 (EDT)
Date:   Wed, 18 Jul 2018 13:23:14 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] docs: networking: Fix indices heading
 indentation
Message-ID: <20180718032314.GC25311@eros>
References: <20180717042906.17308-1-me@tobin.cc>
 <20180717042906.17308-2-me@tobin.cc>
 <1d7a309eb7561b9bb4c31f5deb9a0b63b6263232.camel@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7a309eb7561b9bb4c31f5deb9a0b63b6263232.camel@darmarit.de>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:28:15AM +0200, Markus Heiser wrote:
> Am Dienstag, den 17.07.2018, 14:29 +1000 schrieb Tobin C. Harding:
> > Currently the 'Indices' heading is not aligned with column 0, it should
> > be.
> 
> Hi Tobin, thats not correct. The 'Indices' heading is a part of the 'only'
> block:

Thanks for picking this up Markus.  A little knowledge is dangerous eh
:) Will remove this patch from the set and re-spin.


thanks,
Tobin.
