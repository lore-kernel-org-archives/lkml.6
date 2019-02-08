Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43599C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E2221916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wxLlntPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBHAaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:30:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37111 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBHAaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:30:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so823286pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7S52tSANvStNoXW0WQ36+UsE+KrxcVitS5RILjsG2Rs=;
        b=wxLlntPqF3hw5HcVUT4Uo8fC0zp8kVBeWdsXIK8VgDh0wHsBNx1SL+W2ZcrFugtQwj
         34dEwKPa5aGl7JeQz4Zr3e1KeeQoKS4PsdyRxPa5F1b6fFW3hez99X9GftDbqDO44udW
         EeN13mmEb6/rplIGjSCTMzdFOS7McaHduPfgKOW0r4zY1Oc+RVaFHgCVUnhJCl9XjErQ
         UAZw2LoS9xN1z7U/RcQKb4DJDWo/BITDoELtwXbnvwOBfqKDA7rJ46FL8OG6IZ8BOPlh
         g8iV1j2Bmqhn6FznMKS1Xe4unyYrVF+6gAnvT7GRTsbkV0nOUAB2dphhEjAp0+7w3fPu
         T8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7S52tSANvStNoXW0WQ36+UsE+KrxcVitS5RILjsG2Rs=;
        b=ZCc2SgmZ6gf4l93Zfto1htetpYilF6R7fpUgE1YYzHl/1rQrvoZFDKtyQL14yn8vX5
         isaaCckhDMI0UQCv7FMm0NsI05H1QWDP7Ylku97QhT84frbNHtkd4KRMvRd9CE5pIo80
         imROGPvPZYF5q+ii1p3MmSHuw1enApuxiaPO6+keWjJ+J3AptYEn10UHjFGNtgDdlye0
         gjqgXT63pAV0aAlZDvJOlHRo8F1PDGWw5Cti8yW71VnTWdZStQAES+o0t/oqlTVAZsZ5
         1CTsJpGyc1vIzJinzbUVGXdtv+AyzXECGRxkF5qy0ell8Y1LDKYEjaXqiKhK+2WSR6sH
         FfMw==
X-Gm-Message-State: AHQUAuZD0EPQ8sDRkLyCNOYv7KuxiY0wvty2pAUWcURgPRRbASmQUkM2
        1x5FcR9hSOyijOX9L1KsDBR2lA==
X-Google-Smtp-Source: AHgI3Iacn7cfZS8n6FK+FM9vJoGuj1NVYzdEqSF1aCfM0VmNR1kr4OSXJqQlxLJjIhjbrVoVWXeNUg==
X-Received: by 2002:a63:2c8c:: with SMTP id s134mr16359331pgs.269.1549585833487;
        Thu, 07 Feb 2019 16:30:33 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id a13sm321291pgq.65.2019.02.07.16.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:30:32 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: amlogic: canvas: Fix meson_canvas_get when probe failed
In-Reply-To: <CAMO6nawKrH3d2X=TikdJy8yjiPyuJJRnpaBjyfPYuRx3d=7vVA@mail.gmail.com>
References: <20190204094937.22763-1-narmstrong@baylibre.com> <CAMO6nawKrH3d2X=TikdJy8yjiPyuJJRnpaBjyfPYuRx3d=7vVA@mail.gmail.com>
Date:   Thu, 07 Feb 2019 16:30:31 -0800
Message-ID: <7h4l9fglzs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Jourdan <mjourdan@baylibre.com> writes:

> On Mon, Feb 4, 2019 at 10:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> When probe fails, a platforn_device is still associated to the node,
>> but dev_get_drvdata() returns NULL.
>>
>> Handle this case by returning a consistent error.
>>
>> Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/soc/amlogic/meson-canvas.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> This fix depends on "soc: amlogic: add missing of_node_put()" at [1]
>>
>> [1] https://patchwork.kernel.org/patch/10794545/
>>
>> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
>> index 87a6c6e23591..151aa84bc593 100644
>> --- a/drivers/soc/amlogic/meson-canvas.c
>> +++ b/drivers/soc/amlogic/meson-canvas.c
>> @@ -51,6 +51,7 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
>>  {
>>         struct device_node *canvas_node;
>>         struct platform_device *canvas_pdev;
>> +       struct meson_canvas *canvas;
>>
>>         canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
>>         if (!canvas_node)
>> @@ -63,7 +64,17 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
>>         }
>>
>>         of_node_put(canvas_node);
>> -       return dev_get_drvdata(&canvas_pdev->dev);
>> +
>> +       /*
>> +        * If priv is NULL, it's probably because the canvas hasn't
>> +        * properly initialized. Bait out with -EINVAL because, in the
>
> Bait -> Bail ?

Fixed this up locally.

[...]

> Thanks for the patch, I missed the fact that a driver could have a
> pdev yet with a failed probe.
>
> Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>

Queud for v5.1 with Maxime's tag. (branch: v5.1/drivers)

Kevin
