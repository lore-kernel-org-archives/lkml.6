Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E42C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BC820657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULf9hPfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BC820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbeJaVr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:47:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38428 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbeJaVr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:47:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id p3-v6so9378894qkb.5;
        Wed, 31 Oct 2018 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n4SKnKLCIfEwwiiWAv7UkRr8ZbdZ6pbIG/14rX1N1Kc=;
        b=ULf9hPfiXw4Bp95h/cQpF6RP2YZ+3DQoNkCJOGzNPWB0FIbuXgKxaZO24rhZ1js7m8
         +m+Bfk0SXBo20aWkMKWQtYCTKd/adpPTEX1V4MDIblTKhlD0RVTzfHNY3c/Pg91w7+s5
         zgeUpdnyta9fgi/ZsuMDNEKa7mWYPYlVpyR83ULURupWgxFqiXmg41ZnQrMbboZX9fmr
         Ar0QsfjkJFKwICccE/9qHUu+pboLrGynfCEEIDmUOIyykpB47WWGvKiTyhGc7z+ZS/6D
         KxBD6/hdnwq45pv/FnlM4nYyVQquOm5envxbfCAcEv5A8IhLXoZO3uTJ7CplHfBYb+FQ
         ftng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n4SKnKLCIfEwwiiWAv7UkRr8ZbdZ6pbIG/14rX1N1Kc=;
        b=B0oWaoD93iG3bCBl9or1MV4nmPErpiDpat0fxVR0xBU3ANj0LnChK/JteDHOXiJ5R0
         ycOikZkWwNacW0xqIJ0Wyn1HQOKik2mAEDyj/NvKxS1GV9fZwLNDHiHhkRAKxI9ywtDo
         sBeIC7ws5eKAFNmvF85A7971gRWgdqFTlPKbwT01WDqRmPHmuR8sVznqjYMcKDIceJ0W
         DulWgXMd0GfGJsqk8y4DgVUQLKJpmbtvoBT0STiPC9EXIU9lUudnW40TZe1w2C0KBWem
         lWQgM/fzCz8Uvj+pYYoTpp5o8hA867usMahUfg0IYYNYnRtP0cyTwduqyCbdFN+ZqHJo
         HzPg==
X-Gm-Message-State: AGRZ1gI9YRteUymU5V31uLPAhhBDb3RdL3TDkD24NqF29Jr+LLnzSb4M
        yCIIX5zxlEXjPq3k08BBYha+M3BuxxzquObisVM=
X-Google-Smtp-Source: AJdET5cg5eKjktdwJrG0rm6zMXhnQU8QmrSr9VnCkKJCbc7E2qk6SHs+RDep+g07PffEXAk0KHDVKpap/hCLnPE6ofA=
X-Received: by 2002:a37:4792:: with SMTP id u140mr2417268qka.301.1540990174675;
 Wed, 31 Oct 2018 05:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn> <1540993041-25611-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540993041-25611-3-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Oct 2018 14:49:23 +0200
Message-ID: <CAHp75VewfhyeoAhfFkxjWm+ch_msCeDGqumOEzbawumx7aFjdQ@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:27 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> On some architectures (e.g. arm64), it's preferable to use MMIO, since
> this can be used standalone. Add MMIO support to the pvpanic driver.

>         case ACPI_RESOURCE_TYPE_IO:
> -               port =3D res->data.io.minimum;
> +               if (acpi_dev_resource_io(res, &r))
> +                       base =3D (void __iomem *) ioport_map(r.start,
> +                                               r.end - r.start + 1);
> +               return AE_OK;
> +
> +       case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> +               if (acpi_dev_resource_memory(res, &r))
> +                       base =3D ioremap(r.start, r.end - r.start + 1);
>                 return AE_OK;

You need to split this to two changes. First one converts existing
code to use acpi_dev_resource_io() and the rest does the rest.
Moreover, please, read carefully the code of those functions =E2=80=94 hint=
:
they check for resource type themselves.

> +       if (base)

Same question. At which conditions the base here can be NULL?

> +               iounmap(base);

--=20
With Best Regards,
Andy Shevchenko
