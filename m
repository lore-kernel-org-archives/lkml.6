Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24189C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D6820676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGfsqCv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D6820676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeIYRHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:07:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38639 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeIYRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:07:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id z186-v6so19574071lfa.5;
        Tue, 25 Sep 2018 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5IAFwKcNSh3XLIp+fD5Uyt5iu/XlUnkr9LKi3c9Nz5c=;
        b=QGfsqCv8xi1ZzIY8Av9VHAluNfrUc0kZTUOuZCwnIfeWr6OmyhPcEfTVNY0lXJl9V4
         fWZKiAAZ9aD00KF//NMXhwVgIK9sTUwN70ZWKCD+ol+J7+U9SJvhASBX2apFqxVCikpI
         4JCJoLscsoPPmu2XUlLY6UD7zHlyd++gBvRBLILW7kMS+PYA1yxYESr9jFX+AuoEVvkf
         xxak6PKzsbjJZyB6jKTO/9Z8RtcAd95Q0jipFHmJKDu25lYSK78YP+R2nbxrszCvlfM9
         YDGioCC4/WnGOv/ZiYOjvLJ16co/uLgqGw/jrrCjZV4B0qmyIj6KTzhkqayy5lWhRNBO
         6F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5IAFwKcNSh3XLIp+fD5Uyt5iu/XlUnkr9LKi3c9Nz5c=;
        b=B0zK4NvwD9preD0oCggFcw0GvIIQc4/GkohhezEvjKfKvm3zYZ/gc/kF+m37ZKZTwo
         i28c8IMbKdrsAX0RVcjDYrDqL075PMbRcW2OETlviX4bEMkvoDqlg/2Xy04rFcwC555J
         h63SRpaCpOWklVPrITT160JbmA9sACQ8dpGReh4C8QY8vsSaQqsq/mmxyIaZj1eZstIl
         CWLbZK4PtRBkLvUw8UvDUXdvon9HPOYEm2YUuN/07kBmLrnwGrA2KBgd4BPNtgbh5hut
         KUJVnR0PN/Q7zCO6BBC713J1LI4EwdDGv55wSiuktTk/Ox/4Esv5ICBly8ZJwrfPT4YO
         6J6g==
X-Gm-Message-State: ABuFfogPyS46LSWIelsspse113TIwosSKCJ+LKVwUl/2XGpjpFxKf3wb
        sqGMB67A36tf0QvDwSqpYfc=
X-Google-Smtp-Source: ACcGV63NgJDNcA9cz3E/xK7WVvCt8koHY5khcJ1H66WIWp4vCctqUfKVaxMOj9TVj7qJDoF2EsRUCA==
X-Received: by 2002:a19:3bcf:: with SMTP id d76-v6mr395052lfl.126.1537873223290;
        Tue, 25 Sep 2018 04:00:23 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f4-v6sm361883lfm.85.2018.09.25.04.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:00:22 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g4l4n-0005mO-RR; Tue, 25 Sep 2018 13:00:21 +0200
Date:   Tue, 25 Sep 2018 13:00:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v6] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180925110021.GE3332@localhost>
References: <20180925100635.GC3332@localhost>
 <20180924143151.2273-1-pados@pados.hu>
 <e4a12a0856d083eed0994ab888bc8869@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a12a0856d083eed0994ab888bc8869@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:46:30AM +0000, Karoly Pados wrote:
> Hi,
> 
> >> +#if defined(CONFIG_GPIOLIB)
> >> +static const char * const ftdi_ftx_gpio_names[] = {
> >> + "CBUS0", "CBUS1", "CBUS2", "CBUS3"
> >> +};
> >> +#endif
> > 
> > We want to keep the ifdeffery to a minimum, so move this inside the
> > gpiolib ifdef below (and possibly even into the function where it is
> > used).
> > 
> > Also note that these names are shared with FT232R, but not with FT232H.
> > 
> 
> What naming do you suggest then?
> 
> My personal preference would be however to leave this name as is, because
> this patch only adds support for the FT-X. Even if support for others can 
> be added relatively trivially after this, there is explicitly no GPIO 
> support for FT232R *yet*. If somebody else adds GPIO support for the FT232R
> in a later patch, he/she should make corresponding adjustments themselves,
> including naming changes. IMHO.

Yes, that's perfectly fine. I was merely pointing it out as background
info which could possibly affect how you choose to address this (e.g.
moving it into the ftx function or not, but also that can be changed
later of course).

> >> + if (priv->gpio_output & BIT(gpio))
> >> + return 0;
> >> + else
> >> + return 1;
> > 
> > This could just simplified using negation (!), but perhaps this is
> > easier to parse as it stands.
> > 
> 
> Sorry, it is not clear what your preferred action here is. 
> So should I leave it as is then or not?

Just do

	res = !(priv->gpio_output & BIT(gpio));

And I think you should add locking here to.

Johan
