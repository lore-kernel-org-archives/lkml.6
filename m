Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A219C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5D22084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7qyfqoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5D22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbeKCEDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46721 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCEDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id o2-v6so1994286lfl.13;
        Fri, 02 Nov 2018 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LyxylQsEOAKO9YnrpN6j8Cv17Xvxh0WHRz+EZRQzaJA=;
        b=X7qyfqoqkp+N7mxKcSrgRg9XsAAOyEXsx/+dUdRFnIcRu8D4/jClPFxe3eDrt3L9/M
         VTsknkbeAzuLsVLMhNhh8Lei6M8UQEV58CLPlOOuTQpHLPyDtIPBwFAOPMaw5RqqunoJ
         nTbij41a5EEvZcuUziWtP2Dk7u/2mh00w24W3J/km13RykEGSQKqE+fsImQ3efyIb11e
         zyMn+EO6vOM2nzTgp3SRRBddUE3yrUUB88njAAnXoFowZT/Ozu5CLAyLiOwZ40Vg4T4F
         PZkXJ5A53YlBSTZT3T5UIyqAlS2jm2sC/0jsW2Pa38ekphLBYkSU5lL5U9EvSNZRChSA
         17EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LyxylQsEOAKO9YnrpN6j8Cv17Xvxh0WHRz+EZRQzaJA=;
        b=Lt4EaOXbFV5NRQu41WcaUy+QP7PSKYpzytPs75PS9ssZjf+dmoIYjiQn/KPDHshZcP
         hM7n0jpja/R/k5KcTh0FxNYGuw/ostLSik94yEjynaR8qmNPMacaoM6vRfFMuc+k1hfW
         n251CfpbxzCC5bHCPv0tlKXYoiW3x2BC8BUXL1gu90S6hUPQ3pWwiQ7X/lMOaNgQQ/1L
         OGKMq8oM2pnKn87VkVBwjk1Rg+DTm/3uxpAGb4Je4mA5tljD/ppx7NH94aPU7CwcBFLX
         kEscw/QVCndVFxlSoLgCIlv0r8SDHHf9yqJxvlBrMcFq7oc8fiDYuZdS55RyDAwjy+qJ
         l9yQ==
X-Gm-Message-State: AGRZ1gIZW0NJ81tGUn/9OPJvfrkEz42DkVOTchxl0uNHVdR/JPJjBBPT
        yiyFhxmNmWodr4klCXA8kicB7+YYSStmOAYyJcM=
X-Google-Smtp-Source: AJdET5caotc+edgf84QFUPb3V9PtOhceBB9FIPO/iMRbCUbGRsD63A8vgbZqy4x6RVfYITazkeczKMN85EIyQtbB+BA=
X-Received: by 2002:a19:24c6:: with SMTP id k189mr7810182lfk.77.1541184921233;
 Fri, 02 Nov 2018 11:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181102152637.GA3105@hp-pavilion-15-notebook-pc-brajeswar> <20181102182905.3klrdw4dxapeoiib@tower>
In-Reply-To: <20181102182905.3klrdw4dxapeoiib@tower>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 3 Nov 2018 00:28:41 +0530
Message-ID: <CAFqt6zYmBFQ7gDJJkYAhPzPYyLGsDqOdr8ctXmYbd7e9sv75xg@mail.gmail.com>
Subject: Re: [PATCH] include/asm/cmpxchg.h: Remove duplicate header
To:     mcree@orcon.net.nz, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        rth@twiddle.net, ink@jurassic.park.msu.ru,
        Matt Turner <mattst88@gmail.com>, parri.andrea@gmail.com,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Nov 2, 2018 at 11:59 PM Michael Cree <mcree@orcon.net.nz> wrote:
>
> On Fri, Nov 02, 2018 at 08:56:37PM +0530, Brajeswar Ghosh wrote:
> > Remove asm/xchg.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > ---
> >  arch/alpha/include/asm/cmpxchg.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> > index 6c7c39452471..bcbdac0744f9 100644
> > --- a/arch/alpha/include/asm/cmpxchg.h
> > +++ b/arch/alpha/include/asm/cmpxchg.h
> > @@ -36,7 +36,6 @@
> >  #undef ____cmpxchg
> >  #define ____xchg(type, args...)              __xchg ##type(args)
> >  #define ____cmpxchg(type, args...)   __cmpxchg ##type(args)
> > -#include <asm/xchg.h>
>
> It's amazing the number of times we get a patch to remove that.
>
> Instead of just automatically removing a second include of a
> header file, why don't you take a closer look to see what it
> actually does?

We run the static analyser "make includecheck" which list out files where
duplicate headers can be removed and based on that we thought to remove
from this file. Didn't understood about the existence of second include ??
