Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B260C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C58204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p00TYBXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C58204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756492AbeFOS7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:59:12 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41307 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756352AbeFOS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:59:11 -0400
Received: by mail-qk0-f195.google.com with SMTP id w23-v6so6195279qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y0FwBIRgtoaw6vAwHI4XCJdkasOY/Dg0pHp87eMgVO8=;
        b=p00TYBXXI4VdZaLzPR0g0Kv6zVAtBzjTl3KJk7RqVI5WalJjIDO7RGrXG5PB2/X2Wa
         VBeAaKtucMRGze0NZ9Nt8PmzBEeL0hLVhS4SiZ0bTaFau70vTWoX9UOUEX4OulC357R3
         BJVaCHEGtOKIZHwAKafY+7oFGKqVgfwmDHza32DET40wTQXTyqlQ4r49UFPDvljge8hp
         /MyeDWskbkJyKAIiY5TP8HLDbQCdgH2XwE76K5eci6+nSPcN69aiQfZFoFiapj05pKw8
         u+4nhmLfxSc1fVNJc9nI4g62wwTXkB/ANlanJH47mj67/QmS1fFo6234SyUxjvdG6jS7
         yu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y0FwBIRgtoaw6vAwHI4XCJdkasOY/Dg0pHp87eMgVO8=;
        b=KdWHZSG3ifE+wEGRzPTRdUFhJXgOz6ije+8Pb74a9PME/OUUMyUoYgFwBaHonHs4SO
         BwPW/QNkUTh9kmvsAwBJBogEBGF6yn64hKEUuNbQgxodSYfwQ51CtuAUuK7Xwt/A7wVa
         qn92hFOgx/TLOOAcrZncMAlLivYmGlUyPfH0jVm5Pdl5EEcp3o7zGHAsafyDM10lssfM
         7h2L8npMkie2dA/PGNuNVONz0z3yCsCq5bh+sZo+4bYoJgjYGJstTEfY6kyAxzOsMbK9
         RrjpAv7Q0ihUSbp4msdWvVeDj59tXiVMzW9U1MN4eHZlmqokeLb3ErWSwq+PysGl7CkM
         kGDg==
X-Gm-Message-State: APt69E3hVuO5oRtNky1ex+qPk043ZOGu1++ZqBIe7DQ+PxmSSJCKl9Rx
        D9TJdpNnfMqzrsqyVoQ881hp2VC9rE82mSN9VPW+OA==
X-Google-Smtp-Source: ADUXVKJghMufVJpJoR/Z/krEwsAHiI8lvlrscwRLev81uN1W9/1d3MAix5nKG+OY2pSwyqA5t3Y5RNacTZGeqzm6FCs=
X-Received: by 2002:a37:d78c:: with SMTP id t12-v6mr2428641qkt.45.1529089150815;
 Fri, 15 Jun 2018 11:59:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7190:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 11:59:10
 -0700 (PDT)
In-Reply-To: <20180606194144.16990-1-malat@debian.org>
References: <20180606194144.16990-1-malat@debian.org>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Fri, 15 Jun 2018 11:59:10 -0700
Message-ID: <CA+8MBbKj4A5kh=hE0vcadzD+=cEAFY7OCWFCzvubu6cWULCJ0A@mail.gmail.com>
Subject: Re: [PATCH] mm/memblock: add missing include <linux/bootmem.h>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 12:41 PM, Mathieu Malaterre <malat@debian.org> wrote=
:
> Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> introduced two new function definitions:
>   =E2=80=98memblock_virt_alloc_try_nid_nopanic=E2=80=99
> and
>   =E2=80=98memblock_virt_alloc_try_nid=E2=80=99.
> Commit ea1f5f3712af ("mm: define memblock_virt_alloc_try_nid_raw")
> introduced the following function definition:
>   =E2=80=98memblock_virt_alloc_try_nid_raw=E2=80=99
>
> This commit adds an includeof header file <linux/bootmem.h> to provide th=
e
> missing function prototypes. Silence the following gcc warning (W=3D1):
>
>   mm/memblock.c:1334:15: warning: no previous prototype for =E2=80=98memb=
lock_virt_alloc_try_nid_raw=E2=80=99 [-Wmissing-prototypes]
>   mm/memblock.c:1371:15: warning: no previous prototype for =E2=80=98memb=
lock_virt_alloc_try_nid_nopanic=E2=80=99 [-Wmissing-prototypes]
>   mm/memblock.c:1407:15: warning: no previous prototype for =E2=80=98memb=
lock_virt_alloc_try_nid=E2=80=99 [-Wmissing-prototypes]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Sadly that breaks ia64 build:

  CC      mm/memblock.o
mm/memblock.c:1340: error: redefinition of =E2=80=98memblock_virt_alloc_try=
_nid_raw=E2=80=99
./include/linux/bootmem.h:335: error: previous definition of
=E2=80=98memblock_virt_alloc_try_nid_raw=E2=80=99 was here
mm/memblock.c:1377: error: redefinition of =E2=80=98memblock_virt_alloc_try=
_nid_nopanic=E2=80=99
./include/linux/bootmem.h:343: error: previous definition of
=E2=80=98memblock_virt_alloc_try_nid_nopanic=E2=80=99 was here
mm/memblock.c:1413: error: redefinition of =E2=80=98memblock_virt_alloc_try=
_nid=E2=80=99
./include/linux/bootmem.h:327: error: previous definition of
=E2=80=98memblock_virt_alloc_try_nid=E2=80=99 was here
make[1]: *** [mm/memblock.o] Error 1
make: *** [mm/memblock.o] Error 2

-Tony
