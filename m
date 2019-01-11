Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30747C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DE720870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqRYTR6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392038AbfAKPMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:12:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39371 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733223AbfAKOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:15:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so13083217ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=caIJmW1QPaGcYfkIAx9ZdJEAne12sIEn9QhWFCtOLQE=;
        b=KqRYTR6jwCa86CLWPeD/WV3tPmjNo+USntIrIOXBe3XLkjwy3DbZjUQ4I+F/VpqtPA
         I+zUQdYJKz7iUWB3LIRY1Ib2lFnTRDsi2xjTbBqm5Vawc6be3D8j3L0A4WKZAkYiSpfW
         1bJ9KEKfJ4LF5iCSflBcfyxli940UNtxzEk2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=caIJmW1QPaGcYfkIAx9ZdJEAne12sIEn9QhWFCtOLQE=;
        b=m3jb4w4NQBDuEdLFkMgWF/3q+BI5zSe8CEQ7kRe4Mi7PO/2mGTsgR+fsfeCdbe0xA0
         5FkOMMyVfFKpZsRres/7CzdZsdKuff+9L1k7EpwO0nHkskLeaOaNDpamz2oznkAK5w/V
         6+OL9C0FxG4CAuNAxX2PMhtwN2zfWi9VmLKDNPIG4eg1tULuBTACN0P0SrKxh7Wr2B6x
         2DemzoqRJXkKPxaOx0d0sZZ7rD0gZpyLeTQOH2a3ST4uT9ayJgn4wfuW1Lnb2titSn9u
         uAvaRzUa0nzxob5YU1SOrWTMUMxLwPmU6pLM97YfH+137IZTw/O/dd/o4lx0FF5leZUQ
         rknw==
X-Gm-Message-State: AJcUukdY0mQUsT4lKBxyY4keCsila2liE66ijWX/QO9owNOwjGC9dOKj
        Z/5Z5Cw9IswIPBUJXc76pky4x4yLDIfQiaPCGOx8TfLB
X-Google-Smtp-Source: ALg8bN6eBzXbN20WRhixlD+wBbltxfIdaaPCp5F+08zHeFCdN22ZkiquwELtuIwfjtgcGzCizGw9ndGRhjRN7FToBDw=
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr8678437ljk.4.1547216106772;
 Fri, 11 Jan 2019 06:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20190108200311.4969-1-amade@asmblr.net>
In-Reply-To: <20190108200311.4969-1-amade@asmblr.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 15:14:55 +0100
Message-ID: <CACRpkdb6EPraP+Rs+--y0-83zeCWwiXhZxvFqJuH-JtDMzmGag@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix CM6206 register definitions
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amade@asmblr.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 9:02 PM Amadeusz S=C5=82awi=C5=84ski <amade@asmblr.n=
et> wrote:

> fix typo after a recent commit causing headphones to have no sound
>
> Fixes: ad43d528a7ac (ALSA: usb-audio: Define registers for CM6206)
> Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amade@asmblr.net>

Ooops sorry for this! Thanks for fixing it!

BTW FYI what I am trying to do is get the code in workable order
to get the S/PDIF in working. Right now output works, and I am
going to test whether it works under windows.

Yours,
Linus Walleij
