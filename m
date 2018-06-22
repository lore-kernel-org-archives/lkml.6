Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B81C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C92123F3A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzPsO/lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C92123F3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeFVIyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:54:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32883 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFVIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:54:41 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so8018726lfy.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=whkiTy35XYo8CtN6OJMFj+r2+FYW++9LhorEotSDIQk=;
        b=UzPsO/lbvluelctY7g2wNoHCHYZcZQ0TXII76f3yVHNWXJNkiGd8K++t/rNvdd0Prl
         1jg94nDatUltwLE5ikTimiPpcMKT8kLfe/ST7XRVQmnSne3XZOQdi4faziICfsuHAiMA
         sN/pNZtMHkRcA4Hcw8KuI34AC/IBCVd/zTgw/rKCRTnxtrt3wJ3fhl0cgfjKGzUZhWeI
         NH/9/PHLOnEPFJpUReYh/lrWCBNM4yIyr+0KE6QlXZRKOp6f90BKpmzHMBiRlVjh05tD
         jQf7XbiIn5L+jbkTVDJZe93nu8sHoh0Gk1j+NvEwXkO7OO2aR1x4WuCIs3LEYeRqCuB+
         UImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=whkiTy35XYo8CtN6OJMFj+r2+FYW++9LhorEotSDIQk=;
        b=Jy30A6V0ov8zHoGELho2rSXPOju/WyQ5kEhS6FUNZt5aRzYUCIyQo+adJNAMZGriZl
         bBDhQR3vs41rR1secX3S+Sb+v3ROOFRTXgVZRY3N+KEQEhxtmMkfD6eFelPpcQww03VU
         YyBtk9I5xFQnWlcUumeyI+7RXTomNuunToaWVtqyD9wTkmLHeSyAqWMN5rn85MmMK9ta
         3LlKBpSEK3VYOAe4HW/+ZY2rsmTPA1DFZYtqtXN7XqIaGxLEK4tDLTFoA7RZ3vLz3YSB
         D3TOljeH3rV0U6ueIt5YzCEdL1/pUM8N4SlMb1tQmgY5iSul4eXaK78/IzXiIec+vrr+
         btPA==
X-Gm-Message-State: APt69E0Pl0v4CIFjLm9UCaBwe5NQ+KkBWF5FG2nmBeWgpPXiJh8c6pG/
        iShKyPOyhGNjZWzNEKypu6MSRxqKeB6hv7SCNRg=
X-Google-Smtp-Source: ADUXVKJnTmJnh7eIIzwJAZF+3uhK5mTIWy29k5nHQrpEN0wK5RvkWit9UJQV+4MFFOpyYA7iE2oT449BbeSju4SpuXU=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr691524lfc.55.1529657680480;
 Fri, 22 Jun 2018 01:54:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 01:54:39
 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.21.1806221455570.14@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de> <20180619140229.3615110-2-arnd@arndb.de>
 <alpine.LNX.2.21.1806221455570.14@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jun 2018 10:54:39 +0200
X-Google-Sender-Auth: NDqHyjZ3tKNmCdVyj6WG23vVQ6M
Message-ID: <CAK8P3a2chXVhz+UJ+ujg8QMqyMmJ4zGj9XKuFZ+MsJ=dGqb3eg@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 7:26 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 19 Jun 2018, Arnd Bergmann wrote:
>
>> The real-time clock on m68k (and powerpc) mac systems uses an unsigned
>> 32-bit value starting in 1904, which overflows in 2040, about two years
>> later than everyone else, but this gets wrapped around in the Linux code
>> in 2038 already because of the deprecated usage of time_t and/or long in
>> the conversion.
>>
>> Getting rid of the deprecated interfaces makes it work until 2040 as
>> documented, and it could be easily extended by reinterpreting the
>> resulting time64_t as a positive number. For the moment, I'm adding a
>> WARN_ON() that triggers if we encounter a time before 1970 or after 2040
>> (the two are indistinguishable).
>>
>
> I really don't like the WARN_ON(), but I'd prefer to address that in a
> separate patch rather than impede the progress of this patch (or of this
> series, since 3/3 seems to be unrelated).
>
> BTW, have you considered using the same wrap-around test (i.e. YY < 70)
> that we use for the year register in the other RTC chips?

That wrap-around test would have the same effect as the my original
version (aside from the two bugs I now fixed), doing rougly

-        return time - RTC_OFFSET;
+        return (u32)(time - RTC_OFFSET);

or some other variation of that will give us an RTC that supports all dates
between 1970 and 2106. I don't think anyone so far had a strong
preference here, so I went with what Mathieu suggested and kept the
original Mac behavior, but added the WARN_ON().

>> This brings it in line with the corresponding code that we have on
>> powerpc macintosh.
>>
>
> Your recent patches to the Mac RTC routines (which are duplicated under
> arch/m68k and arch/powerpc) conflict with my recent patch that
> deduplicates the same code. So I will rebase and resubmit after someone
> merges these fixes.
>
> Apparently the PowerMac routines work now, which is sufficient testing for
> me; the PowerMac routines will get tested on m68k Macs when that code gets
> deduplicated again.

Sorry about introducing that conflict, and thanks for bearing with me on the
rebase. One thing to watch out for (if you haven't noticed already) is that the
powerpc version now depends on rtc_time64_to_tm/rtc_tm_to_time64 which
are only available if CONFIG_RTC_LIB is enabled but simplifies the code a
bit. I did not want to introduce that as a global dependency on m68k which
is rather limited on code size already, but it probably doesn't hurt to require
RTC_LIB on m68k-mac.

        Arnd
