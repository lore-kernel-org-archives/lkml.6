Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6FAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB2920652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sed/V6fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB2920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIDLQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:16:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46178 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeIDLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:16:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id e23-v6so2008232lfc.13;
        Mon, 03 Sep 2018 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MKqd2MXJjhKCgfb1chKUTLu766OFgPj5WqnCVtEcjuE=;
        b=Sed/V6fXCENGxh4Utevem5L3L3eu2hAawHG+/rNFw8pFDHJgDJDtPECLwxkZ1vttvi
         3eWvEduS0Pf4n8eAv5ANEssPgbtfqpVBkAsqP8vk6QDWe5tdxtDufoXb0Tgybawi465O
         /NrQdAv70318igilFRKm4qct7/lk4PdKLUGgXd/zRMcy0nPJ7D9VpjOHI+Vj3YtqdvR8
         wqrCn7VrDSejOkO2llIVvLHqfUfyDPS0FeT7lNFVfnzJOwy20sZZKKkURWsgYWS0KeZU
         SElRQXIA5CeQOo7CL+o1upy6W5B6lIkLoQCP21a5+WE3OzAKw6YsU0VkdXk5AZnCjj4O
         AL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MKqd2MXJjhKCgfb1chKUTLu766OFgPj5WqnCVtEcjuE=;
        b=oWiCx6wqCp7YaiGw1c9ds512l2mVWGjGQF68twQ3Y8umq5szbwGx+EHn8LmPfifDYR
         hd84hAENIYz6ehk3do7K6fs1QpHmpn9aAoX1N585iljokQnOp9CQpmZlXfvvBvjiXkyO
         EvWII/4Fqhia90xpaAD27fi2eO1IsDVuyBvz0T6+fL2FWq8QnquIINUaMUjhcwn5tyRK
         dmvWwKbQYvwSZ3dZDi0iP3MFBGDQzBckme8U7oPz63oo4poZk/FAqeYWvzW21w/B3Ck8
         1JWh57zDCm7NG8g3/A5Yr0SKWioTrzHbKxdtY7auF6D0aELn2jv3de1leqJY1jMkKjPY
         NWaw==
X-Gm-Message-State: APzg51AuAf06dagewq11lWhseFG1KQ4Tlt4g4JiJ10x243NXbcQ9Lnbd
        ix9V4aTHytU13qPLGOuV8XHAIUwncucjxr0JxFg=
X-Google-Smtp-Source: ANB0VdajitfF62Dd3VkaR5jDzIvUD9rabu/iY0CoHK7xu5k+kxmnNA9GhvccY9g6a7Ax7fOCW7fZT6Q6zf3o5h58IvI=
X-Received: by 2002:a19:e017:: with SMTP id x23-v6mr13872743lfg.14.1536043973212;
 Mon, 03 Sep 2018 23:52:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4c3c:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 23:52:12 -0700 (PDT)
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 4 Sep 2018 14:52:12 +0800
Message-ID: <CAAfSe-tVJ1P30y+aj-2AsEtsbQ=O3vADxZNc_UW6ri92suGMgA@mail.gmail.com>
Subject: Re: [PATCH 1/5] serial: sprd: Remove unused structure
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 August 2018 at 09:34, Baolin Wang <baolin.wang@linaro.org> wrote:
> Remove the unused reg_backup structure.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 828f114..1b0e3fb 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -95,19 +95,8 @@
>  #define SPRD_IMSR_BREAK_DETECT         BIT(7)
>  #define SPRD_IMSR_TIMEOUT              BIT(13)
>
> -struct reg_backup {
> -       u32 ien;
> -       u32 ctrl0;
> -       u32 ctrl1;
> -       u32 ctrl2;
> -       u32 clkd0;
> -       u32 clkd1;
> -       u32 dspwait;
> -};
> -
>  struct sprd_uart_port {
>         struct uart_port port;
> -       struct reg_backup reg_bak;
>         char name[16];
>  };
>
> --
> 1.9.1
>
