Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A902ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43708208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYrtRwvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43708208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeGPL2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:28:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46034 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeGPL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:28:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id q5-v6so29533984ljh.12;
        Mon, 16 Jul 2018 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jPWgGz67s5DYmr9dcacDNKeXx6qo4aIrk1hpzOtFaDY=;
        b=XYrtRwvnuIZtYu76KL33QV2uQp1BNUMrKAXQWuOo0vZIGspOo8JFwbdjkuXDNrVFHY
         N3ywoGh8uESe5VkK3CiYH1pLhqw/ws4dWHKTJvAN1wdYjiNNs77lblDv945a6hm5E3Lo
         6NIw4k5HvQgJDO6yZ3mtka0SX0fotQm+ZFPDY1NxvbbO8V7Ryq5vf6IbLajzjKFmZ4UA
         rdAYqWXafpIX0W5/iuij47M5x0TwJPnmgm3sIwBBC3p3VTOCcj6jH4Ntl5L81JtHKMcR
         4MTnvqQFU8BzZ5xxpaoWNatsaC3SVQwRYiDIkQ37xGib5QYaIZq4oJo3yapZQz57/zAr
         5ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jPWgGz67s5DYmr9dcacDNKeXx6qo4aIrk1hpzOtFaDY=;
        b=Kt8mvWMHFYthxYZtqQ+KIx/iRG742hELJVKFUbPTb2yZNVIQS30OD2LoLx4S3+C8sE
         1zgR6MtlvSZzTMSkrVVPx+FW+f4d6b8m6+rRCB/42CNy+LZyo1XfolBUwnOVd2gQOTT6
         TRe8oG8puvGkmQ44s6kTd0dIJ3g+tUThxrKrDqiWlXROhBh4y66/8g5lksnfBZL349ZP
         BLLBaoRptAWDHhHm1L8RYaIp1LPRrTKTiDTUoaiNWdgFuPlPypqRbg2Q1VJjCpDzj9iH
         gL2e02/BTbZf3GMfwsgtiGqHawCwuFbPoptMWxmhjseVN0VqkD8IeqiwJ+II7LEwv2Dx
         DcUQ==
X-Gm-Message-State: AOUpUlHBywH4885GYv7nVyNJ5EZK6odIOkwynydGUWBtKXwdGpFHPVNJ
        +Ylzc0WuxTlOO8TIkWZLRZTKiup3uSivkcrcjRY=
X-Google-Smtp-Source: AAOMgpcPZTfS/EE8WEywz2WFSBm/fnI8xQ88e7qAxopBtJERujlLvcRWZG1q/Ay58IDffczCWJf6hPkDD4m4c9MkaqU=
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr9653842ljr.38.1531738895666;
 Mon, 16 Jul 2018 04:01:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 04:01:34
 -0700 (PDT)
In-Reply-To: <20180716040516.GA32783@beast>
References: <20180716040516.GA32783@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Jul 2018 13:01:34 +0200
X-Google-Sender-Auth: gnmpyU9MRA09LY0w1bVyKt_HGuw
Message-ID: <CAK8P3a1tph9VPJnYYhBvH_1wZ79wXDvfnJt_CEruj3T-TBG1jg@mail.gmail.com>
Subject: Re: [PATCH] ppp: mppe: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-ppp@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 6:05 AM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK (and associated
> VLA) by switching to shash directly and keeping the associated descriptor
> allocated with the regular state on the heap.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I had concerns at first that this approach might make it slower, but
upon reading through implementation of the shash_ahash_ implementation,
I concluded that it can only be better than before, improving both
performance and stack usage.

Acked-by: Arnd Bergmann <arnd@arndb.de>
