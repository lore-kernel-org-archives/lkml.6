Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C3E21773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfAIKLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:11:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38066 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbfAIKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:11:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id a1so4072878qkc.5;
        Wed, 09 Jan 2019 02:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HK0H4QHsqsYBpDgeVZp/u1YrJG4jKZciqcePdhXymvc=;
        b=lQukS1YfyW7r+t16/o12emWHrLFTpoDXWlWqB43s+KOgmrqzJdA4IW3W5w5gN73cTW
         LTLzbeqSuji8ul7/X9YKGZ/LXVdb1GZErcjBGUgtrHopfFFutaGY+qc1+gqZs3TxPBWW
         8a3gjbZDSnf+uKJb/7z4A7yvvhXwEdhnMWRuk9PEhfi7oxkLp1zqs+eVjsfrzUkUOKeI
         EfeXGI7oytgBijUm13B7toB3ZXW7xHdscKOWIY+XCwZtmZscH7RUB8thonj7Nqa/boOj
         +cc0YwVWyNir0UqBjBuuXzKLm/Vm+puXTN2EBTrpiNFfOKQAHTqJllui+1USNg4nTuR1
         tx5w==
X-Gm-Message-State: AJcUukcGLz9obu/tS8UCtURnRWV5ZH8WFJ0Z3GhI0cwUZxWJUE93cPKv
        60RmDVudttL1BvWJBFHrLp8ywGtaawjgSJq2oRc=
X-Google-Smtp-Source: ALg8bN7hr8gjnHLV2PmFQD07nhx4NsccHZrXynlWZ0pKtz+0i9ZZ8f6Ww3tRHrc+amTe0vjvpyZY7LE+ugqqMxeZO28=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr4677676qkf.330.1547028658854;
 Wed, 09 Jan 2019 02:10:58 -0800 (PST)
MIME-Version: 1.0
References: <1546871413-2433-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546871413-2433-1-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Jan 2019 11:10:42 +0100
Message-ID: <CAK8P3a2CqpjG4b9WNYwi5-B8=RHN+edji0p5_Y3Ln-oH_B-Auw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/syscalls: add system call table file for asm-generic
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Mon, Jan 7, 2019 at 3:31 PM Firoz Khan <firoz.khan@linaro.org> wrote:

> +242    common  accept4                         sys_accept4
> +243    common  recvmmsg                        sys_recvmmsg                    compat_sys_recvmmsg
> +244    archs0  arch_specific_syscall0          sys_arch_specific_syscall0
> +245    archs1  arch_specific_syscall1          sys_arch_specific_syscall1
> +246    archs2  arch_specific_syscall2          sys_arch_specific_syscall2
> +247    archs3  arch_specific_syscall3          sys_arch_specific_syscall3
> +248    archs4  arch_specific_syscall4          sys_arch_specific_syscall4
> +260    common  wait4                           sys_wait4                       compat_sys_wait4

This arch_specific_syscall0 should be fine as well, but there is a small
chance that existing user space code refers to the __NR_arch_specific_syscall
(without trailing 0) macro, so please change 244 back to
'arch_specific_syscall'.

Not sure if we should then count from 0 or 1, i.e. whether 245 should be
arch_specific_syscall1 or arch_specific_syscall2.

      Arnd
