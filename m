Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F98C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B37824617
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="heB/eDuj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pw12lfeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B37824617
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeGBVFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:05:41 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35855 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeGBVFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:05:40 -0400
Received: by mail-yw0-f194.google.com with SMTP id t198-v6so7155898ywc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NTHeU/zpbRRMcJeZOFAppkjexaXF5KDm1Xpl4agsF9I=;
        b=heB/eDuj6A4XVaCgVK1aRorFr7PFPsPI8yaNJl0m467I+TsKAwqQHBt4Ab1Ou8wV52
         Nkt50fr//twXHFrKKBzABTfsWyuV7hbcZFo/rkTe+XaeHKC+Z/BId7/yr5/hY2c05ANr
         FYMDni5NSHBGZJG3c9h4kM/NKLx8+VvUoPH9iHwNDh5yc5NYvB8fzRKNZeHaqRw8o1JR
         iBV9ZF5JRIuHLs9p1loW5ONdUQI/6QPKV4ZsGyrKIWE4W1tM3hriSRVCyYb9x6IRiWPY
         7vV1OVdH/Il819Tn8nyQa/MnuavLuF5yLGTObKJ+XbKmVwjhmB6aYvpuTFuWhhpnoPmR
         2PUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NTHeU/zpbRRMcJeZOFAppkjexaXF5KDm1Xpl4agsF9I=;
        b=Pw12lfeBdwLEfyyMKjI6JMNfqZcv/98mCTGeJn+xOdZVaEjXHlo/tfj8ozQA7iEvWW
         74ja1pLd3HDrYpjgz8YySv0hmrGi1tAbIWV0wP+0HJDfywRubbO7mjEhdOWBsZUclG0w
         5m8ou0QK+5N5k6ElQdGBDM1hqymUrUHX9FTaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NTHeU/zpbRRMcJeZOFAppkjexaXF5KDm1Xpl4agsF9I=;
        b=pYGGcvp1SkZfuYnbimkFTdFWOu1zirB6KbJOg5KSkKQpIY5bVZsKUmVVQGEfbBcP39
         gvsE/wksVzdcrwhLf6rogB0Cug+ihSDlUXzuN1P27Km75TnI/SSYjkgd0Dd6C/R8C0XH
         unI/3UcI91iz4+8Me3uosdg9IEmfzeE3G92xBd/6EMF88YSvoKkSDnW3Rd3QtiYe/duP
         DkCQeCpOURqY5jjT5kkRAn7gW+aQPF/RmEMWNJZRDydRgnmU9OrTSAg5UZJNtNQBdAOD
         hkwOn3ptA7NSUADMtyTe4wI0wVAg7sLFvkIDylEKJcy8zPzJBulSz0FNP1iQtuTKAQ/j
         rj8Q==
X-Gm-Message-State: APt69E3Dgx/NlKQwQr0pAATxJK7IrlGXANza2hJab1RmX+iUxNVdvRCG
        BxY1Rx3fpuGkwGLtAn9WqDtqf/rXhR/Xv0LNNDMB5A==
X-Google-Smtp-Source: AAOMgpeLh5YzRM7zbY+q+jmAPpS5jDY7L5qqTFCruI1H9w+IwwsQSiUEGgJBLA2mLQ212EGbYdzR4vN0PbkIlouULoQ=
X-Received: by 2002:a81:4a05:: with SMTP id x5-v6mr13890620ywa.116.1530565539133;
 Mon, 02 Jul 2018 14:05:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 14:05:38 -0700 (PDT)
In-Reply-To: <20180702194505.28355-1-eric@anholt.net>
References: <20180629184449.GA37304@beast> <20180702194505.28355-1-eric@anholt.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 14:05:38 -0700
X-Google-Sender-Auth: XeubM4mVAeIikiijOwxCr3OKBBA
Message-ID: <CAGXu5jLqkdSYd4MWPm9v49U+6FvgfMLtG1Vz3SUBR999vHshHQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! firmware: raspberrypi: Remove VLA usage
To:     Eric Anholt <eric@anholt.net>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 12:45 PM, Eric Anholt <eric@anholt.net> wrote:
> Kees - with this fix to your patch, the kernel boots again (otherwise,
> the FW would try to parse the uninitialized bits of stack and throw
> errors).  If you're good with me squashing this in, I'll do so and
> send it to -next.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/firmware/raspberrypi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index b80f15214b73..a200a2174611 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -162,7 +162,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
>         memcpy(data + sizeof(struct rpi_firmware_property_tag_header),
>                tag_data, buf_size);
>
> -       ret = rpi_firmware_property_list(fw, &data, sizeof(data));
> +       ret = rpi_firmware_property_list(fw, &data, buf_size + sizeof(*header));
>         memcpy(tag_data,
>                data + sizeof(struct rpi_firmware_property_tag_header),
>                buf_size);

Eek! Yes, thank you. Yeah, please feel free to squash. Thanks for testing!

-Kees

-- 
Kees Cook
Pixel Security
