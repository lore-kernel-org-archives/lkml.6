Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E404C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B084C2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7ANTBJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B084C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeISBeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:34:05 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51741 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbeISBeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:34:05 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so5118694itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc0eLMdfu11JhiI7s/ThrPnIYFMZSqZM3TTOuQhi3L4=;
        b=S7ANTBJaYwwpP0n2FLLHrfPMxtI7bQ4VhQx1MWOjydTTQ6FSb4rcLYfBysjckb6eTm
         0v5JNOyDeu21rALGOPSuy9V92xkYLjIfJjR8lSNWmzHp81lY/QWlIVDht+u51XAZfVuo
         PtwuvqkaillORFIf/pVmB+ldDRwv5TuLukZCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc0eLMdfu11JhiI7s/ThrPnIYFMZSqZM3TTOuQhi3L4=;
        b=s+WJ2CGvPPc/9Jetb8BaGrgx/fzdtQFof0EA2ALZ/7dhkiQRWPwcnAhlPc6Haa1FgX
         GocR2ekBf95jp0/6NrCKW2AFlpVYcPZxonPPhYoke6pR+xrQgS7hlTmU9iIwrrJFSceS
         EKH8VKNSc6H2CmCLNU0qYAbTvUWHhjGay4QpJVH/w5K1qJtGu6qFXWxKhFhSuua2rGt6
         WV2lhLnRA9k6NMDaXeTEuuIr/kRywDbMHvw50XOlsyeCnYnSkcjq9LuGttOLG/Pn4Bx2
         3QTDAqIVomGLnCfdAIdPEM/rIfsllolKZEzsbEhVDMl9M0BTIBHA1E5NdOar6BAzTSTS
         cpbQ==
X-Gm-Message-State: APzg51B9mkJmllEGCH4f75tr/R7IPCFa+BlP/Z1y3XGsNJtMq1uhcq0j
        FVAKqBWV1APcgRLWkLEJtIlL1nEcl1sAmHQT3fFoBA==
X-Google-Smtp-Source: ANB0VdYT5hquqaCxQvZnDXoRKWaFs1bSleYtlJD8xBsmF4LLALog937Hq+xsCkOHWweTEUg7nSiUqPTseswlMOLpsUw=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr27614834jab.113.1537300796407;
 Tue, 18 Sep 2018 12:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <ed67b2e8e71220a8cd32c9a7e584931af3d83041.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <ed67b2e8e71220a8cd32c9a7e584931af3d83041.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:59:43 -0700
Message-ID: <CACRpkdZnD+pKii0nDq7qbQu15uiKycJAK5szCByg=vaVUyDKuQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] pinctrl: mediatek: add pinctrl-paris that
 implements the vendor dt-bindings
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:08 AM <sean.wang@mediatek.com> wrote:

> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
>
> Add pinctrl-paris core that implements vendor dt-binding which MediaTek
> tablet, box and smartphone-based SoCs such as MT81xx, MT27xx, and MT67xx
> SoCs really want to depend on. The driver is just completely rewritten
> according to pinctrl-mtk-common.c but uses the new logic from
> pinctrl-mtk-common-v2.c to have an elegant way to support new SoCs in the
> future.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
