Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DDD206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="IjBKN7sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DDD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeGSWmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:42:25 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:42526 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGSWmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:42:24 -0400
Received: by mail-lj1-f171.google.com with SMTP id f1-v6so7805718ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XkN7ESwEnYNQ3tt7T3y9pSDFDcyA5U1z4laOwHrdsEk=;
        b=IjBKN7sPk81jZYnXU/VPrQ2Wwwhw8VPMPslfz32G2N/3ldGf6qMddE2cL9cvL6/M/8
         juHeFcGfq2+pBhnICqnVEKDu50v8ZcZrjpJemeJGSMGvpHfqvN+uCDr6Ax8KSBqs6PEa
         B8TwUyakmMoQ+R/YxXBAN7wBfQuJ+0suS+vNbQGdPb8yZvAJt1JvcxIHGis62wdh8bAr
         cimzANgM6iSLMYNcXtLmdf+1YloGBX95VG9V5shQnF3T1fkcBCA6SS0+St/CtCIexKNl
         kk8EWmNbdpuOAz3JPGmc3cG9pKqWvQNGhRP3XBDiy/uYCbbn9uuxdsuxpJUkQ7h3SiBn
         CVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XkN7ESwEnYNQ3tt7T3y9pSDFDcyA5U1z4laOwHrdsEk=;
        b=K+/41uz562LKjrAf2VUfFGjSUfbsdpYUU0xDvoeXuyRy4dZABJcQCTcBByMyQi0olY
         8qvFy7TD7uHwGF3nwRAYYNqpSabfk3r3wAEtyYk0NsfNTMj7xYBjf009tkAZvbOuiJSL
         LVjTzXmQSd0TVB76uxawPED12zSLwWONqxAScgENrDA8gGKkNIZCNUbSalwhNmpgQeBw
         pFk6avbiXY8w4cy6uPHUfKmtSn+mElxShRl9jtxRI9w7qC2awC3keNqZBoVpXkFkiy15
         3DmfDsQq1J5zdz+j+xOx5BPPxsoWGF6fmXwCbO7/IpGZKC1XO6azLWgdCewm94RBjZE4
         UlTw==
X-Gm-Message-State: AOUpUlHSyX2YCBvG6YT7XqDrhLK8kM7ZSnAUd9JbIJ014YPmU/MamSxH
        b3iIm9i6xGwej1wIpz9MoIJ7pATS2H/e5bhnZbJa0Ge5Bw4=
X-Google-Smtp-Source: AAOMgpeBrXwIXdGYVbeCFavN2oUuqqvveHmaN72A84YoKcCo3MgqKtfG2XpPgmgUvRDaQF95kSgSaa5PVDtgqDG7Feg=
X-Received: by 2002:a2e:195c:: with SMTP id p89-v6mr8564284lje.138.1532037440779;
 Thu, 19 Jul 2018 14:57:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 14:57:19
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::6:14c8]
In-Reply-To: <7h4lgvm3go.fsf@baylibre.com>
References: <20180716080014.75c9016b@canb.auug.org.au> <7h4lgvm3go.fsf@baylibre.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 19 Jul 2018 14:57:19 -0700
Message-ID: <CAOesGMghENGioK2o_dZKGPJYT01yoP9Fks1k-i1SUXZFENu3Lg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the amlogic tree
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:26 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>
>> Commits
>>
>>   3f1ad8c53b29 ("ARM64: dts: meson: enable the saradc node in meson-gx-p23x-q20x.dtsi")
>>   4dabd157d48e ("ARM64: dts: meson-gx-p23x-q20x: move the wifi node to each board's .dts")
>>
>> are missing a Signed-off-by from their committer.
>
> Oops.  I missed these.
>
> Olof, these were just merged by you in my PR[1].  How do you want me to
> handle this?
>
> I could respin the PR, or just send another with them reverted then
> re-applied with signoff?
>
> Or, since these branches don't need to be static (yet), I suppose you
> could just edit the commits and add my signoff.
>
> I'm OK with any of the above, let me know your preferene.

Hi,

Fresh pull requests is probably easiest for all. I'll drop the one I brought in.


-Olof
