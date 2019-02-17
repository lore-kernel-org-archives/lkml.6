Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43223C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 06:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1182E2196F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 06:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifcnmcwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfBQGXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 01:23:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39281 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfBQGXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 01:23:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so6857822pgp.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 22:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nm7Mpr2bFzDsTZtDgyvgfnqAVAhEse/hD66HPwpevYI=;
        b=ifcnmcwMlqknwcmblNlaOdEKIdi2A7JylegsmM4qPX6LKXhT0ZDMyL5XKSNZUgZ1ol
         mbTn8MatZvfW5RlESuur/dZZzaVRaepLswtWfvSL93RWTQhoKtUMHJWKOU/QNCNchpSq
         Lu/svA4tSsxsI85nS1x9uShfXffajFxM2Df+Mdl4vi3qRz8X6Aqpo0XR/+GbJkZzCj3o
         NrvzGzrRqu5fKqZmH5Bo49rKdOqKBSjfMxBPMNGzaNhsrFFesFV6le1PgjnnT6AA94Jy
         T015qKwtZu05dS2Hm8uFvn5dZTIBkwQrJe1YESNzYmnhfz/SujlmJTpbMmLCkpdxS5A1
         LbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nm7Mpr2bFzDsTZtDgyvgfnqAVAhEse/hD66HPwpevYI=;
        b=MDwwc1LwuGrYoXRCHFxCfURXAyf/KzfjbLkBgc4AH35fnZCj0dhsOPryGCJvbhlavq
         nVbgW1ZxNwsOEara7epEsTaytBJmMn4rhfEw8v+iJnoYk1/Yi3hBbP5xp8Nr9Km7FQvu
         Ze7T/m7PsUZeai/wJsqxi9tlLx1KZXaipX5M9HM91jI9f5Gy+79SYBcyJr0s9ms4SPbm
         rJQz3diDj1HK6Fkwrrfai9QSOMCCGZQvpABKVha7KUR+sFJmL5gXBidSdP4gtZTCHXYE
         Ti/23KhTIb66izVY2qITq4e0Bj+fUwuSp5kcsuZXjASsvhiP30C1WFMVHdr8ISWnyjEg
         jKZQ==
X-Gm-Message-State: AHQUAuYxTMSTzEVKtGtkyoJBO/nCY7+jsJbhzZut4+O0lkv5zAAYVOf1
        3zKl0qi0o8KDibsXb/nrFrZ348uz
X-Google-Smtp-Source: AHgI3IbaL+qoncpcwlKwPaLrZSlwDbREXbJesWUb4jxQUmO9VmgguFlB3LYaCIFe0NomUSbpOkUzig==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr313568pfn.108.1550384618640;
        Sat, 16 Feb 2019 22:23:38 -0800 (PST)
Received: from localhost (220-245-128-230.tpgi.com.au. [220.245.128.230])
        by smtp.gmail.com with ESMTPSA id f13sm13736786pfa.132.2019.02.16.22.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 22:23:37 -0800 (PST)
Date:   Sun, 17 Feb 2019 17:23:33 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        jack@suse.cz, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due
 to pgd/pud_present()
Message-ID: <20190217062333.GC31125@350D>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
 <20190216105511.GA31125@350D>
 <20190216142206.GE14180@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216142206.GE14180@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 08:22:12AM -0600, Segher Boessenkool wrote:
> Hi all,
> 
> On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
> > On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
> > > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
> > > rather than just checking that the value is non-zero, e.g.:
> > > 
> > >   static inline int pgd_present(pgd_t pgd)
> > >   {
> > >  -       return !pgd_none(pgd);
> > >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> > >   }
> > > 
> > > Unfortunately this is broken on big endian, as the result of the
> > > bitwise && is truncated to int, which is always zero because
> 
> (Bitwise "&" of course).
> 
> > Not sure why that should happen, why is the result an int? What
> > causes the casting of pgd_t & be64 to be truncated to an int.
> 
> Yes, it's not obvious as written...  It's simply that the return type of
> pgd_present is int.  So it is truncated _after_ the bitwise and.
>

Thanks, I am surprised the compiler does not complain about the truncation
of bits. I wonder if we are missing -Wconversion

Balbir
