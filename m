Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108F5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DB621747
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DB621747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbeHNIdU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:33:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46015 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeHNIdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:33:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so9438705edq.12;
        Mon, 13 Aug 2018 22:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QpASM0hl8ZygavrOK4vos9mHsFsVc7n4J6SUh6AdhUM=;
        b=lvGy9qB0WybFt55IGRc0FnBr3o26d3FlsKBfotWerem30DLkT5prE/tv65BhmNDk1L
         pYwxrW+eAaOZNhtmsVzCCoUDT3k/xk/KX+WDD/2wopmPcxihAUwDaO94J9Zgitv0F/k9
         VfeTwm1wfK67BSqQc8y0vy02UUhVu0RGAdrgFlzpLZ/pbcxWdqm7ysj41UZCIF0NyAiV
         TC2mQXmZOEADem6uvLMtE31Jc9SFLvWdlZY5BaOxV04gFErlIUtQ5SLyKk962BcfcarL
         Qqdzrr5OoZdGOYj6qmOtpPSNX1Q9uMTBgpZwL6F+L6s66w5aKnY7qqEZRhJ6eX6eWxQU
         eWVg==
X-Gm-Message-State: AOUpUlFAnf4db/dVI/+3qGz8tYnGeGW2ULGU8AVzb8TnefWpn1uyucL2
        ZUXtj9LYl6RC+OLlVbV1f/Ag4HOKWiA=
X-Google-Smtp-Source: AA+uWPwcxCv4KbOq+QFqBngvgfjxhHPN6wW2Onn3MURNNXZm2GQWian5BxH5d35l9hXUOCZwqA00Hg==
X-Received: by 2002:a50:cf81:: with SMTP id h1-v6mr26656200edk.35.1534225662846;
        Mon, 13 Aug 2018 22:47:42 -0700 (PDT)
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id w3-v6sm15308305edb.16.2018.08.13.22.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 22:47:41 -0700 (PDT)
Received: by mail-wm0-f48.google.com with SMTP id c14-v6so10989451wmb.4;
        Mon, 13 Aug 2018 22:47:41 -0700 (PDT)
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr9937286wmc.58.1534225660772;
 Mon, 13 Aug 2018 22:47:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 22:47:20
 -0700 (PDT)
In-Reply-To: <87f1db37e70473cd1a77f5e0d2f9a779c6afe7db.camel@aosc.io>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180711083036.7attjq4hm5ay5gmn@flea> <2309112.TTVI9Fv1ar@jernej-laptop>
 <20180724123741.bbkjgy2uwmzsj45k@flea> <87f1db37e70473cd1a77f5e0d2f9a779c6afe7db.camel@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 14 Aug 2018 13:47:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v644n_CLYkLVqu6ALhpQ+nF-OQ=JRR0KcLENs4LQbDcPHg@mail.gmail.com>
Message-ID: <CAGb2v644n_CLYkLVqu6ALhpQ+nF-OQ=JRR0KcLENs4LQbDcPHg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 1:43 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> 在 2018-07-24二的 14:37 +0200，Maxime Ripard写道：
>> On Sun, Jul 22, 2018 at 04:43:56PM +0200, Jernej Škrabec wrote:
>> > Hi Maxime,
>> >
>> > Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard
>> > napisal(a):
>> > > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
>> > > > This series fixes several issues found in R40 HDMI patch series
>> > > > after
>> > > > it was applied. Conversation can be found here:
>> > > >
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.htm
>> > > > l
>> > > >
>> > > > Patches are based on latest linux-next (next-20180710) and are
>> > > > ordered
>> > > > in such way that they don't break R40 HDMI at any time. Because
>> > > > of that
>> > > > I suggest that whole series goes through drm-misc to preserve
>> > > > that order.
>> > > >
>> > > > I also tested those patches on H3 to make sure it doesn't break
>> > > > other
>> > > > platforms. However, it would be nice to test for regressions
>> > > > also on
>> > > > older SoCs (with DE1).
>> > > >
>> > > > Best regards,
>> > > > Jernej
>> > >
>> > > Applied all patches but the patch 10, thanks!
>> > > Maxime
>> >
>> > It seems that you forgot to merge some patches:
>> >
>> > [PATCH v2 12/18] drm/sun4i: tcon: Add another way for matching
>> > mixers with
>> > tcon
>> > [PATCH v2 13/18] drm/sun4i: tcon: Add support for R40 TCON
>> >
>> > Without them, R40 display pipeline can't work.
>> >
>> > Maybe they are in your spam folder?
>>
>> Thanks for telling me, I'm not quite sure what happened.
>>
>> I've applied them.
>
> Sorry, but I still didn't find them in linux-next/master.

They were applied too late and missed the -rc6 deadline for drm-misc.
We either have to revert the DT changes in 4.19-rc or somehow sneak
in a patch that prevents it from crashing.

ChenYu
