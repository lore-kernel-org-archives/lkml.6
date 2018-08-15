Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE41FC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1CE21521
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0YEsSOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1CE21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeHONH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:07:27 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40721 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHONH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:07:26 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so384065qkd.7;
        Wed, 15 Aug 2018 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MUyB8Kl9akDF9LULlIfnb8LqGdQIqsXoM5M1YgptVKI=;
        b=o0YEsSOGLzSbvTnapcvHVXwV3RSrhMIm4SIysuJdwi5qmq0cSXIfxRkkgJCb6aMTD9
         +bzK2LbPhKaoHXvrDkGDTBoea99Uhk4o2fhGuXWR9FINU1QFD6Lh25TfvmXaeJvAHGEM
         mekTujxpjXMi1BOGNpDL6cZ41MQ2pIb+w2E8AOyh49pn+YKTvDsd+VbIdBspmyfcfhio
         O4w2KRkJFgkceRd1vIUVWrokvq70/C9WUQHX7sdLe80OSfbSxScNvohDY9MiUj1+C/NA
         ggvS0wpNrla4rZKfqwd8SXYkHNmuZtAbDy7tIsRsuz6SZ5KmnEzPqPFcIYWJS66k+0wJ
         sUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MUyB8Kl9akDF9LULlIfnb8LqGdQIqsXoM5M1YgptVKI=;
        b=KlSAfw0o8VwU8EEF+NOIUF3kFQIXykScp/KT1AXy5d90x7o7HLEQjuhXh3QK9IL5Z3
         l2JXByb9nGUsQbGd/pZa8XlzkHdA9JxalXOYbt4gjkPJ2gU4sfgqBgJFLBx8P4/KV8wb
         9vqirg5Z0L+iHTK6GSwDkx52zrTQ1QSvANu8gx/otqhgbSwcjPlz23qktSGcujqcbUo1
         nUXTlNrsA7BIZRd/WjJI7iUWnXBluKR9hyQV5GFqpflfRjHPA3oe/AwXfA9Nc0VRK/mK
         sLDg4zg+26/SMtMOehgnO6Hp725wSikhYMZXbeYqYRIJPMK4MUoJAKkq2rHbj/Tr6oEL
         AAJg==
X-Gm-Message-State: AOUpUlHRY5Gl+YR0qr/uzTW2+YXojL1e1x/dQwwystkBr9lwzHpfgu5o
        5IXTYQ3MNg+cr0jTffLK5Aja3pDezqQ0m9nYJWtmYRwg
X-Google-Smtp-Source: AA+uWPxyK7ux34qW2Zhd6cZbKl4L7cAqpc3uxj8fIDdSc2ODN82zQqU7tjLxIl+np0C3djeZhSWvQZRfAqaYGQOJ6Cc=
X-Received: by 2002:a37:7004:: with SMTP id l4-v6mr22179463qkc.83.1534328153240;
 Wed, 15 Aug 2018 03:15:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 03:15:52
 -0700 (PDT)
In-Reply-To: <04607a59-7e47-5463-7ff6-cb1aae7e3626@vaolix.com>
References: <04607a59-7e47-5463-7ff6-cb1aae7e3626@vaolix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Aug 2018 13:15:52 +0300
Message-ID: <CAHp75VcMxMMgLS5y1=k2wMHy5HNbBVgJFMNJ0gErsExss4K65Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Add keymap entry for lid flip
 action on Asus UX360
To:     Aleh Filipovich <aleh@vaolix.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:07 PM, Aleh Filipovich <aleh@vaolix.com> wrote:
> Add entry to WMI keymap for lid flip event on Asus UX360.
>
> On Asus Zenbook ux360 flipping lid from/to tablet mode triggers
> keyscan code 0xfa which cannot be handled and results in kernel
> log message "Unknown key fa pressed".
>
>

Pushed to my review and testing queue, thanks!

P.S. your patch is mangled, please, pay attention to the format next time.

> Signed-off-by: Aleh Filipovich<aleh@appnexus.com>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c
> b/drivers/platform/x86/asus-nb-wmi.c
> index 136ff2b4cce5..db2af09067db 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -496,6 +496,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>         { KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>         { KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>         { KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
> +       { KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
>         { KE_END, 0},
>  };
>
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
