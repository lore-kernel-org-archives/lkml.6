Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A14C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D80A218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKoWC0uC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfB0A1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:27:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40042 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0A1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:27:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so7065419pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 16:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2V/dVF5Q1F7LotNMdhXS8ldQBuS0ozbkd1QvSSkDk0=;
        b=IKoWC0uC+FKVgxSuVLb4AcNLF2Aiw7puELUPt5uaBCFbdhcNqBJL+Zqf/MATb9k1TZ
         I0mb1QCaM5jKVGjHQN9SzTL/38xuGVWOJ6hgqRymqY4eqOCHm4oOQIp4XMjdMJd+CZlh
         XO0ycCYsf6K0zK7z49lR3Ma5IUj8KbeW9eZ06MUJKc1AHE8197FnEGdHpFCahdPbvVye
         8iG4QZJ6FiBBxZhXWglWX0pJyvt6oNMvmmQtBTDos3XrPt9Z4qcAc6sMEprUn3kjqPFJ
         4+aGTd6OqmeNePwCNP+CXCOCYR5/M/VWaRie+BzsgU3o3gFaAHvFUANf8+zGUNSwVsg+
         TENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2V/dVF5Q1F7LotNMdhXS8ldQBuS0ozbkd1QvSSkDk0=;
        b=rzflSioDJ/kNlXqYA7g2Cy8h/HqkdZ5JUsBWSgGu84GgCEuTz2GPJKJasi8GaNP2VJ
         tSyzSL6w3DPA4X3WTIGLKVQNcfTWn/u5CFvi87Lls/VY1U+xg0bQapkw9SBRidF0+Uk+
         THnXMQ2KVwBBtLI2gLUTPNF4wAtfyc4X2GYQOH3S4ZSmSs+Yf3AQLs1scx3syLnvq8oa
         JXOYwsqh/QOjqVZzPjzUzKMJiCOer65g7qJddfVnMsLVXzKdSN4YIEbBjt9PwXCqpx4k
         Bem9Fl2REbbE5/tFYbA001yfbKkBHTl8yx9BYgS2vPlpCN//eltaeg3RsGdOU0/cd8il
         aM/g==
X-Gm-Message-State: AHQUAub9CioDP6TPAOe9DjG4CuFb3XBqLJRkv3fqPVh83a88mFd6YEmY
        7azsjpahRwoP+b5JxNNnJnxAAqu4Ulfr76IngFqZpg==
X-Google-Smtp-Source: AHgI3IaOhN3g+CoaAE+nrB4RZYNL+cWDyig7G9wikArG7z55p3VMJ9E3jq0MPaB4xX/7j5xe8i6GTpbB5gnIL2bi1uc=
X-Received: by 2002:a63:c70c:: with SMTP id n12mr170294pgg.302.1551227266824;
 Tue, 26 Feb 2019 16:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20190226234853.20441-1-louis@kragniz.eu>
In-Reply-To: <20190226234853.20441-1-louis@kragniz.eu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Feb 2019 16:27:35 -0800
Message-ID: <CAKwvOdnt4o=FDgHOxBB+pSW+wxj4SMp7JbvgdOuCOx1MTqnvRA@mail.gmail.com>
Subject: Re: [PATCH] HID: quirks: use correct format chars in dbg_hid
To:     Louis Taylor <louis@kragniz.eu>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 3:50 PM Louis Taylor <louis@kragniz.eu> wrote:
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
> ---
>  drivers/hid/hid-quirks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 94088c0ed68a..b4e49e1b6f4a 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -1071,7 +1071,7 @@ static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
>         }
>
>         if (bl_entry != NULL)
> -               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
> +               dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%x:0x%x\n",

%h is for short ints, include/linux/mod_devicetable.h declares struct
hid_device_id (bl_entry is an instance of struct hid_device_id)
unconditionally as:

147 struct hid_device_id {
...
150         __u32 vendor;
151         __u32 product;
...
153 };

yep; LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Thank you for the patch!  There's 3 more of these in
drivers/hid/i2c-hid/i2c-hid-core.c if your looking to clean up some
more!

>                         bl_entry->driver_data, bl_entry->vendor,
>                         bl_entry->product);
>
> @@ -1238,7 +1238,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
>                 quirks |= bl_entry->driver_data;
>
>         if (quirks)
> -               dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
> +               dbg_hid("Found squirk 0x%lx for HID device 0x%x:0x%x\n",
>                         quirks, hdev->vendor, hdev->product);
>         return quirks;
>  }
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
