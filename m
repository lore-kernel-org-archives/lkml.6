Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC0EC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6561C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="krsA+AmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6561C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757262AbeFSUeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:34:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39174 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757086AbeFSUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:34:40 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so2343571itp.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NHOeJvP0heZOovorb6mRCU0rGGtlBqU5Y3tEG6E5eAQ=;
        b=krsA+AmFYm9cD3z0YebidMv/l6PqMZtgPVkJf+kJsQHBetDaahsPlLxB8y9D0OQ4IV
         6rdiPrlDoklv/AgvfgXkkLwCSsC6/zryffpxrV6vGISWC86OnRwBEUwdJeR+igHeaIti
         2WsWewsgnAyEEr56nBwZA5hHC2MNhTTCPe1b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NHOeJvP0heZOovorb6mRCU0rGGtlBqU5Y3tEG6E5eAQ=;
        b=cJ9VEHnhcQ4G7DudN5G0aNVbmnUQ4PIb77bILgIe7qP9jgeQ8D5yl0GyYv71Ildtso
         BMcznorDRGgUVDEJ/askSywZ8EXZ0SycqliZaPOel9UUlg3yOHtxqKWsIyNuaXg31wm9
         097SNWe3Q/vRQp+E4XtzsHJ2SQVDhDPDA8CNBJBdWTLitLnDI1hjsso+zUqXJfAeI7D+
         D25ZrqNPJ4ROUgr0U3d2DFPQNx1IMs2PzeZXZT8uID832OPsSIms1rH2tQfCmbvaCF8a
         Q8YVDjYDfrvEE4yfQstiV6eH0xtZSjeVIMTCUDPc24kLejOASearLrJ8dK4hPjCve+ba
         zz2w==
X-Gm-Message-State: APt69E0ru7NxeFQ6K8pj9xPT1LgSM1/TapgLGp5om/BKEl/TslQnrYVq
        3ILQ++cmCOMTwPbdtJMCSOFSlZqUhB4Us7HZ+OnN9A==
X-Google-Smtp-Source: ADUXVKI/xR5s9TGR+DMIf/tdDoQ3W8YzUg/rcqtctCFk0pQuJSLZVidyNo9AJCnHiAI2qqHHhk9OVt8jQJAQfM4VYHk=
X-Received: by 2002:a02:4187:: with SMTP id n7-v6mr15036897jad.86.1529440479524;
 Tue, 19 Jun 2018 13:34:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 13:34:38
 -0700 (PDT)
In-Reply-To: <20180619203223.GA28370@roeck-us.net>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org> <20180619203223.GA28370@roeck-us.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Jun 2018 22:34:38 +0200
Message-ID: <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make badr macro compatible with newer GAS versions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 22:32, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jun 19, 2018 at 09:26:31PM +0200, Ard Biesheuvel wrote:
>> Work around the mindless and backward incompatible change in GAS that
>> prevents us from using a simple addition to set the Thumb bit in local
>> symbol references taken using 'adr' instructions (#2)
>>
>> As a preparatory step, remove badr occurrences in ARM code sequences
>> contained in Thumb2 kernels.
>>
>> Ard Biesheuvel (2):
>>   ARM: avoid badr macro for switching to Thumb-2 mode
>>   ARM: assembler: prevent ADR from setting the Thumb bit twice
>>
>
> This doesn't work for images built with a toolchain based on gcc 7.3.0
> and binutils 2.28.1. It _does_ work for images built with gcc 7.3.0/
> binutils 2.30.
>

Sigh.

So does it fail? Or is the resulting binary broken?
