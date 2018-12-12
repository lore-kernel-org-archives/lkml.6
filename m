Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51353C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4E820870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="So6IaWcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4E820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeLLLFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:05:13 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36170 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:05:12 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so9154532itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zl65wYhWgxumjBrCQBpV7u87LqosHGb3K67coRfqFqE=;
        b=So6IaWcHN3kfoitaYVOFqvpQvaQeK2oY/S4kK1u5ZO2+VJij9OKgL3TsruZdFVUTLM
         HBtQdUdo4NiKqSix1QdZ9AJ6T4LYtMHfCvca96YcF8g4P6KXE/1aI1aGEuuL3augC5Cd
         /BGJCHO1wOw+LIn3qaEkuBqRM5cd2hB7HOhn/MeC9xfJYcHY01oZVuobxr3pvTXt++qx
         VGcjgPm5zD8UPTpWEix5PqlqD22qz+h+8CmAnKs1z/oJSB66ovtZtUpaWgsHTrcZ0dVX
         YithaOR0xt493Uk08ccapVp5xFRW+8lDGnUfCZyMcbwPXU5mfx1pNPlnKWVA/qCUHV7y
         VjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zl65wYhWgxumjBrCQBpV7u87LqosHGb3K67coRfqFqE=;
        b=tP5plrLX+z3Mx/IpTWFz6PryQGJXKLxJmUwlznFg8jBDSDC0p2Py62E7/0KvxvR4KF
         4HAYqwBqccpTbOcolUwz4mqLAnvendNcGTfNMrhjJJ7dHI58v21xop9PTfgB8Gu9zuzb
         cC+pUiA6A2+1BYMkYp9RdqUvkfkOP+jSV+4IwQpOZwtBwbnU/Us+4GeE31NjaNsRRuy4
         ThS61jgvjM/b3mRspzI3uRm3wFO2sBelrFTCP96oO3gyA9KYE9OIh9PqF7Jz+WGVjj2x
         3mJCBHqvayLqAkoGDO+c76/9xFKaV6T12xcN1q9ZjL67YYT4a57b/l5k/9XqOKAsIBA0
         /OHw==
X-Gm-Message-State: AA+aEWYmCmmUdR4ALMOWaDgdxW/EFebVte9lrV5KHHaouR1xZL40vEyr
        6mEHO25kEhPOSM6AaQdZa1IykfC6CGsv4sDXMdVNdK94SQg=
X-Google-Smtp-Source: AFSGD/XcQhoLHqDm9MdNT2beNWIY01r46TkBORmIw1I71ADxqn5zgjJjnlITnXL6F+i+KzTcFe0pk6ug5LZTid9cyCI=
X-Received: by 2002:a24:eb0b:: with SMTP id h11mr5405662itj.138.1544612710887;
 Wed, 12 Dec 2018 03:05:10 -0800 (PST)
MIME-Version: 1.0
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
 <20181212104304.49026ed2@xhacker.debian> <CAPv3WKctDNJVq7SgHBZLO_TU50ponCLu7h5oMKLTndBiDadhaA@mail.gmail.com>
 <20181212172006.0814cf03@xhacker.debian>
In-Reply-To: <20181212172006.0814cf03@xhacker.debian>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 12 Dec 2018 12:04:58 +0100
Message-ID: <CAPv3WKd71XBeUo2d7199f-LNs3ZVKOMBDBB69Mtufy_Qr_w81Q@mail.gmail.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
To:     Jisheng.Zhang@synaptics.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        netdev <netdev@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        nadavh@marvell.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

=C5=9Br., 12 gru 2018 o 10:25 Jisheng Zhang <Jisheng.Zhang@synaptics.com> n=
apisa=C5=82(a):
>
> Hi Marcin,
>
> On Wed, 12 Dec 2018 09:22:57 +0100 Marcin Wojtas <mw@semihalf.com> wrote:
>
> > Hi Jisheng,
> >
> > =C5=9Br., 12 gru 2018 o 03:48 Jisheng Zhang <Jisheng.Zhang@synaptics.co=
m> napisa=C5=82(a):
> > >
> > > Hi,
> > >
> > > On Tue, 11 Dec 2018 13:56:49 +0100 Marcin Wojtas wrote:
> > >
> > > > Recent changes in the mvneta driver reworked allocation
> > > > and handling of the ingress buffers to use entire pages.
> > > > Apart from that in SW BM scenario the HW must be informed
> > > > via PRXDQS about the biggest possible incoming buffer
> > > > that can be propagated by RX descriptors.
> > > >
> > > > The BufferSize field was filled according to the MTU-dependent
> > > > pkt_size value. Later change to PAGE_SIZE broke RX operation
> > > > when usin 64K pages, as the field is simply too small.
> > > >
> > > > This patch conditionally limits the value passed to the BufferSize
> > > > of the PRXDQS register, depending on the PAGE_SIZE used.
> > > > On the occasion remove now unused frag_size field of the mvneta_por=
t
> > > > structure.
> > > >
> > > > Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation
> > > > method for SWBM")
> > >
> > > IMHO, we'd better revert 562e2f467e71 and 7e47fd84b56bb
> > >
> > > The issue commit 562e2f467e71 wants to solve is due to commit 7e47fd8=
4b56bb
> > > It looks a bit wired, to introduce regression then submit another com=
mit(in
> > > the same patch set) solve it
> > >
> > > Per my test, after reverting 562e2f467e71 and 7e47fd84b56bb, I can't =
reproduce
> > > what's claimed in commit 562e2f467e71 -- "With system having a small =
memory
> > > (around 256MB), the state "cannot allocate memory to refill with new =
buffer"
> > > is reach pretty quickly."
> >
> > I am not the one to decide about patch reverting. From what I
> > understand, commit 7e47fd84b56bb was intorduced in order to increase
> > performance thanks to replacing mvneta_frag_alloc/free with using
> > entire pages for RX buffers. I have 2 questions:
> > - without reverting anything, do you observe memory allocation
> > problems during refill?
>
> I see memory waste: For normal 1500 MTU, before commit 7e47fd84b56bb we
> allocate 1920Bytes for rx. After commit 7e47fd84b56bb, we always allocate
> PAGE_SIZE bytes, if PAGE_SIZE=3D4096, we waste 53% memory for each rx buf=
.
>
> > - are you able to check L2 forwarding numbers on top of the pure
> > mainline branch and after reverting the mentioned patches? I'm
> > wondering what would be the performance penalty (if any).
>
> I didn't have the numbers. IMHO, when the performance number should
> be put into the commit msg when introducing commit 7e47fd84b56bb.
>

In general I agree with you about the memory waste and lack of numbers
backing the 7e47fd84b56bb change. However the improved refill
mechanism from 562e2f467e71 is something IMO worth to keep, so simple
reverts may not be the best idea. We should focus on dropping the full
page per descriptor dependency - I want to do it, but since it's a
slightly bigger rework, I cannot promise it will happen fast.

Best regards,
Marcin
