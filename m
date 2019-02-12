Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2AFC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72D2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPelpcvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfBLHUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:20:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41712 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:20:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so1427551wrs.8;
        Mon, 11 Feb 2019 23:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U64zTCXWDQ7iL31iPsF8RezMrqba1QJ9+7xpUmpn3AA=;
        b=iPelpcvbRs7OVTfvAQIxw5jGMdR/imNfdBLMJWS+6cR3yNon0sbyKrc0uhM6WpfD9c
         c5cHKI8P5wDgVY4vrKyJqaK6fDS1QB8gKlxWyYTjnVQTBQoeC6DxrtTAi273NNAfgBY+
         BEAweeQJHwFJ9v0vvhIP1Xu6ypibp8nl4w2Kge0SvZtk6Ws3iu7a2at46rT85IXU7K1c
         OKDH1oMBrwTlJq2eh+IXg+JBI02lNZ9BJFW5c7s1f59bZghUBuTP8j49HNS+BnpkKIrD
         i+1pfV2ojGu3KMRUvbxIJD4/0kCwEjB5bi1/DqDEQGjkUJMeemLA5ZZC/eDXbMMsfKTN
         c1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U64zTCXWDQ7iL31iPsF8RezMrqba1QJ9+7xpUmpn3AA=;
        b=KDCkXVAzZJRNCWpMosUkbMsKqgRuKv6qDPL08D2FbhsYv0/m1EdWfKDBbrXUlp2dp2
         Xgx9wgrx72N9+FSxi5YGftCPJAmhjPkarNvNvfckbAQqgxNy3jdnf7GnG7CZmWd0tb7h
         Ak+qwV7X2zm9JUqYlA+SXqLEQgTknQrZyp72ljp8zMfyKas0wLtWqtHT4F0hnVaJZmQP
         IuDmAkIcNdgHneP/Cgff+sZikuaIICO5quqYCYE48p9EfmWVlC891ivcPSA7yZr70q2G
         Idies/iQx4jAraD2oQ0lU6ieI5DX1rzxmLvwdYDEUUdyjvzztjc33dnPc9ww94mP1/GD
         mG+A==
X-Gm-Message-State: AHQUAuahhQLVjOXPOktRFicB9FBr25OfRI8jOIdR/KV7D3xL4NIu+Ukc
        mcF13WyT+TTHKHy0ePdvKNTbDDyShek=
X-Google-Smtp-Source: AHgI3Ib1rteFIO7F0GUg3/O7a4JhOup1XgqAIL1t8DVD3QH5Hne7mwKWsjaC+uzVtJQT2Q3UmkphpA==
X-Received: by 2002:adf:f60d:: with SMTP id t13mr1601500wrp.225.1549956038339;
        Mon, 11 Feb 2019 23:20:38 -0800 (PST)
Received: from [172.20.11.181] (bba134067.alshamil.net.ae. [217.165.112.209])
        by smtp.gmail.com with ESMTPSA id a4sm1218794wmm.22.2019.02.11.23.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 23:20:37 -0800 (PST)
Subject: Re: [RFC PATCH v4 01/12] __wr_after_init: Core and default arch
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1549927666.git.igor.stoppa@huawei.com>
 <9d03ef9d09446da2dd92c357aa39af6cd071d7c4.1549927666.git.igor.stoppa@huawei.com>
 <20190212023952.GK12668@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <9ebd237c-c059-9219-8d11-7a708a1f80da@gmail.com>
Date:   Tue, 12 Feb 2019 09:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212023952.GK12668@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2019 04:39, Matthew Wilcox wrote:
> On Tue, Feb 12, 2019 at 01:27:38AM +0200, Igor Stoppa wrote:
>> +#ifndef CONFIG_PRMEM
> [...]
>> +#else
>> +
>> +#include <linux/mm.h>
> 
> It's a mistake to do conditional includes like this.  That way you see
> include loops with some configs and not others.  Our headers are already
> so messy, better to just include mm.h unconditionally.
> 

ok

Can I still do the following, in prmem.c ?

#ifdef CONFIG_ARCH_HAS_PRMEM_HEADER
+#include <asm/prmem.h>
+#else
+
+struct wr_state {
+       struct mm_struct *prev;
+};
+
+#endif


It's still a conditional include, but it's in a C file, it shouldn't 
cause any chance of loops.

The alternative is that each arch supporting prmem must have a 
(probably) empty asm/prmem.h header.

I did some reasearch about telling the compiler to include a header only 
if it exists, but it doesn't seem to be a gcc feature.

--
igor
