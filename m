Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59906C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163CE2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AuzRzJ2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163CE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKSAUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:20:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41589 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKSAUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:20:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so25093033otk.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 06:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUgjBo2XMlVbtUz2/fh1FhOSpTDP/gkC3T2CMPuQi64=;
        b=AuzRzJ2xyBGmjZ9wW20mjCp3eQzP8CGe6xEJEMFwBuw4C8Jd+WqXRoy9C4vpJznf2Z
         V2qUWkmzx8ndBbZaVptQhp5VN9JFv9Dbr47XKasuJUQ2biPuf+P/CwvkUlHxHdZ/sBTW
         brOCE0KlXI9mCixPcrxrMr94HVW3FmaYV4uXfj7Yy/C6ZpneLcN6dlR3IcnS1jfKsrzF
         YXAYfhPkEbkJWHoWHvPeOcoFRczMINIs+/WF5kFiI3BYS4TLNImt6zV9LA82sRpA6XmM
         DndtghHV6rDLrBRbsgMyj+xTNs+B04xLTpKvwnIQDa1F3L/fUMPI9EqZL+NjDGBlKvr9
         0wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUgjBo2XMlVbtUz2/fh1FhOSpTDP/gkC3T2CMPuQi64=;
        b=DLUSLCGB8OUjagQGJVMPTqxBXRNxSHJvqgk5/aYB73kzv/gp2QKxZUdrZG9eYEoHWu
         LtIttwCpLeFmfG5nmnEiuIgP6IOLBEYFJICVkGC8U1xLUXKzRinNy5WecCg+KTHIENde
         zgxJtunpllh0c/Qv2y8YuyvtHzHak8snt/PtvVhuoZsvrdoYpYT5Fh6hXVHYT7h4rAG4
         qwahk3RYApzL/zEgqU/Nm4OBDJgtReeYdIWZp01DrbTrXYn0H5dcVvOnRmYc00cgwTfn
         bKAafBY6TzEo2xRUy10eggGEQklXQL4A8YQphhQ3tx43SjJ2t63cTMoJ+9e3fASkgZOm
         7MLg==
X-Gm-Message-State: AGRZ1gLCFOnhGVpQ+DJuxQP2ZnoJQCovVLhasDYq76GOB6i7oMVuyD74
        oFmxZrmppOicPxfsczWfvkc8QlF1l2dpXvwHQG0=
X-Google-Smtp-Source: AJdET5cGOombkupbT+2kKxsPsPpKrptgLpcR+iS4NBLbgC4fl82fsGXG+WoAC02l5Lz3+v/cXN98TKQq/JjN0Z+jggE=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr11098319otg.308.1542549614740;
 Sun, 18 Nov 2018 06:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20181118135024.30720-1-narmstrong@baylibre.com> <20181118135024.30720-4-narmstrong@baylibre.com>
In-Reply-To: <20181118135024.30720-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Nov 2018 15:00:03 +0100
Message-ID: <CAFBinCA5G+QLtaYu5TpFfjD46eFbjPuShPd0tvsYhPQBwZmOrA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM64: dts: meson-gx: Add Internal Clock Measurer node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 2:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> This patch adds the node in the top-level meson-gx dtsi.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
