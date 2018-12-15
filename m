Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158AEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C362D2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTsZIRe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeLONnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:43:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLONnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:43:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so8009620wra.6;
        Sat, 15 Dec 2018 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B92XhGmL6S1m/GMFOjq5pkFbgQ/0L3SkLZAgaUUygCM=;
        b=qTsZIRe9jziOW4G4aJ51/gl6KexRXeMzKrb616OvAhWSaJUf+BXkSE7svAt2WedMe4
         M3qNF0CiC4vAeVYcDKhnXCM1BZzp2nQ1ubVtIEvpNaWMIizjWxRD0CSo66auX4lk/PMx
         r9dRCVTh3g5t785dlio2D7yCLTNJfchUdUzPwd8H4Q62uIgpGV3S0zk5A/0xew4bGNLr
         iu/ZvDC1nTbcn527Tka+9T/r3igWesHXxAyKazBJp8bTh63UYxX0W55AAm9P6tHBYkiA
         85I3HUbwNiD4+XLf6+qkSpWGFZya0ehnjEPVkV+wLqwELyP4aOSm+1Yic+r7MbeW6ZrI
         9iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=B92XhGmL6S1m/GMFOjq5pkFbgQ/0L3SkLZAgaUUygCM=;
        b=N1E4EBCcl9yi2LYA8LIfC2m9zbVYKONfyhWu5vLgMwshRFzGWeZEyiO0Ose2o15kfv
         /VqnovCorTvff58f6BffNlvACuoAvI+VpGvcwdiacM9bhk0hcrCIsEuJI9V1r8LMtS1/
         y61sLbK5i4VCP2PbmZf26pGm1Zadx6tMFgSIvQcvKj0HBTw3WHjB2AxT4lNYX4qpXGn4
         ao8j0ooCfP5NsH5MSJrELkya51WQuUQ7hxlte2jE4DI6Pke8T0cSCL+Zh94qN1x1bRqh
         RAgxWLAvMbDIBYXBkgcQwaeqP6UWTDBTzM08lTZbJCvSYEvRWK4BLTNscz8z+pWTx+K6
         4V0g==
X-Gm-Message-State: AA+aEWYxPhjF6dBLrIbPAbgjU5hUHy6YFvHzBzc2TtsqUK6sj4rHTo0T
        K37sSSAKmA1T83WJQlTSLQ==
X-Google-Smtp-Source: AFSGD/UXzfiLRXtoXLtP86CBJR0fe4GlIIE1S48YndPCIyU/Epnfa7dXSkjm+N9nYoXS1RdTkYdgbA==
X-Received: by 2002:adf:8068:: with SMTP id 95mr5540960wrk.181.1544881424129;
        Sat, 15 Dec 2018 05:43:44 -0800 (PST)
Received: from tpdeb.localnet ([95.87.234.74])
        by smtp.gmail.com with ESMTPSA id f2sm8021487wru.14.2018.12.15.05.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 05:43:43 -0800 (PST)
From:   Dimitar Dimitrov <dinuxbg@gmail.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, tony@atomide.com,
        robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com,
        jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: Re: [PATCH 04/16] remoteproc/pru: Add PRU remoteproc driver
Date:   Sat, 15 Dec 2018 15:43:41 +0200
Message-ID: <6339524.5sMj8qDFZB@tpdeb>
User-Agent: KMail/5.2.3 (Linux/4.9.0-8-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <5C137DB4.9070602@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com> <308735274.C9ZyqtqOL8@tpdeb> <5C137DB4.9070602@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12/14 2018 11:53:56 EET Roger Quadros wrote:
> Hi Dimitar,
> 
> On 30/11/18 23:39, Dimitar Dimitrov wrote:
> > On Monday, 12/26/2018, 9:52:37 EET Roger Quadros wrote:
> >> +/*
> >> + * Convert PRU device address (instruction space) to kernel virtual
> >> address + *
> >> + * A PRU does not have an unified address space. Each PRU has its very
> >> own
> >> + * private Instruction RAM, and its device address is identical to that
> >> of
> >> + * its primary Data RAM device address.
> >> + */
> >> +static void *pru_i_da_to_va(struct pru_rproc *pru, u32 da, int len)
> >> +{
> >> +       u32 offset;
> >> +       void *va = NULL;
> >> +
> >> +       if (len <= 0)
> >> +               return NULL;
> > 
> > Could you please clear the upper 4 bits the of IRAM device address, in
> > order to support binutils ELF images? Here is an example line to add
> > here:
> > 
> > +       /* GNU binutils do not support multiple address spaces. The
> > +        * default linker script from the official GNU pru-ld places
> > +        * IRAM at an arbitrary high offset, in order to differentiate it
> > +        * from DRAM. Hence we need to strip the artificial offset
> > +        * from the IRAM address.
> > +        */
> > +       da &= ~0xf0000000u;
> > +
> 
> After some more thought I'm not very sure how to proceed.
> 
> I'll be using the below 2 patches in the next patch spin in place of
> patch 1 in the current series.
> https://lore.kernel.org/lkml/20180623210810.21232-2-david@lechnology.com/
> https://lore.kernel.org/lkml/20180623210810.21232-3-david@lechnology.com/
> 
> They figure out the PAGE (IRAM vs DRAM) by looking at TI specific section
> attributes.
> 
> e.g.
> [18] .TI.phattrs LOPROC+f000004 00000000 000e08 000010 00 0 0 4
> [19] .TI.section.flags LOPROC+f000005 00000000 000e68 00002a 00 0 0 0
> [20] .TI.section.page LOPROC+f000007 00000000 000e92 00002a 00 0 0 0
> 
> AFAIK the ELF by GNU pru-ld won't contain these sections.
These sections are not documented, so pru-ld does not generate them.

> 
> We need to support ELF generated by both tools (TI clpru and GNU pru-ld).
> Is it safe to assume that if the ELF doesn't have the TI specific sections
> then it was generated by gnupru?
Right now this is correct. My concern is that in the future TI may decide to 
document these sections, and pru-ld default linker script may get updated. On 
the other hand, if TI considers these specific to their toolchain and not 
applicable to GNU, then go ahead and use this indicator.

Slightly more robust might be to check if MSB byte of the entry address is 
non-zero:
  Entry point address:               0x20000000
                                       ^^
> 
> Is there a more straight forward way of differentiating the two. e.g. by
> looking at something in the ELF header?

Is there a reason to differentiate? As long as you zero the MSB byte of IRAM 
device addresses, there should be no conflict. Very large IRAM addresses are 
unlikely to ever be valid, so it should be safe to zero the MSB for any PRU 
ELF image.


Regards,
Dimitar
