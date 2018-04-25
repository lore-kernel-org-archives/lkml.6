Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483212-1524697079-2-7025120957332379966
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524697079; b=DjcQnmXFGexI5YcndiGaa5NyFwrLObneGvy0C9obAz2+TgGLwt
    hs+o7oXCEYYTlrP/L5Zfo//+yHtzNeZ/NLsNzONXI2nZruv8wZlp7vQaEyz3oPpa
    hK8GywZLyjuRN0QroFkAWAUGirJiqipEiMsdNfrI2GkyHe5tteXI8p4iqoLZVzpE
    iiqi7amgIfKMHLGC7bglnELXZVX1C37ihWZdOYYKoVITLmih8Z1Yd052MJ1HDh+t
    Mt4nvsRQFjGaGoe5Xp0lzMSNkSmOoKxxkJu/eCB26DeHSBzPUBzfC2MoFQtGsuuS
    xrM6p+EDeWuUz2xoGNokkC5bq4iwZmFc8Cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524697079; bh=db4Pz06u2xNkz7vWtIgjXfwgHRZvMg
    4A487C/DE3FR0=; b=P/JTSQCSK1klLyI7EWHFZu4RsNtdxp1v4xZ45Iw2U8her2
    C6HKKvhJUPAbgL1OGfAptlIn9HH8vn7ezlc+Y1iJTi0pedicIOiV817GZQxUrxtx
    WXLIv7TbvLkC1nj019FXfVchXuhqOh+VK3arHJo9cRi3mar3zePUcQc+dmNTM94i
    cVuj/MtTHYEsImBvQtnav9ATWBgVy51iBrjl3a3/OhNO9hMzLlOcJm3YS9uvvmSL
    NWESNoWxd2Lg1UCDTcp8hP6Qn2iFy3Qy6yW82RqqxFXvXkoRjv3xlND8W4Kr+yvl
    OLPFaCQaCOVcnI+1oYw02Ve2MsTSURjK83Wx76cw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PuzVBmo7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EAJnOsa9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PuzVBmo7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EAJnOsa9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBGlBxOjycPqJTfZzSz7brMHH70M/eQ+9M6Zi3zind+fMXQ3YjmNmBHbsEyOpL23VkdJpteIckQAkg86LQA5td1w33sr+umGDR/Jg+HrfD3qLW7U1ND5
    a1n7OrD+W5/vzZw+Nw+o6ntKQZZYsTjA0N1et36I/apfPIXq9qt6Jcv5iVVr96XfDImodIw8C9McVtdipfkb2JFQkkLPSgRa3gD3CyyW0kZDGdbbw4OSriz7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=uNphubBhQK8A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=rEqvwrX8AAAA:8 a=nx57h0buAAAA:8 a=97XZTxN1aWDSCt3u8loA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=2B8fXRCmRxTqFPaLtVU6:22 a=YtO9EDU9lxz8Tya6zqt4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeDYW5n (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 18:57:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34150 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754036AbeDYW5i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 18:57:38 -0400
X-Google-Smtp-Source: AIpwx4+4xwyhcelmedUqwzbAn6+R8F+imwibCs4Jt3UoymObYEOZY8NW10CkFBjzIJ2C3O1kGD9dJw==
Date: Wed, 25 Apr 2018 15:57:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        stable@vger.kernel.org, nick@shmanahar.org, bleung@chromium.org,
        Salvatore Bellizzi <lkml@seppia.net>, groeck@chromium.org
Subject: Re: [PATCH v2] input/touchscreen: atmel_mxt_ts: Add correct touchpad
 button mapping for the Caroline Chromebook.
Message-ID: <20180425225734.GD200812@dtor-ws>
References: <201804251232.w3PCWweA028076@mail.vittgam.net>
 <20180425222650.GC200812@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425222650.GC200812@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 03:26:50PM -0700, Dmitry Torokhov wrote:
> On Wed, Apr 25, 2018 at 02:32:58PM +0200, Vittorio Gambaletta (VittGam) wrote:
> > This patch adds the correct platform data information for the Caroline
> > Chromebook, so that the mouse button does not get stuck in pressed state
> > after the first click.
> > 
> > The Samus button keymap and platform data definition are the correct
> > ones for Caroline, so they have been reused here.
> > 
> > v2: updated patch offset after 20180409 changes.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
> > Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
> > 
> 
> Applied, thank you.
> 
> > ---
> > 
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -3035,6 +3035,15 @@
> >  		.driver_data = samus_platform_data,
> >  	},
> >  	{
> > +		/* Samsung Chromebook Pro */
> > +		.ident = "Samsung Chromebook Pro",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),

I've been alerted that shipping BIOS has vendor not capitalized; where
did you get the firmware that has vendor all capitals?

Thanks.

> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
> > +		},
> > +		.driver_data = samus_platform_data,
> > +	},
> > +	{
> >  		/* Other Google Chromebooks */
> >  		.ident = "Chromebook",
> >  		.matches = {
> 
> -- 
> Dmitry

-- 
Dmitry
