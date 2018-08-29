Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84039C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAB42086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbQUMiWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAB42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeH2Lxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:32 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45876 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2Lxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:32 -0400
Received: by mail-io0-f196.google.com with SMTP id e12-v6so3681300iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrLADOX2CyAZJ7ZqxBfs9N8TlXtdBnJXH5xv397VT60=;
        b=ZbQUMiWHnthMQ9JuhqggQrpujgDrH6xXWQHJVt4w5r5yOYzgevuqV5Nomv2/1AOmp4
         IDwm++N7ngOMUXgB6L5lliDt44jqaZihCuNN9HvsxYI/P3qh0165gXyoTW9cImaYA0cI
         fICXZJZPE9pL3D8j9c+qRC4vnMR4DhRh7A+n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrLADOX2CyAZJ7ZqxBfs9N8TlXtdBnJXH5xv397VT60=;
        b=ZfycycnONvy9DUDpqYhJ1vIDN4ioF8v6pglEa7Du012GrY2HJ+iNc9h4f6Z9qPIQKD
         svAR133inPukQo5lPztFYcaMXv3M0B2UtwJUaP0wanltO8/wD8SbsTBHt0JLEi8C4ZOb
         dJvcBETFVAD0DnES7opWgfZGX2SFQapcwb6HshaFg9kbuZCmwKUya4Vj2yQRi32NM30p
         5gFiG8OVKOzuaXK3kjDpSt0nexyX+S1nybFnE5Uyh6AK0cOtxs9TCdQduDxVQ84NWx6P
         ehszp4QlU0mUArcApM6ZX15KkzTxlgNQPiS0F1DO45fpTcKYFrdSILg+AP5xZ9HATktB
         WTPA==
X-Gm-Message-State: APzg51Clk01Vf7WUok0J8qbHzkilPXh9VGchRxfy1HSS5OtRMCVYN2mU
        zy5S+SZqWBXQQzYjvTRROoircNlPIcKp5qmXAT9wEw==
X-Google-Smtp-Source: ANB0VdYMfqxzAJxNLgFOmBLuNV1K0CgCDhPp6MNA7hYRUZczsGxPbZbgDxgV1xfzuaLNKEJzzgbArAAAPbm87v5lPzA=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3968335ioa.277.1535529474588;
 Wed, 29 Aug 2018 00:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180808092526.87405-1-tmaimon77@gmail.com> <20180808092526.87405-2-tmaimon77@gmail.com>
In-Reply-To: <20180808092526.87405-2-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 09:57:42 +0200
Message-ID: <CACRpkdYDUO9JY3+d1_iOquMo6yoJmjuH5DV42rjY47gomt++tg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-binding: pinctrl: Add NPCM7xx pinctrl and GPIO documentation
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        avifishman70@gmail.com, Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 11:25 AM Tomer Maimon <tmaimon77@gmail.com> wrote:

> Added device tree binding documentation for Nuvoton BMC
> NPCM750/730/715/705 pinmux and GPIO controller.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied, bindings are clearly finished!

Yours,
Linus Walleij
