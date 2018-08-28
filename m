Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A456F20880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSfKoFte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A456F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeH1UyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:54:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35716 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH1UyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:54:25 -0400
Received: by mail-qt0-f195.google.com with SMTP id j7-v6so2535608qtp.2;
        Tue, 28 Aug 2018 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AG16YByWFJVLXWZ9W3ecTP3OiU3qcAbxM0zp5GnZyNk=;
        b=iSfKoFteL6MFKMcnfJeYo1Mdu/36HYhrgQyaBJ16N2nUUjcBrUQZSohfsy8xBui6tW
         9tLM7++4IWDDzdf783Pt+UsYG6oOZUDCZ6WgFP24GKbP0hWWM3pE3LHn73oD1D5VU8Sb
         OyuH65pD//r8cYA1bq68jBpSu4Lm/fCa4J/+vtqj8hWfALVXn74K+lfSlgBWICHhcCQN
         hHYJE66kZml6BW7Glz9ZRuFGg5k04VimK4Tp4RKX674lnARj4Q+2SSlutdEGG4EsKjs3
         1IorW0x0+Dz8eXFYUhOPyIA5iC70qSIHwdeHSTCBgOOQBG/rAlqLttqdu/ud0M+IaPUp
         v8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AG16YByWFJVLXWZ9W3ecTP3OiU3qcAbxM0zp5GnZyNk=;
        b=idFRk71hT3IcE2pGKFGCxqd6OXaRYsiQOnKGIP1+ZuqtnqNXZ7Od30tEhEO0Lz5ipn
         VanlkJZ6y1tqAfjonLMxbFNYFq8EkVDX4Z5HM/Ju7tLzbOMG2KftdQ9CcxkA4hM1B71Z
         AY/1++MQiPs3dEwlYE2jVNlajjZnMEfHkeqoqfJdROMXv1FjiDLv/A0ZfUdbUTgDqRy4
         Buv0PSwKThFbkrU+0WAxM7c2Rq5zbJIO8Lx5Jj6neGiOYe6HV7U4KgAUxYOoUnZP16Ff
         eQ03O/ZNCEl70oHKCLY5FQQIoRq0IiVOHZxcmIppfriIXxp/hzhk0yJX7VsUjys8HdME
         maXQ==
X-Gm-Message-State: APzg51DMXq51wck5quLuqAUag1Ve5/H9CgM+CscXPfIYhw3EHQRyFxdV
        FFMlqJC1QYpXHifi3HZDWkIk6xiId+8izMCcSOE=
X-Google-Smtp-Source: ANB0VdbF5oiYIq2ssNLqLcEdccfklP+gQoTx5m1awYZSxOba0nTTRqG7g6adc9vc1EwpPM/SFScItnMYbKuKr5Bsc/8=
X-Received: by 2002:a0c:8b11:: with SMTP id q17-v6mr2521899qva.193.1535475710756;
 Tue, 28 Aug 2018 10:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180828154727.3589-1-ianwmorrison@gmail.com> <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk> <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
 <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
In-Reply-To: <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
From:   Ian W MORRISON <ianwmorrison@gmail.com>
Date:   Wed, 29 Aug 2018 03:01:37 +1000
Message-ID: <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com,
        hch@lst.de, bart.vanassche@wdc.com, hare@suse.de,
        ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 at 02:13, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/28/18 10:10 AM, Ian W MORRISON wrote:
> > On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
> >>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
> >>>>> Kernel oops when booting on Bay and Cherry Trail devices
> >>>>> such as Intel Compute Stick. Bisected as:
> >>>>>
> >>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> >>>>>
> >>>>> This patch reverts the above commit.
> >>>>
> >>>> Did I miss the posting of that oops? Just curious where this is
> >>>> going wrong. Not adverse to reverting, but I'd like to try to
> >>>> understand the issue first.
> >>>>
> >>>> --
> >>>> Jens Axboe
> >>>>
> >>>
> >>> I've not been able to capture it however manually transcribing what is
> >>> on the screen:
> >>>
> >>> mmc0: Got data interrupt 0x00000002 even though no data operation
> >>>
> >>> followed by:
> >>>
> >>> mmc0: sdhci: ============= SDHCI REGISTER DUMP ==============
> >>>
> >>> Do you want any specific register value or should I transcribe each
> >>> (as I am working from an image taken at boot)?
> >>
> >> Just take a picture of the screen, that should be good enough.
> >>
> >> --
> >> Jens Axboe
> >>
> >
> > Attached as requested.
>
> Can you see if this patch helps?
>
> https://marc.info/?l=linux-mmc&m=153485326025301&w=2
>
> --
> Jens Axboe
>

I confirm that the above patch works with commit 6ce3dd6eec11
and removes the need for reverting it on eMMC based devices.

Tested on Bay Trail, Cherry Trail (both now working) and Kaby Lake
(not affected) devices.

Many thanks,
Ian
