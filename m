Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F408C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17E7206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eI4ufnKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17E7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeIRRRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:17:14 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38921 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeIRRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:17:14 -0400
Received: by mail-yb1-f196.google.com with SMTP id c4-v6so653876ybl.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+9qbjdL5iZmKDA+HUw9Uk/8fCXg13r2BFRtgHLCTRgM=;
        b=eI4ufnKU6VjeotjDYIiBZ03nVeQ5WmsBINDtHu/Cz204Z2fGs8YizmSTBP8q4K1UFU
         i0HrwncjTVWeXUvyoCXw9kE9W5dvvt45ZQqhQqlUfw96Esdp0WYImGfwzER7Ny3MuMaX
         Y9/ImX8zGgjHAwJsOKV8fVbj/F8FevAeG1COo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+9qbjdL5iZmKDA+HUw9Uk/8fCXg13r2BFRtgHLCTRgM=;
        b=h84mwrTmG91AiVIIN8xuN+zpjao8jvH63ZD0o1XRqfSmIKW4r5600Y1z/N1R5lUGsK
         Xx1TKmS2axJsv7OFKobZTtjM/HdYD17giU5hq2HFZZLjX28Y500v5tmO9rVSaI4d1eol
         0NM1/dAtcr0XX30ADzG+NA1OCkH6EsvvBN9PM5bfG3DmalxRP0gjSEvrtZkMt1kV3JxJ
         zPmJpi6qwHdUt+mGKeAomTceK5pHtGLbZ+mu0OVexo0lUKv4/YXc5UwheliNl3OpUe9b
         2wRiUPUCjWv8K+iWaF4MGpN2qj9QmplJi7h8vh/ZwC0cdJpgHCSuxw0+lCy905LPmjCa
         8pLw==
X-Gm-Message-State: APzg51AJD1/smUZheOPcY4zv160OBLgwum6Wo3VxR/UBgUngXFG6gi1C
        Tu5eES9Mq71mligVwGpxyLS0PgkquxA+15EMKL0lwIub
X-Google-Smtp-Source: ANB0VdY3ryLamtQ2Ld/E+k9G0c4t/qkKjOohURVFackjy1zUA1QHUYfrXGHnaKwq1KlFBgQCSVFfGcdDsfwaZxl3sXo=
X-Received: by 2002:a25:be41:: with SMTP id d1-v6mr12199446ybm.483.1537271101100;
 Tue, 18 Sep 2018 04:45:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 04:45:00
 -0700 (PDT)
In-Reply-To: <CAK8P3a2qFoCOzM6x-_mv0Um2E-WHDeOU-fuuZ65TtDKKcPxNrQ@mail.gmail.com>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-5-git-send-email-firoz.khan@linaro.org> <CAK8P3a2qFoCOzM6x-_mv0Um2E-WHDeOU-fuuZ65TtDKKcPxNrQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 17:15:00 +0530
Message-ID: <CALxhOngr6KY+CijcMx8f6Kg=SK3wJK_wxV6Z-HPWYpQ6h5iJog@mail.gmail.com>
Subject: Re: [PATCH 4/4] sparc: uapi header and system call table file generation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 21:04, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> System call table generation script must be run to generate
>> unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
>> will have changes which will invokes the script.
>>
>> This patch will generate unistd_32/64.h and syscall_table_
>> 32/64/c32.h files by the syscall table generation script
>> invoked by arch/sparc/Makefile and the generated files against
>> the removed files will be identical.
>>
>> The generated uapi header file will be included in uapi/asm/
>> unistd_32/64.h and generated system call table support file will
>> be included by arch/sparc/kernel/syscall_table_32/64.S file.
>
> These changes all look good to me.
>
>        Arnd

Thanks for your reply!

- Firoz
