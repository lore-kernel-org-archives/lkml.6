Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D0DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697AA206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsoJmsmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfAIVSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:18:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37089 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfAIVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:18:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so4250603pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5k0BDd2Fq4Ire4k19JuqBM4qr2zKh+LQps6gaEAHcs=;
        b=SsoJmsmkKbFHViZWDifUulSoG5/lYQkQ/x455rnEeF4WeAW+fhR9TgGK6NKah+Abhl
         IDpLPPCVFWdRplNyCT2SowXSkbDG1nYOUM2ajoLX7rYuSq5hogaDpzS/mIwkwRb6Oz5w
         8nDSt01akthA2nuVZyMR92wo58EgUb4yz9AjjKWsPFUR624dc4qIFKWoumjlwZTttkmY
         9Y95V7r3H70T3BQI7zji2qyu65ss37qN8pfqV6m2F1XHYxnnPVCeuRsiUNCFxYNNGaqd
         lM1ZDEdjJUenR1NePit3KwTmbOckBpUft3MpIlUSdEOEMpnyAgARcL/m3mL3aG0zpzHx
         yR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5k0BDd2Fq4Ire4k19JuqBM4qr2zKh+LQps6gaEAHcs=;
        b=OwE7mpvWPo8MxyejibsTn4yRuun/MR3BUTBQzDzonUXNZkP5AYVW39w+XzRyuiIigB
         FHuHzqcQURmjBQN/Ig6WFih6gbZNYpttrOs84Kbkx6Ebn3HPRnJPy+YVqTBP1odsh8zh
         811A43E/jfqftKRATfZLKu9gOPswvxZ89zAKUvpP/H34y/n+lSTLqsUgbod1aEAdLcXO
         8IF5oyTEexoE06echszAno6f7ItP+p8mTeGJB8K4r/N3Cjy4rA7e0BZFENRWqRBqSZ2v
         H7T2K67C8mzOopnrRKUkd+UsygJOn4QZA7xJNWyhwJ7BGadllTlvyDi0wRsTjAn27V1F
         sAxA==
X-Gm-Message-State: AJcUukfFY3ANLdBXypbIXRbDCoNfxuaDA6CIifJoVVSNzDScMsWSoAUk
        LZfuogFqhkiX2tYNkun6BUBT7A/oZvQaOZWKBG8NMg==
X-Google-Smtp-Source: ALg8bN7qgGozYgHZv9k6oOFX7i5iJl/MyHGBwXBp5UbJDktQ5ZzpGu26V0oWEsWIZo1zTy0I1eal7XDbLESfExZLt3Q=
X-Received: by 2002:a62:9657:: with SMTP id c84mr7744990pfe.77.1547068709264;
 Wed, 09 Jan 2019 13:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20190103194308.4217-1-avladu@cloudbasesolutions.com> <BN6PR21MB011407C0A4C2EC0BE7A3DB41CA8D0@BN6PR21MB0114.namprd21.prod.outlook.com>
In-Reply-To: <BN6PR21MB011407C0A4C2EC0BE7A3DB41CA8D0@BN6PR21MB0114.namprd21.prod.outlook.com>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Wed, 9 Jan 2019 13:18:18 -0800
Message-ID: <CAA42JLa3QEYg4-LbHem9=7ahSbte3czWAJzxRXiWvt2phxeW_Q@mail.gmail.com>
Subject: Re: [PATCH] hv_netvsc: fix typos in code comments
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Adrian Vladu <avladu@cloudbasesolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        apilotti <apilotti@cloudbasesolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 4:13 PM Haiyang Zhang <haiyangz@microsoft.com> wrote:
> > From: Adrian Vladu <avladu@cloudbasesolutions.com>
> > Sent: Thursday, January 3, 2019 2:43 PM
> > To: linux-kernel@vger.kernel.org
> > Cc: Adrian Vladu <avladu@cloudbasesolutions.com>; KY Srinivasan
> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>;
> > David S. Miller <davem@davemloft.net>; apilotti
> > <apilotti@cloudbasesolutions.com>
> > Subject: [PATCH] hv_netvsc: fix typos in code comments
> >
> > Fix all typos from hyperv netvsc code comments.
> >
> > Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>
> >
> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: Sasha Levin <sashal@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: "Alessandro Pilotti" <apilotti@cloudbasesolutions.com>
> > ---
>
> Thanks.
>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Looks good to me.

Thanks,
-- Dexuan
