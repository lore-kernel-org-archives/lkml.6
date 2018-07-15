Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D46208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQK63Zz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D46208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeGOKkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:40:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45405 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeGOKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:40:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id c4-v6so16366611wrs.12;
        Sun, 15 Jul 2018 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACK/c6UUuncJo62TVbwW6/DMIGe7BZnMYMz2rZstmxE=;
        b=bQK63Zz+arbg7eVQqpGuOClT+TNqvzkRR5oNXbQLPzrcPQEmOuKh1kJ7t++T4QF7fL
         XGg8ZZNG4JZh+A0hJRyIOrQFnT1EWxANAH3XWR3f/FRRduLvuucdSiuZ8n/snl3gPDEp
         SNFRRD8JfGxo0vqa+oH1wFNvj9aVhMmFCaeSPYTqMiIkdwXypgzpGOP8krwcoOLysyzy
         2Uz/s2rxvdUqsbTP/qYY9wpWsvOGc2jJ2KE2DwkUhLnICcv7MdtneSgwW71YNwMxbtkP
         BZd1zwABWFPQHPr90K2BOKp9S473AwEnAvvw8ZouY76e3AeZcDI3fbHe50Qdui5npiVi
         /AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACK/c6UUuncJo62TVbwW6/DMIGe7BZnMYMz2rZstmxE=;
        b=s0Zn5zf9bCFSZNuPstbA31X63aCuFbeYkzMONidehdDLjC3qJI6xeib+79Ht7xFhvf
         839D+IPzo6RkkTjw9NlJhhupf1jouu3/ku3PXtip57Zuf4670GAIH9sY5qffN0Znfi6j
         JBaiO2r6rm5xtSBzhNxz4xmnFnSiEZ6CgRLm/HOhgxDjZ63xV0O3RK0wWNz2o79OoKEA
         TXTZOTUduL8jlbNmn818kvGNutaGRV2TsaaMJEY7mqdL3Aiz1EBT5C+M4IbAT9OcJO6U
         1n0oYvZO1155q09PZ2PfZD4l7By0E/pNix+fTvyCMh5jAM4L0S7nihgW+Ailzk7BNEuk
         +n8A==
X-Gm-Message-State: AOUpUlE+1vapdpF1LPo2JgLcqOpDJ6pfBzSAdUZ2CJ4eUcShtP2Bon3n
        IsoCVNJlXjc5Luik9jdvXDo=
X-Google-Smtp-Source: AAOMgpdfT+KPJcEpUsp/FR1Dfhfe7gomYYhKXiXPTKT2EL+Gu8nRIYj0yeCWOS2ZMk9yvbpXskpLbA==
X-Received: by 2002:adf:e9c1:: with SMTP id l1-v6mr8996332wrn.14.1531649899708;
        Sun, 15 Jul 2018 03:18:19 -0700 (PDT)
Received: from localhost ([195.46.23.67])
        by smtp.gmail.com with ESMTPSA id g15-v6sm21909285wrh.48.2018.07.15.03.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 03:18:18 -0700 (PDT)
Date:   Sun, 15 Jul 2018 10:18:15 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
Message-ID: <20180715101815.5derw7zfjm2d2ayn@penguin>
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
 <20180714080920.GA15123@gmail.com>
 <20180714085109.mbhk6aybpjsbuq6l@penguin>
 <20180715074225.GB15123@gmail.com>
 <CAKdAkRS0NBOo7thkevZAQXBWt_ReppjdPz6a6PQ6LtJHbPYgVg@mail.gmail.com>
 <20180715101244.GA32410@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715101244.GA32410@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 12:12:44PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 15, 2018 at 01:06:32PM +0300, Dmitry Torokhov wrote:
> > On Sun, Jul 15, 2018 at 10:42 AM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:
> > >
> > > On Sat, Jul 14, 2018 at 08:51:09AM +0000, Dmitry Torokhov wrote:
> > > > On Sat, Jul 14, 2018 at 10:09:20AM +0200, Marcus Folkesson wrote:
> > > > > Hi Alexey,
> > > > >
> > > > > Good catch!
> > > > >
> > > > > On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> > > > > > pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> > > > > > anywhere in the driver.
> > > > > >
> > > > > > The patch adds one to error handling code and to pxrc_disconnect().
> > > > > >
> > > > > > Found by Linux Driver Verification project (linuxtesting.org).
> > > > > >
> > > > > > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > > > >
> > > > > Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > >
> > > > Hmm, the biggest question however if we need to "take" the device, as I
> > > > do not think interface can outlive the device, and whether we actually
> > > > need to store it in pxrc, as we only need it during set up, as far as I
> > > > can see.
> > >
> > > Yep, the device is only used during setup.
> > > I interpret the comments for usb_get_dev() as you should take a
> > > reference count on the device even if you only use the interface, but I
> > > could be wrong.
> > >
> > > From usb_get_dev()::
> > >
> > >          * usb_get_dev - increments the reference count of the usb device structure
> > >          * @dev: the device being referenced
> > >          *
> > >          * Each live reference to a device should be refcounted.
> > >          *
> > >          * Drivers for USB interfaces should normally record such references in
> > >          * their probe() methods, when they bind to an interface, and release
> > >          * them by calling usb_put_dev(), in their disconnect() methods.
> > 
> > Hmm, usb device is a parent of usb interface so our driver model rules
> > ensure that usb device should not disappear while interface device is
> > still there. Greg, is this comment still valid?
> 
> Yes, that is true.  But remember that interface devices can go away
> while the parent is still present, so if you need the interface pointer,
> you have to grab a reference on it.

But not in a simple interface driver, as we'll unbind the driver before
destroying the interface... IOW we need to record the reference only if
we are doing something unusual.

Thanks.

-- 
Dmitry
