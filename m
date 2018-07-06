Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB6BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B589823C4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="S5lfALwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B589823C4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeGFRkc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:40:32 -0400
Received: from vern.gendns.com ([206.190.152.46]:49702 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933973AbeGFRk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5kqv4rf1LuXa8jPAJuTHClohnCOJ9UzCJhHBhg9EneE=; b=S5lfALwiZAIl4JWtDes/XthgZy
        GH9IOc4OkNyHWBYO7iPWplY6CYHI5mkXiqmUxeaXCtHzrqVbnYGg2WWKOYLn3lvexP9NKIh23KR/7
        nz6dpllig08ubhucyZZoDr1H8IJCQyJUKFezWSBJGrGYk1/TqfAVH63zlWb0/xAllAiKS/mZ8tEi/
        WP0wlue4aU0Kc0ygQJd0ZyUxxLcoY6WuNeq1kev7XTIMbkLBJ5dOI7OQHAzfyj4sNk2ByI2XDYz2i
        qBZMvMMxOBKbspk4MfOSwJJFu/tvpV1TgmEstf9+vZZAnGAq/SFdYmsZvp2K53DNyuXQP4/GDS/2R
        d/PxxMvA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36638 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fbUiZ-00BN9Q-Rm; Fri, 06 Jul 2018 13:40:28 -0400
Subject: Re: [PATCH v3 01/13] clk: davinci: psc-da850: remove the
 'davinci_nand.0" lookup
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <20180628095748.4462-2-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <23f1a1fb-689a-3120-6ae4-d91c76698401@lechnology.com>
Date:   Fri, 6 Jul 2018 12:40:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628095748.4462-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/2018 04:57 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Since commit a8e3923ab571 ("mtd: rawnand: davinci: don't acquire and
> enable clock") we no longer acquire the aemif clock from the davinci
> nand driver - we only do it from the ti-aemif driver. Remove the nand
> entry from the psc lookup table.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-davinci-4.19.

Thanks.

