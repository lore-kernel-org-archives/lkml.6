Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-208113-1526280427-2-4738574975352054617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280426; b=kx6RLKk3T3YlDT7ACN1cDGk2yJU2tpUagB1p6dwpTwO7oPpAHq
    C3yL0pOMtr8YDNes2HDCy+8YiOQbh5Rg6nGxP5oewpxaVTJdxgmjshDIWlq/L2r+
    h300ggJIwCys/hSCqsrbFKupVk17iunuNPGioHu/CA+snrEDlk5taNprDqB7GP6a
    u1o1SYd4WlTFaw1AEVBauz941CIeca40CkkrzKXuFUw3IzY/+gEp8113xTOzN8MR
    H6XLEw00KjVZ86NpIHhP4bzN5oj1qrpPXDgIKUgp9kBg4sU5Wv753mS8OqTmjZsk
    MwmoGswIYFKilFJLJGVF4CoNjyuOw1mS+ujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526280426; bh=Y4b0T5rwtHJPKM7IOGhiwzMoYCEXnN
    iJE6facYhW5F4=; b=kZmaiEcMfBmst3pNFQmkScNH4eAyllN77fNyQcGfULrL/C
    PX4416CMuedEAmfp0eE7WLxnCcNDEGcvgJufxfWxZh9N7LoIDPfutfTJVmurDHhf
    qbro1Yf9eDnndI7pqn5adwqOUgc3ENkKa5awRY2SB2Dx6SJq30/al94Uxr4492t2
    mFt/dSS6TkL36LnWLinSjywhPx/ABYCa9SodvbpE/WOzLLLlNI4BRYFWcoiticbA
    Hdh0mDu8SwM846zQxzQIBnQV4Ublysct06Nr7kPVlK64nWe49QeHR3VOEc4E52PD
    tVMfyUldNQuvXvTbcN6nDllE4VAmxwyrSNCky+Kw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=HACd3n3G x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=que0v5OB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=HACd3n3G x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=que0v5OB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjXDIY1rGbnvj8obfSd4Gychc605eh6Vis8KaFYMkE20iyGc4Bk2/OPRKnZVk5pf2iDAth8D1PsCE+sO5Zi3gaLcpZBitv+B64EZGf3YwUawb18Yugc
    gvOLea5OHaOqV/Pb9g+XWiOodjdUPcCCUSsYd2A+oLkhJn4BfWmR0I7gphbmmCrbO3uZdMlmp86uGR92cz+k4BteRS16qIBn8MCkyodI+TUT8mj77i2Rswr9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=XmLwkUzE_7r71jr9VEsA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeENGrF (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 02:47:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55362 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeENGrE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 May 2018 02:47:04 -0400
X-Google-Smtp-Source: AB8JxZrsAWQ58naGSG2CTbx6ykfJjmHmBHnnMVHlpAdrLRJRDo5v/80zS1Hpxws1hDOUFR1YRmWgKg==
Date: Mon, 14 May 2018 08:47:01 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] efi/libstub/arm64: handle randomized TEXT_OFFSET
Message-ID: <20180514064701.GC16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-18-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504060003.19618-18-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> From: Mark Rutland <mark.rutland@arm.com>
> 
> When CONFIG_RANDOMIZE_TEXT_OFFSET is selected, TEXT_OFFSET is an
> arbitrary multiple of PAGE_SIZE in the interval [0, 2MB).
> 
> The EFI stub does not account for the potential misalignment of
> TEXT_OFFSET relative to EFI_KIMG_ALIGN, and produces a randomized
> physical offset which is always a round multiple of EFI_KIMG_ALIGN.
> This may result in statically allocated objects whose alignment exceeds
> PAGE_SIZE to appear misaligned in memory. This has been observed to
> result in spurious stack overflow reports and failure to make use of
> the IRQ stacks, and theoretically could result in a number of other
> issues.
> 
> We can OR in the low bits of TEXT_OFFSET to ensure that we have the
> necessary offset (and hence preserve the misalignment of TEXT_OFFSET
> relative to EFI_KIMG_ALIGN), so let's do that.
> 
> Fixes: 6f26b3671184c36d ("arm64: kaslr: increase randomization granularity")
> Cc: <stable@vger.kernel.org> # v4.7+
> Reported-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Kim Phillips <kim.phillips@arm.com>
> [ardb: clarify commit log]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index b9bd827caa22..541b82fdc8a2 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -97,6 +97,13 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>  		u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
>  			     (phys_seed >> 32) & mask : TEXT_OFFSET;
>  
> +		/*
> +		 * With CONFIG_RANDOMIZE_TEXT_OFFSET, TEXT_OFFSET may not be a
> +		 * multiple of EFI_KIMG_ALIGN, and we must ensure that we apply
> +		 * the offset below EFI_KIMG_ALIGN.
> +		 */

When referring to config variables in comments and changelogs I'd suggest a bit 
more verbosity:

  s/CONFIG_RANDOMIZE_TEXT_OFFSET
   /CONFIG_RANDOMIZE_TEXT_OFFSET=y

... because at first I thought (based on the name) that 
CONFIG_RANDOMIZE_TEXT_OFFSET is an actual integer offset value - while it's a 
bool. The =y makes the bool nature obvious.

( Similarly, when negated the canonical way to refer to it is 
  !CONFIG_RANDOMIZE_TEXT_OFFSET. )

> +		offset |= (TEXT_OFFSET % EFI_KIMG_ALIGN);

The parentheses are not needed here I think.

Thanks,

	Ingo
