Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB819C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26B420863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEmFo8A5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26B420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeK3Tok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:44:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44576 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3Toj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:44:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so4400452wrt.11;
        Fri, 30 Nov 2018 00:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zfRaVJKjZlt5JZQz/ov9C7UdMwoX+TdMlhH5XHjsqpA=;
        b=YEmFo8A5FhXBywrJ69tHWKeHdoAcwoi9aeRmHv4Yi6vk5ZugrrX2Mg6wjFBQUDl57g
         PJ6C9WVSBVKpG0k7LabK3QIKrwx7LD16N6+2UctHW2ktmsiiS0lTPxecVpEXZ7gHKLix
         w1ViEP4CETs/VxlQljOc21g0GOwwpLR0vnnlF/xBMvJG8E1jJCrz8wLPnbY/Qrpqjq8A
         8IRzlrEaayTqLYR5533hpvJyC2hKZUhIwnn1tMF9gUC0YAITK0QmE1PYjrKQeI1nMiFR
         HzdXlQZE/NN24L5VB4676g3xVF7FoBGSXjd4sWH3dg8uprYEsn4tqExQ5h3nZykg+3tL
         Am6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zfRaVJKjZlt5JZQz/ov9C7UdMwoX+TdMlhH5XHjsqpA=;
        b=kxk69DbWB+XVIBxOjuVP+3F0diLSIh8AyxokHBXwwHhSp8swcUUQVcdmKAf36L2Eiq
         uyf7/7dOD8WHQDLq8aKcSbNXCUnqwn7gu1Yuv2cEdB8L9NvZVRcnZv/vnG4Doi5sEf+9
         wujszg6spsNjpdm7uYdljnzzgMQFMiUuFK0qR2VVlQM6+66AQVr7NHR4Gp4KZ+1BsyWp
         YNZZdp/Y3I1M7fZkKGtzlZAraoc9mjuguAE5f3/xvXpzTiRq/1Vspgb7EFWACHg7INWW
         F7Sd0nIINlLhxpmoJuXr+6lME3DfzKCA6RlIA+x1Gt34cEtHm9EdVvPagvaOT8gQ7D65
         LYFQ==
X-Gm-Message-State: AA+aEWaoKQhrcpKhkCSuzuWm9Y6BqBD8nru9LiSg7vLLLjjhw/O3rRaD
        L5+i7nJ3E4drEklhfht5hPw=
X-Google-Smtp-Source: AFSGD/WRHUjHesmwyjnyw/Xy41lnZvMRLqNTBk3FgXjdbrGFkkfqgFjR4jZN8k2210O2wFBBPIdk9Q==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr4036211wrv.236.1543566964531;
        Fri, 30 Nov 2018 00:36:04 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s8sm3998331wrn.44.2018.11.30.00.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 00:36:03 -0800 (PST)
Date:   Fri, 30 Nov 2018 09:36:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [PATCH 01/11] x86/efi: Allocate e820 buffer before calling
 efi_exit_boot_service
Message-ID: <20181130083601.GA97998@gmail.com>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-2-ard.biesheuvel@linaro.org>
 <20181130072952.GA16084@gmail.com>
 <CAKv+Gu8OMvnxb-n+ubYETRNhm79_H1RkGp+-7N1KF6Hgg3cbCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8OMvnxb-n+ubYETRNhm79_H1RkGp+-7N1KF6Hgg3cbCQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On Fri, 30 Nov 2018 at 08:29, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > > From: Eric Snowberg <eric.snowberg@oracle.com>
> > >
> > > Commit d64934019f6c ("x86/efi: Use efi_exit_boot_services()")
> > > introduced a regression on systems with large memory maps
> > > causing them to hang on boot. The first "goto get_map" that was removed
> > > from exit_boot insured there was enough room for the memory map when
> > > efi_call_early(exit_boot_services) was called. This happens when
> > > (nr_desc > ARRAY_SIZE(params->e820_table).
> > >
> > > Chain of events:
> > >   exit_boot()
> > >     efi_exit_boot_services()
> > >       efi_get_memory_map <- at this point the mm can't grow over 8 desc
> > >       priv_func()
> > >         exit_boot_func()
> > >           allocate_e820ext() <- new mm grows over 8 desc from e820 alloc
> > >       efi_call_early(exit_boot_services) <- mm key doesn't match so retry
> > >       efi_call_early(get_memory_map) <- not enough room for new mm
> > >       system hangs
> > >
> > > This patch allocates the e820 buffer before calling efi_exit_boot_services
> > > and fixes the regression.
> > >
> > > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > >  arch/x86/boot/compressed/eboot.c | 65 ++++++++++++++++++++------------
> > >  1 file changed, 41 insertions(+), 24 deletions(-)
> >
> > Any objections against marking this for -stable and filing it in
> > efi/urgent? Boot hangs are show-stopper bugs, so distributions would want
> > to backport this fix anyway.
> >
> 
> No objections per se, but this is the kind of patch that might go the
> other way as well, so I would prefer to give it some wider coverage at
> first, given how quickly patches are taken into -stable.
> 
> I can make a note of it and send it to Greg halfway into the next -rc cycle.

So there should be at least one week of testing because I just sent the 
EFI fixes to Linus, plus -stable gets at least a week of testing as well.

Also, in practice, -next and early -rc cycles get only the fraction of 
testing that later -rc's or -stable gets. So if we want this in -stable 
we might as well do it now - or the real testing gets delayed by ~3 
months in practice. That's also the pattern encouraged by Linus: if it's 
a fix that matters then it should be upstreamed with the usual regression 
fixes.

Anyway, your call!

Thanks,

	Ingo
