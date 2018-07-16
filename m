Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3629F208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=awxrd.com header.i=@awxrd.com header.b="Y89L5YO4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIAWHItv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3629F208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=awxrd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeGPXvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:51:24 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:38373 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728947AbeGPXvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:51:24 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AA90F235;
        Mon, 16 Jul 2018 19:21:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 16 Jul 2018 19:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awxrd.com; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=nSMQO8AQCYJvw51S3zuB5AFyo8eS+
        ZkpGmjjUxlh0yA=; b=Y89L5YO4qwH9215ZRvr2QI9IJOsmw8aam/hjq7GPpUQSk
        Fy1s+dJaVISofptoCufp5yGxR1A9bL0TJn1xym/nEQZyIWf5hbkJUJdL/Tw3QCAd
        +uVLVy/ZDCrLv9/ahzmObM+NNuMGXxoYUzc8C3HIetuJvv5fTRNKwPphdSPgGXKg
        K6p3kfkVMe5t2IZ3hG+trLZ950hvylu3I/agDOlxpbMVy21A7HupGXMhHgVs0LB6
        8LjcF/xjWZbWAC+uoBpOJ2rFiEM4d6Npag+XAyJQoAbJ2QV99XUsr4P+vKzKJ0TG
        gVJyVEFe5eXRIbm/33DjOjUulq7u5FE3XrN1P5ARQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=nSMQO8
        AQCYJvw51S3zuB5AFyo8eS+ZkpGmjjUxlh0yA=; b=jIAWHItvsbJkD77MVsbgNR
        YqufePbpz+mg/HzPB3epv/6GqxHL4HSVMZiWg4EOsZZ1MXxBjp4xW7Px3R3uxK6N
        NN1EjYUyVokoqiqsElCySfrZfSYXuVcyaxWovGxcTzCsIBqKpWbmo012fg+Y1ydW
        Rs+wTCNRAeZtSax2cXbyb5lvRu73P37ysvAmb25OIHYOnKiF9edFhdJM6YtOW4+C
        gbulro8zZHlQ6L5Z4rGknXh/kJPPJKrVVTlwnWa5ATg/kqi34t0yzXJivlFDg0Ih
        qjBOvkatyE/PBKeZ+FEDLaSyUr2m48b1/+az9Q83zr+j5yntgYnjkPZ/vrpEzF/A
        ==
X-ME-Proxy: <xmx:iShNWx3KFw7athZJyYz8FICxXZ5vbki5wfsLudENXhBytV31dy3IJQ>
    <xmx:iShNW6UgQdccf0mvLw-jU7cgjRl5ILrrti5NtheXR-fJPPTGMCf6FA>
    <xmx:iShNW0IAb0P7-2CAMkDvfmDxbdK4_3lggDnDOSUcNj6I6Lk2k3XnfA>
    <xmx:iShNW03WBXgH1q15z03MZPMcSnaj9T2fXZLFpM9OjbMTKKHzhV_oqg>
    <xmx:iShNWy5BtvUKUkFNND1Lu1Ve3M7XpPWD8S8BGLLaW-SHDIWBL67a-Q>
    <xmx:iShNW27HPNPYYTFA6IKMn-RoNl_p0jEWgwW84KVj4DLnc-UdMy8pfw>
X-ME-Sender: <xms:iShNWw_tFGWCa1Rycksd-HwvHTNfj5u3687KDeSuuc8tW_9zIDSW6A>
Received: from allworx.com (unknown [24.213.148.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F24F10266;
        Mon, 16 Jul 2018 19:21:44 -0400 (EDT)
Date:   Mon, 16 Jul 2018 19:21:41 -0400
From:   David Rivshin <drivshin@awxrd.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     tony@atomide.com, daniel.lezcano@linaro.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com
Subject: Re: [RFC PATCH 0/4] Fix dmtimer parent clock setup
Message-ID: <20180716192141.28269517.drivshin@awxrd.com>
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Organization: Allworx
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 22:38:58 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> With the move to clocksource, the omap_dm_timer_of_set_source() broke
> because the "fclk" clock is now defined in the DT.
> The omap_dm_timer_of_set_source() was using the first clock declared in the
> timer node, but now this clock must be named as "src" and clk_get() use
> "src" as clock name to permit specifiying the parent clock of the timer "fclk".
> 
> The 3 first patches adds the "fck" clocks to all timer nodes of SoCs using
> the Clock Framework to pass this clock to the dmtimer driver.
> 
> Adam, David, can you check if this solves the issue reported at [1] ?

Thanks! Works on my AM335x board.
Patches 1 and 4:
 Tested-by: David Rivshin <drivshin@allworx.com>

If I might suggest also:
 Fixes: df54bfc5502a ("clk: ti: am33xx: add clkctrl clock data")
 Cc: <stable@vger.kernel.org> # 4.16+


> 
> [1] https://www.spinics.net/lists/linux-clk/msg27638.html
> 
> Neil Armstrong (4):
>   ARM: dts: am33xx: Add all fck timer clocks
>   ARM: dts: am4372: Add all fck timer clocks
>   ARM: dts: dm816x: Add all fck timer clocks
>   timer-ti-dm: Fix omap_dm_timer_of_set_source()
> 
>  arch/arm/boot/dts/am33xx.dtsi     | 10 ++++++++++
>  arch/arm/boot/dts/am4372.dtsi     | 18 ++++++++++++++++++
>  arch/arm/boot/dts/dm816x.dtsi     | 10 ++++++++++
>  drivers/clocksource/timer-ti-dm.c |  2 +-
>  4 files changed, 39 insertions(+), 1 deletion(-)
> 

