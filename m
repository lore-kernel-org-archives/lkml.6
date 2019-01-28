Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959A5C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAF92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gudJhnT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfA1UDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:03:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38450 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1UDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:03:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so15395040lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MA38io3UNyh5Ga/1EdayW9F9/5BuNgGrSQxRu84uXPs=;
        b=gudJhnT5abwJ6d2/TJ9KZoBbIUCYgBwyywX0t4ZQoOIbRK/ghpkICOppYhT4fIUwKS
         VLKrjaASaouRWQQsmZZ57DwPUjXUpIXCSOX4CusUl/yeOqUoK5Yf7L1VWsfLzM76Scik
         gOOQrNog6oq/gyKTGqWe6LpG4doKNePjPbaaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MA38io3UNyh5Ga/1EdayW9F9/5BuNgGrSQxRu84uXPs=;
        b=HDkR+o4I4IUdpG9O1kNT9WaQ5LzChbyFW5icjxbkmyAqI6diNopnyweYBRqBtEERRw
         o5+i1fTVMju365QjQGyN4qQIOKL6/oQ7j0Okve9SK2wHnrg3Py8h/A75leXcOAu4WrXa
         Argw3Gq34eu0vZSYmt2YIx+KvYrF26QAE1p0j/OHsxPbRWLtUbeLPOTjxBXPqp4ETDKh
         3o2YURJ5B+btxitr9cPqxzSPHs2XPItNhWLouj4jlev9q3OymL5zLZcbp9p/3xA55mge
         3oBUA+lrcO00vtw9jUR6/HLFND/CXsMx/fSSLaUpMtCwyliTp85nfXk6JH/9F54+so37
         3+SQ==
X-Gm-Message-State: AJcUukfH4PyZhUSJS1LbqKur8h7jlgB9p7tHvCY3dV2ct4y8AI7SHP9B
        Y9hBxo6O54wQv8Phna2vaKW9jhoYGb4=
X-Google-Smtp-Source: ALg8bN6HbcsxUwc3CZ2rdF63nHdvksYNl9wvznJ5sRT1DVuV+R4k4JNRhof8FGiU5ybmD+XUfr61wA==
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr17899102lji.145.1548705819979;
        Mon, 28 Jan 2019 12:03:39 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f11sm3190613lfi.12.2019.01.28.12.03.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 12:03:38 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id a8so12842521lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:03:38 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr17532840lfg.117.1548705818275;
 Mon, 28 Jan 2019 12:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
 <20190110101232.9398-4-o.rempel@pengutronix.de> <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
 <20190110151953.qpat4t7lat6plfk6@pengutronix.de> <20190110163030.GB19693@kroah.com>
 <7a593f3b-0019-c30f-30e8-34eae7b96cf0@pengutronix.de> <20190128082313.GA15182@kroah.com>
 <dedfa895-ae7e-9a64-9e89-055ca85cf2e3@pengutronix.de>
In-Reply-To: <dedfa895-ae7e-9a64-9e89-055ca85cf2e3@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jan 2019 12:03:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOMvFBxmBSBZPZEwSyU96L5V8Qhi6bXLqzV4Sdsb2HAg@mail.gmail.com>
Message-ID: <CAHk-=wjOMvFBxmBSBZPZEwSyU96L5V8Qhi6bXLqzV4Sdsb2HAg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for tty_buffer_worker
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 1:22 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Yes, I tested it with different linux-rt version with mostly similar results:

Hmm. It strikes me that you use very carefully timed serial *writes*
to control the laser cutter, but the flip buffer handling is mostly a
latency issue on the *read* side, isn't it?

Are you sure you are testing the right thing? Because your loopback
test is testing the latency not of writes, but of writes _and_ reads.

I'm wondering if we could/should try to simply avoid the workqueue
entirely if we could do the work in process context.

That's harder to do for reads - because incoming characters happen in
interrupt context, but shouldn't be all that hard to do for writes.

In fact, I thought we already did writes without any tty buffer
flipping at all, and that your patch series shouldn't actually affect
any write latency, but I've happily not had to work much with the
tty/serial layer in years..

Do you actually have read latency issues? Or is this whole series
perhaps an artifical effect of the benchmark you use?

                Linus
