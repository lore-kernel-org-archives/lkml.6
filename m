Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D49C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022992173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NFWVTb2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022992173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeHUCsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:48:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44839 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeHUCsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:48:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so7536417pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wVB50HPFIvEh5C1xFtxJ1SV8MXGvqdJD3nLvGKQdLLw=;
        b=NFWVTb2HH18i3RxrbmEDTgwTfFOFFt8Qoeg/AqyIqNzYvnFeEklqeVdHb4sjZHnC7Q
         FntmNYFVOpc6oUe3JDQ22thJagPQ2ak+inX6XnphcTZONeF9U2/HAk9G012xrQnaOKHu
         /C7RMfbss/AMGlB3A0j6+e6M1c8D9YBlSJ5Tqt6yKIg0YpCOlSojx47FPMjsXJo0y9Kw
         DuSYJet9XpdpgUdS47a2KjjYMaVSPOhGl2d2TEV/lahVoEOYwzOoUy/p8TvvnfdswQtM
         d9LYY90vz3WFcdrNCXS/DzIPl0zXTgiy6qjsXxbIxVnW0RrfsCqoWy/ZFPct+U+0RFTX
         zKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wVB50HPFIvEh5C1xFtxJ1SV8MXGvqdJD3nLvGKQdLLw=;
        b=m9mVD+7ELbUgsa7aBt9C4DkF5GDsgSHrfGYcsIQgxpCIc47v3KWa7Jrc0Zt6aMMqzP
         HDANE6o79kd7m/1+Q4nfzeuRWTq66F6ahy+RLyV2TXiHs0r3iiHIyujsABPoF2aStwBx
         CCehIboHPmeYP8WTjH0pulNpfyLMX6ua06xydM2+zeBMDPP76HoBNHXE2+qu+iDxp3Rw
         KDGB19C4pUrAP0paWRrZop17PfInKCxKIe2t+seXGOoWFFXyoi6rNsngLJAhK3PNks76
         vsqaydz/pQ81haqv71i1tUgWr9fAsUvKkp7Do95KB7p2z9ZNHBusMAS/rO26wEuVKRJW
         lyqQ==
X-Gm-Message-State: AOUpUlHh2hL4WZ5xKPExIh0zIGCPtcE+IqGIFZoVNB3XbgyFxr2iOLw7
        BMT8nIZFYFejkAjd9Rq41PZoXg==
X-Google-Smtp-Source: AA+uWPxw0YjZjM28A6ssJQy60E94AIHRxGhrIqFu8NvLzTfep1VhjHpr2Qr57G5O9x5tMeBYFFP7fg==
X-Received: by 2002:a62:234d:: with SMTP id j74-v6mr50137529pfj.106.1534807841082;
        Mon, 20 Aug 2018 16:30:41 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x80-v6sm20588431pfe.129.2018.08.20.16.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 16:30:39 -0700 (PDT)
Date:   Mon, 20 Aug 2018 16:30:39 -0700 (PDT)
X-Google-Original-Date: Mon, 20 Aug 2018 16:23:55 PDT (-0700)
Subject:     Re: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
In-Reply-To: <20180814133922.GC28080@infradead.org>
CC:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net,
        aou@eecs.berkeley.edu, Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, tklauser@distanz.ch,
        linux-riscv@lists.infradead.org, dan.carpenter@oracle.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-32cf9aae-1b8f-42e7-86ce-497ba7a43577@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 06:39:23 PDT (-0700), Christoph Hellwig wrote:
>>  SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
>>  	uintptr_t, flags)
>>  {
>> +#ifdef CONFIG_SMP
>>  	struct mm_struct *mm = current->mm;
>>  	bool local = (flags & SYS_RISCV_FLUSH_ICACHE_LOCAL) != 0;
>> +#endif
>>
>>  	/* Check the reserved flags. */
>>  	if (unlikely(flags & ~SYS_RISCV_FLUSH_ICACHE_ALL))
>>  		return -EINVAL;
>>
>> +	/*
>> +	 * Without CONFIG_SMP flush_icache_mm is a just a flush_icache_all(),
>> +	 * which generates unused variable warnings all over this function.
>> +	 */
>> +#ifdef CONFIG_SMP
>>  	flush_icache_mm(mm, local);
>> +#else
>> +	flush_icache_all();
>> +#endif
>
> Eeek.
>
> Something like an unconditional:
>
> 	flush_icache_mm(current->mm, flags & SYS_RISCV_FLUSH_ICACHE_LOCAL);
>
> should solve those issues.
>
> Also in the longer run we should turn the !SMP flush_icache_mm stub
> into an inline function to solve this problem for all potential
> callers.  Excepte that flush_icache_mm happens to be a RISC-V specific
> API without any other callers.  So for now I think the above is what
> I'd do, but this area has a lot of room for cleanup.

Thanks, that's a lot cleaner.  I missed this for the PR, but I'll submit a 
cleanup patch after RC1.
