Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81679C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D89C20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txcpDc6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D89C20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeKJLYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:24:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43968 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeKJLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:24:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id g7-v6so1700158pfo.10;
        Fri, 09 Nov 2018 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tCiRbQTJFVhrW8I8wn7J528t71wWAbQnh0V1vMaAjJU=;
        b=txcpDc6JnzuzRGVzLByMFuDgOKqN5lhJ8beZ+7hKFdUGjrV0lerJGMD4jfJVlNOVS6
         3YzQy3jusasQTcORhdGuZZhQi/DRncQxVPTlxFEBaVahlqBhDFi67Xgmi1rM8UM44oK4
         CBaS/ytVMUqIJawTgHYFfNcTkMgCf7FXwp4YzKU7uwjiLu/GN1HZcVJAfodxgcOsk6wO
         AaKQoD1eJyYtfw9BCLD+QAeBEf3K+Kh7m7q8wgOsVZQAK4ulDzfZDlFevWPnQxmOasTe
         ip5T1t+7fYqW5JBlB3KFgN4VLbXxVhZrWBMCUeg904ZeuAIdfp7Ax6IqtFWry6Jik6pb
         tM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tCiRbQTJFVhrW8I8wn7J528t71wWAbQnh0V1vMaAjJU=;
        b=J+ihnkwHJCjVJgIZOCEC0iNjwD/1AA16Qbk24YFg9WO1RJfLYKvi0R6mSv7WVSa9If
         NqMwqay3fv/16SN0A4KSyaZ8rza8j+3RU79esVaAQ1RdzeBOOWV7V4SR08hldvQfvrbL
         p0OLczx6O8DdcmxlxrdFMu/ff61jgofRcfS5VFx+V3rjGSK/shmjuzjPTJcrPaDwfLOA
         uEyaEaQOiiRmiYrVePk9EuTV9WGGM96DywlpsIzlTQuhRwYbAQY/nhVMU/xPqj94x7kT
         O5jER4VCM3gH5lLN8SNBGsYtvAMPBGLGHLjskzgUIDQKamGJ78eULJKeMvCnuwVtGR5+
         dPTQ==
X-Gm-Message-State: AGRZ1gK0Sh/2+t4Ds5TrSs3CUdp01ppGCv4PZ7itAmlvdBC+5tCsuYMZ
        8+bmt4u7E0EU806j6JQWuCI=
X-Google-Smtp-Source: AJdET5fFe/KBuwDnHlLavNXNQbTEW7RvSYjF35/pgurN2DSj73YcjJF1AMfFSJ19cflUkuNsw1PcsA==
X-Received: by 2002:a63:441e:: with SMTP id r30mr9730217pga.128.1541814081439;
        Fri, 09 Nov 2018 17:41:21 -0800 (PST)
Received: from mail.google.com ([207.246.110.149])
        by smtp.gmail.com with ESMTPSA id r12sm2450350pgv.83.2018.11.09.17.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 17:41:20 -0800 (PST)
Date:   Sat, 10 Nov 2018 09:41:12 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Changbin Du <changbin.du@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
Message-ID: <20181110010708.d3nayrzuy5d3lrkd@mail.google.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-2-changbin.du@gmail.com>
 <20181028140911.21d49629@vmware.local.home>
 <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
 <20181102112728.GC14602@zn.tnic>
 <CAK7LNAQcdpU+_LOYQ8X+4K4sxd3D-+Z7k6BuBjUOJ9LR0j+zfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQcdpU+_LOYQ8X+4K4sxd3D-+Z7k6BuBjUOJ9LR0j+zfA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 01:27:29AM +0900, Masahiro Yamada wrote:
> On Fri, Nov 2, 2018 at 8:28 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Oct 29, 2018 at 10:04:46PM +0900, Masahiro Yamada wrote:
> > > On Mon, Oct 29, 2018 at 3:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Sun, 28 Oct 2018 13:09:42 +0000
> > > > Changbin Du <changbin.du@gmail.com> wrote:
> > > >
> > > > > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> > > > > So declare check_la57_support() as inline to make sure the code
> > > > > referring to level4_kernel_pgt is optimized out. This is a preparation
> > > > > for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> > > > >
> > > > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > >
> > > > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > >
> > > > -- Steve
> > > >
> > >
> > > Applied to linux-kbuild.
> >
> > Next time, before you route a patch through your tree, please get an x86
> > maintainer's ACK first.
> 
> 
> I changed my mind, and did not include this in my previous pull request
> because this series is causing many warnings.
>
Most of the new warnings are false warnings. Since this series didn't change any
code where the warnings happen. I'll make patches to make gcc happy.

> Now, it is aiming for v5.0-rc1
> 
> So, it is not too late.
> 
> If x86 maintainers issue Acked-by,
> I am happy to add it.
> 
> 
> 
> 
> > Thx.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > Good mailing practices for 400: avoid top-posting and trim the reply.
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
