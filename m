Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EC4C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B9B2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWObDpBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B9B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeKFTR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:17:59 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40299 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbeKFTR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:17:59 -0500
Received: by mail-vs1-f68.google.com with SMTP id s9so6902840vsk.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9z15kKrtPjTadF5nBhQpkUcVywgEkqgy9mlhS13uwpg=;
        b=vWObDpBA6n5VfcY+SSbibTRT4QkjUmbFe5Hj6h7xqL6899Vk7qM96ejaBgsfsVgNes
         uVpERg9o1xlmkP80IOseQMdHuVpUhfzMMLPnKVfR6PpoV+ENZbS3tRtiXLW9WzCuShNZ
         +XLe5xnYzZbeCGpBfPTNQTTOi3IsNMOmFhqWUe0Y/NQBg9MuYHroEClTMLctfZ8a18on
         /M2oPzvylMatwEfSph1Rby+7sszJVjCL2ycVluXsxITtlokfEhrVs0Zu0x2WgcxH6sVv
         twq2flSWrT1ALni+FdITjyx+zAcP2HfvWY+J1It0NGAJVIu4E/Cmh/xOmvMP2V4glF5U
         6+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9z15kKrtPjTadF5nBhQpkUcVywgEkqgy9mlhS13uwpg=;
        b=PAx4egyjZAWMCjz8BOIa3iLef6/5GJb8GLDxfih1s4vgy5UyRvJJtXOK4V0qiW4njD
         ZgcOodYhXoEo5TeRt7eys13KjL+S2ENhz2UWR+qdeIXrSAIm5632PLcLCoILEwVZD3+O
         THrS8dAdhAPgR67o2f56vXb7Q78O6ptgaER9YgbD+hFf6BeqZTbNygEUrEHXNQbvtaGL
         CanECwc2Vjm/qqi8oER+lf4TJqOTY9wyCwQzLTQFt+JKlkHturWwsxMZycq/JgfAJwp1
         m36VYpT5JkNF5bxCzvU3+bY5i+SJLgA66E9sYWz+1F9b49eELIPSxDdPP5hTZboKi0ap
         VnIQ==
X-Gm-Message-State: AGRZ1gISwOfIT0Cg8Xpj2SnwkpKPa4v6A/zlMUXiyamA/a9gDFbHKnWR
        uf6NhBrJkeLBvU0nn5FFCBHMuZ+5Wz0lDQr+4PH3HTow
X-Google-Smtp-Source: AJdET5e74WtlwThXjKmrsOeybIFdMpOMfd27ScamvxPX6Iot6pVdLoZSrav6UrYdJlJV6Hlc85wzezdaLDo2b7rC8Rw=
X-Received: by 2002:a67:7402:: with SMTP id p2mr11025023vsc.101.1541498012879;
 Tue, 06 Nov 2018 01:53:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541055990.git.vincentc@andestech.com>
In-Reply-To: <cover.1541055990.git.vincentc@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 6 Nov 2018 17:52:56 +0800
Message-ID: <CAEbi=3f0OggbR2_ajWPT3Sx=ck2CTj448WUkssr63hHsywCsqQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] nds32 FPU port
To:     Vincent Chen <vincentc@andestech.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,
Vincent Chen <vincentc@andestech.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=881=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:17=E5=AF=AB=E9=81=93=EF=BC=
=9A
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
>  arch/nds32/Makefile                      |   11 +
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
>  arch/nds32/kernel/Makefile               |   10 +
>  arch/nds32/kernel/ex-entry.S             |   24 ++-
>  arch/nds32/kernel/ex-exit.S              |   13 +-
>  arch/nds32/kernel/ex-scall.S             |    8 +-
>  arch/nds32/kernel/fpu.c                  |  269 ++++++++++++++++++++++
>  arch/nds32/kernel/process.c              |   64 +++++-
>  arch/nds32/kernel/setup.c                |   12 +-
>  arch/nds32/kernel/signal.c               |   62 +++++-
>  arch/nds32/kernel/sleep.S                |    2 +
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
>  46 files changed, 1827 insertions(+), 67 deletions(-)
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

Thank you.
Acked-by: Greentime Hu <greentime@andestech.com>
