Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1D026B44
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MSgrwVqG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftIEH5sG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1D026B44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754672AbeFZWCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:02:51 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38151 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeFZWCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:02:49 -0400
Received: by mail-yb0-f193.google.com with SMTP id f12-v6so3630656ybp.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LqKOc2QnZo0tuXjwotNZ89Iq2LhapWAu0JxbbBTVBwU=;
        b=MSgrwVqGqUwVnQzOKkb0P8JDNdj3qWBeFoyVHlaaCWGpPTvI2hrxilMFVbHUW841n6
         Vxc8kDkpoNsU1a3Ouq3wbdFQm8Q0COI+DeCpvCCcyd58m2rwdNfr4aFwc5ZPxSvlycPw
         99DIOyyFDfawrPVaF7LTCCT3HBCXeqcp7bjVWxR9rZqxcROGy1jz2rAzXuTKqP+z+bDR
         fHqav51G3IJgR5O/wS/wJqYyV/4FpJy0Sjriu/VcznN0ANU9bcP08KV9c5AUGO7b5ejA
         fT/SsXhRFdvn+C9KNMybiv/opocVDCDNs2hK4hfpG/j3nwfC4plQ0WlvqgFYsGLTFB8l
         3Wkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LqKOc2QnZo0tuXjwotNZ89Iq2LhapWAu0JxbbBTVBwU=;
        b=ftIEH5sGzQXGYYc52q6gldHw8aQ4451R/M3cWEnQIeD5FoYhwSyatiLUmksY6eDXtj
         yeBQsyF0HkXKOHT17HaSrg5Riqkk44nOJ4WO+YfGs5P9nGkTw9NhOIdLENDETrtqdSVT
         Fiaw00YWOjhYuOU+dGf693TNTarNrg2LxaCAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LqKOc2QnZo0tuXjwotNZ89Iq2LhapWAu0JxbbBTVBwU=;
        b=WlZgrTm9HM2rKEQEGfChQbdzFowARRaCJFxYK7S9WB7ZhMNYFgRaRTQfG1nW1Q85Hp
         V3fhgWQsuP3qO0ve4tZI4szTXBWWElF3nfFwaOosvC0NX4P+AhGHiLo5ad2n7GMbT5if
         RAEBAkU1GAqUsGeplFFQ+Jc4WzKoX1sKyGy399CWOTQtZqpjHB36MGGWdqEAOlmvm18v
         9lzLE9Hd1VWn6RiGdID9gn2vcgfqbN/AZNtxocPL0nZRqC0GSrQM0W4b+SDXkduEAdSs
         yhuPbbf7htzwshXaHZb3c7KqtG2I44InLMyj9KrWdQOkVlC91KX6QVwiUMPmnGAHdlhs
         qxrw==
X-Gm-Message-State: APt69E1yIqUT0aMUBMlbVGBIXwoujVxa4WRpRrYV5Xm3zNLpk6ch1KTb
        qNWp/1jkmDxAzK79aI8n49xw19xAELT77x+/OwleB+GV
X-Google-Smtp-Source: ADUXVKJcCW22YIsqzZhDM3cH1PAHR/o1nMNq7FCGUXCGwZfFvLTsST1FYGz0PLFrm2hE4ERd+1AKpThb4l/ppYf9vxE=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr1823498ybi.193.1530050568518;
 Tue, 26 Jun 2018 15:02:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 15:02:47
 -0700 (PDT)
In-Reply-To: <46d20fac2dc15d842ebf23c62372ecdb892d7efd.camel@perches.com>
References: <20180626174013.GA41617@beast> <46d20fac2dc15d842ebf23c62372ecdb892d7efd.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Jun 2018 15:02:47 -0700
X-Google-Sender-Auth: x_3IoJcmgpGUYxOo_cfhK9Y79ks
Message-ID: <CAGXu5j+8uqu7vQeupbPF26UTnAvTrwYObqrVAueM9ztFKaH-qw@mail.gmail.com>
Subject: Re: [RFC][PATCH] Makefile: globally enable VLA warning
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 1:21 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-06-26 at 10:40 -0700, Kees Cook wrote:
>> This is the patch I've got prepared now that fixes for all VLAs have been
>> sent to maintainers (some are still under review/adjustment, but there
>> aren't any unexplored cases left). My intention would be to have this land
>> at the end of the next merge window after all the pending VLA patches
>> have landed. I just wanted to get any feedback here, since it touches
>> a couple areas in the process and I didn't want anyone to be surprised. :)
> []
>> diff --git a/Makefile b/Makefile
> []
>> @@ -778,6 +778,9 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>>  # warn about C99 declaration after statement
>>  KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
>>
>> +# VLAs should not be used anywhere in the kernel
>> +KBUILD_CFLAGS += $(call cc-option,-Wvla)
>
> I'd probably spell out what a VLA is here.
> # VLAs (Variable Length Arrays) should not be used anywhere in the kernel
>
> Beyond that, seems sensible, thanks.

Ah yes, good idea. I've made that change locally now. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
