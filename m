Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA56420842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551105586;
	bh=2Y/v+JSnfvvlP06YCQ323goMVYR3sag8hKS4m3uE6a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nIb3RKi+QfzoiTdcUuNoPc68/Uv2xIGLvV9Ltn13pskOMsfk+bNFHovxa85J+jHj9
	 crELsVbs3bfC2GFdSOhZ7i0drCnXL5/ZXZh3rWzvZqzm4fnP+xv/h/ZXL7YBAYsZ2m
	 iDyAijyklV6/yeYMOWtAH8tCH2t36prCH2wHOir8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfBYOjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:39:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33122 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfBYOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:39:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id q24so8032968otk.0;
        Mon, 25 Feb 2019 06:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVnoIzx6swz+tWUg/1uvpeP6seGZ7cfS1owZ9VHY8Ls=;
        b=LKuKqJXYeeggraeG2C0Drqm2ltqBudYCrLVYenmhkHiiYkkw1BMtcQoK0Lk6mdwjZD
         elBmIgab/48fMns8GXWdVpRt4PnTMWVdyqXIxGZ3Tm5Aovyhno3/B9QR7jNQB7IOOFXT
         LdFnru1fhgdMYtys9nIRZ4pfWHvUENUmh87E1wWDC+RzAQUFcMu2RwfAC4oBOoLAnioC
         kneU5aYjYFkFBzvXRRqFnIhCohRHgcfbNc/JWUmI+KLMmHbwzRE35IDWLi2otNvHHnaF
         zXptrsmqf9G4o/6pxEy+UKk6qCYws01WvhWcEkByFNMgI/NwYei5NKJzIkoZ6J3Lo7md
         KTMw==
X-Gm-Message-State: AHQUAuZyBYHZiu8J0OBcDa8ZzQ7MCbHSFpJlgnbHyVjEF35o36jfSg2A
        GeZ7KmvjMLSLFfZszxQbRXA4GH8=
X-Google-Smtp-Source: AHgI3Ia4F5ncFC5rCjglsRliCrAlehxLCwP1DaDoQr/3pb3wy7JHIe26hXEFCUyHr9/rSjFtnl6roQ==
X-Received: by 2002:a9d:610a:: with SMTP id i10mr12260969otj.186.1551105583736;
        Mon, 25 Feb 2019 06:39:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm1346433ots.75.2019.02.25.06.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:39:43 -0800 (PST)
Date:   Mon, 25 Feb 2019 08:39:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK HU <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        ginny.chen@mediatek.com, kendrick.hsu@mediatek.com,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: Re: [PATCH 02/10] dt-binding: gce: add gce header file for mt8183
Message-ID: <20190225143942.GA13388@bogus>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-3-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548747128-60136-3-git-send-email-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 15:31:59 +0800, Bibby Hsieh wrote:
> Add documentation for the mt8183 gce.
> 
> Add gce header file defined the gce hardware event,
> subsys number and constant for mt8183.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |   6 +-
>  include/dt-bindings/gce/mt8183-gce.h               | 177 +++++++++++++++++++++
>  2 files changed, 180 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/gce/mt8183-gce.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
