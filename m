Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EA2C65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F66C2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6JadZwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F66C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJFTgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:36:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37879 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeJFTgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:36:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so5364392wrd.4;
        Sat, 06 Oct 2018 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5ebSLkD0UFrm0Zo5niwE5ReF8HMW+6U0qSy/prZmK4c=;
        b=T6JadZwmy4l8sV30x5cxcVjvhz5ErllkjyaJPl6KnPljpsNHa69MK5wCWUL4/DzG3Q
         i2250xYG741txylBwHi7CeL5onXQcNiLYhE90npzcJQuHwx9keMHmhn4Qq+HKs9+jd+l
         cpJYrOaNDS3o83DXZ8g9OjngFSzFNiz7CAxh43q9lTiJlBP402eHz+Un9ZRg8rGqf8qx
         KFRGYpjJ4RxpDWEGbZPNhIiZEkWoR3b+I2NKHMElXtmiK1QdzSnNp+Vuz4/aNRJAg46E
         mONcJp88XSuV+CLGGstLeDwkN2rtjCQAIpdGthyCmeAnAZl2ba2/Vb5NXY5cZbYEIOcf
         stCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ebSLkD0UFrm0Zo5niwE5ReF8HMW+6U0qSy/prZmK4c=;
        b=QrwvR7CARlz75GOZ/OZzpSuvep3C+5p6Btwan2BnUzcH+3IMmiImXHBtoOhmHYLSqm
         GZ7hBCORketytqzVDdUw8FpaSqOEH7bZCYZD3cA4VgvqS/YaoOatIhmREZA7VqHFBetS
         g4Xmco/thJCe2MDFbr0cKQ8rZsbR6hmrgerrg/uH/s/4az0tjX/UmNt3JOr83+HHxWQ/
         1Vu2bkWu6BWIybUf1zkxWHB97cvaqiQxclNtiVqQTyEZHbaaURKTXxkm1mVxlA6w1skJ
         tTfQU41RGDJkvNfXT9hi8k5FusY1ydDHvpQJr7BFpGcK0MZR1vU8OOnAViiybsMoMV4w
         E9JA==
X-Gm-Message-State: ABuFfohnbCaPYCXqNyHogZMr/Z0ci753qpNS+9m3T1oULw0AhXheHv/z
        cI+JFDewxpv+er09wl9p7xI=
X-Google-Smtp-Source: ACcGV60BNITByNkS0xAUnz2OCZMrPqTQnsCMex8Smq5aYfjZPvHrUaSdyg8Nl2em41E42K3A2oK6Ug==
X-Received: by 2002:adf:ec11:: with SMTP id x17-v6mr11138090wrn.266.1538829205496;
        Sat, 06 Oct 2018 05:33:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u191-v6sm4690792wmd.31.2018.10.06.05.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 05:33:24 -0700 (PDT)
Date:   Sat, 6 Oct 2018 14:33:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/3] x86/mm/doc: Enhance the x86-64 virtual memory layout
 descriptions
Message-ID: <20181006123322.GA60572@gmail.com>
References: <20181006084327.27467-1-bhe@redhat.com>
 <20181006122259.GB418@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006122259.GB418@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> +========================================================
> +| Complete virtual memory map with 4-level page tables |
> +========================================================

> +--------------------------------------------------------------------------------
> +start addr       | offset     | end addr         |  size   | VM area description
> +-----------------|------------|------------------|---------|--------------------

> +
> +# Identical layout to the 56-bit one from here on:
> +
> +ffffff8000000000 | -512    GB | fffffffeefffffff | ~507 GB | ... unused hole
> +ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space

> +========================================================
> +| Complete virtual memory map with 5-level page tables |
> +========================================================

> +ffffff8000000000 |   -0.5  TB | ffffffeeffffffff |  444 GB | ... unused hole
> +
> +# Identical layout to the 47-bit one from here on:
> +
> +ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space

So patch #2 appears to have introduced an error/typo in the 47-bit table. Note the weird size 
and discontinuity of the 'unused hole' in the 47-bit table, and compare it with 56-bit table:

  fffffffeefffffff
  ffffffeeffffffff

(Note how the incorrect end address was cargo-cult-copied into the 'size' field of ~507 GB...)

The correct number is the 56-bit one, and both tables should show the following identical 
layout:

  ffffff8000000000 | -512    GB | fffffffeefffffff |  444 GB | ... unused hole
  ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space

Agreed?

Thanks,

	Ingo
