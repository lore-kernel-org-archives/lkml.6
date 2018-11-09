Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F06EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D9D20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj/Q2/uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D9D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeKIQig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:38:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40539 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeKIQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:38:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so755876oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Rt7dvlXRtuXdezXvwwdHrCrHcLtulW0mACAMUGxzCQE=;
        b=cj/Q2/uzb+1I2cqayV2i0EqPfq/nKB/b2/15tW2fon8xYVmVs5owm8Thf6hVn1V+ui
         +j4PxDcj+aEVnUfUDabuqzPZVti0vZUVXmFLBQR3PPWd4cpA1/rnWe5tzD5G4rhePnTU
         59/qgSg8bcrscrxIMb9UcmzOtasJEa3q/X9TFKyGu8QSFzvmK0ieRy3WILsumh1psVwq
         KrkOpSU6Prz+lCDDwUfRcQ8lNsj164AYeNzlz462MxUa9bKxQY9bEXk1/Ao1HdSVhmUs
         zC+3AYAD5iETMa24309sKBHrEpiN49+PlAHpbW3ozVkwUq/RkBLklEZr09wrCs4faHC1
         cuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Rt7dvlXRtuXdezXvwwdHrCrHcLtulW0mACAMUGxzCQE=;
        b=uEz1WZRTYoVHQDqhlXqRDWp/0lZk38KN7832cxAtzjyNqGrJDBLD4kNAF+4CItUOv2
         73fOD2gkKzZW0OvrKJnuNFeoBaiU06qW3fPRRxJ3Es08ni6baw9TD6J/fGhxmORbXqCO
         memVOXZ9W+oymeiFax8ytptsPSHCC8eXt1U5HoEbcAAYjIyVQTMH0JGx98f0L8LSif7c
         F/6wr+HDkYqC+LA1iiz16Z8LbgSVbm9uUWmUOpmf1QqpN5i6zaKMXoOtxy2qwV06Kwrj
         UQ8qEgMkt8p9k5Qcuqm4fg1tD7ysO9J1Fwqje/fxbzvFK3tjBwFaSRMAWmVb1J3WRf/U
         gMGw==
X-Gm-Message-State: AGRZ1gLh+EfJjUP33I4MpBpsr2aLMFVbdPnpLZppZ5ac970cJ7fsc4xw
        XiXTybBaxmf9KtPh/NZD1s1CXaWdTuv94wpO9Fg=
X-Google-Smtp-Source: AJdET5dAKOPl9dS/Ib+deFNw+ij/Zm8bpH7t66EDEK3F5Z2VHu1lEjgo1P/Uqsq9g35PM+LASxyw8iRBl3WL0YWjgIg=
X-Received: by 2002:a9d:dc3:: with SMTP id 61mr4575956ots.345.1541746764030;
 Thu, 08 Nov 2018 22:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20181109031303.GA20906@altlinux.org> <20181109031712.GL21511@altlinux.org>
In-Reply-To: <20181109031712.GL21511@altlinux.org>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Fri, 9 Nov 2018 07:59:13 +0100
Message-ID: <CAEn-LTpbzdpeWv8wqo_ptBw2t3Ypzzp0JcB+TGMG4NZbEGBnkw@mail.gmail.com>
Subject: Re: [PATCH 12/13] riscv: define syscall_get_arch()
To:     luto@kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, Paul Moore <paul@paul-moore.com>,
        eparis@redhat.com, lineprinter@altlinux.org,
        linux-riscv@lists.infradead.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:17 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> that use tracehook_report_syscall_entry() in order to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>

I have posted audit support patch for RISC-V in October. Pending review.
It defines both AUDIT_ARCH_RISCV32 and AUDIT_ARCH_RISCV64.

See thread: http://lists.infradead.org/pipermail/linux-riscv/2018-October/001933.html

david
