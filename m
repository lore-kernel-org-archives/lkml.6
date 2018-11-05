Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC265C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D15F20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eujQqY5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D15F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbeKFA4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:56:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53326 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeKFA4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:56:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id v24-v6so8838568wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wPxaXLAoeqDsGzlZsQpmh10uKf7xRpSJRSXgCynY2a0=;
        b=eujQqY5OUUMwCwSD0aOGxfO/ylH1eoI0c0WXxz8oRfmAPg+JervbKEtzYVWGGik+Dv
         kBBFgQWR7HAGKSKX4K+8A7D4q3ugn0QOsw0BVIcML7qhZ8ZmOvNn6NHpYLtNFJojoENl
         MZ2qXfZX5BUGY5N1vCuqf1yccaY2kqc/LUiUcO/HHnYfl5os03W4BsAPFw+acVaXwKKc
         8E2mmLWs+sDxvweSVR3mLwnTK3OPtKFLd23P7ssb2MOAiKpOGM62yYpFVn8tiVmyv6Pg
         nejGftDPneQ6ljF50hdgxipDU8W+0uwv7klk2QhWj3X2URZuAtFerEQX/shbS2AKVpe1
         rZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wPxaXLAoeqDsGzlZsQpmh10uKf7xRpSJRSXgCynY2a0=;
        b=V/GV/JxHIdIRrIwd6PZRwy5oQlD0ctDRHFsv0tZ9EY1p+ZeY1IswQrMZlidovqzN4Z
         kpfjolFnyzbynsDbtkRyxAtENw1JNy7rcOg7/KwzEscQoIvFntvt6gWtAcfdkq2Xj4YF
         QxSjwSbYae/PJmb0vU5IvpszVfWqnHub5YF7VneO43IZnlnBE7OGTkGLFaqkipkaCaFZ
         co6dEi100m7CZVL2PvfthEiH4DNZikFV01jWOUoMWlVSIy/k8KhYHWnTAIACBQ9L5fNN
         vzRrYCui3qrRqPzVCHOpibT+9BhL6xyHf5LGiZfPSJJbVgDf7wkQzIROZgFeyQI+4BS/
         4LWg==
X-Gm-Message-State: AGRZ1gKNFzHpSeA0nT902SoNQ6MSff41eEeHrKE2aD4a23dZfUlJbmRe
        rvzOQUdalnn+4Gw976YyLsex+o1D
X-Google-Smtp-Source: AJdET5cHZTJhj69foIsoTHjv9MngtWvOBydrqjnkS9ZDxybyZtlFEs+wOiBMeHqo7AkZSEr58+QOWQ==
X-Received: by 2002:a1c:3a8d:: with SMTP id h135-v6mr6791792wma.92.1541432143819;
        Mon, 05 Nov 2018 07:35:43 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o3-v6sm6662317wmc.2.2018.11.05.07.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 07:35:43 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:35:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/gart: Rewrite early_gart_iommu_check() comment
Message-ID: <20181105153540.GA89305@gmail.com>
References: <20181101155314.30690-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101155314.30690-1-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> ... to actually explain what the function is trying to do.
> 
> Reported-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/aperture_64.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
> index 2c4d5ece7456..4fb4b7f53568 100644
> --- a/arch/x86/kernel/aperture_64.c
> +++ b/arch/x86/kernel/aperture_64.c
> @@ -264,18 +264,23 @@ static int __init parse_gart_mem(char *p)
>  }
>  early_param("gart_fix_e820", parse_gart_mem);
>  
> +/*
> + * With kexec/kdump, if the first kernel doesn't shutdown the GART and the
> + * second kernel allocates a different GART region, there might be two
> + * overlapping GART regions present:

s/shutdown
 /shut down

Thanks,

	Ingo
