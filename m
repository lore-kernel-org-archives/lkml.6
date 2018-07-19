Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4DE2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Rd7c9BBg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mP1Mxdqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4DE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbeGSTSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:18:22 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42106 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbeGSTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:18:21 -0400
Received: by mail-yb0-f196.google.com with SMTP id c10-v6so3649426ybf.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oolAZBVz/DmbPLXCAl1F8Ve8Xxy4I4jLDqU8aSJbBEg=;
        b=Rd7c9BBgQw/dyJSN4xep83b9UcuPZWHEwbhupBYi7mkE3hCdLqBXwBSb4fECx5atEE
         o2CwSHbQHzWuV7dyUT5baCl4gp/Bp/CkJw6PIpcFWKiCltY5bbY145vDdpC7Q9pkNfXe
         BYCmoqdQqwzeFMBsjmvtMqyyEl//PHuR36svVuXJFlcljc4yrP+B3nVvE8RU/wnNrLA0
         QLGq+Bn9aTlAK2ZR64xIaf+Xt4iWN9COE9d/3BjDpt+36N3IhXkTlkTkb3y2qiho8x3e
         ILctYV7Iv32XeijXBQHoKdC2KRhWD/RGQ7nm0BDDIle6/Aacl+oR6SYdahb0VojuwE/P
         jH4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oolAZBVz/DmbPLXCAl1F8Ve8Xxy4I4jLDqU8aSJbBEg=;
        b=mP1MxdqvQLrDpp057Tp7hmcOCi85CsKV4fMFoW3LqAA9WWt9ZGC7cRerFf2GM7w4PC
         UPzLCYy9NNBQS7j0fDFYeYloEhVDJytoo41qGwN2vzuU5HqnU26M1Jy2NHk9v1PkUOPi
         cLV3utJyAJSEtAq1IehXgXN+ZYvgeqgxhoRB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oolAZBVz/DmbPLXCAl1F8Ve8Xxy4I4jLDqU8aSJbBEg=;
        b=exoTp9XgBu0MTQLd3N/FaxlSeET5CjoE2OadtEgxGKOkKz0k//LCXGdAenZmSBBXcA
         kZ6PdPmxxta2shmEY4grlNAZX6k2IReRQE45dVAFaPDihLGRqAL050+cvlAvWFwVHMdy
         IPPWNeyk8eo6xRW0j115S2fNt505zm2p7Q/NFgtMRY0/2vJr4Icvvxg7Key6sAEAE37N
         CxjprI/NThPnBOpaDzWhnROyd1Gy7KQAF6P2zPntITVsX2jv6gCvLwoIGsRbwvilGh2p
         9UwvAsN0mUzAUqKkesFdvbCuEQKsF9PWPiGjzlZHIDgvR7AqdlXZPVGHUYmyOmQo1oZ1
         EUIw==
X-Gm-Message-State: AOUpUlGtgRZIpHX8tnxyyOiPNOMdEZPg4cWTPdbNzwbIGh8CDGkJn1ME
        UWvTXxQz1Ai5D4YF3jVeZxJJScinQXNNBHfEFOObhA==
X-Google-Smtp-Source: AAOMgpdYAkzpfJVqYcnFVVxLmmXHDf3qhEnVsL3JjeXBJJZYebMlmNxdJxkXEZcQPyJWlAjRY5sHRdguW4gUMFuwFOE=
X-Received: by 2002:a25:15ca:: with SMTP id 193-v6mr6269765ybv.484.1532025238241;
 Thu, 19 Jul 2018 11:33:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 11:33:57
 -0700 (PDT)
In-Reply-To: <8736wfctdl.fsf@concordia.ellerman.id.au>
References: <20180629185254.GA37557@beast> <CAGXu5jKV-YAQZtN2heFdmiD9EOZ-AqrBc-NjC8fRYLSafovuyQ@mail.gmail.com>
 <8736wfctdl.fsf@concordia.ellerman.id.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 19 Jul 2018 11:33:57 -0700
X-Google-Sender-Auth: KPwKoTTitzzfB4kNshg9bqi5HM4
Message-ID: <CAGXu5jK+K5Wo2Syf0-b9mWorSSLSj8XbimPtPSayjiMMkWht5A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/msi: Remove VLA usage
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Rob Herring <robh@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 5:17 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Fri, Jun 29, 2018 at 11:52 AM, Kees Cook <keescook@chromium.org> wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> switches from an unchanging variable to a constant expression to eliminate
>>> the VLA generation.
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Friendly ping! Michael, can you take this?
>
> Yep, sorry. I actually applied it weeks ago but hadn't pushed.

No worries! Thanks! :)

-Kees

-- 
Kees Cook
Pixel Security
