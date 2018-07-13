Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0002AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21D720843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ln1VBrE2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BeqzG5bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21D720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeGMG3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:29:36 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36297 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeGMG3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:29:36 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so12344184ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GzZeGfuL4DflS+9uKKdn08BhyPocXR6tIudCfDgUhEQ=;
        b=Ln1VBrE2HJHarvFB/G9ml4lHDvGeATjbzfIkb23DCGzYjgq3lY28QMMo8CL6uS8AGe
         qerE+CBQmabXgWUYe6KUUqE4QNJ5KxOhjtswK5JunXTzFSemgu5gyrAAeBjOsG0U1kUn
         xp5JqvOI7zqSKwjzqahCzxqhsB5Nu4LESwynYz7Ui5onGXnF/2mz1eMNkSBJqioY/2c+
         FO2ePC2Yw2hUNVsyZMC5Q6dHi4Xs2VoW7emDR/HdJMGuAXj4JZ8SbS89Y/pdwCrfb6Ts
         LLoeoZw6bqSpky46K3ayqe+UNhGm61pTMoaoDZVR/S9hF9nSoZ0xj8xdpN7UOxFOyBA3
         Yj4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GzZeGfuL4DflS+9uKKdn08BhyPocXR6tIudCfDgUhEQ=;
        b=BeqzG5bqCtMsHTtbWLGZZYPjTUtM44C4u68Zzkp8biTkMz0EbwxVKZd3kPEGH3/0VQ
         rhe6CJaE5s7/kVlgWwnQ1z/zNNdcNxf0LJIRSPz+Srxm+whP39gm32Xeo7VtIT54AqJj
         B5aE0mxsz61kUTfQ86vd3rXf8e4oexnWJBenY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GzZeGfuL4DflS+9uKKdn08BhyPocXR6tIudCfDgUhEQ=;
        b=QWZizyxQ4mAxF6W/8f86lbYZ1dXRuO/svs5ycv+CUMIQteoASV8Tmv6hfdAl2woTxb
         XDbLXxeTFK5wY8jRcWzdWonYslkRzk2ELSoVwFzePsxuMlyllHCExMVwkpzdz8o2v72p
         baBsMn8kqSdbdBQebufG1L6AAM0AIYIjjwLO6r/gHP8MqT/BeNAyOnkXbWFcacz081ll
         gApuXLFKQ0joKaScXH9FURTAn3eUN0q5jMhpD0eBjs8w2mdmOj/b3NzHZS5Yycq5Kinr
         dswBvWjxSWdmEin4l0xH5L3sf0tO9E8laJs1oumx7C+ZSODH0u8jxSd7e+72IgI+vUrR
         p8kg==
X-Gm-Message-State: AOUpUlEIz+4+ozUIEGgMd73+GquMJAy4zwVJfkdcqk18TK1+Hi1K2rOo
        WyAPoQkTnyz4+hR6oLhIpr/SBfvQTfkyNQrhJOYVUA==
X-Google-Smtp-Source: AAOMgpdg0P4o3eLEmwKqxBb2B+Ww4lO9bQ5gwfuKveqWC6QwZ6YQLnEbG2ShYuaStmmxh9t3wpi4mkBO7aKvQVP2Ues=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr2562083ybj.343.1531462589307;
 Thu, 12 Jul 2018 23:16:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 23:16:28
 -0700 (PDT)
In-Reply-To: <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com> <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 23:16:28 -0700
X-Google-Sender-Auth: U7ioNlkGKxxGI5DFsAOqJ-kLAEw
Message-ID: <CAGXu5jJOZ3u1BTf8U20wErphfjKzaGK+m1sdhA89LqVP3MDYZA@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 5:40 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Jul 12, 2018 at 06:02:26PM +0200, Arnd Bergmann wrote:
>>
>> Looking through some of the drivers, I found this interesting one:
>
> As I said before these patches are fundamentally broken.  Users
> of AHASH_REQUEST_ON_STACK can only use sync algorithm providers
> and therefore drivers are irrelevant.

I've also now gone to look at the few users of AHASH_REQUEST_ON_STACK,
and it seems like they come in two flavors:

- ones that can be trivially converts to shash (hibernate)
- things that use scatter/gather

Is this correct? It seems like you did the bulk of
AHASH_REQUEST_ON_STACK conversions in 2016. Can shash grow an sg
interface?

-Kees

-- 
Kees Cook
Pixel Security
