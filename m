Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E120920684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E120920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJBM6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:58:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34619 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBM6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:58:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id y10-v6so554407lfj.1;
        Mon, 01 Oct 2018 23:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbsAm146G5mKWeBrijisff13oCUc8g3RKcOMJBHt0EI=;
        b=la4ufFCA8lLMZzUAkrR9V0IjRShZsZxVR5BmPg+rwxl/xqYr5eWTRrS4n1SPH9WXK9
         sKq9HauSCfDPo9G/cvkprcqVDvTiGlVDE3f3G3f45lDFybYry5t/SKCuOYLRb+Ytc4Jw
         O1WJCMdaWL/zY/6owGcp8gPCihlh+rcGAU5ban2lEAiOuJKASr1NX3RVVIkq8rWJFwFM
         B5NmRwfI5HjvvqxuT9V4/GkqUSGz9cihJlT2+h0MyYk6dwuBdhlQ78hBFexTm2LKqxTr
         9h2N9ELm5dPBFgsurLcbNBbj821M00BOu2W492X5uzcMPWDnW4CFMzBMI9w+gNffDNjj
         fq3w==
X-Gm-Message-State: ABuFfoijxlcgv9Ezwen6bsrw7Ldn0SD90tFmNhn2RoPcJHy7HTfBuxsA
        P/9f3KjEzZmBLO7MQ3i1C40=
X-Google-Smtp-Source: ACcGV6320ghLsUpCHznefSYujraoKG8SjKnGL/3CF350kxOIKwvdEdPPAzeZ+nvgwKNWT+k1pzoDOQ==
X-Received: by 2002:a19:c20e:: with SMTP id l14-v6mr7128788lfc.113.1538461007899;
        Mon, 01 Oct 2018 23:16:47 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id n3-v6sm2994992lfi.96.2018.10.01.23.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 23:16:47 -0700 (PDT)
Date:   Tue, 2 Oct 2018 09:16:44 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the regulator tree
Message-ID: <20181002061644.GC9389@localhost.localdomain>
References: <20181002130748.61e33ad1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002130748.61e33ad1@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

On Tue, Oct 02, 2018 at 01:07:48PM +1000, Stephen Rothwell wrote:
> After merging the regulator tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/mfd/rohm-bd718x7.c: In function 'bd718xx_i2c_probe':
> drivers/mfd/rohm-bd718x7.c:101:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   bd718xx->chip_type = (unsigned int)

I am pretty sure the last patch version corrected this to
+       bd71837->chip_type = (unsigned int)(uintptr_t)
+                               of_device_get_match_data(&i2c->dev);

is it possible one of the earlier versions has accidentally been
applied? Should I create patch on top of the last regulator tree or what
is the simplest way fix this?

Br,
	Matti Vaittinen

