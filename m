Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08850C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C2727E32
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MX4U8l+k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cFLJb2jC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C2727E32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937342AbeF2U1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:27:12 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36111 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936587AbeF2U1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:27:10 -0400
Received: by mail-yw0-f195.google.com with SMTP id t198-v6so4078236ywc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yId4Zanw/xZc7Twv8oIAnhs2neDsM4bXUG6gpQ9oA/I=;
        b=MX4U8l+khWXp4PkPaZp8Voj8Ya9+S9tQjMCHnaPPtnk3DgmMzOdOXeNHKeali4odFU
         hdBPOZ8rE0Yebo2UjBQ4VyXNOtjr6vsFa1FxiJreDi2iFHYovcUO4v1tapNeaTdRdCTI
         9Hd9IUay+xfGBYkvulIHUwAOB4oexVVUNiu2u5HWaZw2On/RbpPrJenIBIH7Wl7tdrCw
         1H6yP51nq+/guETusUDPWa8xsb9zZOsubjQ5BbksH8YL4n37JY0V2+ZaqOmBrnq83HUC
         wUH17mgSlFC2WuIXhr2YDCzvw/ujwL+yguul9mhX8jhNybmkdStxhPdeAX2xiWh8lZkL
         fhHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yId4Zanw/xZc7Twv8oIAnhs2neDsM4bXUG6gpQ9oA/I=;
        b=cFLJb2jCDW3ZnYRZP3tM78sLqSATYIGFI17lH7MFMCFE6XuhoAZlh/OWDLBT7IXFgb
         dNy3WOLPbS5V2Qrs8zHS1ajuHyg2LDp6IUJn/BJN/vpodwriz2dts5FEibnN7ign5WKl
         GUHpDd6ICr1rMH6d4kH8S7FaSjTl6ZPynneZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yId4Zanw/xZc7Twv8oIAnhs2neDsM4bXUG6gpQ9oA/I=;
        b=XdZaZXedNiqy8nRhz2zwXoQ4fGrCW06uKyCM3qQt/ClBTABzlb9vajmSSBSOOVKX20
         hHg0sHSyuOFo8hmT1CuuFTTihe/2fxksSFOpTLQhSejW1svSSMeotC4o+ZcIn/RcbUo0
         LVpsKjpxtyGzQ/aC8aETQrn4pbBsl6cOWoVT4tLlNruGT5zkE3l2haaZ6bSdZF8ZQ28P
         dkO/hZQmf4nZkV442no6W9KVG6hKAsoW/7BCxrQ1FJlNIgQCPc33XmBKrXIpLING9PMo
         Sqrrj391Mwd4hiU6dGbkV48Mn9vQoF2HgiPELMOFc+QDFhccSFw64OKIQE6A3Tz+HzFn
         kgeQ==
X-Gm-Message-State: APt69E1qXS6T3hVBmDTxWpN1QwCuaORXAmLqqFVH3eS6F6HjwFvjW2dF
        mK2pxaRAE5Gfl5voXXZjhOFVw/VDzvfx+ICfeI8REQ==
X-Google-Smtp-Source: AAOMgpf5AwUQceNGJFaLYSUbchq/FlF3ddJGuiGA+azb6L9NLCdGiNYD/LoZpPOALkG1LvgYpChTBXMLrlLwqp5vtBA=
X-Received: by 2002:a81:8743:: with SMTP id x64-v6mr8021995ywf.129.1530304029402;
 Fri, 29 Jun 2018 13:27:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:27:08
 -0700 (PDT)
In-Reply-To: <1530302661-20953-1-git-send-email-kamal@canonical.com>
References: <1530302661-20953-1-git-send-email-kamal@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 29 Jun 2018 13:27:08 -0700
X-Google-Sender-Auth: wSOk9NmdenDRm2vuX3bMsGR4DDo
Message-ID: <CAGXu5jKXtq75+HkziTT-8F0VHvvOiRrtfez60h8hKK1GaE64ug@mail.gmail.com>
Subject: Re: [PATCH] security: CONFIG_HARDENED_USERCOPY does not need to
 select BUG
To:     Kamal Mostafa <kamal@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 1:04 PM, Kamal Mostafa <kamal@canonical.com> wrote:
> Allows for CONFIG_HARDENED_USERCOPY without CONFIG_BUG.
>
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> ---
>  security/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index c430206..7667774 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -153,7 +153,6 @@ config HAVE_HARDENED_USERCOPY_ALLOCATOR
>  config HARDENED_USERCOPY
>         bool "Harden memory copies between kernel and userspace"
>         depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
> -       select BUG
>         imply STRICT_DEVMEM
>         help
>           This option checks for obviously wrong memory regions when

Do the lkdtm tests for usercopy correctly halt the kernel thread if
CONFIG_BUG is removed?

-Kees

-- 
Kees Cook
Pixel Security
