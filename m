Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281289-2-8811928464942889798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281289; b=a3jC6oJVb5+qEs9K+m2SR3pMhMQEiKkvez0uRLZ7UbWo7aceq4
    yGSR+82G1YKBSoc7pSYVdmZ5r8nLxs4ZeG06W5RQNu6hTCUgfbPte5QnsPkVaLsc
    Wi9LLy88b2k8U5hv+euUpHpnHhmde/Ud768mw/lcQ5zNbK7M+OiLO65W7S/6EWGE
    Odojf1sF2KhHMiNBi3BugS+zDehpuso0jZ2SwOec4uuVsMIobgWjPXKLWGI5sbM/
    hFbuHby3dRBGlOVz1kAwG7iOKZrfXABNfn73yFGk2SckQ1faZ+cH8Aa2m915xKV6
    UxsVdbdghgk0wRgIL1lLFHjYZXdZgh8mezCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526281289; bh=z7thFS661kwvSVozFzOYrh1uxvC6tmiQJcQ020gAw6
    E=; b=H9qq1o+E5vrEaYXZ3QEE1sYpTJm21/5PCtC5WTvdgK3gGuvYH1JTIlRYaG
    942M19LJTSX09sJax/2pKhHP3oRg54AVjWY7yM/Wt1OwGr/CLISS771bDDu0uNUD
    KbjOuj2x5xH2j6DY7AvfUKV69xbOyoAsslYoozW7blwZ9IuCJ4nHIt6bFwDEZ60G
    j3hl+9FKnlMVkOK7pOfWNuUPEeuBm6QJ+33NJ/murxjmFj8NmELS41GeeXK0pMnD
    QkZoEpR4hInDg4EiG2JXTPbd+hHYApjK6xNYt+8g6E0QL6Qy8KFg0OHDBEzgMNJR
    agO/gCs7ZtBeQftxg/BS80A8pDWA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=BiLk35Lv x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=OipDexmy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=BiLk35Lv x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=OipDexmy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNEmlAU+yYNwnqV7YsS9wXNcu3nYPByZhLFmE29LVEOKCSws9XHOe2v8RUzHbTnOQeFH+FX0Nbpma7onItnRyEa3NDRsKhviGsh8Ns8mMZ/YfFveNqZP
    1FXcpHHZ9Q9UhrsdtenYitkW12dNDJqGaMtot8+XuKH0jaQYFH5QPm5/97NofwHbqU1DwePtx7wTaMz7+aRAzVrcPnSRXS0pvTuICcjN0LLBS+VMZFJiqFuV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=QyCegJKs-wUNG7sZ9JIA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754293AbeENHB0 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 03:01:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42952 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754285AbeENHBZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 May 2018 03:01:25 -0400
X-Google-Smtp-Source: AB8JxZrgm1Kik1VsAneKdL9L545cSVMPpF8dmdHu0gVomznrPY3v73iMQuK4/OGBUlqRkgTAxHBXw+X+A6LD15jOfjo=
MIME-Version: 1.0
In-Reply-To: <20180514070010.GF16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-18-ard.biesheuvel@linaro.org> <20180514064701.GC16596@gmail.com>
 <CAKv+Gu9nud17L+FhMwbTb9AaVd0+qRgqXU1_c4K+GCH-=uhpxQ@mail.gmail.com> <20180514070010.GF16596@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 14 May 2018 09:01:24 +0200
Message-ID: <CAKv+Gu_RLb1fTNff0+HkQ9h5j-TFAJk=2nva72PSZExXdM1VJw@mail.gmail.com>
Subject: Re: [PATCH 17/17] efi/libstub/arm64: handle randomized TEXT_OFFSET
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 May 2018 at 09:00, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 14 May 2018 at 08:47, Ingo Molnar <mingo@kernel.org> wrote:
>> >
>> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >
>> >> From: Mark Rutland <mark.rutland@arm.com>
>> >>
>> >> When CONFIG_RANDOMIZE_TEXT_OFFSET is selected, TEXT_OFFSET is an
>> >> arbitrary multiple of PAGE_SIZE in the interval [0, 2MB).
>> >>
>> >> The EFI stub does not account for the potential misalignment of
>> >> TEXT_OFFSET relative to EFI_KIMG_ALIGN, and produces a randomized
>> >> physical offset which is always a round multiple of EFI_KIMG_ALIGN.
>> >> This may result in statically allocated objects whose alignment exceeds
>> >> PAGE_SIZE to appear misaligned in memory. This has been observed to
>> >> result in spurious stack overflow reports and failure to make use of
>> >> the IRQ stacks, and theoretically could result in a number of other
>> >> issues.
>> >>
>> >> We can OR in the low bits of TEXT_OFFSET to ensure that we have the
>> >> necessary offset (and hence preserve the misalignment of TEXT_OFFSET
>> >> relative to EFI_KIMG_ALIGN), so let's do that.
>> >>
>> >> Fixes: 6f26b3671184c36d ("arm64: kaslr: increase randomization granularity")
>> >> Cc: <stable@vger.kernel.org> # v4.7+
>> >> Reported-by: Kim Phillips <kim.phillips@arm.com>
>> >> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> >> Tested-by: Kim Phillips <kim.phillips@arm.com>
>> >> [ardb: clarify commit log]
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> ---
>> >>  drivers/firmware/efi/libstub/arm64-stub.c | 7 +++++++
>> >>  1 file changed, 7 insertions(+)
>> >>
>> >> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
>> >> index b9bd827caa22..541b82fdc8a2 100644
>> >> --- a/drivers/firmware/efi/libstub/arm64-stub.c
>> >> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
>> >> @@ -97,6 +97,13 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>> >>               u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
>> >>                            (phys_seed >> 32) & mask : TEXT_OFFSET;
>> >>
>> >> +             /*
>> >> +              * With CONFIG_RANDOMIZE_TEXT_OFFSET, TEXT_OFFSET may not be a
>> >> +              * multiple of EFI_KIMG_ALIGN, and we must ensure that we apply
>> >> +              * the offset below EFI_KIMG_ALIGN.
>> >> +              */
>> >
>> > When referring to config variables in comments and changelogs I'd suggest a bit
>> > more verbosity:
>> >
>> >   s/CONFIG_RANDOMIZE_TEXT_OFFSET
>> >    /CONFIG_RANDOMIZE_TEXT_OFFSET=y
>> >
>> > ... because at first I thought (based on the name) that
>> > CONFIG_RANDOMIZE_TEXT_OFFSET is an actual integer offset value - while it's a
>> > bool. The =y makes the bool nature obvious.
>> >
>> > ( Similarly, when negated the canonical way to refer to it is
>> >   !CONFIG_RANDOMIZE_TEXT_OFFSET. )
>> >
>>
>> Fair enough.
>>
>> >> +             offset |= (TEXT_OFFSET % EFI_KIMG_ALIGN);
>> >
>> > The parentheses are not needed here I think.
>> >
>>
>> Nope.
>>
>> Will you fix this up when applying? Or should I resend?
>
> Since this was at the tail with no dependencies I'll skip this for now I think -
> mind sending the refreshed version in the next batch?
>

Actually, by the reasoning in your other reply, I'll fix this up and
resend it for -urgent instead.

Thanks,
Ard.
