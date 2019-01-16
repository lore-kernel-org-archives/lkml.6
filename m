Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AB020873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547665366;
	bh=zGV1x+A4UOjkIap9GCOnaA1snknthJ8s8Ua0b1m7W+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GyN07YikUP9ac3a5FdCCBOqz3C9m8w0Mc36I+XP/j0BO/QJQc9xafZrdyoq7bTDtI
	 rRxuuIn7a0ybbqJd8X4ECkOdiV0h0YfDG0qWfWmxrOPKxCSrKVGBPZn1jQF9tuNE9A
	 idAT1bsuCA818h+a2XIKI1T79ZWklohU+az1Iaj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfAPTCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfAPTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:02:44 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E0CE20873;
        Wed, 16 Jan 2019 19:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547665363;
        bh=zGV1x+A4UOjkIap9GCOnaA1snknthJ8s8Ua0b1m7W+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xF2amGIR8KE4u1CrdM85QPhFnGQqEHl9NSgdNjHRayjTgFtsHbva3OHKCKFDEypQJ
         3qIn37FYmvhxHVOQQNPx0YPmoJj1DkOWmy3TQyUIEd2/cvXvmCnZ98G7DLmPkpaWNx
         +X9aiF9ryCeQgc+QWA4vPduMgnC/k1QeEhZ6U3N0=
Received: by mail-qt1-f180.google.com with SMTP id l11so8526143qtp.0;
        Wed, 16 Jan 2019 11:02:43 -0800 (PST)
X-Gm-Message-State: AJcUukeYXqIXgY1F7gE079RYhQ7UTVq1X8IaAPW2LM45aZp8c79YAIAC
        3bV2U6cCw8x/On6f3F/KhuVVnjoinbb7YRrPzg==
X-Google-Smtp-Source: ALg8bN7yAyhz/3evSA3iCRjO57QTECE3jWcoRYZpz46wcoOrjeZjKGulqo6js4fDBuNUJ3PWD7MtwYwgfSpeBdq4j/E=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr8083086qta.38.1547665362783;
 Wed, 16 Jan 2019 11:02:42 -0800 (PST)
MIME-Version: 1.0
References: <8fd140950dd0bb859f9a48d8b25fb919cbb3cc6b.1547059503.git.ottosabart@seberm.com>
In-Reply-To: <8fd140950dd0bb859f9a48d8b25fb919cbb3cc6b.1547059503.git.ottosabart@seberm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 16 Jan 2019 13:02:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFcUnDPmsZpvrxn3EsR5+B4jcjHonWsEsDrNxc98rZTA@mail.gmail.com>
Message-ID: <CAL_JsqJFcUnDPmsZpvrxn3EsR5+B4jcjHonWsEsDrNxc98rZTA@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: gpio-mvebu: fix broken reference to
 cp110-system-controller0.txt file
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:07 PM Otto Sabart <ottosabart@seberm.com> wrote:
>
> The cp110-system-controller0.txt file was renamed to
> cp110-system-controller.txt.
>
> Fixes: 4aa5496980e4 ("dt-bindings: cp110: rename cp110 syscon file")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

Rob
