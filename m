Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A80EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B764420659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZxgrlX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B764420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIFKcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:32:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34650 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeIFKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:32:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so7934673eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 22:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtzJ17LvWV4Sh8no/rLARVBkY1nCXns8Q210LLvvSzk=;
        b=ZZxgrlX6k732fck9Reh+diImG4GqRg4Y476/K3iKhfqU10dt884dj0bhrbeQZ8f2PC
         mKcZZRQE7OWbMamD6748AM08ZKgOGkjvSa1lXQYnH8FzJUulUlZFjPQxmyn782YB1I9B
         TMtRzu6IdNk7NDaYIWBRzB2qV/JsVfnyUaM7loObhL28/7EW7rft/DuYOmd+rTrtODhV
         2konDGAV7VPb7zggHy0Gi2C49V5sna6ybvDzpWn8pIy8KFC247vcKlCAJ0DUoQrKkqj+
         Ks6CvBlxXUQ4aHGct6HHHAeGnx7RiB6YfWbtqSleLHukQpvt1PXv+V09LSnQE5UdoO8L
         HQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtzJ17LvWV4Sh8no/rLARVBkY1nCXns8Q210LLvvSzk=;
        b=un5wxpgWy1Kfi9ROJP6zcdfBy8vgrF0eAldyewS8PzU9NNNcKMH3H8UNGK2O1AP8Hx
         XsSQJPBqiDYmg6JdS47220lw8rRlRBtRsAn0LQJIiQYLIxsscBVxss8UlQLgv0l/yNRe
         /jaTARrfk/epLYU8wKA5w3yPkrl+WhcqLxTktt46TqbDCTMPKluI7x/W/6zQpvb4McWx
         PWl3BnBKws9Y5+jelxv1DRkxB8E68V55hE86WOckSnS9De5Bhfb5+Hjqbf3OyrEIQnXo
         /OgZoSshcicCe0GA0gMM9wNPKzQ/6NmYmvrRxxC/B3VYcWzAUL2iATRTF6tyG/5k7BRP
         J0FA==
X-Gm-Message-State: APzg51CMAD4IkFXHMiaztDHomz7KtEsKEjLlchNrJva0m29q4ePifLgz
        gxxC2xaht+9KbNBJ4TuT/q/tyxA+OquLEctGBw==
X-Google-Smtp-Source: ANB0Vda1nbNE/y+H7VzfKBS/KcPCsWy1Z0vhGbZnsVZ+OqmmincsQFDwGsOwx0da7/G0YrqoJW5LDi0l7xvGJSYtgxY=
X-Received: by 2002:aa7:c384:: with SMTP id k4-v6mr1751881edq.270.1536213499835;
 Wed, 05 Sep 2018 22:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <1536201382-13133-1-git-send-email-kernelfans@gmail.com> <20180906040723.GC8555@localhost.localdomain>
In-Reply-To: <20180906040723.GC8555@localhost.localdomain>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 6 Sep 2018 13:58:08 +0800
Message-ID: <CAFgQCTtafOH45aPZeLwi7bWoJTjjKq7dp2_VAF1hHVrwG0qRKA@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/boot/KASLR: enhance randomness of kernel load
 addr when using GiB hugepage
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 12:07 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Thu, Sep 06, 2018 at 10:36:19AM +0800, Pingfan Liu wrote:
>
> Hi Pingfan,
>
> >commit 747ff6265db4 ("x86/boot/KASLR: Skip specified number of 1GB huge
> >pages when doing physical randomization (KASLR)") and commit
> >9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages
> >handling") prevent the physical load addr of kernel from spoiling a good
> >candidate of GiB page. But the algorithm deterministicly chooses the most
> >front GiB page for hugetlb, and sacrifices the randomness, which
> >is the heart of the KASLR. This patch tries to enlarge the randomness in
> >the cases where hugepages=X < the num Y of good candidate of GiB
>
> Yes, in some situations, if Y > X, the patch would reduce the
> randomness. And to reserve a fixed 1G for huge page is not perfect
> enouth.
> But the the size of slot is so small, the size of memory is so big.
>
Yes, but this is the sense of a human,. and normally, we are protected
against the attack from a program.

> >page.
> >To comparison, taking a typical KVM guest for example, the head 3GiB mem
> >can not be used as GiB hugetlb. Denoting the total mem size as Z(GiB), when
> >Z=5, then Y=2, assuming X=1, the randomness range before this patch is
> >4GiB, after this patch is 5GiB, and get a 25% improvement of randomness.
>
> Such as your example,
> in 4G, the probability every slot chosen is about 0.00049
> in 5G, the probability every slot chosen is about 0.00039
> Yes, you did improve 25% for randomness. But I wonder if it's worth to
> improve from 0.00049 to 0.00039.
>
This is the case of least improvement.

> If there is something wrong in my understanding, please let me know.
>
Yes, you get my idea. There are two factor worth to consider. The 1st
one is the head 3GiB, if it can be reduce to 1GiB or 2GiB, then the
randomness will have a great improvement. The 2nd one is the X, which
also play a important role of the randomness.

Thanks and regards,
Pingfan

> Thanks,
> Chao Fan
>
> >If Z=6, then Y=3, assuming X=2, the improvement equals: 50%( 6/(6-2) - 1);
> >assuming X=1, the improvement will be: 20% (6/(6-1) - 1)
> >
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >Cc: Baoquan He <bhe@redhat.com>
> >Cc: Chao Fan <fanc.fnst@cn.fujitsu.com> (authored:1/16=6%)
> >Cc: x86@kernel.org
> >
> >Pingfan Liu (3):
> >  x86/boot/KASLR: change the prototypes of
> >    process_efi_entries/process_e820_entries
> >  x86/boot/KASLR: change the prototype of process_mem_region() to meet
> >    the align requirement
> >  x86/boot/KASLR: enhance randomness when using GiB hugepage
> >
> > arch/x86/boot/compressed/kaslr.c | 228 ++++++++++++++++++++++++++-------------
> > 1 file changed, 152 insertions(+), 76 deletions(-)
> >
> >--
> >2.7.4
> >
> >
> >
>
>
