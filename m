Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E2E204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E2E204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeI1SdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:33:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34752 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1SdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:33:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id x23-v6so6331998qtr.1;
        Fri, 28 Sep 2018 05:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+bx1FzWZAJStTfViWY9Qus05GxGMuHIRFsQvJa/OZE=;
        b=UYNwGyt9aubU+PjuSTiAnS5RYBEyE9y4sjCwBN4f6CVm0gW2X0AHknGwItMzU7D5MP
         dzXBwYP/w2XXyWIChBByunqUwxGUOgOZascRnyhUO+aD9FDVMTIeXP76hpExZ71zwc/V
         6gsgkh9v9EN+amICQeaAgXkN1bLjRZBAZ0syYWdzAuUKoqSeI+emIwi2MplAL3Lkp5Fu
         I0zbv8FAIclL0y2uYlScANBW5zoifA6E7XY4T3rNR8A0qsJrU7iGghc/+17O+k75MiJT
         mKAXdgj5tY+po/78xoq9I3iQlAFKzH8VIqhEKYlzPh+KW4TCTAKLM+mapK/jPrOGoD+Q
         hy/Q==
X-Gm-Message-State: ABuFfogW7WXf4i9QgQAWuAHje/sSdD9UjOjToyXBK14qPYvpgMMA3e8m
        zPWd/DtCT3BsD7AtdqTLAMQdXMO+auft9iyY89c=
X-Google-Smtp-Source: ACcGV625VmSj8m/blZSc64uzBAfpIfIxM+5+1beUlGK4i+9tpxQ/EHHmEE/hK7HxoS2jaObk4UB5GoVUAWA+7XQTNiY=
X-Received: by 2002:aed:366a:: with SMTP id e97-v6mr301280qtb.75.1538136587047;
 Fri, 28 Sep 2018 05:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org> <1538057720-3392-8-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538057720-3392-8-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Sep 2018 14:09:30 +0200
Message-ID: <CAK8P3a2E2KJApEcwpJgqs9KHuyr-mzE8Y6F+D1E0akpXt8VK_Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] ia64: add __IGNORE* entries in asm/unistd.h
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 4:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Add __IGNORE* entries for perf_event_open, seccomp, pkey_
> mprotect, pkey_alloc, pkey_free, statx, io_pgetevents and
> rseq in the file asm/unistd.h as it is correct to keep
> __IGNORE* entry in non uapi header asm/unistd.h while uapi/
> asm/unistd.h must hold information only useful for user
> space applications.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---

This patch looks wrong: We don't want to ignore the fact that the
syscalls are missing here, we should add them instead. I'd leave
that for a follow-up though, we may want to add further ones that
are currently marked as __IGNORE.

      Arnd
