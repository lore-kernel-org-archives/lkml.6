Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF69C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BED25059
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g3F+yEsY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3j2WHNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BED25059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeGBR31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:29:27 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39255 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbeGBR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:29:26 -0400
Received: by mail-yb0-f193.google.com with SMTP id k127-v6so5373023ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WsdLDu5OaU7bna58R2kvyy/cN5DTIgA+YtqNBar7NWg=;
        b=g3F+yEsYPuIS4EmE4BApJGdkJGMOWKPYyiCI3GKGOgiycXZIXTWNrH+Atw2OrvHy0f
         wuBlUFbr7rs8r8RTt0gkmNETMcd8yJMwUvBPLE9up/MREdEA/TRYVlO9hVdDCK/Ija5u
         q0BAIOBcYoo093+cBm999FDCYoSkgsemBpl+ifR7Pyzqes5YAgjabET9ABwECvJxoozy
         nYfRIgR7N6dC/WT1gf9LQp7OIIRSzgDgwVByJkb30vAYzhh2wnNa7Npx+nV6/uLY+wdA
         ilSqqaKlo6iHzOL47JEoEheHEPFD25tWRoOEPYzT5bJ3lZUDmMrHNQptdtNuL2ZjT7El
         qyQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WsdLDu5OaU7bna58R2kvyy/cN5DTIgA+YtqNBar7NWg=;
        b=H3j2WHNaX3zgm9VAOQFP+i2S3kde8xJBtXUAyXn7U8kwXXKhuIr0mxRx/rRESJUqu2
         xKs/r0ktv+3PSoXGNj1C3eKFeR4HAqTUFbHBrBh+A/TFUsj69iIXbpWqGqHqX/8QoalJ
         acCrZoTPafeoRZwPEWgr1/BaYlEAFgEmvAMcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WsdLDu5OaU7bna58R2kvyy/cN5DTIgA+YtqNBar7NWg=;
        b=NRwNX1GcBVjxbPfJR0KgrGI6koIxl5KmtY7BLIZLKbyllpwN6p687MhBiEoh1/63uC
         YVxpjnyAXTLTqIQJAsKJfeEGwarNDEdp0KzBd+H3eIfOT/ECVNy3+VobdRbozDyMuL7Z
         jCnW48abNKlLduqsTy8SP8LDHT+gmIK5D7LNE3VEIAcYXYNsl/pwRdlfRqRNxck7ZxnB
         z/7rhOcyKwlJs6kaeb1Yff3lsMw3sI8u0RIqTVfKg//D5zJbp6PZUqxyzE4uH5zPELtK
         rXKWP5fe95gXaGUTrTtP4mQl5NzSvHnTSkdNz/JyJSFmDZHYqjLz8LeoHpVGTNcK8ILN
         9d7A==
X-Gm-Message-State: APt69E3a/cMLTiP6lcyecDx7nHZInwHT2fwOUWeCGa04iYazrCE+yhhX
        aA+V7I6x2s5dI86cGl0XZcWKm4dp4e7rBbqjYkACnQ==
X-Google-Smtp-Source: AAOMgpdQM7pS7kYiewZhFDLHRcXc7caNRTxFKpJr6hjTDV6LQd0pZ0aXFSyZRsj1hh+0e+2NAhwr/JjwITDqgL+LHw0=
X-Received: by 2002:a25:a483:: with SMTP id g3-v6mr2696051ybi.309.1530552565079;
 Mon, 02 Jul 2018 10:29:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:29:24 -0700 (PDT)
In-Reply-To: <20180702095931.GB28665@arm.com>
References: <20180629190553.7282-1-labbott@redhat.com> <CAGXu5jL8kZHtg-MdScZ5m_6xH_Ho4TsdKGWH83zEL9Y5rutncw@mail.gmail.com>
 <706dc06b-0157-89cb-33a6-d0b9d811dcf0@redhat.com> <CAGXu5jLW5FJdRdRXcP=xPOEcQ=Tg+uSi=vj6vQ39iVp=QHSRAQ@mail.gmail.com>
 <20180702095931.GB28665@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 10:29:24 -0700
X-Google-Sender-Auth: A-Lwg-DmYgixkvxifuC9n8kMOhI
Message-ID: <CAGXu5jJSUFFUpaWYToiKQymKR-wwem55WgAgbygWXdTfHQUs4Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: Clear the stack
To:     Will Deacon <will.deacon@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Mon, Jul 2, 2018 at 2:59 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jun 29, 2018 at 01:25:20PM -0700, Kees Cook wrote:
>> No worries! I've made the change locally and will push this out to
>> -next unless there are objections?
>
> I'm a bit wary of conflicts in entry.S, since it's likely that we're going
> to have a lot going on in there for 4.19.
>
> Could I take this via arm64 instead, please, or are there dependencies
> on other parts of your tree?

It depends on the plugin existing, but we could split it up so the
arm64 part could go separately. It would just be a no-op in the arm64
tree since CONFIG_GCC_PLUGIN_STACKLEAK won't exist there. Whatever
works best for you!

-Kees

-- 
Kees Cook
Pixel Security
