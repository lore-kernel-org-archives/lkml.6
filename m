Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E591ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298602087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jmXYYBup";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8DXdTyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298602087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbeGLVqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:46:14 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35814 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeGLVqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:46:14 -0400
Received: by mail-yw0-f194.google.com with SMTP id t18-v6so11020325ywg.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/h3XgWema/r4fY0IZGG28wrJc/TEj3osDTSEZ+7zkAA=;
        b=jmXYYBupeBpkHMuGIs4+x5UFLOndLD4N9mmAOjDdOpfaRVI0LGhcjXnmPkzraHTE2Y
         u6gowRdDOQuimCra5WYnRe+xB5yyvFhS2k1boaq0AGfhs/eDkF5JAj3/8cKvMIPusM88
         Q9vIcVrfsrumiS+8b3igsRRwi2Qy+2M6SkwkeWuKgG+bUKLpUvMQKhUAJqP54RQWmsXN
         VcDmVONa6+E9iDtWcAQ5zl5II4lNQkbYXtXno9M6pzTLkTQW5XCXIKo2hV0dFMOGk1nq
         nx9WmVor1xcDVBYx/kXmAsELxO0JdawokL6+XQmE9bz1EF9LCjOFprC6Z3gmvgWTathU
         uA9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/h3XgWema/r4fY0IZGG28wrJc/TEj3osDTSEZ+7zkAA=;
        b=l8DXdTyrF9cwYddavXPdmgcxuumjhxUQROsiWkG3IAsSVhxEZIX4/WByqAUCjHq9Ol
         XTuAJHiXkpEbWUmu5W/AXTiidVCpXMYcbc4pwu6XZWBWwVRKiLddbWYxQZmW4rEA3Blc
         +gB5CmoKZJkn520jNBu8oSTWUnc7B/ZVF94iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/h3XgWema/r4fY0IZGG28wrJc/TEj3osDTSEZ+7zkAA=;
        b=I4KtVzjEjYMaJ+EnXmpF2DA1kT/OVbMx76Zk3K3Ej73HsBvZWf06NGrVHzvIqBuQac
         j5HZG3odT7QxX79AOT+5Q9/FwLOzHlqaG0L8m7yy80uLyCNsHaGbVdBAK5NahKS0bPe/
         twDtKHIZEobiZy1MAHX2shmfiu2fRCgLjrMvkTxQ31bBgOSBM4WUwADnaJSbyZSza+Gn
         WQ/axEbFUeb2Y6qQdcsIKM2cc5JxV28KV0V/D5MOzsHovqXGRhTCCiNvEOfQaoep9r8u
         3SDArfT+C88hzyzlLqbvE8cMxAo4uzNTPU1DaeiDK8R2xydVE8WcOnhetSnxOYPEgbmw
         ospg==
X-Gm-Message-State: AOUpUlG5wKzZgtDDjCKFJZbJFJNF/rb4dIQq32CGZp3vr0cTgANspqRQ
        wCfb16I4ul9x2gjTch4jqS2kuSiUHV3xzr+DtSriaA==
X-Google-Smtp-Source: AAOMgpfLXn2bTk0wk5e7XMH0e77EexQdIvKMuvh3WXcCKN5lEW9r6KlgHiWURKV714WnQCFd2gPoyLar06FDlFjgONA=
X-Received: by 2002:a81:39d7:: with SMTP id g206-v6mr2106380ywa.416.1531431286369;
 Thu, 12 Jul 2018 14:34:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 14:34:45
 -0700 (PDT)
In-Reply-To: <18355.1531430916@warthog.procyon.org.uk>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-14-keescook@chromium.org>
 <CAK8P3a1k+cy9wAVNQMWE4tdA4aV8tiu6K3haLc+kMPt0iiUQ9Q@mail.gmail.com> <18355.1531430916@warthog.procyon.org.uk>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 14:34:45 -0700
X-Google-Sender-Auth: bZA_ACaBZU25w9jzCO9hKM4eB8c
Message-ID: <CAGXu5jLFEN4cTGGPy_i+-MksCafCwQvU_e3mTvtusyyyXfnrNA@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] rxrpc: Prepare to remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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

Hi David,

On Thu, Jul 12, 2018 at 2:28 PM, David Howells <dhowells@redhat.com> wrote:
> Can I get a cc on the original patch?

I'll add you to CC for future revisions. Here was the start of this thread:
https://lkml.kernel.org/r/20180711203619.1020-14-keescook@chromium.org

-Kees

-- 
Kees Cook
Pixel Security
