Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D49C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9962080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Cg/GP+L7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9962080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeKSAZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:25:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44554 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKSAZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:25:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id z33so25365277otz.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 06:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppz352SnbgHTeFP6BzKW2e+oWUPFWxDj3j/n2x8LzuY=;
        b=Cg/GP+L7QRAoIxAKaPp6uNIekKMautptcflaKwILnx7QgA8R34dNQ5IwzuWe7W4OKp
         XsMmsNg96L7zllBziB+gzrmC5rIBkcdUbMasBLeWuR2Aj8PW7OxNtx0sx/7haB2AhKW9
         LMi+xt+vs4zfCpcqb8pQHO/VTSqPxtCh7WwX0R3bk/xl2tpt8oM+8H/3yDpY8bFMlr4I
         4jFKaD+CB24tpwXZLffPtP0wSEwC5jDS1wD7TGxlLoqRz4WbTHJmtg8k6iof4n+EZlDJ
         mLHCAnP496R2f4/pA90M3Ap15Bd4BsFPQhrHA3iDT+eekxfrgoLC6d4Ug84B9aN5oYfy
         rKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppz352SnbgHTeFP6BzKW2e+oWUPFWxDj3j/n2x8LzuY=;
        b=p0EkdzYaSGtkP3HsGMIDj1Tyc1nK78izPc7Iyz14AHp64tv2KpB0Ix1YZccC/vheSC
         1NK+yZgoWXJxEWgZyCpiJPt6IW3/t7Qg0y0+E7ndRad9GcF17rA7vlt8HO20ZdI/o28M
         8VMT2gBOoLDBkOb5g896p5DiwgC9ABXEbKvZd3kvAe+otqLr9rzB8UpF2vQQUSFZm2bg
         YVCsbRA2SvxB8sGNJyW9/xduNbCmxCiIgYxS9rfA8Bn0H5pOseZlxVy2EPu48zQOOxpT
         GOkNtbLq8J/jzdzZ4UkxXp+3Ku6v62+BFJ0cbkAPtb/XazPhm7JIQWqe6vJruMwDbe/X
         zRCA==
X-Gm-Message-State: AGRZ1gLzQp7wlUicuvGe1w9uj8GzJYn47myxk+ipAqgE1ZjGRamuQx2z
        FluTYFhwnh4dmaavXgazhvac1Zu6XIupEaPvMKDpgeuoQPI=
X-Google-Smtp-Source: AJdET5dVomrt7kyacGTpsAHgY2PHqmJuVZCf92E/SXGs2eHc3nw/LdTm2pFcUJ1Kp+yzyDDeas881DbTf21wJOq6IXc=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr11425777otf.131.1542549878346;
 Sun, 18 Nov 2018 06:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20181118135024.30720-1-narmstrong@baylibre.com> <20181118135024.30720-3-narmstrong@baylibre.com>
In-Reply-To: <20181118135024.30720-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Nov 2018 15:04:27 +0100
Message-ID: <CAFBinCBSoXtUtXmvokp9c+E=gQV9VNcqG0VjvPmbKBfngZ8Evg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] soc: amlogic: Add Meson Clock Measure driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 2:50 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> The precision is determined by stepping into the duration until the counter
> overflows.
> The debugfs slows a pretty summary and each clock can be measured
> individually aswell.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I have successfully tested it on Odroid-C1:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
