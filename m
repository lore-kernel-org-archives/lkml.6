Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8C6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9477220871
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RdrhGLDO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C7j7fzDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9477220871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbeGOCze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:55:34 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42285 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731978AbeGOCzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:55:33 -0400
Received: by mail-yb0-f196.google.com with SMTP id c10-v6so12488604ybf.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EVmZK/bGRThrZmexRbVczgiLqbz8TsVxazjB15G9JMs=;
        b=RdrhGLDOQvyAdUPyg2VNMv9D657Viu/CtPJ6M72FvMfsfQ65/xnovq5giPG3nyrFtK
         yTojqBNMY8b1RioGaZViz6NmAL+6OIlsDwxvVsPQKPccynl7z3Xu+heSTRkF2uZJNn3z
         cLdv/K4TVgTNQGFV6HCjXiV7j92FR5wrL6l1EaiBk5XTFeZOEi63EimirQR9Lp6Mwf1n
         AKWARvYLqFQZeeJ7yKsXVYv4+FGxMovE9uLfbz7qqV07w0ExPcUXIt1V6Zzh68uLP3UM
         pk/aB4GOo4lY4iPXgKFDz4To4CikC8kip5V8bcyfnhQ1jMbujsUnggbjqqKrbPQso+5w
         2I5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EVmZK/bGRThrZmexRbVczgiLqbz8TsVxazjB15G9JMs=;
        b=C7j7fzDkgP0zwWI7LG01yP2JOI2nlcVdz9dcsMZ4WL8Mi0UfhTWhIHL1fGUPo2aJkd
         tKnlVQsoyYZhs+z2hs8ktCCf9B5tJS4xucId1N4fa4iBQXyV8DGtgXtyY5s5zk4iNtDy
         Nd6oS4nZ82EIl7fh7lJQGPbHhCOgm40/M7Tn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EVmZK/bGRThrZmexRbVczgiLqbz8TsVxazjB15G9JMs=;
        b=XkYIPr56OptDm6pBX6dwx7OFi6ptkQE7ZjHuHXuJw4nFE/mPEbyHPmUJ3KudwaB7BA
         cjxNTi4Qmtyn2iZRim4ITOzusk/6vQZMkYyMd6co6xJIn5C5hufd3aJmQCv5IkH/dd77
         ggdCcxhBC83kkZ1q79xcRRXqIdcxfgTHidbfO58yEAWB0CRnm7Fc8ZEHx7QGBtLdnBIR
         xKawNhFx6ixaN2kyw7Nw3PLv97aS4q9f7M7XIGmGySncAY6BSYLxspCOSbvLauXq2sfJ
         a0/rZ3tqqOsoipeUiN/4FzswzEVwKtVJ2toGI27Pr0bzr00Gr7MUe2CoE9QfEmEPAVF6
         Hsew==
X-Gm-Message-State: AOUpUlFoAASI+0w3bIqNVbYbX09yt0ZwKA477k4mrdEuHDConYKUHmb0
        bn4B4yOrsYbNfgsnhWTOlSnLGGN61DfpkhL5GdQA7QrUB88=
X-Google-Smtp-Source: AAOMgpe+V6G3jvZFLTWpKaHhKyfDSSgQ5S7xfaN31NF0a5UOm6y0LZIMDQr16n5kV3dWJglcM9xBo8x+kkUYLAmFhV8=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr6131656ybe.118.1531622060172;
 Sat, 14 Jul 2018 19:34:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:34:19
 -0700 (PDT)
In-Reply-To: <1531505163-20227-9-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-9-git-send-email-zohar@linux.vnet.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:34:19 -0700
X-Google-Sender-Auth: ufNdvUiMxR3UvG97A8SSI7hVITY
Message-ID: <CAGXu5jKGvQLKV_LmyYaOaF_G6CzF6kUp03cROz1+1PWHEMdrZg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Some systems are memory constrained but they need to load very large
> firmwares.  The firmware subsystem allows drivers to request this
> firmware be loaded from the filesystem, but this requires that the
> entire firmware be loaded into kernel memory first before it's provided
> to the driver.  This can lead to a situation where we map the firmware
> twice, once to load the firmware into kernel memory and once to copy the
> firmware into the final resting place.
>
> To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
> into a pre-allocated buffer") introduced request_firmware_into_buf() API
> that allows drivers to request firmware be loaded directly into a
> pre-allocated buffer.
>
> Do devices using pre-allocated memory run the risk of the firmware being
> accessible to the device prior to the completion of IMA's signature
> verification any more than when using two buffers? (Refer to mailing list
> discussion[1]).
>
> Only on systems with an IOMMU can the access be prevented.  As long as
> the signature verification completes prior to the DMA map is performed,
> the device can not access the buffer.  This implies that the same buffer
> can not be re-used.  Can we ensure the buffer has not been DMA mapped
> before using the pre-allocated buffer?
>
> [1] https://lkml.org/lkml/2018/7/10/56
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I can't decide if it's worth adding the link (maybe using the
lkml.kernel.org url[1]) directly in the code or not.

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

[1] https://lkml.kernel.org/r/CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com

-- 
Kees Cook
Pixel Security
