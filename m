Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F4C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9F12146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9F12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeLAAxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:53:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37089 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLAAxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:53:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id z16so5917650qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvCNnwTCIErvOoJQOcvV750sKrkF6TtyT01sFAzs1Yk=;
        b=We+Mm5bxUylNdP6humxigx9rfaz8wPksey6aftUYoTzsAmVo+zXWASrziZLYzhOa0U
         52cJZO9j5G2o5v4Qe0LdBnuIvge368MprfzYoqvT0RoOFva7gPayHM8NfnsVI912PPJn
         vIgvfwKpcNjB9ZeJ1+swMbsdXYOUgCLBiqJbxtX3BBoYRtCD7A5rDxh75v4YAARiSMKh
         qxYmwdsLQbuuk2GkFllwfqdFnVrGvGjiFOeFZSdEfNaOx2EhTrEMyXnvCVWTjZTp7LOG
         6FbYNstSmr5gIzO7ZZvt7JfTy7xB9oPQMGjK8BLsm+oyyAzQL4ABRzJnIsUjFfnDxJ5z
         8jOA==
X-Gm-Message-State: AA+aEWZ7RltHpgLeumbrMjlmQFkWMvd7GTsQMV+9Yyk+aOgN8saisNY2
        DsKqJtC2W5Yg3kId5tRea2sY+BZGtKkj8kR7NsY=
X-Google-Smtp-Source: AFSGD/Wf1UJHgAw+SoirwwvrfQSIDDV3ampaiXa591gwtLvU6LsCy1FKy8aNzBAdzH2UgweuUug8kUFHjJDaVZHmFaM=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr5415765qvl.180.1543585470428;
 Fri, 30 Nov 2018 05:44:30 -0800 (PST)
MIME-Version: 1.0
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
 <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com> <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
 <d2d133e5-267c-c42a-7329-22892bbbdee4@synopsys.com> <CAK8P3a2U3ft3crF2SiAuc=PQdDooEUaVAN9gQDyxsxvBn5+xRw@mail.gmail.com>
 <57437493-31bb-eced-032c-1f54470b030e@synopsys.com>
In-Reply-To: <57437493-31bb-eced-032c-1f54470b030e@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 14:44:13 +0100
Message-ID: <CAK8P3a2mqEb4_F4wB1DvL5jJJobLhOg6-bW3ZDNGhvbv-_qW3A@mail.gmail.com>
Subject: Re: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
To:     jose.abreu@synopsys.com
Cc:     David Laight <David.Laight@aculab.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        alexey.brodkin@synopsys.com, Joao Pinto <joao.pinto@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 9:57 AM Jose Abreu <jose.abreu@synopsys.com> wrote:
> On 29-11-2018 21:20, Arnd Bergmann wrote:
> > On Thu, Nov 29, 2018 at 5:14 PM Jose Abreu <jose.abreu@synopsys.com> wrote:
> >> See how the if condition added in this version is checked in
> >> <test_readsl+0xe92> and then it takes two different loops.
> > This looks good to me. I wonder what the result is for CPUs
> > that /do/ support unaligned accesses. Normally put_unaligned()
> > should fall back to a simple store in that case, but I'm not
> > sure it can fold the two stores back into one and skip the
> > alignment check. Probably not worth overoptimizing for that
> > case (the MMIO access latency should be much higher than
> > anything you could gain here), but I'm still curious about
> > how well our get/put_unaligned macros work.
>
> Here is disassembly for an ARC CPU that supports unaligned accesses:
>
> -->8---
> 00000d48 <test_readsl>:
>  d48:    breq_s r1,0,28            /* if (count) */
>  d4a:    tst    r0,0x3
>  d4e:    bne_s 32                /* if (bptr % ((t) / 8)) */
>
>  d50:    ld r2,[0xdeadbeef]        /* first loop */
>  d58:    sub_s r1,r1,0x1
>  d5a:    tst_s r1,r1
>  d5c:    bne.d -12
>  d60:    st.ab r2,[r0,4]
>
>  d64:    dmb    0x1                    /* common exit point */
>  d68:    j_s    [blink]
>  d6a:    nop_s
>
>  d6c:    ld r2,[0xdeadbeef]        /* second loop */
>  d74:    sub_s r1,r1,0x1
>  d76:    tst_s r1,r1
>  d78:    bne.d -12
>  d7c:    st.ab r2,[r0,4]
>
>  d80:    b_s -28                    /* jmp to 0xd64 */
>  d82:    nop_s
> --->8---
>
> Notice how first and second loop are exactly equal ...

Ok, so it's halfway there: it managed to optimize the the unaligned
case correctly, but it failed to notice that both sides are
identical now.

      Arnd
