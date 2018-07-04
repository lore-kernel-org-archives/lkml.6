Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D152C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA29223BD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="a5K2uyUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVe8/1pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA29223BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeGDJ0K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:26:10 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43017 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753046AbeGDJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:26:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 14AA024E;
        Wed,  4 Jul 2018 05:26:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 04 Jul 2018 05:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=GRIUWM6gAa/SSWVDMYjCcUJi+j6NxZxXgZ5d80I7nOk=; b=a5K2uyUn
        wsU9UAEFEKyOhpulpVQGFvXPVUT4dsD9xDw4Bi5JuBYvMUl9FPAh6GwbPEmFG024
        DAIsTD8FdhlDRsVPU9WkDMFmi015iNpS0KVJanZTq7NcJPJJasZha8n6FkMNNIqT
        DPgoc3caZ5YBwIKvMsBXsqJZ7UgSJECFYOzHxDgk2lpq/nvM4kLI4rntirD+5WaT
        g/sVTWfC86527BQwftX+IorJNWMzd2CGnRPZkWHC+c30SQmFmxtUwBamDlRPkacT
        OZM804SGX1cvg9FJLK8Bz2C4C261MaVmNXHn9a/qaEoff1njOgfQumZXApp7l3Bg
        p9KVniBHjwvSXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=GRIUWM6gAa/SSWVDMYjCcUJi+j6Nx
        ZxXgZ5d80I7nOk=; b=iVe8/1pdtL+nIIKkLWWJWa8Z16g3n8Ukyjy3MVNJRkQAU
        5CJKyzdOFyJktwKBexuqIw27NJq9VTukrUfgiyMKgBkvM/kGmf3OIRe4vwMWclbx
        n/K0GDgSayiNmW3PnaHobXeX5dW9caT2iyg75ViUFAAXE5BkyaSMWlE2FAUGxNGO
        WyHZORiLGMNimh8kE7HFa+wqne+5q+wxlMWBeFh/darb2E68efU1YYgQaN2kK2AB
        aND118s/7iVVOXH4xBBgVg29Jt8Qm1MQbUHgaWUWrml0dvpbqXfKAuD4t0OFAGNY
        3OBXb5x7dlZGRzr3gFec5dkUeAL/DLy5y/ed1Js4Q==
X-ME-Proxy: <xmx:rpI8W24rx_x6sLgSwZMccFppbVFItMr-2LIIYGEJXqq3onfwQ7K7Fg>
    <xmx:rpI8W9-s0aawZTJgQm8fSclQsHIYEFnRJnz-yAkDUFzXSVWHUOrATw>
    <xmx:rpI8W8CFs5ZRBrCeS5rcxb16gnnYXUPv9TDbTj3Fk5sVF-yK_N1HPA>
    <xmx:rpI8W5pZseGvXa_jODn5jH9BVn0orVvwdufLmPSC-q95e-O83Aobag>
    <xmx:rpI8W2dmcdU8YhCiwIdElF0BDq9uhXnZ3YUKN7fkp4IXY-j9GveKWg>
    <xmx:r5I8W5avuf_-7XTlo0D5XCl6L9JcrsbNlk7Wk1FqUHL72nhgRulBIg>
X-ME-Sender: <xms:rpI8W0dKpfujoSZOU3lX5qIKQ-XdkXrpG1j01THzdvXu0Pm-isC2mw>
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63CE310323;
        Wed,  4 Jul 2018 05:26:06 -0400 (EDT)
Date:   Wed, 4 Jul 2018 11:10:33 +0200
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     manio <manio@skyboo.net>
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH] w1: fix w1_ds2438 documentation
Message-ID: <20180704091033.GA25411@kroah.com>
References: <fc05c438ba7a22719501467e62baed7c@skyboo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc05c438ba7a22719501467e62baed7c@skyboo.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 11:02:00AM +0200, manio wrote:
> Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>

I need a changelog text please.

> ---
>  Documentation/w1/slaves/w1_ds2438 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/w1/slaves/w1_ds2438
> b/Documentation/w1/slaves/w1_ds2438
> index b99f3674c5b4..e64f65a09387 100644
> --- a/Documentation/w1/slaves/w1_ds2438
> +++ b/Documentation/w1/slaves/w1_ds2438
> @@ -60,4 +60,4 @@ vad: general purpose A/D input (VAD)
>  vdd: battery input (VDD)
> 
>  After the voltage conversion the value is returned as decimal ASCII.
> -Note: The value is in mV, so to get a volts the value has to be divided by
> 10.
> +Note: To get a volts the value has to be divided by 100.

This does not look correct at all, are you sure about it?

greg k-h
