Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD29C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB02080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="r33nfh9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAB02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeJ3D7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:59:18 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:42238 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJ3D7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:59:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id B817F644;
        Mon, 29 Oct 2018 19:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540840157; x=1542654558; bh=DzVhpi4lJw
        tQXa6n4ECe7toEu/j8VT8uqR54fAW0d9Q=; b=r33nfh9vzrh0IhqicTYUV/m9LD
        lfNo0kOFZpwHPfUHpZtTG3d2pICoKX0IXsw1DAVpeH6cKU6K/4cVQLewYu8f7t8J
        AvACg3e7psQRm9gh55X0TYmJ94FkzjSO1b+b4GvY+lvhIb4Ql0Mg5rXkuXRwgTih
        nJ8AgAc+rxFO/6ZHhu1K6lzHFKwP5FixF4DCjNo1vavEmJg1ykgXPTBFOlp9uKif
        S5+lmrVtxLGNMRyvj6/HJv8uQxwXizJEidMBM07EGZ22QUQ1pAw2te6xaHJoA33U
        n/XLunEEC9tWKvs3EHY9M8Sfjz86JqdI7clGy8BLVh5jNz20xtj3IsAsclfA==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4V5kkHk-wzLP; Mon, 29 Oct 2018 14:09:17 -0500 (CDT)
Received: from mail-it1-f176.google.com (mail-it1-f176.google.com [209.85.166.176])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id 87B92221;
        Mon, 29 Oct 2018 14:09:17 -0500 (CDT)
Received: by mail-it1-f176.google.com with SMTP id m15so10808387itl.4;
        Mon, 29 Oct 2018 12:09:17 -0700 (PDT)
X-Gm-Message-State: AGRZ1gI1UgHwB9oNAsglOMZmUQtd0rrXpApTsUsCPVXMfy7QD7lJulaO
        iGynXUQ+fRQHczqCk/ktdWT2/w2e8SG7ZP8DUdM=
X-Google-Smtp-Source: AJdET5eEdutDBaL9+MILQsqkGRMG8ON7SAPJFmpOuVhT+u4t1AAndY7cpzyUqV1daOLOg5W9heP9G+xBiYpXJlk7o0w=
X-Received: by 2002:a24:bcc1:: with SMTP id n184-v6mr10799171ite.174.1540840157251;
 Mon, 29 Oct 2018 12:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <1539981557-13590-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1539981557-13590-1-git-send-email-wang6495@umn.edu>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Oct 2018 14:08:40 -0500
X-Gmail-Original-Message-ID: <CAAa=b7ffkENv=OYDToZgr9fK5qnKs8orMXioQ8ABkFHJ+qTpsA@mail.gmail.com>
Message-ID: <CAAa=b7ffkENv=OYDToZgr9fK5qnKs8orMXioQ8ABkFHJ+qTpsA@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: sis: fix a missing-check bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, thomas@winischhofer.net,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can anyone please confirm this bug? Thanks!

Wenwen

