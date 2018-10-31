Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F927C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB7120685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="IhYQKOpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB7120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJaSCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:02:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40284 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJaSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:02:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id g21-v6so7292980pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TIWjmqbEd/zuiJ0NHy8DUlpR/L7Id5VevFW/stv5+/8=;
        b=IhYQKOprCE3fNEKbKluEgoq6pIP0TOefK55MHA/T6JuxbJEyHSRxTHTmLBdlcmHwqd
         /syc8THOu4Gi5q0HvGgu5ftGq7P7dgTgCCd+1kuEgE2R78JByo8T64lqqQAk5R6EFbdC
         4YY1pFMAEWl0gSE1O4Z3c1Flih+fjOxAe8JRwu5mtrXX6RU1BNQMvwiAb1WXPElgUcLN
         p3U9hWjUdNWxrlWp1Q2r8GO1N9IFOIPvh4h1y45/LzYAICnDJDMEr+nbm1gQba9UES/M
         NpvJ2/ZKwRLLxj5dbJa5/OjpVMBPBXhUSA+w0xPG0uCM4k9QSF/59B6htG9R9C4M8U/H
         0gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TIWjmqbEd/zuiJ0NHy8DUlpR/L7Id5VevFW/stv5+/8=;
        b=I26z0R9pQMazwvAyLsLgZ2gz40PuBdqTTLXlYuuNgl66IutPIhGjfQgUPYQf55tNgi
         yuYL9puPuJSTYbkG48Ptx2FO5n7iKdwZnIpA+8lfvQrPcxJQqcUQgPJcZLbzvDY6f799
         11DNZaKyBtoVJlINMZ1IGrtcwP8X2Y1Q1rk49TaywoynjnlKo6W46+US7ZmAozoA+hbq
         auf2/9uER9cYqnJTmPPfUaVLfO+rjtVr6YT5n235rleupJanx4VgKGn1f77ns9C96mjg
         ptuCYhe0eiSaZFwoT+ceezIdi2FwJ12lmtunBbQOlNIN+WSeDa4cqu8XXVMrYBxZmzGd
         aiNA==
X-Gm-Message-State: AGRZ1gLnYyQglRMZZE/FiRzI5ZrbLO31GKPumYYPKs8XITyg3hcJdiUP
        t2qSqFF+ZHZFtpMsaaQxQ0a5zQ==
X-Google-Smtp-Source: AJdET5dxnGZBxHSmnh+AW50GKD5hlSoNzE7aJM+UbAcizOFmIQ8NFZ26KbcP1Axq6eVQ7obcDuabcw==
X-Received: by 2002:a62:5bc4:: with SMTP id p187-v6mr2504294pfb.94.1540976685109;
        Wed, 31 Oct 2018 02:04:45 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id d143-v6sm24383051pfd.58.2018.10.31.02.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 02:04:44 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B45EF301604; Wed, 31 Oct 2018 12:04:39 +0300 (+03)
Date:   Wed, 31 Oct 2018 12:04:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/3] mm: add mm_pxd_folded checks to pgtable_bytes
 accounting functions
Message-ID: <20181031090439.5uhyk74g2e3j6lm3@kshutemo-mobl1>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
 <1539621759-5967-3-git-send-email-schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539621759-5967-3-git-send-email-schwidefsky@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 06:42:38PM +0200, Martin Schwidefsky wrote:
> The common mm code calls mm_dec_nr_pmds() and mm_dec_nr_puds()
> in free_pgtables() if the address range spans a full pud or pmd.
> If mm_dec_nr_puds/mm_dec_nr_pmds are non-empty due to configuration
> settings they blindly subtract the size of the pmd or pud table from
> pgtable_bytes even if the pud or pmd page table layer is folded.
> 
> Add explicit mm_[pmd|pud]_folded checks to the four pgtable_bytes
> accounting functions mm_inc_nr_puds, mm_inc_nr_pmds, mm_dec_nr_puds
> and mm_dec_nr_pmds. As the check for folded page tables can be
> overwritten by the architecture, this allows to keep a correct
> pgtable_bytes value for platforms that use a dynamic number of
> page table levels.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Looks fine to me.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
