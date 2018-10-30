Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC75C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E882064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8hYkm3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E882064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeJaEGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:06:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38335 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeJaEGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:06:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id p3-v6so8002716qkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxBOD5E4g/NvF4ndMpQa9bRsTKNvf9E8V532kAml20U=;
        b=Y8hYkm3KIw/X8CQV5RX2Z+vC1zegJkWpgEfDj4xa+lpQnf8bPrgssr3VEu4pg6WHn1
         Uxm8txRkcOgHsmJMbbDayXjmGKBL40cSjDfaKvNCFdy8iwmcZagv31AV5pgcdKYBfBgv
         Nlt3yaQQ+EGht9IuzqIX76Gp/U/e/WE7mWEaOrR5d9eByJf7HDKNaYVBiaaRjtINFHCp
         R2kMZ+DsMfU8vaAh37WAnrUVfxXIEh9mY8Nbvw/qfAAbxa0N2iYbN+R/pgj8UmyLCjAc
         /HSBwIlAdtdXJP5kvzPXWP21UuAojT8B0m/mT/4z26op4DxdAVykeXSzUpK2jqXN5MQz
         MvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxBOD5E4g/NvF4ndMpQa9bRsTKNvf9E8V532kAml20U=;
        b=WCLBiGUgSDlqmSAKj3RA3ivlIS2WDfvZgpHudF041T7o+n+dSf40yJbYnxGMILO6oR
         1HjkockDDHvSG22fyNHou3jjA9p3bNDhvtuGgJXNHILUsDYsS3SNgmN8nlwHWD1tt0K3
         vRVB7001t7bkKzufYgQT3ORMKQvqMelXPUWNxj/cLU5gheEwFeE0wocEezVylMO5ES+y
         Tz8UYfPikcJ1/rq1nuczFCYVHk/O9TREBjk39o61ZjoCJzsuW82RTVlN/I8S6ka1lRzl
         QUghuBExPbXsQNg1meJ7ADXkjJOekZZYn21QBtef5KrRjbUYIdzy4hd2Dxd9TdN6OANV
         hs+w==
X-Gm-Message-State: AGRZ1gL9VL4qi4J5GDz5bNFzoxV2KV0CP+GTmtqPpnQkcDMkqlUamX5x
        CtmzK7k6ogJsPb0vE6AaW9CZNeyV3dzaO3RDr0mZ7A==
X-Google-Smtp-Source: AJdET5fq5iQh41LcgDU4Vsv/vYHlQ7Zm6+E+Mx9tVfp0iIgiS1K9IKQK1CU5RhcGwC/B5fVGhoHgj1koZk4XF8vlggE=
X-Received: by 2002:a37:5b83:: with SMTP id p125-v6mr149790qkb.88.1540926718810;
 Tue, 30 Oct 2018 12:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181022222614.41016-1-mikewu@google.com>
In-Reply-To: <20181022222614.41016-1-mikewu@google.com>
From:   Ke Wu <mikewu@google.com>
Date:   Tue, 30 Oct 2018 12:11:47 -0700
Message-ID: <CANRnR9SOtjVtEWnt3_5ZLGhTGxquycbDYkEiRFbfM2pAEz0r_A@mail.gmail.com>
Subject: Re: [PATCH] modsign: use all trusted keys to verify module signature
To:     jeyu@kernel.org, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

On Mon, Oct 22, 2018 at 3:26 PM Ke Wu <mikewu@google.com> wrote:
>
> Make mod_verify_sig to use all trusted keys. This allows keys in
> secondary_trusted_keys to be used to verify PKCS#7 signature on a
> kernel module.
>
> Signed-off-by: Ke Wu <mikewu@google.com>
> ---
>  kernel/module_signing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> index f2075ce8e4b3..a8b923ba1a39 100644
> --- a/kernel/module_signing.c
> +++ b/kernel/module_signing.c
> @@ -83,6 +83,6 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>         }
>
>         return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> -                                     NULL, VERIFYING_MODULE_SIGNATURE,
> +                                     (void *)1UL, VERIFYING_MODULE_SIGNATURE,
>                                       NULL, NULL);
>  }
> --
> 2.19.1.568.g152ad8e336-goog
>


-- 
Ke Wu | Software Engineer | mikewu@google.com | Google Inc.
