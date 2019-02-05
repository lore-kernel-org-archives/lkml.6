Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1DAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590A02146F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="adwspT3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfBEIPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:15:55 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:48051 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:15:55 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x158FmL7030033;
        Tue, 5 Feb 2019 17:15:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x158FmL7030033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549354549;
        bh=dxcwCv3jDokuy0pw5CdGPCzxTklgqbRZRnTexhayDNc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=adwspT3x0caRZS5GgzO72zQcMYcTRz4nqWdmqerFH+thiUpf2xfBZxUQduhuXKKVb
         9n/gOCvuOKqHuaxyPDARHp59awjfUA7ldtM2+oj8rxoz+5nmeAkUOp3rGYpRX5/LcB
         WmJEkpsJDH1ppv8NklNI9c7Fw7b1ln13ssmR6lPYaOyDygjs3DJK7h3TAA2B/cMnYA
         Cc5mv4bjrjLOJgCJbcHbUihu2GNWSf01fZ4Ea+g6F6P9NAc17kRx/FfldQ/aktNQBY
         ztKbGmJfCOmyAEvoT/qSWlytZYMauguAZlGifqbs4hFqdgJl7GxE44wUWC25tVcqsD
         oZX7zN4BVH/oA==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id n7so847258uao.7;
        Tue, 05 Feb 2019 00:15:49 -0800 (PST)
X-Gm-Message-State: AHQUAubrv6IJum4xu/G1u/Iz0BCm9NBzA5f4J1XBOrGt60Im1mUpbM0T
        yfWjR98edmvIhrgBZVA4lr+QWH+6TRgmck5b1Tg=
X-Google-Smtp-Source: AHgI3IaMqXGIs471eG54UZ/G4h0B96i1W+F2HmX7j8OTXEWMc/Ve+aPjWK/O0bBV8eqj2FCQwbFFL28R9VIFWZ6Bpsw=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr1385633uad.55.1549354548058;
 Tue, 05 Feb 2019 00:15:48 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAS8g3g3OTtqTN8begMxzbSS82Wn0CqY8u6vuELEZaLo3g@mail.gmail.com>
 <20190203084840.6113-1-vladimir.kondratiev@intel.com>
In-Reply-To: <20190203084840.6113-1-vladimir.kondratiev@intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Feb 2019 17:15:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0XOch3SuCJAh8Mq0s9Y9FGNJaESbYHD8yNywnzVkg2Q@mail.gmail.com>
Message-ID: <CAK7LNAS0XOch3SuCJAh8Mq0s9Y9FGNJaESbYHD8yNywnzVkg2Q@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: gitignore output directory
To:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 5:50 PM Vladimir Kondratiev
<vladimir.kondratiev@intel.com> wrote:
>
> From: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
>
> When compiling into output directory using O=, many files
> created under KBUILD_OUTPUT that git considers
> as new ones; git clients, ex. "git gui" lists it, and it clutters
> file list making it difficult to see what was really changed
>
> Generate .gitignore in output directory that ignores all
> its content
>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
> ---

Applied to linux-kbuild.

Thanks.


>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 141653226f3c..b1d651e822b1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -483,10 +483,13 @@ PHONY += outputmakefile
>  # outputmakefile generates a Makefile in the output directory, if using a
>  # separate output directory. This allows convenient use of make in the
>  # output directory.
> +# At the same time when output Makefile generated, generate .gitignore to
> +# ignore whole output directory
>  outputmakefile:
>  ifneq ($(KBUILD_SRC),)
>         $(Q)ln -fsn $(srctree) source
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
> +       $(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
>  endif
>
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> --
> 2.19.1
>
> ---------------------------------------------------------------------
> Intel Israel (74) Limited
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>


-- 
Best Regards
Masahiro Yamada
