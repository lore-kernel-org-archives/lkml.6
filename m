Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B52BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5D021871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7pegYCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfABIM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 03:12:28 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:41733 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfABIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 03:12:27 -0500
Received: by mail-qk1-f182.google.com with SMTP id 189so17434061qkj.8;
        Wed, 02 Jan 2019 00:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Khd0FNPXSnCiqOhVbbx5bXRgNu59tTuDnGyAwCjPmQ=;
        b=e7pegYCEHCMJ209IKRkE6siRKe/ZTJ1RIfCHZUup6RL3Imxm5SF6NO+NTp5JJ7dqtD
         s0OGXzwTZ5D2FXbJMv0MdaHJfet9SxS2gbRtL1cPBM//B8NJNXU0bnCt/4HwMTN/3h/Q
         IRsomxEGFH2ikDLfxsJp632esBxDcPfanHGkdbBisicaKg3qmghUBEsQuygz8Xhx+sNs
         wmo5BBIt81izDSqwkp/51bngzMq/XVTuwTFpG5E1K4qbQPzN2RhEjqOz+WwE6iDjoZV9
         VjS85H+7kfdS8bbeiZ6Fbkald4oEUc+/RWSJegPlQB+sf56odriB4qpsp1uBnTaQ4UcL
         wO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Khd0FNPXSnCiqOhVbbx5bXRgNu59tTuDnGyAwCjPmQ=;
        b=COUX4OZIAlje+TAXg0ARhQBSXJn1ZXryO6ypXhll++PwN/zoRZpQjZaZX5Uan63xUK
         3D+VoAMtwZoaXzaYdwzdBb+w5G0h+Kkh2twL3E0G1PfljdLbhR4wGkL5JWSOc7RMGYGd
         xuflamFo6zeyxKLCwuBu7G+ey4mAC4RHvyDfD7lolF0baFvMaw3CQ2Yd1PRlj0O3GiRS
         hylrlrJ+p68J6uHQF8EUNHUvWgz+CvEpwGzv08l919hPHh6K39LZGTRMWnP6Y4HKwD3M
         Sga1HvoXWNl7YSPEDy9dQtya49jiCIN4d6aj/aMB6AX2GRifb7BOzf3heUZpaAbBAzYc
         bjeA==
X-Gm-Message-State: AJcUukcLxjqlPPUpImWNm9Rd3BmxtjOocbLNwNaZ9zr4DGX6Hd6GfilW
        t+xd0/K4Jy93/6aYivGhpMPJCYqHi+REBs/D/zAejcuJ
X-Google-Smtp-Source: ALg8bN7lFXoJtacmaqsJENEHa1c4eDgIKUHzggTDM2bnuRNWwOlZqKHJbDuTAI3DhiTnfQ3pRsnP1Qk7dOLx0hQQEI4=
X-Received: by 2002:ae9:de44:: with SMTP id s65mr40522863qkf.55.1546416745756;
 Wed, 02 Jan 2019 00:12:25 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
 <CALaQ_hp26KFcF95-yY31rtdhiG3XKJ_A4_B7nsysbJMPEy6k5g@mail.gmail.com>
In-Reply-To: <CALaQ_hp26KFcF95-yY31rtdhiG3XKJ_A4_B7nsysbJMPEy6k5g@mail.gmail.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Wed, 2 Jan 2019 02:12:14 -0600
Message-ID: <CALaQ_hof-z=20ZUxBfnVM7evgjieq8WorZesURegV7v_ZQ7VDg@mail.gmail.com>
Subject: Re: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 -
 Kernel 4.19.13
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        mathias.nyman@linux.intel.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...But then again, maybe it wasn't the cable. It's acting up again.

On Tue, Jan 1, 2019 at 3:14 PM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> Looks like this particular issue may have been due to a touchy/finicky
> connection.
>
> I removed my tuner from my hub and removed the hub from my
> motherboard's USB and put my tuner in directly.
> It STILL produced the error, but after I put everything back and
> played around a little, the errors stopped.
>
> Just to be sure, I also rebooted and it's still fine. No xhci errors at all.
> The only thing I've done recently (within the past few days) was play
> with my scanner which is also on that hub and maybe brushed my tuner
> cable or something.
