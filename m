Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB61C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B6D2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU22U/Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfBGVEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:04:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54687 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfBGVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:04:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so1329330wmh.4;
        Thu, 07 Feb 2019 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vzs5+xO8TOrFu/AzQQL9tefJptORwmLNWErK66+mj8=;
        b=nU22U/MlkdWjqQ/Mok/bA6iHuoBXSWVFWF8+lnY4NfAyZOZTUFZ3m0JLpmccmHRxrN
         RxvlliNwlmhmHft7jdVXE2VIYATxswt7KLD2krAbz3L+JG8pAa6JI8RUbCSDxg9E40zF
         wtU+0q77kGa7wXqJabIESYVwPlIbpmNLTFOQbDX7dQCrASVMHnTVEzqLA5wk2UN3T2hB
         OBC7aXfaz4i5+oxLKK/v+RuSBIcc8/EnIAuoPng2/Ja9LoE935fyq4J8pEfwLoHBfkB9
         VW2ge2C0+Nl42PuCC5+h2CUWUEVCxt8ZidGHEfq80uSMCM6wFi4a9B++36L/5SAV6szh
         As8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vzs5+xO8TOrFu/AzQQL9tefJptORwmLNWErK66+mj8=;
        b=Vh64pScHJYIdt3Qm+NdchpVQZD0hPdiY3x+ZxMPWpllY88dtpnqIGWLqTKdRXrpwPo
         QPCGZDa7i9M1SA3XdlRGnQZ9rqpQeRN1jSjhp7+K6N4SBPZ2D9CLfVfelnaefijtX33U
         ePysCZgwQQSB/7WV0SuH+tZSUOpWUBQAadCvTKRqu/mipu/xL4eXRyUL4SpNMfMTnx5t
         RrsX9OZtYqYLlqnk1gdxvyw+ISq6FJczUVUns9qXjBy5VbXIVPNkC/2t4Qkcblv45SFk
         bSpWTmt+fqMG/wkbx4tP6bDnRreHe9aD9sVYoFY2TmJFlSlsWxAz49/C1jR3fINI//f7
         xwSw==
X-Gm-Message-State: AHQUAuZXLkClOd5yHVNlYV4kdSE9rYM2hNQbtHSh1LChm+m0pAVdr9UY
        wdPUEsSEUCMlydbr589sxowvF5lEPfVcxWxKdA+ZKsq2
X-Google-Smtp-Source: AHgI3IZgPlpfw4AxOPEiReNNXSjix6lR4F6B1J9p1a6J6c2A++v06FzlcEwfyrigM8I9LJE6Zz2ZZr7sQ9fLH2w090M=
X-Received: by 2002:a1c:f605:: with SMTP id w5mr9256493wmc.116.1549573443017;
 Thu, 07 Feb 2019 13:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20190207000308.7051-1-andrew.smirnov@gmail.com> <63866354-48b8-5787-39de-5c23e7471f6f@linux.intel.com>
In-Reply-To: <63866354-48b8-5787-39de-5c23e7471f6f@linux.intel.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 7 Feb 2019 13:03:51 -0800
Message-ID: <CAHQ1cqGUohhev5+gFUMn3-6wK0zd5zkefr-RvMjtgWBaE1tunQ@mail.gmail.com>
Subject: Re: [PATCH] xhci: Convert xhci_handshake() to use readl_poll_timeout()
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 12:27 AM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 07.02.2019 02:03, Andrey Smirnov wrote:
> > Xhci_handshake() implements the algorithm already captured by
> > readl_poll_timeout(). Convert the former to use the latter to avoid
> > repetition.
>
> readl_poll_timeout() doesn't really work here as it might sleep.
>
> iopoll.h:
>
> /**
>   * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
>   *
> ...
>   * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
>   * case, the last read value at @addr is stored in @val. Must not
>   * be called from atomic context if sleep_us or timeout_us are used.
>
> -Mathias

Shoot, missed this part. Will change to  readl_poll_timeout_atomic() in v2.

Thanks,
Andrey Smirnov
