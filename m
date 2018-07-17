Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AEC20864
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbQMKaBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AEC20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeGQHGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:06:03 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44187 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeGQHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:06:03 -0400
Received: by mail-ua0-f193.google.com with SMTP id k25-v6so17487037uao.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ua1s/J5nxP9BcUF/ip9hPLPY5Pq/lkBGj6HbKD6A1Fw=;
        b=UbQMKaBLgdXa4eUh2y9i8LIeRbBtc41rKvozLrZfcH8muICzAftuH9Z4TxhzPDQWKw
         I7kFhIXKkzEzXNZUmagnVhhIfS8juQNofVhcUdRsHJZpWOSADSY3AEoHbXd5CIZF2e5T
         78b2RfB0SSOcz3V5dkDd5JbWMiYYnQSQ63JaxkF45Un446Uezu6XgpNQuQjZ/PHSahC4
         f/2Uc7+TooSPvg+1xwk/iUwoVJMgWwyLGLxAzTwV/fLocMfgla4jWkp1yH//7EPSSHZG
         sNzleetWzN5i0Jct+wc3SKT2CL/D4P3gqEcRdSHM7BXZ2r8CxIDSBP8CECMJHfKiRUSJ
         9fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Ua1s/J5nxP9BcUF/ip9hPLPY5Pq/lkBGj6HbKD6A1Fw=;
        b=i8pTOkd6QY8wxYKC04Fyw6DrosEDITH62OcAPXThtembfpaR8SYYfquN94iZsqvrS3
         5MrYKA1P/CiHRAdV3ud/RJWEfu60np2TmW8VdwGqzetqK1VhhEDEv+zHg/DWJvjorZQw
         sq5mHyeJqtey+g72nj/MvQuYIju8h6r04Ospycqv3nXJlt2t0YJm1QuF0UIwOs/1+McD
         LZuH81xL0p0hjJmllvQNu+onVCpFWuAdLFskRwcC96UtV5YVXhX0xN/2BUx+tLF3YOCE
         icBC790NCRBBcQpmyBWg4/DmesLxVprTwTLXD2L9RICMSVTbwnhvSK7gZ2Reb6fw9ldZ
         UpgA==
X-Gm-Message-State: AOUpUlE2Dev0BMBXv2wk87O/mMsJZ8TRUaVFHEQ3vCqwQ+x1606KzazR
        xGZtD4gG+FjPwulwtAa2kEWHPIK39jhGzb9XSTc=
X-Google-Smtp-Source: AAOMgpcWFGgbon4tk+t32ENpjIzE5XmkgOpxvA6tcR7m6Y35dU/wPBAVpIn02RYBlvp9+L3UVRKMr4rnd0zqfrP1uaQ=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr218185uad.94.1531809302226;
 Mon, 16 Jul 2018 23:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531124135.git.greentime@andestech.com>
In-Reply-To: <cover.1531124135.git.greentime@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 17 Jul 2018 14:34:26 +0800
Message-ID: <CAEbi=3fi9dZCzZjMFDXQGPNjpbT9+PP0WDUNf2e1mFtXLP0Omg@mail.gmail.com>
Subject: Re: [GIT PULL] nds32 fixes for 4.18
To:     Greentime <greentime@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
Greentime Hu <green.hu@gmail.com> =E6=96=BC 2018=E5=B9=B47=E6=9C=889=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab=
40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the Git repository at:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.=
git tags/nds32-for-linus-4.18
>
> for you to fetch changes up to 987553894f0ce8c1d83578136603a89009f42d35:
>
>   nds32: fix build error "relocation truncated to fit: R_NDS32_25_PCREL_R=
ELA" when make allyesconfig (2018-07-05 16:13:47 +0800)
>
> ----------------------------------------------------------------
> nds32 patches for 4.18
>
> Here is the nds32 patch set based on 4.18-rc1.
> Contained in here are the bug fixes and building error fixes for nds32.
>
> These are the LTP20170427 testing results.
>
> Total Tests: 1902
> Total Skipped Tests: 593
> Total Failures: 418
> Kernel Version: 4.18.0-rc1-00006-g987553894f0c-dirty
> Machine Architecture: nds32
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> ----------------------------------------------------------------
>
> Greentime Hu (4):
>   nds32: To implement these icache invalidation APIs since nds32 cores
>     don't snoop data cache. This issue is found by Guo Ren. Based on the
>     Documentation/core-api/cachetlb.rst and it says:
>   nds32: Fix the dts pointer is not passed correctly issue.
>   nds32: To simplify the implementation of update_mmu_cache()
>   nds32: fix build error "relocation truncated to fit:
>     R_NDS32_25_PCREL_RELA" when make allyesconfig
>
> Guenter Roeck (1):
>   nds32: Fix build error caused by configuration flag rename
>
> Luc Van Oostenryck (1):
>   nds32: define __NDS32_E[BL]__ for sparse
>
>  arch/nds32/Kconfig                  |  12 ++---
>  arch/nds32/Makefile                 |   2 +
>  arch/nds32/include/asm/cacheflush.h |   9 +++-
>  arch/nds32/include/asm/futex.h      |   2 +-
>  arch/nds32/kernel/setup.c           |   3 +-
>  arch/nds32/mm/cacheflush.c          | 100 +++++++++++++++---------------=
------
>  6 files changed, 58 insertions(+), 70 deletions(-)
>

Ping.

Did this please-pull get lost or is there another reason that prevents
the upstream integration?

Thank you. :)
