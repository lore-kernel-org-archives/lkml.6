Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E52E21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XL2Ztvit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfACLzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:55:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38981 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfACLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:55:32 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so42360222itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxqOfRECq1Xyc6645A19FQ0lYLd4E+5dBQ5nZTmkHBw=;
        b=XL2ZtvitKnWPZSUt76irYOnGHshCsJrpgZ2ejSNbn2aTC1X4GDQ1UgInEyQkyeDZg/
         EyG3lnRoL/GTIW0qzhwP0M3qfKyD5EbL/2UNd8RVzAj02rsoNDOmeF20u04QNHDTlqXJ
         ty/Xpg6GfkcA2lVAIdu6XPmM7Nz6DWYkVk/KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxqOfRECq1Xyc6645A19FQ0lYLd4E+5dBQ5nZTmkHBw=;
        b=OeiZDcLQLSaWyuIJLhcLO35Rodn44nP8vSYCm5XnJSqu1AuwSzGM4P/JeIfRhZymCO
         6ZETGsWdLrHUJbP43GkOcQm1x9+H+imayFEDO0JDEkVX+KXd3Ksyw3EIWbref5eTCrYq
         vZVrbT80q+E1s1UDj6YO5XzD1OOJdI1XrDvVXVzQT8uXMnHPV5WjsLIlpHINezq/fE9D
         VOPIadg3BHhcPlKI/cmZrAyuxw597wRddMvcqEmHmDMDGvSj2FyhHctMbOsib2i5W/YU
         DVqInJjOGTnwGTvov2zWlzIIuG/7vDBCgZIsyyritqwBwmiIixXUTHoW66c7/UVHYhUx
         KweQ==
X-Gm-Message-State: AA+aEWbNiF0lIG24XN/II5OyaMIIJZxh4POANZv+zb5KADCc824MhM7N
        2iFKqrJbI1RUfMGaylIIZQ+YD4AcoAMW+tCLEAmblg==
X-Google-Smtp-Source: AFSGD/Ucy4uSzLdkwv68Z48AJBP6cB/p9k57FCC/nChiXbUq+pogS+0ihN0S/Pjrx8hDfGIqnIdQ0cjMENaeM/f8Vps=
X-Received: by 2002:a02:f42:: with SMTP id h63mr31746615jad.133.1546516531286;
 Thu, 03 Jan 2019 03:55:31 -0800 (PST)
MIME-Version: 1.0
References: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org> <CALxhOnjz3Qd-a0OWMDV9ShfPOUB8gNB5Ltp9HGZi01mauaxkuw@mail.gmail.com>
In-Reply-To: <CALxhOnjz3Qd-a0OWMDV9ShfPOUB8gNB5Ltp9HGZi01mauaxkuw@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 3 Jan 2019 17:25:20 +0530
Message-ID: <CALxhOni1b0hS1a7EHFBkzcCx9cT-Z+jy4azrLcFveu6KG944jg@mail.gmail.com>
Subject: Re: [PATCH] scripts: unify system call table generation scripts
To:     Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tony Luck <tony.luck@intel.com>, Helge Deller <deller@gmx.de>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Henderson <rth@twiddle.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, 3 Jan 2019 at 17:04, Firoz Khan <firoz.khan@linaro.org> wrote:
> > +fileguard=_UAPI_ASM_`basename "$out" | sed \
>
> Currently, all but MIPS have the architecture name included in
> the file guard.  Shouldn't that be retained?

I was planning to do something similar to this:
-fileguard=_UAPI_ASM_`basename "$out" | sed \
+fileguard=_UAPI_ASM_${ARCH}_`basename "$out" | sed \

But later I thought, the generated file will present inside arch
directory (eg: arch/m68k/include/generated/uapi/asm/unistd.h).
So Is that required to mention the architecture name in the file
guard as it is generated inside the respective arch directory?

Thanks
Firoz
