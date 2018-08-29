Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B49C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EBF2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q082jdgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EBF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeH2Ltx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:49:53 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44061 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeH2Ltx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:49:53 -0400
Received: by mail-io0-f195.google.com with SMTP id 75-v6so3675963iou.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/P1fyCywsLg/OlvttoZMQyBFkGeepCaT5JF4lG8jNE8=;
        b=Q082jdgdBJMSdmL0vgQ/AIs0KFTmWD9YfHTNxI0eR1NNRNHg7CsWzV7qsZLms1JPJT
         MUpoG4U02F07x6GUM+83PMhSSnHx0OAk0zGDN8Ez2DfkCbjJhf93dULhwdUezBXn2FrY
         DjZOThor9/CBsZVWUrFVKTKRrcxKMqK6ii7T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/P1fyCywsLg/OlvttoZMQyBFkGeepCaT5JF4lG8jNE8=;
        b=jl3dCxvga/UVwaTtmmmz23esEpqsdJhjiUe894Aipbb1OC5akmXT2KIxikjhn5Nmo1
         No5XljNyT6taL6I5nj3/TWruCJu8OW4BmTDR+yDwYpmHHIU9JNUljwNsOqn4sE/ZirCP
         XTb5cbACtDuH9pNI3RkKSm+ywX07d/tQoM1jqsUw72n6tuXI9T78ixbpe1geN0pAmZBU
         afzNF92Ras272XIZTv8ViN9f/+Q+cYD0exiagBjPprabg2FpaG5n4E40tqsBCvx9eL1/
         10kJD0bWYbxPEWHqthwzIW2PD02tF6EotHR1WM1imIEghlv8aoE3TU9Jez/x5u8VfwYo
         mhMg==
X-Gm-Message-State: APzg51ApEHutefNlXWeDvPyv3om+BtSIJAspeX/4R6UmLFAQUrGqSNh7
        affCCmA7CaVtFqQSjSqXweowhsPFltZQ8PwmmoRXwQ==
X-Google-Smtp-Source: ANB0VdbKk95advp7FkG2jQ7oVqEMYmi3Nq9D4fBEGNEZLpNqIHgb/fqi4O070iEMi1I7MkIpVmiOqkPfAipujVTIKGY=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr4177450iof.304.1535529256940;
 Wed, 29 Aug 2018 00:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <1533522556-55055-1-git-send-email-aditya@kobol.io> <1533522556-55055-2-git-send-email-aditya@kobol.io>
In-Reply-To: <1533522556-55055-2-git-send-email-aditya@kobol.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 09:54:04 +0200
Message-ID: <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
To:     aditya@kobol.io,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        gauthier@kobol.io, Alban Browaeys <alban.browaeys@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dennis@ausil.us, Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 4:31 AM Aditya Prayoga <aditya@kobol.io> wrote:

> Allow more than 1 PWM request (eg. PWM fan) on the same GPIO chip.
>
> based on initial work on LK4.4 by Alban Browaeys.
> URL: https://github.com/helios-4/linux-marvell/commit/743ae97
> [Aditya Prayoga: forward port, cleanup]
> Signed-off-by: Aditya Prayoga <aditya@kobol.io>

It would be awesome to get some feedback from the MVEBU maintainers
on this patch set.

Who are most active on Marvell stuff these days? Thomas?

Likewise I'd be very grateful for a nod from the PWM maintainer that
this is OK with him.

Yours,
Linus Walleij
