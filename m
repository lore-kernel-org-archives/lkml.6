Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3199923-1518625049-2-9814111466418805781
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518625049; b=v+RamZcYbqTJWd0jnlEU4vPFy1XY9haiFVBofeHfDCpzyLu
    lyHsgh5ur8+z3VbFy05CxgplOJ7WVUecptOWhp6dB2ocDJSamqoZuf8L7XJBgrD0
    YRHwEpnBvsHU8TsueDoomQnWrdM9AruwnAzHA84NRfYpSauRFFczhOY7lhd3WgZw
    vVe9cVBeRQQmufqGwPfUxvDvw/UB+Mi831Fg4YfFSwMGCFcsGQhvV8xulpniBq9G
    17fRFf10TDlkb/dtZBoAhvQgf2pb8QPfSANNyzQhJ4Hy+6w2rVB3rNc/zG48LXnm
    aGWrUsD4OdrIdGbRDJV5O5fBXb39UC4l3m684eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518625049; bh=VX/f4XE2VP4qdVVQexR64MKLCeYcXPqy4ChWrk
    uq5gc=; b=kteWHuPiDb70J0Cnck9KrHNiZKQN/zlKZ+wwD4nyN0Cxflm+z0kmBd
    8wF92CysPE4ScucGP/PCscKSTQ0lX9BQnYfq5YaJrcPCru4MQwxgV/X/SeprKLG+
    BnYHod4IQmt35uXCThBEEAjYTtjlmcV27E4f5LUr4S0trDz/FMnTRLrcyNqoMKCB
    4lNedAjMRPr7kBpnRa+QeDLRMV/AdB9OfPaL3NufHzjvnudOfWmZLTtv5N4Y7IWv
    MXytArI+W7WSWY6dmvBQE0SCLKD7weIQEJ1QQ5EJdURxhslXnkYveci2Yo7WAx61
    mxCgqEkdalArZ+QqrCx/Q8bFo6CLzoMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=K50lIQM5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=gu+75mAw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=K50lIQM5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=gu+75mAw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032260AbeBNQQ5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 11:16:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032074AbeBNQQy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 11:16:54 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D09AA60F72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
X-Google-Smtp-Source: AH8x226ff0Ezf0sD26JeJ+XusX/mlcc/tvre0ZTt9569DUgHUshBDm5heFi/bOPyPVL/4CahQTvlKPavFzRJlLUfq8k=
MIME-Version: 1.0
In-Reply-To: <1518616386206238@kroah.com>
References: <1518616386206238@kroah.com>
From: Timur Tabi <timur@codeaurora.org>
Date: Wed, 14 Feb 2018 10:16:51 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWZV4TDZchsYeHE_Oh+s1y3yjXE9NxVY9wz-vCkZVhN4w@mail.gmail.com>
Message-ID: <CAOZdJXWZV4TDZchsYeHE_Oh+s1y3yjXE9NxVY9wz-vCkZVhN4w@mail.gmail.com>
Subject: Re: Patch "[Variant 2/Spectre-v2] arm64: Implement branch predictor
 hardening for Falkor" has been added to the 4.14-stable tree
To: lkml <linux-kernel@vger.kernel.org>
Cc: Shanker Donthineni <shankerd@codeaurora.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
        stable-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 7:53 AM,  <gregkh@linuxfoundation.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for Falkor
>
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      arm64-implement-branch-predictor-hardening-for-falkor.patch
> and it can be found in the queue-4.14 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please note that there is a follow-on patch, also from Shanker, that
fixes this patch (it was slightly mangled when merged into 4.16-rc1):

https://www.spinics.net/lists/arm-kernel/msg633726.html

I would love for it to be included in 4.14.20, but it hasn't been
merged into Linus' tree yet.  I will send a patch request when it does
land in 4.16-rc2.
