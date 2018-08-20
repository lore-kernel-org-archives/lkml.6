Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C63021531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhR9nfrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C63021531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeHUArq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHUArq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:47:46 -0400
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com [209.85.220.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB8E21531;
        Mon, 20 Aug 2018 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534800630;
        bh=RasW+M0TfWs1w04LUhWTv3Yn8Ybvvf/1hbI9Zoc/uSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MhR9nfrxvxJyKQrS6GA7WQ5roVTmfTxQweK5KcVFW8NXVfSFnf2xlHzH8VRydVo2u
         4T/T8I6lcwYRuU8jcQf6vymzSz5hFsrVrPhEgtlMKvKV7u7Q3hNni5M7JASkOLt2kj
         oyRo9MTpaR1CW/Ekldss9KUnKwbm+yV4WnK56Rh4=
Received: by mail-qk0-f173.google.com with SMTP id z78-v6so9716675qka.0;
        Mon, 20 Aug 2018 14:30:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlGipd7NwIbwoSAu99pzVsf3R13UTvNTDMpjJh+YfFUjOJtikbiL
        AUduMxf2XIEG2ie8wlHq+1Pxuzs/DQCGyr/VZA==
X-Google-Smtp-Source: AA+uWPy7D66h71QrJGPI2T/GlAM9mHsltLzDG5lbM43wcffAVFWymSPMnlTQje5xt1ikRfQo8pHuYqw3LRGQJVVELR0=
X-Received: by 2002:ae9:c112:: with SMTP id z18-v6mr41901644qki.96.1534800629211;
 Mon, 20 Aug 2018 14:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNAT+szUMMyftudykuxVA7ROk6VM+QUobptnLciwAb8pLJw@mail.gmail.com>
In-Reply-To: <CAK7LNAT+szUMMyftudykuxVA7ROk6VM+QUobptnLciwAb8pLJw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 Aug 2018 16:30:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+TpNPB5H3dUYjjiHjk5sPbCw8tJcNgzeN9XdKVNSvZuA@mail.gmail.com>
Message-ID: <CAL_Jsq+TpNPB5H3dUYjjiHjk5sPbCw8tJcNgzeN9XdKVNSvZuA@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 1:56 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Rob,
>
>
> 2018-07-04 10:59 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > It is tedious to specify extra compiler options for every file.
> > HOST_EXTRACFLAGS is useful to add options to all files in a
> > directory.
> >
> > -I$(src)/libfdt is needed for all the files in this directory
> > to include libfdt_env.h etc. from scripts/dtc/libfdt/.
> >
> > On the other hand, -I$(src) is used to include check-in headers
> > from generated C files.  Thus, I added it only to dtc-lexer.lex.o
> > and dtc-parser.tab.o .
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> I hope this is a good clean-up.

Sorry, I missed this.

> May I apply this to my kbuild tree for v4.19 ?

Yes.

Reviewed-by: Rob Herring <robh@kernel.org>
