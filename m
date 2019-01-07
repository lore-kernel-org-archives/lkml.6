Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9623C20660
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbjwHpW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfAGDo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:44:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33167 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfAGDo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:44:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so34867442oib.0;
        Sun, 06 Jan 2019 19:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=il5EYEvlVMHtJoIOYPOQFE5SNOKwK+b+o9VV+R/V9kk=;
        b=pbjwHpW71bpKFquMHLrEW5678CfRgxiWKtbrl1jv947rHphjXiXujGpr6vhc9fgsMB
         doSx9cujPk6WV3T06I7barhvX9TK0wY/JFF6zZxz7OK4XwdnbDDGUZculSa6ZYrAusYr
         IL6ciSelo7rse08nTOLV5dhYc9Zy8VaEgVY1HOvA+zullEuxMb3fkuzlf1FTvEyRQKrB
         ArGfr6v0kQ1d3FCa8L+D2bQiSrT4EkgFB/7Vh16P3M/2MyarzRx8ow1lXQL3y6xDFI8d
         TSt6feydm5QHKoNgxVaLeY/8bWTtqUtNWiNpMdWG7zh3xZI0YNl38lk1CkAROnGS0YEo
         V0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=il5EYEvlVMHtJoIOYPOQFE5SNOKwK+b+o9VV+R/V9kk=;
        b=WzlSydeJV8Ow04SEMNmLZvZELS+FvnvrxRWwTdvBiOwKk+Zjx2BV80xUTZtU4DB974
         T1mrXG3vBOQJgRLYEyGLASJACOgye8Ffda1R0PMtNHJRoVOqUBgmbbB8YjBVN9bDuwCa
         X+LxQZOcH9yIpBHTb4wdxjoP5mEQyEJ1i9s/PDmvvpFcoJ7qFnQc/mxR0QswzuXC6W2r
         KINm1eYnlEP6FU6juyOFtPnr6oxHdlSeb2yimeSlfy/NN7/pX7DUeM0F+6XKsDtR2/7x
         y6xrsLBKdnx1GJV5piVTIcp9qTD2O0NXmG5ObQBV3O1ysOnte4VVdU27p8ZaLjWTE59B
         WC1g==
X-Gm-Message-State: AA+aEWaAa5s2SeaDexw2lYfWHk94E/v6wF69DNUs07wIt/721Ypm/0rO
        OV5nS+wz3SgeOOAKcF0uamzkjvQzRMzAZ07wMiJOFg==
X-Google-Smtp-Source: AFSGD/X1jzgCT25y7EUxafZ/qJwUujCT17A+9nTx9CX1Jywdzz/5JsrkE9MELrXyVZg/lJycRWHAOH72waBdDk+XB1Y=
X-Received: by 2002:aca:d4d7:: with SMTP id l206mr42268767oig.320.1546832695306;
 Sun, 06 Jan 2019 19:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20181230163143.21030-1-ap420073@gmail.com> <20190105.141021.1299321405902891635.davem@davemloft.net>
 <CAMArcTUGujArU1L8L=n32yKbT+MwuUEm6S8C=am_EGQ5GG3jQA@mail.gmail.com> <20190106.085535.1209544587823450673.davem@davemloft.net>
In-Reply-To: <20190106.085535.1209544587823450673.davem@davemloft.net>
From:   Taehee Yoo <ap420073@gmail.com>
Date:   Mon, 7 Jan 2019 12:44:44 +0900
Message-ID: <CAMArcTXvCMPHarHJy19QAr9AKb4w2RNQ-E6JJoBhuD3eGhHkSg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] umh: add exit routine for UMH process
To:     David Miller <davem@davemloft.net>
Cc:     Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 at 01:55, David Miller <davem@davemloft.net> wrote:
>
> From: Taehee Yoo <ap420073@gmail.com>
> Date: Sun, 6 Jan 2019 14:34:52 +0900
>
> > How about adding a new PF_UMH flag for task_struct->flags to identify
> > UMH process?
> > By using this flag, the exit_umh() can avoid unnecessary lookups.
>
> Yes, that might be more efficient and eliminate the high cost for
> non-UMH tasks.

I will send a v3 patch.
Thank you!
