Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59282075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAME6Hmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59282075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeIFSWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:22:03 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55958 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeIFSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:22:02 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so14785617itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMIoBcyCnnsiRKrbYO+gBBx66uwywt8vjOE+4okCjUU=;
        b=ZAME6HmjjFEx/3AkJwjhOqiWmFpgXSTNyCPi8TtSj7NpspIZoR0CqkCLrzPDE4+B0s
         juJYks+mLp0fuFXFNFcTl0gbQnqfkIR7+81/GxzWX2zNOX0IEyzayup9ICK53zMiJzVD
         KgN44TtLvdUG4HLDD3l5NxBRzMQS/cWci1oYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMIoBcyCnnsiRKrbYO+gBBx66uwywt8vjOE+4okCjUU=;
        b=EkZb9FQVe+2Edl64xle8wy1WYPm0cxWTOSNVh5ldhHuLVsXO1kfrYerxtxQk+bpDr/
         a3xQ5MnwtKJbeC0RDOSityFA1J3VJEsCh8fN6ZNz9p3yjcLhM1FnfeLNJQlPiRlQFHRW
         KAErR7FOZp9Pmm3mzVmJIMxN3hveE4dtnlQJQPsMcdg5bcuMYBlZJ+B0bmfSk1PAFTkg
         8EohOc78e/OlVyWSvjENU1EtRl23PkUs45+P0L6fYf+kethd/i9V1h8I+Un6/31qYswP
         qx0MudZIq8ukqAYvwSOklSkv91ZaFmLqE+FjQrVj0aY2xHJaB+51owpJzuV8K8Im954p
         vQUw==
X-Gm-Message-State: APzg51CLEoVbr0V0wxUMMZR0JKeiELj+NL2/tZbXErhvpBXQGjqUaPi0
        XTTukJ+Qh2iSltF+nH+XbYtyE5QB5JEp/pAZEgDHPA==
X-Google-Smtp-Source: ANB0VdZF0rdH0rmSBp04lgsyilZHJD6DADy/zf1ogg1GoKfHowr5AYTOoXkQeJYftIIFMMaiXVuI3iEf4FbXI63GnW4=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr2801025itc.16.1536241584783;
 Thu, 06 Sep 2018 06:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Sep 2018 15:46:12 +0200
Message-ID: <CACRpkdakAAAFKfRFeB_8kUCyGts_7sojVwyexe4aL4QQo2CcGg@mail.gmail.com>
Subject: Re: [PATCH 1/5] mfd: lochnagar: Add support for the Cirrus Logic Lochnagar
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:41 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>
> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform.  Audio system topology, clocking and
> power can all be controlled through the Lochnagar, allowing the
> device under test to be used in a variety of possible use cases.
>
> As the Lochnagar is a fairly complex device this MFD driver
> allows the drivers for the various features to be bound
> in. Initially clocking, regulator and pinctrl will be added as
> these are necessary to configure the system. But in time at least
> audio and voltage/current monitoring will also be added.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

It's a bit confusing, maybe you can clear it up:
it appears to be an I2C device, so when you say this is a
"development board" is there something like a board
controller that is accessed over I2C and this is what the
driver really probes to, not the board per se?

I guess jamming this card into the I2C slot of any other
system (would work fine with a 96Boards LS connector
as it seems, actually)  also involves connecting some
I2S or similar on the side for high-datarate traffic?

This driver seems to only concern itself with the I2C
board controller per se, not the board is that right?

Yours,
Linus Walleij
