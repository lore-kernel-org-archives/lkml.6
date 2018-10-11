Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE2DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3203920659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtX2SYIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3203920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeJKXat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:30:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38120 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJKXas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:30:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so10446096qtf.5;
        Thu, 11 Oct 2018 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LnaAFkpRwfLe/B3ufddRI6x2C60FFqK2USjNFtglROM=;
        b=RtX2SYIY9/F4KMY9fFD6hkoSXS9xkmJR+NjF7W0DustGxN9/NGQSyO7F2kWlQf4hOB
         XIL3LZsniNnkX4uyXjBLIkDgeXI9tP5YYPguZkumlHmUc6jI4XOAYH0ngIHvN9PpOe5p
         zD0CUiD4lWqBZj9VZuxio1zmLX5CNzlPthXUcdoqxig/4EZ8u89HARWaeH0T37bQ4Rou
         lchIth1X8VU3Ad7tgbxAuG2UFguMrLuD1/ERfDdS0j3aEjLY9T3tdYSY7qK992F7dLTs
         hqQRCa/jhDSm5Yj14X727q18sM1g3XyeMUvvXxg/HL8Ty1i9izgcdl3/cZSuLUowtqRN
         2QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LnaAFkpRwfLe/B3ufddRI6x2C60FFqK2USjNFtglROM=;
        b=dgR+/wl4UhLjjyBo8kaIPEMbwG2UBAowXPmVIgBbU3IQYSHnUOeUwWcrl8yyOTJ5Df
         QxHqRV2h/HQMYT9ykCaaeu0PnUKaKocJny83887C2G779BejkKh/90aAn7a8rjIkY0zw
         3c8eo5qgCSCMbTq5tXXaaNkpBvHboGXNnVt3y7fHFzI8fF6boiPOq9aWGn/r59rozaFU
         eGKqEvnYWO2iNNs0UF5TH2VES3A5xXjqID8ngk4IIzaaj/ifg+ft074SlopYUftA3Upl
         numq5hjqKOz/h955UxxK+4zOulUAbrBMRgqXeeSZGN0rmaTotQrFZB/Gn96xUt9s8ngA
         YMVw==
X-Gm-Message-State: ABuFfohSlJC+oCj+LpVK54UpWU+928rvseGJ/X6W1cBtbbEXAwsl05/W
        XyNmoeH1kjWns47aoVAlytZjkJGHVlhrDmr5oQ0=
X-Google-Smtp-Source: ACcGV616GRSiwSaW+vTBm+Y+8bjGHIPxO7n9YOCXe7zL2JKRlrn3zCrC1ufs6kZYFRDVehpCvZaHE0SwL2lb7VaNK9g=
X-Received: by 2002:a0c:881c:: with SMTP id 28mr2179099qvl.40.1539273777384;
 Thu, 11 Oct 2018 09:02:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 09:02:56
 -0700 (PDT)
In-Reply-To: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
References: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 18:02:56 +0200
X-Google-Sender-Auth: resRB1-556fg3xjU8OHo0VbLWmE
Message-ID: <CAK8P3a3PjfQHKb_Chmn6RDyLV7+xE=s_AAFdt+fNshohdD7Ztw@mail.gmail.com>
Subject: Re: undefined behavior (-Wvarargs) in security/keys/trusted.c#TSS_authhmac()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Nick Desaulniers <ndesaulniers@google.com> wrote:
> Hello,
> I noticed that compiling with
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> and Clang produced the warning:
>
>   CC      security/keys/trusted.o
> security/keys/trusted.c:146:17: warning: passing an object that
> undergoes default
>       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>         va_start(argp, h3);
>                        ^
> security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> char' is declared here
> unsigned char *h2, unsigned char h3, ...)
>                                ^
>
> Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> standards explicitly call this out as undefined behavior:
>
> The parameter parmN is the identifier of the rightmost parameter in
> the variable parameter list in the function definition (the one just
> before the ...). If the parameter parmN is declared with ... or with a
> type that is not compatible with the type that results after
> application of the default argument promotions, the behavior is
> undefined.
>
> So if I understand my C promotion/conversion rules correctly, unsigned
> char would be promoted to int?
>
> We had a few ideas for possible fixes in:
> https://github.com/ClangBuiltLinux/linux/issues/41

I arrived at a similar patch as the one cited there, but it broke again
after an 'extern' declaration was added in include/keys/trusted.h,
so that has to be patched as well now.

       Arnd
