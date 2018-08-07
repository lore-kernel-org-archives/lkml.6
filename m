Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA13BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF57208AC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arm-com.20150623.gappssmtp.com header.i=@arm-com.20150623.gappssmtp.com header.b="v+W0kRw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF57208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbeHGNRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:17:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43891 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeHGNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:17:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so8403967pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5AOcbbpnqGz/ft22xwlfmGgcim1722Z0SVCOa2jf3dU=;
        b=v+W0kRw5LJvWxMqNE69x6gM5FbTJP0ncM+mSbXQp5QkUAI5IN5R/SaJ//U80o+VEzB
         QpI4M/aiZCj4YPKCReL1JDLpb3MKqID4HwvD345UbDkeS6IFC7HLqrpCI5P39d21vdU7
         rYlc1TLmLvrMh+9aGPVWKEp+HUp2eaW6cDHQg8JbvsiiEszEidTVOe+0lteyhRPsDuH/
         9EvAYyX6aSQGxXLBH1SodXlpzuWKzDb+afkmKp2S9JJkcyGQiMRJ4M1t5ujHHqN1BkaT
         bWvsvgF077kixiuJX/FZJoi14xCYKqyAnmZlnPoPOdXfIdKTZIyExVM4aeD8ECHUYNON
         FM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5AOcbbpnqGz/ft22xwlfmGgcim1722Z0SVCOa2jf3dU=;
        b=YEUSH/mpLEwwYQrE80IxLDco6p9gTSGg77Kl4JQ4eUQhGJ4FKHEByT5fo3QdGWDYsz
         D2dHp3B06nh1WTB3gtX4G9ElBJYmaLyg400j+LNk+WJQ0yzY7qr/NOpOyv+0ofAUqIbj
         IPSqKolMqlmopSMVFpMPG95//GR5nhGA8vStVwG3VH+Rezhs8zQ2K2KjEsW2NUEkfxVJ
         IDPlIVwVQ7tpjaPpX1mhB/pl3yDNqvKG9gFJd2n3B2k5SO5PpQD03KFO8R7Ub+QMGCPp
         ogRTZ5GoTYkHLvpWa0mmbQYXImAJnD6mIkrAVO99MJ/NQltQ3VnP8TBhz17SGSwZAU6J
         yBMA==
X-Gm-Message-State: AOUpUlHsAJFtoWX7uhAEW+8b12ffLSxXuUuMcZpgfE1G78uETphQhBLu
        ihpDZInMYwO09sagDZGItodFZKaHo0lmsWYZjS8=
X-Google-Smtp-Source: AAOMgpdyXCUoMc/+2CNt+d+FOJqdxh8vkhx6AdZSmgtMnuIewVB3IgirFP35vO2RF7VXhB6blB9JHEhWCiIBAs15i8M=
X-Received: by 2002:a63:f002:: with SMTP id k2-v6mr17921973pgh.8.1533639803357;
 Tue, 07 Aug 2018 04:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <468d3c5b-d71d-c95b-dab4-ea8c2cebe129@molgen.mpg.de> <69a6086d25c17b03ecf3ab7ed34fe941fd993410.camel@kernel.crashing.org>
In-Reply-To: <69a6086d25c17b03ecf3ab7ed34fe941fd993410.camel@kernel.crashing.org>
From:   Catalin Marinas <catalin.marinas@arm.com>
Date:   Tue, 7 Aug 2018 12:03:11 +0100
Message-ID: <CAHkRjk7aYtMJXmQ_zuV7B12JiCkLfg3-8x+ayTD2DU9gDwi8Hw@mail.gmail.com>
Subject: Re: Several suspected memory leaks
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     pmenzel@molgen.mpg.de, Paul Mackerras <paulus@samba.org>,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(catching up with emails)

On Wed, 11 Jul 2018 at 00:40, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2018-07-10 at 17:17 +0200, Paul Menzel wrote:
> > On a the IBM S822LC (8335-GTA) with Ubuntu 18.04 I built Linux master
> > =E2=80=93 4.18-rc4+, commit 092150a2 (Merge branch 'for-linus'
> > of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid) =E2=80=93 w=
ith
> > kmemleak. Several issues are found.
>
> Some of these are completely uninteresting though and look like
> kmemleak bugs to me :-)
>
> >     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
> >     [<0000000007135d64>] hash__map_kernel_page+0x30c/0x4d0
> >     [<0000000071677858>] __ioremap_at+0x108/0x140
> >     [<000000000023e921>] __ioremap_caller+0x130/0x180
> >     [<000000009dbc3923>] icp_native_init_one_node+0x5cc/0x760
> >     [<0000000015f3168a>] icp_native_init+0x70/0x13c
> >     [<00000000655550ed>] xics_init+0x38/0x1ac
> >     [<0000000088dbf9d1>] pnv_init_IRQ+0x30/0x5c
>
> This is the interrupt controller mapping its registers, why on earth
> would that be considered a leak ? kmemleak needs to learn to ignore
> kernel page tables allocations.

Indeed, that's just a false positive for powerpc. Kmemleak ignores
page allocations and most architectures use __get_free_pages() for the
page table. In this particular case, the powerpc code uses
kmem_cache_alloc() and that's tracked by kmemleak. Since the pgd
stores the __pa(pud), kmemleak doesn't detect this pointer and reports
it as a leak. To work around this, you can pass SLAB_NOLEAKTRACE to
kmem_cache_create() in pgtable_cache_add()
(arch/powerpc/mm/init-common.c).

--=20
Catalin
