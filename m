Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD5AC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6988C2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BNyqwuBO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FoZQza6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6988C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeKCPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 11:53:04 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:41515 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbeKCPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 11:53:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BABF62938;
        Sat,  3 Nov 2018 02:42:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 03 Nov 2018 02:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Z5buhsz3n6yqnTw5T3hK+p8/Bx5
        /n4IhoptyvyU/Ii8=; b=BNyqwuBOzsr74Wu/++VycOkqDkhBY3b+tuDGr5jp1jO
        pogh2pLHGqvHfpDeayg/D60UbDU0n5nHZ0TYeJSfRy7A12yKSdNsnCn1uPAoMQcP
        G+p9njTc3GA0/t+uxRNR5JqZTtMUiUU2p4UXD4buEwX9GQwLuRXakdIJ1wAVauxo
        GdhCuoIWM4OHRvgwtudJM7L8c2zjdz1NtX1rz2Z3lzGaBjRbB5X6/Lfe5TU5fW7e
        KdvOg4WY0n4bw3aOCJblgjd9QwaXoaYdetSRWzrtw4luaerLBaZPTmQI4xAm8j1D
        YaZMq4ibWogsX+WonOV8VfI1Syvu2HkYuKPaeAqbtVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z5buhs
        z3n6yqnTw5T3hK+p8/Bx5/n4IhoptyvyU/Ii8=; b=FoZQza6NIRKC4MlEuNdt8k
        dt56gN5zd8ND4CEhCoOk99OY+CRI7rCeJCrGZOgNGbb9AcrIYM94uHiyf6Ljwyby
        0CkIRJhsTMdchqu5YL0gKWkz8YIwws5Sy8lmNy57oec2CZrMzQJy2fHkzs7PQER7
        7/SDbGyVADDYnRJ5PYueWVaBFuvGzajxOgjAtkO0LAcW10D3OlVnmoFQxvT97MiA
        jBZykaLOfgN4cqxlD+780B13VcC4i/gbobWPVZj/jHyiGZdXhKT1js9CDwnvUGwJ
        J+qxleLq9zziaBWtxdD7kZxzJmvtG5U+1nyk+lt5kA6fNAE3OI6+EIn6tMwNTS9Q
        ==
X-ME-Sender: <xms:ZkPdW8-3fQoZf1I6XdaODmNJV84E-yExURMDQcii06g8y5OHPg52Dg>
X-ME-Proxy: <xmx:ZkPdW6pv9CuGwcyZKgdtdIvmEbK9n00oMYakcejcCsSMSTowqgY86g>
    <xmx:ZkPdW6cV6jGkxGD81A5csWEPJWp-NrUW-UF7-7Lu10g3fzlrbFF9bg>
    <xmx:ZkPdW-VfGG-Fikm5Fw8P6qLx4g5mE64MGPJzeiZQ8o7vNfS3PRwvRg>
    <xmx:ZkPdW9MbfgTz4P9QxFBNuB2KXS6TwMDF07qtboKCmz0uBDBzucGaXA>
    <xmx:ZkPdW2o8cVn1es_Z-TZJ8Z8GO77n59LkRoTOZ0a2WY9S62eAZ7l0YA>
    <xmx:ZkPdW2a2LKikni_orGKfZIzpKRxY1yBj43HKiouh1p9doHc4lhzHzw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5993E40E1;
        Sat,  3 Nov 2018 02:42:45 -0400 (EDT)
Date:   Sat, 3 Nov 2018 07:42:43 +0100
From:   Greg KH <greg@kroah.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: /proc/iomem: only expose physical resource addresses to
 privileged users
Message-ID: <20181103064243.GA1517@kroah.com>
References: <20181102191028.226989-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102191028.226989-1-salyzyn@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:08:59PM -0700, Mark Salyzyn wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> commit 51d7b120418e99d6b3bf8df9eb3cc31e8171dee4 upstream ported to
> 3.18.y

Now queued up, thanks.

greg k-h
