Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2B7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB0B206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJyy0pSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB0B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeH2Maa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:30:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35484 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Maa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:30:30 -0400
Received: by mail-it0-f67.google.com with SMTP id 139-v6so6213596itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/53V2W3Xp+jTS+AAHMLGENe+ZK+W0DZYh7wAQpA1sYk=;
        b=hJyy0pSWmsi38DoRP7zjFFU+GuH+zJpYEwocuIAZ50WV3mGlnIYI0KV8tnRNHuHUdB
         HYntoO4DtpN0sIGHtCtkvWezqWp6prJFrR4gxWFacxFKg/JelFTbeRjExLex/zD11gtX
         v+bpQlw8GP8PUdwpSyeHWXwd8GCHQnzB4ZfQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/53V2W3Xp+jTS+AAHMLGENe+ZK+W0DZYh7wAQpA1sYk=;
        b=ZhpzsOPnnWkm6C3og4+ujhleslxDeaB70YfRqi8P19QRKQZS59qSahSh/x58YJHm4y
         996WEGekM3UVRIgoK/2gzW4X9hEEK1Urvb3fBgbXKGH0K0gxe3SGwhsq6kOFuyKmsm46
         H3gcMtgapDlCv66pKjD1GAtJRVkD+YawqVjUJRIruKdXtTwDjuzAMtm793IuI13yBCLW
         YORhkjJKYasp1ZCTzOEz97YRkqGJRA9zJkWpl7a560LZoZLtH0BOmf1RqGI63oSRhCNM
         9KRVRe/qsRcELT/uMOAwhoIpF4qs26RPocDZgVYgfpBzdNkDV/Lk5NCHVXwgcxZ1ybWv
         G3xA==
X-Gm-Message-State: APzg51BeHEDgyr4dUgLibb46rtWNexD0Vd+xlTm/tZhwjpzLc0wR/hDS
        JjhMbZYnIQN40deI6nYHtNkKDoMvD8xl+7GVvK50Q9Je/eI=
X-Google-Smtp-Source: ANB0VdbBOEgtOohfIW8UBPBtFJRR+A9wZ8UATswuX6AQE3LKaEu/5WiBjIIpZBQuwRhIGIdcJ0GdAPAJkzfYnPJGgdo=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr4579879itd.130.1535531682835;
 Wed, 29 Aug 2018 01:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180807020634.18182-1-yixun.lan@amlogic.com> <20180807020634.18182-2-yixun.lan@amlogic.com>
In-Reply-To: <20180807020634.18182-2-yixun.lan@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:34:30 +0200
Message-ID: <CACRpkdY+FRs0xbyrK1szAFLsLKz4uDRUJs-1U=brs8M92NJTUg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] documentation: pinctrl: Add compatibles for
 Amlogic Meson G12A pin controllers
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:07 AM Yixun Lan <yixun.lan@amlogic.com> wrote:

> Add new compatible name for Amlogic's Meson-G12A pin controllers,
> add a dt-binding header file which document the detail pin names.
>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied for v4.20.

Yours,
Linus Walleij
