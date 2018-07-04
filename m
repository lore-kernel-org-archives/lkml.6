Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C1FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30277208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mBso/7GE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30277208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeGDRfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:35:06 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41002 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeGDRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:35:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so12023431oiw.8;
        Wed, 04 Jul 2018 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vqvqD4oNOQmOx/zvYemwiUGXSFCOzqR6QwOLfPnpYs=;
        b=mBso/7GEp/uxUSxOutO5PVfVSH/u33Bi9r7xkR7jI2F3BDfOlOzPi4OqsvhzdcLrnS
         Pbl43H8xXeItsFmtoahV5nBMLoBcyiKjUn0kzEPSgC0Rah3V5hQVkubVFsQX2Lcjvvb1
         HCq5+k5Rws19xzHfr0heQgH6nwUKLcAUkiHuk/46B9S1SS2nSIWFEVG5VT3BO1JUZ8aE
         m5s6hA4uT3ipvwJbvuAwJluxkISB+eKYpSIfflBnp5mcaMcoKjiltQnShBLq+Sdk0m3m
         ahy8sfYLaPfqLu+VdD3Ey7HH/rsjpkM+7aM1J0PEY8IjwpAFWgcstP+zRo//feipypiR
         IQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vqvqD4oNOQmOx/zvYemwiUGXSFCOzqR6QwOLfPnpYs=;
        b=Tae3zZ9ScvnhRshK73o9TATe5a+0D6io22AWpwNmi50fFhUZhYGG5MDz7eeNOPGi9s
         Lgv/MyNIHnKsXtBCX5LLZLcjCwSfH15kGfB3lCvhlKvQ+elBNwR9BimgsKcQXEG3wx8Z
         fFhCZSi5pRTpVUIXfNfR+yeJEhGik/O81q3OwyKcoZido/or9HMLedvEJNc+yUD1JdV3
         htFfiUYSSpqecWuicNIBIXiw0Tu7+ENKbfbf40kf3hcE8RDDM1ZpgiSGooZBYAfFeo18
         RRQocS4vGcK4iBKromDOjmh8KmYvbxp1KS5a9Y0LW4cidMkY2ILvVNc1SJVpBey472rm
         bLqA==
X-Gm-Message-State: APt69E1zp08g08UWWgnE57jjjiJw8yklMiXV/xbDMax3QFBkCkvQ8NXa
        uzsuGaM7soXJCOrd6KFW+ulo3WffhewQ8yvcvPc=
X-Google-Smtp-Source: AAOMgpdv4cqw3hE8xAyLJGv2R2VsxfjZyd5DlwccU3dD9h8xvo78RZ2PJtO3C4OEsgZLR0OrTcV7lMsnaewuW9BHK1U=
X-Received: by 2002:aca:c70f:: with SMTP id x15-v6mr3332312oif.97.1530725704289;
 Wed, 04 Jul 2018 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180704165458.24149-1-jbrunet@baylibre.com> <20180704165458.24149-2-jbrunet@baylibre.com>
In-Reply-To: <20180704165458.24149-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 4 Jul 2018 19:34:53 +0200
Message-ID: <CAFBinCCJPf5EhAu1gcToiXWsCpTYfHrE6XH0FGe1NVFv96WVXA@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: meson: gxbb: remove HHI_GEN_CLK_CTNL duplicate definition
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 6:55 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> HHI_GEN_CLK_CTNL is defined twice, just remove the duplicate definition
>
> Fixes: 738f66d3211d ("clk: gxbb: add AmLogic GXBB clk controller driver")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

good catch Jerome!
