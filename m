Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262AC20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGl4UuRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262AC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeGINfy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:35:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39000 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932753AbeGINfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:35:52 -0400
Received: by mail-io0-f195.google.com with SMTP id e13-v6so17055256iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/WRyF7RnjoWcZZwVR+z/ZoE8L9NADZnFLYfdDbsBn4=;
        b=CGl4UuRYR8Xw9krgxBUF8gFRfdC2bng8dABZ4+X5v1MicoQZ/fh2uG8NVPOpnphWhi
         iQP+tB70c3/3kmOPIVUVP0NWxonDurrzzXBzoF31+dUhvJE66nxYIZkk38xepcCJi3DD
         t7hTzZSqN+j+1+NUZ6pmOn0IrgoTCb8dLpBfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/WRyF7RnjoWcZZwVR+z/ZoE8L9NADZnFLYfdDbsBn4=;
        b=Nlt+DDzJZ5CIg1GRhcb41Pgyhur9rWsTMjnIeX1tjaaUsxnRP8bZsTmdUkTD3irOZW
         CoBSo0oKhAdOBm7+2lWN844l8lqlkRkNCLxR+whn+akzjvNA48LMqP8WMR79Clq6GQgA
         nM8GBJp7pn22GslbKxc3EMHV5x1G8Gy0e7xEvRndiyVaH9xhnud9iQhC69kXF1rRnN7J
         3SmUNhtmM+RyjuklUwS7kRljDnn0bP/2k+oyHWIPXyOteI/qPQdcWme/8U7rwgA/pMSv
         HRvep+NE+5GKyafACyHFvxhtEN+Zg5PEu+XxYw9PxNUOrCnaaFWbQ+EaCVuHpNXFKN92
         VjjQ==
X-Gm-Message-State: AOUpUlFdOvWwCeGPlvJjVagT7Yg91mEBxqFnSQU7RJ9moqx6sKxh+13z
        5FFGGhz7k3wnjFisB+y29y49NXwBjWrcsQd4KbL/gA==
X-Google-Smtp-Source: AAOMgpe6WUxpFVYd9hJijWBiM9DAWLeXDxqUkuMk9CcbndPgDaZ7WmLjYB8DbaVWDcSMR8xc88qWXDH2CuKux/uqJqI=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr16592209iof.304.1531143352110;
 Mon, 09 Jul 2018 06:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
In-Reply-To: <20180704224511.29350-1-yixun.lan@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 15:35:40 +0200
Message-ID: <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
To:     Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Beniamino Galvani <b.galvani@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 4:48 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> This patch series try to add pinctrl driver support for
> the Meson-G12A SoC.
>
>
> Yixun Lan (3):
>   documentation: Add compatibles for Amlogic Meson G12A pin controllers
>   dt-bindings: pinctrl: meson-g12a: document pin name
>   pinctrl: meson-g12a: add pinctrl driver support

Overall this looks good to me, could we get some review or ACKs
from Beniamino, Martin and/or Carlo as an indication that everything
seems all right before I apply the series?

Yours,
Linus Walleij
