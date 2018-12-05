Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4481C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C15F20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1fM85on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C15F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbeLEQiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:38:08 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:40740 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:38:08 -0500
Received: by mail-lj1-f174.google.com with SMTP id n18-v6so18942257lji.7;
        Wed, 05 Dec 2018 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcRWG8ZW3ymqnQBXciReECb3hZIMGKiN+j9Ob8L8x+Q=;
        b=R1fM85onpXG10KsjnUNEBYDthB6L1GIFoJ8wE35XUkH+1cZCxY7ViR3cMRR4oUHNXS
         N5uFlAjBpcEttIMib4zGwQbMjZ2jGp8vXYx421US8/TjYr6f+gbOcY8taFc7hZwVVXLc
         r5OhTTu0hyB8u4lZG8KKuR4KlmMM5VOB4gzChhPbzWc2i36et+yEJRPP3wwH7VDw4eAG
         gZfCJGS2T0bDpg2mBSNkgAhpOXl6cEKqi5xxcSXVXkHiYEkku14T1XGo5HDE8UB04alS
         TumZZfn/chasIG7BP4xYKV9/vL+z6iZZOH+z23TfBsbF6VPAhPps7ccLGT3q4Nl5r11K
         N+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcRWG8ZW3ymqnQBXciReECb3hZIMGKiN+j9Ob8L8x+Q=;
        b=fWfvuIxnrn8khILiVJmQ3lN5Lhyu51RUO9Yj+URR+5h1LlIIjitOy0uQg0vgxomUaM
         YOAuIONawuHdJSH+rQyyJPhBLgr4bCwTkwODtVjmWZIofIuUPRbFNfxjpqU2/b35bflj
         o8dh/fWdgw7P7qz2d5VXKW6J6sTjNwMUCNHlHKv8Ge7J3Xwk5ZyKrKSflYuiqKeKm+dw
         BvuMMM4xzjCfQBJA8mLyvK7NjmPMeC08ATqyr7A8W/SN8e3HwCUBEgoOIY9qiZ6eIaJ/
         Y+R080ZbpLpVxjHZI8JIO/WnxHHIUFCdJxb7c5iTycWyQvJhK4mqh8SAnXY/yU8MJblH
         uzrg==
X-Gm-Message-State: AA+aEWYuTGnsM/VGV4KeTxWzppP9MK+VVKejz/t4UIF4OQzmNlBQJtYJ
        1b5nQPK6uAnM1wUjUvoKRNiX4OUjraKy7YtwrSJ5VVND
X-Google-Smtp-Source: AFSGD/WzDQmjtWzVsG5CALUyFc048tdY4CIZNhokEk0LAL/lDS7qxtEfrkchGAjd2Bq/rRpTnNUmqT6iVngPcYHs1BM=
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr14361484ljd.140.1544027884867;
 Wed, 05 Dec 2018 08:38:04 -0800 (PST)
MIME-Version: 1.0
References: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com> <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com> <20181128234415.GH16830@zn.tnic>
In-Reply-To: <20181128234415.GH16830@zn.tnic>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Wed, 5 Dec 2018 10:37:52 -0600
Message-ID: <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
Subject: Re: edac driver injection of uncorrected errors & utils
To:     bp@alien8.de
Cc:     york.sun@nxp.com, linux-edac@vger.kernel.org,
        util-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was very helpful. Tracing through the code, it doesn't do a panic
before Linux crashes from multi-bit errors because as York has
indicated, this type of memory controller doesn't limit the number of
errors.

I do have a general question about single bit errors.  The EDAC driver
corrects single bit errors by doing a scrub, is this correct?  The
edac code does not do periodic scrubs, but I see scrubs when a
correctable error is found (edac_mc_scrub_block and edac_atomic_scrub
in edac_mc.c)?

This is more directed toward York for layerscape. I see some edac code
that seem to do periodic scrubs based on intervals or scrub rate, but
that is not needed for the layerscape driver to correct errors because
errors are scrubbed when found by the edac scrub block or is it
because the memory controller itself does the correction/scrubbing
when an error is found?

thx,
Tracy



On Wed, Nov 28, 2018 at 5:44 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Nov 28, 2018 at 04:14:24PM -0600, Tracy Smith wrote:
> > Is there another way of creating an uncorrected error without crashing
> > Linux using the layerscape driver? I would like to see a UE error
> > collected without a Linux crash scenario because I need to validate
> > UEs are being collected.
>
> It depends on whether the hardware is causing the crash on uncorrectable
> error to prevent data corruption or the error handler is calling panic()
> or somesuch. If it is the former, then you need to disable that feature
> - if at all possible (no clue what that platform does).
>
> If it is the latter, you can comment out the panic() for testing
> purposes only and inject then. For an example what x86 does, see
> "tolerant" here:
>
> Documentation/x86/x86_64/machinecheck
>
> HTH.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Confidentiality notice: This e-mail message, including any
attachments, may contain legally privileged and/or confidential
information. If you are not the intended recipient(s), please
immediately notify the sender and delete this e-mail message.
