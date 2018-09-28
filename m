Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F34C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8282170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8282170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeI1SeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:34:18 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:41615 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1SeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:34:18 -0400
Received: by mail-qt1-f180.google.com with SMTP id m15-v6so6280591qtp.8;
        Fri, 28 Sep 2018 05:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2e7UiVi1D9I/LeBvco++o20kVBX9IAhrkwkzOg8/rb0=;
        b=M2tGSFjjNt2UFu8JnBmA4D7MBagqzstHpiyYXC9H37oW/ZH1o6/0QZx4XCffVQoMXv
         3g7zlFlS/DslniBrd6qW/EaveK7Umw1ibJ1qCY7ZBOcqVC2HhGN1crX3gChd+dCuY0aN
         WfH9IsTri5bK3Yy5rnMhpn5/Vvaj5/wlrwwfv0nP9O9/g1KtPJu8QtBlJP419v97UrJq
         SUN7NI+uHaPb55U847rgPvWaZ42GsGEtrRJ57DzvJELo10bgjVR0RvdK7GuiaUR5hmiT
         s4qWsCcyWNIZBEalWgy8PIT42Mulx7t5vPx29pSPmqU8fXVEn7+EhnRp6b6h18JcD5rl
         MP5A==
X-Gm-Message-State: ABuFfohM1lKBJho1eXCp0nx1kEfdQroi7lgzBsBkqPYgu55EfJ0XieiG
        7zbvtNBzPF7uWx/oi/wMu/EvlmSNfA/uPvru4EDWKQ==
X-Google-Smtp-Source: ACcGV60rpSPSwn6W4urA9OL8CP+44PVgT6yn06JRLdXC1KWEyoUo+rncKCg7+XcPtZkd8GpOmg+TPNtUh+dSh8+iPWA=
X-Received: by 2002:a0c:f642:: with SMTP id s2-v6mr11770792qvm.115.1538136649121;
 Fri, 28 Sep 2018 05:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org> <1538057720-3392-7-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538057720-3392-7-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Sep 2018 14:10:32 +0200
Message-ID: <CAK8P3a3YkR7Qr=XnqvQTOn=v34rCBfW1+dqU5xpV4ysar+C4yg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ia64: uapi header and system call table file generation
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

> +#include <asm/syscall_table.h>
>         .org sys_call_table + 8*NR_syscalls     // guard against failures to increase NR_syscalls
> +#undef __SYSCALL

This part looks odd: according to the comment, this should only guard against
the table getting out of sync. However, with the script, that will never happen.

      Arnd
