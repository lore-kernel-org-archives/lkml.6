Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21D9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AFA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="mgHkHz67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393505AbfAPQfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:35:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37663 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfAPQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:35:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id s13so8275211otq.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9i1P6vRG4Obd1Kx4xHAhhonpuvI3/QuYbbm9Ht4Hpt4=;
        b=mgHkHz67OpaIV1cU3g1u60rmd8aROla5rE6DlZjD8pSEZkSUxAWRiY0dTYJ+LCWeTT
         YcBTA1VJxNJbBqQks5IaFJfcIeve+JNId3USPTkIqwfanLwhqBwnne3cOsNRWwCtevX1
         SFXer9orndKSXkbmWXzN8CjO1Bvfuau+H09rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9i1P6vRG4Obd1Kx4xHAhhonpuvI3/QuYbbm9Ht4Hpt4=;
        b=mX3zylQDcgQCE9sa/zOCkUIwCNCnFqLq4zxwmWjbaPTeDY6LnY9EGq1zJrlOrPakTe
         HVwgeqLPuizl6Qak0EH7K5R65VJqBFV6/5+XD2G+Ln0LuhG+LpFnKrT0V0wvPsD4Yhye
         Sq/AuMLIvhAov69/Kmew55YALYOFLA51TJiK/iwAHnAdenmbjGvEIfIcKwkB2i1e6hKj
         I/jj43fpWxpPwfgOlJORoYwdASQ+S8+jANz4U+vaFnK8IgxL6ZEcc5d/x8P/qdEJW5b9
         PGzfSek/1YS5boE50KNU7uNDCVyx8vRJHWw3lYRHmZKHmfxaLjo2ApXmqdpDZoRR5YZd
         +f/w==
X-Gm-Message-State: AJcUukc0cj3oY56ME8+0nDDRnSdQ7/QItQes2u0OHMzgDqLuoehB1Tm4
        VrBwpCQgQDxAiTJufnH2i7RF3Q==
X-Google-Smtp-Source: ALg8bN7XZSnwudLofwLpY7Np8CLo0hbzupAXZTACpBexJkFOA5TkVxRGve6luuRJlmULBL9eVpkaGg==
X-Received: by 2002:a9d:6287:: with SMTP id x7mr6331509otk.304.1547656505363;
        Wed, 16 Jan 2019 08:35:05 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id b14sm2710291oti.6.2019.01.16.08.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 08:35:04 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id u16so8253958otk.8;
        Wed, 16 Jan 2019 08:35:03 -0800 (PST)
X-Received: by 2002:a9d:8c6:: with SMTP id 64mr6298138otf.168.1547656503478;
 Wed, 16 Jan 2019 08:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
 <20190116142458.19542-5-starnight@g.ncu.edu.tw> <20190116143613.GI5265@nanopsycho>
 <3d905f4f-e354-3607-32e0-84ec385222f0@suse.de>
In-Reply-To: <3d905f4f-e354-3607-32e0-84ec385222f0@suse.de>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Thu, 17 Jan 2019 00:35:13 +0800
X-Gmail-Original-Message-ID: <CAC=mGzi-jP2L3X_W2w6fudLSvWoO9GmKW2Dfoymd8XyQ=3n7Mg@mail.gmail.com>
Message-ID: <CAC=mGzi-jP2L3X_W2w6fudLSvWoO9GmKW2Dfoymd8XyQ=3n7Mg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] net: lorawan: Split skb definitions into another header
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas F=C3=A4rber <afaerber@suse.de> =E6=96=BC 2019=E5=B9=B41=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:50=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Am 16.01.19 um 15:36 schrieb Jiri Pirko:
> > Wed, Jan 16, 2019 at 03:25:02PM CET, starnight@g.ncu.edu.tw wrote:
> >> Split LoRaWAN related skb definitions from lora/lorawan_netdev.h into
> >> another header lora/lorawan_skb.h.
> >
> > What is the motivation for this change?
>
> I suggested it because skbs could be used with either LoRa or LoRaWAN
> netdevs. I have a lora/skb.h.
>
> In general the lorawan_foo.h looks ugly to me, so I thought I suggested
> to avoid that by using [lora/]lorawan/skb.h?

Seems we have some choices:
1. Split the lorawan skb stuff from lora/lorawan_netdev.h and merge
into include/linux/lora/skb.h
2. Split the lorawan skb stuff from lora/lorawan_netdev.h to
include/linux/lora/lorawan_skb.h
3. Split the lorawan skb stuff from lora/lorawan_netdev.h to
include/linux/lora/lorawan/skb.h
4. Split the lorawan skb stuff from lora/lorawan_netdev.h to
include/linux/lorawan/skb.h

#1, #2 and #3 are good to me.
So, the intersection is choice #3.

Regards,
Jian-Hong Pan
