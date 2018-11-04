Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BFDC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21C32082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EnTmcJ+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21C32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbeKEICo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 03:02:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33523 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeKEICn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 03:02:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so76989ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 14:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwwedDvToS94/uEhhheUBD+yrh9clE36cscmJkUYzVI=;
        b=EnTmcJ+wgoOxS3ZKb0pvAWmGetfaF7tksLDUhNADobBlLAikbD6Shy+WDTuhOdoV4c
         MJ1ANUt8puTSSDRc/tT3lUT97lijKsnTa+YQ9+3wEQ1lRkHMOMXLcKsbeTWv4xBK/3bP
         aHQsGbfx6gEZ/Q0O9rwsA+O148IoaN9hAeQNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwwedDvToS94/uEhhheUBD+yrh9clE36cscmJkUYzVI=;
        b=e//bDqDLkAQu7rgz/5t95oep8rHmsTaezfsWfT7OLizmmQAgViviSd2OuYmq0YI7ZD
         FWP7ywtzSpYKLD7GVV+rbf8i9sGSBlbmvqAE8szZ7eGw9NvD476mJONMrvoyWzs3pgrR
         MC7JXmT+3BsWTXcJNTv80/j7qsKMhDMvPx5qNa2xrqRVS7JcAeGCM15uzSVfe0ckvxlH
         0bru6sx2riq1v//xHaR0962TQFAWsIxYygWXZRZGDXsfcF7RJmbHqlWUhKbOidPy6Rer
         iDRcYLAVy3OZm0pAEqip52OIG/fi/rf24etDJm9EhCfETkzpGwTeY6z4cxqpOVmfmxHi
         jWQw==
X-Gm-Message-State: AGRZ1gJUgnXQROfvuFAVqEYLo6mz08I7BV0CgWcoImM5SwjOb+tEhp/U
        3ezGfY9MUsfgI1w1irDYdQGImM/FNnM=
X-Google-Smtp-Source: AJdET5dz62sUKvhRCtksu3s/p1ZT1r6vHrbeX9DppmtOXagLO9sxsX3xZMB59c8L9e7aUXjmnGPTjQ==
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr13900561ljc.147.1541371567996;
        Sun, 04 Nov 2018 14:46:07 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id x11sm1247201lfd.81.2018.11.04.14.46.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 14:46:07 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id u6-v6so6319510ljd.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 14:46:06 -0800 (PST)
X-Received: by 2002:a2e:3e06:: with SMTP id l6-v6mr9237919lja.148.1541371566306;
 Sun, 04 Nov 2018 14:46:06 -0800 (PST)
MIME-Version: 1.0
References: <2346471.iD2boZGiFq@blindfold> <CAFLxGvzR5XCyBiR2tyFw5ouB+aekPrL1KD6zwiaL3VqCnznTaQ@mail.gmail.com>
 <CAFLxGvyP51DcR_=YqP1P4kt=cPpiMdG9n4FGOxpkOYtsfdRg=w@mail.gmail.com>
In-Reply-To: <CAFLxGvyP51DcR_=YqP1P4kt=cPpiMdG9n4FGOxpkOYtsfdRg=w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Nov 2018 14:45:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-4T0XEK4fPrnzRxODD1TO4rs4dz6xXH8dL8LJpEXReA@mail.gmail.com>
Message-ID: <CAHk-=wj-4T0XEK4fPrnzRxODD1TO4rs4dz6xXH8dL8LJpEXReA@mail.gmail.com>
Subject: Re: [GIT PULL] UBIFS updates for 4.20-rc1
To:     richard.weinberger@gmail.com
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 11:25 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> I'm sorry to pester you a second time.
> The first ping had you only in CC,
> let's hope this mail passes your spam filter.

Interesting. Your two first emails used 'torvalds@linuxfoundation.org"
(without the dash between "linux" and "foundation"), which works, but
with my new email setup it didn't get marked as "to me" and got
auto-archived as "not directly to me".

This third reminder was to my normal "torvalds@linux-foundation.org"
address, so now I see it in my inbox.

I guess I need to go tweak some of my mail rules in my new email setup..

                  Linus
