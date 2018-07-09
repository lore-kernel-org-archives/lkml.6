Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFB8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E77120864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OTSENwBm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ckgsGr6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E77120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934181AbeGISGF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:06:05 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37684 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933795AbeGISGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:06:03 -0400
Received: by mail-yb0-f196.google.com with SMTP id r3-v6so7545946ybo.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IloA37DvCyuNdTRwenSBEvNBHMlSqke0mfNY5vWGHa4=;
        b=OTSENwBmUwK23CKH5pCUqTjM017CyoQ1ZiJ90gQ79EEo2o/KIWIApa7CejxzApJhjf
         yCELFxxAb/MBCdX8udcel5nfJIbfG8y8OlGgfqh/cywaYfv2eYDvfpG7+wRkJmK6RZCk
         7Rj5j4nZCIQfZgLzrt6k308B09doX74pbsuvMW9vE5FKNcurKrfWqkkLc9ACSp8TwEXq
         YI1jyddAnyIl707GWzJxCGTsUboEsZnAfIpQXw2HiVICaHzFtah21QMuBiVlpviLA56a
         eqtfd3Rqe6eVIwYT68Tld7itGczgDek1frmWVwTuapSbpJ84qN2/9CUf/nVpk/mlIxpE
         52bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IloA37DvCyuNdTRwenSBEvNBHMlSqke0mfNY5vWGHa4=;
        b=ckgsGr6ARD/8628Ju5Zlp1ElNeqIB4est1bj5MJm56WqMggV4Up6hUPy2blA9RA858
         ZvvtsLMJYfNfSt/RoklO/VMA9Je3ecIniTTnxjaOqEUJbuFwpXA/oz/RqdT0zDGSXuFW
         Z39SkkgUkCGul6IDg+FdkKVBGX3cgexcJsEpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IloA37DvCyuNdTRwenSBEvNBHMlSqke0mfNY5vWGHa4=;
        b=ZzO3W4DDJj/Xduu4dpd7kx0pygYTQFusoB30yz/hPU2audNjsCZerZL4sgxnGsFnNY
         W1FXpGKqZmn2LAQ9LvhJlyBctCirrEF7Hfqj96OIDXH5MYcHWWNJKNQp6AIBHEcErIwR
         d6S/PLrkdG14FQtOzJfo8YRfCNkkojyjZnHxz0IAsD/V3jE+B/y9HaWsimkeQT/K8H/f
         jPAQ3SpxJbAMtJmfInySLOhRi1V2qZTgYsCQeLPIf8RdLmkN/wlkPcCTWdvlbdOTIzNA
         4rXzNxlVzaq6SmQ7fGxee0BYzz+x8svIcZQprVS8pE6MRv6SSxR6oNLxREaWAJ4GSkYd
         FdrQ==
X-Gm-Message-State: APt69E1pVrx+YqOTwxmB+5uxbHTItnepdU+nDFSZ44ISPvZUE/ssbHzs
        ExU7fMhkRQ4gFHt09Umm6NguhsQjlnUjXt+cvE+JaQ==
X-Google-Smtp-Source: AAOMgpdWXktfohWU/1w6Sv6eneIMlVsZH6t1XiGDwGTsIkEC7CtMLGQpQLZj3rJ9eJ7+6QJDUClif4uA2vqQQVpSJZg=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr12005265ybj.112.1531159563131;
 Mon, 09 Jul 2018 11:06:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 11:06:02 -0700 (PDT)
In-Reply-To: <20180709175550.GA7469@roeck-us.net>
References: <20180709175550.GA7469@roeck-us.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 9 Jul 2018 11:06:02 -0700
X-Google-Sender-Auth: _eixSMD8Zz7WeZmbElWh7gTUCNw
Message-ID: <CAGXu5j+rn+69QiLR=Rbd6ys7atL8Z8THyazW_T3Z=CAw0n8xzg@mail.gmail.com>
Subject: Re: Build/qemu test results for v4.18-rc4
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 10:55 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> s390:allmodconfig:
>
> arch/s390/kernel/als.o: In function `verify_facilities':
> als.c:(.init.text+0x24): undefined reference to `latent_entropy'
> als.c:(.init.text+0xae): undefined reference to `latent_entropy'
> make[3]: *** [arch/s390/boot/compressed/vmlinux] Error 1
> make[2]: *** [arch/s390/boot/compressed/vmlinux] Error 2
> make[1]: *** [bzImage] Error 2
>
> This problem is only seen when using a compiler which has the relevant
> plugins enabled. Bisect points to commit 1658dcee3d43ed ("gcc-plugins:
> allow to enable GCC_PLUGINS for COMPILE_TEST") as the culprit. I don't
> know if a fix for v4.18 has been submitted. The s390 boot code in -next
> has been rearranged and the problem is no longer seen there.

Hm, that would imply that mm/page_alloc.o wasn't visible during the
als.o linking? But ... if the problem is gone, I guess... good?

-Kees

-- 
Kees Cook
Pixel Security
