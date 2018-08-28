Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81797C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B7720893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLIeyD4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B7720893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeH1T7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:59:40 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:43710 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH1T7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:59:40 -0400
Received: by mail-qt0-f177.google.com with SMTP id g53-v6so2290542qtg.10;
        Tue, 28 Aug 2018 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEmgqgZaVGQ8pcFdoUu93CYeZO36hpseygM7FISJuDM=;
        b=oLIeyD4oAaItsSdXNfw35nOn1Cb2McOm+fHSqeQayPzG5/QEQUCDMwQQuTtJ7koIIl
         PF4zAZiY7iNQKEwbw+hz02fmAV/TMkduUiWOOrPgc0214W4Bz/YciWxio0bdLQcgBKUC
         QEsOzpv2xTgW5BuMnL443uMwwPtrK3PoAbC+XittFrGiulbvgLH4wQfSIr+jGja6vlJ4
         hgzpNn9tPr6TIZkeRWumcZTPsgb1iY/7lXgrHid0mXykgpcwglK8SP0IfH3l/ZgpZ1SM
         GR6R6YPA2EPY7C27TdTh8W4/sOK9XinPMBtZqToGi7RoIFDoc37PFiQvIMrhYcSyqz8k
         JP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEmgqgZaVGQ8pcFdoUu93CYeZO36hpseygM7FISJuDM=;
        b=EbwBmhfvPaQ2pwnb42u7bbAw863vF3WYZAFIUkgTQ4z6K9o8SMATFGNIaxO76Xk9nX
         Mv7kGrfkkod8f3e1+7hCTnzP36Z7GwRGV6/O+oq078TrahPskeyEoz7k0OI34O8Dh4+h
         /GtNJGDClVHLGDoZeS1iicBVbrzkeJ+GnFHlY6MBL59rCyRVnt/iF/qN6wQx1FKHdSQW
         XFXhzaBMsRxcaBclCvu/2+PDWT5Dp7GhlgjZtWcgqdk3zzNV9AcJLCm5u3Jvp7+OXuab
         NYwAiaoMHgqWC8ULqnUhiMaL1eKay3w07LTG+fpu6VQSbd7sFMKxoof0BtEg6GJJek0u
         l54w==
X-Gm-Message-State: APzg51DVW/G09Wi2poLYCUnh177THtsXIkXT3Y1POtNShcdR6EokeI+P
        rF2KXfg2U5s8JCsGw7GqhumY7lA4hAnP5ysucEI=
X-Google-Smtp-Source: ANB0VdZBB3KI5GUaVzb4S+kW/6dZkNlQsbUGQqxsXkxQtQ0xri4DwrOXr8x9FG0qc/MAfy0/oUfebUwS6S3Vicmlaao=
X-Received: by 2002:a0c:ab43:: with SMTP id i3-v6mr2279769qvb.87.1535472438219;
 Tue, 28 Aug 2018 09:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180828154727.3589-1-ianwmorrison@gmail.com> <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
In-Reply-To: <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
From:   Ian W MORRISON <ianwmorrison@gmail.com>
Date:   Wed, 29 Aug 2018 02:07:06 +1000
Message-ID: <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
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

On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
> > Kernel oops when booting on Bay and Cherry Trail devices
> > such as Intel Compute Stick. Bisected as:
> >
> > commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> >
> > This patch reverts the above commit.
>
> Did I miss the posting of that oops? Just curious where this is
> going wrong. Not adverse to reverting, but I'd like to try to
> understand the issue first.
>
> --
> Jens Axboe
>

I've not been able to capture it however manually transcribing what is
on the screen:

mmc0: Got data interrupt 0x00000002 even though no data operation

followed by:

mmc0: sdhci: ============= SDHCI REGISTER DUMP ==============

Do you want any specific register value or should I transcribe each
(as I am working from an image taken at boot)?
