Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6186C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A062D20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRHsLvHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A062D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbeGXMZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:25:56 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34338 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbeGXMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:25:55 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so3668693qth.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fdTUKev+lB0JleJ0SGGq1V61piI4IgOrZv6JPrGU+B4=;
        b=kRHsLvHgw7Bskf8XNlxd4Og6+IargWU8Ih78QsQQq1520vIJNUfIiY7CJT9OM6Vpmg
         O164lt4RvHL8B/B3Ch4Dlf5Dt0pbQEiyNpN54NUbq3U1oCVAnt8AbMtkuXz9LG7Z5bLS
         y9qJGwJf+rS5oRQdTU1fjUrr77H4z43K7UppniGcluD6tY6ABANkBs2ooiYtF6gpZwD0
         92RqjW+nwcI6XzzfQC/Zm5pDQdovFDHpH6q1QKS2XmCtEEN4zjV2gPEJfyLwX0f0xeYu
         Bunh8woWIUm/RuLaaZo4fmuhP2lEJwOafocG4utsaQOrnR24niVsJy4GMJRB4AwWDRE/
         C0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fdTUKev+lB0JleJ0SGGq1V61piI4IgOrZv6JPrGU+B4=;
        b=M6Yo/8s6/dCpkSoeo7jhrbazNRPJFmP302i7NsB9YULSXN9c8wLzUimUb/rvNsTQCt
         HDJYMf59jouinAB+Wt4Ice1nI6TN+2rFFAhPLw21Ilhm24pxNukWJLYTWKuGgJVXnZld
         4xCGdRV79Y23VzLGXyp49hIwLzPYPCQoEIksNUDTdi4LN0EXllgN1YvpEXlTt0nkXkbm
         8zcqYFR16D/LYpfbr0VKi8DGlUd17IZGmnxA928J8R0tjvyeNpDCWBYSERsPxe0rQS+1
         WLKDQ27fIX0afAfUvumRyL9dxJO4GO8RzYF/8u5pFvIGBv+HiWCpapZQF+zak8ZOBOmA
         vkgQ==
X-Gm-Message-State: AOUpUlGaabxOCgfhoSBWe13XVB4w/GszlEEZzNPBfbJGsDRl+vGd7Egn
        hbkwSyU37Bwc4+7FnDeTJA7x3+BAFp/6R21zls0=
X-Google-Smtp-Source: AAOMgpeVBUr1lYHBYhS68mowVP+8HOiU9Q82t7P1S6exlzSB3gNBDOWer+PnPw+i7W/TqqcC87n5csn7RsJm5B61Zs4=
X-Received: by 2002:a0c:93b3:: with SMTP id f48-v6mr14566102qvf.151.1532431196686;
 Tue, 24 Jul 2018 04:19:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 04:19:56
 -0700 (PDT)
In-Reply-To: <e03d364551b205afeef5b1702efec9eedef388f6.camel@perches.com>
References: <20180718145254.4770-1-geert+renesas@glider.be>
 <CAK8P3a19tFrP7ymiMHcmQ9Jah4_zTwuoM3=KN+WQROiZ36ArPA@mail.gmail.com>
 <CAMuHMdWCjr__9QB-wSiuo7ZZnOc9PuCRLJU=cVTrfvywJh5eBg@mail.gmail.com> <e03d364551b205afeef5b1702efec9eedef388f6.camel@perches.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 13:19:56 +0200
X-Google-Sender-Auth: IYxK1lMkcn_PjrVsYPnE_D0it6U
Message-ID: <CAK8P3a3yLNg07-qD5ohYNb9t0nCR=YAF_ktjBeU=z_wXrK_Z3A@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: Only encode UTF-8 quoted printable mail headers
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 7:38 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2018-07-19 at 17:03 +0200, Geert Uytterhoeven wrote:

>> >
>> > The one exception seems to be arch/s390/kernel/ebcdic.c, which apparently
>> > uses 0x81 bytes as an excape before characters ISO-8859-1 characters with
>> > the high bit set. I don't know what that encoding is called, but I managed
>> > to manually convert it into something useful.
>>
>> Yes, we should convert everything to UTF-8.
>
> Thanks.
>
> Can you send a patch or a script for Linus to apply?

I sent a series of four patches now, one for each type of change I did.

      Arnd
