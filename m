Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D84C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F7A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbtr9xNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F7A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404220AbeKWBQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:16:27 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53606 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395565AbeKWBQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:16:27 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so14396130ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MoBp6pKDAd0GfHHMklnFi0Ff+PqvcZ0N0BnisJHvQ5I=;
        b=Kbtr9xNOQ973eOnXfJX9LdX0i8wcAufxu5Lf+y9+zwt44FEuKhKsPsfIMqUC5vUGiV
         a406mA7VQq6oSoUTBcsX0ocAAePahWlofpteq9vOatgwtrsHoUWdMEQb8IaZf2bh+nO9
         xdp6pnDCl23w9ahxiKnLu0abHWMhVwd9bN0kXhObBBR4A684SInQyO5sK+VGld+WPZoS
         fQNid9YPAEuUbzQrNx/2nGFsm5MXJs2dSvooOrxFG/cPgulEoSoqmYHM7g93ghS+9wj0
         Az8tkjjOC/Kxpsq4p6IiY8qyB/NnMSgAU14WSfPCjGB8+0rXdKVjpFu7lk0nP25P0lRE
         IgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MoBp6pKDAd0GfHHMklnFi0Ff+PqvcZ0N0BnisJHvQ5I=;
        b=AoSQw5kmNr5YhuFmCcOyUZoi8wXl9uQNhddCyMq1DksJrAKZs4DcRz2vJhYrMEO7Zk
         xOheonmvhefj414NrU6Rh8o+VqkSHbVOtavW8+OmMgFnh5Qonqy6B5Ffa2kbvZ7O3YZK
         q2FBOzjk4vDXQcDm8MAyp13BM8tiRkyyqFi9rHNc0Ea8hvP5xml9MmDQ0dKWEHNsXBXH
         VqUjLggl/Kv9u426LPWSmUW8LzLEfM+4BOai7tumwtQFIgvFIEFSeteVDQxmgQ7I+8bA
         BXemc58/iWBNgTtpR3geA2rxR69NAlFNizCuphmmuJgpSXFRC1a0Nlq1NQuUg1g/QqcR
         Rx0w==
X-Gm-Message-State: AA+aEWZJexfFzqntNc8PkTU6Q2C9sZZdAEcIRC4UuOHgGkaPTFf/pvc6
        EA8G204GwXsROq5HyFl9+w3qE2fMMysMxwCuQgZuTrxWl4M=
X-Google-Smtp-Source: AJdET5e3QKnT3macta3wLwArwOzVphXT2hGm5ViNW0i+36ZaCLyiHZxqIDV7gsB9736fY+LcvX8fgazQo6qBoUik8P0=
X-Received: by 2002:a05:660c:681:: with SMTP id n1mr9412188itk.37.1542897409211;
 Thu, 22 Nov 2018 06:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20181120131853.19710-1-tiny.windzz@gmail.com> <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
 <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
In-Reply-To: <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 22:36:27 +0800
Message-ID: <CAEExFWuvVG+BXKZe2AqJc2TTayNPHoJRziEYYYxy56XW5w=iQA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:33 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 20/11/2018 14:18, Yangtao Li wrote:
> > > use of_node_put() to release the refcount.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >
> > Applied, thanks!
> Hi Daniel=EF=BC=9A
>
> This patch is a bit small, I will resend=E3=80=82
Code logic seems to be a bit problem, sorry

--Yangtao
>
> Thanks=EF=BC=8C
> Yangtao
> >
> >
> > --
> >  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
> >
