Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF65C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597882176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="M8Ye+OQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbeLTMHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:07:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35538 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:07:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so808491pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIUbfGj0ZCRmz7DLPEjJXEmKMomHxKEDvxPnFWOmzqY=;
        b=M8Ye+OQI+RuG5Ti3jbzJLmyK1REJPPo6EoOu8mS98f0+xKFHq/TPKM/W7BUtOlT9KB
         XHv2sGtoqoOcmg4zfPDloE4ffnWMzuVjjS91Os6MUEZnU6+Dd2vSVhwOFFInbmzcNH3z
         ruORusyMZWKb9OFSZir2EjYN5OzWySdvHNV73G2qtFHIRPWsszsMutnqy+v3k76hvGgD
         TbnWTTxwQvA5l8rk+FqsxrgvRo1A+LkneuFybEIqmVOSKGkI+sS8IOutM0YS7lZsKm7o
         OdcFLDKLyzvJc8+2oEWGnBKccb33YuU2g19gn8i7NkYDvP+jrTRguudy6Ig8DY0LFlpQ
         JkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIUbfGj0ZCRmz7DLPEjJXEmKMomHxKEDvxPnFWOmzqY=;
        b=rnHiYsl4MqsW5mQinuCSyWPritbcSodg40bQKrLYb6wZuVh/xorWc/W+1g6e2U6ak5
         XCUI1XMLBgPpp/ryvLPZxPfCtOL813Kl9TrIbhJ8JohCawWSwHEODiOEbH7+cSvFdJvC
         IWwdkO9lWxR2S32VRrxM5UOYw9Pz0SJFak5MLXGgr0FPDlYNUDqI/nIaHnnJzgQtsVRY
         c6ozr/w54MiuIFCBSR2he3XhG0Ag7zsPjAj+Gk9NDgm6Rgmhwwxdikuw8RKAMnOUtMpU
         6mhdW77Z3pTuuQHAx30WESDK9PuE3z25JLiQ3eYG6H4eGMce39wT9gB5nGMqjuC512qE
         fkWA==
X-Gm-Message-State: AA+aEWZLuQhTg+oO97p0L13Vg9uBXeOrtvvOQCighxSztWVp1jMv9lzy
        qooC7mgnfbAZAbMoMwFBLimgUUXUrs+Knw==
X-Google-Smtp-Source: AFSGD/U4CTIn5tYtDd80tWU+4BXtBiGtjCqcvnq4nHNp205xtPOAJQQBapZjFQN8TdlaZnpm1SspmQ==
X-Received: by 2002:a63:a452:: with SMTP id c18mr23165013pgp.204.1545307668616;
        Thu, 20 Dec 2018 04:07:48 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id b9sm27157846pfi.118.2018.12.20.04.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:07:47 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A425E300816; Thu, 20 Dec 2018 15:07:43 +0300 (+03)
Date:   Thu, 20 Dec 2018 15:07:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: sort cpuinfo flags
Message-ID: <20181220120743.wnb766yemn7xqrjq@kshutemo-mobl1>
References: <20181219195014.A0962820@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219195014.A0962820@viggo.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:50:14AM -0800, Dave Hansen wrote:
> @@ -96,15 +168,11 @@ static int show_cpuinfo(struct seq_file
>  
>  	show_cpuinfo_core(m, c, cpu);
>  	show_cpuinfo_misc(m, c);
> -
> -	seq_puts(m, "flags\t\t:");
> -	for (i = 0; i < 32*NCAPINTS; i++)
> -		if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
> -			seq_printf(m, " %s", x86_cap_flags[i]);
> +	show_cpuinfo_flags(m, c);
>  
>  	seq_puts(m, "\nbugs\t\t:");
>  	for (i = 0; i < 32*NBUGINTS; i++) {
> -		unsigned int bug_bit = 32*NCAPINTS + i;
> +		unsigned int bug_bit = x86_NR_CAPS + i;

s/x86_NR_CAPS/X86_NR_CAPS/

>  
>  		if (cpu_has_bug(c, bug_bit) && x86_bug_flags[i])
>  			seq_printf(m, " %s", x86_bug_flags[i]);
> _

-- 
 Kirill A. Shutemov
