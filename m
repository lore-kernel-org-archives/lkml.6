Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA6AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AD720869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGyrziZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AD720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeKSBX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 20:23:27 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50535 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKSBX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 20:23:27 -0500
Received: by mail-it1-f195.google.com with SMTP id a185so3340402itc.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXAPoxwEEap10gcpSJxdYyfAqqZm/P6DHqqPsQGvZU4=;
        b=pGyrziZB/wLVfPyEOMraevd6a0sqhsq5Qal4zYmZN/cYA6lCpjHCu3uh1fBwOWfc72
         HRlky4rZ14VBwLnBsycadY3z1juWITI9t6Iuw2wuYS/v/6/cPDFMzx2tosvLdM0pJukK
         uiTYsmhMgaFqYhmLb0+UwhA20pp7SUjvne8aHXjnwX8Dzi54DwfMXLwbTEXprMWZ6yQN
         HmxTAWxYlm8xMdXWxSX2IRWm8/DFQ7/PYxNOV9pYFBAVCjqOb7uEEOUacUWGG8pG6+29
         QV5S0Ag79EMeup60FEJ+KM0qllSyniBSuTOfVWsKgjV7PopI9IARVTDycxrhHDfWUtrD
         uN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXAPoxwEEap10gcpSJxdYyfAqqZm/P6DHqqPsQGvZU4=;
        b=haSmRPnFR0aLpWUgj3nFFPH93NbPI1SlKaVuQ98Hn6Fx6GTCuMyv8kvEKD6RNuAXQC
         0vmpN8mnSexzV5UszWzPzajdcC37IW8ro/+22y+cTxEewWuHBzP1NVg9BONto/bDah/b
         wzHGL4MEiG1/dN0abxBAWMhRqJoCsBiv3oqGYj5w30lyFqojuhPN2jHRFBtpicwNRNLZ
         zyib97ZlZLZIs+hPUhG1UzpszPpJczZK2ozUVbBHVHzXsIeojDMhCwyMCPeveXUJEG2j
         tQFioaKiUY19b1wrOeAEZbywT1+99rJ6gzUfDejEplIUNER7ctNGir/HTrsitv7aIQrt
         ffqw==
X-Gm-Message-State: AA+aEWad3iQKDbQGYuMKy6u3ZvqcyUYvEF0tmVvM2rTtsF38pZpjaDH0
        ecnciri+FQQ9f0iOgGdnkWCoKAU82hqtk8Ced1s=
X-Google-Smtp-Source: AFSGD/UX7keu9Msd51q9vvgsYuqDoQw5jEs1K5obs+nyTg4LSzlhgRlw61JZGbXp3BJTTGShJyqM66YkOWHzNAXqr/o=
X-Received: by 2002:a24:f982:: with SMTP id l124mr5166077ith.59.1542553375686;
 Sun, 18 Nov 2018 07:02:55 -0800 (PST)
MIME-Version: 1.0
References: <1542542538-11938-1-git-send-email-laoar.shao@gmail.com> <20181118121318.GC7861@bombadil.infradead.org>
In-Reply-To: <20181118121318.GC7861@bombadil.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 18 Nov 2018 23:02:19 +0800
Message-ID: <CALOAHbAfWkAYJPTRfyPmHKSmg7UEhtnamzUVx9xd4oYkqi_x8g@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap.c: minor optimization in write_iter file operation
To:     willy@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, darrick.wong@oracle.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 8:13 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Nov 18, 2018 at 08:02:18PM +0800, Yafang Shao wrote:
> > This little adjustment on bitwise operation could make the code a little
> > faster.
> > As write_iter is used in lots of critical path, so this code change is
> > useful for performance.
>
> Did you check the before/after code generation with this patch applied?
>

Yes, I did.
My oompiler is gcc-4.8.5, a litte old, and with CONFIG_CC_OPTIMIZE_FOR_SIZE on.
The output file is differrent.

> $ diff -u before.S after.S
> --- before.S    2018-11-18 07:11:48.031096768 -0500
> +++ after.S     2018-11-18 07:11:36.883069103 -0500
> @@ -1,5 +1,5 @@
>
> -before.o:     file format elf32-i386
> +after.o:     file format elf32-i386
>
>
>  Disassembly of section .text:
>
> with gcc 8.2.0, I see no difference, indicating that the compiler already
> makes this optimisation.

Could pls. try set CONFIG_CC_OPTIMIZE_FOR_SIZE on and then compare them again ?

Thanks
Yafang
