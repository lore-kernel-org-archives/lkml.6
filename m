Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B371ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA43F208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzWbz4wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA43F208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIXN4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:56:16 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39875 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeIXN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:56:16 -0400
Received: by mail-yw1-f68.google.com with SMTP id v1-v6so725725ywv.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJNCjcNCTvO8CzlPUlOSta4dgsJzCl/QecgNUyV3yqc=;
        b=MzWbz4wjyIUbV3xxYgycVR0Gg9elsDmNiZmMOWrX2YquFw0/X0xfy0AAO9NQaw6Wzn
         7bGZiW9nylxm3lBHQZSl/m4y4XfAAT8ERwb61YmY6c1NZaxK+MlhCO5+MZVuDhjdLFwH
         wfzFsKodjgoA6DvHM5IVMIoIcIJSuUgKi0X9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJNCjcNCTvO8CzlPUlOSta4dgsJzCl/QecgNUyV3yqc=;
        b=pYX4h0LFloVQavwS8riATsDTJwNVKteP0bu6dcHP8k4rVgnBs+mDzJGDoxxyu7DeMk
         AO5ejFXrt+ECuvIWVAZLOMxZViSR69wn20ine9gyBx4Barz5UYpSYEh8bpgUMgv/Rslp
         eprcd9OU2Te8HMo49T7H0k5NT1cD1z2+xQmz12VsyI5+g0lkC5BaAAstPnj2utHuu+8W
         1Sc67sALPSxc97kTRIDA4WSv++lyeu06etJPOXycULsnm3Zql6Lzl6EKgaZwKNQXAE4F
         9xP7swjWZdL74v74rQdFH7/U+N0IbtpnHuUsRGv1PqJx3MxOAaGpkddOhf5DT2uMLEjE
         DFMA==
X-Gm-Message-State: APzg51ClX6q3cOfBWZqHuiTmhXG1q+IXqoAHyxhS+DqZxh4MnAs3O/dv
        oiabWOsrJx/kZFLy9sXUcBDYDnMVr+SZqqCYHhWHqw==
X-Google-Smtp-Source: ACcGV63iEwLFYhaDr8y6iWzFGIYdZs0FOuFUXEVdEsaZa8YVQViyfvbzb4/ZghvhoZ/0HOnZKdf1JTXiFFx9u6CVrro=
X-Received: by 2002:a0d:d801:: with SMTP id a1-v6mr505328ywe.399.1537775726878;
 Mon, 24 Sep 2018 00:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
 <1537455973-12468-5-git-send-email-firoz.khan@linaro.org> <CAMuHMdWZv7eKt+2CSXQ3kgPXc-Vvm7o7zED9afXxnG8dh6+nFA@mail.gmail.com>
In-Reply-To: <CAMuHMdWZv7eKt+2CSXQ3kgPXc-Vvm7o7zED9afXxnG8dh6+nFA@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 24 Sep 2018 13:25:15 +0530
Message-ID: <CALxhOng7vodqyOAceTbv_LxLhe2KfuEgHSx+=8Dj57McQX1qCQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] m68k: uapi header and system call table file generation
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
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

On Mon, 24 Sep 2018 at 12:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> > System call table generation script must be run to generate
> > unistd_32.h and syscall_table.h files. This patch will have
> > changes which will invokes the script.
> >
> > This patch will generate unistd_32.h and syscall_table.h
> > files by the syscall table generation script invoked by
> > arch/m68k/Makefile and the generated files against the
> > removed files will be identical.
> >
> > The generated uapi header file will be included in
> > uapi/asm/unistd.h and generated system call table support
> > file will be included by arch/m68k/kernel/syscall_table.S
> > file.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Thanks for your patch!
>
> > --- a/arch/m68k/include/asm/Kbuild
> > +++ b/arch/m68k/include/asm/Kbuild
> > @@ -24,3 +24,4 @@ generic-y += topology.h
> >  generic-y += trace_clock.h
> >  generic-y += word-at-a-time.h
> >  generic-y += xor.h
> > +generic-y += syscall_table.h
> > \ No newline at end of file
>
> Please add the missing newline.

Sure. Will do. Thanks!

>
> > diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
> > index c2e26a4..6d600e9 100644
> > --- a/arch/m68k/include/uapi/asm/Kbuild
> > +++ b/arch/m68k/include/uapi/asm/Kbuild
> > @@ -21,3 +21,4 @@ generic-y += statfs.h
> >  generic-y += termbits.h
> >  generic-y += termios.h
> >  generic-y += types.h
> > +generic-y += unistd_32.h
> > \ No newline at end of file
>
> Likewise.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
