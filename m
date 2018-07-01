Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B388FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5826121A78
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1D8X9FB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5826121A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeGAJOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:14:46 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42034 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeGAJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:14:42 -0400
Received: by mail-vk0-f66.google.com with SMTP id s187-v6so7623448vke.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nlQU1K3/0xVSOVyZDh3cWkL1gRHgkbrcW5D0QZ1UYAw=;
        b=u1D8X9FBlx5SoFrIDc5EDKQWfSmRUfIbfbbpqutPB955rOihheqKSTwQL9R/IGfBuA
         6q3hwfM42R/KcTqrTfSNXaHGv3D7LR1mLH19U9bc7+BIpiltszEEc99fmZOOEUnOuTQ0
         MUmTlSapr2dGB9Lj949kzM9BwS8Zhjm6VlAp+s0x5y9YyNurSa7t2MMDl+wDHkvkQ9yr
         S6GmAV6JhoOTmU1X6GyQOybdmEn33uuzF3x2wuco/0ouOweQXVLmSTcMnr4kw8X68rG4
         SBlGXrAqveKNIpMmAsJqzUU4zDqyklQnVHGFUin0LKPMSDSKVIJvbisEM8cWs+ztDJLp
         9Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nlQU1K3/0xVSOVyZDh3cWkL1gRHgkbrcW5D0QZ1UYAw=;
        b=NkDh0nkBjwTNS0vkPRI4ltKML2HRITpTSH7dp6v1P3umI09RYidO1AEb3C2D1+RgnR
         mBf8puxT7aQVnbSRTuFEUfgQ9iudMHMl3V5PZHWV7DCsGrA2g9CXt541hvd2QmYj/2b+
         0EmWiLhEoT6cHLuoVdaF+IPmaFYlrhJWqRq71xOp/a0k08KbOMp2GfsQkzEvBJnARUYK
         VyrhqI3MzctIMD9Nzd3YG2BZB/H+mzn/S6HH8j2L8GAbJnlqCqyTnekzklb07ECxDRzX
         NVJqTgcbwZuLRpBZ20maOBuUYN93cCwW/CthKdjUxzkYaYxlDWigS71eyCNHSCgdRMS1
         x/2g==
X-Gm-Message-State: APt69E3np6F1zw9blBkjaTEq7A4zU0ModsaZfB/pLBzIal7ViWKUAAW4
        3Xmvy7g5EEaRTcnHF9DeT9te9ku6EU1A9q0/FTA=
X-Google-Smtp-Source: AAOMgpejS87WRLWoe1tzm2NUaCtBgPfhVC5Qb9CixbXcyrik0Xux+wRPTAB/55j7M2Lo/hTICqLtxMcbqnISbcfn2OA=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr13394914vkd.161.1530436482069;
 Sun, 01 Jul 2018 02:14:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 02:14:41 -0700 (PDT)
In-Reply-To: <20180630145941.13118-1-straube.linux@gmail.com>
References: <20180630145941.13118-1-straube.linux@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Jul 2018 12:14:41 +0300
Message-ID: <CAHp75VcEXHbOAHgf5jTaP9ZP99wGFBVhXkuohsVd-cD6QQWBkQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8188eu: remove rtw_ioctl_rtl.h
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 5:59 PM, Michael Straube
<straube.linux@gmail.com> wrote:
> The header rtw_ioctl_rtl.h is not used anywhere.
> Running 'grep -r rtw_ioctl_rtl *' from kernel root
> directory returns nothing, remove the file.

Just a side note, using `git grep` is much more efficient against
kernel source tree.
Something like `git grep -n rtw_ioctl_rtl.h` in this case.

-- 
With Best Regards,
Andy Shevchenko
