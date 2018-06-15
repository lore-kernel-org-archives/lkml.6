Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0055DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A043420896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YcaMk5gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A043420896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966442AbeFOUeD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:34:03 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52143 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966118AbeFOUeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:34:02 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 41eb9e91
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 20:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=dhzbR9Rzbz95OZkTVQ4Hb9LZ7k4=; b=YcaMk5
        gwbajH67+sLPbqxivjlWE7/bek+M4i3Bdk2osEz7V/n/9fPUvFZWoyr3gWkeT3co
        hLi2d69WKd229WxyrOGb2xhEGp6oUn4rNfGI1kZvE3iGQzOl1fOVoMgDHP2ttLf9
        QbQRwilpDvNhk3vngti29jtfHa1J80+2lCrFa82U0LASJUGKV8E+gysLlccoOeMv
        jskaOGsOlZKvvHu8eB+FKIB5LN0nccG5HYatqXeLsIb/WqobdKdDja8aKbL66ogB
        gpXJNKcOCVE5zmjdaSwjT/3OqwGMf4oQghSdF5ZrwNDAaCWonAklPC1dCkFXa31f
        /oVvA2orJ2wYqK4g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ca293eb6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 20:28:36 +0000 (UTC)
Received: by mail-ot0-f182.google.com with SMTP id a5-v6so12359503otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 13:34:00 -0700 (PDT)
X-Gm-Message-State: APt69E3QNvS/5tGtdFuXvzChIZYQEGA7d3Aiw2GQ80XDhWmVxeZ+1CB9
        65k5i5lvf4ZgcObFRjORmiRXwK1zUHGpSHrJ9C0=
X-Google-Smtp-Source: ADUXVKKxogGt94V6ovIIm/LGo7YWKxGpL4WLWp7ahkSNFrXqXFZBIRiIfOcRn5ggkiJSbDyPxLDTyr9VzRri9fHEuRo=
X-Received: by 2002:a9d:59ed:: with SMTP id u45-v6mr2086541otg.320.1529094839684;
 Fri, 15 Jun 2018 13:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
In-Reply-To: <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 15 Jun 2018 22:33:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9qhmSVNBq_GnkYrGU-PPEX9Fk0yiGktsCeEXo+LTB9KPg@mail.gmail.com>
Message-ID: <CAHmME9qhmSVNBq_GnkYrGU-PPEX9Fk0yiGktsCeEXo+LTB9KPg@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     riel@surriel.com, dave.hansen@linux.intel.com,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 8:32 PM Andy Lutomirski <luto@kernel.org> wrote:
> quite in the form you imagined.  The idea that we've tossed around is
> to restore FPU state on return to user mode.  Roughly, we'd introduce
> a new thread flag TIF_FPU_UNLOADED (name TBD).
> prepare_exit_to_usermode() would notice this flag, copy the fpstate to
> fpregs, and clear the flag.  (Or maybe exit_to_usermode_loop() -- No
> one has quite thought it through, but I think it should be outside the
> loop.)  We'd update all the FPU accessors to understand the flag.

Yes! This is exactly what I was thinking. Then those calls to begin()
and end() could be placed as close to the actual FPU usage as
possible.
