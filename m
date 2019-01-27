Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD68DC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA092133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YeKetHxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfA0VWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:22:01 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:34598 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfA0VWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:22:01 -0500
Received: by mail-pg1-f175.google.com with SMTP id j10so6366060pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsC5djDSgiVzrtInfE/sjOudfzw3cuktrPOR86Hcybk=;
        b=YeKetHxLkdOJHVwAktew47Gm5Y3qoxfx7WH60YQ/HLNOXRJaU1zZm8yunxCKeYbnkI
         XGqJk+T197KlhvcgtA3uxDygUanuVB3Rh1QcrjdndTXtmWdmC84irosgGhMPjnrdQSIL
         2jtFE0RChSfHrzWNU+n5uRsnvHdpSXHnMO90qTbfyVmXK0O+8YKjwwrtanzJ2ehXb2Tv
         YzMhaE5haPylRzq8sj+Z5QU0Mv9ohCmlVypM9A2g0TNX9cumQxOXIN1RODZ9CAxIWPJD
         pjjwEr6bwiaRxF+6A9GAWpx+LsCsZxcw/N290LxoZSUS8gPyX74gLHBad2UnLUho0ohe
         kuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsC5djDSgiVzrtInfE/sjOudfzw3cuktrPOR86Hcybk=;
        b=UyjjU+ITncCDUNGzNnLvi5osmQ9mnA+ODT0Nw3ju5j67L+famczev41duwXD50xtZD
         dZPOZLVxOMxPEWqq34+nV8Qxd9NXsy+qEqlhfs5AYh8//2f8gFmMjGgT9DqGhOQQ3EpH
         EZliBCAgjIBV/vJK72tiey+rrOFyd7Yams9YSL/0rQt/56gpvvM8AKXR65Iy1A4D8pBN
         NNJEiLgVJzPropFjC43/2zn+uywWWivejBBvJfk3yPoIFY0bnCMe4F1NP7AkAVCpxsiI
         Z9rchtOdXKNRFH6BKsstJORzl7+mPFlWd9JVkMasefViXaBsmeUpaaFnPgxfCGjEwFgh
         Nf4g==
X-Gm-Message-State: AJcUukf3cEG5Q/keLhM7YeOZ6BMyVzpZqtypzNH44PC83ZyUIvXUYxpd
        EEF8tMZ4EBXD7cUA+ZIc5S3R5NekGwFNv0daIT6Cyu/6PG0=
X-Google-Smtp-Source: ALg8bN4P/0c79dJoNhvPyNIhO5fcVHeC9TM6pyV/aWohgfzlt8F+REVS8FaIlXNZUqWBBpW/mZgofzHP5yfYz/0TXjg=
X-Received: by 2002:a63:2406:: with SMTP id k6mr16957556pgk.229.1548624120526;
 Sun, 27 Jan 2019 13:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20190127203239.973-1-Florian.LaRoche@gmail.com> <6e166e2d25a56212c06c1334fd9bfb09d14beff0.camel@perches.com>
In-Reply-To: <6e166e2d25a56212c06c1334fd9bfb09d14beff0.camel@perches.com>
From:   Florian La Roche <florian.laroche@googlemail.com>
Date:   Sun, 27 Jan 2019 22:21:24 +0100
Message-ID: <CANZrA2ZEnqWvp8K1PYpOch5y6_ic5DVaRMcX7KHndieEp0z5=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] int_sqrt() adjustments
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

sending in a new patch with u32 as return value and some adjusted
callers of int_sqrt().

best regards,

Florian La Roche
