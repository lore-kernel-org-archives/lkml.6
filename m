Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFD8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248B22084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248B22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbeJATaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:30:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34228 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbeJAT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:29:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id y10-v6so9770597lfj.1;
        Mon, 01 Oct 2018 05:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4huskFt1PgMtkdAvQiYOBlD5ExXcCAX9i/lj8xIq9fk=;
        b=d8I+GTSA8GUlMWLLbl2xsk4vLT8c5spXnt98HahStIQ7szViBDqmYdevM/Oz64vznR
         6AKQ/CxgfBJa7vEXzfW+tyKrJWVO7NIbWN/4J8YkN8p0vMbKfKsG02Wt8+AJsW5c9uEY
         dU/1WIj9tqi3KBRefawef6BlxQXbThLOnXqnLYOD0AwGSmtqs+zp+uO1iGXEvWdRPe3c
         rqnr3wR2FOfSa/i75QwCAZJHmjxvNBSFeca8SvbpxMRYjn3oFN92XMMrq46c1yqdy/4j
         9HjiWt+Pid0fGBt6mRtw9LiBQlnEUxatFPIwXXWRXfZEwFSQs9cU81ElegqXsWCdGJFM
         SeIg==
X-Gm-Message-State: ABuFfojtg2MSILX4bi9XSFdspaQrCZiSFg6ixUlNNn5Tl4oVGyGcFmM/
        jdHgr5cM//oTXr/woUyyNy8l26XNcpRSdtHWGdM=
X-Google-Smtp-Source: ACcGV63rkw/HjuYxk9aQAAVssvh6EotkLK1w+35eGDgybJs9vFyKbg4le4z9tSCwxZGHw3r1pvn1VYNht8E11+l87gA=
X-Received: by 2002:a19:9d8d:: with SMTP id g135-v6mr5836977lfe.3.1538398336682;
 Mon, 01 Oct 2018 05:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org> <1538397477-4003-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538397477-4003-6-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 14:51:59 +0200
Message-ID: <CAK8P3a3_NjWWPnoNjg0cgoAMyYCuG4ABqy-z9CyjROjLGxeG3g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] m68k: add __IGNORE* entries in asm/unistd.h
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
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

On Mon, Oct 1, 2018 at 2:39 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Add __IGNORE* entries for seccomp, pkey_mprotect, pkey_
> alloc, pkey_free, io_pgetevents and rseq in the file
> asm/unistd.h as it is correct to keep __IGNORE* entry in
> non uapi header asm/unistd.h while uapi/asm/unistd.h must
> hold information only useful for user space applications.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/m68k/include/asm/unistd.h | 7 +++++++
>  1 file changed, 7 insertions(+)

I think this one needs to be dropped, as I commented on a similar patch for
another architecture (I forget which one). We really should implemente all
the syscalls below, with the possible exception of the pkey calls.

Note that we even list pkey_* in architectures that don't support the feature.
See also the commit text for a60f7b69d92c ("generic syscalls: Wire up
memory protection keys syscalls")

     Arnd
