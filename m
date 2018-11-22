Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79130C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFB020820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fse03GBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFB020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394446AbeKVVmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:42:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35788 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387923AbeKVVmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:42:00 -0500
Received: by mail-io1-f67.google.com with SMTP id u19so6357006ioc.2;
        Thu, 22 Nov 2018 03:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DiSwIeFch/FcBHE03eswGvAIIimwz+a411OMRRzxA0=;
        b=Fse03GBu0EdIoRrrJziu411Mfj9EJ/NIDTX2DLCyilQViiykzbhzT2RD9nlp4MXyC8
         Ad7+WsXcoC3EBpn+XGIHFl5K6OEhfjp/tiYBHo2Sufn9IYEtr7jdvTZyITzHPJ2ETEVS
         t+XLfg5ULeH8xpeOrk26VsMyhJMj5o1PRm2r3kkP2UQNVXT5dihA1FRgrSXkfXBeH3YJ
         jOZdBh1i1dHmJqKkOt+zNGh5rgUkdNks8UVwfvTJ8qXYVAoAIx4dUXNY/GYtm+9ziknp
         LppZg0tl1tluDvIIYHBGkswIz3cZWcURiQmA0pSm+wumj0K54+UlW2yqAfXqIH07H8RU
         WY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DiSwIeFch/FcBHE03eswGvAIIimwz+a411OMRRzxA0=;
        b=EeHSVHK79EYFx+jzDUY6V6VRTCZ2Y5oo33V0a7i06I5KeHA/Wfbhe98XN+9Y0qR7OV
         AasoC6OnMcM3ZufQFWaIjjlc4riRPKLPlItnRudtBZsoCpSxdEDDLKKTwjz2O6E9mDwQ
         fq87S444u9t1Hf++hz2AU3f3zdY1DYnL5DhwspKjCvbw2mWgJ6yHcr60Ux/vtkKA7CgF
         K2YPpkm7TAb+DVwA5l4K93aZLGaYILPx5QOPff3fm0sKkLSi48z8Pm/eBEetokRpde7F
         jlD+LzCrNRWRvgOuXSMSho+filTHP7KgN5eDVm1ZllHuv8SGBw6npNnGROuFlXniBGhu
         xF7Q==
X-Gm-Message-State: AA+aEWbiUJyDAkCPCjmQitxBw4kqXdEJHi5Do6LTqum62lk0lEvrYvMQ
        hIOnyrnj0OfvLyPdpQmfRvKYM0JcEILkYjsW4PE=
X-Google-Smtp-Source: AFSGD/V4GtorgHpxtgZ4nuaXnEuKqTWd6Idr8r+K6HxR34GE86I6C2P/jjgD33LufcKQZFrqlnH/6RbunulALL11PbQ=
X-Received: by 2002:a5d:9818:: with SMTP id a24mr1034364iol.225.1542884585681;
 Thu, 22 Nov 2018 03:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20181121141204.22819-1-tiny.windzz@gmail.com> <CAK8P3a0zwWTyLuihBMaggGkRHeYwo4UrxZrx1qBE=t=A4tKVEw@mail.gmail.com>
 <CAK8P3a1Q=cgL4_GVHhVN-4Su_OJVhZB8uM1i86MsjQJES5TJ5g@mail.gmail.com>