On Fri, Oct 19, 2018 at 3:39 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In sisfb_find_rom(), the official pci ROM is checked to see whether it
> contains the expected value at specific locations. This is done by firstly
> mapping the rom into the IO memory region 'rom_base' and then invoking
> sisfb_check_rom() to perform the checks. If the checks succeed, i.e.,
> sisfb_check_rom() returns 1, the whole content of the rom is then copied to
> 'myrombase' through memcpy_fromio(). The problem here is that the checks
> are conducted on the IO region 'rom_base' directly. Given that the device
> also has the permission to access the IO region, it is possible that a
> malicious device controlled by an attacker can race to modify the values in
> the region after the checks but before memcpy_fromio(). By doing so, the
> attacker can supply unexpected roms, which can cause undefined behavior of
> the kernel and introduce potential security risk. The following for loop
> also has a similar issue.
>
> To avoid the above issue, this patch firstly copies the content of the rom
> and then performs the checks on the copied version. If all the checks are
> satisfied, the copied version will then be returned.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/video/fbdev/sis/sis_main.c | 52 ++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
> index 20aff90..a2d8051 100644
> --- a/drivers/video/fbdev/sis/sis_main.c
> +++ b/drivers/video/fbdev/sis/sis_main.c
> @@ -4089,29 +4089,29 @@ static int __init sisfb_setup(char *options)
>  }
>  #endif
>
> -static int sisfb_check_rom(void __iomem *rom_base,
> +static int sisfb_check_rom(unsigned char *rom_base,
>                            struct sis_video_info *ivideo)
>  {
> -       void __iomem *rom;
> +       unsigned char *rom;
>         int romptr;
>
> -       if((readb(rom_base) != 0x55) || (readb(rom_base + 1) != 0xaa))
> +       if ((*rom_base != 0x55) || (*(rom_base + 1) != 0xaa))
>                 return 0;
>
> -       romptr = (readb(rom_base + 0x18) | (readb(rom_base + 0x19) << 8));
> +       romptr = (*(rom_base + 0x18) | (*(rom_base + 0x19) << 8));
>         if(romptr > (0x10000 - 8))
>                 return 0;
>
>         rom = rom_base + romptr;
>
> -       if((readb(rom)     != 'P') || (readb(rom + 1) != 'C') ||
> -          (readb(rom + 2) != 'I') || (readb(rom + 3) != 'R'))
> +       if ((*(rom)     != 'P') || (*(rom + 1) != 'C') ||
> +          (*(rom + 2) != 'I') || (*(rom + 3) != 'R'))
>                 return 0;
>
> -       if((readb(rom + 4) | (readb(rom + 5) << 8)) != ivideo->chip_vendor)
> +       if ((*(rom + 4) | (*(rom + 5) << 8)) != ivideo->chip_vendor)
>                 return 0;
>
> -       if((readb(rom + 6) | (readb(rom + 7) << 8)) != ivideo->chip_id)
> +       if ((*(rom + 6) | (*(rom + 7) << 8)) != ivideo->chip_id)
>                 return 0;
>
>         return 1;
> @@ -4124,6 +4124,10 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>         unsigned char *myrombase = NULL;
>         size_t romsize;
>
> +       myrombase = vmalloc(65536);
> +       if (!myrombase)
> +               return NULL;
> +
>         /* First, try the official pci ROM functions (except
>          * on integrated chipsets which have no ROM).
>          */
> @@ -4131,20 +4135,15 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>         if(!ivideo->nbridge) {
>
>                 if((rom_base = pci_map_rom(pdev, &romsize))) {
> -
> -                       if(sisfb_check_rom(rom_base, ivideo)) {
> -
> -                               if((myrombase = vmalloc(65536))) {
> -                                       memcpy_fromio(myrombase, rom_base,
> -                                                       (romsize > 65536) ? 65536 : romsize);
> -                               }
> -                       }
> +                       memcpy_fromio(myrombase, rom_base,
> +                                       (romsize > 65536) ? 65536 : romsize);
>                         pci_unmap_rom(pdev, rom_base);
> +
> +                       if (sisfb_check_rom(myrombase, ivideo))
> +                               return myrombase;
>                 }
>         }
>
> -       if(myrombase) return myrombase;
> -
>         /* Otherwise do it the conventional way. */
>
>  #if defined(__i386__) || defined(__x86_64__)
> @@ -4156,24 +4155,17 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>                         rom_base = ioremap(temp, 65536);
>                         if (!rom_base)
>                                 continue;
> -
> -                       if (!sisfb_check_rom(rom_base, ivideo)) {
> -                               iounmap(rom_base);
> -                               continue;
> -                       }
> -
> -                       if ((myrombase = vmalloc(65536)))
> -                               memcpy_fromio(myrombase, rom_base, 65536);
> -
> +                       memcpy_fromio(myrombase, rom_base, 65536);
>                         iounmap(rom_base);
> -                       break;
>
> +                       if (sisfb_check_rom(myrombase, ivideo))
> +                               return myrombase;
>                 }
>
>         }
>  #endif
> -
> -       return myrombase;
> +       vfree(myrombase);
> +       return NULL;
>  }
>
>  static void sisfb_post_map_vram(struct sis_video_info *ivideo,
> --
> 2.7.4
>
