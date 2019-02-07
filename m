Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5405C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7964F2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="HdafhgbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBGIZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:25:53 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33207 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfBGIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:25:52 -0500
Received: by mail-ua1-f68.google.com with SMTP id t8so3206502uap.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 00:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KKJXec/17dqhQqZhGlHFxMNW2trdhcCphzGyRH7qzEQ=;
        b=HdafhgbZ4WM3HTG0itqg1wEnY6zUcnWBRCx9tmIVvN0J0jOUnn2G614UDXiChkw/QE
         xynvjMQznqsO5tM8sEqs+Aj7yE10EBHzGjiUcnlUQIL92oi3cB0iaNwNHROfLE9da4wF
         jKGou/tTwneqZYidegNJw3fm/4WKbzTSLnfhQNJ8VO5D7/1XSuSm7RTJc9UXWCPwSjSX
         Ov1hXA0Q+cUDEP+LvVrPt7aEg9RBnBoA3mlXCsuFloI0Lq3Jx7WQHqOLbXdiPioq+zF3
         i0wzJMcgZRdv8wewSjYAxqJPmRW3WjyhhOYgdAg15DUsHu2LU4R/4pRUcYexZawEOR/D
         6j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KKJXec/17dqhQqZhGlHFxMNW2trdhcCphzGyRH7qzEQ=;
        b=cpA/6K6kxPLXPbMyDIMM1wL6hIqcJ85Ihod8Tt06N25prKcUnZOxVX2iCZ+EAvGIJC
         zAOOeutLGj+TXJwTAAufHSaW80eyaKSlYGxILB/X9UcJA473MhA04aKCck2dKUXnMghz
         TF5ZzYa2VNRhtsDmsfAWAi2Wrs5G6ltQ8Nn4x7Kl4aT2QNfNsq/gCXa9+LOHuucMYY7/
         dN0HYetYcQnIOSXpRhuBS9fotzrbN17vfKF7/iKFFVnJge15soVgdsPxurWDHH5k74wW
         yR1t4ShwEo0QfJqweQmEdhg5fqjpp53xebOniwgf5rpyxvNc6g4WOhUxB9U2dyLjf4Qc
         D6FA==
X-Gm-Message-State: AHQUAuZmIA7PrN+JwZxOjEoWEGSkcqo5ew/f5StpKWmT5OcQ4CTCerek
        OHEjZns5vV7IcRgsMhMuoxaaRWulGFt7tvn0M0vaCw==
X-Google-Smtp-Source: AHgI3IZ7cKqXrgKQbYesx29ikvEuoy4tjKOx3fbi04mk0XRHjC7A7T4pxaXx6CEdF1teYeBisKMyr/Q400SVdtV6m68=
X-Received: by 2002:ab0:2c08:: with SMTP id l8mr5688696uar.113.1549527951445;
 Thu, 07 Feb 2019 00:25:51 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMd-38BL1jJnHQY0J68mmtxW1WBQF2qGqyNpWtwsrwUcYg@mail.gmail.com>
 <CAKfTPtBaKbtfLMjLH1u20+ukhpm6i9qDK-3HiTPizSjKNCnw=w@mail.gmail.com>
In-Reply-To: <CAKfTPtBaKbtfLMjLH1u20+ukhpm6i9qDK-3HiTPizSjKNCnw=w@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 7 Feb 2019 10:25:40 +0200
Message-ID: <CAOtvUMdRWjqp0sEZUQU6w6RcDFP26i3Gxzg5zsRvG2ej1LVSFg@mail.gmail.com>
Subject: Re: Regression due to "PM-runtime: Switch autosuspend over to using hrtimers"
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Ofir Drang <Ofir.Drang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank for the quick response.

On Wed, Feb 6, 2019 at 6:59 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Gilad,
>
> On Wed, 6 Feb 2019 at 17:40, Gilad Ben-Yossef <gilad@benyossef.com> wrote=
:
> >
> > Hi all,
> >
> > A regression was spotted in the ccree driver running on Arm 32 bit
> > causing a kernel panic during the crypto API self test phase (panic
> > messages included with this message) happening in the PM resume
> > callback that was not happening before.
> >
> > I've bisected the change that caused this to commit 8234f6734c5d
> > ("PM-runtime: Switch autosuspend over to using hrtimers").
> >
> > I'm still trying to figure out what is going on inside the callback,
> > but as it was not happening before, I thought I'd give you a shout out
> > to make you aware of this.
>
> Are you using autosuspend mode for this device ?
Yes.


> Also this happen in a platform specific function cc_init_hash_sram().
> I can't see anything related to pm runtime and autosuspend in it.

True. However, the function is called from the driver PM resume
callback and before that commit it did not fail.
My guess is that there is something related to the timing the callback
is called, probably some race condition the change exposed.

There is probably nothing for you do until I figure out what is
failing in the internal function.
I just wanted to give the heads up in case someone else runs into a
similar issue with another driver.

> Do you have more details about where this panic happen in the function ?

I'm looking into this right now and will update.

Thanks!
Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
