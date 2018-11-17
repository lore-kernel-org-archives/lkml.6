Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D6C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33372080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 12:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfuMS7v0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33372080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeKQWgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 17:36:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42290 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeKQWgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 17:36:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so14670049lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 04:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PTkO9LJ0aELwDkLk9tV4qAHt+lw5jWOf9ELwtZ8LmU=;
        b=JfuMS7v0Vzgr9I8mtQT6Q2IiZJZZeNv7xuycMNRvGRRH+OlY4DxAF09O30XldFT6EU
         mFSMEHthGI6GHgcg0iapagvZXzmaRPzvS8AJNH6353cP4BFUEe6qnxipRJXOm2bk8XiS
         GUHJg0E6CZ/SALGn0e5E++i5Jw+8ODhf2Uc/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PTkO9LJ0aELwDkLk9tV4qAHt+lw5jWOf9ELwtZ8LmU=;
        b=P8X7OiEZGBH0RrKBW+Lu0D5mECGDBL31e5S73xdMUVN+9TmKeDAQqO1mLSvqqjMIUr
         hoB9fRoSr4PGd5S42XYH6m8GfKAtJWePbpsRXJU7eOEKcJ2ce3+Pr56rjn7VbmPFERRd
         AZlVSS1j9/lT1+EVcpyMZ2HHbmqISsx4lypA34IKzLUsix7d8miwAM5Ckfu49BheP820
         S8Ohi+i5Sv2yMN2wzDE//QAYMIm5nIsVYmC/oIYYxX2Ag/EyL6Qq1t+Iwmc55oudatcz
         iOwfX0R6qZjs8eL3pOZsqlpa6FtpDkJl1FfIUEGVZq/sVn5zcYQrPueL3PT+ezQXGz+3
         uneA==
X-Gm-Message-State: AGRZ1gIil7YuTILCfj9lCu5ZWiSgztWo3tBUqOsjABIUCZ+H4jFrRZVL
        WyL9DFdQ1X/G2me0GAH+hkYl1ucVUrseadDOyj0p1nBFn2k=
X-Google-Smtp-Source: AJdET5dV5hUfdQ3Ji8JOXre1GZvf+INbNYSZ9kNbchRfIsVpb1oEla8BqE1RM2lWUICvQcnelrdW8Lcdh7bur/8XCPs=
X-Received: by 2002:a19:f813:: with SMTP id a19mr7060880lff.67.1542457167661;
 Sat, 17 Nov 2018 04:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20181111210047.30375-1-heiko@sntech.de> <20181111210047.30375-2-heiko@sntech.de>
In-Reply-To: <20181111210047.30375-2-heiko@sntech.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Nov 2018 13:19:16 +0100
Message-ID: <CACRpkdZO852hScSgCGQVspcLSCK99B5ofM9mNkGUj-uQHwfS+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: rockchip: add rk3188 routes to switch
 between nand and emmc
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>, heiko.stuebner@bq.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:01 PM Heiko Stuebner <heiko@sntech.de> wrote:

> From: Heiko Stuebner <heiko.stuebner@bq.com>
>
> The rk3188 has pins that are not handled through the regular iomuxing
> for handling either nand-flash or an emmc and are set through only one
> specifal setting. So utilize the routing function to simply do that
> setting depending on one of the core nand/emmc signals that are actually
> regular pins handled through pinctrl.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Patch applied.

Yours,
Linus Walleij
