Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED60120811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="aXbPNi7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BU41mqPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED60120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLNG7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:59:05 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33581 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbeLNG7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:59:05 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A79A911F3;
        Fri, 14 Dec 2018 01:59:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Dec 2018 01:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=YiDdmpfy7hh2OJ6S4Mf3A/mOuKa
        sxc/Vz3jyFIl9kQo=; b=aXbPNi7+7grEEdKB/BwrObNiEWmW7h/dFXn4vkzD8pc
        L/EtIRWB5ViRjzHtrNBcobgS1RuM8NAIjga6aQEx11atS3vd3iYrAmQzx1IsPOW+
        Ws50fosR3BuklB3VRW/m1jLicb+w/BeBG/Hy7OMjS9NqBzv6+4NLIa44uQoaPWaj
        9qAHPj0nyLwPbgs+oEUylWKvboW5idBf/ahoXFjmNy/xmlXEg5pD65jLEeRCVCxp
        0780M8OAhlbvhcMSj6U1HtuMQScCwvRKRuJhUbI+0n7m0j5o7an0JhDNU/u8Mv84
        SjljJTUkbiPNk8xnvZ968m4tcCqq1CFTK/B/OHxfC0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YiDdmp
        fy7hh2OJ6S4Mf3A/mOuKasxc/Vz3jyFIl9kQo=; b=BU41mqPc+J+zPFbS5qoguK
        sA+tN5heYevpgrJaPpdDaLUs92h/h4ySrCjNgb1JtbeftWq5smll/gKVjWwE2fMl
        FcWQO06FoqQiY3Cbhe8NKFVBnb3TgiUoyXmUWLY07CMmUkEmjaEd6xAyecGlx0I8
        TVU4GniL2T8KcLhf47ZG1kqdclQLzFh1mY9s7wX+VVUXKoWz0QqZznFNRrY1Door
        eSGOoJ0Uz/imi0m1IGEYte6RbjU4d9DTstRfHzACmvbDDn+LUiQMuS5RhA5AZIAN
        uFsJ2GkAtuu93hqPOunAzPqCK2f2/1EEW0LAmAx6irstuLx1xXc4izppnVDwSzaA
        ==
X-ME-Sender: <xms:tlQTXHowRyIxqk6BwuX1A-G0h5p_PzPLNmQauzCNQ_Y17mmzzaNIGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudehfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukf
    hfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghes
    khhrohgrhhdrtghomheqnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppe
    ekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehk
    rhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:tlQTXHq3V-MQAbT1Ye30e19XXzS_Qevb5N9WdOVBlS5lZHs0x2aoGA>
    <xmx:tlQTXPAjaR-oYLKfSiZs9kS_VTEVROldP20GjCNjsC8oJyC5S2gpCA>
    <xmx:tlQTXNv9v9k3cLGQvDVXfvTZyJLi6iLPbk2Oo6MyFehi45B0pUH1QQ>
    <xmx:t1QTXEa321yP971qn3JGVCMaRkPNXdFHd57eBPe-0razTQY3aZqTqA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 195CDE405D;
        Fri, 14 Dec 2018 01:59:01 -0500 (EST)
Date:   Fri, 14 Dec 2018 07:59:00 +0100
From:   Greg KH <greg@kroah.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: Specify I2S assigned clocks in proper
 node
Message-ID: <20181214065900.GA22664@kroah.com>
References: <CGME20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab@epcas2p2.samsung.com>
 <20181212175744.8287-1-s.nawrocki@samsung.com>
 <20181213205656.GA799@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213205656.GA799@kozik-lap>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:56:56PM +0100, Krzysztof Kozlowski wrote:
> On Wed, Dec 12, 2018 at 06:57:44PM +0100, Sylwester Nawrocki wrote:
> > The assigned parent clocks should be normally specified in the consumer
> > device's DT node, this ensures respective driver always sees correct clock
> > settings when required.
> > 
> > This patch fixes regression in audio subsystem on Odroid XU3/XU4 boards
> > that appeared after commits:
> > 
> > 'commit 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")'
> > 'commit 995e73e55f46 ("ASoC: samsung: i2s: Fix rclk_srcrate handling")'
> > 'commit 48279c53fd1d ("ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access")'
> > 
> > Without this patch the driver gets wrong clock as the I2S function (op_clk)
> > clock in probe() and effectively the clock which is finally assigned from DT
> > is not being enabled/disabled in the runtime resume/suspend ops.
> > 
> > Without the above listed commits the EXYNOS_I2S_BUS clock was always set
> > as parent of CLK_I2S_RCLK_SRC regardless of DT settings so there was no issue
> > with not enabled EXYNOS_SCLK_I2S.
> > 
> > Cc: stable@vger.kernel.org # v4.17+
> 
> I gues your format would work (got recognized by stable scripts) but
> strictly speaking format is different:
> 
> 	Cc: <stable@vger.kernel.org> # 4.17.x
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/stable-kernel-rules.rst#L127

Either works just fine, my scripts have to be a bit flexible due to all
of the odd ways people like to tag things here...

thanks,

greg k-h
