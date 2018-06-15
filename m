Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E432C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C92208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Dq83irAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C92208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756513AbeFOUsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:48:54 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:43213 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756133AbeFOUsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:48:53 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c62d9c9e
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 20:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=g+S3hVlDdyC9j6lQphHSH+UUJjk=; b=Dq83ir
        AHbsIWPVHvx/b72Bd42fYfb/4w181tLBneAa5nDDHnv/PnoQdCCjM3lpf5PeZWFY
        fpK9NYYoNn1y00/rruASNfwRaW8+Zm/zPGVYL3lfMCwnfpC5fkxzsy/8NWK5zk+2
        fFjmKldcORF6rRAkHLl54UWT5T8v5G3ppRK1sIrYYHv+ho+YrQZ9fxq2wdVYoRhg
        +B7dEYZU9cdXBWz6uFYZaQLHlgL2KSQDH7PqBa11/hjfgl0/93cby8+Isoz93Q0Z
        0daXwovJSCLXChpF33lyab29ZDNfR4uO5FbVNo55A2Xj3t4VZwyBtTElbplhm1Wl
        nN+UTwHRoteqzKUQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dc4863b2 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 20:43:28 +0000 (UTC)
Received: by mail-ot0-f181.google.com with SMTP id p95-v6so12410243ota.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 13:48:52 -0700 (PDT)
X-Gm-Message-State: APt69E2e5loc5lmkr1djerfkRFrXtyWPgXnDzwBJHNZb8XOl1vi4SCnp
        blxgERlscgaabStOVHXTBMKpyqT9aH6uVNRmDZs=
X-Google-Smtp-Source: ADUXVKI6mzyDYfMJOW//D5FNhI8AV12V3xumaoVUJZzEhsWqjrM0GzrsCqBsmXUeSaieszKGGmB+GswMVTpTYGDvBCk=
X-Received: by 2002:a9d:542e:: with SMTP id j46-v6mr2189579oth.41.1529095732114;
 Fri, 15 Jun 2018 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
 <6eecf873-9d87-5345-70ba-5c064a31714b@linux.intel.com> <CALCETrWoDEXzH=y9sqoGWtzLPoeWgpRyUQw5AiCubX4O+UOa3w@mail.gmail.com>
 <CAHmME9qBrmD3HJtXHiLYjxhrX=ZL2jNr9TRQayB6SyJcZLmgHg@mail.gmail.com>
In-Reply-To: <CAHmME9qBrmD3HJtXHiLYjxhrX=ZL2jNr9TRQayB6SyJcZLmgHg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 15 Jun 2018 22:48:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9pqANOxpKMujWoP_rydcZ-cDGaypLOs=kdXuB4pkdLw2A@mail.gmail.com>
Message-ID: <CAHmME9pqANOxpKMujWoP_rydcZ-cDGaypLOs=kdXuB4pkdLw2A@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     dave.hansen@linux.intel.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 10:27 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> AVX512 - Intel(R) Xeon(R) Gold 5120 CPU @ 2.20GHz
> Inside: 634415672
> Outside: 286698960
> Percent speedup: 121

More realistic results, with turbo turned off:

Inside: 616851298
Outside: 339606790
Percent speedup: 81

Still a pretty outstanding speedup.
