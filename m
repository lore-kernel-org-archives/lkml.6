Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3AC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA77F20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXvnIepx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA77F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeG1RPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 13:15:09 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32801 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbeG1RPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 13:15:09 -0400
Received: by mail-oi0-f68.google.com with SMTP id l10-v6so14286737oii.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkqzGe9C4F2Mv3QJp1rDwXsxs5/LiOIhTks1CeQ5dEU=;
        b=kXvnIepxCRDxDzatUbkC9lnhb+lGxitI0jsGSpfVnSnTDDEMi9hIA0AWp12NYPCrZ8
         xcEIB+hol8dzfJJGoyTGjLex0s/1lnZxds4IJyHj8ebANcE1hHvthrhLFGV7hpXMnbYm
         3HAXZmE075OVGg+1PHbkOZVK3C5Ou94sGRfauLUjWElKYbJBauLsm92my1TEIGWqubsz
         kSoCkQN67BSQ02Yj4El6RUYmDMDlwRnmYWdUryeVaGAaaCjPJPPUEK1aaWoxRMV4MtFn
         d71VM4LpolE7F8sETRCUYsFKmgphGdvd082O73M9+C9RqQSDj+yPYWhiiiWhQS47fOFS
         crgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkqzGe9C4F2Mv3QJp1rDwXsxs5/LiOIhTks1CeQ5dEU=;
        b=Dd9rCmJicSFR+uUmbdeixK0l3d8XfEzrWpU/kjjRkg3fi9aEygu3co/BGNy6haAxC+
         gcut/F39KGszKRL9w6KEdVXKDLryYMPSoiUbxpxpAEqAldQKb69rGAI7nJfFzNVJ4yXJ
         jjsQ5gXTwnEX9wGFbBAuVBZZz+Q5NrLBBPGoIkaHlsu/eUHGdRACjHVgvGPUmhQL6z1i
         7pYaP6zU07Ujpgy+wFCIP3kd7uImDUggNJoMh+4WwuePDQR065k/qZ247//W7WGA+8t3
         coZC9mfeImTZLCGsNqSDGQHi14KYaMKgIwmJELSRepnBC7di5TYHAuZq6lFtrJjzee0I
         RmLQ==
X-Gm-Message-State: AOUpUlEdQIbDE1raVdxX6hAvh3N8WPcrr2wdzFbHB3OVY9cJWs7KEzBk
        KK+AJGAUNKcnkzJbKaCWYZq4/io8C/qI/T8pv2YllELxjmc=
X-Google-Smtp-Source: AAOMgpd06ZKS0bTKsu1rSbFflomMV/YK7x9i/8z/loAfvB41KsYsK3BPPSprMOQYtHbIyNoHcdwgfpCfUS7XHhVIZIA=
X-Received: by 2002:aca:1a0b:: with SMTP id a11-v6mr10327293oia.316.1532792892924;
 Sat, 28 Jul 2018 08:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1532610629.git.tsotsos@gmail.com> <37553f45bfb34de4b0af476286b1b782ea834963.1532610629.git.tsotsos@gmail.com>
 <20180727151527.GA2209@kroah.com>
In-Reply-To: <20180727151527.GA2209@kroah.com>
From:   Georgios Tsotsos <tsotsos@gmail.com>
Date:   Sat, 28 Jul 2018 18:48:01 +0300
Message-ID: <CADERADM8=GDf5qHmrcoDDTL48DmuDOJLRJezNrpwQcjO1Rhjuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Staging: octeon-usb: Change coding style of
 CVMX_WAIT_FOR_FIELD32 marco.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will change it into function, as i checked so far i will need to
change USB_SET_FIELD32 for the same reason.

On Fri, 27 Jul 2018 at 18:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 26, 2018 at 06:41:52PM +0300, Georgios Tsotsos wrote:
> > Fixing coding style for CVMX_WAIT_FOR_FIELD32 was confusing. Also
> > encapsulates into parentheses timeout_usec.
> >
> > Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> > ---
> >  drivers/staging/octeon-usb/octeon-hcd.c | 44 +++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> > index cff5e790b196..c8e0ebf1434f 100644
> > --- a/drivers/staging/octeon-usb/octeon-hcd.c
> > +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> > @@ -378,27 +378,29 @@ struct octeon_hcd {
> >  };
> >
> >  /* This macro spins on a register waiting for it to reach a condition. */
> > -#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)       \
> > -     ({int result;                                                       \
> > -     do {                                                                \
> > -             u64 done = cvmx_get_cycle() + (u64)timeout_usec *           \
> > -                        octeon_get_clock_rate() / 1000000;               \
> > -             union _union c;                                             \
> > -                                                                         \
> > -             while (1) {                                                 \
> > -                     c.u32 = cvmx_usb_read_csr32(usb, address);          \
> > -                                                                         \
> > -                     if (cond) {                                         \
> > -                             result = 0;                                 \
> > -                             break;                                      \
> > -                     } else if (cvmx_get_cycle() > done) {               \
> > -                             result = -1;                                \
> > -                             break;                                      \
> > -                     } else                                              \
> > -                             __delay(100);                               \
> > -             }                                                           \
> > -     } while (0);                                                        \
> > -     result; })
> > +#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)   \
> > +({                                                                   \
> > +     int result;                                                     \
> > +     do {                                                            \
> > +             u64 done = cvmx_get_cycle() + (u64)(timeout_usec) *     \
> > +                        octeon_get_clock_rate() / 1000000;           \
> > +             union _union c;                                         \
> > +                                                                     \
> > +             while (1) {                                             \
> > +                     c.u32 = cvmx_usb_read_csr32(usb, address);      \
> > +                                                                     \
> > +                     if (cond) {                                     \
> > +                             result = 0;                             \
> > +                             break;                                  \
> > +                     } else if (cvmx_get_cycle() > done) {           \
> > +                             result = -1;                            \
> > +                             break;                                  \
> > +                     } else                                          \
> > +                             __delay(100);                           \
> > +             }                                                       \
> > +     } while (0);                                                    \
> > +     result;                                                         \
> > +})
>
> It's still a mess, why not just make this a function call instead?
>
> thanks,
>
> greg k-h



-- 
Best regards!
Georgios Tsotsos
Greece-Evia-Chalkida
------------------------------------
Georgios Tsotsos
*Greece - Evia - Chalkida*
