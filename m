Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A118FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D232921528
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W+BetYAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D232921528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbeHPA1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:27:19 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:39148 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeHPA1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:27:18 -0400
Received: by mail-it0-f44.google.com with SMTP id g141-v6so3937221ita.4;
        Wed, 15 Aug 2018 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XGkGONCZDet8uklYpOe8rBESV0L9T+8NBcQHUUthJM=;
        b=W+BetYAhPO8aoT4t1CRyqKrTCXHd5Hz2V8KFF9u+H6zxa8Oxcw7ouFrVTJOnsajb7f
         qjfde9YfzhQofbNVLf10GIjO6+9Alg6mzS9GzGrDDh6Qez+pu8P02fyrWaCn8Ij8eHOH
         W+7PBhUya7Ri40FyJJp0ea02f5WvAmQ7opWqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XGkGONCZDet8uklYpOe8rBESV0L9T+8NBcQHUUthJM=;
        b=IPXrz3w0Hgq/mX6gxzU/P8fl0NAW4FGABV3e36EfQ7EDi0jr69wuyFl5neaZQlSevx
         DN+uOuzL5cUG3IF0z2hpYnjxk3PrQB4ERG1XjicFeQNFVmHsD+LIVXDFlGTIk+nXa0KK
         /YYiwehaUhi9CbQbq9BZXC06vD7cAOqQMi9I8CBZR3YaxetkLBk8GYFQy8s5VqqBH/ou
         qCMqn1xgB5K4w53qe9XsQhERfmvCvw1+8wtp0Wv12xW6RL9zeUerW44hh1oZ/SftXfAq
         P+YH/L/jI7RsMRkDzlNthHQdd7nZx9ltXT7UxtvK5FMmKwNhrR2rLBBCQcpJ8XCWUUHt
         scCQ==
X-Gm-Message-State: AOUpUlHppSraxy0D3j8ENHHtk996bXiXD2kfOkxht7r/3BtiuZ+Q/M6V
        wRk0JdGn7cSx6sExhcYSuYmO7EpU7mzD5s5AMEw=
X-Google-Smtp-Source: AA+uWPxISpzf1kSXCydD/85DCBAmB/HlY4xMDui9kDNuk/ztEG5oQsOguz8b3xtiYb0M8CnZgiyvUwYIbw7BKg4HbiA=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr19088682itb.16.1534368801216;
 Wed, 15 Aug 2018 14:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180813214328.GA15137@beast> <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
 <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com>
 <CA+55aFyFCWH3YJnRUKtSzs9Mvny0eU+=QANxoPTE+9B9CkUWDw@mail.gmail.com>
 <CAGXu5jJ1JNSxJABUTAO85z_hXjSkjD=nWEho7KrYJTqqVGivig@mail.gmail.com>
 <CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com>
 <CAGXu5j+Yv9Bu4mJPOfkpxrom91kSKaUESHR-Tn1CAJCTTZy_8w@mail.gmail.com> <90a49b4e-7b17-0262-e358-27343549d990@linux.com>
In-Reply-To: <90a49b4e-7b17-0262-e358-27343549d990@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 14:33:10 -0700
Message-ID: <CA+55aFybdHfDhtqSQQT-cRcG2pA_zcE4H7SO059RhC11zcRtrQ@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugin updates for v4.19-rc1
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 2:19 PM Alexander Popov <alex.popov@linux.com> wrote:
>
> >> I fart in your general
> >> direction and call your mother a hamster.
>
> That is plain harassment. I ask to *stop* it!

The correct reply is

 "Is there someone else up there we can talk to?"

just google for it if you haven't seen the Holy Grail.

(And I got the quote wrong too. I forgot about how your father smelt
of elderberries)

         Linus
