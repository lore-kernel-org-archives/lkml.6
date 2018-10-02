Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C02C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2B320652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtSEhL1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2B320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJCDdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:33:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37502 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJCDda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:33:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id 63-v6so3059249ljs.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1f/zqaNNJ1CcQ1pglGDjW++Utt2ZWV0bF9lPiXJpQhA=;
        b=MtSEhL1zyS9l8FINxykLH99hlC1A56ekhlEaO1X1psVyKcGASZ8C2AHlOxleZRCsG8
         m24uxg6hbl5ySj0Wdz6MZeOLYlwDZdfgDauhzExFwFoMrsYZwgnocGqiZICFYUA+NEpZ
         vHEQ3/2TUFGIYqP9kEhiDCKW+KT+5ElBPHfbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1f/zqaNNJ1CcQ1pglGDjW++Utt2ZWV0bF9lPiXJpQhA=;
        b=pu7OBcRYyMfMYF/GUGy2sUZoMIELfnZUAAinw9/50gGRiWnJ665HM57EZhT3wTECWr
         0//Y1fqVTDXfFR9VDBgY3I3iNToS1VtFPL9AW6qQsq6oMdceKvlZ7P+0n8R2wWeXaCjL
         4kl4CW2O9jr1KjKaldtUnDDGWw4AuhuFoLn3Tt7V+i3AiuLNJsU8GbpwFaZn9PR1NbIB
         s0Ph3bJUrzutgro0Kbfc5j6KTmHTVI72PwmTpRzq09KJ4hhcGtQXAYsi8f0jdhmvwxGC
         A9eSzlcz6cal04UoHOb7P3MmYZB4yOy+VBTcmhZW24Aor3LIVPBxrs3UoDODiMfA4b2d
         3kqw==
X-Gm-Message-State: ABuFfohSw2iKgBAzCf4v9gsuBICGrkQr2a1EWKyYQm1c4CR2OMC9ixCx
        3K+EGiAmxY+GYTtJb239Bpq8Md4BZ5W61Vw40acgFQ==
X-Google-Smtp-Source: ACcGV60v+rDiZaQyfF11regfOreJG7837iaNlTugzm4ZSpEoTUSr+BK/Y/sdwQs/J35580H5VYcycpPCzIo0j3vUcCI=
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr2401638ljc.61.1538513297667;
 Tue, 02 Oct 2018 13:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <1536330895-8391-1-git-send-email-daniel.diaz@linaro.org>
In-Reply-To: <1536330895-8391-1-git-send-email-daniel.diaz@linaro.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 2 Oct 2018 15:48:06 -0500
Message-ID: <CAEUSe79yNJ_2FsLsxKW6J0dfrJ2HoVvk+_NZGWHCsy_Kc0+pQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selftests: gpio: restructure Makefile
To:     Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Fathi Boudra <fathi.boudra@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        "open list:GPIO MOCKUP DRIVER" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, 7 Sep 2018 at 09:35, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wrot=
e:
> From: Fathi Boudra <fathi.boudra@linaro.org>
>
> This patch cleans up the Makefile by restructuring a couple of
> things, namely:
> 1) change explicit paths in targets for variables
> 2) substitute a variable (BINARIES) for another, part of the
>    selftests build system (TEST_PROGS_EXTENDED)
> 3) proper cleaning up of the EXTRA objects
>
> The resulting Makefile is much more readable and manageable.
>
> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
> Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/gpio/Makefile | 32 +++++++++++++++--------------=
---
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selfte=
sts/gpio/Makefile
> index 4665cdb..a4a01ec8 100644
> --- a/tools/testing/selftests/gpio/Makefile
> +++ b/tools/testing/selftests/gpio/Makefile
> @@ -1,28 +1,26 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +CFLAGS +=3D -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/
> +LDLIBS +=3D -lmount -I/usr/include/libmount
> +
>  TEST_PROGS :=3D gpio-mockup.sh
> -TEST_FILES :=3D gpio-mockup-sysfs.sh $(BINARIES)
> -BINARIES :=3D gpio-mockup-chardev
> -EXTRA_PROGS :=3D ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
> -EXTRA_DIRS :=3D ../gpioinclude/
> -EXTRA_OBJS :=3D ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
> -EXTRA_OBJS +=3D ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpi=
o-in.o
> -EXTRA_OBJS +=3D ../gpiolsgpio.o
> +TEST_FILES :=3D gpio-mockup-sysfs.sh
> +TEST_PROGS_EXTENDED :=3D gpio-mockup-chardev
> +
> +GPIODIR :=3D ../../../gpio
> +GPIOOBJ :=3D gpio-utils.o
>
>  include ../lib.mk
>
> -all: $(BINARIES)
> +all: $(TEST_PROGS_EXTENDED)
>
>  override define CLEAN
> -       $(RM) $(BINARIES) $(EXTRA_PROGS) $(EXTRA_OBJS)
> -       $(RM) -r $(EXTRA_DIRS)
> +       $(RM) $(TEST_PROGS_EXTENDED)
> +       $(MAKE) -C $(GPIODIR) clean
>  endef
>
> -CFLAGS +=3D -O2 -g -std=3Dgnu99 -Wall -I../../../../usr/include/
> -LDLIBS +=3D -lmount -I/usr/include/libmount
> -
> -$(BINARIES):| khdr
> -$(BINARIES): ../../../gpio/gpio-utils.o
> +$(TEST_PROGS_EXTENDED):| khdr
> +$(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
>
> -../../../gpio/gpio-utils.o:
> -       make ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE) -C ../../../=
gpio
> +$(GPIODIR)/$(GPIOOBJ):
> +       $(MAKE) -C $(GPIODIR)
> --
> 2.7.4

Ping on this series.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
