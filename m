Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5287ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A76B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="coXimtjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A76B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeKAEUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:20:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32906 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAEUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:20:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so15910385ljz.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHNsws9O0ZmFQDI+IpvIriqFgxG0Yi+asUfseioP9mU=;
        b=coXimtjZA6VWR6GVxkM2Egja1wyKPzX2LfMp0o2xycfy6/5jtOWcZ0V5IBcG0H2k66
         /ZXBVeydkL3w9RbjlVw+FCLebNiWIedqzAYDPeDHYDK9wRiXMF+WLBkOloqVo2I5kS3s
         n93ViTMVqion/f6OjJzgxrH2ia3mh0niP1L6PSZQWE0Ko4T0Y7AaU4BUaMJ9rv8JsODu
         OWH+zleA81SLPEuaTq4DqtPJ/3aj0vnjFRu/YbLHtg9Kin6TbZ5MdU7Ma/86qyUAj0/2
         hmxguW7WVFKvZ5X2ir69XiH9G2qLuuoik3zAcdmTCFlHtLMDbpCBiGl23gD5ngUQVXiV
         88qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHNsws9O0ZmFQDI+IpvIriqFgxG0Yi+asUfseioP9mU=;
        b=mfoscS2sKhsgjZ5cvIZa9o3DoaIgNvc7RyFe7E0xOsy7CbGH4FwhMiHgxTW1D+3VNl
         W+DVhlqok1X85zrsurPMjsX38HSF+I88AsFD3s2bVB1ep35MOce1KQMzCLOcmod3htsr
         AivxOKMyCLt2qu+pRcZs+licwPjZ3N6qqeG/XXTvMD2q4KYdtNgn9P6YnmGDNRnt18oM
         L0BM7fKV5TdPsr9BkTmNvCCaInlbIPz8RtzYKtRzymi10y5K2V7QAtzoE6JVqv9MkQgJ
         fOgaEbZ5PLkwYXsITNQ8L9gPuwQzXvLullPxjVDdCzru5bJC0oDHH6azVPsLONkx1ncj
         FhAQ==
X-Gm-Message-State: AGRZ1gK6ylEMbU3SyNQjR5PXU3A4C7dp+tMXBZvQiOkvJ8fjHB4q2eci
        o0+JyTM63Cx1JkynpGgz/Djs8vjHv5x5OJPOQj0EWw==
X-Google-Smtp-Source: AJdET5c3H/ofrFIXOHXrveIrCN9S8MQsbClDOSUeYV4+UmnaAt3zQ3iUGOHyiIHggmb5eYMwK1eyMPw5b+kK1jce77A=
X-Received: by 2002:a2e:f02:: with SMTP id 2-v6mr2897459ljp.134.1541013652187;
 Wed, 31 Oct 2018 12:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181030123720.3273-1-anup@brainfault.org>
In-Reply-To: <20181030123720.3273-1-anup@brainfault.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 31 Oct 2018 12:20:40 -0700
Message-ID: <CAOesGMjXZNURZ4SdKjssYCcFv3=4MYLBpBpzvvb1rNM-fo=QHQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: defconfig: Enable printk timestamps
To:     anup@brainfault.org
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 5:37 AM Anup Patel <anup@brainfault.org> wrote:
>
> The printk timestamps are very useful information to visually see
> where kernel is spending time during boot. It also helps us see
> the timing of hotplug events at runtime.
>
> This patch enables printk timestamps in RISC-V defconfig so that
> we have it enabled by default (similar to other architectures
> such as x86_64, arm64, etc).
>
> Signed-off-by: Anup Patel <anup@brainfault.org>

Acked-by: Olof Johansson <olof@lixom.net>

For next time: doing a re-format of the defconfig (to shuffle config
order), plus changes in the same patch, tends to be a bit fragile. For
cases like these, I'd recommend hand-pruning to just flip the one
option if needed, and then have Palmer or Andrew refresh the defconfig
during a merge window if needed (usually quite rare).


-Olof
