Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B611FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F8620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ambo3w/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F8620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeG3KlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:41:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33259 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeG3KlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:41:16 -0400
Received: by mail-it0-f68.google.com with SMTP id d16-v6so8739653itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQ4H43+538MTi+c51gN0R4h+srKFKgiJSpPdcFKOAzc=;
        b=ambo3w/DD6WwsSUp0XRFniP/iq5YwFJqpSWt5D6IJQ7xAFW/pcKEj79wvuQpJKQBXR
         XklYz7+6JdOsLF9KK4pZh9L9zKGk+2NIicQdHWYLnyIrQ9d5f1pyJrl42keVOin/PVKn
         QFOwMF3AGDjN0ENX6PdNFGrqCiHDiqTcZYGMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQ4H43+538MTi+c51gN0R4h+srKFKgiJSpPdcFKOAzc=;
        b=p218nsSCD7rXSJFytLkEur/CYveNmHgHuwBNnSZBoGRYsGfrpMkcrTTQZ2ldN8kZrh
         Gk+2XH+lvoVjgsUZ495Sxbkd9xRegA9eu0sCGIBVkMbFj8ErpJeSows5WtJq0OjVe2pQ
         XRje6y/1SoNqcXhPNxfLO1IyI0syEDsq1qQJMhIlw1EB0XPponWan90GHI7REg29C3lj
         dP0nxbOJJ0ERyaDJPtb6Fv2Gotd2XXUNx+B+UfzXGAYcE/OX27rZJbRQB+paSlrqfack
         qqmqqSbLUWwdNjvU5zAzoYDU+6qwAIXsmvObwnxH0xtzZazHVC8EqcLG5wTuAlAstOyk
         EF+g==
X-Gm-Message-State: AOUpUlGVpNmdi9tpLN671BmTGOElBvJEEc1J2rHvIJZFvfq738aWqqn+
        ySklvNyqvPEzabkEciZwNVkwgOJ6pyzJyZLqz9EfCQ==
X-Google-Smtp-Source: AAOMgpd3zc9B/LA18CzE5LDu6ruluvCElo09F1msrTEOJKyrpcYExNcdQ5m+b4qAQmHr6F1nAh7k+GhbsfkyVGX8vUo=
X-Received: by 2002:a24:7503:: with SMTP id y3-v6mr13375725itc.70.1532941634956;
 Mon, 30 Jul 2018 02:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <1531991136-1179-1-git-send-email-hayashibara.keiji@socionext.com>
In-Reply-To: <1531991136-1179-1-git-send-email-hayashibara.keiji@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Jul 2018 11:07:02 +0200
Message-ID: <CACRpkdY_DkBSZAkaXgz1p7x13_qkEcUQCcenaYnrTHJG-AY3sA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: uniphier: add spi pin-mux settings
To:     hayashibara.keiji@socionext.com
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:06 AM Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:

> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>
> Add pin-mux settings for spi controller.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  Changes since v1:
>  - Fix build error of "pinctrl-uniphier-sld8.c".

This v2 version applied!

Yours,
Linus Walleij
