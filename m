Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F42146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ValM5WXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8F42146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeLBCIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:08:52 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:21183 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:08:52 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wB1EtwEh005895;
        Sat, 1 Dec 2018 23:55:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wB1EtwEh005895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543676159;
        bh=U+jS1Iy8bi9ULFv6STwhLiJtpsS0UIs8ankEVWeflYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ValM5WXokkmU3fJq7S2jPtsKO9o+QoKj71OOUYygRMHNgIjY06ff5dyzn6ce7Lb77
         RPFcxJEI8GuS2i26vGNxdmW07J9cBN2PZ7v7L2pp5Cywt6+QzIwrzHr/V+lVzqVPaY
         SPrSbtaRV/O+LFzrk6yG4Vrr10xuZa7hVbUcA6eitR4gqQ5++2XbkZ8e38Jid2Auhn
         jtNAOJDmqkBORgOQlhv2CADz+/G0s1MSSRfF8R1qX8+ba2Ln0DAO/5oh02kURgeKDD
         9jRR0h8cMqUXfPyd+vje6Cn+L7LE4wrpf5OvvRbJdy3LEck1gtAFLlv5dNjPgZiCEo
         0nFpiIbyz8RqA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id y27so5108458vsi.1;
        Sat, 01 Dec 2018 06:55:58 -0800 (PST)
X-Gm-Message-State: AA+aEWZqedEtPDorr5qArvlAcG0jDaOPk2pFj5oTv/gpiuxHe7JwTV+6
        DtZpWRAuhyf9x3L/3qvur8nMdcxhvx0E+9skkYo=
X-Google-Smtp-Source: AFSGD/UBFy2FXHS4BVDc4ycxT4Fj8jXXSshA84hXE8JLkFnVGZ+vmi5S7wPEmM/4PSd5njROZmi/woN33TSed7o9de8=
X-Received: by 2002:a67:a858:: with SMTP id r85mr4145682vse.215.1543676157989;
 Sat, 01 Dec 2018 06:55:57 -0800 (PST)
MIME-Version: 1.0
References: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com> <20181126083633.GA10604@light.dominikbrodowski.net>
In-Reply-To: <20181126083633.GA10604@light.dominikbrodowski.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 1 Dec 2018 23:55:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVcFj2-ooroLsyZgpVyv_xW1RJCkVtayg7sNxVjvHN=A@mail.gmail.com>
Message-ID: <CAK7LNASVcFj2-ooroLsyZgpVyv_xW1RJCkVtayg7sNxVjvHN=A@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: remove per-arch PCMCIA config entry
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jeff Dike <jdike@addtoit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 6:24 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> On Mon, Nov 26, 2018 at 05:15:41PM +0900, Masahiro Yamada wrote:
> > Now that all architectures include drivers/pcmcia/Kconfig where
> > the PCMCIA config is defined, the PCMCIA config entries in per-arch
> > Kconfig files are redundant.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > I will queue this up to my kbuild tree
> > along with Christoph's clean-up patch set.
>
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> Thanks,
>         Dominik

Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
