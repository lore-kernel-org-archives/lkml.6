Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D4EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6630521721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169254;
	bh=HJZhPDbYJqMS4nNQEXqjZxg5xuXEMO4YuuHVnKrEN34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d9VxjZ0LwfED+5RExoWDUwM3vkASq7931QS/d443BnO54PgXuZrGRSnNVHPGvrH/x
	 Nwb+WIe8lZA2ctI7eEw+YfzmRdnlrTwNstmx/xyoFXiRjXBGLvEqYIP+w/C2HTixfg
	 vQ6Cp3Xdzt6+VfIFEJC3GW65exVcBIZ6NkIK0Jzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfAVPAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:00:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfAVPAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:00:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04CB20879;
        Tue, 22 Jan 2019 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169251;
        bh=HJZhPDbYJqMS4nNQEXqjZxg5xuXEMO4YuuHVnKrEN34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2KnJ3lUC2XZRAlej4KHBaC/einrcStzo7CMYurCtAeovVfHhtI9vh8XDw/TxQNRh
         MdDgMVk7TWbmwfP3iZ9HUv6TPfrYt2n1Ss90m0IAeIv2w84XH/P78tKWzsthPOw+QP
         v7ZRd3A9Oo7Ft7eStSUxwiZKBrFmAEUNjF7XGVlo=
Date:   Tue, 22 Jan 2019 16:00:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v13 0/8] Introduce on-chip interconnect API
Message-ID: <20190122150048.GA11466@kroah.com>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
 <20190122124204.GA26969@kroah.com>
 <2ac9b994-ecbf-05fd-5c01-7ecd0089c744@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac9b994-ecbf-05fd-5c01-7ecd0089c744@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:45:20PM +0200, Georgi Djakov wrote:
> On 1/22/19 14:42, Greg KH wrote:
> > On Wed, Jan 16, 2019 at 06:10:55PM +0200, Georgi Djakov wrote:
> [..]
> > 
> > All now queued up, thanks.
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for considering these patches! Actually i have a branch named
> icc-next [1] which is pulled into linux-next. I will drop these same
> patches to avoid conflicts.
> 
> If all is well, i was wondering how to proceed with follow-up patches.
> Some consumers of this API are already floating on the lists. How about
> sending you a pull request before the merge window with the collected
> patches?

Sure, that works, or you can just send them as patches, either works for
me.

greg k-h
