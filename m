Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3DCC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B4B27C2F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KDJMhmZv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l/CTxlZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B4B27C2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755377AbeF2UCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:02:39 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43213 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeF2UCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:02:38 -0400
Received: by mail-yw0-f196.google.com with SMTP id r19-v6so4022854ywc.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7mHzmz3qfmNfrj5waqY0wcvZQY5Vnun/Vy9c9x3vwMs=;
        b=KDJMhmZvzVEldm3EwHqF38YG3KKwDAPgM2NQohz5DXscc2dQtvjJU8cUOPfIOSWoXE
         /jCX7fayAgxJ9SJlFiDKEyUztMUMbzB5EYlkjn7pFA8abF4PU/SJKkzFDT+0rHluEtTk
         SOsCZLY4ydaY4/rjVh+HvSrNbwIzBEVaxJ+bCESd5ZSPL3SoAn/bNJVfrz2hrnsGt99E
         IwreKUqxR+H+/xizIuT+6plUrDsE+9hY2evlvf6Z/tRZiQQap2PL2IvNc/KyYyclUiXq
         EADLvAG2R34hk+Q/2SK7Hq2EnWj52s4+M9FQ40/GIEK+Uaoilz8ZF91v5uU0MO/BjwH7
         JLyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7mHzmz3qfmNfrj5waqY0wcvZQY5Vnun/Vy9c9x3vwMs=;
        b=l/CTxlZdJY86nAGmuUdX2cEQI71hSJdDasOYZfotmR9BQ7PI6VZ+fkeh1XHfF7VZeW
         +LDAyIotP1WepNhUQBEs9IRA+3ocjaguKBVFcRdPUQSke8DFJMmuDc7+B51olByIxqdF
         6wfPU+fjLe3OBqBVrsibHYfGzC2fdqvyjdOlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7mHzmz3qfmNfrj5waqY0wcvZQY5Vnun/Vy9c9x3vwMs=;
        b=iXUp2s/wKd+zRfh0RQzVW8232bvcja5EmD7Dnb5eRPURzZ+Wau1e3Yt20wXsFfW0Kx
         XYjalZSHhVqCfj+GD2uC00pg2bj/g22NNOjYvibgBz9gJbhnBeTcOA12TykPOQ5IgYtY
         BRKHALwSxB/V0StDavuU/tcatdkvgcU+UbsFZeGs7eNsBHNNrghrQJisHAbzL2Uc/rAy
         SBGg1d5zURuMEPt1BliMRe4hp7UzdvBPB89DuQaABvWSvHQfDjE9FfvzE9UCXC8fS5sK
         C7JobxeQqnWqsV1KPZclmT/vMFSa+dvjzcup+oz2sNI7Tm2p3gI3rGalMQvx2kXgWDWJ
         EftQ==
X-Gm-Message-State: APt69E3G8U+pXTelRqS0dE2jfhZgEM7OBniOjl8cZs52KF8MCozys0Ff
        +NoEAM9vO10YwNaI9qmDyCYLIsJWpQcTdHK+Oi99Wg==
X-Google-Smtp-Source: ADUXVKL+Sgog2mTqLr5HHswJO/TAHPDDK1piBs43/0+HO18vphjFkc2X9RkomUALnm/dbJ2RoPmg98Lq3O5RKg477NE=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr8039923ybj.343.1530302557152;
 Fri, 29 Jun 2018 13:02:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:02:36
 -0700 (PDT)
In-Reply-To: <CAL_JsqKKjcvLOxoWvqaZYJwEoc_s_B-0KnAfhZYEg9Cwytd4sA@mail.gmail.com>
References: <20180629185212.GA37517@beast> <CAL_JsqKKjcvLOxoWvqaZYJwEoc_s_B-0KnAfhZYEg9Cwytd4sA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 29 Jun 2018 13:02:36 -0700
X-Google-Sender-Auth: J1wEGAIlCBXpvU6rJPKPmj2WQI8
Message-ID: <CAGXu5jKstvoro4Gx=BKjVi6R4wYtWMsp=OfxJXsywSfKOehwWA@mail.gmail.com>
Subject: Re: [PATCH] bus: imx-weim: Remove VLA usage
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:45 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jun 29, 2018 at 12:52 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> switches to using a maximum size and adds a sanity check.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Not sure how you came up with the CC list, but you should probably
> have some i.MX folks CC'ed.

Automation for the lose, apparently. :) Looks like maybe the
MAINTAINER entry for IMX needs a drivers/bus/imx* line added. :)

Adding more CCs...

-Kees

-- 
Kees Cook
Pixel Security
