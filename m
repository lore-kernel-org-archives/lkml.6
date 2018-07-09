Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D2C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E962087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tvkz0rvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E962087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeGILKB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:10:01 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38954 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGILJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:09:59 -0400
Received: by mail-io0-f194.google.com with SMTP id e13-v6so16674161iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Il+p5cNq78IiYaJhSKpznAzyB7lwwA9pqyC50bvG5Yk=;
        b=Tvkz0rvyhVeulIPXajWItuCuIfMTfK8NxbStSXjgFuNLCU19o9j2FFSaMqw9n6vvtR
         ygTWlTli+zvIOHtDFhTWGbcEUCDkMa1vcr/pSFGVf3K7N4r4vdeXmtsjboJ49ERgpBJ6
         ibRkdbnIHpgSnXcYaHY13n8THgU0slLQP1VbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Il+p5cNq78IiYaJhSKpznAzyB7lwwA9pqyC50bvG5Yk=;
        b=QxzmxP8TMBKt+sKvyEaPY49zmNezjsGwXoswPTa7ZhBs6/GaO5rf7s++bUtdG8FZYT
         R3PVDzwSHY9U4ZgFrkVimi9D21U1TPTgLaJbfPkUwTAPknS4dOCoxYXfig7a3gb25lfb
         6PW3EUsApGtHGx1Z9L6NgQua5eTQLqoYrOHbsCfy/7ISX96zgaIikjwzU0r5vgb3Bv+B
         CrSpITIRcqh/FExNowVVD5i9+M0a07j4IBXWY6xzRmj0hrrxtKcFjcrMLMC+NbiW2DFD
         CN4PvTf/Dn1z5N8Nctuf/IPzeH5MQr78SDio6CjxE0sJGB49OLdLUWMqO6c203EBa50e
         nnkw==
X-Gm-Message-State: APt69E3tqwNanvx8+xTXY7DDrE8bdkPYIt2kBcwrJWKb8QGFINmRG+TF
        Szixyea7GdyYKsm71XcJEUNZeRtfvO3y+RwLKFtiWw==
X-Google-Smtp-Source: AAOMgpcWUDdqk4FDZ+FZUIUpa3BDw/mlMEcsAbCozswcKCUzVdmiiAHOuiSOMDQHzi/DNVVfXuNpIEK1Y1A7CQNC26A=
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr16549788ioh.175.1531134599366;
 Mon, 09 Jul 2018 04:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180702225939.109169-1-dianders@chromium.org>
In-Reply-To: <20180702225939.109169-1-dianders@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 13:09:47 +0200
Message-ID: <CACRpkdZo4fBkP8ooWna5_5Bwg4Q9qG8O5p-NwKS7XbrGNXE6dw@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: Document pin_config_group_get() return codes
 like pin_config_get()
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 1:00 AM Douglas Anderson <dianders@chromium.org> wrote:

> The pinconf_generic_dump_one() function makes the assumption that
> pin_config_group_get() should return -EINVAL and -ENOTSUPP just like
> pin_config_get() does.  Document that so it's more obvious.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Patch applied!

Yours,
Linus Walleij
