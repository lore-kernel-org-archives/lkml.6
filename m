Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9394FC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AB32087F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEwWnVVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfA0UWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:22:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37326 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfA0UWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:22:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so6801001plr.4;
        Sun, 27 Jan 2019 12:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rin6Z5rxUwQbLP18lUcO/4uxvilt/ro0Og27uir8dDo=;
        b=nEwWnVVFWs1LIz/UZtT219J3FW60hpIKB1EZyqX/k1RCpztyUG/rjm1SdM7qtresdC
         FzjBRgAVbE5t0d7uRdGNXGBblznRBxEqH/8zywCl8RAfbL4g9bS0zYtLq4DtAwhyf8Oj
         tHkfonfwizjwwpH/ZjCv3tQiCn8aAqtaIOqoP1t4zWvLjWws/rNFIAoXR2Kgm+dpCiX+
         fAlPEWoO0opVkduNMF7efKyymPxDoj9qrVnIDe8qUX/f9ACLZnLV0CZTLB6qUZBbcIic
         C7U1oljrXjJQl+rl8HRLYFRrx0TzBE7WdT29Qow2ExYUEI/vEZptQgmfskZlbNfIhtS9
         Wpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rin6Z5rxUwQbLP18lUcO/4uxvilt/ro0Og27uir8dDo=;
        b=bdk+Ef+Sp0SHAsWHm3UpeGHz+1qK9O6XCNa5HL5h1V3GCuS/kMBc7NDAq4R54bQYLc
         crCFiGt5ZN28CMs6Yy7C1YoG8otayIiX8WhkQejCHR8yYrJMUMvd4klABlElzgIO3I6s
         CRmm6UYMjDTIDxlOyZlHOoPyWJtQ9HH/aWznbE1oT30IvTBXObDCIk5kyNYe/Ck3zc0O
         icacxT6GFlTAq5aD60ziHo7bUlH69+VLNVScIROmonqopEt7twLd2ITLn114RUBYjEXk
         nmHM2qxTZTcZMxPNcOOqYESzWPvon3zGd9pGMubIXBFjyCKXLT4wCltRoaeshsoLbbKJ
         GtJA==
X-Gm-Message-State: AJcUukfeC3k5xmozF1SjMYYgKwoB/ql9lOI+o+mtm1ev65V6sbOJJdi7
        DmTfzOJNNcIBQBK0q7+ZpqAExxq6/tHXy5bq6QU=
X-Google-Smtp-Source: ALg8bN4Ojcu9phHcyMsYX7BlUEZGet1RgOnlzHpbQCvl4+zdHMkGso3PpOp/ydQMW4j3rRzGewluaqF2A6rLj8L3RJg=
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr18546638pla.144.1548620565797;
 Sun, 27 Jan 2019 12:22:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548610407.git.2pi@mok.nu> <680df320c7263bdd35f87794ae12fb9a9ef3b71c.1548610407.git.2pi@mok.nu>
In-Reply-To: <680df320c7263bdd35f87794ae12fb9a9ef3b71c.1548610407.git.2pi@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Jan 2019 22:22:34 +0200
Message-ID: <CAHp75VfE0g9OVeOzJ5fBj4MGL4nv=a4S-n1fD9kfP1AaniAOGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        michal.lkml@markovi.net, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 9:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> The kernel provides the macro MODULE_DEVICE_TABLE() where driver authors
> can specify their device type and their array of device_ids and thereby
> trigger the generation of the appropriate MODULE_ALIAS() output. This is
> opposed to having to specify one MODULE_ALIAS() for each device. The WMI
> device type is currently not supported.
>
> While using MODULE_DEVICE_TABLE() does increase the complexity as well
> as spreading out the implementation across the kernel, it does come with
> some benefits too;
> * It makes different drivers look more similar; if you can specify the
>   array of device_ids any device type specific input to MODULE_ALIAS()
>   will automatically be generated for you.
> * It helps each driver avoid keeping multiple versions of the same
>   information in sync. That is, both the array of device_ids and the
>   potential multitude of MODULE_ALIAS()'s.
>
> Add WMI support to MODULE_DEVICE_TABLE() by adding info about struct
> wmi_device_id in devicetable-offsets.c and add a WMI entry point in
> file2alias.c.
>
> The type argument for MODULE_DEVICE_TABLE(type, name) is wmi.

> +/* Looks like: wmi:guid */
> +static int do_wmi_entry(const char *filename, void *symval, char *alias)
> +{
> +       DEF_FIELD_ADDR(symval, wmi_device_id, guid_string);
> +       if (strlen(*guid_string) != WMI_GUID_STRING_LEN) {
> +               warn("Invalid WMI device id 'wmi:%s' in '%s'\n",
> +                               *guid_string, filename);
> +               return 0;
> +       }

> +       if (snprintf(alias, 500, WMI_MODULE_PREFIX "%s", *guid_string) < 0) {

What the point to use snprintf here with arbitrary buffer size if we
exactly know 2 facts:
1. UUID string is  36 characters
2. buffer is long enough

?

> +               warn("Could not generate all MODULE_ALIAS's in '%s'\n",
> +                               filename);
> +               return 0;
> +       }
> +       return 1;
> +}

-- 
With Best Regards,
Andy Shevchenko
