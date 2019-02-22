Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF429C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0D320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fftn4VQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfBVJMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:12:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33457 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfBVJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:12:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id x9so751527qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHSCGJhQT5vPeUcYw0BmG5nLTnZfntsgY/PTxVdZY78=;
        b=Fftn4VQX/W/D44cAGIxjl0t1qigWol/1m3EHJ+Cpb0eIIsGO3UEVzmHFbHN1DUch3e
         71g+Iiazdw4XQy3ugtqUQUm7WTMvXfn62nx0n4EO5hoONvGqXvLlmcsXgYGQL2QpQm8/
         O55jSLNHCkSOqIfdo+/3epPej7vn9drc7BAX/nlOYMEqMK+azf24hFTc4C9gVtw2JLok
         WDaHQNcn+ZcNwDyGJEPwAR4en1/FRHr3nxHcrwPzc+3t2AV31xlFyx6SFyzMfbWG/+8r
         1thDhaKqkOFmscW9550iQR2c+NMhBxNVxRPHgjLElQMAHhdwQ460b2jPHnv8IU4now93
         u3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHSCGJhQT5vPeUcYw0BmG5nLTnZfntsgY/PTxVdZY78=;
        b=faDrijsfOMzQeZgVpRBEXJJ/i74FfYxdAs4RtGnGBWdtfuQMX2Qfk/4+7hdCDQK01+
         7oPorNhbDmnP2gESBFmJQ3e/vfbw7y1O82/QpJVqcBvEcAflRg6NkTgenr4feQu96Hsb
         nj39O7DkkquuGwaptbKxiHm3soR567heaHwldL/WXia+wBL/4PDAEJRF+3jgfsRo7F5n
         dXK5oI7XUNUFITJBJfTgttoBWJDN0fiTxBm4AQ38XA5N8lAKOk68K6DrZBG6ANHx2h/c
         S6EW1E5/Q4PgHfEN3jx1WFssVoBOV3bw1oRls6oHQoF3bibwoOhGv0wU0q6eC/AUkVY4
         rgKg==
X-Gm-Message-State: AHQUAubtgsgJ5ZzIp/nYUKkPiqCy6sLOqMIbIHZT3+zVBxwRnbVE0H29
        byjlSyCmZRkl/W3YnHzc7ZqWy1IqwG6L6D5YBwGk/g==
X-Google-Smtp-Source: AHgI3IZfztJr+mk2LwXJ3aJi0rh1SjSxCQMaCvfrsTLmvx9ucgLTeh0XX3RhhgVX0wpHL9gNHjSrHXMYt7W+LLGNZiY=
X-Received: by 2002:a37:ea1b:: with SMTP id t27mr2210146qkj.117.1550826755732;
 Fri, 22 Feb 2019 01:12:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550783880.git.sramani@mellanox.com>
In-Reply-To: <cover.1550783880.git.sramani@mellanox.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Feb 2019 10:12:22 +0100
Message-ID: <CACRpkdYRdOwcV4iHPTNoDraocpjeSk-eSzvMnMjSQcsLZ3ok6g@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] gpio: add driver for Mellanox BlueField GPIO controller
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:33 PM Shravan Kumar Ramani
<sramani@mellanox.com> wrote:

> Regarding the suggested use of the generic MMIO library, I noticed that
> bgpio_init only allows for either dirin or dirout to be set, never both.
> But since our controller has 2 separate registers, using bgpio_init
> might not be possible here.

OK let's just fix that instead of working around it, I will
send a patch.

Yours,
Linus Walleij
