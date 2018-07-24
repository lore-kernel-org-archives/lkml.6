Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1559C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEEE205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sh8VHPCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEEE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGXIlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:41:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35071 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:41:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so3069903wrt.2;
        Tue, 24 Jul 2018 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XPD7RccnLvT4VAt2N6s4HnFKNbU1T68iVADG47R1bmI=;
        b=sh8VHPCbrm0do5xhqo0iGzmvKIdgOr+iDz3zckhVxaiUQxMGvQtE0TtXSqlwD2L4Cv
         /plcxM/iSMcd30nh0QWgN5HkMCk2WzPAkWOrnMOmj0wCBxopI2m62NVN4pvK9AXQDBr8
         //5q7Rv3SJM4KLXQ3oXyrcBKqEl1fKxjirFunFEdPThn+JDfOg5nWfUzRD/SnJMgRLai
         rgMSNoZuvmn+0wSH2epXesBjGLXYtykkxjdBm983V/onU94EL2PddTAE/QsXk7VAwJkp
         ykh6rg/Vvys4hKJ3fL14mfNrmo+sKr+fIe3aP7Jw2D2gAeZDcjjlPO3JISq1KE50z3MP
         2hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XPD7RccnLvT4VAt2N6s4HnFKNbU1T68iVADG47R1bmI=;
        b=UnrJ3OUjY4YZBE6qkETrS2fbYmRGaivXJ2TMikJHRXdzZezGhzifJ+kYsMAz6rYYjM
         lkh+WSkZzcowWts6siPBsd1OWJOHneN8tmDbc09xunge/0zVJiTqskG64E/QctTZzq4p
         8+nq2lzqrERPoRSxcypUXJKvoRPdIJswtHXLCE6sLYKB1XRmKI1Ehy7ogqbKsTLISp/W
         cZs1gq7hrT6n8PPvpgYXp4SVrYZMT8wSbs6b/Jv28egc+I0+cToP04iC6Q+cHi5P0RnK
         +V5wp4edZacAa8pj63sx960uJ32vyQpcBev6qBqJw09Z/lRbCMZW2VvToCDjaMqPiKuy
         EFeQ==
X-Gm-Message-State: AOUpUlFx7Zd+tz/SFkD8GDR5wEAOJ+WG7GOmUfNEtXTzNea7FC9fv4eG
        x70U5/CmBUn+dw197/92OfQ=
X-Google-Smtp-Source: AAOMgpd3C8XVwP04Kkau4JnjKYhUsYP5kQXDWFaJhvJvwvOj7E93y/6uW1+M88+30ZBK8PsxWPWp2Q==
X-Received: by 2002:adf:dc8e:: with SMTP id r14-v6mr10540542wrj.166.1532417804624;
        Tue, 24 Jul 2018 00:36:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s124-v6sm1172441wmf.47.2018.07.24.00.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 00:36:43 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:36:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        x86@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/13] x86/mm/pat: Prepare {reserve, free}_memtype()
 for "decoy" addresses
Message-ID: <20180724073641.GA15984@gmail.com>
References: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153154382700.34503.10197588570935341739.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153154382700.34503.10197588570935341739.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for using set_memory_uc() instead set_memory_np() for
> isolating poison from speculation, teach the memtype code to sanitize
> physical addresses vs __PHYSICAL_MASK.
> 
> The motivation for using set_memory_uc() for this case is to allow
> ongoing access to persistent memory pages via the pmem-driver +
> memcpy_mcsafe() until the poison is repaired.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: <linux-edac@vger.kernel.org>
> Cc: <x86@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/pat.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
> index 1555bd7d3449..6788ffa990f8 100644
> --- a/arch/x86/mm/pat.c
> +++ b/arch/x86/mm/pat.c
> @@ -512,6 +512,17 @@ static int free_ram_pages_type(u64 start, u64 end)
>  	return 0;
>  }
>  
> +static u64 sanitize_phys(u64 address)
> +{
> +	/*
> +	 * When changing the memtype for pages containing poison allow
> +	 * for a "decoy" virtual address (bit 63 clear) passed to
> +	 * set_memory_X(). __pa() on a "decoy" address results in a
> +	 * physical address with it 63 set.
> +	 */
> +	return address & __PHYSICAL_MASK;

s/it/bit

Thanks,

	Ingo
