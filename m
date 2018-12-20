Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74D920672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zWG/YzcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbeLTCAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:00:43 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22402 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbeLTCAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:00:43 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wBK20WFL009462;
        Thu, 20 Dec 2018 11:00:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBK20WFL009462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545271233;
        bh=yHSlXIor1Fh3gCFsMpZEw4y1VA61jENAqCxtVTMLXRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zWG/YzcR/vuOhXdRm3h8wR/f9h/KrWtLvtcxpKuDsdgo4av2YE4ylUTWvOm0/3/FG
         mR830Xdf5xQz0KphD01AK+QBIyUvO1rdJESnvbxmDYTxTUC4tgBt2MKsWj8YzMzerP
         Vl8U6+qUNUEl2UKPYYx/QKxZNwjXoxUvPhGTFDBscgEnp8LkmM6IJnhYSSLMfdg2h5
         giLFyJb6jm08b5oQSE9FHouGlulS0WFdgyKHQCWlh7uo/AWHQKMM0Tau4vornGY4l2
         pk0tEXNFPdcltQ6C63Xh9ULSPLZobEVGgRcyiHi7WUllumTSkb5TR5R2dHrujVZoK2
         Qm8ubtBgDN/eQ==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id c24so50882uak.1;
        Wed, 19 Dec 2018 18:00:32 -0800 (PST)
X-Gm-Message-State: AA+aEWbdurCk3cwipQrJe2so5uAaU9afXeU8WRckor3DW4hWiIuSNcie
        pr3bbUzk4ubWXkR5Gwv3wJIyQ78GmYv0bnZoOoA=
X-Google-Smtp-Source: AFSGD/UgkDxVB8vDD5fRJFlWC9maqsWBYc9ErRB8IQxR2m97UwM1jNEe6vHFLEs0Rd01P/M+dzymvcmawBtbMdJdPUY=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr11144432uad.55.1545271231818;
 Wed, 19 Dec 2018 18:00:31 -0800 (PST)
MIME-Version: 1.0
References: <1545110741-10761-1-git-send-email-yamada.masahiro@socionext.com> <1545143648.18411.20.camel@lca.pw>
In-Reply-To: <1545143648.18411.20.camel@lca.pw>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 20 Dec 2018 10:59:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxG_UmLQGCZqaNkKGQwKyzJdZst343o_kTqsMcGCcLCQ@mail.gmail.com>
Message-ID: <CAK7LNAQxG_UmLQGCZqaNkKGQwKyzJdZst343o_kTqsMcGCcLCQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix false positive warning/error about missing libelf
To:     Qian Cai <cai@lca.pw>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:35 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2018-12-18 at 14:25 +0900, Masahiro Yamada wrote:
> > For the same reason as commit 25896d073d8a ("x86/build: Fix compiler
> > support check for CONFIG_RETPOLINE"), you cannot put this $(error ...)
> > into the parse stage of the top Makefile.
> >
> > Perhaps I'd propose a more sophisticated solution later, but this is
> > the best I can do for now.
> >
> > Link: https://lkml.org/lkml/2017/12/25/211
> > Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> > Reported-by: Qian Cai <cai@lca.pw>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
>
> Tested-by: Qian Cai <cai@lca.pw>


Applied to linux-kbuild/fixes.



-- 
Best Regards
Masahiro Yamada
