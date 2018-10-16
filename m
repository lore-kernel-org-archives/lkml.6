Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7356C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BFC208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="ys55mSlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BFC208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJPI5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:57:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35206 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeJPI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:57:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id d21-v6so11441617qtq.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58BO7VhVQCIpfvpsTCzExxe0HVPvAcHz+tjsTTvFTbA=;
        b=ys55mSlM61BiZo/NHWpSMyNMP+SW+uAmuVohraYIikuBQLlkG/av9B23T/5Sy3/9fE
         gWjr4hwhYA6Qc3efV9fzKYw4HBwzJYQ+jXx08eNJkMn2D2BK/NVpywere4iL3d3rPLkK
         Zlpan5gEYFot5SYHwbFkkz1KRi2y79zwWnwpxlALcx7CroZS3OrUHgY9n0jI+XAIfrns
         fqJSSUj8lQxmYc5llM5b1qp0NZclBWmkYRVceBWbbb426dMnUnqjZbPIRoLDK0zXMSSa
         MIUxwh99DFojaASG38qaHqttVAeaYA161OAT4nlDM+Q7XMItSg1HDFBP0IAH4a6HEk/a
         SVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58BO7VhVQCIpfvpsTCzExxe0HVPvAcHz+tjsTTvFTbA=;
        b=Dffub8LtOCM35Sny6qU5couynxfg/iUyJP5xWft6YP+cToLadhZKFiV8/GEVqTjRni
         LkdMjR2CP7p60yUi8jpL7kwitTRiMb+brMt/4TkLcciqIu/JV399EFEpbaBfFEZEFt13
         Bd9SJ97nzypMvDCCtHpB0mLTK6UyMuZY5ycB6TvF5LkDV7CxQN/iwjOqpFBZc8PVMJ8P
         q5Zk9jxBQ/Vv5Tm0T1T47I/C40GpvFhmh1qhiW5y+zY8jeqjYqlWfgkSGC7nDf52piqs
         zniqLdMbEXAoijzT/P83nWshbHflErFI+P2KMMLwSjPvJcT1w7IISnVai/8fe20UUhj/
         amIA==
X-Gm-Message-State: ABuFfogf/eMpKVcv7QPJMHdpw7grptBMFVryrxvc7QZz6NgDof1HXZh3
        eAnCIFaHENIvKfyoOvSaNfuxGw==
X-Google-Smtp-Source: ACcGV63I4cHeLkU8n1UZzDBoKxu7AM6QUwgyyO2jl2w/S8q+Roa+P3+Q4zDiMNGbMr2ArXaT7led/Q==
X-Received: by 2002:aed:33c2:: with SMTP id v60-v6mr18334623qtd.25.1539652160143;
        Mon, 15 Oct 2018 18:09:20 -0700 (PDT)
Received: from skullcanyon (192-222-187-87.qc.cable.ebox.net. [192.222.187.87])
        by smtp.gmail.com with ESMTPSA id r20-v6sm8379798qkl.12.2018.10.15.18.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 18:09:19 -0700 (PDT)
Message-ID: <3653d4a4317cfa8ee45bc8bc43c98576c339c09a.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?= 
        <tiffany.lin@mediatek.com>,
        Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Date:   Mon, 15 Oct 2018 21:09:17 -0400
In-Reply-To: <CAAFQd5ASZU-tSadEbE5NuD3aiNeZakPe-UT7oXdBxASqCpujWw@mail.gmail.com>
References: <20180724140621.59624-1-tfiga@chromium.org>
         <20180724140621.59624-2-tfiga@chromium.org>
         <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl>
         <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
         <a6af3dc9-1d09-a414-ce31-bc1b3e69894f@xs4all.nl>
         <CAAFQd5AnC+hWy4QUGE-s+qgRvvgGC7rMhH6x8koTfYJzTLw8Cg@mail.gmail.com>
         <f0aa7c84-08e3-9b04-8d1b-95f741d6817b@xs4all.nl>
         <CAAFQd5ACWO0FxzZdxf-N-GStCMOSWzxKxhcpCRUh=BqT7jLJWw@mail.gmail.com>
         <CAAFQd5ASZU-tSadEbE5NuD3aiNeZakPe-UT7oXdBxASqCpujWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 15 octobre 2018 à 19:13 +0900, Tomasz Figa a écrit :
> On Wed, Aug 8, 2018 at 11:55 AM Tomasz Figa <tfiga@chromium.org> wrote:
> > 
> > On Tue, Aug 7, 2018 at 4:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > > 
> > > On 08/07/2018 09:05 AM, Tomasz Figa wrote:
> > > > On Thu, Jul 26, 2018 at 7:57 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > > > > > > I wonder if we should make these min buffer controls required. It might be easier
> > > > > > > that way.
> > > > > > 
> > > > > > Agreed. Although userspace is still free to ignore it, because REQBUFS
> > > > > > would do the right thing anyway.
> > > > > 
> > > > > It's never been entirely clear to me what the purpose of those min buffers controls
> > > > > is. REQBUFS ensures that the number of buffers is at least the minimum needed to
> > > > > make the HW work. So why would you need these controls? It only makes sense if they
> > > > > return something different from REQBUFS.
> > > > > 
> > > > 
> > > > The purpose of those controls is to let the client allocate a number
> > > > of buffers bigger than minimum, without the need to allocate the
> > > > minimum number of buffers first (to just learn the number), free them
> > > > and then allocate a bigger number again.
> > > 
> > > I don't feel this is particularly useful. One problem with the minimum number
> > > of buffers as used in the kernel is that it is often the minimum number of
> > > buffers required to make the hardware work, but it may not be optimal. E.g.
> > > quite a few capture drivers set the minimum to 2, which is enough for the
> > > hardware, but it will likely lead to dropped frames. You really need 3
> > > (one is being DMAed, one is queued and linked into the DMA engine and one is
> > > being processed by userspace).
> > > 
> > > I would actually prefer this to be the recommended minimum number of buffers,
> > > which is >= the minimum REQBUFS uses.
> > > 
> > > I.e., if you use this number and you have no special requirements, then you'll
> > > get good performance.
> > 
> > I guess we could make it so. It would make existing user space request
> > more buffers than it used to with the original meaning, but I guess it
> > shouldn't be a big problem.
> 
> I gave it a bit more thought and I feel like kernel is not the right
> place to put any assumptions on what the userspace expects "good
> performance" to be. Actually, having these controls return the minimum
> number of buffers as REQBUFS would allocate makes it very well
> specified - with this number you can only process frame by frame and
> the number of buffers added by userspace defines exactly the queue
> depth. It leaves no space for driver-specific quirks, because the
> driver doesn't decide what's "good performance" anymore.

I agree on that and I would add that the driver making any assumption
would lead to memory waste in context where less buffer will still work
(think of fence based operation as an example).

> 
> Best regards,
> Tomasz

