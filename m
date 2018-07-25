Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5711AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3BB20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEmp6dbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3BB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeGZAvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:51:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42509 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeGZAvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:51:54 -0400
Received: by mail-pl0-f67.google.com with SMTP id z7-v6so3932340plo.9;
        Wed, 25 Jul 2018 16:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xe1DtgLCKrqL7OmTELZx0Eh18OPrDF/mqraNVNEUSuk=;
        b=MEmp6dbPgJvM4UjRWo7kenmPBf2xFJ+JCAcpQ52nS9mDZd/+hOwmlhNVmjiT1e+duD
         E+WPkF3/OLuc15KWwP9o1IH59r3hv1gZ1/rhecYYFbOubwBkNlPFGn34T07nlaXOzsDb
         B1MORYUQFAOfn3qhY/qpAsCcBrHa3QxIRp/1+zDHnNE8tg6woMy59CwuoMI7xfDEOen7
         mzJ5lpsrIYGJGLu3fb8Fu5GbXQ4Vx7ZZfojzDEnGfHuUBoUVvh0ycDvXR7QKunhX/lQ8
         KtIxsynpo3xgbDray/B9tqQomPnKhLmd3ECwpA8RH2+guC5HMJXNYF3s7/iqJm6hYwrU
         R2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xe1DtgLCKrqL7OmTELZx0Eh18OPrDF/mqraNVNEUSuk=;
        b=Sd9jqhnMSuR8pCRei4QDAuxKy0r0FXWTfYwINwUyyO8RnIITvm4AkmM77/mA/eHtMW
         n54JfaBDEhBYYrVMbcVdXjRiXg8yVBwvuGKgVu9NXhYPneSf9JnlHUFQZjHp25ekVD2x
         V899VQorfgMSF//QPZBJWisqXcFswjHrJffwa0e4bSR4TUDM+tPTkPPkHkj/iQUXFafN
         75YK7IORM/s6eI3SazetRmqYowxzT4KoxR+q4+26TaTtFdYhl7dvgOZ/FALlDu6W3fRb
         1dZIF8eaptYqMNsgXNcFxjjwqALE55c85NljvW3KUTLXGOljope5164qp9PX2ZpBcYjD
         jjow==
X-Gm-Message-State: AOUpUlE4atPEWOAiGZvzJtg8vj05e6iLQo0cpDp44ED4Pui4WHaneXY8
        6NLVveN8v1EEKFzvwvB9sWI=
X-Google-Smtp-Source: AAOMgpf3fkVVAcsmiIDkN2pzuwd+efK9X+PxHW4xOb2DtDTGVxvCAQNPmc94a0nzRlLzIUUQuAWZhQ==
X-Received: by 2002:a17:902:bf06:: with SMTP id bi6-v6mr17040246plb.76.1532561874183;
        Wed, 25 Jul 2018 16:37:54 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id c12-v6sm35822852pfl.20.2018.07.25.16.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:37:53 -0700 (PDT)
Date:   Wed, 25 Jul 2018 16:37:51 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: pxrc - do not store USB device in private struct
Message-ID: <20180725233751.GC80336@dtor-ws>
References: <20180716144014.6331-1-marcus.folkesson@gmail.com>
 <20180724023804.6mnbstzdrcp74rev@penguin>
 <20180724180959.GA2864@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724180959.GA2864@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 08:09:59PM +0200, Marcus Folkesson wrote:
> Hello Dmitry,
> 
> On Tue, Jul 24, 2018 at 02:38:04AM +0000, Dmitry Torokhov wrote:
> > Hi Marcus,
> > 
> > On Mon, Jul 16, 2018 at 04:40:14PM +0200, Marcus Folkesson wrote:
> > > The USB device is only needed during setup, so put it back after
> > > initialization and do not store it in our private struct.
> > > 
> > > Also, the USB device is a parent of USB interface so our driver
> > > model rules ensure that USB device should not disappear while
> > > interface device is still there.
> > > So not keep a refcount on the device is safe.
> > > 
> > > Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> > >  drivers/input/joystick/pxrc.c | 22 ++++++++++++----------
> > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> > > index 07a0dbd3ced2..46a7acb747bf 100644
> > > --- a/drivers/input/joystick/pxrc.c
> > > +++ b/drivers/input/joystick/pxrc.c
> > ...
> > 
> > > @@ -204,23 +204,25 @@ static int pxrc_probe(struct usb_interface *intf,
> > >  		return -ENOMEM;
> > >  
> > >  	mutex_init(&pxrc->pm_mutex);
> > > -	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
> > > +	udev = usb_get_dev(interface_to_usbdev(intf));
> > 
> > There is really no need to "get" device for the probe duration, or in
> > general, when you are not storing the reference to it.
> > 
> > I posted series with an updated version of this patch plus couple more
> > cleanups/fixes, and would appreciate if you could give it a spin.
> 
> Thank you for doing this.
> 
> I have reviewed the patchset and tested on real hardware, and it looks good
> to me.
> 
> For what it's worth:
> 
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Tested-by: Marcus Folkesson <marcus.folkesson@gmail.com> 
> 
> On the whole patchset.

Excellent, thank you.

-- 
Dmitry
