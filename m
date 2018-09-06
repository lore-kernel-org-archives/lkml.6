Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FC2C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2A5204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2A5204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbeIFUF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:05:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39009 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbeIFUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:05:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id b19-v6so7595102qkc.6;
        Thu, 06 Sep 2018 08:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44/lx/bCCYlHDN8cucujEdw2totk9E8TcIXudE00W9g=;
        b=P1MX6wMHtyxhzuZaH3Nt+EWJ1BGjnWjrFbvJuoPjKGnvWrvdB6z4HbcJYrZsvF+aUh
         XX8lXJ3txleuCHWI5eSRmM0TE5GV+5SSxyPl1aJA1E2z8Ya/xTDa5ZSmc7cnpFv8Fjas
         TE4i1z3lSWI+/OdEIUfbyHKYSSzT460XFHJK9e6e9vSb74B3D/pKS5cfeFSB8oaCO6df
         OPYQsCyYg+XJO+4srWfFZ9k4K9yPqQEewm/2dh1Q3AP4NRm2nA1RQk9+A4wAVPDIBwsN
         sJ5ShX6m8rvCet4hVmbGmsHhzBlSZ46PWbVW7tD9T+rlb6gdUz1WXI2ztlIAkt8COoDG
         ZowA==
X-Gm-Message-State: APzg51CyjDNeGtSXNGq/75/uAPxWcun5eCAYfcue4Sdlj2IqI8dAq3MF
        o5/t16tGVDp5W7/8Xkv/b8DgltO0lCckbCxnJ2c+yA==
X-Google-Smtp-Source: ANB0VdYNDtFaNTQilfxBzTT+IOeTD9G3av6t+gX3sdkDbF1HpUbH4CRqqTOpat4mDCIppVAxJ7ETNrmS/5teQOaCcXQ=
X-Received: by 2002:a37:1b62:: with SMTP id b95-v6mr2360957qkb.343.1536247795441;
 Thu, 06 Sep 2018 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-3-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 17:29:39 +0200
Message-ID: <CAK8P3a3_tzeKf2PFa4LMym3UgBPu380H9LGyGLTDJEu7aNyecQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
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

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:

>
> -#define NR_syscalls            361
> +#define __NR_syscalls          361

What about the suggestion that was made earlier to enclose this in
#ifdef __KERNEL__?

     Arnd
