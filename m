Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D673C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFDA208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjlXrKC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFDA208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754974AbeFRPt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:49:29 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37515 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754561AbeFRPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:49:28 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so25440086lfb.4;
        Mon, 18 Jun 2018 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=urvLpIp5N5yjvo4jJN5d0f0WyVBk/20CoSSYTm+orjI=;
        b=WjlXrKC5gXG/CDtrDIZYPMfozWYM48I68VeClOGDegAFaWrd/UxKqR9xY8Vcb6uKvS
         u2QqQATzB+Znayj5QXfqZYHnvozPMe0k1SlskrsTnoDRXxdxtYd8fYj3kbOQvjdIZmxH
         7S17a2StUJV6a/1tyhzxJ5ybJFopibcR8RplBvGFRq0rTSkt63MIuHCCoFBmtqtXOyH7
         tEIy0WuggG6fybLXYoM6NxGCJYpSC5HdmGz5p2zX0DASIU+RImwUOhd2jmxHXb4NRc73
         cB0+T/XwESCLvMVPMrEyuA+b+dx+5so4gZVj9w62w77khMgc6f9XOo65G+orSiF9AIc7
         qnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=urvLpIp5N5yjvo4jJN5d0f0WyVBk/20CoSSYTm+orjI=;
        b=XwQz167uPfpg60HIUNhROiFy5zP2kRKsUWtbio6y3xrXaEZF65D86YuPWfv5Lk/Oeo
         fW8QB5Hg8Vxisq+Jp+8jDvyeUTF6pnybBPtOrrIrSWwf3em8TY/Hgjj1nn4IbSILAwKD
         VYkDWuFjoaCW/Csc8n6YQ802cgV6ibNXXsnvRWfi/QVTuiEBzFAfTB4uoi1yxO0atNec
         LxCBp46a5Ayco8ejBLpDnTLvUDUYXr+3fNQiCj25GBj9tatKvF53tX6WljXW0tiiuneW
         uPL8SnYnDb2fPKO80Oh+8J6oK1sA9TgW0O9QtM5qyoNv7/tTm9EZvzsWxcCKdOrwg3LT
         wg6g==
X-Gm-Message-State: APt69E0zR+wRy9QBfwtKEeYxa8H45kFhx9IWC7Vf+2+koap6JFA8oD5b
        PNtt/2NpRgm8Db0TjwkAuEvEvVKZbAPvqTgh+dQ=
X-Google-Smtp-Source: ADUXVKLtANmq81UYRwoZGgK3w4bVbt2ce5Lg7xpgVI9sqlvk1jNwavpHhYwqEptDPumOTR0uo1YTCRLFhJTfMvKpzcY=
X-Received: by 2002:a19:c004:: with SMTP id q4-v6mr7495758lff.16.1529336966731;
 Mon, 18 Jun 2018 08:49:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:49:25
 -0700 (PDT)
In-Reply-To: <CAKv+Gu-r_+b_tCXeZeE6=EN3=1N98rheODOwV_4mpb9GMzdqrQ@mail.gmail.com>
References: <20180618141811.3353245-1-arnd@arndb.de> <CAKv+Gu-r_+b_tCXeZeE6=EN3=1N98rheODOwV_4mpb9GMzdqrQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 17:49:25 +0200
X-Google-Sender-Auth: Vvze21eixWVgr1An8OwUnIMGalQ
Message-ID: <CAK8P3a0dP+zvucn=_um1zRgBYQCskrhqa2KNSDtnpSu199baWw@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: avoid using get_seconds()
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gengdongjiu <gengdongjiu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:47 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 18 June 2018 at 16:17, Arnd Bergmann <arnd@arndb.de> wrote:

>> -               atomic64_set(&seq, ((u64)get_seconds()) << 32);
>> +       if (!atomic64_read(&seq)) {
>> +               time64_t time = ktime_get_real_seconds();
>> +
>> +               /*
>> +                * This code is unlikely to still be needed in year 2106,
>> +                * but just in case, let's use a few more bits for timestamps
>> +                * after y2038 to be sure they keep increasing monotonically
>> +                * for the next few hundred years...
>> +                */
>> +               if (time < 0x80000000)
>> +                       atomic64_set(&seq, (ktime_get_real_seconds()) << 32);
>> +               else
>> +                       atomic64_set(&seq, 0x8000000000000000ull |
>> +                                          ktime_get_real_seconds() << 24);
>> +       }
>
> Given that these values are never decoded and interpreted as
> timestamps, can't we simply switch to the second flavour immediately?

I considered that, but the downside would be that all future filenames would
come before all past file names. I don't know if the order is important at
all, but the current implementation at least looks like it's intended to keep
all file names strictly sorted across boots.

         Arnd
