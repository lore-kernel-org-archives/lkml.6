Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E02B208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cHej0Syv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E02B208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbeGKDPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:15:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39860 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbeGKDPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:15:34 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so1540212itp.4;
        Tue, 10 Jul 2018 20:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWUmHz09Rw2+Xbl5p+bwxgdglDB32BbGFkwL8CT9X18=;
        b=cHej0Syv5FCxg7UuSGVwgpFUhdU4/bCXmOLp7YcLf8B7pORHe76OKW7oIgaRBhwrgS
         T0wxtfs40OfxUAX8igcZgwDX/F5vm2Bi/DerdiVo4JbAj3bnsMI2aEM4WDXiuIZkaVET
         Z6wjdDKdGnVk46wM2i8MY9g1RykkCKL/05G2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWUmHz09Rw2+Xbl5p+bwxgdglDB32BbGFkwL8CT9X18=;
        b=tg5TUbf4t35nkkjNwqjygvs3DL2gzvgoSTf670XS2JFxZHrjUYHHc0fx/9jG0Fvupt
         09CHYnGAQCqSFqVLjlOWb6WKIF7O0gET2PHrnwtlIfdPDwJxz55+gE5uBJ3S7knzkFzl
         A2Kdxba0fV1kyoO47YZPxnKS9CDW65f1gf0KlReBFUL/vuqmFoB6UzT6mTBrGg6A2/WH
         E2ekDyHsIxV2S38IHn1jCO7hbDIAOz2ZvxWVrCHRGB5f9hmnwgHLdDgPH24O9J8D0bHT
         I1cl6h1YONYZt6hY+aKVIYUvoTisXUJZlQ8i46IWO8TlSpa4C/aImFT0copWDhh3U+22
         mZUg==
X-Gm-Message-State: APt69E1vyNzMfb3oCaR5dK7h+OYO/0SU5tFu2RdCnv8wppqDtmXDj/bQ
        y0DLWaM5S6OyCZyCUvofbWdjZOEexxO1k/yuvIFywQ==
X-Google-Smtp-Source: AAOMgpdjVnb4aQPqHHcwgpkWBXRWlxxOCpSUEOqkN52+pfpRnJhRZ65LyVletlgGfYGBe2BSscd5S/Vp135O88905MY=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr20966116itm.113.1531278805620;
 Tue, 10 Jul 2018 20:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <20180711022206.12571-16-viro@ZenIV.linux.org.uk> <CA+55aFyoQkoRm5sGaXpxtrr8au1mgr1_+khY=St0o7NRd5qw8w@mail.gmail.com>
 <20180711025920.GQ30522@ZenIV.linux.org.uk>
In-Reply-To: <20180711025920.GQ30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 20:13:14 -0700
Message-ID: <CA+55aFznpzngTuSRjKskUvdF5QeuxosV3eZ_L_dzXsBTG5sxyA@mail.gmail.com>
Subject: Re: [RFC][PATCH 16/42] now we can fold open_check_o_direct() into do_dentry_open()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 7:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  Something like [..]

Ack.

            Linus
