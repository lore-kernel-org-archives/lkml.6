Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E51C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BB820665
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GzxGcn5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeL2Ega (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:36:30 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:46121 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeL2Eg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 23:36:29 -0500
Received: by mail-lf1-f41.google.com with SMTP id f23so15587096lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 20:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPdQo5vsB7UCXvTXbohh/RQf7VQuS04m49I4t3ZR984=;
        b=GzxGcn5HzXp1Ei/c3fICaB6Dw1EH7gaTOs/lpzFm7zYvNpE9/kwutgHxlwCO3C47NQ
         BxnfIE00p1K2X0bkz2bhqsYl9EMlkkWG2IGpmoRR/GIbOhEQXkphf6aSV7l4ILOUiBr7
         3noHk1rq5EIkGm2fOJFOSFqe6Xd10YDn0iioU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPdQo5vsB7UCXvTXbohh/RQf7VQuS04m49I4t3ZR984=;
        b=pSftSAb/7eAZy9Dl5kX3geSZAdFZmHLDT4vNT+zLTGHDjsItL4fsekM9ZLK3wCR7yq
         CSulvMl62c80YWg9vX81NoD0DbKIMLav4NO0N/J17GxAvs9XwovSMzHfYtLpBcfbt1Rh
         GkWBMpsdxUYNF78dkPnmg+34OFxz/+49gZ7rJ8bdUnoumnBLZ2ALqPu+c9V9dK4DY7vP
         dH+ajACDudebqlxsJ0f/2qgFzjo92sirZkJteCgCr6sOJu8SH7MZdaySFs3BMCrVTggj
         Szm9T+LUaUJ6y+sS13+bggkrgjHMQ10PGbwou+htDGtCzLwuqE0BfNNaFZLfSWEPVI5v
         yawQ==
X-Gm-Message-State: AJcUukd6xeo7cJG4rTZv4nB+Ty89FofQlBXT5nF3nNhfRhFB89U4u+7w
        e7Qo5qsvPpAGwM7cV5brH78CsHWdPAk=
X-Google-Smtp-Source: ALg8bN51ukMmYRP2i0p71NFMMsFuEz2q295PYklafj6o0a//9w8OWOZDW3cSFQJ9obu5lExSYMPcPQ==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr6264026lfa.40.1546055009293;
        Fri, 28 Dec 2018 19:43:29 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v17-v6sm8755936ljg.32.2018.12.28.19.43.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 19:43:28 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id a16so15595822lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 19:43:28 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr16166329lfc.124.1546055007882;
 Fri, 28 Dec 2018 19:43:27 -0800 (PST)
MIME-Version: 1.0
References: <1546008946-17600-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1546008946-17600-1-git-send-email-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 19:43:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZREyNTzSTq2hYrueHGby48w2h1dDPLtCqC+BubV5zUA@mail.gmail.com>
Message-ID: <CAHk-=wjZREyNTzSTq2hYrueHGby48w2h1dDPLtCqC+BubV5zUA@mail.gmail.com>
Subject: Re: [GIT PULL resend] hwmon updates for v4.21
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 6:55 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> [ First sent last Sunday. Resending now because I don't know if I will have
>   internet access in the next few days. I don't know if it got lost, if it
>   was rejected, or what else may have happened. If it is still in the queue,
>   my apologies for the noise.  If it was rejected, I would appreciate
>   feedback.

It was still just in my queue. It's about to be pulled next.

                  Linus
