Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646CC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B62820881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c74hdLh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B62820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeG2Wty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:49:54 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43830 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2Wtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:49:53 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so17781840oib.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5y1Y4ox+WJXanaUexhNXg5L0+KMoNXtAyDsV9Zv5y0=;
        b=c74hdLh4p1hxG//0yBdI/S+A2izSNSG72zu+lGnj816OiDw+Ch+QFFtxjT4eKYy3Fk
         GqKfhhRprn6n8fEY7RULjEKrLbcPTJaa4Rm7Er7HQIQG7xZDJop5Ne+FoOKoc/ToK4sV
         H58WLZyu7CIbQDY0eGHw4j0w9HgfHjO+TX69KQXJZjIfOTRNzmW9aWfkwKw3LefAnHzF
         x45x/aQMe3ycFCxEc+0u/6jXzCzDhUeZbjDsjT4F+J59VimywxyDHveq3Dyv1Q8JBJ2s
         exF5ahLDhzVTN6mkrY4mCH054bmvF9lVQ/OA2Oi+RNdhbEQINyKRwoZ7hXxlUktxC+Lo
         W43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5y1Y4ox+WJXanaUexhNXg5L0+KMoNXtAyDsV9Zv5y0=;
        b=DbeGMeL/eSL780pQJO+K4eSLERbqUoDVOWN1KOWKmdwCJNmx2nRZA9lvoZ5qkGGBho
         j37TMxw2QVSUsJTLnSM41/bMEKV66DJjJXHzCyXQHPyHUD7DsTAauDNSxGKNPYxYIEyo
         c3j7c2sy+NEM96bhUF2KQfFbzXUdAs/jqpCrk3A6+FbZO8a/VhtEorVYjVdDsp8FXSig
         Fp59UHl+TX6aplZL7GkalFwFopdOJ4dtNa3H9Wy1RXn/RNks0aDI2jaz3vVk0XoSv/6S
         eV7phIblLHNFAE07F3/iXgBK5RkI2SrP2qri82Ic5gjHuomAOdJ5XHLS9XmbM52VitRr
         rLwA==
X-Gm-Message-State: AOUpUlEAkre2i+fFhuji0vHsM+LT5EUW+T6fT5MBkjnuFDciWcFis+qP
        cvb6WmeZti4ijVrfrnUOmRo6GTRdskDcuYBM1HJ6wg==
X-Google-Smtp-Source: AAOMgpcPUGIDIqWtfG0q94HBiGfLRDaLvRw71bLMiTJ6KVWfWJXJ6jH5of9qPC+yWr/p9uMnzgZH+edFxSyxhjyyqx0=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr14067777oia.154.1532899080299;
 Sun, 29 Jul 2018 14:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180729124320.GA27275@kroah.com> <20180729143338.2251-1-tsotsos@gmail.com>
 <20180729202108.GB14390@darkstar.musicnaut.iki.fi>
In-Reply-To: <20180729202108.GB14390@darkstar.musicnaut.iki.fi>
From:   Georgios Tsotsos <tsotsos@gmail.com>
Date:   Mon, 30 Jul 2018 00:17:49 +0300
Message-ID: <CADERADOYj2Hjugn=qs5sfnTZxaXcvLCwO9wa45YRmsguFUwKEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] Staging: octeon-usb: Using defined error codes and
 applying coding style
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Indeed there was a mix-up with patches i will send correction asap.
On Sun, 29 Jul 2018 at 23:21, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Sun, Jul 29, 2018 at 05:33:38PM +0300, Georgios Tsotsos wrote:
> > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> > index 3f44ac260eff..edf87d1b3609 100644
> > --- a/drivers/staging/octeon-usb/octeon-hcd.c
> > +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> > @@ -2590,6 +2590,7 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
> >               }
> >       } else {
> >               pipe->next_tx_frame += pipe->interval;
> > +
> >               cvmx_usb_complete(usb, pipe, transaction, CVMX_USB_STATUS_OK);
>
> Unrelated whitespace change...
>
> >       }
> >  }
> > @@ -2624,16 +2625,16 @@ static int cvmx_usb_dma_halt(u32 hcchar_chena, u32 hcint_xfercompl,
> >               cvmx_usb_write_csr32(usb,
> >                                    CVMX_USBCX_HCCHARX(channel, usb->index),
> >                                    usbc_hcchar.u32);
> > -             return -1;
> > +             return -EINVAL;
> >       } else if (hcint_xfercompl) {
> >               /*
> >                * Successful IN/OUT with transfer complete.
> >                * Channel halt isn't needed.
> >                */
> >       } else {
> > -             dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
> > +             dev_    err(dev, "USB%d: Channel %d interrupt without halt\n",
> >                       usb->index, channel);
>
> ...also here. Does this even compile?
>
> > -             return -1;
> > +             return -EINVAL;
> >       }
> >
> >       return 0;
> > --
> > 2.16.4
>
> A.



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
