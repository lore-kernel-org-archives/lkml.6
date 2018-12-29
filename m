Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4D6C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184C420815
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeL2Vhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 16:37:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36730 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeL2Vhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 16:37:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so26505446qtn.3;
        Sat, 29 Dec 2018 13:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwVwB1S8LdUynVFe20mibVGVOLUyPee2SJD6q4AnfTg=;
        b=H1GeJMCciFk9ozbZ0QeRWAm8NR1xSWI10A2Dq3O8EVGz08dVo2bwIcZ22Coxf4QZk/
         LdCdf/tzl8S0a+QKI88UcBIFdVlAy7ktqIxJXwdVnSVm68UBUoH6TC4K0LkjfDwa0Js/
         dP9Fp1IO+jrfwFZQmID8UnRi+zFsylH1E/7Iyk8xY3BZ0e/ZFUuzYk1XRre3mJo92UbX
         TN9N3EmiPGHH6dR2hgJnCS1BgRMVuAeeOpoAujxiFRNihml7GxxwTplyYUbXs1/YhEqS
         qPwS1HBBLdSv9bRciOzAyD/vs00I+S3MpgdhamSm9lOPzXY44gvnx3kwKp2AEWz7hOiK
         gt1g==
X-Gm-Message-State: AJcUukekFp5EmYJWjWCW4xMligD4vtTuOnK6kCa+geSwb3RfL2HeoR5g
        3/RTSGnSnPhBG/FHDHBcWg7EbeBvePopJu6YmR8ivmF4
X-Google-Smtp-Source: ALg8bN5t2ynaRnOoH0ytyUov60/lnzeVr55hB9q7byJScxyC9/TYJH41eW1NcVvy4FlcA8WtxHp8K6moh+7TivOOWBw=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr30406307qvm.149.1546119458090;
 Sat, 29 Dec 2018 13:37:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet> <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
 <alpine.LNX.2.21.1812291327380.152@nippy.intranet> <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>
In-Reply-To: <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Dec 2018 22:37:20 +0100
Message-ID: <CAK8P3a1J3sy55nd5QbxR5AjxkLyE-RE=bDNKB9sG27xx=mZ60A@mail.gmail.com>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 3:51 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Hi Finn,
>
> Am 29.12.2018 um 15:34 schrieb Finn Thain:
> > On Sat, 29 Dec 2018, Michael Schmitz wrote:
> >
> >>
> >> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to suggest.
> >>
> >> Or (really going out on a limb here):
> >>
> >> IS_BUILTIN(CONFIG_NVRAM) ||
> >> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
> >>
> >> Not that I'd advocate that, for this series.
> >>
> >
> > Well, you are a maintainer for atari_scsi.c.
> >
> > Are you saying that you want IS_BUILTIN(CONFIG_NVRAM) used here instead of
> > ifdef?
>
> No, just pointing out that there would be a way to avoid the ifdef
> without messing up driver behaviour. I'm fine with the ifdef - not least
> because it clearly eliminates code that would be unreachable.
>
> (On second thought - I don't want to speculate whether there's weird
> compiler options that could result in the nvram_check_checksum and
> nvram_read_bytes symbols to still be referenced in the final link, even
> though IS_BUILTIN(CONFIG_NVRAM) always evaluates to false. Best leave
> this as-is.)

As far as I know, it's totally reliable with the supported compilers (gcc-4.6+).
In the older compilers (e.g. 4.1), there was a corner case, where it could
have failed to eliminate a function that was only referenced through a pointer
from a discarded variable, but a plain IS_ENABLED() check like the one here
was still ok, and lots of code relies on that.

Other than that, I agree either way is totally fine here, so no objections
to using the #ifdef.

      Arnd
