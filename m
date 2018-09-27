Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472EFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003C3215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJNrxBkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003C3215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeI0Rrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:47:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42251 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeI0Rrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:47:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id w81-v6so113397oiw.9;
        Thu, 27 Sep 2018 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G2vP0zniIugIakmSQP/hDk8xkBgbaD03o052KVRdnbc=;
        b=rJNrxBkqzy9XtVJl6EHlcBu/HFa0gb4u5lXO/kZsuipaouAD2cmSTQ93TAVStAxfkv
         JejvPpebTaa8UaBc1HCypAKxQHwbsUiLxObRvUs8ICCs9hVBUURu9byutAeHx0ErD1UY
         GPhsYw83KGbFB/p0D4XI+EeVjzLwzBH+TMxRo0KRMdQ1GbCKH7jzrKDnKOS54ZJJXtsr
         oIN5G7YjakSq5gYLLmEEyHfeFbF427c5qbC0ZfyZZcbEEVgMAJhxIjTk1n6DGcEWhQdJ
         hQC/PBxYSe4pFsmzcDkcOTmZ6DI5ey3rE0KaE5Ar24Vo6p9GJ9RjZxE3EdXcK3P1f4xi
         kxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G2vP0zniIugIakmSQP/hDk8xkBgbaD03o052KVRdnbc=;
        b=Op0mR2obAcQ3tfU/AZFHedWqj4KY2m9wZYvtf4rOXgEm0cM8EcquBokFVqhj7vXvk5
         eXDoKerAl2UWkhAxlyTygxaqzQpFMam9NS2JAglm64/R/0eVIYRgTFWzyoEDFgQ6HeQW
         sYYfcisndn0M2ZNVrrPtjztAciF+QYySwUaPtpH6BRh294ZqxfLsE+Fe1E4Xoy41qeJ/
         X4LW37nitytytbK7cxOFu179ThDR5fRmxvVBwHy3ZsyaVYd+YuMVA7rPhvmSSvGqrg81
         Hou62gVXvFqN9yHBAQj6l0oiDMU/7CJLBf/RjjLJrLTVKZ1IwF6rCDB8Qoft4xxbXjBW
         82rg==
X-Gm-Message-State: ABuFfojwUim4Bi0UxacG8FEhrfH/uja+Vo+2EfEzY6Eyw9HS15XOaweP
        OLNKFEEYEnhJrv4nj7YYTtYkcT+JdT/aDXr3+sc=
X-Google-Smtp-Source: ACcGV63E5tg5QcTj71o2vKSvd01j5aTNl0ne3MWbnUYZDf8/A+VOxfPBs8v0jg5ZgYjgx85NmqbYeZfyb3mM4lE1z/g=
X-Received: by 2002:a54:4516:: with SMTP id l22-v6mr2851581oil.0.1538047805119;
 Thu, 27 Sep 2018 04:30:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:59c3:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 04:30:04
 -0700 (PDT)
In-Reply-To: <20180927090258.591819886@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org> <20180927090258.591819886@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 27 Sep 2018 12:30:04 +0100
Message-ID: <CADVatmPQQCaUrMYxP-STbP50HVSr68ngQcYLXcBgX_6B0QZ6Sg@mail.gmail.com>
Subject: Re: [PATCH 4.14 64/64] crypto: x86/aegis,morus - Do not require
 OSXSAVE for SSE2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Zdenek Kaspar <zkaspar82@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Sep 27, 2018 at 10:04 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Ondrej Mosnacek <omosnace@redhat.com>
>
> commit 24568b47d48ec8c906fd0f589489a08b17e1edca upstream.
>
> It turns out OSXSAVE needs to be checked only for AVX, not for SSE.
> Without this patch the affected modules refuse to load on CPUs with SSE2
> but without AVX support.
>
> Fixes: 877ccce7cbe8 ("crypto: x86/aegis,morus - Fix and simplify CPUID checks")
> Cc: <stable@vger.kernel.org> # 4.18
> Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I am confused with this one. I am not seeing this in the "git log"
from your 4.14.73-rc1.
I also tried to apply this from your queue to v4.14.72 and it did not
apply as it could not
find some files.

error: arch/x86/crypto/aegis128-aesni-glue.c: No such file or directory
error: arch/x86/crypto/aegis128l-aesni-glue.c: No such file or directory
error: arch/x86/crypto/aegis256-aesni-glue.c: No such file or directory
error: arch/x86/crypto/morus1280-sse2-glue.c: No such file or directory
error: arch/x86/crypto/morus640-sse2-glue.c: No such file or directory

Am I missing something?


--
Regards
Sudip
