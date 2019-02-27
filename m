Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F4FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BD9218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="UR8y/Heu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cQFS62DN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfB0Cz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:55:27 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32821 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbfB0Cz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:55:26 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C66522121;
        Tue, 26 Feb 2019 21:55:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 26 Feb 2019 21:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=b
        4iEysqFL4m300+akQl0IBvgTq9CmzuFiOWX/epovpY=; b=UR8y/HeuBoOmQpree
        HibfwdYqUq4BrRoHDHas3VEHCHzmZwXD1HJUcZi+QbRntgX4ck5Y/63Pw5VewfgF
        07Aq5vWNke0Q0NmBSwYtjOsBP5gd/QuyMSWgl6P49K3oKZCrXi6fyhs5XCdCxfbx
        JGcOyasa/PoNRLLhEwd3/O4t5MVCIOaoST9mnvbzeUdu6ZkZi84gwOr0f95mW/+F
        Txd9ghwY4oCGM2TaOQ+E1vMNNnMru8qSuTHyemmWK11/i80N3d8nTCEb10gFpwzt
        1z7pN6TuwVlyCYojwjB0WJYqX6Z9ySWq47TlL5v90AwR8ZilfRo5GWBALPIekDaz
        KdkAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=b4iEysqFL4m300+akQl0IBvgTq9CmzuFiOWX/epov
        pY=; b=cQFS62DNxk9Jss56Z7KP/ZLJsKEFS4/zmZvn5uCm5v6lpRCn/qZcBSUL5
        zhV6yEVpJ1pm0uQD3QDcZjzxTJ7E0AaLT3NsuWhXoT954GiJRRU/bOwd62gWI3H6
        lI8Uv33ul6bSlTGj1mPFjYHcWtbRvj5ddX88OD+oS4kyLKBrEiYw8bKcN0hJbVLy
        bGCuVJtLWzJ6VMb5ibxCAc+oTWuIFzCGOW/Ep2TW6io1Dj1E4exsx07MT4URHO4e
        7LCVDv3Q8eG6EdIeqK5WobDyieQgqYjac1vg36HDuCADm0eWqaF8aonCpdtmTadu
        K63LP3a748YMvwA6Psr2ZSXI5lj1w==
X-ME-Sender: <xms:HPx1XAxdrjRwX1HFreZKpljY6j5yoLMQywT1v884EQx3ocxRCg47rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvddtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:HPx1XOngO75guKkVmt3_nPNT-t2PP4vzuUBUlZUtfnTjBWP48cg-6g>
    <xmx:HPx1XKiSPHkTm1PadTYN6ZtXRflkUR-KXL0JZsYnn7ydozbz6EBFgA>
    <xmx:HPx1XJd9Xbmf4fKL0veJW0jTMF3uxzCe8JDG345p1-7XE4yyszMlww>
    <xmx:Hfx1XJpSqLT0iT3fDaRjDFq8ksD7AJD8bWQ8aiTkJWbvzBzdI562-A>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 545C9E419A;
        Tue, 26 Feb 2019 21:55:24 -0500 (EST)
Subject: Re: [PATCH 02/18] clocksource/drivers/arch_timer: Workaround for
 Allwinner A64 timer instability
To:     Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190223130707.16704-2-daniel.lezcano@linaro.org>
 <20190226212356.C6B68218A2@mail.kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <49678bcd-7af3-fe05-356d-f8ed90596139@sholland.org>
Date:   Tue, 26 Feb 2019 20:55:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190226212356.C6B68218A2@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/19 15:23, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v4.20.12, v4.19.25, v4.14.103, v4.9.160, v4.4.176, v3.18.136.
> 
<snip/>
> 
> How should we proceed with this patch?

This patch is actually only applicable to 4.14.y and newer. It doesn't apply
cleanly because fa8d815fac96 was not backported to 4.14 or 4.19. fa8d815fac96 is
not a dependency, so the extra part of the hunk just needs to be removed.
(Should I send a rebased version somewhere?)

> --
> Thanks,
> Sasha

Cheers,
Samuel
