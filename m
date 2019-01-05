Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F7C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A342821871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 01:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dqX38+5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjsUCsoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfAEBVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 20:21:18 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52469 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfAEBVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 20:21:18 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E03F24B7D;
        Fri,  4 Jan 2019 20:21:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 04 Jan 2019 20:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=a
        DJ2tzE6wzKUQvm3MaX3vz9Ifn5TgUO8QFv63CM9GE8=; b=dqX38+5czcjpjeCP8
        LL13rO5p5Z3izgjrVnx0e4mO8J7G4+73FIOm57+UEPcwxR0qjrkqHezBOWD13TYQ
        rMFK3JKVKVkorFWPLE6io36Gu1genXby92OGSawT0hc3ViRPaxCd7674OXmEWuNs
        MSzNXiEWrW/ad0b8mbmsv/xKlOqh2yVm2yrLL2i99WuKwVLO4SwCronhmYhch8Ga
        P2aqUNJzgO1MTjCjsor7IcQYK6NRDFW1Zkvdoid0jKnVSyEg/842CO8dSuT9YzXV
        SGrVH/JtI4avK7/R7bqrEI4V5RdeZzwk+VMLOIIQpUIwM0UXn7O6l/XPaC17+U+Z
        Ry3Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=aDJ2tzE6wzKUQvm3MaX3vz9Ifn5TgUO8QFv63CM9G
        E8=; b=jjsUCsoG0yGX+5TCCeEPXmdkh+yIoIDdGq/qlYYBT4QKi1q+Nqtgi/LMB
        eIHQF6fVGQj1Zgm+tw4U7VI1KCrHbEoRsjjhtNfZwz30CmYAqCkoSo7ohDCG6W5G
        Ueh6RzDisk2IibUelxoh3aPtRa7KJz3xIGsNIqmAF8JOf52LStaJnpE5KmF9vAwO
        vMfxoGU7j7R+vz+KF7xCJywzA4WQqOReB7c/dBcGFzCdqN/ASXFeTLKAx7yRkUU3
        DmGNBM3WvG8hk+SyiTqMQbsI+RPU9knAt6M7kLYvRRQI0553aZNQH8wkjcLmiCES
        uXddRb5c/EP59R4CuIYy4YdXQkNIA==
X-ME-Sender: <xms:jAYwXJLyg1b7M7fEGTM839ttaIYn_weF9H7fBA5fahIrll_YW9WRXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrvddvgdefheculddtuddrgedtkedrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpedflfgrshhonhcuvedrucghvghllhhsfdcuoehjrghsohhn
    tgifvghllhhssehfrghsthhmrghilhdrtghomheqnecukfhppedujeegrdduvdejrdduje
    eirdehheenucfrrghrrghmpehmrghilhhfrhhomhepjhgrshhonhgtfigvlhhlshesfhgr
    shhtmhgrihhlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:jAYwXO-7IBCcKoSwrzGLlsJtOcD9YYexlHyJTTMzfjqJ9_GnoAG6hw>
    <xmx:jAYwXAiqxc70VGlyE35vwaapWmieLMzVsMBjGyTlbNt0yDhvKDcqmw>
    <xmx:jAYwXFy_se7HQoGUZCTDNF_3c9wtm35KnVlB7VvG7sjUOv834zvKYQ>
    <xmx:jQYwXBAb087pTL_O_JSgFtzNMDVzg_EDk4zOCI0FSlp4U0yd3BxW4w>
Received: from [192.168.0.18] (unknown [174.127.176.55])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B394E4147;
        Fri,  4 Jan 2019 20:21:14 -0500 (EST)
Subject: Re: ZDNet article on GPL is wrong and misleading. PJ (paralegal) does
 not fully understand the law she's spoke about.
To:     vnsndalce@memeware.net, linux-kernel@vger.kernel.org,
        gentoo-user@lists.gentoo.org, ubuntu-users@lists.ubuntu.com,
        debian-user@lists.debian.org
Cc:     freebsd-women@freebsd.org, esr@thyrsus.com, misc@openbsd.org,
        freebsd-chat@freebsd.org, moglen@columbia.edu
References: <5918e2886da009d3a2e962d1c7c8b2da@memeware.net>
From:   "Jason C. Wells" <jasoncwells@fastmail.com>
Message-ID: <58cc5026-2b1f-173e-837e-2e0253b69b6b@fastmail.com>
Date:   Sat, 5 Jan 2019 01:21:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5918e2886da009d3a2e962d1c7c8b2da@memeware.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC trim the freebsd lists. This is not our jam. BTW, cross 
posting was never socially acceptable so please don't.

Suddenly, I feel sorry for Mr. Moglen and Mr. Raymond. I can image 20 
years of this sort of nonsense in your mailboxes. Cheers for all the 
good stuff you've done for FOSS.

Regards,

Jason

