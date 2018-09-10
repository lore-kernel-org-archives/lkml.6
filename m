Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BAFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C1D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV/xj+nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C1D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbeIJSuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:50:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50334 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIJSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:50:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so21693521wmc.0;
        Mon, 10 Sep 2018 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UpLeN29PCvXtmZBhbfJwLGowpL6bG55hTlstL2L/45s=;
        b=WV/xj+nCGMB0/rzia22Vj8LgoRytE1c1gd2FmLKKH0MJZ8p/RL0P89cyBjrF5N4y7j
         O5UX9aVku30QmQyWpJG6oQ5wM7R/TUsKK4gL2MG6Tbhe686kAzNnKZOJSr2UQjmw5m97
         QJU5kW3+wa+REYOHw/HqlEWsnjw5P8SEUBUy3KMdNpuor5anw57fnukarxBMVMS3UxKQ
         VHcQLzVhNPaokIR3sou6+a5KC1rOvtaDpZRCUKw8qTisC3mo+IL/OD5odgHJySY42UVE
         jxSePf0ijsfg6z94Xy3a7wPF5VGPbZ3dalDJL/SzpME4QHM/LUTnVku0fzwLVqeae1xe
         6jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UpLeN29PCvXtmZBhbfJwLGowpL6bG55hTlstL2L/45s=;
        b=fuBVq35lbR3itiSrvMYDZ+eHm/zt8UJYGq2glsRh7Hx7VBvNz8nwWXtk0PTqaNKRcB
         2xYU4AXtsbOSaBrdEMnICX2PoL9+iR4MDeDLZ1tomPTyea7pLrx6aNILFZIva28oxn5f
         aU/z2Pykuie8cOEPFTM6ilrUAkUK5NywU2pr87G0dG893DJMdiCHam+/rP8KDFn5M584
         /PqO9JOrDve83FbQu3ceF0fgZl89W39jDibMHVesq7Ykf2EAuE3skv+99tsQdkmJZFNh
         wylvF0/7WTmHZ3A8zVv4bgihKOqiyKVQHb6wSkgM1iK80pKTpxzaE6MgXsFC7Nq9e2rB
         klEg==
X-Gm-Message-State: APzg51A6v8oyb8dcWY/P9Mr0fXzhIdfAQSVcH3MDHn6fPoq4NVOWJFst
        IMb6LZOJgPK88+x8uR4CDzw=
X-Google-Smtp-Source: ANB0VdYiURsRAwk9qmwxR26/LUhCT+ECGbT9r0Q4SUEWvm+++l96nTHbYeg4EaTFVb0rs6eoEgu7Gw==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr852626wmo.60.1536587767862;
        Mon, 10 Sep 2018 06:56:07 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:81e:af75:e036:d35f])
        by smtp.gmail.com with ESMTPSA id l7-v6sm19248213wrt.67.2018.09.10.06.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 06:56:07 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:56:05 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparse@vger.kernel.org, sparse@chrisli.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Message-ID: <20180910135604.j2phe7r3k5vs6cik@ltop.local>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
 <20180910092835.v5nex5nzfgtl475m@ltop.local>
 <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
 <20180910113448.dxnfvznyimtj3tkv@ltop.local>
 <9409138a-dc14-2b12-edc0-cfa0b471da6e@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9409138a-dc14-2b12-edc0-cfa0b471da6e@c-s.fr>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 01:19:07PM +0000, Christophe Leroy wrote:
> 
> 
> On 09/10/2018 11:34 AM, Luc Van Oostenryck wrote:
> > On Mon, Sep 10, 2018 at 09:56:33AM +0000, Christophe Leroy wrote:
> > > 
> > > # export REAL_CC=ppc-linux-gcc
> > > # make CHECK="cgcc -target=ppc -D_CALL_ELF=2 -D__GCC__=5
> > > -D__GCC_MINOR__=4" C=2 arch/powerpc/kernel/process.o
> > > scripts/kconfig/conf  --syncconfig Kconfig
> > > #
> > > # configuration written to .config
> > > #
> > >    UPD     include/config/kernel.release
> > >    UPD     include/generated/utsrelease.h
> > >    CC      kernel/bounds.s
> > >    CC      arch/powerpc/kernel/asm-offsets.s
> > >    CALL    scripts/checksyscalls.sh
> > >    CHECK   scripts/mod/empty.c
> > > Can't exec "/bin/sh": Argument list too long at /usr/local/bin/cgcc line 86.
> > > make[2]: *** [scripts/mod/empty.o] Error 1
> > > make[1]: *** [scripts/mod] Error 2
> > > make: *** [scripts] Error 2
> > 
> > OK. Clearly nobody has ever used it so :(
> > There is an infinite loop because cgcc use the env var CHECK
> > to call sparse while kbuild use CHECK to call cgcc here.
> > 
> > The following seems to work here.
> > $ export REAL_CC=ppc-linux-gcc
> > $ make CHECK="CHECK=sparse cgcc -target=ppc ...
> 
> Not yet ...
> 
> [root@pc16082vm linux-powerpc]# export REAL_CC=ppc-linux-gcc
> [root@pc16082vm linux-powerpc]# make CHECK="CHECK=sparse cgcc
> -target=ppc -D_CALL_ELF=2 -D__GNUC__=5 -D__GNUC_MINOR__=4" C=2
> arch/powerpc/kernel/process.o
>   CALL    scripts/checksyscalls.sh
>   CHECK   scripts/mod/empty.c
> <command-line>:0:0: warning: "__STDC__" redefined
> <built-in>: note: this is the location of the previous definition
> /opt/cldk-1.4.0/lib/gcc/ppc-linux/5.4.0/../../../../ppc-linux/lib/crt1.o:(.rodata+0x4):
> undefined reference to `main'
> collect2: error: ld returned 1 exit status
> make[2]: *** [scripts/mod/empty.o] Error 1
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2

OK. Using cgcc creates more problems that it solves and this file
scripts/mod/empty.c is weird.
Dropping cgcc and simply giving the GCC version to sparse works for
me here (the needed defines are given by arch/powerpc/Makefile) but
for sure I don't have the same environment as you have:
  $ make CHECK="sparse -D__GNUC__=5 -D__GNUC_MINOR__=4" ...

Bonne chance,
-- Luc
