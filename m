Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA5DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C302082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW3Q3z1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C302082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJYScj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:32:39 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:47073 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:32:39 -0400
Received: by mail-vs1-f67.google.com with SMTP id l6so5084542vsj.13;
        Thu, 25 Oct 2018 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dR5bFwv8bOwwJs4GKudaPDmPfcxoCd5ewhF77B+pa74=;
        b=aW3Q3z1g6uh2nr7DsgZUsDNHen6fpD1Lf72T9TFyr5C1kr6rX+O1axNf0wIzxnhz0v
         nN+USedGRotztfjjTmvJUbPIsMBNHrMxescdqNkzLY0jA/JOwob9QNyT4+RepqC68PHk
         uUwNHI8OZY6oiDJIU+JK+93eipyD5Ejo1s7UclYl22a179s/6GozYoASY9+YwGgS5TKr
         q7KlA5wAjDnkjcszJ1bGUPm+WZJ44f5lVUIZc/G5GuSud7RXvtKv1M+x0t/FW16O4RP9
         HN7mo5bPNhmE/6+L/oI81QKFhvd2c/bSu3kK/TcF1JVinHjRT7W0U2xHrpPdKH3G/0bK
         +m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dR5bFwv8bOwwJs4GKudaPDmPfcxoCd5ewhF77B+pa74=;
        b=h5fkvssf9aBkNuOKyyFLV14O/gBX24bvLCR2kiPu7c3/Sk4wRJCmZrXpgIhSXGoo12
         Cg2/8aaZ3vvAuEKCQeMS0/c/Igxt1HhyWtKkXdIGSo9uNWFvQx8REKSPmZJM+pMsdJb1
         NDBU+25NMP29vTQlybxoWZqkANHvdWVIOnnWHysqQwtT98pYksxQqJPJ3Q1ReCb06i4D
         OJ1ckiUVot5v26XezShgaCnVfaFmKhcHBty5jAZZwF5hkCWIHF6FE8FJiJtST62qpVNn
         8f7uX282k7vvNHlArRxgGNIWUDTCr1NWcvu/7VQSiTqBrWLLODcaxQP7GfXwyjcKHm8q
         fnXA==
X-Gm-Message-State: AGRZ1gKLq1qE+Lfra17A2rmbuQKEGZPI1oQhvHI/kYz5YTTYzdD0JbJc
        mkci6TK/gheIoc2xINFtuDId3wfiRriBpqI0mx8=
X-Google-Smtp-Source: AJdET5cIcMq/7jZKfe2l4J7XsJ9SL4yZEWB7R8LTBEyskJzAU27PXRGeUlVrD8fiMRFo8S+vxVY+M8Wa+bVexGgqGIU=
X-Received: by 2002:a67:33d1:: with SMTP id z200mr383864vsz.40.1540461636798;
 Thu, 25 Oct 2018 03:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1540430861.git.nickhu@andestech.com>
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 25 Oct 2018 17:59:59 +0800
Message-ID: <CAEbi=3epEazp30TE=dgVtAU8kye49a3z7uZig88q0zngxAmitg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] nds32: Perf support
To:     Nickhu <nickhu@andestech.com>
Cc:     Greentime <greentime@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-arm-kernel@lists.infradead.org,
        DTML <devicetree@vger.kernel.org>, Zong Li <zong@andestech.com>,
        alankao@andestech.com, Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Hu <nickhu@andestech.com> =E6=96=BC 2018=E5=B9=B410=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> These four commits are perf supporting for nds32.
> There are three perfomance counters in nds32, and
> each of them can counts different events. You can
> use 'perf list' to show the available events that
> can be used.
>
> Changes in V2:
>         1. Change the definition 'PFM_CTL_xxx' to
> array form.
>
>         2. Simplify the PMU driver.
>
>         3. Stop all counters when handling irq
> caused by performance counters overflow.
>
>         4. Rename the compatible string in
> devicetree.
>
> Changes in V3:
>         Fix the typo in Documentation/devicetree/
> bindings/nds32/pmu.txt.
>
> Changes in V4:
>         Move 'Documentation/devicetree/bindings/nds32/pmu.txt'
> to 'Documentation/devicetree/bindings/perf/nds32v3-pmu.txt'.
>
> Nickhu (4):
>   nds32: Fix bug in bitfield.h
>   nds32: Perf porting
>   nds32: Add perf call-graph support.
>   nds32: Add document for NDS32 PMU.
>
>  .../devicetree/bindings/perf/nds32v3-pmu.txt  |   17 +
>  arch/nds32/Kconfig                            |    1 +
>  arch/nds32/boot/dts/ae3xx.dts                 |    5 +
>  arch/nds32/include/asm/Kbuild                 |    1 +
>  arch/nds32/include/asm/bitfield.h             |    4 +-
>  arch/nds32/include/asm/perf_event.h           |   16 +
>  arch/nds32/include/asm/pmu.h                  |  386 +++++
>  arch/nds32/include/asm/stacktrace.h           |   39 +
>  arch/nds32/kernel/Makefile                    |    3 +-
>  arch/nds32/kernel/perf_event_cpu.c            | 1522 +++++++++++++++++
>  arch/nds32/mm/fault.c                         |   13 +-
>  tools/include/asm/barrier.h                   |    2 +
>  tools/perf/arch/nds32/Build                   |    1 +
>  tools/perf/arch/nds32/util/Build              |    1 +
>  tools/perf/arch/nds32/util/header.c           |   29 +
>  tools/perf/pmu-events/arch/nds32/mapfile.csv  |   15 +
>  .../pmu-events/arch/nds32/n13/atcpmu.json     |  290 ++++
>  17 files changed, 2337 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.tx=
t
>  create mode 100644 arch/nds32/include/asm/perf_event.h
>  create mode 100644 arch/nds32/include/asm/pmu.h
>  create mode 100644 arch/nds32/include/asm/stacktrace.h
>  create mode 100644 arch/nds32/kernel/perf_event_cpu.c
>  create mode 100644 tools/perf/arch/nds32/Build
>  create mode 100644 tools/perf/arch/nds32/util/Build
>  create mode 100644 tools/perf/arch/nds32/util/header.c
>  create mode 100644 tools/perf/pmu-events/arch/nds32/mapfile.csv
>  create mode 100644 tools/perf/pmu-events/arch/nds32/n13/atcpmu.json
>
Hi Nick,

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
