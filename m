Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD37C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7AB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka6ViaS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7AB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeJOIdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:33:36 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39153 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeJOIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:33:35 -0400
Received: by mail-yb1-f194.google.com with SMTP id g15-v6so6890077ybf.6;
        Sun, 14 Oct 2018 17:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zaE6pRI2A+cX6QpcSyvFIqm7fnwI+aswxan+a131+Lw=;
        b=ka6ViaS0U2G8v6rI0Q08kHxdckUu62ifkJsI+xeHaNjHhVTLWD4tziqFQ2uv9NR+kE
         EvUUpCNjOa9njaT+8wq3mAWtY8MMbkm60e3ZzCo6/ldT2363Z0TewokRCJAPNb2wy+92
         hbZo/2GaxoVrnSj6cV0NHsCdMs3EhRlshdLjXOJkcshwPe0Ww6ip94iFibYr5qOr4b9s
         g4YKHdwx5Z4B2n48YbGqikMY71HmNNSir+JH1DMU6xn1Q+PBqwxwZZrFV3Czu1cOmL7x
         OlmPt0yUAUGSFHL1az8Vb1sF8wHyEXvXUCsfCBhdYLm0rKwy/7cvgeamy7BY3kTkjp5O
         5dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zaE6pRI2A+cX6QpcSyvFIqm7fnwI+aswxan+a131+Lw=;
        b=O/eEbam1lIjMcDWcVNAGQFoLReQQmz7/rVKhCFOcaKLKEfxZPqQAKCnVCMwW3Nmz91
         bIBuPA/d0PXGR/EGo4Rp2kLuHASnLppvAKPr8E2f1uU1cmxUUL2vSzFl/sLdVGPFRvdE
         ggkxuMS8NEBth4dg2Y75+3UoIsXLwLNS6rPrdAo/P9Ozc1hVznn1fTh8Rc59UyUxR8sj
         joAATraxCRSQMo7OrWS8aXq0FhFkVO0z15bKk+wnG0hi/c9ovQBVlyt+QTxjvcLPmFMC
         Uaquac4MYlEBjbodrRZ/u4CO0lvX8jLQRoDn3EHVHDQBfspLAqbpSPgxTh30LFfYDaf4
         6+zA==
X-Gm-Message-State: ABuFfoiXpLhV9jCdsu9PrbpBlQcZyVEURBDQeRgldkjEUM03L+hHVWdF
        YZj4qJ7MO96WOWuouIUFTA==
X-Google-Smtp-Source: ACcGV60JZwt0of3B/Em88mgCnARQS+zT8SFoq3cXwHNd5bVAS+CD2vh8p9vcIWWfKyepwUfSpw0f7g==
X-Received: by 2002:a25:83cb:: with SMTP id v11-v6mr7736216ybm.477.1539564642371;
        Sun, 14 Oct 2018 17:50:42 -0700 (PDT)
Received: from gabell (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id b71-v6sm2440351ywa.48.2018.10.14.17.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 17:50:42 -0700 (PDT)
Date:   Sun, 14 Oct 2018 20:50:35 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181015005035.z3xym6nx43hogdge@gabell>
References: <alpine.DEB.2.21.1810101113070.10278@nanos.tec.linutronix.de>
 <20181010091923.GC5533@zn.tnic>
 <20181010093057.GA22088@MiWiFi-R3L-srv>
 <20181010194443.sgdvplwdnltshwwi@gabell>
 <20181011002955.GJ25297@MiWiFi-R3L-srv>
 <20181011055154.GB6667@localhost.localdomain>
 <20181013201958.zfzv5ahhe3xz7bwi@gabell>
 <20181013203429.GE31650@zn.tnic>
 <20181013214550.ag5qzokhkrkwnzsy@gabell>
 <20181013220541.GI31650@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013220541.GI31650@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 12:05:41AM +0200, Borislav Petkov wrote:
> On Sat, Oct 13, 2018 at 05:45:51PM -0400, Masayoshi Mizuma wrote:
> > Yes, but I think we need to arrange the Chao's SRAT parsing to be used
> > from kernel_randomize_memory() because Chao's approach needs the SRAT
> > parsing before extract kernel and the padding size calculation needs
> > the parsing in start_kernel(), so they are living in different life
> > cycle and space.
> 
> Or you would like to pass some info from the compressed kernel to kernel
> proper?
> 
> For example, something like the passing in add_e820ext() and the consumtion
> in parse_setup_data():
> 
>                 switch (data_type) {
>                 case SETUP_E820_EXT:
>                         e820__memory_setup_extended(pa_data, data_len);
> 
> So info you need for your padding gets collected in
> arch/x86/boot/compressed/acpitb.c and you consume it in
> kernel_randomize_memory()?
> 
> Would that work?

It's nice idea! Thank you so much!

- Masa
