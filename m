Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E287C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C06C20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfAIKNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:13:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45309 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbfAIKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:13:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so6784909edb.12;
        Wed, 09 Jan 2019 02:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7yQbhSiniQkONQT8QwDM7yKGzR8/XPXa9/njSg9+oE=;
        b=QXejNRdgcFEnHXEz9pgobfCES06gogbTeRqmBpK3anC25e7nYj5AFWz6Z9hv6ogxOa
         NqItM8HR2vFHp/+Nu4CCHSr2R8FUdV/a8drXqp70xvY5zySDAsA3XO/aUUlI0QyIpGkI
         4SOfOH7Jix7Y/hFJowtl2L1UcWumTyzsTTLXyFbBAmeeyXgrqP4VAapxs/y2+5BN1z5M
         Z9qUmqQ3yvl87dzKwVCdQ3BXDDhewanBIxpk5LII49nnWT4fC0P0grO6l4tr6f657dmS
         K8+P7Uz/PjSkyyU8aZXcDBFR/Juti3m+PYAFIXYv9H/qbBUl3bN/L+j+UEJEr5VhewFk
         WWyg==
X-Gm-Message-State: AJcUukemmNVctSU/iizRgLnTFaMYNFQ15QbNab/h/joK61+uXipWkIP+
        086hXXarBcoNimk1INftsLjr/HAvR7M=
X-Google-Smtp-Source: ALg8bN5TpVTJK5qWK2mV9Rl1q9L090wHgfGCOot2gJCyjFYT1Kj8TdTk3MQr1v3MdC9Kf8p5Yy1DFA==
X-Received: by 2002:a50:8f86:: with SMTP id y6mr5560142edy.131.1547028820334;
        Wed, 09 Jan 2019 02:13:40 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id n3-v6sm582856ejd.35.2019.01.09.02.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 02:13:39 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id x10so7012262wrs.8;
        Wed, 09 Jan 2019 02:13:39 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr4272475wrv.87.1547028819339;
 Wed, 09 Jan 2019 02:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20190108191840.16007-1-jernej.skrabec@siol.net> <20190109101228.alsaaw6s57dbapfe@flea>
In-Reply-To: <20190109101228.alsaaw6s57dbapfe@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 9 Jan 2019 18:13:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v64QM9gyPTtpw0C0fpANW5R9DEsWFSDA_tJPYhdgF_FAhQ@mail.gmail.com>
Message-ID: <CAGb2v64QM9gyPTtpw0C0fpANW5R9DEsWFSDA_tJPYhdgF_FAhQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 6:12 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Jan 08, 2019 at 08:18:40PM +0100, Jernej Skrabec wrote:
> > Because "ethernet0" alias is missing, U-Boot doesn't generate board
> > specific MAC address. Effect of this is random MAC address every boot
> > and thus new IP address is assigned to the board.
> >
> > Fix this by adding alias.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Applied, thanks!
> Maxime

Might we add a fixes tag, so the patch gets backported?

ChenYu
