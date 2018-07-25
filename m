Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459C5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C5620882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+eaOBnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C5620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeGYLU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:20:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54378 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeGYLU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:20:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so5449829wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8fJy2UUZNWsTBrVloKGgVpp74fGwGR5ql/tcxDE0tVw=;
        b=c+eaOBnmn0OA+DhSLp26WQ8eS5ZSYLvp3pPrdHTkmDidhjoZCKtB/j1GDjlGZD+R8M
         2XCZ6ceX8Bub4N5+PDC7M+gn2MMEK77V+KSgd7OgMybY7UGy4UrkZwCrCyajLVypK+6q
         ucMNQ3hrGiLYH1B2iNscR9a7JG9HAf8lAEviVLhb59B3bIe46rdgTpyJvqKgZjxr443S
         gD/Au3ks1Ic4hlqUYxxRugs7V8eJKuSyiW94BeIl1t/Uy9sfLdE33D8ptgzHMgSHLgQz
         O2al3t5NQbCHtYTgyxFJIN5xdtQt4YbwcOgYJa1tyFDcuc1yHtUVJwRdj2MVKGcF+3f8
         NPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8fJy2UUZNWsTBrVloKGgVpp74fGwGR5ql/tcxDE0tVw=;
        b=COzKs2R8T/X44zrZ6SbducoTrKTehwGhbD5wXda/LwJ5wtev3cG9RBDjEB1NNLYmEj
         TlcBQ60FIdoOo7e7k2QkLGfFtuWepvDw3yDAEMWpRf7W6F/0UTOe5ydV6R7LXI96XPRz
         mCFt0s8BxwRdNAQl3hFolM7eSkpKChtFlx00AtCpbpndp7+CQam8H9QXCy/05evhjWf/
         YYtH6C29z+Vy3BddLK5MiYYmK7RYDyKas5ZTnoxT7E4HAMkDznm87GI0FgPE3bzvmYeT
         Q9zfHLAR+1hS768vyBXX7HvaGTz/gPAdJWfxr83079ALmb4wmBRdlaHxnTkFipszJCPD
         vApA==
X-Gm-Message-State: AOUpUlE5R+ypeJw04OZSoEPxViW0DruoEMU0/BllS1s3nAQE8NgdMIwD
        X1XQZx0hTSLq4Wtd+c7bc4s=
X-Google-Smtp-Source: AAOMgpc+KrxbuMela5MaUCJFbfxQmlEct3JaHz9IGyXAI5/owaQTFGqn3dNpmNhrwOxdVsBoyD5L9Q==
X-Received: by 2002:a1c:ad42:: with SMTP id w63-v6mr4538024wme.100.1532513395797;
        Wed, 25 Jul 2018 03:09:55 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 64-v6sm13693456wrj.50.2018.07.25.03.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 03:09:55 -0700 (PDT)
Date:   Wed, 25 Jul 2018 12:09:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     riel@surriel.com, peterz@infradead.org, songliubraving@fb.com,
        linux@armlinux.org.uk, dave.hansen@intel.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: asm/tlb.h: Fix build error implicit func declaration
Message-ID: <20180725100953.GA26481@gmail.com>
References: <20180725095557.19668-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725095557.19668-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Anders Roxell <anders.roxell@linaro.org> wrote:

> Building on arm 32 with LPAE enabled we don't include asm-generic/tlb.h,
> where we have tlb_flush_remove_tables_local and tlb_flush_remove_tables
> defined.
> mm/memory.c: In function ‘tlb_remove_table_smp_sync’:
> mm/memory.c:339:2: error: implicit declaration of function ‘tlb_flush_remove_tables_local’; did you mean ‘tlb_remove_table’? [-Werror=implicit-function-declaration]
>   tlb_flush_remove_tables_local(mm);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   tlb_remove_table
> mm/memory.c: In function ‘tlb_table_flush’:
> mm/memory.c:372:2: error: implicit declaration of function ‘tlb_flush_remove_tables’; did you mean ‘tlb_remove_table’? [-Werror=implicit-function-declaration]
>   tlb_flush_remove_tables(tlb->mm);
>   ^~~~~~~~~~~~~~~~~~~~~~~
>   tlb_remove_table
> 
> To fix this issue we define them in arm 32's specific asm/tlb.h file.
> 
> Fixes: 2ff6ddf19c0e ("x86/mm/tlb: Leave lazy TLB mode at page table free time")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> 
> Ingo, would it make sense for you to pick it up into the x86 tree since
> that contains the bug ?

Done and sorry about that! Will push your fix out to -next as well ASAP.

Thanks,

	Ingo
