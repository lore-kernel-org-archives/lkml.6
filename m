Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B84AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0662133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BORfNbWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeLRIpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:45:46 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35489 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:45:46 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so6184288ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJbMnFFfPxYHVkz3AOwOK9IDF8Rc2s84M5Quhh5FO0c=;
        b=BORfNbWK5n+85Uc2XNGLtoP0/J/QZCh9/DjO4u3OvYhYfk2JvuRqTOSeZPLlcmHXOf
         Plz5zCZAaQ5snliGI2j7hG3l7bkJeHRpkELtQuY/jhdeDs5qmm+XOHdDevWoIa2NfIWs
         mCYxecEDqr9jXrMEp63Rd0akHtIpiBkMUB3G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJbMnFFfPxYHVkz3AOwOK9IDF8Rc2s84M5Quhh5FO0c=;
        b=D71LpB1KWdSk5gsRMTc5UMMTFqqmQ1s1OgahEfQCoBn05CKf8kapqZw5BQTSIX/ykD
         1u5UJ7wYfZLMdMJdLDlUxx1hs1Lf2RIuBeL6eDdcHRcmnS56O6swBkOooJlHxd4RCVIK
         5q2mM1E297usM+qvvPF7H2QwXyhk0jrGHLZtB6ANpsxMPcCiF11CyoVpPnz7ZyMFPm/W
         aPZST9pzLXDDMLscsFCYVpuLoNaSqZg7/uxK+a+/FW6nzAhnPwGQTnJDZT/hDgqrZz9z
         6secK52RdLMgIbHqjm4T13mS9nkKb0kREH/AY9zuuUZcwFcMXVxbij/pKj45tmEOuYoI
         +vow==
X-Gm-Message-State: AA+aEWbI07/A370J+cBsiKTYszepAZIJtlpgL4a1b5QCunH1iM2gu+gh
        kI6DhAotylyuw0V0plosgbJ7DUg11badlaxPonRIyw==
X-Google-Smtp-Source: AFSGD/VWGuth5LRwvRfMjYBwIsbK/os8Hq4+O7HTqSSVGU/JqsXMP8jj1iE6ZCmxJbdb7m9I+/rBiOLEBSblgqe8pjc=
X-Received: by 2002:a25:af04:: with SMTP id a4mr15686432ybh.195.1545122743715;
 Tue, 18 Dec 2018 00:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-2-anders.roxell@linaro.org> <20181213124042.GG10669@sirena.org.uk>
In-Reply-To: <20181213124042.GG10669@sirena.org.uk>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 18 Dec 2018 09:45:32 +0100
Message-ID: <CADYN=9KBpcUSaU_P_sZuhin60huQUBUT-H-FedH=fXu7a_7EWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] config: provide a fragment to enable gdb for qemu
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, mingo@redhat.com,
        rostedt@goodmis.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 13:40, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 13, 2018 at 01:29:08PM +0100, Anders Roxell wrote:
> > Adding a fragment to make it easier to know what options is needed to
> > build a kernel to get the that you can debug in qemu.
>
> > @@ -0,0 +1,7 @@
> > +# Enable debug info for gdb
> > +# CONFIG_COMPILE_TEST is not set
> > +CONFIG_DEBUG_INFO=y
> > +CONFIG_GDB_SCRIPTS=y
>
> Is this specifically for qemu or is this just good for debugging with
> GDB in general (eg, via JTAG)?

I haven't tried, and I don't have a JTAG so I could test it =/

Cheers,
Anders
