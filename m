Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE3C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E282098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT2R/z5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E282098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJLHdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:33:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35497 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJLHdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:33:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8-v6so5000950plb.2;
        Thu, 11 Oct 2018 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6r1JLPg0IqKaayCtOulc2ZNroj/XXnXaGCny+Yao7NE=;
        b=BT2R/z5KzqAmd6FbH5JY2jolJ0T+JSg53vBg4StOru3o0XDBws0iQFzDGhSEgQ6zLD
         /LUmskV+2PLu3XKIaaMWhdyfyFfPY2MV4eBFE9CcWwL4IzaglfpMR5+VsT2zJGi1z/so
         HmiLaFnB7UhEftzR/NjaEkXb4lgw5bY72yCRFig/HGFd9ENoKJJBrSggD3d7Rcqb64b5
         aO4k8WL14sp7SHQAELx7uxCrWZyZGlAjTPtQ1xohBSIrRjrV475+TGv7LL5YkvcstUDL
         t5UEO0rueLisqL7qkB4Q+EnY1lbWo2BSm80MZe9lF77x00/ApCAkNdPQ29AVtXZrBzSV
         mGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6r1JLPg0IqKaayCtOulc2ZNroj/XXnXaGCny+Yao7NE=;
        b=TCdUorwEZW2mfm9Zp0LtXk78IeNuisGyohAnhGpTykYjJPQup6Y6aBsHtReDWG+HXr
         Qkkl08+5T5BcHol+EMyKxYfwB3pz4W5Nrq9aYuUTEK2+yhayN4aFZAsGBiPrz+2pfp9p
         NsD5NGCDmRjVIY3/OSwUYzCFfLOxtS+lSphsT1B0pex65vFYtMpKaKUxK/F1zqlmoy2p
         tzjJxw3XN4UvPGkNYxBtAnhnAcdRRVgDEbb3YcY/A3RNo/rymnFEnHknNsc0R4pJT5hx
         EW1ALRh4FiB8fgEe5tPknhzDJoVLljSGIW9mNpHn/z5CKVJgsA3rqXbC4ZnpqvG9wcIr
         Be9g==
X-Gm-Message-State: ABuFfoiSloX1B/6zGPIVvPZr+y14NcKdQTL/JbN8NQBPO/aEIRSP0JV4
        0Q+4wDAqEQsDUKs9SpjOYZPnJW9pFwM=
X-Google-Smtp-Source: ACcGV62rlOB4qQIzKX72QoHlAVikzhrZQ33nMY3cTTZTTmE2Tg15SAdvD8aUnMS3vAVL0RntIB07kg==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3-v6mr3577275plk.333.1539302616813;
        Thu, 11 Oct 2018 17:03:36 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k24-v6sm21599857pfi.11.2018.10.11.17.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 17:03:35 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:03:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181012000333.GA68467@dtor-ws>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
 <20181010170219.GA47260@dtor-ws>
 <CAMuHMdXypH2mKoGoY2=_L2_C3YV_v=9OLNCOHE5+u1QaWhHz_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXypH2mKoGoY2=_L2_C3YV_v=9OLNCOHE5+u1QaWhHz_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Oct 10, 2018 at 09:04:08PM +0200, Geert Uytterhoeven wrote:
> Hi Dmitry,
> 
> On Wed, Oct 10, 2018 at 7:03 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Same goes for patches that deal with error handling in probe() functions
> > that your AUTOSEL scripts like to pick. Yes, they are fixing bugs. But
> > show me actually users affected by them? You encounter these issues with
> > probe when you do initial device bringup, but once device is stabilized
> > probes are expected to succeed. There won't be duplicate sysfs
> > attributes, memory will be allocated, and so on. Fixes to remove() might
> > be worthwhile if it is a hot-pluggable bus, but otherwise - no. Yes, the
> > box may OOPS if someone manually unbind device through sysfs, but the
> > solution is no to patch stable kernels, but simply tell user "dont to
> > that [yet]".
> 
> In modern days with -EPROBE_DEFER, bugs in probe() are much more likely
> to cause damage than before.

Yes, as usual, the real life is not quite as black-and-white as I
painted it to be ;)

If the patch handles failures that could be result of signalling
deferral I would consider it for stable. OTOH it is not very likely that
older, previously working device, will start signalling deferral where
it did not before, so if we see deferral it is likely we are dealing
with newer platform, and it is unclear how far stable backport should go
in this case. So again, choices, choices ;)

Thanks.

-- 
Dmitry
