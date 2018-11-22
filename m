Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32371C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E025B20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HX5wwkvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E025B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395488AbeKWBCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:02:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35455 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbeKWBCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:02:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so8153054ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ym3cHuSkDQ5w2VoEvvYejK1J7B3F0dwtxBj8LV0mhA=;
        b=HX5wwkvkSjiIW3teUJG0FwLR9bKi5x4kWnB0n0ZpXgwvb+QICq/F9ruQAYjkMDOpfQ
         +oqEyg7BAZonGlFYBPd/GrAW5/uYhJM2rkg0WCywSoXBcw3968qXJkOay7CZ4zIRseEQ
         /izjf1WuQDaNuuum2PfJ5t6Kb+oTDPGqrQs/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ym3cHuSkDQ5w2VoEvvYejK1J7B3F0dwtxBj8LV0mhA=;
        b=IzmJ1etEN7mh2nCYBSOX159KfLL43XXlRKZ3EZJXw00OD2St6LMDznLC3aRZo46LIC
         KYQ78jt+GFyt+3ppT5VfEK5MtadxJErqo/lUdBzLvkwdcz0YB30Jy3SYFr1QnysgGll3
         jQDmPyOHz9ValtThhc5d0aL4qTuP461IIvSP4FI6AePHtmCggdtJn31zl1A+5j2dfo0+
         DcGnSgPP/6jJ7XDjW+3TbvsV4Moz/OZzPT46HWmNqbI8d2zNU9iLTgsFitTgpIJZYSJX
         K7yszIhK4yCjMzGDJvO6Ofl0TOI6r9e4PHsfzGzWHbizEF4vXVs9OC4O0Dc628+Rqrow
         0WJQ==
X-Gm-Message-State: AA+aEWaEDblzFlX++4fzYAR9p21z5C8m6nAb4g8AccHw3MujL3lzKl1f
        b+fIyhrkk6/jgs146gkRmNavq1wm9ED3VV8SbmiNIA==
X-Google-Smtp-Source: AFSGD/W9PY8tS4CB0BhUeaeYN6F0+4rZRNd8ZNWEofRM7WpB751EiRIPiSHcabI9rR7TSaTFrjf1UP8p6yyglAO2BPk=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr6348533ljj.120.1542896581236;
 Thu, 22 Nov 2018 06:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120131853.19710-1-tiny.windzz@gmail.com>
In-Reply-To: <20181120131853.19710-1-tiny.windzz@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Nov 2018 15:22:49 +0100
Message-ID: <CACRpkdbk_b2PbEPRQN2R=FJekLQ59Jv3-7DBBULYuM=FCWMz4g@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     tiny.windzz@gmail.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 2:19 PM Yangtao Li <tiny.windzz@gmail.com> wrote:

> use of_node_put() to release the refcount.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
