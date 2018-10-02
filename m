Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D41C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAD6206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dabWz0xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAD6206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeJBVu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:50:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43916 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeJBVu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:50:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so2634686wrt.10;
        Tue, 02 Oct 2018 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6IyQlIqfGRxzs1J2ybTgoUmk/7HvMABstEbHUuU/q5U=;
        b=dabWz0xqkmNrNNk5NZhg+2EDnYxP6xfne9/+yTWZEqebn5IKWuzpC1ckE8f2V1IkxE
         0ZnxovAgBraK2c9fn26WBWy0BAK0Rz121C2SHVHYClZphJEYl3OvplZ6G2gWk2sRpW/D
         ECqzVoKiVM1W9/uBDek0SgYF9cHYUjkcD5GuU6gviXbnsmEH9Z9bok5fEqiOIp69UmL+
         WbjxX4FVkR5h/8INKnVkBINp67/6Qo0rwXqIAqhkXEoBzZ3sa9aZogh/H03WuCWb6KQR
         J3Gz2omfnrNRpbrhvWKSg/uqlIEsc1M26dHjLgU/Qwm4P+ersCwoa2EqVRqvXD7kfOO0
         QsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6IyQlIqfGRxzs1J2ybTgoUmk/7HvMABstEbHUuU/q5U=;
        b=MYxnC1V7g99xniatjSgcrmJASPX/VzHFS66R4CWzRRyLunUUKZLStnAhXuB/vqdDem
         MoZ5IhuabATb1ZulM6tOOX/qU64dKRd8Q1ecHbNKIy97hHsIMu9tuTMDLExO9jLVGdeW
         gdb8DI7ic9Cwbih6ol68z227GbPDPDFY0+9L8FKTrACJXXksfekC6urSwMnwYPbOrFyu
         rRrtIZU4ceMQhN/BQP/lxkirN/BJsfXY3c/2JlSRUdZkrbtwco871wKHgX9CVN+dSvch
         GNpGfpg20P0Iqv/opG6Myxh3J5MPrSBmYdMzOYPUHwStTvb1ePah66XlGH0/aluvhE3z
         rzlQ==
X-Gm-Message-State: ABuFfojTRPK+EvSaelS75mnpGi8N+6z1uD03jm7naXDS1+fwZyOnurkW
        AeQ0G8Rqh32vVxpy/BYoJ0ODeQDLVGjLPA==
X-Google-Smtp-Source: ACcGV63jXZXu1LsCvJYvIqT9k0Vzqw5RZwQZtZ9ksvbEIM3jpmzRy019mXOkwqja6nOdukbfk6cACw==
X-Received: by 2002:a5d:4605:: with SMTP id t5-v6mr10291743wrq.52.1538492826283;
        Tue, 02 Oct 2018 08:07:06 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k7-v6sm15403595wmf.41.2018.10.02.08.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 08:07:05 -0700 (PDT)
Date:   Tue, 2 Oct 2018 08:07:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] scsi: mptfusion: Remove unnecessary parentheses and
 simplify null checks
Message-ID: <20181002150704.GA444@flashbox>
References: <20180915063645.31295-1-natechancellor@gmail.com>
 <CAK8P3a3PaWgieA0_HBJJ-FVeBO+iAdN8_kv5YUbpKURJ3gsoaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3PaWgieA0_HBJJ-FVeBO+iAdN8_kv5YUbpKURJ3gsoaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:58:21PM +0200, Arnd Bergmann wrote:
> On Sat, Sep 15, 2018 at 8:38 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> 
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/message/fusion/mptbase.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> > index dc1e43a02599..ba551d8dfba4 100644
> > --- a/drivers/message/fusion/mptbase.c
> > +++ b/drivers/message/fusion/mptbase.c
> > @@ -335,11 +335,11 @@ static int mpt_remove_dead_ioc_func(void *arg)
> >         MPT_ADAPTER *ioc = (MPT_ADAPTER *)arg;
> >         struct pci_dev *pdev;
> >
> > -       if ((ioc == NULL))
> > +       if (!ioc)
> >                 return -1;
> >
> >         pdev = ioc->pcidev;
> > -       if ((pdev == NULL))
> > +       if (!pdev)
> >                 return -1;
> >
> >         pci_stop_and_remove_bus_device_locked(pdev);
> > --
> 
> 
> The exact same code also exists in drivers/scsi/mpt3sas/. I had a similar
> patch for both drivers, but saw that yours now got merged for fusion.
> 
> If you don't mind, could you fix mpt3sas_base.c the same way?
> 
>      Arnd

Hi Arnd,

I did sent a patch for this a little bit later: https://lore.kernel.org/lkml/20180920201002.23979-1-natechancellor@gmail.com/

I am still waiting for it to be merged.

Thanks!
Nathan
