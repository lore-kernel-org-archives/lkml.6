Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E002186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1KVSqt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfB0TnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:43:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43092 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0TnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:43:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so8482836pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v10SQsz27WAbdJEQoAu+f4GrXevfP2+IfguzPFDhyIU=;
        b=J1KVSqt95IFYzYcLA8IcGi3bsqlNFPPR9ePjBYKC0kcgBnQHxJb9vHkoks0Aqq/rRV
         0axvYaPbPmVc62NkMKIpVm//mUZZfGU3qFQgSKjAQZth06QU5+53dShjVV4Q3WLZZbNK
         d1wiG84iSQYeSYve3+C7TaXmf+zBeFkPSSfyWtyWEmm+cxQwIMCJbC15eOJ5pooQP6tw
         STi3XQplrX6QRG2ihHnsezCBhtrFNC+QfQrz20ea1bLEGr4bvqhz6/BaGIqfD+dW5XOi
         45DoKyMD7ImUfS4OYSluQizdrIujWfwP313EGK3cHM88yI4kQqkYMk0btKdLUDFVDd8B
         yqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v10SQsz27WAbdJEQoAu+f4GrXevfP2+IfguzPFDhyIU=;
        b=a9duFA/ZIS79Zvq7bedJCDVAh+75+KNuQEwvm4MHHJeRWL+EGd1T2WTyTaRXyv44T6
         rHaa2B4itsHPcDZwWOsosS0ZUyHaza+mGmEvtuz8WNwgUIa5jAZ66DU9jHgiA4EZVj09
         rgfERomDzUrQO21RnU6b4tTV3X8pg02l6V8eGIIwcjaLiRSOrDORUb/ZTBLGio612n39
         4YgG3bFqDTG1pHOXa6NfQnoC7yZVmE5UfKemGYCqmoCBKo8qKyzLDJGw3HUerV5I+PEQ
         Np5qX18h//ltdHrrCSbAeBhFqZN27snoBiKxXl1wxjpJmXxSc+Os+V63EAsxwh4GIVMC
         ljcg==
X-Gm-Message-State: AHQUAubMuBUiycNitgspqe5O93ZmBh2j3+5wkfsuDEtmKr5NqkyjD822
        4K0KunaivloecebdKG52mOFweQCPZNTFPMdtSbhPTQ==
X-Google-Smtp-Source: AHgI3IZTv69gLpeaYLtvB3P3wS9UKjdpPpUAdoCmgBQHr+U7r5xcqdgOCzZj6pl2CUD3he9NK0+b+EGg+L6818PaiDs=
X-Received: by 2002:a63:fe58:: with SMTP id x24mr4553167pgj.255.1551296584092;
 Wed, 27 Feb 2019 11:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20190226234853.20441-1-louis@kragniz.eu> <20190227110720.27329-1-louis@kragniz.eu>
In-Reply-To: <20190227110720.27329-1-louis@kragniz.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 Feb 2019 11:42:53 -0800
Message-ID: <CAKwvOd=RZ7E3MRo4dB6KEi5aw92kjZ63ij0jL4XJ0nKzDwcm=g@mail.gmail.com>
Subject: Re: [PATCH v2] HID: quirks: use correct format chars in dbg_hid
To:     Louis Taylor <louis@kragniz.eu>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 3:08 AM Louis Taylor <louis@kragniz.eu> wrote:
>
> When building with -Wformat, clang warns:
>
> drivers/hid/hid-quirks.c:1075:27: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   bl_entry->driver_data, bl_entry->vendor,
>                                          ^~~~~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1076:4: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   bl_entry->product);
>                   ^~~~~~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1242:12: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   quirks, hdev->vendor, hdev->product);
>                           ^~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> drivers/hid/hid-quirks.c:1242:26: warning: format specifies type
> 'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
> [-Wformat]
>                   quirks, hdev->vendor, hdev->product);
>                                         ^~~~~~~~~~~~~
> ./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
>           printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
>                                    ~~~~~~              ^~~
> 4 warnings generated.
>
> This patch fixes the format strings to use the correct format type for unsigned
> ints.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

Thanks for following up on the feedback.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v2: change format string to use %04x instead of %x
>
>  drivers/hid/hid-quirks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 94088c0ed68a..b608a57b7908 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -1071,7 +1071,7 @@ static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
>         }
>
>         if (bl_entry != NULL)
> -               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
> +               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%04x:0x%04x\n",
>                         bl_entry->driver_data, bl_entry->vendor,
>                         bl_entry->product);
>
> @@ -1238,7 +1238,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
>                 quirks |= bl_entry->driver_data;
>
>         if (quirks)
> -               dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
> +               dbg_hid("Found squirk 0x%lx for HID device 0x%04x:0x%04x\n",
>                         quirks, hdev->vendor, hdev->product);
>         return quirks;
>  }
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
