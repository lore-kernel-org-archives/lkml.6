Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D87C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997E4206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyn4B5wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997E4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbeGZX15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:27:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41504 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730989AbeGZX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:27:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so5719506oiw.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqUi42plOepQqSrKhfOGAXCIxshMD0X8M0Raq4ZDWTs=;
        b=lyn4B5wzd7VWVfTs5xBxb30B9l7dze/7b7yj1o2O0kcc18zYPg5LBQIMvOCpkRVBRl
         5kBGZsXqRj7+EyEDviKww6RVwaFLWonYXbWqOzGM/qVZyQwotKVLvjaqBANMuB3R7tpT
         C8/75HYsLuBgJD2XVGDqFaiVSZgQ4p32q8D6oiHNpV90u3gZGs12CnW0Yht2j2kI6cdm
         L5WmqvYSdOpRKmC/m5UjOBFMOve1AUorCK2QhNFLD5ddVou8Nzp8fdmv38d8qmNAZvz6
         vPbAwDEd8QNze+2xa+CfHWXInUQ0p8pONaJt5BzbtIU1aGFxtVY7n/WIjPGTb97CV/b4
         kmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqUi42plOepQqSrKhfOGAXCIxshMD0X8M0Raq4ZDWTs=;
        b=aNHbwuDnnV3o0kJtzc8YNPHVtplENEySNzh2QesYbBHGwWMIos5kEHqYfTv7Dc2LVx
         sqYyJo0VSFyYYf6/NZ3n+LjWFEqUqgXggJD6zpOFJ/H5fJsoKaUV6JaWC/UjJ57Xp8l5
         qmhRy+eLs73G7/tDJRci5+S4o4Tx+kkf2MocqPXdkIsWENco5aMX28re0IpoMW0YXLbw
         xyU1MFmFU4Jx/LFqz8NiAM9tZY5i45FKn7EudvmW+svjja7/PVyxysI/CrHuqTNvS4+U
         mioetBYU+QyacifdZ/vzWc78wG16Kr0lEpBWON4pYW6AOJsGm6D9pHKA8ETEfQdRBICr
         M68w==
X-Gm-Message-State: AOUpUlGO/N9esXo/UZA5oT7+GCbRd1xMJqysjvVSwSievlu19fLUcZkn
        hKoavh/LHvWWqKpHh9xIXT9wz4SA/hthf3eoAH4=
X-Google-Smtp-Source: AAOMgpcp4+0EIDhVyiivUkh+wy7q30LaRDvKyw3604/rwyPlEgqXrHyIwNXqts5R6SopPoTZzq7TzdAsKbXrS+0K3nY=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr3738254oih.311.1532642949453;
 Thu, 26 Jul 2018 15:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1532610629.git.tsotsos@gmail.com> <4465097e58f6dbc0e19b9e945ac0b8eee5d98726.1532610629.git.tsotsos@gmail.com>
 <3b90173dc3a8ce12ef7f4896f05673140ac3b4d7.camel@perches.com>
In-Reply-To: <3b90173dc3a8ce12ef7f4896f05673140ac3b4d7.camel@perches.com>
From:   Georgios Tsotsos <tsotsos@gmail.com>
Date:   Fri, 27 Jul 2018 01:08:58 +0300
Message-ID: <CADERADOaeF3zee3OUj+qpgMGX+FCvfqSEj=7rGuY4LErPORpzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Staging: octeon-usb: Breaks down cvmx_usb_poll_channel().
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <jhogan@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed i should probably either use pointer
or pass the values, i will do some more testing
and update this.
Thanks

On Thu, 26 Jul 2018 at 19:31, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2018-07-26 at 18:41 +0300, Georgios Tsotsos wrote:
> > In order to make this function more clear a new function created that controls
> > channels halt on no DMA mode.
> []
> > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> []
> > @@ -2585,6 +2585,52 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
> >       }
> >  }
> >
> > +/**
> > + * Handles channels halt in non DMA mode
> > + * @usbc_hcchar: Host Channel-n Characteristics Register (HCCHAR)
> > + * @usbc_hcint:  Host Channel-n Interrupt Register
> > + * @usb:         USB device
> > + * @channel:     Channel to poll
> > + *
> > + * In non DMA mode the channels don't halt themselves. We need
> > + * to manually disable channels that are left running
> > + *
> > + * Returns: -1 on halt
> > + */
> > +static int cvmx_usb_dma_halt(union cvmx_usbcx_hccharx usbc_hcchar,
> > +                          union cvmx_usbcx_hcintx usbc_hcint,
>
> It looks very suspect to pass unions on the stack.
>
> Are you sure these aren't used after this function
> is called?
>
> Likely these should be pointers to unions.
>


-- 
Best regards!
Georgios Tsotsos
Greece-Evia-Chalkida
tsotsos@linux.com
skype: tsotsos
------------------------------------
Georgios Tsotsos
*Greece - Evia - Chalkida*
tsotsos[at]linux.com
skype: tsotsos
