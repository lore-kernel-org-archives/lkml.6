Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819FEECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A247208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A247208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeIZN4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:56:03 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46151 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZN4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:56:03 -0400
Received: by mail-ua1-f65.google.com with SMTP id u11-v6so10481173uan.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw2hYzzEIqBrVeq7KyxkB9jqqPwxYAMVWW+3BIjW5u8=;
        b=BLwoi0hXn17NlV7kheiYDz23ZhH1VIo62TZxQzjVssyhKK440qsk3OnNCpjMqU1xps
         jTM9GwzLMeWUsuRfkAaEki7J6f4vZtXgRGsS8MFfvcbfo203CZ+BCFnhzZJPm+JPWHLZ
         u7s+hlMAeUwv6Z4QFCUht4aE+sxaOMs1CVoUjx0ru6t3B2zo/pSLcMOPmFtfWtFQMjYb
         NgaZvPZxmqIyBFlxmx/cmlc10XxWdnQBWPhGFjbuPQ1MSxTo3PBRXKIpeO6unEgot1z5
         InEF5RsLQlo9qlZIqHGW8AELfidNxNURuAsGFAroZ3IXhGJtngxAVmPClaizHr6kRRJy
         l+Og==
X-Gm-Message-State: ABuFfogPrlD2zc6Koq5NPI2qHwvdvaVJ79RZIvrpdJYcdwxb+rs60Vgz
        cvZLdVreiPLek51OQgzieVkeIu5i5JKNmtd9/cDj6A==
X-Google-Smtp-Source: ACcGV60E6MzcHJAPhu/CRcr2TlGw6QmYGsy20JOoksqOG6RDhN6JIRzakDRdh2vd87NCD+l1GDeoFYYgCEyfi6A2oBE=
X-Received: by 2002:a9f:2986:: with SMTP id s6-v6mr1504339uas.28.1537947865837;
 Wed, 26 Sep 2018 00:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
 <878t66idai.fsf@igel.home> <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org>
 <87sh48r0zf.fsf@igel.home>
In-Reply-To: <87sh48r0zf.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Sep 2018 09:44:13 +0200
Message-ID: <CAMuHMdW-ZA3bUJP3Fztm5sm7TSO345Jah471oMUr89x89d51xQ@mail.gmail.com>
Subject: Re: m68k allmodconfig build errors
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, Jul 24, 2018 at 7:35 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Jul 23 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
> > I don't see that all of these string compare fields are null-terminated.
>
> That gcc has converted the strncmp calls to strcmp is a pretty strong
> evidence that they are.

Isn't gcc-8 just assuming that any char array must contain a valid
NUL-terminated string, unless it is tagged with the nonstring attribute?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
