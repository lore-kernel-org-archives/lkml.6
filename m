Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14006C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB9120825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Lo0LkcDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB9120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeKJGtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:49:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42686 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJGtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:49:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id u10-v6so1456003pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 13:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DtZf/Yhf6YcoCJQtZF/0TckJMdJbZDAs+n97jsH+NWg=;
        b=Lo0LkcDjzceyGEbQmVDxX2QEbERLDpRj0iVjak0bfGElpu8kKxQctdqHnTa4bLktZu
         06K1OLwk/rEH2+KN3bbfuhpH/pYBgWVmEeiFDu1P9/OgizrbRJGGTfhdvj7vY5/aZiif
         LiNMYgQirHQrM/8IHhX/N0RvQMqbVlUhRBim55fWJw9178eubvxN11qttm68RJvYFmzf
         W43TMUXNANiHxNfAwmkVg2CsYeJ3j0ZlUcSv7z2AK9ulmJN3lE0fv6INFFoAhpj2/kRi
         02g1Dh6XUcYtoat+UxSiaX58tQLYvccKzCnmU1Ot/pWFXYrhjUqP9Da/don0a4bwVnBC
         jOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DtZf/Yhf6YcoCJQtZF/0TckJMdJbZDAs+n97jsH+NWg=;
        b=oEeYdVE5UJLsaTqnSS5kWO7qVt4emxciLz3yVs8y4sPkZnpleDMRH2bSymShV20ZKr
         p813B5fByuEwHcvGqEtTVRVCDCgbI4AW5zGdz1cllC6rrLvjKpuD+XydORgVUkelipZu
         wBKBg/4ovvCVo2WzTpOn/7yP2Tx8ReDdCGdsE465+woJWEfxso5MsaH4J6L2dGIccN3O
         xpnDD7c8+w0YmQ5hbAhJChyT0SCSZ+LbYUmToyhE/9XCs4v5AKdn0/XReJA9WXhfXnSv
         1hRLRGCEpVpybmPFILZDa+0tdKK1BHTbkPYfGWh0VHa1gU79xwwYSxJTzloItKuKq2Tj
         BlMg==
X-Gm-Message-State: AGRZ1gK/5y75efOwH5jYkrZNSfgqg36/B09dtixbzvOJu9VGMl1fPQ1m
        xO3/A7P9opKABPeVzRmxkqshrhnM4Dg=
X-Google-Smtp-Source: AJdET5fIH+NiBOZBDeq8BSRMOeS9X953ImVxIGBzgZDZYYinojsUidMzX5lX5up4okGXgHl+tE1fMw==
X-Received: by 2002:a62:380e:: with SMTP id f14-v6mr10425998pfa.203.1541797624592;
        Fri, 09 Nov 2018 13:07:04 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n87-v6sm10101474pfb.62.2018.11.09.13.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 13:07:03 -0800 (PST)
Date:   Fri, 09 Nov 2018 13:07:03 -0800 (PST)
X-Google-Original-Date: Fri, 09 Nov 2018 13:06:44 PST (-0800)
Subject:     Re: [PATCH] RISC-V: recognize S/U mode bits in print_isa
In-Reply-To: <20181109193349.28179-1-me@packi.ch>
CC:     linux-riscv@lists.infradead.org, me@packi.ch,
        aou@eecs.berkeley.edu, atish.patra@wdc.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     me@packi.ch
Message-ID: <mhng-cff31d5f-053e-4e62-997c-232c8bdd5fd3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Nov 2018 11:33:47 PST (-0800), me@packi.ch wrote:
> Removes the warning about an unsupported ISA when reading /proc/cpuinfo
> on QEMU.
>
> Signed-off-by: Patrick Stählin <me@packi.ch>
> ---
>  arch/riscv/kernel/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 3a5a2ee31547..4029c7e6872b 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -64,7 +64,7 @@ int riscv_of_processor_hartid(struct device_node *node)
>
>  static void print_isa(struct seq_file *f, const char *orig_isa)
>  {
> -	static const char *ext = "mafdc";
> +	static const char *ext = "mafdcsu";
>  	const char *isa = orig_isa;
>  	const char *e;

This is a bit pedantic, but the "S" extension should really be hidden from 
userspace.
