Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1083C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEABA2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9SvVIW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfAZJp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:45:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36840 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:45:57 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so9542422oix.3;
        Sat, 26 Jan 2019 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KTA5+Pi52+WsHEraJwxHhWK/n47KMqyCzuN3T2F7d1Y=;
        b=W9SvVIW4ejpD4K/xqoOMnPNv4NXw3GJY/53k5lVQ85pr0kDbgQtdKXuuJ5SXKZj2dY
         y5PsEic5lvaIQEyFDw5zdhjV+120o0vFo+kOG1+YfW8nHoEHrK0iC/9yBd3lcWWfPSO4
         dNFXT9EpNAsiYZaarZxh6LtVrNtW8aNcKmpOaYXGkkgvuBmv8Hk39NgcXHSLeFEXExZP
         /mkmplRkdK293p6FCbfRCUpnKvZJFVWd3kwEudunAT8joj/FD5k1IPP71bidla3ESg5N
         z9J2ieOBbX+PqggkRrATIADd+Cq2pyq/2cRAyzKhnT+YmgQZcgwbX7IH2NljlaIwOrj3
         NJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KTA5+Pi52+WsHEraJwxHhWK/n47KMqyCzuN3T2F7d1Y=;
        b=jeSgLDZa6QyNrCn5qgTqvzBeYPsTom/stD0KaD4+rAMrUEAfvhAswSFT820qs1zCAW
         P6IyHsuwky0RQhA63W0e6kgJ2X8n+ppwOo3P0FARWf+6HsAAMrUNsZodSA/mnHxoNgFU
         fqFtsk0m7Tiv+o9LBHrNXICAYach1+V8TQFTJwNtlIPyGgtqLrazP5H2lRxdRO9J+DIG
         12wfkuEfyaXXR0g5YjWNvsteKULRNcky0WOIH5NNBGYQy31CAzfs1W/osT8PmrPi70qL
         mDnFMrgVZ6e3z9UT7QpB79ngTK2LgxBo/Afb5P+/Qdsp2EdZp96duGCVQdeb2bMPT88/
         XklQ==
X-Gm-Message-State: AJcUukcJ7t+SzKscxexc9pd8eYaNaq0lifWmVkOCrOElgZmT0AiyOLBU
        FXKkH4h7lMpkpeJuFECm7ulrvUxCG8Q9MJOXuCtAhoD9
X-Google-Smtp-Source: ALg8bN4acJhC6Zwb+qpXp/0V81T4Qo5MssVapt3pppqGYgy3wtrlxXTfLTiiubt/XFJjbQYtjQQO4sQYngY9+Zlb+DI=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr626213oix.246.1548495956327;
 Sat, 26 Jan 2019 01:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20190125164412.GJ18982@uda0271908> <Pine.LNX.4.44L0.1901251636140.4354-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901251636140.4354-100000@netrider.rowland.org>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Sat, 26 Jan 2019 12:45:45 +0300
Message-ID: <CAJs94Eb-ERrfAEONK=_14f=kMsqVBT-XkcwfWZXwUgspraD9QA@mail.gmail.com>
Subject: Re: [PATCH] usb: musb: Fix potential NULL dereference
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D0=B1, 26 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 00:37, Alan Stern =
<stern@rowland.harvard.edu>:
>
> On Fri, 25 Jan 2019, Bin Liu wrote:
>
> > On Thu, Jan 24, 2019 at 09:47:02PM +0300, Matwey V. Kornilov wrote:
> > > By the way, why do we need to store the qh in urb->hcpriv?
> > > qh can always be accessible through urb->ep->hcpriv
> > > Wouldn't it be better to drop entire urb->hcpriv usage?
> >
> > I am not sure why. The code is there since the first commit in a decade
> > ago. But I tend to agree with you.
> >
> > In a quick search for urb->hcpriv and urb->ep->hcpriv, based on the
> > usage in core/hcd.c, it seems to me that urb->hcpriv should not be
> > changed in each controller driver, but I see both have been used in mos=
t
> > controller drivers. I will leave this to others to educate me.
>
> In some of the older HCDs, urb->hcpriv !=3D NULL is used to indicate that
> urb is on an endpoint queue.  Perhaps that usage was copied.
>
> Alan Stern
>

Hi,

Thank you for the explanation. I think that It would be great to
document it somewhere. Such a purpose for variable named `hcpriv' is
not entirely obvious.
Now it is clear to me, why __usb_hcd_giveback_urb() sets urb->hcpriv to NUL=
L.

Returning to my initial patch. I think that it is still valid, though
I admit that the commit message must be rewritten.
In this code path we successfully queued the new urb, so urb->hcpriv
should be NOT NULL indicating that the urb is queued according to Alan
explanation.

musb_urb_enqueue(), musb_host.c line 2345:

        if (ret =3D=3D 0) {
                urb->hcpriv =3D qh;
                /* FIXME set urb->start_frame for iso/intr, it's tested in
                 * musb_start_urb(), but otherwise only konicawc cares ...
                 */
        }

--=20
With best regards,
Matwey V. Kornilov
