Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14435C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA21420C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VaVDjUNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA21420C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeGLKXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:23:02 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32138 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeGLKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:23:02 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w6CADxRX025029;
        Thu, 12 Jul 2018 19:14:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w6CADxRX025029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531390440;
        bh=XcMmWhXZ6I7gSUE0bBS5gYSb48l6tT4ZYhWFC87IIos=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VaVDjUNbC1hOxgZIIRGCWcHPhxLIFr3wLvYftdUx4fjig4hfXYD191us7Qw/axHZX
         nLDpnyFnIOtA/Gja3hdofr+Ujp/Iqsbkvfn7/CakZ8BH03u5nzvEcNX8PDqQXRTeoR
         otsH+o6yAWL4gZlUcsTwh2e7Qy7BxBSxC18YCLYab+7OXMg1aiK510gId+g9VsMvU8
         9MmhzFk7RxAgWanJvOR6W5aEycOGybpjrv3U9uVGFUMclM5AaunI8iWpZqQO5oAFLL
         VfdUQEyL4d6vu3VKRBS9JY23SR0CljPK92aDqXhfxRkVIDThmc2ujAvvl5xPgPXsdH
         nQ0Yq99s6x45Q==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id b14-v6so16030971vke.13;
        Thu, 12 Jul 2018 03:14:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlHJydeHLi1vbxWcY+8ddGGTIsnnqbElhEJdSrmEHlP/4fwhaUmW
        FfApu0BJC0xt+GvZC2N+Y7rpZQoLVOiNvD3R0Go=
X-Google-Smtp-Source: AAOMgpe3G26YGul2QnmcOkGjUEM70VJ4MA4Fma+NmTpj8PV+vYk/1Z5IbiKyAjoy13dHAGWC/Oa77ks2XsNLaLYGCm0=
X-Received: by 2002:a1f:88:: with SMTP id 130-v6mr819848vka.154.1531390439154;
 Thu, 12 Jul 2018 03:13:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 03:13:18
 -0700 (PDT)
In-Reply-To: <20180710004602.21599-1-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 12 Jul 2018 19:13:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ0dWqaYkLjevCuboCBovcsTV1cMh48qv__wwMZs-vAxg@mail.gmail.com>
Message-ID: <CAK7LNAQ0dWqaYkLjevCuboCBovcsTV1cMh48qv__wwMZs-vAxg@mail.gmail.com>
Subject: Re: [PATCHv2 0/7] HOSTFLAGS and HOSTLDFLAGS from the environment
To:     Laura Abbott <labbott@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Jarry <robin.jarry@6wind.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-10 9:45 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> Hi,
>
> This is v2 of the series to set HOSTCFLAGS and HOSTLDFLAGS from the
> environment. The changes are mostly minor fixups requested and also
> include documentation of the new options.



I checked this series.


I left minor comments for 3/7 and 7/7.

Unless you disagree,
I will fix them up locally
and queue it to my tree.

Thanks.




> Laura Abbott (7):
>   tools: build: Fixup host c flags
>   tools: build: Use HOSTLDFLAGS with fixdep
>   treewide: Rename HOSTCFLAGS -> KBUILD_HOSTCFLAGS
>   treewide: Rename HOSTCXXFLAGS to KBUILD_HOSTCXXFLAGS
>   treewide: Rename HOSTLDFLAGS to KBUILD_HOSTLDFLAGS
>   treewide: Rename HOST_LOADLIBES to KBUILD_HOSTLDLIBS
>   Kbuild: Use HOST*FLAGS options from the command line
>
>  Documentation/kbuild/kbuild.txt | 16 ++++++++++++++++
>  Makefile                        | 17 +++++++++--------
>  arch/alpha/boot/Makefile        |  2 +-
>  net/bpfilter/Makefile           |  4 ++--
>  samples/bpf/Makefile            | 22 +++++++++++-----------
>  samples/seccomp/Makefile        |  6 +++---
>  scripts/Kbuild.include          |  2 +-
>  scripts/Makefile                |  4 ++--
>  scripts/Makefile.host           | 24 ++++++++++++------------
>  scripts/kconfig/Makefile        | 10 +++++-----
>  tools/build/Build.include       |  2 +-
>  tools/build/Makefile            |  2 +-
>  tools/objtool/Makefile          |  4 ++--
>  tools/perf/pmu-events/Build     |  2 +-
>  14 files changed, 67 insertions(+), 50 deletions(-)
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
