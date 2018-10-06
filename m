Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF223C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC4721479
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKrPOhOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC4721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeJFIX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:23:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34398 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJFIX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 04:23:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id g12-v6so5448420pgs.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yybb4j5816FN7XHimgxCt4d+wVaZjUBqR9Cwips7ekU=;
        b=kKrPOhOjQhKUDM5zFkadXJjOR/Iao+k0ikQ9gZ5Pw/L3Xup6scTrSy3MOfLrhCvjRf
         CQaKxcwE/Exw4vt2loWoLfABZxSees4yqzRVsgTlB5bV4bZz657h8FjFdLFYkJC+QieZ
         8V/2h9Q4CWrdlLzJDodktOZFipidMvwZKHCHcqZ6OByWqTS2OFNkijh9hvVk3lDh/KPA
         EiHnHMXXj7DCZshseyMPi7HV2ErRW1229YdTf4kXnBkk3ThQQqP3kig2yAV7vb1HmEBF
         /GfSTyRIJq2jASYU+zIOqINTum1dacPK2WDmm66h9VaF2DwAyvSP2ruvJRD0RkZM0Nhs
         GwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yybb4j5816FN7XHimgxCt4d+wVaZjUBqR9Cwips7ekU=;
        b=CQAVgpXf2IcIrauLr0QgPURQEenJ4KIllMPu13SjLuVH1aBZK4CBo7mLVwsi9zrVRc
         H4oDSUMsfxVxDZMgSJ9i6C04rAKt9IXbNhQqqnOPp2buAyeEhQALduzEFHiFZRB5BGuk
         vgHakKSGNNTrkHM1v/dySw2jneLvVXvnq65Fx9xTLQxPilSy24/OxSPc+PUzJ5lAsBeY
         trLmn/QtzQgkKFHBpMFALqEKPatfcK2Ubt7Z8NpOOyo12xRO6BeVbAQK1r7ehymkhcU6
         vjd5M5PsZ/1ssTdvCMn8ID8nrjfF7uqJxPeegLxQjJTu9lEtg7/CynyrAF6zM7WvRs7r
         MjZg==
X-Gm-Message-State: ABuFfojB2EqkbK/LN9yxZ1kxs2c2Ip1fT7niPpNNHU+QIWS5R9IS4Wda
        ZlrjXzYl2+iS1P6CL8uzOjIR7dZzmXSgVwrUbr4=
X-Google-Smtp-Source: ACcGV60+GiHuCFPHSH66PFxOe4uFDSW+loIokORIWvwiyjaVKGCexdSN/suV3a8ifr6uAvVSRWvO2k68DWoaDDZkH6Q=
X-Received: by 2002:a63:e256:: with SMTP id y22-v6mr12198820pgj.439.1538788926695;
 Fri, 05 Oct 2018 18:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181005225859.GA19554@hax0rtop> <c53084c6be538d127db8b88dec4babc7eb7c6a9f.camel@perches.com>
In-Reply-To: <c53084c6be538d127db8b88dec4babc7eb7c6a9f.camel@perches.com>
From:   Scott Tracy <scott.a.tracy@gmail.com>
Date:   Fri, 5 Oct 2018 19:21:55 -0600
Message-ID: <CAANxuDfv3CSssyaASbbTqXEtde-GkpJojTMVj=octOnTvZvDOw@mail.gmail.com>
Subject: Re: [PATCH] staging/rtlwifi: Fixing formatting warnings from checkpatch.pl.
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 6:37 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2018-10-05 at 16:58 -0600, Scott Tracy wrote:
> > Fixing formatting warnings in rtlwifi found by checkpatch.pl
> > Changes include breaking up functions calls into multi line calls.
> > No functional/logical changes.
>
> I believe the code is better before most of these changes.
>
> There are various tradeoffs do source code formatting.
>
> Here you are changing some alignment to open parentheses
> and converting to < 80 columns.
>
>

Joe,
Thanks for the criticism. Fair comments all. I was just working
through the KernelNewbies.org tutorial looking for low value changes
to get my feet wet and assumed that a "check" was better than a
"warning". A also didn't feel confident enough to refactor the code to
get under the 80 character limit. Maybe I will spend a little more
time refactoring something and then submitting that. Thanks again,

Scott Tracy
