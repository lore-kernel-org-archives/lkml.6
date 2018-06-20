Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EAC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E310D20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pFe3VT5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E310D20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeFTXeh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:34:37 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:37836 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeFTXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:34:35 -0400
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com [209.85.217.178]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5KNYVnx016158
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:34:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5KNYVnx016158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529537672;
        bh=nPH5dK8HoG7OINvLKvZz+OBq0SDH5ngVJJZVXAH2ReI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pFe3VT5exxYyWZJ5PRez6iEtcnAIAuBza14RPIX86r5oj/l4iz8avohiHtRkmTQej
         nYt0vs9JinGo3T/7juRlSbN4izMVcyKSUW1uypaLT106txKZY3qC65WC5/eroNr6Fg
         1OC/BaJayZ3ghz5J+gHuQhG/bqoDE0RC1dyQWIhVmn1c9EOvSx1Szh2yRGYMCWogjI
         MdoKNuQX9TLng9vCeelreIFUVZ85zThEKGmak6cmLs+OcyJukYSFLKzmmuT3JhOuBX
         2N8ktdTuSQDxntScK7XSoVGpqO3blLZjyq9x8Fw3CUIypqhZheyfdnKgut/TLpNDwD
         wYEmlVG1ek+3Q==
X-Nifty-SrcIP: [209.85.217.178]
Received: by mail-ua0-f178.google.com with SMTP id c23-v6so853547uan.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:34:32 -0700 (PDT)
X-Gm-Message-State: APt69E3mkheiWqMZvF+ZYV0xeIWoGqwgD/uiE7zRkBQqlXMQbOqpyLGa
        WWvTorlfeW/WqBZCv4t4YvrxQeWBWwIwAopI2/c=
X-Google-Smtp-Source: ADUXVKLO8XEZffQsGs5D3rLTEn75bLl3W3qtF/qn/rnM4TY42m2Ptkunj6rlT9gqr7uVUF2QalNSF/CjHw6SRAI4W68=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr14663156uae.140.1529537670921;
 Wed, 20 Jun 2018 16:34:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 16:33:50
 -0700 (PDT)
In-Reply-To: <20180620002229.xsh4bupxa72nhjoh@pburton-laptop>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
 <1523890067-13641-5-git-send-email-yamada.masahiro@socionext.com> <20180620002229.xsh4bupxa72nhjoh@pburton-laptop>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Jun 2018 08:33:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_z_o0M2OuHyT0XGkUqCncdVxyL9oH5yXZoM3yDyuM-g@mail.gmail.com>
Message-ID: <CAK7LNAS_z_o0M2OuHyT0XGkUqCncdVxyL9oH5yXZoM3yDyuM-g@mail.gmail.com>
Subject: Re: [PATCH 4/7] MIPS: boot: correct prerequisite image of vmlinux.*.its
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

2018-06-20 9:22 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> Hi Masahiro,
>
> Thanks for these - I've applied patches 1-3, 5 & 6 to mips-next for
> 4.19.
>
> On Mon, Apr 16, 2018 at 07:47:44AM -0700, Masahiro Yamada wrote:
>> vmlinux.*.its does not directly depend on $(VMLINUX) but
>> vmlinux.bin.*
>
> This isn't really true - to generate the .its we actually do depend on
> the ELF, which we read the entry address from (entry-y in
> arch/mips/Makefile, provided to arch/mips/boot/Makefile as
> VMLINUX_ENTRY_ADDRESS). In practice $(VMLINUX) is built before this
> makefile is ever invoked anyway, but the dependency is there.
>
> We don't need the vmlinux.bin.* file until we generate the .itb, so it
> should be fine for the .its & .bin steps to be executed in parallel
> which this patch would prevent.


You are right.

Thanks for catching this.




-- 
Best Regards
Masahiro Yamada
