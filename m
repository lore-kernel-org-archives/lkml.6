Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49E8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F81120841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXZ58IUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F81120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbeGLUVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:21:42 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:46310 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeGLUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:21:42 -0400
Received: by mail-oi0-f73.google.com with SMTP id j5-v6so41432204oiw.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=7HBBS12wdzPnBqb4PrxQnvTynFROAsoBAJFMXIhIg7Q=;
        b=eXZ58IUykEz8VdCuzNS6RPoVPfkmTF1iOoslHx1q2+xQRoF9blLLyNpSG+yd6pB6VB
         /GBnY1suP6yD//ftGZ5vEWpfLpg7M2WjS6EM97RCVI/MaWlKMmEqggoGcBA7r5g868F6
         PmSysizzQ6f165LhH5B44C+DKgSiLLJw5g2mdOcY7exSUgZHhhrVKpgiyB5pbrYll8h3
         VVt3LFOCTB7hK+i5ZADi36HBQbsYnyEoFct1XvToGCfii9KAnhzCd90NxWcCcleRZocW
         iWZkj23EnToiKpnIwV2NV4z+AAS7RT0XC9gd604gi/VMIBS/1sSvaQv2GOP+6fwOMEnE
         t6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=7HBBS12wdzPnBqb4PrxQnvTynFROAsoBAJFMXIhIg7Q=;
        b=lMGjSgWMMZyj+EgY0nrxLXCd9Apt6uo3mmG8aaYDIaLa6umvDpTYD3hUIXpCYWRIR8
         7RWozA2CbRTJnuIhpkH3D9P888BfMcsAerkEw1cRvUtEjf/e8BO3FfwSSAcpfyU89+/L
         jFVxV3LVrzfAVaPUM3/FSCguVDmWRlvNazWxCulJ7P/wCd254mEi3Aj/nM0DkiFa9O1B
         87VZ/aAvuxIcMiSrcdBC5wCqd48JDmGDaXHeeDIGp/48SUyBLcq78sZpLHpLNL4UaBPX
         hAF2EJmq2cYk/MdwjHDj/xPIKy74obPp4rEr7hI4HBLvs5EXREF0eVnZc6uXjh6BgT3a
         X1lQ==
X-Gm-Message-State: AOUpUlGR4ZPFPeDuUDhMmYAgOucE7pjAQoi1V55luqFe/1I/x0WWr1cm
        fIpr72g0JheywihSoxDd4/qB70cFw1eIwnHTEgSIDIQucFP0+OYuDgdKS6kDyTV2+bDbIgCN90x
        jZy6IZZgip+KvPz5nPoXnmZou6DPpxaSsWxA/YQABpppHLZ9/Z1stpBqBmGLE9HfhbUtX550dWI
        GaEA==
X-Google-Smtp-Source: AAOMgpes7GQ36nMec3KT4wmuTkVBHt+qsBjvoBRloTTRAQdH75dFeJWy/u10WjeDITzbnZ6mCzZGgZSd/+EVc2w=
MIME-Version: 1.0
X-Received: by 2002:aca:bd84:: with SMTP id n126-v6mr2235933oif.78.1531426235108;
 Thu, 12 Jul 2018 13:10:35 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:10:32 -0700
Message-Id: <20180712201032.156997-1-astrachan@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] x86: vdso: Fix leaky vdso link with CC=clang
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdso{32,64}.so can fail to link with CC=clang when clang tries to
find a suitable GCC toolchain to link these libraries with.

/usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
  access beyond end of merged section (782)

This happens because the host environment leaked into the cross
compiler environment due to the way clang searches for suitable GCC
toolchains.

Most of the time this goes unnoticed because the host linker is new
enough to work anyway, but this cannot be reliably assumed.

Extract the needed --target and --gcc-toolchain flags added in the top
level Makefile from KBUILD_CFLAGS. These flags direct clang to the
appropriate toolchain to link the vdsos.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org
Cc: kernel-team@android.com
Cc: joel@joelfernandes.com
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 261802b1cc50..062ee94d2d26 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -163,7 +163,8 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=both) \
-	$(call cc-ldoption, -Wl$(comma)--build-id) -Wl,-Bsymbolic $(LTO_CFLAGS)
+	$(call cc-ldoption, -Wl$(comma)--build-id) -Wl,-Bsymbolic $(LTO_CFLAGS) \
+	$(filter --target=% --gcc-toolchain=%,$(KBUILD_CFLAGS))
 GCOV_PROFILE := n
 
 #
