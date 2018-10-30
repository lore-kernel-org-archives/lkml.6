Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21A320823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuzQVs7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21A320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJ3VBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:01:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34341 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeJ3VBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:01:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id n26-v6so8669045lfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikcapejhZs1NZVz+nd6VxP3ivNvG3HHZ13oWDtGHyD0=;
        b=MuzQVs7TLQXYLnlv5NK83Rwiud/j6ktYcTpRljzkYwYuFtd789l8uwxlsutoAq8Blo
         lKoaRr4x8QlnYuZsd24rc7OQcR/VrueBxGsUOcc5nrF1zqG6VdshbGg8E67kKDz/OlCn
         uvgyMzO8jAXTJb/IBXpVjTOjcVbSgqFj8jyOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikcapejhZs1NZVz+nd6VxP3ivNvG3HHZ13oWDtGHyD0=;
        b=bcDRjvIfIDPFPCaJoRHxhkiH9C6pFnQlHRiOqYWZCvGk7hAAigOPn0KM+ceVrfMJIh
         Wx+eLZK1LPbH5sHwLT6jvuB6N5doKxwIk9zJ9D27UCkuFKtcCXkZEGK6IP9vsgiRd6PY
         +vAyLm78Erpwe80GAkrcKp6XFH2/0pnrRpgtGOq18jJ2WVUM8lq6tIK52CAja+oC1URH
         y3pAwnJ6zRYnH+Ns1BwaSULisYh9fW+GY2DEGVH8jxzYCiDoiTbsqIDVlVpbSKqKGjql
         d7G9G9RmtSluBC+AYwnienO0DAcao06zT78Rfb4BVzYlknPwSvSjjnx8hecfXAHEUSBu
         GzBQ==
X-Gm-Message-State: AGRZ1gJdxbEPz1yE4ff43qtltBSSxxKucXQMJ2OG6zOwZuCYmmuLfyDW
        N/MIGWtIJO1NRSmeHXxdCHgPoUGq3FATvQnrFALO7w==
X-Google-Smtp-Source: AJdET5cqFmVpeTUU6Zx9FEHXAbX+H7xXPsQF2YCI9u9fDNjCLiPBz0LKYw/gQP709OxDvQHCwKxkedz6MaMolXCgFrY=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr1800325lfa.32.1540901305574;
 Tue, 30 Oct 2018 05:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181017213012.233957-1-kunyi@google.com> <20181017213012.233957-3-kunyi@google.com>
In-Reply-To: <20181017213012.233957-3-kunyi@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 13:08:14 +0100
Message-ID: <CACRpkdbS_aOpFORVnK3QJUsF1p-mVxtMas-q6fOp7emTx281Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: pinctrl-npcm7xx: Set BGPIOF_VOLATILE_REG
To:     kunyi@google.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        avifishman70@gmail.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:30 PM Kun Yi <kunyi@google.com> wrote:

> Indicate that the pins are both controlled by the pinctrl driver and the
> generic GPIO driver, thus GPIO driver should read the register value
> before updating, instead of using the stored shadow register values.
>
> Signed-off-by: Kun Yi <kunyi@google.com>

This is quite a rough measure, if we instead use regmap-mmio
we can exercise fine control over what register are volatile and
not instead of saying that all of them or some of them are.

Yours,
Linus Walleij
