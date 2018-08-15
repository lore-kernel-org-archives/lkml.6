Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D48C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A5720C09
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SBpl3UtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A5720C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbeHOT1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:27:34 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:34840 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeHOT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:27:33 -0400
Received: by mail-it0-f43.google.com with SMTP id 139-v6so2736517itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpFPlLRWVzT7GPJKffT2FirggVIW728dyTPDudvNH1w=;
        b=SBpl3UtNFm+EhtPmKqygGUvCSgVV88eKv3DKeqZUdrWDfaRlgmlCfe4OA3pW0C9iyH
         dihZhS1rF7NAR7GHq/FfskaW3u2zUWz8mvRt8908W/O0OrfAm+eqDWBScyEi0z9iJcSS
         +uez7WpnFwPjxekqC2qaC8mZjfvh4HvfFRj00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpFPlLRWVzT7GPJKffT2FirggVIW728dyTPDudvNH1w=;
        b=mepLw5uCmuCF0hOeMfQBKkollPZlfNATCsetTyNT0cnsUlWb6YqrU98nwWfP4mQHMp
         w1paJW7fsWIINatY68Ed9yHo8SCwmr2MkL9x9gnUpY60eq6NijErtm8QGVA3veITRi3G
         TAtGZ8b+tshFS9gPGns9WAGQJ8l53U8pbgoBIj39jrIGlWvJ+8KweJW3EnWe3DHUUcSn
         6ENDbjis4jiwb4q12V/TMmqwOlk5v6fv1r5HTNtT+PSBIIfXw/V0hSGWhwKquWF+KFxJ
         To73OVzgDR6MhXwuZ2NfiJfXchv0PHgH0ZX7Ml+hw3EgfeZrHLaGfnsD7Hk7AkEglPBV
         XWrg==
X-Gm-Message-State: AOUpUlGzpf4Fneq3n3skgz9tT9HVudwcoWdax9AUpdzqIuhU9QevSOv5
        TR57A0Sfg7hiRhNPeUzjIT2G3UdB4c5THvvqImknmQ==
X-Google-Smtp-Source: AA+uWPzJi5eSUSS0Xy7O4uKnv/1BrTneThEuFagm2SmlFnvxQUy6QJNNVa/YQGntTNzXLwrcgEaAcxatCX403WwY/Ko=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr23712046jaa.10.1534350882666;
 Wed, 15 Aug 2018 09:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180814170904.GA12768@roeck-us.net> <CA+55aFy0SFGaNmzCcpwMCeY_f3ZTG54NmV3SosbK6=QdE20=5A@mail.gmail.com>
 <20180814173623.GA5117@roeck-us.net> <CA+8MBbJ=09jAHNZTFrwMFFGbUSWEMYCDxKTMvM2XE+daVa599g@mail.gmail.com>
 <CA+8MBbLrxj5e6cifAt9h0mR7n8x+8KEtu7Mq-gUSOrpCmkZXsg@mail.gmail.com>
In-Reply-To: <CA+8MBbLrxj5e6cifAt9h0mR7n8x+8KEtu7Mq-gUSOrpCmkZXsg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 09:34:31 -0700
Message-ID: <CA+55aFwD28QmLZv4qMut89nAr7gskfJv-8ANvBDsnq9ZB3qCyQ@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 9:09 AM Tony Luck <tony.luck@gmail.com> wrote:
>
> I did manage to build 4.6.4.
>
> 4.6.4 built git HEAD* that failed yesterday using 4.3.4. It boots OK.

Good. 4.6 is what we'd suggest be the new baseline, and we can
hopefully keep that for a while.

                  Linus
