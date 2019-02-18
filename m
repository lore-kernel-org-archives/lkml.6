Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3080EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FEA2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550477825;
	bh=LNkz2UKqHHCt5QsKpPnteju1JVjgkSyYP0LLCh8NtG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=brFXGM1bOemsqSxPNWyCjFdagERf7a7I4uorcbampA6OAuCKLKnGJSaOYUsjJF8kk
	 I6+yLdtEpEubEZv3Im1BBrdCLl6ZUaXrY+2GZfrUxlceO6AWTND1jEobxOA/Rk8pka
	 jHTGS+5bleYdpMxdm0mURU1j+PnGJlp3SIa1pJag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfBRIRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:17:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBRIRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:17:03 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16566218D3;
        Mon, 18 Feb 2019 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550477823;
        bh=LNkz2UKqHHCt5QsKpPnteju1JVjgkSyYP0LLCh8NtG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XrfyDc3DPOJuUlVqop6jVvwDZ8UjW9b8GG041awpZhGXKekFj1DMuYuKkUAzq+iZo
         nNhnt7ao8/0RopY8FvaVU8Tk9oo508C9GuLQ3U7keVxtiITf/kJ6oNcydIVUiFZlGF
         M+XlzXjp604XNni45wrAxs5rP0+B+a6S3RpnFL+g=
Received: by mail-lj1-f176.google.com with SMTP id j13-v6so13575168ljc.2;
        Mon, 18 Feb 2019 00:17:03 -0800 (PST)
X-Gm-Message-State: AHQUAuabFPf4G9Bjke8ZGZmRaE83Mxyt/4h00A8NqUxoIhYhpFbsV022
        sEoBFdKjBWNx1fcTQS9X4HQJPkJMiKMipU5Xq9Y=
X-Google-Smtp-Source: AHgI3Ia+Vr2YC0EWBhzl6zoA9Yw95pwpkRNIHkgPbpZL0rsNBQFo0g3+oX0oW3GkPUJUYCehzpHSeL/BqqqUo7KXgyM=
X-Received: by 2002:a2e:5d54:: with SMTP id r81mr12577197ljb.183.1550477821225;
 Mon, 18 Feb 2019 00:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20190216012055.79622-1-weiyongjun1@huawei.com>
In-Reply-To: <20190216012055.79622-1-weiyongjun1@huawei.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Feb 2019 09:16:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc5v_WCtpT5x=1bFBiMCAHtqhns3dcqUEVjnDdDVMA2Og@mail.gmail.com>
Message-ID: <CAJKOXPc5v_WCtpT5x=1bFBiMCAHtqhns3dcqUEVjnDdDVMA2Og@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: samsung: i2s: Fix return value check in i2s_create_secondary_device()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2019 at 02:07, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> In case of error, the function platform_device_register_simple() returns
> ERR_PTR() and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
>
> Fixes: 7196c64c7d0c ("ASoC: samsung: i2s: Restore support for the secondary PCM")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/samsung/i2s.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