In-Reply-To: <CAK8P3a1Q=cgL4_GVHhVN-4Su_OJVhZB8uM1i86MsjQJES5TJ5g@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 19:02:18 +0800
Message-ID: <CAEExFWsRVHHWSmDwxK3qTcyB4DE5nnuM6saharWzgOV4C09s8Q@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        anders.roxell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 6:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 22, 2018 at 11:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Nov 21, 2018 at 3:40 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > of_find_node_by_path() acquires a reference to the node returned by
> > > it and that reference needs to be dropped by its caller.soc_is_tegra()
> > > doesn't do that, so fix it.Call of_machine_is_compatible() to refactor
> > > soc_is_tegra() whcih automatically manages the reference count.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
>
> Anders ran into a crash after this patch, on a non-tegra qemu platform:
>
> [    0.055907] ASID allocator initialised with 32768 entries
> [    0.063381] rcu: Hierarchical SRCU implementation.
> [    0.137238] Unable to handle kernel paging request at virtual
> address ffff00000935f0c0
> [    0.137274] Mem abort info:
> [    0.137291]   ESR = 0x96000007
> [    0.137320]   Exception class = DABT (current EL), IL = 32 bits
> [    0.137337]   SET = 0, FnV = 0
> [    0.137352]   EA = 0, S1PTW = 0
> [    0.137370] Data abort info:
> [    0.137387]   ISV = 0, ISS = 0x00000007
> [    0.137401]   CM = 0, WnR = 0
> [    0.137456] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> [    0.137479] [ffff00000935f0c0] pgd=00000000bdfff003,
> pud=00000000bdffe003, pmd=00000000bdffa003, pte=0000000000000000
> [    0.137644] Internal error: Oops: 96000007 [#1] PREEMPT SMP
> [    0.137766] Modules linked in:
> [    0.137950] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.20.0-rc3-next-20181122-00006-g38d8a1f80349-dirty #2
> [    0.137975] Hardware name: linux,dummy-virt (DT)
> [    0.138071] pstate: 00000085 (nzcv daIf -PAN -UAO)
> [    0.138110] pc : __of_device_is_compatible+0x30/0x138
> [    0.138132] lr : of_device_is_compatible+0x40/0x68
> [    0.138147] sp : ffff00000804bc80
> [    0.138167] x29: ffff00000804bc80 x28: 0000000000000000
> [    0.138207] x27: 0000000000000000 x26: 0000000000000000
> [    0.138224] x25: ffff80007dfed2a8 x24: ffff000009301000
> [    0.138239] x23: 0000000000000000 x22: 0000000000000000
> [    0.138254] x21: ffff00000935f0c0 x20: ffff00000935f0c0
> [    0.138269] x19: 0000000000000000 x18: 0000000000000400
> [    0.138284] x17: 0000000000000000 x16: 0000000000000000
> [    0.138298] x15: 0000000000000400 x14: 0000000000000400
> [    0.138313] x13: 0000000000000000 x12: 0000000000000020
> [    0.138327] x11: 0000000000000008 x10: 0101010101010101
> [    0.138357] x9 : 6862726efffefeff x8 : 7f7f7f7f7f7f7f7f
> [    0.138373] x7 : fefefefefefeff2e x6 : 0080808080808080
> [    0.138387] x5 : 0000000000000002 x4 : 0000000000000001
> [    0.138402] x3 : 0000000000000000 x2 : 0000000000000000
> [    0.138416] x1 : ffff00000935f0c0 x0 : ffff80007dfed2a8
> [    0.138475] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> [    0.138540] Call trace:
> [    0.138607]  __of_device_is_compatible+0x30/0x138
> [    0.138632]  of_device_is_compatible+0x40/0x68
> [    0.138654]  of_machine_is_compatible+0x34/0x68
> [    0.138672]  soc_is_tegra+0x2c/0x40
> [    0.138689]  tegra_flowctrl_init+0x28/0x108
> [    0.138706]  do_one_initcall+0x5c/0x178
> [    0.138722]  kernel_init_freeable+0xd0/0x240
> [    0.138741]  kernel_init+0x10/0x108
> [    0.138755]  ret_from_fork+0x10/0x18
> [    0.138913] Code: b4000861 f90013b5 aa0103f5 52800013 (39400021)
> [    0.139229] ---[ end trace d4d0fc77e9b04fa6 ]---
> [    0.139448] note: swapper/0[1] exited with preempt_count 1
> [    0.140598] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    0.140767] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
>
> I'm not completely sure what's wrong with the patch, but I assume
> it never worked on non-tegra machines.
>
> > > diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> > > index cd8f41351add..0b40700b672a 100644
> > > --- a/drivers/soc/tegra/common.c
> > > +++ b/drivers/soc/tegra/common.c
> > > @@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine_match[] = {
> > >
> > >  bool soc_is_tegra(void)
> > >  {
> > > -       struct device_node *root;
> > > +       struct of_device_id *match = tegra_machine_match;
> > >
> > > -       root = of_find_node_by_path("/");
> > > -       if (!root)
> > > -               return false;
> > > +       while(match->compatible){
> > > +               if(of_machine_is_compatible(match->compatible))
> > > +                       return true;
> > > +               match++;
> > > +       }
> > >
> > > -       return of_match_node(tegra_machine_match, root) != NULL;
> > > +       return false;
>
> I would also note that this is a rather inefficient way to check
> for a particular platform, as we to do the string search through
> the DT for each entry in the table now instead of doing it once.
>
>        Arnd
Hi Jon:

Do you think we should stick to the new way or go back to the way before?

Yours,
    Yangtao
