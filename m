Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FBCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3350920890
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WntCNCLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3350920890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJHXGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:06:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJHXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PC+WwSlNTXh6sorAga4vNvjL9bI6aa04qUElThqGnkI=; b=WntCNCLGYR+jlgF8N+M/UNB5Z
        dQQPminKKdEG5gmQWF11cZFlKzTfRjJZeRChnkYLwoYHlPE1E6MxLtKnzJi5jdd4+u7Fq5w69lm9u
        tFSemZHzJh0PBA5CjDHaCNHRzmusJNXGPkG3vQ7rMlQSEVI9dIj96SEpcQq2+ez6UvlCuhIldynKh
        SRSF68HVVg0TVUtY8B/bo0QtgiCWDM7d2Wmr6XB/E87E3baxu9nLflKRMMvPYGG0oRGbJqykxtoPH
        R9wiSnIxPKirmiABZONchJDWPra3qH5czk6mj6mVpFuuDH/zJvZWu0kUPcBW6QhfjfoSxDE9CSz93
        JBbHJtgFg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9XrH-0000dd-4t; Mon, 08 Oct 2018 15:54:11 +0000
Subject: Re: [PATCH] video: fbdev: remove redundant 'default n' from Kconfig-s
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <CGME20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449@eucas1p1.samsung.com>
 <20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449~brFqL1l6v1788017880eucas1p1O@eucas1p1.samsung.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <84e7faee-234e-5640-1c25-83f152bc19a9@infradead.org>
Date:   Mon, 8 Oct 2018 08:54:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008154002eucas1p1a15786f9178c9949d99c72cfa81f5449~brFqL1l6v1788017880eucas1p1O@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 8:40 AM, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n

	config FOO
		def_bool n

is a good substitute, especially for non-prompt symbols. (IMHO)

>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/video/fbdev/Kconfig                  |   28 ---------------------------
>  drivers/video/fbdev/mmp/hw/Kconfig           |    1 
>  drivers/video/fbdev/mmp/panel/Kconfig        |    1 
>  drivers/video/fbdev/omap2/omapfb/dss/Kconfig |    7 ------
>  4 files changed, 37 deletions(-)

thanks.
-- 
~Randy
