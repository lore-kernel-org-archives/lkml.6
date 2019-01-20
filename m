Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECFEC61CE8
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFAA2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C54ILMlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfATBvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 20:51:23 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44680 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfATBvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 20:51:23 -0500
Received: by mail-ua1-f65.google.com with SMTP id d19so5881520uaq.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 17:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7BbmGr0HTL3SKEnOU556dNzvnNLbzxMHiMhLjnBKNc=;
        b=C54ILMlN0B/CmULRDKjLs+2SS+11vlgTyMT0woHHxtNKrF7j+gexrtRHiYQcFiaEFf
         Y/CFhICif2VBLHCTSmIUlfPzpqhrUTQ/TU/xl6Id14HvCj6mDBiKjAosqGzkak/sx7jk
         y4FSCo75E3N2I4eJ34wie1YjaEAFmd/S7uOUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7BbmGr0HTL3SKEnOU556dNzvnNLbzxMHiMhLjnBKNc=;
        b=LFvbB2ACxc3Gpa2z9ajMnLqUsgdPToDzlV4nLeASthxCEHBsa12c6Jp1eLE6xsek1g
         av67fv8nRIULG0ezthM3eor8BKtfPnAExDFbETyzN+xMKW0Lj3YG9j3iV09scYMb44aR
         7mLV4EQKEe+7eidEUhmgAHWozBucA2MX++bm0rNcVYfnQpIr0D2OEM2ddg4TLGgzgqe8
         XXjg4QPwrO73IWq6hnnUDNQcxJDXIMy+wuySbWNjx92vO1gA3NE4HF2A0b3R/ERIcR3T
         U/Ue8bHLNKr75c9mAZ+N3RZhHiWi5PcJi+aZjQPELIeFj2wC6QqctcUSdO20kt+MhChX
         kPwQ==
X-Gm-Message-State: AJcUukclEdRLJCWmnNPG6jOb/gtaytD1EHvPsy9/qK2gqBkABVaJGJSt
        AO2GZs0JF/DZDkUQ/Cs+/Am+QPosxhQ=
X-Google-Smtp-Source: ALg8bN4aEzDGmgPmmadsXK717F8Yd1eJAqURzlcwSLU+LE5TP4ecweiwsp1VLlzhLE67bfPRgEtxiw==
X-Received: by 2002:ab0:621a:: with SMTP id m26mr8809568uao.36.1547949082156;
        Sat, 19 Jan 2019 17:51:22 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id w65sm18363195vsc.16.2019.01.19.17.51.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 17:51:21 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id z3so10715127vsf.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 17:51:21 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr10540778vsc.48.1547949080517;
 Sat, 19 Jan 2019 17:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 19 Jan 2019 17:51:08 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKa6Tzea9SyTi5aOZusnb+1+yTJhMNaz-Ha8sjR7oCWsw@mail.gmail.com>
Message-ID: <CAGXu5jKa6Tzea9SyTi5aOZusnb+1+yTJhMNaz-Ha8sjR7oCWsw@mail.gmail.com>
Subject: Re: [PATCH 0/2] gcc-plugins: fixes for arm_ssp_per_task_plugin
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 2:58 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> A couple of fixes to permit newer versions of GCC to use the stack
> protector plugin for ARM.
>
> Ard Biesheuvel (2):
>   gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
>   gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+

Nice; thanks! It seems like these should go into -rc4, yes? I'll get
them queued up for Linus...

-Kees

>
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 23 ++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>


-- 
Kees Cook
