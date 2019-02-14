Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68014C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3589B21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR5soJNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395281AbfBNQ4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:56:06 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55931 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfBNQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:56:05 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so6276447itf.5;
        Thu, 14 Feb 2019 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AGa5YP8yQspqwchtP1mq0Y6YPWG3uTOaM08OkWNe0PU=;
        b=eR5soJNanPo4XY4wwUyLGcI6VNF1BvAH6trErQV1wzdHIPro/Zr5oiecJSSC9XdQb4
         a4M5x7mrKz5RJJpCvqbKw2HAJ78EdOq2SSfWcFbmz2Jyqi7E7gyzHNTNxco6o5j5QiGX
         6HdUz8nWAqlyoJtWg/WSVYKGJQzxWy/HfLaJCzcq1GQMwdNoL2Nb9qNEAyQvDafAA/YS
         sRihSuyHFyJDyF5yLohyEVXRaoKW1Cdgcbc0BdBliwUDYVB4m5GMvyz4hqpa0I1oVkNH
         0sOzE9fCQIiW9ia5a3Q8nl1Mw5xGC4MLrsP1SqGCBD6an+hda9Pjmfu5l8wXGU9m9bRY
         NStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AGa5YP8yQspqwchtP1mq0Y6YPWG3uTOaM08OkWNe0PU=;
        b=fP2JatZ7Fru6+qyHZi0iFuWtcJF15foZFyViT79SHCibjyk53S2Fn5N55e77Sf43PL
         FVBPbu1MrKlldozJm5re7gJIKRvBzaket+w2gN5NhBHuQp+N/xfQ2eUsZ8tku/drhsGg
         7Adma6wADOnOd4xETiQkMBfBdGcoDKJMa/tTXyXWneFrXa7pCtY4w5Y0vnMLRmJT34/U
         gcMGn5Sw6YsMH4ucJHrb/h63CEVWJTOZ0lyFwFH4YlvrLQ5ulTdO7i74QrM6wq+EKKRg
         uj3Ly7/vZILL5y7uogD2vdt6XlTYP/kwoyafZll7PpcJOVKeGgxHGrUWwbsH+CdffMAK
         qqwg==
X-Gm-Message-State: AHQUAuaCGTgk4gXFHwZvT0KQaKZloVLjP1BEk9oRNhml1TAGY4qwDY+P
        QXWSm13CoZTqBTQGdYgJbPhQXQhk7AB9+v1+Zig=
X-Google-Smtp-Source: AHgI3IYLw4FVgCbzeEQEiRhx/pAKxUhrIjGr0Dg9VHyUf9hFFjbGWGQrjYlWH2Oa9Eu572t3ErWwL9zHfTkbDqFI1/I=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr2419733itk.78.1550163364772;
 Thu, 14 Feb 2019 08:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20190214130910.9201-1-tiny.windzz@gmail.com> <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea> <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
In-Reply-To: <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 15 Feb 2019 00:56:03 +0800
Message-ID: <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Maxime,

How about to implement a thermal driver that is not integrated with gpadc =
=EF=BC=9F

GPADC on soc is rarely used now.

MBR,
Yangtao
