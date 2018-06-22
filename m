Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49EBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D2A240A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjUBTcCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D2A240A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933779AbeFVKup (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:50:45 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35391 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932719AbeFVKun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:50:43 -0400
Received: by mail-qt0-f195.google.com with SMTP id z6-v6so5536690qti.2;
        Fri, 22 Jun 2018 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Hsw6Vs/JQ+XbuV9RgP8QOoHC8T5r5TBXJYYb9D9Ujo=;
        b=JjUBTcCX/hldZjVbswCU4x+q/+/FYGj1IFoZ6QL6rfC47KXwsw7CqcVtxhsLCH8phr
         rjoEkhJn2OCwdo/6spEGuJPY2Ba9BgVq3i9dqVB00eGhJImzJ+c3L8T/M9/y6ZmZCg6k
         ANC8x+mAPbTbWBuXp6eBXjqM+Zy7AgqdPJU6RlpmYIUbdPsI0tGFA8eob587l7KZMzr+
         qm+0PAU6JZP96aMpCa+iDuaB9xS6m/pl4s+mzKStjNG1dPYDgIqYLdh0otcCXYno4haa
         ynVKhd0dAO3wIPkYuvLHO4RDwaM9zrvA5Zh2zHX8PmCGp/J2dxLA8aFOzG61OEAHISQA
         x00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Hsw6Vs/JQ+XbuV9RgP8QOoHC8T5r5TBXJYYb9D9Ujo=;
        b=IeiV73BS7pN13rmUEWWNph93/fI44IhOlsSM38B0XwgtSitUJofV3TNJjPpMzR/noF
         D4vvYP0ys8kydWSD1iXWHrlU1VP6YuwZ6eR3T7rGSt9Q6V+7H5XL3zvSoxY+2c43iWjN
         GIWlfFWkwvKm4zB2dmDMgGfhwn2JpulQX5MTcR3duva0uGhJQGHZqMl8R0woVj0rxkWA
         GDeq8Ee2MDHu7hnQ951jFuh5InO/tdV/6ha1aagUHfHhrVjzTuF6YgNsz1o+W7LVBXkH
         w+MK4266+PlSTac68ik20A6TlZUQ9j9Gbe8mn25jo1gN2Aala5B0PHQdvetapWjqhnNz
         UBCQ==
X-Gm-Message-State: APt69E2ESOe2LqElcbGzgB7AmQQlHuaeRZX32dtp3YxJuKkOcUc+t0fq
        v18pIteQQ4xp0yTEXXPuJ/gDJvk46FEUTbl4KRM=
X-Google-Smtp-Source: AAOMgpdOS35ASwkqdacGfWVXhNyu7vV4WqSn6BuwdRnJQBdCk9caP6Ble6OcMvFYSbdqqiKBlH31P9rkOXjTNTpV9wg=
X-Received: by 2002:a0c:ad29:: with SMTP id u38-v6mr871483qvc.100.1529664642388;
 Fri, 22 Jun 2018 03:50:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4716:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 03:50:22
 -0700 (PDT)
In-Reply-To: <20180622100733.29051-1-geert@linux-m68k.org>
References: <20180622100733.29051-1-geert@linux-m68k.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Jun 2018 12:50:22 +0200
Message-ID: <CANiq72mjuCKj+6Rw-2Rsrk1bwcpNfKZ7LwdeRnkk198LsjHz1Q@mail.gmail.com>
Subject: Re: [PATCH v4] MAINTAINERS: Add file patterns for auxdisplay device
 tree bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:07 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Thanks,
Miguel

> ---
> v3:
>   - Update for next-20180622,
>
> v2:
>   - New.
>
> Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/auxdisplay/":
>
> -Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:1/1=100%)
> +Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com> (maintainer:AUXILIARY DISPLAY DRIVERS)
> +Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> -Andy Shevchenko <andriy.shevchenko@linux.intel.com> (commit_signer:1/1=100%,authored:1/1=100%)
>  devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  linux-kernel@vger.kernel.org (open list)
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d393dc22eaa3ece..e5db502df5afdd8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2544,6 +2544,7 @@ F:        kernel/audit*
>  AUXILIARY DISPLAY DRIVERS
>  M:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/auxdisplay/
>  F:     drivers/auxdisplay/
>  F:     include/linux/cfag12864b.h
>
> --
> 2.17.1
>
