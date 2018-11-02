Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178FAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6CF20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMeVSXft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6CF20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeKCEXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:23:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33028 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKCEXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:23:24 -0400
Received: by mail-it1-f194.google.com with SMTP id p11-v6so2173487itf.0;
        Fri, 02 Nov 2018 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDk1X3K4DSQkY1TL+z8S6gHQ4fsyb/pjGxgKFSecu0A=;
        b=LMeVSXftNyh8+Fn/zG5SQdXRbewBOYgyQkFtP9dcO4B3MmWtyXgshkHyOcJ0mFnoYG
         FpdlXLbA33kAJGyztxPolkiWtCNPuYlKYLWs8s1Db0HRiicPCuM07hqiCcSoeRqGh/17
         O9k3g3P+WhtnybTu9xsvmUKmhJaQW7uuwf7/5lIi0ycVOQLz6iFyKebdhmGlONZBeDCN
         LGKFoX0TtP17pFPYIns5CQCNPI2ibJUIPGUKTT5XPeATfRz0T1dyyB44khowFbegJ+d0
         cXohLzJdWZC28VWpUp+aWYL40T1t7HJjZfY/jB860zmAYstP/cuLTGr0eMs22QFQNQD3
         MPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDk1X3K4DSQkY1TL+z8S6gHQ4fsyb/pjGxgKFSecu0A=;
        b=KSu7bggnNBmGBdYuwz5ySlJrxJ66UQ9LtG51gpv4W6ChVRdkSdWqfW+ndWHtsmas3f
         FiBK1tlZ8WwIcMZe+NgVsUlM5Y7Mk2GQQvUeNZi7fwgBjm8tKxJrWwii4qKraW/7r14b
         9366FGHXicwFOAaJ0NmZhqoY7HG0bhhqEt9m5R0i422OH3AUx71uTC8n7iY9ugQsAmq+
         Mp62rPA04D42sA7wLYfTgKRftj2JBKRCeYyPPaByzTX4RPSSzRMqqvBP2Jc9EYxOkwpw
         lCA6bou4hD3ni/VOnw9+MqCbIwYXs+6AzqSV/m7yU1wxamSPfsmH7pU69XEZMPEoJgi+
         mOXQ==
X-Gm-Message-State: AGRZ1gLiGuBJfpaaVe9Q+gVYamp4icI5kNmx91zjGoDwUGSca1YNvOXD
        VidlOloUVeOZFr6LTfUAbaqJwJ8tO7akbKgzRZ4=
X-Google-Smtp-Source: AJdET5cnhmAIYIFaDi8jsm2zXnxtXUwBFRcmi7NGz6IP6y84fOQV6pXDWZl9dGxPEbT3jTUJPb/ueSsQ39jBksKvNYQ=
X-Received: by 2002:a24:16cb:: with SMTP id a194-v6mr234586ita.40.1541186101294;
 Fri, 02 Nov 2018 12:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181102152637.GA3105@hp-pavilion-15-notebook-pc-brajeswar>
 <20181102182905.3klrdw4dxapeoiib@tower> <CAFqt6zYmBFQ7gDJJkYAhPzPYyLGsDqOdr8ctXmYbd7e9sv75xg@mail.gmail.com>
 <CAEdQ38Fh99QmusGbEBi9TjUKQbQDX90pEaUC5Y=s-BL=RQ3o_A@mail.gmail.com> <CAFqt6zboDwTNUkvhRi2s=LUnqhvXoHtGQFkrUrW+2bCEb=5RRQ@mail.gmail.com>
In-Reply-To: <CAFqt6zboDwTNUkvhRi2s=LUnqhvXoHtGQFkrUrW+2bCEb=5RRQ@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 2 Nov 2018 12:14:50 -0700
Message-ID: <CAEdQ38FNiY78zXMtqCUCjiGYBfjHXnDTQia3a62hJ_6UG3O+gw@mail.gmail.com>
Subject: Re: [PATCH] include/asm/cmpxchg.h: Remove duplicate header
To:     jrdr.linux@gmail.com
Cc:     Michael Cree <mcree@orcon.net.nz>, brajeswar.linux@gmail.com,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabyasachi.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 12:09 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Sat, Nov 3, 2018 at 12:31 AM Matt Turner <mattst88@gmail.com> wrote:
> >
> > On Fri, Nov 2, 2018 at 11:55 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > > We run the static analyser "make includecheck" which list out files where
> > > duplicate headers can be removed and based on that we thought to remove
> > > from this file. Didn't understood about the existence of second include ??
> >
> >
> > #define ____xchg(type, args...)         __xchg ## type ## _local(args)
> > #define ____cmpxchg(type, args...)      __cmpxchg ## type ## _local(args)
> > #include <asm/xchg.h>
> > [snip]
> > #undef ____xchg
> > #undef ____cmpxchg
> > #define ____xchg(type, args...)         __xchg ##type(args)
> > #define ____cmpxchg(type, args...)      __cmpxchg ##type(args)
> > #include <asm/xchg.h>
> >
> > asm/xchg.h has a comment at the top that says
> >
> > /*
> >  * xchg/xchg_local and cmpxchg/cmpxchg_local share the same code
> >  * except that local version do not have the expensive memory barrier.
> >  * So this file is included twice from asm/cmpxchg.h.
> >  */
>
> Thanks Matt. Sorry for the noise.
> Is there any way to exclude it from static analyser that someone else will
> not do the same mistake in future ?

Since this is not an uncommon pattern in C, I think any static
analysis tool that attempts to find duplicate includes should attempt
to recognize such a pattern.

That, or humans should review the output of their static analysis
tools. Or you could try to compile the patches produced. I think any
of those would have caught the problem with the patch.
