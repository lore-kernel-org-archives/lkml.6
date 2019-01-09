Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB030C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724142075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvdafmnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAIWLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:11:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35677 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfAIWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:11:38 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so5412238qka.2;
        Wed, 09 Jan 2019 14:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QW18+eB2DJo7cyCD2LvBplL480Z3+nXLq52xkRHz/3Q=;
        b=BvdafmndzPIGamvpO5bueEs2XNZSB7h0Kv5hW9LLEIDhdbvK8Ji3rUE2mwqP8dKBbN
         OBbWEXRvxjICBEcNfy/EgU4v6x38yGocMLkcM9fblsy97oNgSwX8qfUb7FhMWAGtEc3L
         KKzYbR/C3mp5okhchcOYrN8L0L2a4n6rYkDxCyXFbimpw1EDmyx0vCMb765wqmoASn7j
         sjXBwcr5yaYgzhRbAUweDqfcgg8NhftQmeiwXGwJng2VxmAyy6AHfsP1+uW0wOy2UJok
         TQckyQIivR+QY33KlH6gPxOCQj/EsXV6GPQWBjr2v+eO8x+1N6FL+9l/a2IrKdcejuXo
         8NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QW18+eB2DJo7cyCD2LvBplL480Z3+nXLq52xkRHz/3Q=;
        b=hEBflwP17hE98Hoy8LjJ66t/bS1lUjQWvbB1yLDcKLicuB3Skws2YHlqjL9vGIPnVd
         ajXiMdN7UBz63OTmSdl9BZfQxK9TS1gp9j+7HROUocGIZnJ5F/fcZLoCYEq0hzn6h3Q1
         od5k0xt4XJ6sNEYMuPG7xLT4CrA0p+8tggIcWpcaZCr8EriZ803Y/fdK/IVYQUt+kD2f
         MlVsdA7y2QrkVaNllhuHM7Uwi+HAsKq59jxZxCLLEglWcU2CtkosGFzDa3lMyHE6n0Tn
         DOYkyh7h5Pjrov0X2/59xmLyqwe4Cdf5YiglMmTWRWvqHSBodLZ8QwrgnfSGNl3DmrKW
         Lu/g==
X-Gm-Message-State: AJcUukdl45TSrsbn9dYu/yuq9qIoKAPrKy/yTQQm6VipPH9WljS5rJ81
        +oLtFp3rEP0TK4As43tYZTr0cNugAyGsx9RfWMLcpso/jhg=
X-Google-Smtp-Source: ALg8bN4HryBWGTV4XGA6BLxtpq/r2mLLzESSPT2yJ1nIdt6syR3PKQFuVRG083/nc3hrRTiU1f3kaHew1SO3U7JK0Xo=
X-Received: by 2002:a37:6cc6:: with SMTP id h189mr7043851qkc.186.1547071896300;
 Wed, 09 Jan 2019 14:11:36 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
 <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
In-Reply-To: <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Wed, 9 Jan 2019 16:11:24 -0600
Message-ID: <CALaQ_hp4XoEbT7qYG58fbrODbHvOFS7-GQZcEoPw4CPDNZZ+6w@mail.gmail.com>
Subject: Re: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 -
 Kernel 4.19.13
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, my system got wrecked (exaggeration) during this latest stretch...
Pulseaudio was stretched to the limit and beyond and was forced to
restart. Anything that was producing audio had to be restarted to get
it back.
This time was much like the first time and went from timestamp
573100.060927 (line 1) to 572506.604155 (line 11069), where 100%
(literally) of it was that event 37 in the journal, no other kernel
log entries except for the systemd-hostnamed audit before it all went
down.
And as usual, it was my USB TV tuner (tvheadend really) giving the
Poll Timeout log entries.
Those same uploaded trace files will be updated with the latest bugout.

On Wed, Jan 2, 2019 at 5:32 AM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> The event type 37 is a host controller event, most likely a event ring full error.
>
> So there are probably so many events that we fill the event ring before we can handle them.
>
> Could you take traces of this?
> Note that the trace file will be huge.
>
> mount -t debugfs none /sys/kernel/debug
> echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
> echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
>
> copy the traces somewhere safe once the error is triggered:
> cp /sys/kernel/debug/tracing/trace  /<somewhere>
>
> -Mathias
