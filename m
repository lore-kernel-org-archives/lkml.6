Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5BDC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D06F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJhKhnTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D06F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeGIOEg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:04:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51186 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754530AbeGIOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:04:33 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so4162508ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klrOpymtS7WGWKWkKqysGz9U9nZCD1UayDZWKA0iWSo=;
        b=JJhKhnTMrtPKZOtfvAjKhCpy3BYoTeZEu8U9Nw9neSq5GlGEgIhaAo1XzJ7GHstSVr
         fdl/r8AfmqFW8bOsH8CnyIIqIJZoX/cI5amfF4sHGsaYflP6+xmZHOybrKkzl4TqZgj4
         2LEI3nUuuCp5bPVInB+dR6plOtJTdCipdNoO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klrOpymtS7WGWKWkKqysGz9U9nZCD1UayDZWKA0iWSo=;
        b=SHtA3G/fT5mOwM/EXKEm6uCU7QTyZERwM6py9C1/E05nwLAqGsmJKIf5KuyupJ+cLx
         Mi4p+ojOoa4hiFA1ffVhIeI2rJmqP5BEQ7ApTmIyjI2bKKBAQWmMWZo+xEu9YL08aZaP
         u58ewVXtoj8yb/Xb6mE7h1aWu/96wvHyAdrTZYxE597E2mcZzhZGGHxoatAZeC7aJ33d
         81OuO5wbWs1kj9tcO87pdGjvUDXYk0pbODEgNTpSn0iXwHTK4ewOhil5Q+j/DHsPB09c
         dvAIFTO3qhd55D91OAAprKUSwyaJxOR9bqoNzQvL+BcBO7yJ/7JtgzrSip+CmZ+4SSo1
         tpvA==
X-Gm-Message-State: APt69E3pwAtrl/Eb0MOszZGhGfg3VuHTdHZzll4j/sBJX2JJijs0ANw9
        DrSMZ984rVYrbikn/EaqZ46NrlvoI/anJ1FUMolcEA==
X-Google-Smtp-Source: AAOMgpdBoY6RV3N47msf2XLdK8bPaTEkAoAkuJqH8wbjDdWMcPG0cIHIggwpJCWEs9p08kUc/aMdKpEVK79gPGbQXN0=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr15863859itb.38.1531145073070;
 Mon, 09 Jul 2018 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <1530532746-619-1-git-send-email-abel.vesa@nxp.com> <1530532746-619-2-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1530532746-619-2-git-send-email-abel.vesa@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 16:04:21 +0200
Message-ID: <CACRpkdZfFGsADqYbmyBw7_==NPds7DinyRm5NMg5LWHKFSzKcQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
To:     abel.vesa@nxp.com
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        abelvesa@linux.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 1:59 PM Abel Vesa <abel.vesa@nxp.com> wrote:

> This adds the binding for the i.MX8MQ pin controller, in the same
> fashion as earlier i.MX SoCs.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied with Rob's ACK.

Yours,
Linus Walleij
