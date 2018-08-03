Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F73C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F1A21759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFahZa+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F1A21759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeHCObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:31:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37170 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeHCObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:31:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so4807849ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QwXyrEjX8iVrxIbJasKEs+ObJd7zXBNoFZWMYKI6DPY=;
        b=uFahZa+fmUxGj9U3Pt5tvXdHgzMbmbSROSux+ixEmmCx8D/d1xRJCoXQp/pWwXDo/V
         +Ll+P0shCE7hNLiDc8hibY6IcRVLvRz4tVoSwArHfmgl/LRvYgZKWnbhKkquUQ6uMjRy
         fQ1O1k5y1h0WIuN+SCjWRzdeT+UNZq+pyL3CsGnm6kMC4iHUhuxnnYEON0uau0RVEp12
         XrW2PKj609h+b2VZ5TAHiCDnjCdSHG2jfVttmoNe6atQD882tORuZfGnUUc+eCgTYO1l
         LdT2zgGoEV4mWOmXswrjQ37Znh9H5gbW4W9KSbYhzcgUHStH4uOK24+mG7S2UGVdwrjP
         zEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QwXyrEjX8iVrxIbJasKEs+ObJd7zXBNoFZWMYKI6DPY=;
        b=tY92Rli1t3OX2HbYhWm+dvv2IjtNDPW/o+kH5bE1LyE/LyJP19VBTane5W31EYODC8
         /dltVKzaPd/FE4nnsN9CBFFjBIeVZ8aq30iE5InWXficynx7CjdwsxGvQgDNqAL450Kc
         L28TAfH4KiJsoxH/u12yBP/UPNDbLoB6k82iHc3w4vByOVAesGZK0xMXnD0E4rn4aR50
         CUcpLVl87fDCJO2WyQriKz0D/E8eCQWxvEKCAY7fXjf8yF5kJuHN965QNCV3znD24DyP
         9i9w+EzPkqpjC8gU6wV15zcds4NAyGMcZpmAGkK+Z30ckRVHl8vSjGgJo0j6ip9M5R8p
         3A8A==
X-Gm-Message-State: AOUpUlECUMTLFlI8VOIbpA2CRfETKQlWSj1ZACgcgjBMiamGqReamZI0
        wyNiaigw4iVikXSFdjmuujwRO1prPnVtD/cNeQY=
X-Google-Smtp-Source: AAOMgperGIj5NttJYV7qTVTog1fue1b6OgV+VgQ43oCg3nRjuCBziM33yYBM4Gj8R/PRiiwmxZy6p3l7tl2aVlmj2k0=
X-Received: by 2002:a2e:4619:: with SMTP id t25-v6mr4214153lja.96.1533299691394;
 Fri, 03 Aug 2018 05:34:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 05:34:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1807161116590.2644@nanos.tec.linutronix.de>
References: <20180703123910.2180-1-willy@infradead.org> <20180703123910.2180-2-willy@infradead.org>
 <alpine.DEB.2.21.1807161116590.2644@nanos.tec.linutronix.de>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 3 Aug 2018 18:04:50 +0530
Message-ID: <CAFqt6zbgoTgw1HNp+anOYY8CiU1BPoNeeddsnGGXWY_hVOd5iQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: Convert vdso to use vm_fault_t
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 2:47 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 3 Jul 2018, Matthew Wilcox wrote:
>
>> Return vm_fault_t codes directly from the appropriate mm routines instead
>> of converting from errnos ourselves.  Fixes a minor bug where we'd return
>> SIGBUS instead of the correct OOM code if we ran out of memory allocating
>> page tables.
>>
>> Signed-off-by: Matthew Wilcox <willy@infradead.org>
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>

Thomas, are these 3 patches part of this series will be queued
for 4.19 ?
