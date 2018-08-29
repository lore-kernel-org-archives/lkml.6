Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C9620862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJ0S4XVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C9620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeH2PjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:39:21 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43978 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbeH2PjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:39:21 -0400
Received: by mail-io0-f194.google.com with SMTP id y10-v6so4188110ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utigLbuG9azR7kwNVawjTYAJrJFGJVdzjYGq/C6xMs8=;
        b=DJ0S4XVROxY0CZsDvLdUpm4P963CilC8Yqo7UUevy5PBeKTk08dDjevxyakGVpD645
         668/FxinOhAiNLeUnnZ7MaY5B0ThOWg5l+v8omEFArpjm9XwEXrdYbQqykbRwoknJIDx
         gkIK3QvFKKg8SftouROPIRNBOSfYNCzm9bQBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utigLbuG9azR7kwNVawjTYAJrJFGJVdzjYGq/C6xMs8=;
        b=r22DDT9+5wyPTd202fzSV3tvi3TheEmMrPyJOYAPUpgQVfE2C7mEKYW1B0ljjTKlrJ
         ttCTERpouALZQqm71xEF70upwyudVETdG0cnxNYAJEgR0XUIeX2fmK8J/9EnwiFcJFRO
         aoUUxdM5+eCUQQvjzQDSwPpXEaLDrt0632/jPjkm63El+qV93tUdeFw5mtk1kbotEetu
         EOz3VWyG42++ooQcx30OHP6fzOpJMpXTAX3/G1ig28wnLv+O69E8gp8JFATB4TyS5azE
         b4BAhF/BPt329fZSiflSSb7OLP+Cvkm1g/cIwK7bXazreJGMIZq1KlR+wqQLAA4VEL2P
         R9WQ==
X-Gm-Message-State: APzg51DNvyGWbOfmJJdAMD5CtEOGp4lDlRUg7t3Vywi/LBRh9qhqJN+B
        cigSmb/7A6LOebXjAWfYI1fn4R66FQ3GNunz96h8/A==
X-Google-Smtp-Source: ANB0Vdb0lyk8+iRrJApWYsYsv5LeUrVd8awKZodpsQCSXZ31nZw3moGue2TCNJ5mPUyJkFCsNbMVxgQYhIp/Xskz2dM=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr4725790iog.175.1535542970803;
 Wed, 29 Aug 2018 04:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180821164236.21101-1-paul@crapouillou.net>
In-Reply-To: <20180821164236.21101-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 13:42:39 +0200
Message-ID: <CACRpkdabymwty1pLDgwUzf4eScN4ECfZ_zDKRSfYXxhq52-FYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] pinctrl-ingenic GPIO merge + JZ4725B
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 6:42 PM Paul Cercueil <paul@crapouillou.net> wrote:

> I created a V2 to address the issue that Rob's bot reported.
> The dt-bindings doc changes were moved to their own patch [1/8].
>
> The only other change is that I dropped the "ingenic,jz4725b-pinctrl"
> compatible string as it does not provide any functional difference.

I have queued these patches in the pinctrl tree on an immutable
branch "ib-ingenic" added a small patch of my own on top (include
file) and pulled into devel for both pinctrl and GPIO.

Very nice work!

Yours,
Linus Walleij
