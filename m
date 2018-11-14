Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7C622419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CD7hiRgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7C622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbeKNWyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:54:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34013 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeKNWyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:54:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so13993800ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 04:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DQ5ok3d1HCyACAXAFNcRKnegy7bDqFjHbFfMbNcA8A=;
        b=CD7hiRgNVhvl+VjRFGBJcbOozmdHmmEfXWkWT+uHRMkKPJWhnEydz95WlSqtAqZ7Eq
         2TsBUeVbyIYQfYuikeHoCjwUAYZgaoQaW0GqZolYJPpUWxI3Gz9zxzMLuh6ez4BmruQ0
         HhkDVxy/th1qfsLgIe7BUE/wWyJhAO2PtzmGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DQ5ok3d1HCyACAXAFNcRKnegy7bDqFjHbFfMbNcA8A=;
        b=CF6lJRZJVxmjYMSDqmBQpQhf+RQo99J3S0SEhs8IkFduNdu3mUBUiVEGCh5o2fkT+6
         dufWOnPSchTP5sqBqTNjDdNnEM8+VcV5FIKQInGl22wKsER8Nbka28WlxUZi0Zr771P+
         RfHVgxRoU4Zeqsohr1YDGz32DFydGe08qj7Kq4SN9J3zB0xde0dqxL+lRDitdDBaz+R5
         sNGGzYvteca5UwrqFBadIJQ5vbutweacKhoLjbHT22KEEZDxethVwIVJEeTQJVUjyvlx
         1ZjK3mQ5oZwB4i5+QdG7sEhbUdn/THKpt8yv6b0eS4Ear4q25p1mu0ThvyApv3wBpC8c
         +57A==
X-Gm-Message-State: AGRZ1gJnhqHziokNeXUsBMKCw0wBHvvjNF4/E0DxUxTQ5iwYvtbitan3
        WpQ96Skj2qV5x2BX+PQgemDEPAh39bUg3QSYcF3YKw==
X-Google-Smtp-Source: AJdET5eO2pshaTQTpqpcLOVAsDCYmQoTeoBHBoyBpaU31suNlJVxti6g5E4X/2+b8wcWj8Q5VCRHJJySUzg41QDH7sk=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr249756ljj.9.1542199896058;
 Wed, 14 Nov 2018 04:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20181105232349.17351-1-jmkrzyszt@gmail.com>
In-Reply-To: <20181105232349.17351-1-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Nov 2018 13:51:23 +0100
Message-ID: <CACRpkdYxgh9Nvh3WsOmE25KRHhn-E9NJ-4wVSzt6SjOTRCuYLg@mail.gmail.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-leds@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 12:22 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Global GPIO numbers no longer have to be passed to leds-gpio driver,
> replace their assignment with a lookup table.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Excellent Janusz! :)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
