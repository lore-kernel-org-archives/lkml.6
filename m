Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC44EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF6420850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrQGfMT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfBWJv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:51:27 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35580 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBWJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:51:27 -0500
Received: by mail-ua1-f66.google.com with SMTP id f88so4264269uaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGA0TS/NROxPnq6keBS8N82pK9bdWNftC9AOvWz98qI=;
        b=IrQGfMT6bglJsDzFn3M+f3ZwSS44vjF7gC8heACILNy5aSC4nw+MEUtbb9nvgeTaL/
         NZ4ToUKnV9itEtqToIPg3OSi7l3HLPT0nRzn8+WKYSgHHtj5QPgjQ/Al2wxYuJxl9poN
         qW8wNIfrbE8XG643HvH3yV9Jpxur5gkOgEeIf6FZ5ceDKefJ4cMNCZq6vUIgE8Ep/5Lh
         YhVEjTeK6/4j1OTKJZT46jnhe51UPtpBD7O5iPtqja09vWyEvhZPrijlVAwIJnb3USoL
         W/ymK0VeNw6oRBW0LkMpDS1j9h3XQOx68Gd9P8x9lvnYMotAPgDCyVsg90uA93fu/MbS
         O5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGA0TS/NROxPnq6keBS8N82pK9bdWNftC9AOvWz98qI=;
        b=SVv5WsrbcsNz85zMntnmCD12rPYsOMj0lw7Oz8dCQLFedE8g+ZgD8Rh97kh6Zf8Rx1
         Kw2WBnewrxpzpiwFu5vHfGBV3jT2v8Kz+fIpeFHkZLN3ygKcN7RfVRZy0Uv25DooYWhB
         AotOc+NgWQvcuzs2SGh2JJJO0u/HaXfwyc8gi16/m0de4kxXnoUAI0ts4/5zpH+ih+w0
         YjntpTAiFeWSXPQTXtIwjyuDoAzwvWEqxx4RmwouD3polGIRZMeCN4jbrYCCymHU4qmt
         y0JiF5CD+JMn3M23GesbPF+JJKnmU+vta097XWcMxqt3+IddqUmurgHv+GuKERXScVsf
         UOgQ==
X-Gm-Message-State: AHQUAubSHRGF9/+VaCOrEWJAr3Ec/QlgCOLdGDN9sgyyVGNJSgdjKG+q
        RaFVKiBRDzuTeTv0Xlb/Jl66kvLeG7m4rNuq5VA=
X-Google-Smtp-Source: AHgI3IYU/LFFb+TBmPd9Ha9mKyB3ItNJ8i7wXDu0TUUwOnHGPsiAQsNQBza0mYNimzyC/i7K4A9CYgMAsk7M8KtiDuM=
X-Received: by 2002:ab0:22d6:: with SMTP id z22mr4367686uam.66.1550915486303;
 Sat, 23 Feb 2019 01:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20190222192959.241499-1-oded.gabbay@gmail.com>
 <20190222192959.241499-2-oded.gabbay@gmail.com> <20190223091659.GA25029@kroah.com>
 <CAFCwf13nv5Q6dy=dH=GtoMYNyZHMCnQ=C68kLhkcJ8P0LaSdqw@mail.gmail.com> <20190223093407.GA26471@kroah.com>
In-Reply-To: <20190223093407.GA26471@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 23 Feb 2019 11:51:01 +0200
Message-ID: <CAFCwf11fsmny3N9xzFR4n4NE2CcboBnNk4387fBtW54rmqg3ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] habanalabs: driver's Kconfig must select DMA_SHARED_BUFFER
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 11:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Feb 23, 2019 at 11:19:07AM +0200, Oded Gabbay wrote:
> > On Sat, Feb 23, 2019 at 11:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Feb 22, 2019 at 09:29:59PM +0200, Oded Gabbay wrote:
> > > > The driver uses the DMA_BUF module which is built only if
> > > > DMA_SHARED_BUFFER is selected. DMA_SHARED_BUFFER doesn't have any
> > > > dependencies so it is ok to select it (as done by many other components).
> > > >
> > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > >
> > > kbuild reported this, right?  You should always add that type of credit
> > > to the patch.  I'll go add it by hand this time...
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Ah, I didn't know that, sorry. It wasn't enforced in drm :(
>
> Really?  The drm developers should know better, that's not ok :(
Well, perhaps it wasn't enforced only for the few instances that I
fixed those errors and usually it is enforced.
I don't want to smear the entire drm developers community based on a
small set of examples.
Thanks,
Oded
