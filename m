Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC5C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F0D2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaK44ok2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfBDUVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:21:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42623 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfBDUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:21:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so2004173otk.9;
        Mon, 04 Feb 2019 12:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77PDMoZYnq2ZgZLEMPBVLN8rFVn+ehqiJapB9ocHbzI=;
        b=DaK44ok2frNNNyG9zL1VjYcPw2VABzR/6TfQAyRLr5l2r+M/Z3Abp7F6a6rHRzfiiG
         +tt6ueLxNUwbieiKPHokNauC2MV9rQMpJQ+jDVDnzFU3uzJ1/Kv6sLiVXbGf8bJv9J3g
         dyEqXivL2qyhUrkk+AMQcUTeumiaQyCLolG9feaTUzoQS2syGDvYhH3PEHxpM/x6nz8N
         o9fAGoum69c3VteDLWT6IlOieGZJyUdZq6tsptWbIeRubfLevBskJggw2I7lHuK71IGD
         qrK9a52CgXQFH0sRGqad9iqZtHZ25vzzVHBUKxxzGp3+fxeL91Lfws7hq8ofTZNeD6eF
         UhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77PDMoZYnq2ZgZLEMPBVLN8rFVn+ehqiJapB9ocHbzI=;
        b=CFXTMGUscxQiDV5qreWwUb4IEPVKuDi1aaRLjmBjTl1rwT7EPjvd+kNmwribVo8h1S
         1uQBWAocIyxuzWtNe3HK6Y1rTcUzVBkklqYXsRhLp/zaWY0OcDhm+xQW015M8AolT/zg
         YtUEm5ghyJqqlDB0KbusB8B+9SycPMV6kt38tpjywKYGyiOKGGOMY62o5IQHTUh38iky
         tKU9laFdVJqBU8OXcUmui33cFYDbG4gHm9Mllx/sZSlArtVvi91HEGrEg+Au/o/KJm4Z
         2oMrez40K+MalmrsuEuSgfQnBcQbIN3My31m+tWpvWfgPfHc8SQUmC84E2JxnpO2pi+K
         G/aA==
X-Gm-Message-State: AHQUAubR1KLShggB9RpGO2m4iXNjx2eNTiI7Ek3ey1z18iNfCKasvmmF
        bqQrAYMtd7M8jvzZ87ZUfqdpUsYEFaMMsGrTOVo=
X-Google-Smtp-Source: AHgI3IYc78yXpnw/CsdPHuo/lUtmY85Ufmkv9hF0CtQ9Ti4M4Ip+jl38i3SEJWh5919XxqM65qhgOyfasVXkUBZrJIs=
X-Received: by 2002:aca:c142:: with SMTP id r63mr657213oif.98.1549311698096;
 Mon, 04 Feb 2019 12:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20181018073327.64942-1-icenowy@aosc.io> <20190204122250.GB7660@lst.de>
In-Reply-To: <20190204122250.GB7660@lst.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 4 Feb 2019 12:21:42 -0800
Message-ID: <CA+E=qVfHMqo_ZWPTgvr+5G2J29Yy-TU4aceVD0oHLeyaOxVogA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Analogix ANX6345 RGB-(e)DP bridge support
To:     Torsten Duwe <duwe@lst.de>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 4:22 AM Torsten Duwe <duwe@lst.de> wrote:
>
> On Thu, Oct 18, 2018 at 03:33:18PM +0800, Icenowy Zheng wrote:
> > This patchset brings the support for Analogix ANX6345 RGB-(e)DP bridge,
> > which is used by some Allwinner A64 laptops, such as Pinebook and Olimex
> > TERES-I.
> >
>
> So what's the status here? I'm working on the Teres-I and I find myself
> recreating the chunks in this patchset almost verbatim (only DT so far),
> one by one, so there must be something right about them ;-)
>
> Whose turn is it?

I've sent v2 yesterday, however I tested it only on Pinebook.

>
>         Torsten
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
