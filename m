Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BEEECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99A82083C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsMp7tEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99A82083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJVKGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 06:06:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39976 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeJVKGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 06:06:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id z9-v6so4318312qto.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 18:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RADwbBNRTe5nQdyxUbMQyAOYg5sXdVTP711OddUnSq8=;
        b=IsMp7tElk1DbLJ8hYhbEfDI4suxn74KNdLHISYHOj9Y3h198HDFdvcNIHh0T8tGMv3
         vRx+4ZFAG50QhNm0wsVz73cmW29JCxYbNm0u5chZGIsWqFR8bKVi+6xfNCOKk3Liee2h
         qubpzjSY5k9R1Dt45iscjplUHEEdttekaGBQMTPUFz36ofTAliI1ipy5Nj1guFkHvZK1
         oeL6Dk+SzyoNCcBk6ecLBT5FGtLGQ/KWauCi/vBHOvQx/PWqAIK5zIDkaMPb6mcoOz04
         UIONaxBybiIT4Fvg53kY5eLx3+Oy8qjWg41o9O0hnxmCJhlo3ZfJD2eg1er8df0R/YIO
         UdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RADwbBNRTe5nQdyxUbMQyAOYg5sXdVTP711OddUnSq8=;
        b=s+3OQ/JOMzpEaxsDKB2RU3AFbSBMKRQEuJOKm0eckZ7VuYpFqKPXOsFAdI2glyy8vL
         v8TVqyB/ZoNQeFVCwMiK5TkGskWRQ0a4oFrZmeSLyQF+Hjv6aKKWZzR2qtBU2L2dhhnm
         iyQkz4Tux/PXkBEPHMdOKthW3QwrU5PGOI1898jYTYbCB/MVF0WUgsR6/droXJq2/R3V
         HfvVY3l3HTtPLjMngBrs0spIolWYDfkxAieA7fRiHgsayDpmE58rql2XiM2SdBvPiS7U
         Mfc8Mu5L2nwJjB588ZNR1urKxQe7MtMUU4shTr7ttSgrkzcaTNuisOfdcWNrf7h4vCNH
         bhhw==
X-Gm-Message-State: ABuFfohW3nstXE0al0PsBh7Pc6rPRJA96C083ZPBmIz/B6I31d4PALHu
        tVIaw62E9ZrBKiUDt8p826xuI47SmI5dcSD5M5Q=
X-Google-Smtp-Source: ACcGV60WIW7XPNKF2b/q8ycSoapXhtTBzUTK1MKHczPwkMz2TTiOGQo6b0WEvg9nelec55PL2g2EzdwjjltMfQbRs7Q=
X-Received: by 2002:a0c:fc04:: with SMTP id z4mr43934952qvo.157.1540173028125;
 Sun, 21 Oct 2018 18:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMkWEXP4Mm5x9rdrKn9xRNVm7vxqoL62ftxb+UcJFAiJ+U9X3A@mail.gmail.com>
 <CAPM=9txnZaeUgYEauJF5eSidEsGS9DmT6M4O-PcTPtCFXL8adA@mail.gmail.com> <CAMkWEXN3v41hg70vjzygbJPK9==xZSBdeDPkSQNs85Sm4HFucQ@mail.gmail.com>
In-Reply-To: <CAMkWEXN3v41hg70vjzygbJPK9==xZSBdeDPkSQNs85Sm4HFucQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 22 Oct 2018 11:50:16 +1000
Message-ID: <CAPM=9txOFw60VZZQYJnOg+BCXLoN8cUd+Ri_B8Bt4Lg0sYBH4A@mail.gmail.com>
Subject: Re:
To:     mtirado418@gmail.com
Cc:     Dave Airlie <Airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        zhoucm1 <David1.zhou@amd.com>, Hongbo.He@amd.com,
        Sean Paul <seanpaul@chromium.org>,
        Gustavo Padovan <Gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 at 10:49, Michael Tirado <mtirado418@gmail.com> wrote:
>
> On Mon, Oct 22, 2018 at 12:26 AM Dave Airlie <airlied@gmail.com> wrote:
> >
> > This shouldn't be necessary, did someone misbackport the mmap changes without:
> >
> > drm: set FMODE_UNSIGNED_OFFSET for drm files
> >
> > Dave.
>
> The latest kernel I have had to patch was a 4.18-rc6.  I'll try with a
> newer 4.19 and let you know if it decides to work.  If not I'll
> prepare a test case for demonstration on qemu-system-i386.

If you have custom userspace software, make sure it's using
AC_SYS_LARGEFILE or whatever the equivalant is in your build system.

64-bit file offsets are important.

Dave.
