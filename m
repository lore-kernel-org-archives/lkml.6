Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD02ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E13D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E13D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeJREX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:23:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37307 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeJREX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:23:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id o14so27579288oth.4;
        Wed, 17 Oct 2018 13:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymd5wralDBwI1+nvWrInzavSha2pjNT5R8MNAt3lHjs=;
        b=IJNEeuu32CBbx8FVAsB9pUOUbRBmJau1d3YF+6OFWdx98U0ufrge+vtfC+QZuynNps
         GCA/hUI+cffpy1hz3jXNffHkWIBEUemivpBAFcp1vqx6IVMbtAa4he/hG35rwZi5zA23
         6n2VH1PIIyWE1HfdlLWv8NGnQA4J0+zTHwzQJp3Y9BbHxvkjbNsmQWX8L3vdilO5CVvw
         hhOnH2cZ1SAQEZO4ZmIrVdsQVt9/a+CbTZaDjrbAYbcKENh9nH6Y1ueKhgyF6b1Y05nz
         BK4Qc9TOZLjgWU77jo9VY6SLhYetn1G+6NGUwhVbbiC77D+LRKsUsyW9HdZCx1jDUAZf
         I4LA==
X-Gm-Message-State: ABuFfohYWCg9okHInbL6+VUwunR+7dLluNBlyP2ZXu1TN8C2qUzeiotq
        fzc5qsJKmWcaGEfoTO1AmqCroPcLS/pNfTkLweQkDkF1F4g=
X-Google-Smtp-Source: ACcGV62x+Z7nz/E8dRPJzUgVEXNeJ6lIBa5mTdv/llLukctvmcYRZkOVFtuHkNCo+W0r/ZazXX5apH/2yWN3IscUIkM=
X-Received: by 2002:a9d:59ae:: with SMTP id u46mr16612272oth.243.1539807994864;
 Wed, 17 Oct 2018 13:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180606193811.16007-1-malat@debian.org> <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
 <20180831203752.37rsceiwotcmeses@pburton-laptop> <20180831205857.nb3ij3rzhfs2fu42@pburton-laptop>
 <CA+7wUswC1SfC3G0RRH7OV4C6nQsp59R62FN_NiDSyCpxRDf__Q@mail.gmail.com>
In-Reply-To: <CA+7wUswC1SfC3G0RRH7OV4C6nQsp59R62FN_NiDSyCpxRDf__Q@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Oct 2018 22:26:22 +0200
Message-ID: <CA+7wUsycUxKoCEk1CW+RKfJ5e9AxOumyfKoF93JYw3qmU5r=nQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Mon, Sep 3, 2018 at 8:15 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> On Fri, Aug 31, 2018 at 10:59 PM Paul Burton <paul.burton@mips.com> wrote:
> >
> > On Fri, Aug 31, 2018 at 01:37:52PM -0700, Paul Burton wrote:
> > > Further to that, this series doesn't seem to work for me. With
> > > v4.19-rc1, with the patch from [1] & then this series applied I see the
> > > following when booting a ci20_defconfig kernel:
> > >
> > >   [    0.846684] ALSA device list:
> > >   [    0.849642]   No soundcards found.
> >
> > D'oh! Apparently I haven't drunk enough coffee today - missing link can
> > be found below:
> >
> > [1] https://www.spinics.net/lists/linux-gpio/msg31965.html
>
> Awesome, thanks for testing. I'll return to this series once I receive
> replacement for my laptop hard drive.

I see it now :

[    0.289701] bus: 'platform': really_probe: probing driver
jz4740-i2s with device 10020000.i2s
[    0.289713] jz4740-i2s 10020000.i2s: no pinctrl handle
[    0.289782] OF: /i2s@10020000: could not find phandle

I'll try to make sense of this.

> thanks,
> -M
