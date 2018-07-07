Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CE9C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8740A215E5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJInBf7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8740A215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeGGJDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 05:03:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:47030 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeGGJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 05:03:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so27734263oie.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwWAqO1qpWzrLm+tvUPxnqu74EjpZhqQesoesetkjng=;
        b=rJInBf7yA5W49kk7FPNx1hncresLnLlfxPAQ5DoRilKLKRV/kgOfk/cvONm2MYL+wG
         F7iy3u2YDnytLRyzt3R+NQc1t8M1TJu/7IUtpmJnoyFQmGn1MG/MOqKM4sdPYnCGuRHS
         QPvpSIMyCM5cmU4kMKSdpmgnMYQjUDfAEFl5zwGE8cMHlVRU1S8YbWi1E9deAlSsJgtx
         M2PkADi13pTnwITeleCSoxYlO4vM9L2F8F4uid2CKeC4xuTUMMRfSJJmmmv5r5Z4jbzl
         07e3qTsot3rcag7walIer7lqIspTrcLWgNoDAFWSmTWOU8CQKafoXkBXIp/19qMfCUL3
         SOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwWAqO1qpWzrLm+tvUPxnqu74EjpZhqQesoesetkjng=;
        b=SKzPB/zZwEa3COOHcxoMwOCeA3uUgJ+qLqSNQ6xRVFtbF8Bkt9AucJPuhAddSrgSj1
         eM+3sW8Qn9d41TVmUA4jR9CuiFqCrg6ErnEWkCKBCncBLFrh+26ojuHfGXhhKnfYBA7R
         pDMfD0ZyGltVeemmZ1B4m0/yN4kYkP0dCGggohNm9V/A00z3o9STJpNdGzwWwk+Gelg/
         U4A+0YaL+XYCkfM6dI4jhB6zb/Cn4wbLKE5v/mh1yK4pP1B9Si9d3UwVUcyJdwWUd3Qd
         1VpxCWfehemfociF1wrqjziaFV2GylDtRct8VaG8suNJ53CWMMBvcO9CaTKwBMD0Jti6
         DQKQ==
X-Gm-Message-State: APt69E3SEiz9srLiYBptzjYisoasX/pdj4r5PCjdESld+A8Iw1tq+T4A
        AzeV+50oYMgwACM2K84n1JQWH3LUKmyH6ZbX/DfM0Q==
X-Google-Smtp-Source: AAOMgpfz/V/Vf3MwHwQ6ms7ZC1av9XxmJwOaJrdM90yiv5C4ZyvTojjHFhbxTAfUJmsifziMOnZGeRsF1Z0lLMsdcvE=
X-Received: by 2002:aca:d015:: with SMTP id h21-v6mr15709112oig.142.1530954207397;
 Sat, 07 Jul 2018 02:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180707033722.219468-1-jannh@google.com> <20180707104412.1580a285@bbrezillon>
In-Reply-To: <20180707104412.1580a285@bbrezillon>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 7 Jul 2018 11:03:00 +0200
Message-ID: <CAG48ez3MUm=0iJSY21BNOFBJt=gWgGAQTwM8cz5d_wNwpMyQeg@mail.gmail.com>
Subject: Re: [PATCH] mtdchar: fix overflows in adjustment of `count`
To:     boris.brezillon@bootlin.com
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc linux-api

On Sat, Jul 7, 2018 at 10:44 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Sat,  7 Jul 2018 05:37:22 +0200
> Jann Horn <jannh@google.com> wrote:
>
> > The first checks in mtdchar_read() and mtdchar_write() attempt to limit
> > `count` such that `*ppos + count <= mtd->size`. However, they ignore the
> > possibility of `*ppos > mtd->size`, allowing the calculation of `count` to
> > wrap around. `mtdchar_lseek()` prevents seeking beyond mtd->size, but the
> > pread/pwrite syscalls bypass this.
> >
> > I haven't found any codepath on which this actually causes dangerous
> > behavior, but it seems like a sensible change anyway.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  drivers/mtd/mtdchar.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> > index cd67c85cc87d..02389528f622 100644
> > --- a/drivers/mtd/mtdchar.c
> > +++ b/drivers/mtd/mtdchar.c
> > @@ -160,8 +160,12 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
> >
> >       pr_debug("MTD_read\n");
> >
> > -     if (*ppos + count > mtd->size)
> > -             count = mtd->size - *ppos;
> > +     if (*ppos + count > mtd->size) {
> > +             if (*ppos < mtd->size)
> > +                     count = mtd->size - *ppos;
> > +             else
> > +                     count = 0;
> > +     }
>
> Hm, shouldn't we return -ERANGE or -EINVAL if *ppos >= mtd->size?

Hmm, good question.
The pread() manpage says that pread() can return the same errors as
lseek(), and the lseek() manpage says that -EINVAL is for when you're
trying to seek beyond the end of a seekable device. So from the
documentation, it sounds as if you're right.
But testing pread() beyond end of file for various things on my
machine seems to just return 0:

# cat pread.c
#include <unistd.h>
#include <stdlib.h>
int main(int argc, char **argv) {
  char buf[0x1000];
  off_t off = strtoul(argv[1], NULL, 0);
  pread(0, buf, 0x1000, off);
}
# gcc -o pread pread.c
# strace -e trace=pread64 ./pread 200000000 < /dev/sda1
pread64(0, "", 4096, 200000000)         = 0
+++ exited with 0 +++
# strace -e trace=pread64 ./pread 100000 <
/sys/kernel/debug/x86/tlb_single_page_flush_ceiling
pread64(0, "", 4096, 100000)            = 0
+++ exited with 0 +++
# strace -e trace=pread64 ./pread 20000000000 < /dev/dm-2
pread64(0, "", 4096, 20000000000)       = 0
+++ exited with 0 +++

Do you know of precedent for returning -EINVAL if *ppos is beyond the
end of the device?

> >
> >       if (!count)
> >               return 0;
> > @@ -246,7 +250,7 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
> >
> >       pr_debug("MTD_write\n");
> >
> > -     if (*ppos == mtd->size)
> > +     if (*ppos >= mtd->size)
> >               return -ENOSPC;
> >
> >       if (*ppos + count > mtd->size)
>
