Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AC7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D31262A4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="UxHXMZxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D31262A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932888AbeFYXSd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:18:33 -0400
Received: from vern.gendns.com ([206.190.152.46]:35519 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932235AbeFYXSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G81hSo2v4U4brBxlIMvXfT+XU6RDxZK31J7WXuz0OBc=; b=UxHXMZxD9uLImrC0jcOIhPaCTI
        CKhUJgiQ4P6rr5ZsUUCSzJNAKJS9iVogovHhnInm3YMdvUasT+kMxFIDgbGQBVnnYuf7lxUkuAecI
        ccdakI5Nv8Je2KXiKbkB1fjRRxirDpLL2wL5r6yHvLUlyAqxfW39NdYLTYk9rVSO5jLEaHYmlUWIh
        JTppK6wFL+RzehS69ZUmbTuaUu7RI5SxOrWyIivZkNNpL8fKUyap2VGq+XaB530kA7rnLXh8fmQw1
        zdLe3oHdg0Q+CZM68+Wke3UJQPg0ey5+gZ4LeS6V4n+sSw6LpCF2yfcjFdONRLFLzB4XUuoKBNB+0
        yY+bMASA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60728 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXakf-002Nxd-Vy; Mon, 25 Jun 2018 19:18:30 -0400
Subject: Re: [PATCH] clk: davinci: fix a typo (which leads to build failures)
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
References: <20180625172550.17379-1-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <28163c26-152b-9188-9c13-7a906809e0f1@lechnology.com>
Date:   Mon, 25 Jun 2018 18:18:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625172550.17379-1-brgl@bgdev.pl>
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

On 06/25/2018 12:25 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This should have been DM365, not DM356.
> 
> Fixes: 4eff0bebf4ed5 ("clk: davinci: Fix link errors when not all SoCs are enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/clk/davinci/psc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
> index 6a42529d31a9..cc5614567a70 100644
> --- a/drivers/clk/davinci/psc.h
> +++ b/drivers/clk/davinci/psc.h
> @@ -107,7 +107,7 @@ extern const struct davinci_psc_init_data of_da850_psc1_init_data;
>   #ifdef CONFIG_ARCH_DAVINCI_DM355
>   extern const struct davinci_psc_init_data dm355_psc_init_data;
>   #endif
> -#ifdef CONFIG_ARCH_DAVINCI_DM356
> +#ifdef CONFIG_ARCH_DAVINCI_DM365
>   extern const struct davinci_psc_init_data dm365_psc_init_data;
>   #endif
>   #ifdef CONFIG_ARCH_DAVINCI_DM644x
> 


Applied to https://github.com/dlech/linux/tree/clk-davinci-fixes

Thanks.

