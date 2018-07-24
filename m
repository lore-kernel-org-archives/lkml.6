Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88021C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F5520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af0dstl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F5520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbeGXOzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:55:15 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38849 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388352AbeGXOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:55:15 -0400
Received: by mail-qk0-f193.google.com with SMTP id 126-v6so2614186qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4/yA7SBlDxU4yNm78hFF9zoLhzv38sjKXYoYRcp1Lcs=;
        b=af0dstl4+mRhnCRvmT5oXNnnkERxyUoOWfQWOOVGMu2pi0ANWK9NtIj0GXgHAyLzBi
         jKQ2oXA0nE3wauf1rvX1v6iYzd0/gQPC5PiWgbAJBdIeqvIzZ4ZNqArqFqWVatim+Ost
         hIuxAw3OB9WQB4UmU7UPo043ale9LqBa9KvRaEdcwgGvtA/hXndimoZnBIQMqxOccmID
         8eYRP8XJgcZ7H9yQXRZIsEPdFD8SqN/PjeSCt8nSFeY1HJXSsGpNBPrH738MS5wFamrl
         j9rvlk+ejpPAK6mdW44Xqk1nbIZz4Kfq0TNMWec89V2pEw/GHYQCUrtGuflTf3RYyfhz
         S+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4/yA7SBlDxU4yNm78hFF9zoLhzv38sjKXYoYRcp1Lcs=;
        b=Gb3f1/9vqtrrTtTNaQsF1XwDk6xpBUViKmnNBgRrO4i7v4HXwHKXzGtCVySeiFX6ki
         JwoHFT6eYGnzy//XKaOF714nVbK4B5iCmG9ECbeW9QdH67jYN7HD61U6sTTN/1TGgxxt
         NrRYc+q54sJtvKxXaSmwYFIqobSJHyjT2+q+ceCXzDfmHnP5Gjps1ldXxqk9ApXgh1uY
         c366m8RIsl8PzLSWgK0gf8A3cFhWenbNxQdyj0baMFshDL1sDcBbE0lxqVWbkL69CfzF
         vAYpq4idfU5yhxqGkOUEEbFO6JWfEj/Hda51/0aGFH7U1eGU7nBc42VTiPKOHIEBYGY8
         Bgxg==
X-Gm-Message-State: AOUpUlEJKbpruPoXpD7U4N/jyDOMUrnPEXiu8gw3Xx8QFJ7+yE3JO0PF
        bYVxXe4qR1D2DtEAN/6FYNHJKKaTWZ/E/rZYsEY=
X-Google-Smtp-Source: AAOMgpffE9PUWnRLMOguAWoui6oqlfSOQptYgMh9RYOmJ2wYlP94ic//ep4mhvk+3unfQuCiHm/CZvP1JO2YjZhFckM=
X-Received: by 2002:a37:2a65:: with SMTP id q98-v6mr15244998qkh.174.1532440119877;
 Tue, 24 Jul 2018 06:48:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 06:48:39
 -0700 (PDT)
In-Reply-To: <20180724134122.86718-1-acolin@isi.edu>
References: <20180724134122.86718-1-acolin@isi.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 15:48:39 +0200
X-Google-Sender-Auth: hGB7nAhchUMXGNhTSopCKVHM0sg
Message-ID: <CAK8P3a1sA5tw1oZ+vM_BgR3jU2ww0g6_QDn6sxF2SC4PtrP0Sg@mail.gmail.com>
Subject: Re: [PATCH] arm: enable RapidIO config options in Kconfig
To:     Alexei Colin <acolin@isi.edu>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alex Bounine <alex.bou9@gmail.com>,
        Barry Wood <barry.wood@idt.com>,
        John Paul Walters <jwalters@isi.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 3:41 PM, Alexei Colin <acolin@isi.edu> wrote:
> ARM SoCs with a PCI bus offer the RapiodIO config menu; SoCs with
> RapidIO IP blocks but without a PCI bus, need to add "select
> HAS_RAPIDIO" to the Kconfig entry for that SoC (e.g. ARCH_*).
>
> HAS_RAPIDIO was chosen over HAVE_RAPIDIO to be consistent with
> other architectures which already define this flag (powerpc).
>
> Signed-off-by: Alexei Colin <acolin@isi.edu>
> ---
>
> Tested that kernel builds with RapidIO subsystem and switch drivers enabled.
> Maintainers for RapidIO subsystem CCed.
> Sending a similar patch to ARM64 maintainers shortly.


Could you move CONFIG_RAPIDIO to drivers/rapidio? That
would avoid repeating it for each of the five architectures, and
make it more consistent with other subsystems.

       Arnd
