Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17796C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6B920868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODWiHn8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6B920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJZXKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:10:40 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45896 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeJZXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:10:40 -0400
Received: by mail-yw1-f66.google.com with SMTP id i185-v6so523131ywa.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dngp4pO7lHWUw7N7MMRMUIDFNF8PFTwuVDCWLWnHfYA=;
        b=ODWiHn8tjautaGai/Rt5hcEmfh8kcUWOO5lgfVnpsHyOdL68dzUE39QSZs/YoPcuS5
         jEQVl4hpJHj2PDmhMyGdzM6S5zrU6g5XN65NXp+jMw9D+qUrt2w6r1eMFOzGr7IhHhgG
         igf/3fo5FsJTBF8UvvN1xEuhUDjEMcWN7OrW1zQocr8M05YY/U21FqAfOFhcfyFr32qD
         p/7QFjOjSrull9yDXEAKOiXoyqDk1akATroDgAsio2D4dqACkxazA5GskaEXXqoyAInu
         Gne38NBN6tb4FSiAstwYWpgJ5G46bK63ubRpnPneerMmOYMXyxu5VQE7LSZoPCo+W9Rn
         SjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dngp4pO7lHWUw7N7MMRMUIDFNF8PFTwuVDCWLWnHfYA=;
        b=T890YDTp1rj4z3GvcCCQk4NSDnZvF5a4T+Tz3TQxF6QJOpuj+VKLme5yRHmxsCakX0
         XVv+srpDXN469SGHuTG8KWl9YlvbHA18EiOk1JDSwM9xO+q2RQz1u+RGHw4F/1lmaaLH
         OBQnLpWub7m3X6tx6/xG1KnLzaF+X2HnBS+WXG6QQc+mKA3TEBMOnW2F2lzFhyQSq65P
         rVqSmNAA5soM7HSZr65zrH/UudtoInyFbD+Wf7Zp5pmgESTGwx4MCd+R0FmpLNuPnQGm
         BGjLGK9hNDReUrnGMB8+nV1F6nCGzL7rwRh3HCGV940f7/8IeThTgpJrL2TRRhTlQ0F3
         Nm7g==
X-Gm-Message-State: AGRZ1gJolDGbgSgnHhaCEpwNJIe1vyv2fobzRRhGCbIW5Sxys14x9m8N
        JoHwaO66S87VJ74aN3fiwZKO4F8m+WotElsfFQU=
X-Google-Smtp-Source: AJdET5fl/1qtiHPbWYy+jDS+GyQ+EtoSkUofzCWJ5mBvFdp9RsXeSfimNI5ls05Yo+EUKKOsZsLybAraEqLQ7ZWkug4=
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr3865603ywd.124.1540564401595;
 Fri, 26 Oct 2018 07:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181026015804.4120-1-diego.viola@gmail.com> <6749376c-930a-3392-6a02-386431a9a432@redhat.com>
 <CA+ToGPH4+=6foUoBOiay9C97eBaUG=kn4RezrH7Wrr_CaL-=Tw@mail.gmail.com>
In-Reply-To: <CA+ToGPH4+=6foUoBOiay9C97eBaUG=kn4RezrH7Wrr_CaL-=Tw@mail.gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Fri, 26 Oct 2018 11:33:10 -0300
Message-ID: <CA+ToGPGhzDKAHLXBTPWr5am9MXayRqSP32-ukTqJaQecPRGErQ@mail.gmail.com>
Subject: Re: [PATCH v2] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
To:     hdegoede@redhat.com
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:48 AM Diego Viola <diego.viola@gmail.com> wrote:
>
> Hi Hans,
>
> On Fri, Oct 26, 2018 at 8:59 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 26-10-18 03:58, Diego Viola wrote:
> > > med_power_with_dipm causes my T450 to freeze with a SAMSUNG
> > > MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
> > >
> > > Switching the LPM to max_performance fixes this issue.
> > >
> > > Signed-off-by: Diego Viola <diego.viola@gmail.com>
> >
> > Thank you for the patch, have you updated the firmware and
> > confirmed that this happens with the latest firmware version too ?
>
> No, I haven't tired the latest one yet.

s/tired/tried/

>
> The last time I saw, Samsung/Lenovo doesn't make it very easy for
> Linux users, and I don't have a Windows installation to perform the
> upgrade.
>
> >
> > If not please send a new version limiting the blacklist to your
> > firmware version.
>
> OK. Sent.
>
> >
> > Regards,
> >
> > Hans
> >
> >
> >
> >
> > > ---
> > >   drivers/ata/libata-core.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > > index a9dd4ea7467d..a7f5202a4815 100644
> > > --- a/drivers/ata/libata-core.c
> > > +++ b/drivers/ata/libata-core.c
> > > @@ -4553,6 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
> > >       /* These specific Samsung models/firmware-revs do not handle LPM well */
> > >       { "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
> > >       { "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
> > > +     { "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
> > >
> > >       /* devices that don't properly handle queued TRIM commands */
> > >       { "Micron_M500IT_*",            "MU01", ATA_HORKAGE_NO_NCQ_TRIM |
> > >
>
> Regards,
> Diego
