Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6BDC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF6B2172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T33RiPMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF6B2172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbeHGUfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:35:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52216 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHGUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:35:51 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so112688itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xi8iSiN5PpmLysk1/ZjblDyLQEGHI9xjsgH44cSZmBw=;
        b=T33RiPMdpveCuMffWSKsodEB+2yO3sRektp4CV4SUceClcqYnNNGPC4dRioQPi6UvF
         09RNKzmhGIJxBO2HI3PCgxVXOXIfkjz5J32SwV1G53laokeC7pk15S67AtMR3K7XNrQQ
         fijG/Lo3qgqQUHSwxx3CR1WYnR3W6gQx7bPk/QYEAbVp6wPmHnXi+tH9i7InGQz/jEvQ
         vW8A5dYlBnCl+IYTQI5pkVKhxwm6XTggbkdqOWwypBoI4wNJ9xf5P8a4UlkxNjXtlUGG
         sEJsRkacKqPy4S9oo5XNQUsiE9+LEGAKgs8uiQWvdwmV2GWG/fMmyja+WIYC4SfSLjpK
         4x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xi8iSiN5PpmLysk1/ZjblDyLQEGHI9xjsgH44cSZmBw=;
        b=GeN3c+z+xJTQgsPXE4lgx4dURT9na2g1DtSDfIMAxyCF8InHEPHWQ/27+FZ4LactwV
         6oyY/Sfslk+J9jYsWnWeL1dfeav60JBGr6Mq4KgBBig6PiokS5BUC7YOeZscYXm8nr/W
         Ze8cE8yNYyciIQ6LQennB9YlTqIP3Xq3ecfmD29cbSKCJVQ+EttTJWhZYaYzhSrtomE5
         5VL/YjMPNMYu6Dl0Y2ACVnjBy63FAWAQfjyEL+PsjU2WhnYwgFQG3i5+wLnBThnc1Yw1
         vpoH/58lo4s2VvDNnRCSwQg5i3omN68g8kRJljEWZ/cDWwrX+Otcz+wXTTMzrjxP9kxn
         KKEw==
X-Gm-Message-State: AOUpUlHKavbH2Qh3hqsgeSl4gVW3AnihGOiislTtC5J9X89UWW6XDjgZ
        GadA3kFSRab8vWYP1l3uxsr1lgqzOQ8=
X-Google-Smtp-Source: AA+uWPyFzBFRghdTRtu4M1drYp065CxaXz0OOIxG/LNVb6WqEhu1iQhKlEwPeA00vXuaApiERMs8tw==
X-Received: by 2002:a24:f68c:: with SMTP id u134-v6mr3008581ith.85.1533666014988;
        Tue, 07 Aug 2018 11:20:14 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v23-v6sm562593iob.72.2018.08.07.11.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:20:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fn6ab-0007OF-2u; Tue, 07 Aug 2018 12:20:13 -0600
Date:   Tue, 7 Aug 2018 12:20:13 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com, flihp@twobit.us,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
Message-ID: <20180807182013.GC4960@ziepe.ca>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
 <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
 <1533596748.3159.19.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533596748.3159.19.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 04:05:48PM -0700, James Bottomley wrote:

> > @@ -118,25 +155,48 @@ ssize_t tpm_common_write(struct file *file,
> > const char __user *buf,
> >  	 * the char dev is held open.
> >  	 */
> >  	if (tpm_try_get_ops(priv->chip)) {
> > -		mutex_unlock(&priv->buffer_mutex);
> > -		return -EPIPE;
> > +		ret = -EPIPE;
> > +		goto out;
> >  	}
> > -	out_size = tpm_transmit(priv->chip, priv->space, priv-
> > >data_buffer,
> > -				sizeof(priv->data_buffer), 0);
> >  
> > -	tpm_put_ops(priv->chip);
> > -	if (out_size < 0) {
> > -		mutex_unlock(&priv->buffer_mutex);
> > -		return out_size;
> > +	/*
> > +	 * If in nonblocking mode schedule an async job to send
> > +	 * the command return the size.
> > +	 * In case of error the err code will be returned in
> > +	 * the subsequent read call.
> > +	 */
> > +	if (file->f_flags & O_NONBLOCK) {
> > +		queue_work(tpm_dev_wq, &priv->async_work);
> > +		return size;
> 
> Here you return holding the buffer_mutex, waiting for tpm_async_work to
> release it.

Doesn't lockdep complain when locks are left held after returning to
user space? Even if it doesn't, that is a pretty ugly thing to do.

Jason
