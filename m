Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0704FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF7A20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF7A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeLGP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:27:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44262 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:27:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so3855852lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 07:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWzi5N9ErnaoM0xtxI+fsrH2tP7+GEG9Yks3l1TlQ9c=;
        b=j/hQaZjf49QZgjtLKC+zZHJRzRMA8PLbd3EaGjDr7/1BHwe6oYiIAGfCaCE+/PYgTw
         f8nKNDNcgeggViU32qaAwbnFXsDPe/r8yKq4EryLzoYJY5XV7DWMKjE2sQ2X+qXVBIiK
         oI/Fs9gbmD0kl6tSpVA04ku5ElUteN6jYdi1L5Q4AJnduJ31Q0g8Cy2n6BwWA0Sy6iru
         9xk9O+Wz3EbDenpbOCClZMMd1hcyHRxVwJRcXRlBL8irNBIvMTekG4J5AtuOGare87YD
         PDJEtwy/hDHWWCqPfcBDWJNq+p5psGNxJumVFGzOW8ZQV3FR8UxC215a6ZcwaPYrGJfP
         cDeQ==
X-Gm-Message-State: AA+aEWbmb2yUq/USk5l/g7MCb2DZdRKr5FU7mbL6+LnIG7BBsC9YuJ/m
        oXM3daCVrMwiKse8syrjLpl5hAbsKk/DlhdfbENwqw==
X-Google-Smtp-Source: AFSGD/WTd/GmJolkIKObTs+ltMJuaDgq9GIkgtG35aCg3hkojYRO9GQVVks9H09pqEe4/k1S2cqSx907M7vYAZaI4WA=
X-Received: by 2002:a2e:96c6:: with SMTP id d6-v6mr1768292ljj.35.1544196426315;
 Fri, 07 Dec 2018 07:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20181207101439.190918-1-james.morse@arm.com>
In-Reply-To: <20181207101439.190918-1-james.morse@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 7 Dec 2018 20:56:53 +0530
Message-ID: <CACi5LpM9_bQnx+YqBcFqFbMWAmZoYtDwopuSq+NpOaX8tjak=g@mail.gmail.com>
Subject: Re: [PATCH arm64/kexec] arm64: kexec_file: forbid kdump via kexec_file_load()
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>, robh+dt@kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>, dhowells@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        frowand.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Dec 7, 2018 at 3:44 PM James Morse <james.morse@arm.com> wrote:
>
> Now that kexec_walk_memblock() can do the crash-kernel placement itself
> architectures that don't support kdump via kexe_file_load() need to
> explicitly forbid it.
>
> We don't support this on arm64 until the kernel can add the elfcorehdr
> and usable-memory-range fields to the DT. Without these the crash-kernel
> overwrites the previous kernel's memory during startup.
>
> Add a check to refuse crash image loading.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>
> Context: http://lore.kernel.org/r/20181206155424.GA4422@arm.com
>
>  arch/arm64/kernel/kexec_image.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 1ad1d5f8f024..07bf740bea91 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -47,6 +47,10 @@ static void *image_load(struct kimage *image,
>         struct kexec_segment *kernel_segment;
>         int ret;
>
> +       /* We don't support crash kernels yet. */
> +       if (image->type == KEXEC_TYPE_CRASH)
> +               return ERR_PTR(-EOPNOTSUPP);
> +
>         /*
>          * We require a kernel with an unambiguous Image header. Per
>          * Documentation/booting.txt, this is the case when image_size
> --
> 2.19.2
>

TBH, I would have loved the complete 'kexec_file_load' support to have
made way upstream for arm64 as well, but I understand that it is stuck
till we have an agreement on the DT side of things. So, refusing a
crash image loading in such a case makes sense for now.

So, please feel free to add:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh
