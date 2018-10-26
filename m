Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC35EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545A62082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiHqVOvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545A62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeJZQ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:26:31 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43349 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:26:31 -0400
Received: by mail-vk1-f193.google.com with SMTP id y20so53665vkb.10;
        Fri, 26 Oct 2018 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifUczU4je9oCDszSdIMUeOP/LoKljHatRCRPELagqZE=;
        b=KiHqVOvmg6olCWZ4x+6hmsXiVPhuG0U70mFVj9fE8QGNH+91qAAwrPxXOmk4hSYaKf
         AtIQE1kmtvhAUzPzACpZclUfi71jdz7BulfxvhOc5VXWq57o2iqKC939lVxuXtsF7NJJ
         2nZqsdp6GfHvGhQzBhsSqbIGfEObnvof0zqdhOaX1dAYE4FSqIgvjb5dMpJzaV1Ht7p1
         IPuI9zOWjLPNFI4EUcUSAKECichYEljBD15lxiEkfNbB7z8ioSFhq3pDG9/1kv3zAPou
         nQbLOvOxzFkZRl1Y/Pu2HscVfDTydWaQMvBoncGzZ1E1RLMtpNpLDQSEBRcp+vSi+Jwc
         rPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifUczU4je9oCDszSdIMUeOP/LoKljHatRCRPELagqZE=;
        b=baePKwwp76YDOvzw2FR1IACk9gnFh5s3Ths08e4uL8zJJ42+c1CaRNvtvcj02xPPO7
         OAF7CHvxeNJRGqgfgOieWErsSggfTG4riMGz9Atb7rCEuOj3GAns4g0xl2II8TRsS8Eo
         7wX/R3afihHUjWhYUKx+iUmtNSE7JFznQSV5qvMIcuMm6vnz0xboq1sc77vAfyR7clPM
         9s6PGBWhJjkeK61Rpn2Htg7OV9LAVkBJNTtIM1luIkD3L7u7XSlQmjDgJombYO3IA92W
         442i3kZ3K32Bmn0ExmBONUQLy8PnQAi38EgJZiemO+k/QzLlTCDBM9+8hW36QuhxJiH2
         S22g==
X-Gm-Message-State: AGRZ1gKxOuH3/VR5FwYU7+2gY/g9cRpjYroXnufGLnhQWESsuEv3QIHt
        WczYp0S4TblfzYTTWLYD4Jqcie8hXRVzi8vLGA==
X-Google-Smtp-Source: AJdET5d1tYe21XCUdXiRl7QrM7BRNPKj0byQkjnuWwtKlZN7gwW6kADt1zv76/zioHmX4OubjSGPLTf4PgUVCQV1H5M=
X-Received: by 2002:a1f:250a:: with SMTP id l10mr1114984vkl.5.1540540231822;
 Fri, 26 Oct 2018 00:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
 <20181026062743.GA21483@ming.t460p>
In-Reply-To: <20181026062743.GA21483@ming.t460p>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 26 Oct 2018 08:50:20 +0100
Message-ID: <CALjTZvaAc1HBXWHuhaCMsWwJLZEvPy_gvX2U2Lzcj6iVVktWNQ@mail.gmail.com>
Subject: Re: Bug: swap discard issue with zram caused by "block: don't deal
 with discard limit in blkdev_issue_discard()"
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 at 07:27, Ming Lei <ming.lei@redhat.com> wrote:
>
> The patch titled with 'block: make sure discard bio is aligned with logical block size'
> in the list may fix this issue, please test and see if it works.
>
> Thanks,
> Ming

Hi, Ming,

Thanks for the quick reply. Unfortunately, it doesn't seem to apply
cleanly to 4.19. To which tree/tag/commit should I apply the series?

Thanks,

Rui
