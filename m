Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F55C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD50120684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQpj79gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD50120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405269AbeKVVA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:00:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40515 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbeKVVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:00:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so7247882edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 02:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HSvJahu1uRerfznMJOkPbm+lTH+CajCOTME1u3iZuuY=;
        b=vQpj79gwQrz1SCK8HSbM9pKA7ChOgwo3ylDojPMI7SNROt/1xur2jd+x7Ss0fWa/3a
         fkTeo37742qwgXalEoOHfy/X4YJEjz5BLnVwzTMEmXiuD3PI275YmIT+Xcf9DG1TZ59w
         nv5QEDO7dJhgy3peUS/w8fyVwd+4HuEjSbVF5ffdjC7mkHCGYdSL2PuM9Gl80E/FaBWf
         LoDXXvN9Qvd/4LzN8dZhfgYcOyBSqtQqBeRXuTwWOeTQ92AossgVlf2gN7Bjl0RkB4aa
         37dvCxzL5HlsoYdEt537cPga25JbJEO/DSrMHI+2q9ccWKH6mO61ZvfXgfkZYLcDmenY
         yRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HSvJahu1uRerfznMJOkPbm+lTH+CajCOTME1u3iZuuY=;
        b=tZ3/YTmtBDYzdRTpDqSUDnwm+aN8XH37qRHHMAw4eewrDOWXIyAqt8YbyWDOjG9nad
         HsE2Khf0zBLk9vsYiIYR+AKaz2zHbpo+Bu/4P1rDcrRZ61wTEQ5E8NQoiKvWGR47Pkyr
         9K2yinYCie8EcT0wblGpn/LBvV+Bbi7VWMpm4ynSS3k5lJOllsrCG9sYX6bWFENtwxEZ
         Thr5sITHkS3uQe+ovdt97S3v3ghTr5vpxo2ohRHl1y3hJGHEGYyRa6KpZMRWrb0b+i5J
         rYZZnKFDaylBkxGtFapThpyBTPE8/LwRMG5rW603yW6i7j/zEsux+tBCO32YBGHPHLl6
         AzOA==
X-Gm-Message-State: AGRZ1gJUC4ulDGbUP84gCt/lhHNnq1y51gEx0uPec8sYuQLMoI1CzOm4
        2IQigmlefn7vp/9KCsm02jUduxava3Wb0g37cdk=
X-Google-Smtp-Source: AJdET5f2YAx2s5bFptaD7PRk5DjsGsp0Iro8WZBNUtOposzNKbWkUAJy24kHOZkFZ5Dy0XW+RyrvHkSZhwjZ5lmxJ5Y=
X-Received: by 2002:a17:906:304b:: with SMTP id d11-v6mr7832632ejd.4.1542882099656;
 Thu, 22 Nov 2018 02:21:39 -0800 (PST)
