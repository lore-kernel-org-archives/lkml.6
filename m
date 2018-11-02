Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E67C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8892E20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOxMcp0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8892E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbeKCESU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:18:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38631 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKCESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:18:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id q186-v6so2664962ljb.5;
        Fri, 02 Nov 2018 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EukwXm1V5NYg2ckA/hhEuwFZhmWjYxGuDHNjZCf6Ahg=;
        b=VOxMcp0ik+J7Bm1PEs/RqAr/L2JJJdGJtbwfTPNJiZp7go/s0xnKHCd3VtvDQf2Fp0
         8fr9qX2dhaYowxUTXtNbv1E0aplB9ENHwwdZrOHEM8K1t0iFbqiiJKzl9Zkx9PNPvRo5
         kCRhbAFcJMu2EbLqUSTY7IYRADWjLMeFJZNdso44yONHGJVLp3bXoj4yYB7aMFCGU3T6
         sarbO9P7Ijd9utUG5zYFcKi5C7aqSV0xCV0FAp8M+ZF/e8T1lowGXUbVIzIOenrWZX4D
         sdznmACPXWS2JNvNML67elV6SxRaAasslgcMh/iET+EC1x+sKqPSuGHQ6qvgCWlk7mUa
         j7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EukwXm1V5NYg2ckA/hhEuwFZhmWjYxGuDHNjZCf6Ahg=;
        b=N+3L+2hLJhvRneXtzllj3+yYSw+DrYmJrDRaUpKL/DAGr2LAQWga5lMtjknA4SYRf4
         t4c9oIhQnjfRZj6Bgw/K+ocIIM2reNU2bG7DGb6GLHhCZDfeL29K39nNgnMUr3lYjcwn
         L+sH0ZjyI1H/CIuSDfEoWMjXX1b+A77WHPzKmeFDdLZUS4eZcw2aVwl4LTcB5njDvm4y
         22JrJ1uaDBybfCks6WOLE0Pqka5uGxux7jxVNbf0BcdliaEtDOTe3aUmdsEDbnxR+af9
         tHZwfSk3g5HQPPD2bdgRbkPe8VAF2bSKpGhBRZPfcEE+yhBkbtiwpxMA29qJpnD8FI6q
         Ngvg==
X-Gm-Message-State: AGRZ1gIYK12rf2sfEp0VimjnD6cOIWLGcoFN6G5IqbxgYAhip1a8IldD
        o3v5vs9gYIrNcQKJULivDvYc90RiHYSA495oJrc=
X-Google-Smtp-Source: AJdET5efZfnvmtQ0Ir9hcl5RoFkc3uCAX/m4ytJu/ARaDTUyHkWtkebafE6aaSbg6vqPRg6r9DDgH7AIlfy+nypE3Sg=
X-Received: by 2002:a2e:2d01:: with SMTP id t1-v6mr7367016ljt.99.1541185798465;
 Fri, 02 Nov 2018 12:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181102152637.GA3105@hp-pavilion-15-notebook-pc-brajeswar>
 <20181102182905.3klrdw4dxapeoiib@tower> <CAFqt6zYmBFQ7gDJJkYAhPzPYyLGsDqOdr8ctXmYbd7e9sv75xg@mail.gmail.com>
 <CAEdQ38Fh99QmusGbEBi9TjUKQbQDX90pEaUC5Y=s-BL=RQ3o_A@mail.gmail.com>
In-Reply-To: <CAEdQ38Fh99QmusGbEBi9TjUKQbQDX90pEaUC5Y=s-BL=RQ3o_A@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 3 Nov 2018 00:43:18 +0530
Message-ID: <CAFqt6zboDwTNUkvhRi2s=LUnqhvXoHtGQFkrUrW+2bCEb=5RRQ@mail.gmail.com>
Subject: Re: [PATCH] include/asm/cmpxchg.h: Remove duplicate header
To:     Matt Turner <mattst88@gmail.com>
Cc:     mcree@orcon.net.nz, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        rth@twiddle.net, ink@jurassic.park.msu.ru, parri.andrea@gmail.com,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 12:31 AM Matt Turner <mattst88@gmail.com> wrote:
>
> On Fri, Nov 2, 2018 at 11:55 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > We run the static analyser "make includecheck" which list out files where
> > duplicate headers can be removed and based on that we thought to remove
> > from this file. Didn't understood about the existence of second include ??
>
>
> #define ____xchg(type, args...)         __xchg ## type ## _local(args)
> #define ____cmpxchg(type, args...)      __cmpxchg ## type ## _local(args)
> #include <asm/xchg.h>
> [snip]
> #undef ____xchg
> #undef ____cmpxchg
> #define ____xchg(type, args...)         __xchg ##type(args)
> #define ____cmpxchg(type, args...)      __cmpxchg ##type(args)
> #include <asm/xchg.h>
>
> asm/xchg.h has a comment at the top that says
>
> /*
>  * xchg/xchg_local and cmpxchg/cmpxchg_local share the same code
>  * except that local version do not have the expensive memory barrier.
>  * So this file is included twice from asm/cmpxchg.h.
>  */

Thanks Matt. Sorry for the noise.
Is there any way to exclude it from static analyser that someone else will
not do the same mistake in future ?
