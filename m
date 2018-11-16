Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3C6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D019F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 04:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jltj8ScP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D019F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeKPOTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 09:19:10 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38462 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeKPOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 09:19:09 -0500
Received: by mail-yw1-f65.google.com with SMTP id i20so2222463ywc.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 20:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lDgQgHCcGh7S5IwKNxUZEdo9Y/2qoMMSXzNIx5PZ0+M=;
        b=Jltj8ScPsxOfnzUgBEGY4meIyqhwhTLo9jMdHunGvDYt7GoOZsP0tln/DGoEgHW5Lo
         HbNYNbMoJ7gbGkKM9HOMjsPvaMxVhzoAQ63ZgEXe4l1pQRdCrmhv3F0xOqMsz090ylr5
         2Tev8wjQx387TOP38Jd3X2dViZRmGJBPlaFTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lDgQgHCcGh7S5IwKNxUZEdo9Y/2qoMMSXzNIx5PZ0+M=;
        b=soXz6F4qknMHxPnAR0B53VhR8uhP8Di8IAx4c1REqu1wkmyK5z6nVwPXwgbf1k1bIM
         p4Hl6XfExjJBtQNFKgnoFKtr5P0bIQV5eii+L395Mxi5MYkWK8V9aJKONltxo6bME9CD
         4Dk36MO5zIpeyj9fSYZFBL0P2/THbk1EhawTZQv/rTvxi/MidvMlfaiMTb3oX8IMImg2
         Ae6M5Biqq7y3zBG+SLopXm4NMNt6nVJrgSMH1KBU9YECr70gYeiHKDDTa26gkC6lN/6f
         HwVqe8FQfeg7wDpyusLfQ/sZGdO8HkIJfRqsLphq8fxe/zauZXwuxk9FCo+tGRwl9Qqb
         UQXQ==
X-Gm-Message-State: AGRZ1gLmvQi/U1H7s+293eAPdwL15MT+udY3+fAIVVsUWxp9nTrBhiTY
        rUjZqSneTcm1O6aq5FRvf06he8/a3tQ=
X-Google-Smtp-Source: AJdET5ez/mjEPxRqM8YbWCe7SBRPm/F2J3N/m5aZ+l0X0KHL64LZw88Pq6HtFXUAZ4daWKgqH/Ch2Q==
X-Received: by 2002:a81:83d6:: with SMTP id t205mr2949707ywf.497.1542341304367;
        Thu, 15 Nov 2018 20:08:24 -0800 (PST)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id v136-v6sm7152039ywv.19.2018.11.15.20.08.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 20:08:23 -0800 (PST)
Received: by mail-yw1-f51.google.com with SMTP id k6-v6so9577790ywa.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 20:08:22 -0800 (PST)
X-Received: by 2002:a81:a8e:: with SMTP id 136-v6mr3979043ywk.92.1542341302479;
 Thu, 15 Nov 2018 20:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20181113093048.236201-1-acourbot@chromium.org>
 <CAKQmDh-91tHP1VxLisW1A3GR9G7du3F-Y2XrrgoFU=gvhGoP6w@mail.gmail.com>
 <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com> <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
In-Reply-To: <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 16 Nov 2018 13:08:10 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cw2jmNwHCWYriw4H0TK0uWhVFbgs_RgxXV5npZLWvLbg@mail.gmail.com>
Message-ID: <CAAFQd5Cw2jmNwHCWYriw4H0TK0uWhVFbgs_RgxXV5npZLWvLbg@mail.gmail.com>
Subject: Re: [PATCH] media: venus: fix reported size of 0-length buffers
To:     nicolas@ndufresne.ca
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 1:50 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mercredi 14 novembre 2018 =C3=A0 13:12 +0900, Alexandre Courbot a =C3=
=A9crit :
> > On Wed, Nov 14, 2018 at 3:54 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > >
> > >
> > > Le mar. 13 nov. 2018 04 h 30, Alexandre Courbot <acourbot@chromium.or=
g> a =C3=A9crit :
> > > > The last buffer is often signaled by an empty buffer with the
> > > > V4L2_BUF_FLAG_LAST flag set. Such buffers were returned with the
> > > > bytesused field set to the full size of the OPB, which leads
> > > > user-space to believe that the buffer actually contains useful data=
. Fix
> > > > this by passing the number of bytes reported used by the firmware.
> > >
> > > That means the driver does not know on time which one is last. Why no=
t just returned EPIPE to userspace on DQBUF and ovoid this useless roundtri=
p ?
> >
> > Sorry, I don't understand what you mean. EPIPE is supposed to be
> > returned after a buffer with V4L2_BUF_FLAG_LAST is made available for
> > dequeue. This patch amends the code that prepares this LAST-flagged
> > buffer. How could we avoid a roundtrip in this case?
>
> Maybe it has changed, but when this was introduced, we found that some
> firmware (Exynos MFC) could not know which one is last. Instead, it
> gets an event saying there will be no more buffers.
>

It was never the case with the MFC (firmware/driver) we were using on
Chrome OS and it doesn't seem to be the case for the current upstream
s5p-mfc driver.

> Sending buffers with payload size to 0 just for the sake of setting the
> V4L2_BUF_FLAG_LAST was considered a waste. Specially that after that,
> every polls should return EPIPE. So in the end, we decided the it
> should just unblock the userspace and return EPIPE.
>
> If you look at the related GStreamer code, it completely ignores the
> LAST flag. With fake buffer of size 0, userspace will endup dequeuing
> and throwing away. This is not useful to the process of terminating the
> decoding. To me, this LAST flag is not useful in this context.

Except that -EPIPE is actually signaled by the vb2 core and it happens
after the user space dequeues a buffer with the LAST flag set:
https://elixir.bootlin.com/linux/v4.20-rc2/source/drivers/media/common/vide=
obuf2/videobuf2-core.c#L1634
https://elixir.bootlin.com/linux/v4.20-rc2/source/drivers/media/common/vide=
obuf2/videobuf2-v4l2.c#L555

Best regards,
Tomasz
