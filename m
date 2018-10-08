Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD3C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEAC2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfNmjPuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEAC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJHQGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:06:07 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44597 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJHQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:06:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id x5-v6so7969536ybl.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sGQfFzxBV3oPaUKUBORu2qLMvmufWQBTzgqreKSdNM=;
        b=GfNmjPuQ0z2p8vTPSuhDNgT0W+0yRvDIMufrhff8bJrki2/atI4cbSSe/gpjeRJZpX
         PX5g0wwD3NhgqM3GDLBDfS/cK+xdNpIfLMzVZnAxh65twCUDWX7V3xWlFr860QZtIjJi
         GLyMmHCDk6YNiZvH4AGkGEc/YAMVoTAbT33GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sGQfFzxBV3oPaUKUBORu2qLMvmufWQBTzgqreKSdNM=;
        b=qyRGT/cPB/fzy8bTx0mJAjbl5g64yGBqtc/W5zSlMqSQ9OF/+x1WFEFhGkXqbfsf5Z
         C417Fr5dJGnRYS+lIopMBhjZxPogZKPmRU8yfDokizxrgPdnUqeC7JSfP1NIdwHj2KY3
         wU021Z/OBmm7GhSUOZd7AF2vHmRCxCJcXoJyk3bWFQwKaOAiTauMqa9m/TaCGqZ7lQ0Z
         ikIiEoV/ybHqhvhfdXmsSntQPXf0gSQl2fUqC1RWqPQgbj5h232awrgYk2MINKuXPS+j
         A3SLZE4C8RQ8JfdxNbDadC3bpqzWeN+/dm4AoV0rYNE+rDaGu4rPAXw4JtX1cjKEQDBY
         cJBA==
X-Gm-Message-State: ABuFfogo7sqluYkK5GIrZU2syec6Ll5ugpqUEcTt5rsYfxDL8j3bvJhG
        3sUU9GwYJ6nBC3xSVuz2hfgw0sVAbXYHQqjH3cVa/A==
X-Google-Smtp-Source: ACcGV62WdRuOl6KRpOhoHmxOd4aVQPO8bbSybHssiIREW2Qndk/9rdVYfTdZPgSx4jMdaSAArL46889PTf6fh98HAtA=
X-Received: by 2002:a25:8242:: with SMTP id d2-v6mr12647957ybn.166.1538988927440;
 Mon, 08 Oct 2018 01:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org> <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
 <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de> <CALxhOniZQEMCOY-B1F5=MCdpCYMbeGQAJTtPXhVyJ5TxtOEA5A@mail.gmail.com>
 <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com>
In-Reply-To: <CAMuHMdWOKmnn18yS_dHNjgT8rrVsUc3ipGpMTQbyEBujHuVE8w@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 8 Oct 2018 14:25:16 +0530
Message-ID: <CALxhOnjEBFF8cnwm6MqNwZjpJbA8y_g8kQCrjMiALftcYJmjMQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
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

Hi Geert,

On Mon, 8 Oct 2018 at 13:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Firoz,
>
> On Mon, Oct 8, 2018 at 8:49 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Mon, 8 Oct 2018 at 11:36, Helge Deller <deller@gmx.de> wrote:
> > > On 08.10.2018 07:52, Firoz Khan wrote:
> > > > On Mon, 8 Oct 2018 at 11:11, Helge Deller <deller@gmx.de> wrote:
> > > >> On 08.10.2018 07:16, Firoz Khan wrote:
> > > >>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > > >>> ---
> > > >>>  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
> > > >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > > >>> index 4e85293..4334bb7 100644
> > > >>> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> > > >>> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> > > >>> @@ -349,4 +349,5 @@
> > > >>>  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
> > > >>>  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> > > >>>  349     common  statx                           sys_statx
> > > >>> -350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > > >>> \ No newline at end of file
> > > >>> +350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > > >>> +351  common  rseq                            sys_rseq                        compat_sys_rseq
> > > >>
> > > >> You can't add the rseq syscall for parisc yet.
> > > >> It needs additional code in the kernel for parisc which hasn't been tested yet.
> > > >> See my initial untested patch at https://patchwork.kernel.org/patch/10495209/
> > > >
> > > > Thanks for your update!
> > > >
> > > > When I compiled the kernel I got below warnings.
> > > >
> > > > <stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
> > > > <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> > > >
> > > > I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
> > > > syscall is gone. But we definitely have to keep rseq entry on parisc
> > > > architecture.
> > >
> > > I prefer to keep the warning for rseq for now.
> >
> > I'm fine with this.
> >
> > > It reminds me that we still may want the rseq syscall.
> > > If the warning is a problem, you may simply add the __IGNORE_rseq define.
> >
> > But I still feel to keep an IGNORE entry, so once you test your patch; we can
> > remove IGNORE entry and update the syscall.tbl.
>
> If the warning is bogus (e.g. obsolete syscall), an IGNORE entry
> should be added.

nfsservctl  look like an obsolete one, so I added an IGNORE entry in
script/checksyscalls.h

> If the warning is due to a not-yet-implemented feature, IMHO it should not be
> silenced, as that would give the false impression that the feature is
> present and
> implemented.

Helge had done some implementation for rseq but not tested. So we
either add an IGNORE
entry or leave the warning as it is.

Thanks
Firoz

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
