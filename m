Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE8C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE102086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxD7h1hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE102086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJLLcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:32:06 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:33938 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeJLLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:32:05 -0400
Received: by mail-yw1-f50.google.com with SMTP id m129-v6so4477025ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bML/mDmDI//IU4h/fTLC2TM4+sEZurQ5hghChA7ypBQ=;
        b=VxD7h1hutE92QjAH2aWkHhHKRaA6eZVFazfG0EWG+xN01xSFhQoucM4Ae5x0wJ9PI0
         4T/EcTOtYjPBIx941gFwnYXMiUeSFPD0I1s8Qg5Hg3bO0ZdVOMML6bTpVL/BCXA3Pbw/
         ylby9rZCjF9ohjg1Ci5CV51obg0KyuHGx/6co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bML/mDmDI//IU4h/fTLC2TM4+sEZurQ5hghChA7ypBQ=;
        b=Zt9kUxlkyULEnDwMuBLO1c3gR4hF+1+hgdLNpdmKq+LJHnUbcugvZvCz0lDDbRcxz/
         VWsDX495wTChXuaLllHP4cpssxPKmaiu2I5k5RZ4YgVKZvHpMYWLWVBrUkS1tw69WK9j
         iAorB28Va7pwssLneCWOE0UnEx79VwuD6vYdMq3/3XWBbQEKM2KBpgSf+j60wEln8rpk
         QeDY/3BxNphhZR0l5aHyubL17NWnmgpM9am7zmgEUUfpmZc+IxmisUVk0ZjWsze2F7CK
         +Hbw5tMf05e88C1SHWeFIAN3G2WLEy7BZdLZpWYmD4b3Su/z7XCTWrcvIoqpB8c78kIA
         NksA==
X-Gm-Message-State: ABuFfoj144acF9LfL8U0CYFVctmWTut6IeM0mFcyZTKZDDgQyfygalX7
        pc/kc381NvKnCLy5U9SrDuPMpcfLn3NV/s4wnpP+yg==
X-Google-Smtp-Source: ACcGV6266DKMgue+pxntfSJ79e2cFPFhfptq7hwRe0KMkyPJOhm367mfz9zr7PbDfqeXrQSxh8qrUM9dgK3Fz+L4pyo=
X-Received: by 2002:a0d:d801:: with SMTP id a1-v6mr2429648ywe.399.1539316900991;
 Thu, 11 Oct 2018 21:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org> <3908561D78D1C84285E8C5FCA982C28F7D40F9DD@ORSMSX107.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D40F9DD@ORSMSX107.amr.corp.intel.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 12 Oct 2018 09:31:30 +0530
Message-ID: <CALxhOngtGNP7MATzwtMZd_Xw+rqvdhP9NMtTxwCEgmzayZshOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] ia64: system call table generation support
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Thu, 11 Oct 2018 at 22:59, Luck, Tony <tony.luck@intel.com> wrote:
>
> Third time lucky. This series boots without any obvious errors on my ia64 machine.

Great! Thanks for your support!

>
> That's not and Ack or Review ... I just applied, compiled and booted.

I suspect the offset logic in the system call generation script had a bug. That
I fixed it in this patch series.

Arnd and Eugene had shared few comments on adding new system call entry in the
table and some other things. Appreciate if you can review this patch
series so I can
finalize system call table implementation for ia64 architecture.

Firoz

>
> -Tony
