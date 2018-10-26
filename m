Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE7AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C72820868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcsc8OFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C72820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJZW0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:26:16 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41591 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbeJZW0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:26:16 -0400
Received: by mail-yw1-f68.google.com with SMTP id c126-v6so464757ywd.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBPfLHMSiNdXv6sRSeUqaPGlFLVQ0LCmhjxz7Xf5xP4=;
        b=jcsc8OFJIiO950RGvJ/DWAWZpaFfbK5DcvjFCEd/IFm7rT1b8dGB8Hs/xFdle6N4eS
         fu5ShJ1BGeNgLYrCBOKpW2w7b7HzSll6nrZudl0sGb4/Fo5ohW7X102Y6X632okwSH72
         JIxEGsaWYnsmLshuVnNJHW02VX5aOrDZY0GXJT5c6wzSO+9yhRA9bjvatAuvT/z54RWh
         DI80kbsm2sMv8xKpniMEcF5dTY/rVfe25e9Thri5fSThOqTeHynFhum0Gi1gnGM1zY2t
         aOAIzsjKCtZQL67wbcr/TKkv+n2JLhJUP4CvfJwDUE5JwfplwMkZw+asdMIIRcWPA7KQ
         LoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBPfLHMSiNdXv6sRSeUqaPGlFLVQ0LCmhjxz7Xf5xP4=;
        b=BQr1DVtn36Z8nd1gnf0qtckTap5UKYMTjqjXTI+b1pnd0f+SisdA/q1WmQrWqEMyoP
         RJ0Ji23Z/2zfwUmlAt3hZIbqxqsVKkzGiRQQbKbNtgPDJYccvhAh0xkRWZ1/80gy8SWD
         //zP5HEiLtVD8JZGaAZuJ77zUdRZGTRzdP9EAbLDPAkrSNSu8OAVspJg8YlSlmTymDY4
         gBmBkSw/ctJikPtUjjWCQyaoo59LlgPNURdZ14TjuYGRMU+id8kSXA31CNMzkUWCH9pN
         IO2LDCamv+axSOYIlRIq4cnxfMDBrYAwToxT3Swz7wDa9scJj+/oU5hq++XLwin2UEs3
         RVSg==
X-Gm-Message-State: AGRZ1gJU57kesRcHft1bhgSCI8YCXoGUMBAZLRKhBqeViEpaO3HOdwdf
        TXNARCdghtBQIo2eblei37MONMVIjVHPQ7zs5+0=
X-Google-Smtp-Source: AJdET5dBn3ALNyzkH2UsRnbLmM3Xe6wHIOparWOIHxhusdW6sfIOTjten47MZ6kRU5vOnOsDxUIN1N8ngeAjXMkBWB0=
X-Received: by 2002:a81:a286:: with SMTP id z128-v6mr3593125ywg.480.1540561746652;
 Fri, 26 Oct 2018 06:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181026015804.4120-1-diego.viola@gmail.com> <6749376c-930a-3392-6a02-386431a9a432@redhat.com>
In-Reply-To: <6749376c-930a-3392-6a02-386431a9a432@redhat.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Fri, 26 Oct 2018 10:48:55 -0300
Message-ID: <CA+ToGPH4+=6foUoBOiay9C97eBaUG=kn4RezrH7Wrr_CaL-=Tw@mail.gmail.com>
Subject: Re: [PATCH v2] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
To:     hdegoede@redhat.com
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Fri, Oct 26, 2018 at 8:59 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 26-10-18 03:58, Diego Viola wrote:
> > med_power_with_dipm causes my T450 to freeze with a SAMSUNG
> > MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
> >
> > Switching the LPM to max_performance fixes this issue.
> >
> > Signed-off-by: Diego Viola <diego.viola@gmail.com>
>
> Thank you for the patch, have you updated the firmware and
> confirmed that this happens with the latest firmware version too ?

No, I haven't tired the latest one yet.

The last time I saw, Samsung/Lenovo doesn't make it very easy for
Linux users, and I don't have a Windows installation to perform the
upgrade.

>
> If not please send a new version limiting the blacklist to your
> firmware version.

OK. Sent.

>
> Regards,
>
> Hans
>
>
>
>
> > ---
> >   drivers/ata/libata-core.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index a9dd4ea7467d..a7f5202a4815 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4553,6 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
> >       /* These specific Samsung models/firmware-revs do not handle LPM well */
> >       { "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
> >       { "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
> > +     { "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
> >
> >       /* devices that don't properly handle queued TRIM commands */
> >       { "Micron_M500IT_*",            "MU01", ATA_HORKAGE_NO_NCQ_TRIM |
> >

Regards,
Diego
