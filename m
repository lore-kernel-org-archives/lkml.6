Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A30C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64222082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr2OpRWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64222082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLDAWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:22:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37738 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:22:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so8582065qkd.4;
        Mon, 03 Dec 2018 16:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpSK210zAS/R400DzkSan6qOeFvRkkTsOn5NjNenIi8=;
        b=Vr2OpRWXbUcPGEGn7/ZcS6/Qr4YpiH/cO2dKBALoAY4mMaFle/hHecRNVzmTNAkBW3
         i9LvEk57mG8f1HoSCMfa+yP3l4yOhV1vNTVFIso95VgyngeTo64nmv9A4oN8QiZaCy4M
         TuOxUA3CiKL+FGIkqVYUd9RCGRx7nmfECxiUH6TG/MGYXEL3IN25EsUFrck5SM21YxVT
         tO6pBubulAaViE0XXs/xPdYtHCA8GMmgPSxbwGFKFRWh/FG77xzFDoz0OrFIVrXffVWP
         qh5ZC1kS6vDWVkT1nPILbZaphLbEUBlxW8TfHnS12aAHGkAK1Bc/gvv82GUrgGZuFocg
         BRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpSK210zAS/R400DzkSan6qOeFvRkkTsOn5NjNenIi8=;
        b=WYN+CSr7Edgb4JUSVbZ5VCj9JkvAHEAvGGonKbG/kKPC7sZYfLCwG0UEQjIOgGBMJP
         9PSlbF0L/yWkdgu7enIxgKzbPG+C4DeqrdaGpUuw6QBrEzVJljf4pmoUDKlLtuAHTEQ+
         bJjwgKGx71NltnJkAGN2DEvyKWiZQmp8B+nDjmQ4Iouk7BRxDzF0Mrc58dzest96EDa2
         uaiFbZ8MJY/P8Ysi5JpZNWjJUzgLLGfHhNdr341tY584TWsGl0Jm4zrvaLG+Go99U4ln
         Bs8DuQ3sb3aDto6a3ODEaL37ZTtzHLroaydX3DijibVolUHZSDNJ2E+4cMesa9lpOmQ/
         uNGQ==
X-Gm-Message-State: AA+aEWadi8i3G2OQtQaV3Y9YVPTmCD7t4x+RsmHHYqhe0rkuWx+Ebv8i
        nn85cjXWQG1ubUQNdMV9dy9olLL0KVnWyZhWs9ah2A==
X-Google-Smtp-Source: AFSGD/Uawfo3nN1yPimNoEexFQ+4js1Ger70gGxpLNX8EdwHVpkP6MQLfKQ313awx44vAyHGgkhf1qYYWlGusGWjt9I=
X-Received: by 2002:a37:112a:: with SMTP id b42mr17111093qkh.136.1543882951156;
 Mon, 03 Dec 2018 16:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20181111214538.32477-1-heiko@sntech.de> <20181203234923.GA29934@bogus>
In-Reply-To: <20181203234923.GA29934@bogus>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Mon, 3 Dec 2018 16:22:20 -0800
Message-ID: <CAJYdmeOyYAiN4jpKzOAepXRgSrzWgO4qWjvV+9qMMYzA2OzL6A@mail.gmail.com>
Subject: Re: [PATCH] power: reset: gpio-poweroff: add ability to specific
 active and inactive delays
To:     Rob Herring <robh@kernel.org>
Cc:     heiko@sntech.de, sre@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        heiko.stuebner@bq.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 3:49 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, 11 Nov 2018 22:45:38 +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@bq.com>
> >
> > Similar to gpio-reset allow to specify active and inactive delays
> > while keeping the 100ms defaults that were used previously all the time.
> >
> > The dt-properties are named the same as in gpio-reset but get an "-ms"
> > suffix as properties should contain such a suffix specifying its unit.
> >
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> > ---
> >  .../devicetree/bindings/power/reset/gpio-poweroff.txt  |  2 ++
> >  drivers/power/reset/gpio-poweroff.c                    | 10 ++++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
