Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E2BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27FE208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27FE208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJBNZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:25:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34431 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBNZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:25:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so730774ljk.1;
        Mon, 01 Oct 2018 23:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eRKxdfWBv5tPuMnMvh/PunIN0rSTzHryEfgPlLpOWeg=;
        b=iybC+zLcLcQYw3ecCQqtnUrm3FKVjIQ8ZRItA6taPuPQLXZtkFBHE8DbqA3SflQ5Ur
         kxUBrJFRMLlKoKiNRlxAOGnuQrtFNcL9stgQB4LJdZSZ9NCoArELFAy+9j66/BsauHUT
         9ak9sLovdXGwS7AiYHxAheKtpDVzh4v2E1YF8R6aZTv4YnfYg4vzLVYp2x/fWCxkknfR
         +V1K80X8Y8ZgDk8vWP6xWIdpUgACXnSzixTcJhY99Pmmw0CUWc32saOq6aN9bxPuEoVO
         gTopJ0EuA6rqjRspniA73OItSSCOj+wtlrYW3UHqhMWk4uRTw4BRZQJRvclTo/0NMf7t
         dwbg==
X-Gm-Message-State: ABuFfojpczztLKDQyd6lY/ZZlGUDZMwMgxgt/pRKP+TdHJ3hsz5xNixU
        0xlBJp58z1IFRd1CWpNw5pU=
X-Google-Smtp-Source: ACcGV62Pb4UJcBdycI66zlcVFNuv4NbeANXHUJ313PDB+llQ1JQe+nUm3Zam38uP8FmxssmxGNrZ/Q==
X-Received: by 2002:a2e:4702:: with SMTP id u2-v6mr9127605lja.147.1538462599756;
        Mon, 01 Oct 2018 23:43:19 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t5-v6sm102050lfg.90.2018.10.01.23.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 23:43:19 -0700 (PDT)
Date:   Tue, 2 Oct 2018 09:43:17 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the regulator tree
Message-ID: <20181002064317.GD9389@localhost.localdomain>
References: <20181002130748.61e33ad1@canb.auug.org.au>
 <20181002061644.GC9389@localhost.localdomain>
 <20181002162551.29b8c977@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002162551.29b8c977@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen, Mark & All,

On Tue, Oct 02, 2018 at 04:25:51PM +1000, Stephen Rothwell wrote:
> On Tue, 2 Oct 2018 09:16:44 +0300 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> wrote:
> >
> > On Tue, Oct 02, 2018 at 01:07:48PM +1000, Stephen Rothwell wrote:
> > > After merging the regulator tree, today's linux-next build (x86_64
> > > allmodconfig) produced this warning:
> > > 
> > > drivers/mfd/rohm-bd718x7.c: In function 'bd718xx_i2c_probe':
> > > drivers/mfd/rohm-bd718x7.c:101:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > >   bd718xx->chip_type = (unsigned int)  
> > 
> > I am pretty sure the last patch version corrected this to
> > +       bd71837->chip_type = (unsigned int)(uintptr_t)
> > +                               of_device_get_match_data(&i2c->dev);
> > 
> > is it possible one of the earlier versions has accidentally been
> > applied? Should I create patch on top of the last regulator tree or what
> > is the simplest way fix this?
> 
> Sorry, this came from commit
> 
>   dd2be639f4a9 ("regulator/mfd: bd718xx: rename bd71837/bd71847 common instances")
> 
> which is later than the commit I noted.  In this later commit, this happens:
> 
> -	bd71837->chip_irq = i2c->irq;
> -	bd71837->chip_type = (unsigned int)(uintptr_t)
> +	bd718xx->chip_irq = i2c->irq;
> +	bd718xx->chip_type = (unsigned int)
>  				of_device_get_match_data(&i2c->dev);

Right. So looks like I am still the guilty one then. I've overwritten
the fix in this rename patch which followed the corrected initial
support patch. I guess sending incremental patch with fix to regulator
tree is correct way to go, right? I'll prepare one against Mark's branch
"origin/topic/bd718xx". Mark, please let me know if you want me to send
it or if I should do it on top of some other branch.

Br,
	Matti Vaittinen
