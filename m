Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84029C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEA924F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mAR5ZxE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEA924F0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbeGCCYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:24:38 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:56704 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGCCYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:24:37 -0400
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w632OMbL028235;
        Tue, 3 Jul 2018 11:24:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w632OMbL028235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530584662;
        bh=9sTQFrapvn6670PIe1SsFv5BKh259nPOfVXOCbDZAH8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mAR5ZxE2kT9QESx9K5Mi0wRzGNq0ZvEjfxI6RFCQ7lZSe8gceFVyZ19kzkMPpYHuh
         6JrgB3F4zIUYg8pCqGWpakONXLetwLYenEgaPhF+4+wr8K7mUCDWqgiKDR3DQccc/P
         OXew1shbIa2UBpDTdt54n+/pzNYhNTJ2vUJAm8hVSt6B9tiVHJwboU/Nco9DziOtDV
         PaIgz3LGgk62K7erNyrcXkFEN0KC7bnpscKb0UTNR3yktLrI5A5l7TfE4yzfZnC/sA
         zmSd9NSNZGDwzT0uO78gbb7dHUgWJryqJOsfEzeQ5vMm9XUxGdTqLYQaodY2Ypoq5L
         ah1YkENWJoZBg==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id b77-v6so219326vkb.5;
        Mon, 02 Jul 2018 19:24:22 -0700 (PDT)
X-Gm-Message-State: APt69E0Ysvoppb8q1BDUUVWRIOB399MzI1//Ame+tPz0kscPEILykiec
        xagow6bycHw1nHctczEzLmFFzrzTyi2hbG2cJW0=
X-Google-Smtp-Source: AAOMgpfKdvj6+/fZT/79rne3vl/4THjq+iK+60GteYMK/7quDpL0o/+2QlLAiQ/0RZTmSMhTjk4N585FDfecDmWUwcY=
X-Received: by 2002:a1f:c102:: with SMTP id r2-v6mr4286907vkf.34.1530584661598;
 Mon, 02 Jul 2018 19:24:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 19:23:41 -0700 (PDT)
In-Reply-To: <CAGXu5jKcWjm-56VRj=0kKU0Fb1ZrGgJ8WgesD0cN2x9WHTGwDw@mail.gmail.com>
References: <1530578352-18613-1-git-send-email-yamada.masahiro@socionext.com> <CAGXu5jKcWjm-56VRj=0kKU0Fb1ZrGgJ8WgesD0cN2x9WHTGwDw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 3 Jul 2018 11:23:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT13TrEbq5YR74YA1Snimn53MLjZFbHhbS2jLuvXn9a=g@mail.gmail.com>
Message-ID: <CAK7LNAT13TrEbq5YR74YA1Snimn53MLjZFbHhbS2jLuvXn9a=g@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: remove unused GCC_PLUGIN_SUBDIR
To:     Kees Cook <keescook@chromium.org>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

2018-07-03 11:18 GMT+09:00 Kees Cook <keescook@chromium.org>:
> On Mon, Jul 2, 2018 at 5:39 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> GCC_PLUGIN_SUBDIR has never been used.  If you really need this in
>> the future, please re-add it then.
>>
>> For now, the code is unused. Remove.
>>
>> 'export HOSTLIBS' is not necessary either.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> Is this going via your tree, or should I take it via the gcc-plugins tree?
>
> Thanks!
>
> -Kees

Could you pick it up to your tree?

Thanks.




-- 
Best Regards
Masahiro Yamada
