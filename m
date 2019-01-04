Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93535C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7CD21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfADWbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:31:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45403 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfADWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:31:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so18900302pfd.12;
        Fri, 04 Jan 2019 14:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4i3rq1bSJoW7TTgWRfRJrR5quABj5cjJJx7ew3RSbo=;
        b=YBNtwAvjPanZxwThqFneeL38OaIJESU67FmWnHa3KaFXddeOEsI4CEOKp000HXjEpp
         yY9o6Y7R4RFJXipC4kwgJLGnYv2GsWqMn/HEta6msD6BZFDINq+kBbhRHDJsBp0sU+fK
         0se0WGJ3uK8SDZ7pNcshMeTpJ8gzC9QXSYFzwnW/G+nwSdy4qr77J8Ah02X3s1xqWeVl
         4GtwalrZVHC9FX0yd3Cy9FE88fpkL3LyF6h46fKQc0+zxJ63jmY1WcAWzJhMjpL+b06d
         OblqqWIUmI8AbhGaFiP+vi3uqrDTRBciQIetU8WN492UM5ZqdMaze2KUt0c4WDo8+ZF/
         uIOw==
X-Gm-Message-State: AJcUukdMrOFsRU3fYzLWfc2ZzFakna1PMbnEUydTVB4d+ZNKtDSImSii
        1kEOGtJOLczh7RkHurRr1gP07tVoKK/dPnD5B2U=
X-Google-Smtp-Source: ALg8bN5xQFzslBqBqdamVFgU6WJ3/p2a3Ln5MMaMYpYR87sLA22GOSdxoQK9DSJHw10OAOXgji0iuLslURVeSev2er4=
X-Received: by 2002:a62:64d7:: with SMTP id y206mr14622578pfb.84.1546641100362;
 Fri, 04 Jan 2019 14:31:40 -0800 (PST)
MIME-Version: 1.0
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com> <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
In-Reply-To: <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
From:   Andreas Gohr <andi@splitbrain.org>
Date:   Fri, 4 Jan 2019 23:31:29 +0100
Message-ID: <CAO00Eh6F4CMF_rPTWjFCon_87wSxA-vRm8DqSw=0sxSbpC_39w@mail.gmail.com>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     Bastien Nocera <hadess@hadess.net>, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Designs that only provide the INT line are able to operate the touch on
> the default I2C address but will not be able to reset the touch via
> software or place the device in sleep mode.

This sounds exactly like the problem I'm having with the One-Mix Yoga
2 I described a few days ago.

I applied your patch on top of https://github.com/hadess/gt9xx, built
the goodix_backport module and loaded it successfully. The touchscreen
continued to work fine. Unfortunately, after a suspend and wakeup the
results are the same as without the patch - the touchscreen is
unresponsive. Unloading and loading the module again does not help. No
error messages whatsoever in dmesg.

Andreas
