Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6963C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694892080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXjD184b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694892080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJ3QPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:15:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35670 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeJ3QPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:15:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id 14so10164495oth.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4DJuc2i95zXJlo6qm/8qeVQ2k/FdiYTh2vtUfqEHMF0=;
        b=nXjD184bujdfTLhc2MD4rHMgHvxRPMtWf3zURasKYCodQys61tZz6CvyJMXtjthp89
         WxLumFErgqy+4jiGvkDbjI45UnhWFTLQVEKPiwlam2VYVZgwvA8G1gabKQCBoV0ROuYT
         LZjEPEU+WXf6trF/At2KUjOfMZX6jx8g4mRbpYXMTARPnXoDj+fWFZ7+ItHqCmNP7WON
         OzLYkBNpHdQMQHNTRBl/pERRWxqDnDq7UAwDjRXv1V2ZV+wEezXtvxA1eN2C/pP2tR8J
         D/JT9VxlB7c4nM6Yas5GxCC1NNWSlErn9uSe9Y1lFTjr5A5mzw9XPUX5UH3lfyOPbJXC
         ERBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4DJuc2i95zXJlo6qm/8qeVQ2k/FdiYTh2vtUfqEHMF0=;
        b=BZNs9aVL4aqg31uNYylBT1urPCir6ucYQ7FpINrV28uNcCMWnBqvtPa5lwV98fuSr+
         AFervZmOyYjVU2QdQb1oEZ46oy0RjCok54VFEK0JG6f1PuuordQluIKo9uiJiz8MfWot
         wCET6Y507yp9V8ocOXYnRMVw4gpqxeVCuTnlv7hmMEiNqu88Y/BiYF+pblfCq+qZo0Bd
         lMge8DHdC+WJkIsG/77nthDZuzhl9FzUroEFpZzNk5BOyjD2FHCb1KYqKEgFGga5Jp2J
         jpdou1zJn6cxmHbLC94sjVOR1UM6Mq06DygFFEalIoBrFrHRwj4oWq0MeyANJ5j8G1qP
         DZGg==
X-Gm-Message-State: AGRZ1gJMpw2lBYa4Hs/BFvgs7vbSdKEK6ZuzRDdwgGRPgOabXLYvmUS0
        Qzil6f7djQDj6MdEYx32hqwSay63zOANkDZYiPc=
X-Google-Smtp-Source: AJdET5e2r6USBRr5MQ2Qy/7+PtpnMuqXVQONVLGrjKrN7IEnjpM5vDy6fS0ezcmeclV5mYeTmOAct50v4DNoi1t6hlA=
X-Received: by 2002:a9d:7383:: with SMTP id j3mr7222828otk.117.1540884212956;
 Tue, 30 Oct 2018 00:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181029121516.29574-1-david.abdurachmanov@gmail.com>
In-Reply-To: <20181029121516.29574-1-david.abdurachmanov@gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Tue, 30 Oct 2018 08:23:21 +0100
Message-ID: <CAEn-LTpaTxPmb0De=834S5G6fA_Oe+mTN0bYk+iR4Amb4Sk1wA@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix trace_sys_exit hook
To:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 1:15 PM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
>
> Depends on:
> http://lists.infradead.org/pipermail/linux-riscv/2018-October/001931.html
>
> Why we don't have HAVE_SYSCALL_TRACEPOINTS in arch/riscv/Kconfig?
>

I looked this morning into Documentation/trace/ftrace-design.rst again.

Of all the things the document describes we are only missing
HAVE_SYSCALL_TRACEPOINTS in Kconfig, yet we already have it
implemented in ptrace.c (+ this minor fix). Reading document, I think,
we check all the boxes needed for HAVE_SYSCALL_TRACEPOINTS.

I assume it was just missed (?) and will do v2 later on.

david
