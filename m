Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7631AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2962420865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="P9OYeKlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2962420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeK0F1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:27:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39569 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725739AbeK0F1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:27:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id g27so17571316oth.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BUpaRIeEwEygjx+ig6iuVCu9RmSe3tffyqCGoB3WXc=;
        b=P9OYeKlZqR5KipT3PA8diTVr2Np7ZY3ykArMmA1Komh/nX62R0OQANvh8R9Bk6Wii6
         4+PWShtEEGIm3GGm2FdOHRHEknJvETbNoczI9H1BwJQ+JOR6OpEhABUua1nZ65RylvHe
         DvhIA+JoNL6ps36Cg9JRMuu+FsRvyvfgF5+Wn+Wu9mKUcCITTLn6UeQ1WUiF+LJZdqK0
         iDRs9yL8PdESeAqhNjGhep8Tk6DJmNvSkMqrA4ATnAApTeWVlr9lkGwQpW8xD1ZJygOo
         B91v1YUt6hBAmw06TX5Hi1Z+Si+lNjhtram/v0NBdxkOKo0FW+CaJmb/iyad7cRxKt5/
         8W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BUpaRIeEwEygjx+ig6iuVCu9RmSe3tffyqCGoB3WXc=;
        b=fFc9ZUPJbVhl+GH0iXT6Tg51SegZUy0VifGkdnSJgH2ZsH7qr6Mc2WAfkrTeUP8hC6
         KSlLvmP26JFBFBGj3vNNoHY0dU589T83hxS8MPIUGjBf3mbKD6w3hH9YklVu9WaWhudY
         tWgE+6I2j0jtViM0PbJtxHL8ZHtXdGYl9IpSkPLaQf1HSA+MWAL6Scb+pp9OvkPOrMTS
         GpWgyWxqPA+GDrrH6mvjQ8jwFM/NEYy+YnI98Fxy8q27UYh61K2Ynm9sjyxs4nqRBGcO
         ToIhsW34YbGvy4vYET6g0Car5JCFtnR/kHNgZQ445RSrXYKMGDHQBcoAV5lvFMiFJ747
         8aNA==
X-Gm-Message-State: AA+aEWZ1dmlqrbSSDTbeTZ3OWtzraVJBT9hrlhy+sBpMUoMd9ciXZ/Hc
        hyncLn7UQ3RzkZ9O/g41DtUKGL9uaY+Rjf64jGJOmQ==
X-Google-Smtp-Source: AFSGD/W/3UYho5tG0Kj3a3uMcg7r+XmhUWz8nraAxA+dLW32FXjkZ5w9GtpuL87sJuhyvkua5aPIE7uI77oYB44Iazw=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr15132906otl.32.1543257135211;
 Mon, 26 Nov 2018 10:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20181109203921.178363-1-brho@google.com> <20181114215155.259978-1-brho@google.com>
 <20181114215155.259978-2-brho@google.com>
In-Reply-To: <20181114215155.259978-2-brho@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 10:32:04 -0800
Message-ID: <CAPcyv4gY0qn-y6=EgmkhdHCozp4cLcutg26WC0vFyasv-etb-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: make dev_pagemap_mapping_shift() externally visible
To:     Barret Rhoden <brho@google.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 1:53 PM Barret Rhoden <brho@google.com> wrote:
>
> KVM has a use case for determining the size of a dax mapping.  The KVM
> code has easy access to the address and the mm; hence the change in
> parameters.
>
> Signed-off-by: Barret Rhoden <brho@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
