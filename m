Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75EEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8708420851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpI/rw0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8708420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeK1NTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:19:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33496 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeK1NTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 08:19:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so21992812ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 18:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ygFlCY1EQpTTfCFFv8LTZ5QyMxMd89kHU6qEZaPqi1A=;
        b=WpI/rw0Fyip2/q73U7FELXA7tHr7FPLNI03UKWn9KOx7yYFbEk/NL5+w1lqWQua8D/
         kGcyMDWOsLERMy0YMZc6Yj1W2Hk3HzDlsQWf+en8AlAq8Bb+15XhVuMmCkfnwXBIh0/P
         zjDx4yu9PHoc9z0+0gydgaX7ctDhvAAJvh52M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ygFlCY1EQpTTfCFFv8LTZ5QyMxMd89kHU6qEZaPqi1A=;
        b=RHxBssaliI7/0AxQK2BDfV7BVITzEW5Rf3n2+Jy8SgsZkZbvlyOyndx5pV9AukB1cr
         oFNK/D9iJwx+G4TVhsk8S5v/HJ5higrojj/pzb7qlZwC6FisDpsqdA+KFlIUAqLaEQ5N
         oxInZLHimb0cXefECcnxf7/SbitPG1LUlKEFyLNMIGwknNZtrvp8UPO+WkUyBw0E6ewi
         zRpJQhDyXhJqsBxjU3B5vf/mR5zFjp9X1qFNh8A7Ce0RAuPO8JsEGPrJTU5hDn8rEKgv
         6Ph4fuT2N9UCCyGf6QanEeNLTHkbplbaD68BcTM7TStmel4KXjoihhZKtBljXV4PlIDq
         q7rw==
X-Gm-Message-State: AA+aEWY4PqDcOgGx1rT8Juk2lccUy8vbgIVHMC8kPquzWFPspqwpJg1K
        tQBghfK2IaMj4Dm8hr/aU6SanLwMr4hzzL5TYu5SUA==
X-Google-Smtp-Source: AFSGD/VeUIDNXajAEwXRM84SwxJWGQrksU+OcFkREo5PcZeZygwQz4b2sg8B3bxNkmk9aPIvmKUCiXQtDClhPEDsVJ4=
X-Received: by 2002:a2e:6594:: with SMTP id e20-v6mr23264247ljf.123.1543371565318;
 Tue, 27 Nov 2018 18:19:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvgDP2+D2mgqxJJJYm1DTgxbByxjKuVGBFOa-m_fT7Q-Q@mail.gmail.com>
 <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
In-Reply-To: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Nov 2018 07:49:13 +0530
Message-ID: <CA+G9fYtS+0xNvjov+o8kh-Fp2O7u5ChUd2ystc6PYxVo4n=Yfg@mail.gmail.com>
Subject: Re: File not found: /sys/kernel/debug/tracing/events/syscalls
To:     Masami Hiramatsu <masami.hiramatsu@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami San,

Thanks for the patch it solved the problem.

On Tue, 27 Nov 2018 at 21:41, Masami Hiramatsu
<masami.hiramatsu@linaro.org> wrote:
>
> Hi,
>
> I found that the commit 4378a7d4be30 ("arm64: implement syscall
> wrappers") changed
> the syscall wrapper function names by adding __arm64_ prefix. So arm64
> kernel should
> have its own arch_syscall_match_sym_name().

arm64: ftrace: Fix to enable syscall events on arm64

From: Masami Hiramatsu <mhiramat@kernel.org>

Since commit 4378a7d4be30 ("arm64: implement syscall wrappers")
introduced "__arm64_" prefix to all syscall wrapper symbols in
sys_call_table, syscall tracer can not find corresponding
metadata from syscall name. In the result, we have no syscall
ftrace events on arm64 kernel, and some bpf testcases are failed
on arm64.

To fix this issue, this introduces custom
arch_syscall_match_sym_name() which skips first 8 bytes when
comparing the syscall and symbol names.

Fixes: 4378a7d4be30 ("arm64: implement syscall wrappers")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 arch/arm64/include/asm/ftrace.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrac=
e.h
index caa955f10e19..a710f79db442 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -56,6 +56,15 @@ static inline bool
arch_trace_is_compat_syscall(struct pt_regs *regs)
 {
  return is_compat_task();
 }
+
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+
+static inline bool arch_syscall_match_sym_name(const char *sym,
+       const char *name)
+{
+ /* Since all syscall functions have __arm64_ prefix, we must skip it */
+ return !strcmp(sym + 8, name);
+}
 #endif /* ifndef __ASSEMBLY__ */

 #endif /* __ASM_FTRACE_H */


>
> Thank you,
>
> 2018=E5=B9=B411=E6=9C=8828=E6=97=A5(=E6=B0=B4) 0:22 Naresh Kamboju <nares=
h.kamboju@linaro.org>:
> >
> > While debugging the selftests/bpf: get_cgroup_id_user test failure on a=
rm64
> > where the test is expecting trace file
> > /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id
> > but this path not enabled after enabling required kernel configuration =
also.
> > CONFIG_FTRACE_SYSCALLS=3Dy
> >
> > strace output:
> > open(\"/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id=
\",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> >
> > This problem noticed on Linux mainline kernel version 4.20.0-rc3.
> >
> > Best regards
> > Naresh Kamboju
>
>
>
> --
> Masami Hiramatsu
