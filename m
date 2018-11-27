Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E068C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C979C21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8rQS03l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C979C21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbeK1DJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:09:57 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:34251 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbeK1DJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:09:57 -0500
Received: by mail-yw1-f45.google.com with SMTP id g75so9365679ywb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qJJbUaLODuI75MvctT19W6ZB+Xpak+0bNYOGaJUIcGU=;
        b=S8rQS03lI6hJSMw3RdOU/3n+9w1URyXuuTkBOx8c0NJxLVu5ElrnpDsVDgC/iJn4M8
         A9r+1iGRs2BKWtrjzOLeASCwbMCJoYa4NzL7+GslCK52Kf7Yl6rCkHzjmd8KR9+sd8Qp
         4BOLnjKy4gBJNY8UBaeVuLEAiLd57Mtsg4MGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qJJbUaLODuI75MvctT19W6ZB+Xpak+0bNYOGaJUIcGU=;
        b=MfxrQrP0DOGv6qWTIs3apcqlnHGP2uSzkWb578GuAnrkKFvBrwOSrvANokmH/HwLI5
         /nzyyTuVDedBtCSfrUYoq6lfKwzHXj7dCVpFNa3EedfWgbgdyYL/QxZN6ElwfzFTJhRB
         h0Y2704WwVH1ZszwB73YoAg30TyYucBKyBfAQnjtQpKtHfISgkRs/Z2ezA/YmQeNpPnH
         7fVBn1GkrCa1tiIEpBpla3A34sJ/ZbGGw5E27pfCml8+EmqcGTr6YnS8Ei9ugxX4K6Nh
         GS5sjPBlPbEydFqNsCTulesDZHO7kBkIoeYnNw/MFU6wexcJrJ0tqR4N85T52gZmQWJz
         MDLw==
X-Gm-Message-State: AGRZ1gK3FCuAJoq/gGklTmgfDW/h95hoisPEZEVXzUEgpoi0bgjFQc9l
        tIpqpIiYXDz+VpT9KDKo+taZgm1VdSVVVaFrd+yBAA==
X-Google-Smtp-Source: AJdET5ffXjVp8T/HVuNdibb6BcnBSOCihBxwvi6wYVJ86ZOgsIK7Thzs8Akb7VfCpbxvffCEOnjYuNgeVFjqA/tgk8c=
X-Received: by 2002:a0d:e24b:: with SMTP id l72mr35201562ywe.25.1543335093860;
 Tue, 27 Nov 2018 08:11:33 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvgDP2+D2mgqxJJJYm1DTgxbByxjKuVGBFOa-m_fT7Q-Q@mail.gmail.com>
In-Reply-To: <CA+G9fYvgDP2+D2mgqxJJJYm1DTgxbByxjKuVGBFOa-m_fT7Q-Q@mail.gmail.com>
From:   Masami Hiramatsu <masami.hiramatsu@linaro.org>
Date:   Wed, 28 Nov 2018 01:11:22 +0900
Message-ID: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
Subject: Re: File not found: /sys/kernel/debug/tracing/events/syscalls
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that the commit 4378a7d4be30 ("arm64: implement syscall
wrappers") changed
the syscall wrapper function names by adding __arm64_ prefix. So arm64
kernel should
have its own arch_syscall_match_sym_name().

Thank you,

2018=E5=B9=B411=E6=9C=8828=E6=97=A5(=E6=B0=B4) 0:22 Naresh Kamboju <naresh.=
kamboju@linaro.org>:
>
> While debugging the selftests/bpf: get_cgroup_id_user test failure on arm=
64
> where the test is expecting trace file
> /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id
> but this path not enabled after enabling required kernel configuration al=
so.
> CONFIG_FTRACE_SYSCALLS=3Dy
>
> strace output:
> open(\"/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id\"=
,
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
>
> This problem noticed on Linux mainline kernel version 4.20.0-rc3.
>
> Best regards
> Naresh Kamboju



--=20
Masami Hiramatsu
