Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A09C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C77620880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OndiZfuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C77620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeILCvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:51:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46948 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeILCu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:50:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so122930edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/eM7wUlB4sL80j9P9LLyszeZYNd1+UL3qDbNM5QoD64=;
        b=OndiZfuBE2NORncF/J4H6IAULj7+9tHZzdQ8ixv2S22Y3Ymmq6/UcOaGfVWD5kvEXq
         h5I4hZCPlgbLvuS6mI40jxyXfmTnkhqKJt/MKMKcpyKNXsun30AjS3gg6MxlL55gtjq+
         yVs9PEZQA9A4iJ0BJtMJGeFxaTf/zQgcstal5lL3Y/cNqBqDZCmNMyuNXcPZ8Xul7PKI
         sOHvGjV5pe01mgIi/0s8UoSTPw3mGMOynkQKY9IG3fgYS+Mu4cc0a1Wnj1RIr5Rw0c66
         CBEkqVusaRVCq1yizW7srB9JW99wZH04wCe/n8JAD1Y6NC9NEHcA0vaU8Fw298j8LMaR
         VHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/eM7wUlB4sL80j9P9LLyszeZYNd1+UL3qDbNM5QoD64=;
        b=mZRvBxF25a1sDDuuAkfJzEgWjPOizlfMfRonST+r0RFD6IumHX108NMPs2JttFb/lC
         mcq8sirYCGtbXIW5zIXqBIA7j2NIFHRswShADOi3FbzrxCcsAHOKKmsuXjrQx1qPzDhd
         kA7YMY8idP+hBkjVCAUEsHf4S45z9nqrRmWUIUIiqABxlRYhYyrUgcYwwaYWhhhpdBdg
         waR2eo/FN9VMna45IvLwjABWVMajQpigbiJDeLZEobXvLf59+w79WWCwrKmD5D4kF+OW
         6TlU1g/9yiNap8wv/aI5AjrmsodTzj3ZOPK1ibfW07dHTBa58NolLCXmx0HVbT3Uy5yj
         fB4g==
X-Gm-Message-State: APzg51CXWoD9CdLxmJbzuIHoQHrKpN3Ps2iN2fH05G6GxgbBPdytGo7G
        tqMMTqJ7xkx2BQozPZaPm7M=
X-Google-Smtp-Source: ANB0VdaVCk1m38YftprAgn/iK1cTwY3TOK6FQibBkXn6zH/Pr5XX0EIfbePtAYgSi4bf3B+ylZBEkA==
X-Received: by 2002:a50:98c1:: with SMTP id j59-v6mr30789193edb.212.1536702581290;
        Tue, 11 Sep 2018 14:49:41 -0700 (PDT)
Received: from xux707-tw ([109.78.225.224])
        by smtp.gmail.com with ESMTPSA id z19-v6sm15621979edd.77.2018.09.11.14.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 14:49:40 -0700 (PDT)
Date:   Tue, 11 Sep 2018 22:49:56 +0100
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 20/20] staging:rtl8192u: Rename OWN - Style
Message-ID: <20180911214955.GE31239@xux707-tw>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
 <20180831230250.16810-21-johnfwhitmore@gmail.com>
 <20180910150927.GC25530@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910150927.GC25530@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 05:09:27PM +0200, Greg KH wrote:
> On Sat, Sep 01, 2018 at 12:02:50AM +0100, John Whitmore wrote:
> > Rename the member variable 'OWN' to 'own', this is to comply with the
> > coding standard, where variables are named in lowercase.
> > 
> > This is a simple coding style change which should have no impact on
> > runtime code execution.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U.h      | 2 +-
> >  drivers/staging/rtl8192u/r8192U_core.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
> > index 68e82b32a88e..f963b664e221 100644
> > --- a/drivers/staging/rtl8192u/r8192U.h
> > +++ b/drivers/staging/rtl8192u/r8192U.h
> > @@ -165,7 +165,7 @@ struct tx_desc_819x_usb {
> >  	u8	last_seg:1;
> >  	u8	first_seg:1;
> >  	u8	linip:1;
> > -	u8	OWN:1;
> > +	u8	own:1;
> >  
> >  	/* DWORD 1 */
> >  	u8	TxFWInfoSize;
> > diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> > index 911d0214b48a..4d0f70ec31ac 100644
> > --- a/drivers/staging/rtl8192u/r8192U_core.c
> > +++ b/drivers/staging/rtl8192u/r8192U_core.c
> > @@ -1558,7 +1558,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
> >  	/* DWORD 0 */
> >  	tx_desc->first_seg = 1;
> >  	tx_desc->last_seg = 1;
> > -	tx_desc->OWN = 1;
> > +	tx_desc->own = 1;
> 
> Is this another case of a variable being set once and then never used?
> 
> If so, just delete it.
> 
> thanks,
> 
> greg k-h

em, I wasn't sure because that variable's a memeber of the sk_buff * passed
into the funtion. That function should be static to the file and is only
called from function rtl8192_hard_start_xmit() but that's a function
pointer which is sort of exported:

        priv->ieee80211->softmac_hard_start_xmit = rtl8192_hard_start_xmit;

Having said that the 'OWN' member is part of the private data:

	struct tx_desc_819x_usb *tx_desc = (struct tx_desc_819x_usb *)skb->data;

Like I say I wasn't sure so played it safe. I guess it's private data so nobody
outside the driver should be messing with that data, and I'm not sure how
public that function is.

I'll read some, ponder a bit and have another go.

jwhitmore
