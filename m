Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF75C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A99D2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAi5XT8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A99D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeH1X2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:28:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35195 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1X2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:28:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so2411760ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-description:content-disposition:in-reply-to:user-agent;
        bh=G+SbF4JMHfIqKGVVyJD2rQB58vLIuAu1NkXH4XaKNjA=;
        b=GAi5XT8T8eCySOTKl4X5q7Pc/SrhHMidy1oJwCk6dxSmf4iXEvw5BhN6aAbUdU02or
         bRfc/FrYk5sD5pW7FHJbbh3BxqQTMHtKUiTcbziNbrpY5jSyDTPQy5bVHG+aNXOjGErN
         lElSN20SkiZ13Wnm3wD9PQaG5grSDw2QA6Yu3qLE9xv1p+ZrCh2gFgpnAFpWzigFRgIB
         sgrpiFrKkwCFBJ0Ctf+mQcxAdeA1tmzZgEW7LSmpupnaEnBv8jz9WIjWn+Yn76O5rTx/
         x+p6x9T6PDXFxV3FBmCCIpQmHazPXW9h1Ebv9oW8+LuGxfJsUCRZldvTrGrRQr6htyLj
         6DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-description:content-disposition:in-reply-to
         :user-agent;
        bh=G+SbF4JMHfIqKGVVyJD2rQB58vLIuAu1NkXH4XaKNjA=;
        b=cFqcx1tLtC3sJMvYNGI33QnUxNMKf/EHI9/Egrpy3vGrz8x5pjoOIW35RFIJj2AFlD
         cLB5CuZ7WONVIInehoEzUW3ZZJAD0w5vZfOxrxasYPSEyQFlgp2H6DYNXL9tUrpftnOf
         FUOu6g85Xwok0qhHPXipKXmkzjK3HU56X2xykgGCLaxbdnwEYKUFV3iaxixmf6AGCJG/
         p+WmjuDq91D3CQnzCkwTZftEGO3hJZuwh6NYfMcspVFrNzCNthTnTQYPmjqp8/8l6nJf
         5ADUbnb2keyTav5oH1ehG3Y7blAfHIkHyXoQWwN1bayFR0OgKUJ1SRF9c0I0pn+o5dwD
         VbrQ==
X-Gm-Message-State: APzg51DXwIoCzcoIqPDTQA++uOzq5nZM3t5s4DDLZcfiJ59iJBJWWMmf
        wSkhC2/ZnOu4Y4hs/haOgf8=
X-Google-Smtp-Source: ANB0VdYJZc9393TY3FsyqWL8aityiLvMuoQaZ507m0hBsDoxfR+A5eodrkSiETrWFzh8PPgr1Rg8VQ==
X-Received: by 2002:a2e:4951:: with SMTP id b17-v6mr2255967ljd.31.1535484902376;
        Tue, 28 Aug 2018 12:35:02 -0700 (PDT)
Received: from arek-VirtualBox (185.59.110.199.maxnet.net.pl. [185.59.110.199])
        by smtp.gmail.com with ESMTPSA id l25-v6sm354312lfi.94.2018.08.28.12.35.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 12:35:01 -0700 (PDT)
Date:   Tue, 28 Aug 2018 21:34:57 +0200
From:   Arkadiusz Lis <areklis909@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jfrederich@gmail.com, jon.nettleton@gmail.com, dsd@laptop.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: One Laptop Per Child: add function argument
 names
Message-ID: <20180828193457.GA8780@arek-VirtualBox>
References: <1533831839-7361-1-git-send-email-areklis909@gmail.com>
 <20180827175213.GA27361@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: sd@laptop.org,
Content-Disposition: inline
In-Reply-To: <20180827175213.GA27361@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 07:52:13PM +0200, Greg KH wrote:
> On Thu, Aug 09, 2018 at 06:23:59PM +0200, Arkadiusz Lis wrote:
> > Add function argument names to pointers to functions
> > in struct dcon_platform_data: init, set_dconload and read_status
> > This commit removes checkpatch.pl warning.
> > 
> > Signed-off-by: Arkadiusz Lis <areklis909@gmail.com>
> > ---
> >  drivers/staging/olpc_dcon/olpc_dcon.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
> > index fa89bb9..0ce1a7a 100644
> > --- a/drivers/staging/olpc_dcon/olpc_dcon.h
> > +++ b/drivers/staging/olpc_dcon/olpc_dcon.h
> > @@ -91,10 +91,10 @@ struct dcon_priv {
> >  };
> >  
> >  struct dcon_platform_data {
> > -	int (*init)(struct dcon_priv *);
> > +	int (*init)(struct dcon_priv *dcon);
> >  	void (*bus_stabilize_wiggle)(void);
> > -	void (*set_dconload)(int);
> > -	int (*read_status)(u8 *);
> > +	void (*set_dconload)(int val);
> > +	int (*read_status)(u8 *status);
> >  };
> >  
> >  #include <linux/interrupt.h>
> > -- 
> > 1.9.1
> > 
> > _______________________________________________
> > devel mailing list
> > devel@linuxdriverproject.org
> > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> 
> Patch did not apply to my tree at all.  Please rebase against the latest
> linux-next and resend.
> 
> thanks,
> 
> greg k-h

Hi Greg,
It seems this issue was already fixed with commit 9b59883c14267ccf2c3f9d260bd6fb0dc9478fa1, hence the conflict.
My patch is redundant

Regards,
Arek
