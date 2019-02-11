Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F8CC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B2A2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAI9zsoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfBKWaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:30:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36658 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBKWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:30:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so1054219otk.3;
        Mon, 11 Feb 2019 14:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4DiyzXag6XNoVFg7/d5HN9eMmepXSzwGkMkkAmuU/8=;
        b=gAI9zsoiS+b8AipSsD3qpmpSVAIW5/G7uFMxls8BlcL0p6KlnSmYUwQrEsuAZv59RS
         J0ckt/R0/qNNVPHfVe6EzF48QNBXkdLwHfEuDJzqVRrRiJ89nY6SkdXZY9W6GnxRvr+8
         R+tVnLBWegg2TjG0HzLx7aYHnu0H04CbSIDC6zT6k1xOB052iSPjfP2sOHG0c344sVcv
         0g96GIv/boIMiVs2ljk4SXkg2KEBQOrUb0nRjfvSMfT4gDKyO2CgG11Oo1+SOaHhpZ7Z
         S7Tveo2AQ+EgDDFOzjjItJVoNErQ3IR7xUgZznq0IImXoiQbhX7xdPzbkHH9SBbdiMzf
         RfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4DiyzXag6XNoVFg7/d5HN9eMmepXSzwGkMkkAmuU/8=;
        b=hMBSZxHQNIDNa4It/YHul5vXrxzUF3BUsx1hcO3uR2a68yZ1LJri+CwKNss0y3E9za
         uD93vVqFzDEWy2P4SflBSAjMd8VER7t+p0sMTZUSyKX2f+u+O5MwN0dKR7A6cpCs+GAh
         YClv48DlypLoJHZLWuvmc6qAJV2By/5NGmwQlVADEgD60cCCdhKJzJQNa0rilet4y+kH
         K7Cas4pe/eKdxl6j7v0dfVi+urazsq9MyVcxDC9MiE0VTYitbsNqofaN5ePcv3Kn6K3x
         Je6gXBKui7srkxki3mrwZF3qJaHoburLCNjB3aGJgDaXXyK9u3dk+iBuU5ZKRvepbI4p
         yB4Q==
X-Gm-Message-State: AHQUAuYEmEtVSNPRcPu5jDCxMnbqOplhl24J5Z28OVuZudn72e5IA8Jg
        zMqblmMlJOJLUU8ItfoNcL3FoxECALhl0ow5Gdo=
X-Google-Smtp-Source: AHgI3IZhD7O4g5bItcIGHccEsp/VM0w2o3YHVdQQabhaSJqXsdQyqAsDdGkumEPecYUDiSZg9pitkHYTNbDDqPT8eyA=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr487355otn.95.1549924229014;
 Mon, 11 Feb 2019 14:30:29 -0800 (PST)
MIME-Version: 1.0
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com> <20190211212734.01909e62@archlinux>
In-Reply-To: <20190211212734.01909e62@archlinux>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 11 Feb 2019 17:30:18 -0500
Message-ID: <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:27 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Agreed.  Or potentially just use regmap_bulk_read and rely on
> the regmap internal locking to do it for you.

Neat solution. But it may only work correctly iff regmap_bulk_read()
reads the low
address first. I'm not sure if this function has that guarantee. If
somebody changes
the read order, the driver will break. But I think I'm being overly
paranoid here :)

> So yes, it's more than possible that userspace won't get the same number
> of events as samples taken over the limit, but I don't know why we care.
> We can about missing a threshold being passed entirely, not about knowing
> how many samples we were above it for.

I suspect that we run a small risk of losing an event, like so:

PS (12.5 ms)
--> interrupt -> iio event
ALS (100 ms)
--> interrupt -> iio event
PS (12.5 ms)
--> interrupt ========= no iio event generated
ALS (100 ms)
--> interrupt -> iio event

To see why, imagine that the scheduler decides to move away from the
threaded interrupt
handler right before ap3216c_clear_int(). Say 20ms, which I know is a
loooong time,
but bear with me, the point is that it _could_ happen as we're not a RTOS.

static irqreturn_t ap3216c_event_handler(int irq, void *p)
{
        /* imagine ALS interrupt came in, INT_STATUS is 0b01 */
        regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
        if (status & mask1) iio_push_event(PROX);
        if (status & mask2) iio_push_event(LIGHT);

        /* imagine schedule happens here */
        msleep(20);
        /* while we were not running, PS interrupt came in
           INT_STATUS is now 0b11
           yet no new interrupt is generated, as we are ONESHOT
        */
        ap3216c_clear_int(data);
        /* clears both bits, interrupt line goes low.
            knowledge that the PS interrupt came in is now lost */
}

Not sure if that's acceptable driver behaviour. In real life it
probably wouldn't matter much,
except for occasional added latency maybe ?
