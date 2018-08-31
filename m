Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A72C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51362083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzBw6WqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51362083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeHaWKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:10:17 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:37676 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:10:17 -0400
Received: by mail-qk1-f171.google.com with SMTP id f17-v6so1950713qkh.4;
        Fri, 31 Aug 2018 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqdNPmVOAviacGJsh0tSGqhpZGx+X00esqnBdfA/WOQ=;
        b=UzBw6WqVHfiMrRakVpe3c2kSrUDV6R6mLy70d2Bk0Lgr/f6PhGTxR10CFMJjZfE2O3
         xLuVjOHr2U9ghHSKxh8Y6qZTy3ijrCKAI+rwCL2P+M0u/bdwd/e0bRktFvf+JKkIT8EV
         xbFfMpRLGDEYyHEHA9daboiR/JRvis52neX4Yl1nXIcwwrHQmvF4tNVwTFhMsZMh6IOO
         GbmzrVcSTD5aNdN4IvJn+5tWGrMhYPhYxpAUF4ldWIZ1hfioL/CXBX455xB9VawkindV
         /f0cRwMLJfsQPtVKM6xl+I/eBiRECVjfepuu/BUBQhuDyLSeI/HmURAQ5MxQKOj5aFy/
         THFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqdNPmVOAviacGJsh0tSGqhpZGx+X00esqnBdfA/WOQ=;
        b=Jrw6l204dbHgzy1lt/Iu31jpjBiJst8uy//0RtJLIhfF/IQoRWKmotv/I8YRlozM10
         XA584QN/yhL54G7mMBrkHRGimnECXU8lSvCWBu9mJ3Z4U76m4tWEt2Qpp14tvyr1v+cM
         5qvpFpB4THTW4p8U+hH1Ba9MpkRnUyhb0lHe8cyNrXwW1EnARr6aFGwT0EohBRgPnYlY
         /t5cna0dUPjCAhWGAIKRy8+VWlqeRL0yzpyhPBbAn9wQewucjlQ9s8Jmkwkb6B1pgyU4
         bKl4ksR+MosAXdLVYtKBjqmDOzesfpARVHcnGHKFJKb8TYAx44HVza+XvxDzfaXgN5Kc
         U0FQ==
X-Gm-Message-State: APzg51AUQof/SfomBehWG0jvArAF5kdqR0XeE7MTrkmi8kft4/ucc80q
        1uE+A7+ngSQv4E7XLJ1RWy+KS4aHqSoBjBBFezs=
X-Google-Smtp-Source: ANB0VdauHfnotUM8HlTd+dOQV7m92e3MOztOF0pT3rNi3/UNTBsgtjM491iaSU+khywp3VCNMALqj1zi+prHwYQ3UxI=
X-Received: by 2002:a37:c511:: with SMTP id p17-v6mr12103237qki.136.1535738499911;
 Fri, 31 Aug 2018 11:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180831130356.6b0fd971@canb.auug.org.au> <fe65a78f-51fb-248a-565a-f21594caa957@infradead.org>
 <CAJYdmeMYT_L841XsUOYYepen7WOSp-6zU40QbRy97G5GPzAygg@mail.gmail.com> <20180831175427.GC19733@lunn.ch>
In-Reply-To: <20180831175427.GC19733@lunn.ch>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Fri, 31 Aug 2018 10:52:34 -0700
Message-ID: <CAJYdmeOELPeG=xwkW5ODgQ+hVnHXFn6YOhtCaCdZS2z-uY2Uvw@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 31 (nixge.c and phy)
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Randy Dunlap <rdunlap@infradead.org>, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Fri, Aug 31, 2018 at 10:54 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > @@ -20,7 +20,6 @@ config NI_XGE_MANAGEMENT_ENET
> >         tristate "National Instruments XGE management enet support"
> >         depends on HAS_IOMEM && HAS_DMA
> >         select PHYLIB
> > -       select OF_MDIO
> >         help
> >           Simple LAN device for debug or management purposes. Can
> >           support either 10G or 1G PHYs via SFP+ ports.
>
> Hi Moritz
>
> Since you are targeting both DT and non-DT systems, you cannot
> unconditionally select OF_MDIO
>
> What might work is
>
>          select OF_MDIO if OF

Sounds good. What's the process here? Follow-up patch to net-next?

Thanks again,

Moritz
