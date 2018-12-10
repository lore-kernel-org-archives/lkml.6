Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68817C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183622082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYJyz4tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183622082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbeLJVEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:04:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44424 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbeLJVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:04:19 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so9941887iod.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bC2z7tUV8JkK88NZkHivaWApFVgDb5ee5X2hJ0P7qM=;
        b=XYJyz4tG9uLneocwyimMtdToxIZm8iC8Wh9IfWiuTX8iFg4nhqvAeXOIjo2ClmAwrA
         6Z1NpNLL/dDn9hti8LXR3L8DKzsqV+zYVcFpgQ4KEP9eq6h6zzNMeqAe5Irq2KvbSmWF
         mWxPCpYlj7gFccxBbv7SJjkUUaBYdfpAKVqqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bC2z7tUV8JkK88NZkHivaWApFVgDb5ee5X2hJ0P7qM=;
        b=g5Qaf4bsB0OVd1BKXCpHWlAxgXKTz/5jziBgprvQukWRsLuaYv759Un94IEY97dr0i
         twh3KAztwJ0xvte8TgC+Ecmdqiw3iwFPMwSTEd5mTz+EqL91kgCPsFI23U6ag84Wd5bt
         J1Q7DxYsczYas2shTK+0Nt7Z92avPItNYRGG+X0dQJFqNxlPlHhwLe6Ohgu+g6xOxEYB
         iC0rx6GyEs5CaBPj+10JVFHujbzQjwBEqEWhyiXmXbf9I4UPuynnkYHZ+EAQ2tSiW51J
         R29QHVl5oDo3MY9RfatuzJE01sKwSKCFoLohebcs7YwhWDbX0TSbwCCJWnAdbHHzUtmq
         c9Xg==
X-Gm-Message-State: AA+aEWa3Wm6HNrAF7Wi87Yp/koAuEaLqVjQeowRCxe3DKBHX1f7yBZ0O
        PmGu97UN8AjiasqUwBg3qjS46IWaYxFO26QBQXrmZw==
X-Google-Smtp-Source: AFSGD/Wg0H2qX1k8HvrVBgsxXbbmsMAexORHgZBFUFulC7vw3NDvXsLWAKrxpF0aJvz+KEwdC244DcU+KzTj91mzkYc=
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr11757906iok.60.1544475857969;
 Mon, 10 Dec 2018 13:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com> <20181210210310.12677-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181210210310.12677-4-wsa+renesas@sang-engineering.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Dec 2018 22:04:06 +0100
Message-ID: <CAKv+Gu9uGxTjBhAD3WyQBohhZ=bswXOoo4waTetArrS601_LJQ@mail.gmail.com>
Subject: Re: [RFC/RFT 03/10] i2c: synquacer: remove unused is_suspended flag
To:     wsa+renesas@sang-engineering.com
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 at 22:03, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> This flag was defined and checked but never set a value. Remove it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/i2c/busses/i2c-synquacer.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
> index 2184b7c3580e..d18b0941b71a 100644
> --- a/drivers/i2c/busses/i2c-synquacer.c
> +++ b/drivers/i2c/busses/i2c-synquacer.c
> @@ -144,8 +144,6 @@ struct synquacer_i2c {
>         u32                     timeout_ms;
>         enum i2c_state          state;
>         struct i2c_adapter      adapter;
> -
> -       bool                    is_suspended;
>  };
>
>  static inline int is_lastmsg(struct synquacer_i2c *i2c)
> @@ -316,9 +314,6 @@ static int synquacer_i2c_doxfer(struct synquacer_i2c *i2c,
>         unsigned long timeout;
>         int ret;
>
> -       if (i2c->is_suspended)
> -               return -EBUSY;
> -
>         synquacer_i2c_hw_init(i2c);
>         bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
>         if (bsr & SYNQUACER_I2C_BSR_BB) {
> --
> 2.11.0
>
