Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35505C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04257214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04257214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbeKVGzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:55:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43684 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389352AbeKVGyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so5262316qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRjxJoHyWVS4XjqdcRM0pfqjiGJnAqqkKVmP/gwOPrA=;
        b=MbunCfzdQqf3qO5nHold71aeFCs5zhhRFkglpbaDbeHMjS9pyddwy68kFK+ubm/8jW
         Omih7YvZyAnbnN5BNkqCW5qcGFcky+ZEPfVswRYzs3nU+dYZ43O/e8Oad5/OWXhtJn3E
         dD1bG8Hsqn2N1Mk7u/ZF23IofB6FUuNKfILM+mDZI53jcX0l9GoIolfrALKdnUMQIzmT
         AzPTLcujF/zzNCzYP9YelsO7iJZK8keOH0ehEWweSOMr0DUAo78CWluzyvx0Ni6XVI9R
         rmT7ZdEnj/vgbEhcvDjOn7wiDfoQjnFPcKc4iIdUmID5TTsF+k1bQ9CZx3VZvjZzwQjY
         KXyg==
X-Gm-Message-State: AA+aEWZetNNnoTMle9OAlcFVuUUjWLscpXwT29Z627//kgovKzmXcNg6
        jpbRAvGtGGF7sq0erE2hBp5QH/VSr6Nfcmodxu0=
X-Google-Smtp-Source: AFSGD/VEpIjV1QIkYRyxmmqW0ZeDT1KN5j9FCSa1Dzdi1ToYJmWAT/R6LOebhOIxCghvSkURTT+WljUFCZ0qBM6/wPs=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr7362572qvm.149.1542831499850;
 Wed, 21 Nov 2018 12:18:19 -0800 (PST)
MIME-Version: 1.0
References: <13D59CF9CEBAF94592A12E8AE55501350113CD10@DE02WEMBXB.internal.synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0B4CD5@US01WEMBX2.internal.synopsys.com>
 <9ffd1270-ad92-88b7-eb53-85c65fe971dd@synopsys.com> <f8c469e7-9e1d-18d6-4e56-ba4338462048@synopsys.com>
 <ebe7f165-2901-2885-0583-c7be53329372@synopsys.com> <4881796E12491D4BB15146FE0209CE6468198AC6@DE02WEMBXB.internal.synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA230750146415496@US01WEMBX2.internal.synopsys.com>
 <661a4323-5768-4977-5434-ab644c5418aa@synopsys.com> <C2D7FE5348E1B147BCA15975FBA23075014641580A@US01WEMBX2.internal.synopsys.com>
 <CAK8P3a1Gszsg7Wky+7Z8TuOtAtZR2ia-QjYm01-wWKRmYfdm7Q@mail.gmail.com> <C2D7FE5348E1B147BCA15975FBA23075014641664A@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014641664A@US01WEMBX2.internal.synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 21 Nov 2018 21:18:03 +0100
Message-ID: <CAK8P3a3MgjjspJd6S_WQZ7y+ZEPU8hRUD2QukkNQ7QxhccUn6w@mail.gmail.com>
Subject: Re: Misaligned Access
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Vitor Soares <vitor.soares@synopsys.com>,
        alexey.brodkin@synopsys.com, Joao Pinto <joao.pinto@synopsys.com>,
        jose.abreu@synopsys.com,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 9:15 PM Vineet Gupta <vineet.gupta1@synopsys.com> wrote:
>
> On 11/21/18 12:12 PM, Arnd Bergmann wrote:
> > On Wed, Nov 21, 2018 at 8:42 PM Vineet Gupta <vineet.gupta1@synopsys.com> wrote:
> >> +CC lkml, Arnd : subject matter expert
> >>
> >> On 11/21/18 10:06 AM, Vitor Soares wrote:
> >>> I use the follow function to get data from a RX Fifo.
> >>>
> >>>
> >>> static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
> >>>                         u8 *bytes, int nbytes)
> >>> {
> >>>      readsl(master->regs + RX_TX_DATA_PORT, bytes, nbytes / 4);
> >> So the semantics are reading the same fifo register N times, to get the N words,
> >> hence read*s*l is appropriate. That however expects the buffer to be 4 bytes
> >> aligned, hence your issue. You can't possibly use the reads*b* as we want the
> >>
> >> The obvious but crude hack is to use a temp array for readsl and then copy over
> >> using memcpy, but I'm sure there are better ways, @Arnd ? To summarize is issue is
> >> a driver triggering unaligned access due to the misinteraction of API (driver get
> >> an unaligned u8 *) which goes against expectations of io accessor readl  (needed
> >> since the register contents are 4 bytes)
> > Is this again on ARC or some other architecture that cannot do unaligned
> > access to normal RAM? On ARMv7 or x86, you should never see a problem
> > because the CPU handles misaligned writes. On ARMv4/v5, the readsl()
> > implementation internally aligns the access to the output buffer so it
> > will work correctly.
>
> This is indeed on ARC: on ARC700 unaligned access to RAM was never supported and
> on HS38x cores, it is configurable, so the API probably needs to support both cases.

Ok, then I think you need to overwrite readsl() with a variant that
uses put_unaligned() instead the plain pointer dereference for the
output.

      Arnd