MIME-Version: 1.0
References: <1542856478-795-1-git-send-email-vincentc@andestech.com>
In-Reply-To: <1542856478-795-1-git-send-email-vincentc@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 22 Nov 2018 18:21:02 +0800
Message-ID: <CAEbi=3eNDRLAOWiXSXyAbDot9TosNRb+-qdsLB6sCSzeGnB2+w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] nds32 FPU port
To:     Vincent Chen <vincentc@andestech.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Chen <vincentc@andestech.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8822=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:14=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>   This patch set contains basic components for supporting the nds32 FPU,
> such as exception handlers and context switch for FPU registers. By
> default, the lazy FPU scheme is supported and the user can configure it
> via CONFIG_LZAY_FPU. In addition, a floating point emulator is required
> to handle all arithmetic of denormalized number because it is not support=
ed
> by the nds32 FPU.
>
>   As mentioned above, the nds32 FPU does not support denormalized number
> This means the denormalized operands and results are not permitted. If an
> instruction contains denormalized operands, the nds32 FPU will raise an
> denormalized input exception to inform kernel to deal with this
> instruction. If the result of the instruction is a denormalized number,
> normally nds32 FPU will treat it as an underflow case and round the resul=
t
> to an appropriate value based on current rounding mode. Obviously, there =
is
> a precision gap for tininess number. To reduce this precision gap, kernel
> will enable the underflow trap by default to direct all underflow cases t=
o
> the floating pointer emulator. By the floating pointer emulator, the
> correct denormalized number can be derived in kernel and return to the us=
er
> program. The feature can be configured by
> CONFIG_SUPPORT_DENORMAL_ARITHMETIC, and if the precision requirement is n=
ot
> critical for tininess number, user may disables this feature to keep
> performance.
>
>   The implementation of floating point emulator is based on soft-fp
> which is located in include/math-emu folder. However, soft-fp is too
> outdated to pass the current compiler check. The needed modifications
> for soft-fp are included in this patch set
>
> Changes in v4:
>  - Fix compilation error
>
> Changes in v3:
>  - Kernel with FPU support enabled still can run on a CPU without FPU
>  - Rename CONFIG_UNLAZY_FPU to CONFIG_LAYZ_FPU
>  - Rename _switch() to _switch_fpu()
>  - Store FPU context when kernel suspends
>  - Modify the comments in code and patch
>
> Changes in v2:
>  - Remove the initilzation for floating pointer register before entering =
to
>    signal handler.
>
> Vincent Chen (5):
>   nds32: nds32 FPU port
>   nds32: Support FP emulation
>   nds32: support denormalized result through FP emulator
>   math-emu/op-2.h: Use statement expressions to prevent negative
>     constant shift
>   math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast 0 to void to fix warning
>
>  arch/nds32/Kconfig                       |    1 +
>  arch/nds32/Kconfig.cpu                   |   34 +++
>  arch/nds32/Makefile                      |    5 +
>  arch/nds32/include/asm/bitfield.h        |   15 ++
>  arch/nds32/include/asm/elf.h             |   11 +
>  arch/nds32/include/asm/fpu.h             |  126 +++++++++++
>  arch/nds32/include/asm/fpuemu.h          |   32 +++
>  arch/nds32/include/asm/nds32_fpu_inst.h  |  109 +++++++++
>  arch/nds32/include/asm/processor.h       |    7 +
>  arch/nds32/include/asm/sfp-machine.h     |  158 +++++++++++++
>  arch/nds32/include/asm/syscalls.h        |    1 +
>  arch/nds32/include/uapi/asm/auxvec.h     |    7 +
>  arch/nds32/include/uapi/asm/sigcontext.h |   14 ++
>  arch/nds32/include/uapi/asm/udftrap.h    |   13 +
>  arch/nds32/include/uapi/asm/unistd.h     |    2 +
>  arch/nds32/kernel/Makefile               |    4 +
>  arch/nds32/kernel/ex-entry.S             |   24 ++-
>  arch/nds32/kernel/ex-exit.S              |   13 +-
>  arch/nds32/kernel/ex-scall.S             |    8 +-
>  arch/nds32/kernel/fpu.c                  |  269 ++++++++++++++++++++++
>  arch/nds32/kernel/process.c              |   64 +++++-
>  arch/nds32/kernel/setup.c                |   12 +-
>  arch/nds32/kernel/signal.c               |   62 +++++-
>  arch/nds32/kernel/sleep.S                |    4 +-
>  arch/nds32/kernel/sys_nds32.c            |   32 +++
>  arch/nds32/kernel/traps.c                |   16 ++
>  arch/nds32/math-emu/Makefile             |    7 +
>  arch/nds32/math-emu/faddd.c              |   24 ++
>  arch/nds32/math-emu/fadds.c              |   24 ++
>  arch/nds32/math-emu/fcmpd.c              |   24 ++
>  arch/nds32/math-emu/fcmps.c              |   24 ++
>  arch/nds32/math-emu/fd2s.c               |   22 ++
>  arch/nds32/math-emu/fdivd.c              |   27 +++
>  arch/nds32/math-emu/fdivs.c              |   26 +++
>  arch/nds32/math-emu/fmuld.c              |   23 ++
>  arch/nds32/math-emu/fmuls.c              |   23 ++
>  arch/nds32/math-emu/fnegd.c              |   21 ++
>  arch/nds32/math-emu/fnegs.c              |   21 ++
>  arch/nds32/math-emu/fpuemu.c             |  357 ++++++++++++++++++++++++=
++++++
>  arch/nds32/math-emu/fs2d.c               |   23 ++
>  arch/nds32/math-emu/fsqrtd.c             |   21 ++
>  arch/nds32/math-emu/fsqrts.c             |   21 ++
>  arch/nds32/math-emu/fsubd.c              |   27 +++
>  arch/nds32/math-emu/fsubs.c              |   27 +++
>  include/math-emu/op-2.h                  |   97 ++++-----
>  include/math-emu/soft-fp.h               |    2 +-
>  46 files changed, 1816 insertions(+), 68 deletions(-)
>  create mode 100644 arch/nds32/include/asm/fpu.h
>  create mode 100644 arch/nds32/include/asm/fpuemu.h
>  create mode 100644 arch/nds32/include/asm/nds32_fpu_inst.h
>  create mode 100644 arch/nds32/include/asm/sfp-machine.h
>  create mode 100644 arch/nds32/include/uapi/asm/udftrap.h
>  create mode 100644 arch/nds32/kernel/fpu.c
>  create mode 100644 arch/nds32/math-emu/Makefile
>  create mode 100644 arch/nds32/math-emu/faddd.c
>  create mode 100644 arch/nds32/math-emu/fadds.c
>  create mode 100644 arch/nds32/math-emu/fcmpd.c
>  create mode 100644 arch/nds32/math-emu/fcmps.c
>  create mode 100644 arch/nds32/math-emu/fd2s.c
>  create mode 100644 arch/nds32/math-emu/fdivd.c
>  create mode 100644 arch/nds32/math-emu/fdivs.c
>  create mode 100644 arch/nds32/math-emu/fmuld.c
>  create mode 100644 arch/nds32/math-emu/fmuls.c
>  create mode 100644 arch/nds32/math-emu/fnegd.c
>  create mode 100644 arch/nds32/math-emu/fnegs.c
>  create mode 100644 arch/nds32/math-emu/fpuemu.c
>  create mode 100644 arch/nds32/math-emu/fs2d.c
>  create mode 100644 arch/nds32/math-emu/fsqrtd.c
>  create mode 100644 arch/nds32/math-emu/fsqrts.c
>  create mode 100644 arch/nds32/math-emu/fsubd.c
>  create mode 100644 arch/nds32/math-emu/fsubs.c

Hi Vincent,

Thank you.

Acked-by: Greentime Hu <greentime@andestech.com>
