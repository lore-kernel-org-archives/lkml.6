Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366A920850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enwcx4nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366A920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLDWYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:24:02 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46041 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:24:01 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so7671004ywd.12;
        Tue, 04 Dec 2018 14:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6nCkMUwljQh49NXS/ClOKHkTPzJgolIuwBRZ+snpIQ=;
        b=Enwcx4nYi6WhkOZPYYFpuGKYYzpK/yoSpN8nn56gZf7MZ0teeS9Kh+AsO50EYX+MbC
         yGILzMN246CsVbcOXF01Lp8TD1shauDu559rocut2Dc8C5XY7Wh1Jga3Zh5J3i1G27V4
         BJGKHtirxwU141ZTGyBhX6dWmjEckAdzQ7D9nieeuTaSGBNAcu6aptmZrcXiUf/xZmv0
         uQChQeCGxi2vLclOK8zwp1IFOx9bRLx2aO43o3u0EjEBl45b4FYgguPs6a97WwgzW2BB
         VLEEqow8Qg7ACZaORuI7QUBewirpwuCT8zDcFlOyMoRRrtR8v24o9QW6HYnx/onW+NgK
         cO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6nCkMUwljQh49NXS/ClOKHkTPzJgolIuwBRZ+snpIQ=;
        b=to/kBQ0BeYTe1X4SNW+bbY7tFPydHf+7oGSY/yoTyvEf53Z9V1sH6ljx2DRbNy0Bhs
         JXZJ3H3VdqTK5wjNOZ1J4WxYlrOEmjGUqO1Uuw7ct74u+BVhkJucfp2oBXLha81pqCwY
         pexZCz9edRn8TaZyjjRENP4/jdcb8ZMR2sq7B3T8Rj9fxn3zG3S201Opbg2ZWNWurBoX
         w9LkXn3mXtG3bqM2DIVPOkMAVzSC3oNYguiQjY12LOqU5rqFWP4fRCmAmWTcfjitgOpS
         RK7x/uIedcBl2Zcut7TbA7J3KqxpFDRJXltkv6Q9G/g18aLFk+zXYEy4D+eG5I+nZba8
         r87Q==
X-Gm-Message-State: AA+aEWbridEZPSDpduksi3xNslld5cPV+yDn+TxVevjkHDXX4kdkcmXo
        TvsHQPcY+abUB2Wfzl3iR7+mm9bHtAxmTZItklw=
X-Google-Smtp-Source: AFSGD/VaqoiUCb2M/7uA1CaI9733KNeLBZjJZx33e5+95+MKsMRDDpUhT09IgyoJB467lNXpjnvXDRg0Daao5Y7dWJk=
X-Received: by 2002:a81:1fd4:: with SMTP id f203mr21520235ywf.422.1543962240420;
 Tue, 04 Dec 2018 14:24:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com> <20728567aae93b5eb88a6636c94c1af73db7cdbc.1543337629.git.andreyknvl@google.com>
In-Reply-To: <20728567aae93b5eb88a6636c94c1af73db7cdbc.1543337629.git.andreyknvl@google.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 4 Dec 2018 14:23:47 -0800
Message-ID: <CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a=Om5Q@mail.gmail.com>
Subject: Re: [PATCH v12 05/25] kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>, glider@google.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>, ndesaulniers@google.com,
        marc.zyngier@arm.com, dave.martin@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, paullawrence@google.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        rppt@linux.vnet.ibm.com, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
        linux-mm@kvack.org, linux-kbuild <linux-kbuild@vger.kernel.org>,
        kcc@google.com, eugenis@google.com, Lee.Smith@arm.com,
        Ramana.Radhakrishnan@arm.com, Jacob.Bramley@arm.com,
        Ruben.Ayrapetyan@arm.com, jannh@google.com, markbrand@google.com,
        cpandya@codeaurora.org, vishwath@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 27, 2018 at 9:00 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This commit splits the current CONFIG_KASAN config option into two:
> 1. CONFIG_KASAN_GENERIC, that enables the generic KASAN mode (the one
>    that exists now);
> 2. CONFIG_KASAN_SW_TAGS, that enables the software tag-based KASAN mode.

[...]

> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -1,35 +1,95 @@
> +# This config refers to the generic KASAN mode.
>  config HAVE_ARCH_KASAN
>         bool
>
> +config HAVE_ARCH_KASAN_SW_TAGS
> +       bool
> +
> +config CC_HAS_KASAN_GENERIC
> +       def_bool $(cc-option, -fsanitize=kernel-address)
> +
> +config CC_HAS_KASAN_SW_TAGS
> +       def_bool $(cc-option, -fsanitize=kernel-hwaddress)
> +
>  if HAVE_ARCH_KASAN
>
>  config KASAN
> -       bool "KASan: runtime memory debugger"
> +       bool "KASAN: runtime memory debugger"
> +       help
> +         Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
> +         designed to find out-of-bounds accesses and use-after-free bugs.
> +         See Documentation/dev-tools/kasan.rst for details.

Perhaps KASAN should depend on
CC_HAS_KASAN_GENERIC || CC_HAS_KASAN_SW_TAGS,
otherwise make all*config may enable KASAN
for a compiler that does not have any -fsanitize=kernel-*address
support, resulting in build failures like this:
  http://kisskb.ellerman.id.au/kisskb/buildresult/13606170/log/

-- 
Thanks.
-- Max
