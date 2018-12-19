Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21266C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28AB20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OonJALQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeLSTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:02:14 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:49767 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeLSTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:02:14 -0500
Received: by mail-ua1-f73.google.com with SMTP id 45so2326032uav.16
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 11:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=gctRfaNoKpG92BlcP2PmFdf5r4Zk6xxcrw/6G9x9wRI=;
        b=OonJALQuUjne18eU6FJEVyigPrOzjLcRYVclb2hzEot8C0eyl23zaPjRonlMSSjJ8g
         dMXR3f7JHqaMI4v+HnTrEuRrfbwEMPcJ3G1KAtpClPMFrCIcS0HAhXW2F/nOtp/OnZZR
         bOvznatKh7gArOe1MMJ1Yln5QEDecuXu7aM6ZktA1ohy8oIFdYdOJwjExSWNY4KXJpGx
         CQ48C2Zm1q7MhfomQTgyKrQElV9FhnuEeet3swY1PgLbF2qATK370h1C017F38PawTaT
         uMKDIn4VC8dCDpC3hCzRwKGEuVNTG85ziaz/chFb/QrtCmt52Uf/nouv1Xoq4wGBnhQ2
         cx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=gctRfaNoKpG92BlcP2PmFdf5r4Zk6xxcrw/6G9x9wRI=;
        b=UaY1v6PaWRANuRAhOafgLkaXS8w0McwW+Me7zupBmE3b+D4+IBzHxBxyhPzPS8iz2x
         RkIAcgErfpOiDLJ5w7LvQ01CFcALeDbDOM8tSAMNFQ0zs//RT0SP/g7mf0qCzI9KFKxm
         ueAVbs+gcXlYLTVCRAl9P47/LBVBfOmqZgmeLrtnWAesgZKTGzvhEAE4cP0HEoLcywgm
         sxrWzlCAf81Q8uaQPB6lJKIqebqMPDlUD1LY9XPKLeH4FhFj9Rjt/LlAUUWoPALkdIr/
         Y7Y/Kz8bxCjUi+z3aa59Nn64eQRkFjHmCKeCFvNHOutVA3B7sQhfXf+UBN+3tXOINYYw
         MdFw==
X-Gm-Message-State: AA+aEWaTKcXzmab69FWUWBAZlRfuPNmpVc5fcxTKlJGfhfsvCX/V22h3
        e95BpLgBHL5BLKv39vR5hFuebFGMZxFKyMK+rJs=
X-Google-Smtp-Source: AFSGD/VqqQdieO2H5AGL6QVq8oVi3gCsPFtEBlitNtsymPXYqLif/bCOToKTuMdXGGzq86nZzhHdsVkdDoPtJAn86ZE=
X-Received: by 2002:a67:8d09:: with SMTP id p9mr23012591vsd.28.1545246132597;
 Wed, 19 Dec 2018 11:02:12 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:01:43 -0800
In-Reply-To: <20181219183509.GB31643@zn.tnic>
Message-Id: <20181219190145.252035-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20181219183509.GB31643@zn.tnic>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v2] x86/build: Mark per-cpu symbols as absolute
From:   ndesaulniers@google.com
To:     bp@alien8.de
Cc:     rafael@espindo.la, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, morbo@google.com, dima@golovin.in, hpa@zytor.com,
        matz@suse.de, Tri Vo <trong@android.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>

The kernel has many variables that it wants to have per CPU. It is
similar to how each thread wants a copy of a thread local variable.

To access such variable, the code has to find the offset of that
variable in the per cpu block and add it to the address of the current
brock for that cpu.

Section 3.10.8 of ld.bfd's documentation states:
```
For expressions involving numbers, relative addresses and absolute
addresses, ld follows these rules to evaluate terms:

Other binary operations, that is, between two relative addresses
not in the same section, or between a relative address and an
absolute address, first convert any non-absolute term to an
absolute address before applying the operator."
```

Note that ld.lld does not implement this behavior. Instead, we can
explicitly mark non-absolute terms ABSOLUTE via linker script. This is
no functional change for ld.bfd which coverts the term to ABSOLUTE
anyways as specified above.

Reported-by: Dmitry Golovin <dima@golovin.in>
Tested-by: Dmitry Golovin <dima@golovin.in>
Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Michael Matz <matz@suse.de>
Signed-off-by: Tri Vo <trong@android.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
[nd: commit message updated as per Boris' and Michael's sugguestions]
---
Changes from v1 -> v2: commit message updated

 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0d618ee634ac..ee3b5c7d662e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -401,7 +401,7 @@ SECTIONS
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
  */
-#define INIT_PER_CPU(x) init_per_cpu__##x =3D x + __per_cpu_load
+#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(irq_stack_union);
=20
--=20
2.20.1.415.g653613c723-goog

