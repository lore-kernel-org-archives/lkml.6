Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495F3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1087520879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LCPJKAOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfAKAny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:43:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55362 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfAKAny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:43:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so754307wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=aQN/RKFxQTK/6lxV5iF1HFo39ISp9QJU8sb5g5HF8vg=;
        b=LCPJKAOvwoI+S+agdYxjgFAtpm1xuHy3kc+U6NmfMgtvfHZiwvR5fEY9eLDwmRVaMB
         Sz5NMCrh6EoEXqO18GJJx94bbFRmThtFtfAGsQ2lCEV+GedGiDJdzWOr71l/AC0jp0/l
         4EosGY0UhAaRDp1XhtlEAQJpy7gPs3uCr+iK3hr7QPFJhPb5xPrGrmIBaOnyKMkGkP39
         1tzeeif8DDCn3Xgl2O4WHezwM1iY1uE06ayXMVh9uKvWBxqnwaESD588GZFyXagM31JB
         OU+l+e/D3GyyFys4ICOuYNaZvHZ67NCWeZTT8LSLjVNFFG2zRQ7Ur0Xfj8av2dMXg0nS
         xfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aQN/RKFxQTK/6lxV5iF1HFo39ISp9QJU8sb5g5HF8vg=;
        b=UlG/Asw4NECfuyD/y9psz+aoJ+VElF1m0nejFoWUjas2RsjQlJlh1cE9fw2KaQdPQg
         gwFpu00S+NcbGiRBzCp8a8p2rM8RcCMreAlWS+u2y7CfWoPru/SPG0hDYZmCV7Z7sq/p
         wcmal8LHCGj9d4b7Is8gvFz7yjdy0UTzbdx1MLYmLJfMiUJCOUOz6tDSaT/ZRh4ewqeK
         0yD03yp88ITUnmnxMrh8ehbdVyXggJPv9EFpqLsixlSwfUhih42Qwpmbz/xwzhEaTRiL
         eLvz/sV/KMio38tYRJQHfD40izSEpgz42QBctL8IeANutsVzKdH6VxV53RZgA0ndyFYe
         km+A==
X-Gm-Message-State: AJcUukdsObC82ZY/3FInlwgCFXpL5WvaRZWEDDz++tcHDLfzuLrembhI
        Sk6AZ2cdibweDv15oUP3YBKMSQ==
X-Google-Smtp-Source: ALg8bN4u/C9wSavU9Y9vcfPA3BXo90JXTvWet/dPUU008sAfcbcxocOBvGowfbtkfRgWZLSc4+D+ow==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr222451wmf.59.1547167432454;
        Thu, 10 Jan 2019 16:43:52 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id k128sm22476100wmd.37.2019.01.10.16.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 16:43:51 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: meson-axg: add spdif input
In-Reply-To: <20181213143631.19218-1-jbrunet@baylibre.com>
References: <20181213143631.19218-1-jbrunet@baylibre.com>
Date:   Thu, 10 Jan 2019 16:43:49 -0800
Message-ID: <7ha7k8qb0a.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset adds spdif input support to the axg SoC family and the
> s400 reference design.
>
> Kevin, ASoC support for this spdif input (including the binding doc) just
> got merged in the ASoC tree [0]. Until the related patches hit mainline,
> you may get a warning about using undocumented bindings.
>
> [0]: https://lkml.kernel.org/r/20181213120843.876CB11254D1@debutante.sirena.org.uk

Queued for v5.1 (branch: v5.1/dt64)

Kevin
