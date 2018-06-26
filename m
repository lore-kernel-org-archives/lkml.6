Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8576AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4EB267F2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjIQqMRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4EB267F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934289AbeFZJiN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:38:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51090 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeFZJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:38:11 -0400
Received: by mail-it0-f66.google.com with SMTP id u4-v6so1353579itg.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O1PE21a+PRmUcGf63OZtspYftsekjt9p1IUenxV/JDA=;
        b=EjIQqMRooMXXwjYEhg9PFq167AIiU9/hsGMciPvt8S09dfDaHQmJ3OEV5i6Ee29Qwu
         FjZd10uhRRzbih+8VFmF08nXbVXRAWItrbt4xirc+dW9G5Btn863rDqgnBYLMo++RhGn
         dP9UgBLzcAmZpl3Z8Np1QuDmr5PPIxcRWB9Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O1PE21a+PRmUcGf63OZtspYftsekjt9p1IUenxV/JDA=;
        b=MArRxg91Wxar2Zxvg28UeUHMwm43pr8y+n9//6uvEsuo22Y3UhansMEy8UwZrm58qz
         VQJ0qPBsDGUU1/mgDqrJEU/fKYs8OgVYUgvXGr+NQABzalTJuTfytlLNOW8lu7T6knNH
         67aYqYFkU5+FC26UlPS3oDJRbXMW1hgGi7n1eMep1izjHA5+qUgd7GMemyosg/Bd20Ed
         RxW3L+CB+s152fmpoqHFcMvpypPinBbp7nftQJg9cRN4m76s9xzcZlvy1Cc4GtHdpxma
         gXmop7E5BDl8u7LLvVmzpAIKQoJ9pp1NkaI7oriLxQJwV84ShvXAuaQeJ1i2L9bISuDR
         gA7w==
X-Gm-Message-State: APt69E0Qf7T41VnryOWAsbEyyu+125ezFKT3fLmk5u0P/nyOPFDZnN7w
        BJ2XRTOLXuFRPZUrcwi6/o1uFAgDCJqv+WckZDfNTg==
X-Google-Smtp-Source: ADUXVKLafwuXm5KYgykLt0KcMmFq1FnSymzhVmhoYID5re2tfni0gk6TF6TdwZ97SMfKCSOsvIY+fTrjqfSCHNZ0FA0=
X-Received: by 2002:a24:d7c5:: with SMTP id y188-v6mr782300itg.50.1530005890530;
 Tue, 26 Jun 2018 02:38:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 02:38:10
 -0700 (PDT)
In-Reply-To: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 26 Jun 2018 11:38:10 +0200
Message-ID: <CAKv+Gu-_tQsYMUMp4NGrEkRrbFGJvE=vJVciaO6TEAC_u5bmfQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Free existing memory map before installing new
 memory map
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 June 2018 at 04:41, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>
> efi_memmap_install(), unmaps the existing memory map and installs the
> new memory map but doesn't free the memory allocated to the existing
> memory map. Fortunately, the details about the existing memory map are
> stored in efi.memmap. Hence, use them to free the memory.
>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Lee Chun-Yi <jlee@suse.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Ricardo Neri <ricardo.neri@intel.com>
> Cc: Ravi Shankar <ravi.v.shankar@intel.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> Note: Patch based on efi tree @https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>
>  drivers/firmware/efi/memmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 678e85704054..68b27b14fe94 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -229,6 +229,9 @@ int __init efi_memmap_install(phys_addr_t addr, unsigned int nr_map)
>
>         efi_memmap_unmap();
>
> +       /* Free the memory allocated to the existing memory map */
> +       efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map, efi.memmap.late);
> +
>         data.phys_map = addr;
>         data.size = efi.memmap.desc_size * nr_map;
>         data.desc_version = efi.memmap.desc_version;
> --
> 2.7.4
>

If only it were so simple :-)

At this point, efi.memmap.phys_map could point to memory that was
allocated early, allocated late or simply passed to the OS at boot
time by the stub (in which case it was memblock_reserve()d but not
memblock_alloc()d, and it should not be freed)

So only allocations made with efi_memmap_alloc() should be freed here.
I'm not sure /how/ we should keep track of that: perhaps it is simply
a matter of replacing the boolean 'late' with an enum that describes
where the memory came from that phys_map points to.
