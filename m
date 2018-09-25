Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884C7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3765420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N23GchDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3765420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeIYQWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:22:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43355 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYQWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:22:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id x24-v6so19424866lfe.10;
        Tue, 25 Sep 2018 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GjXvj9uYdDfvQGceZjGoJR2VJkgyZdNrVxwfz5vNECM=;
        b=N23GchDr58w13aUXUiqn8mhnzVzLcCfV40L+co5PfB5vtSMFZXh1I0onB4lOkFXXMf
         QsiO8EhL5Nl/1UeTcK+lHVURXIOdaHU0Ks8C6LZhdGspwM4Z8JymLcyShDrYe3cGxM1Y
         XgbYClfDnlKZM2+7wggm9xU1O+/X2eZBeFemeXpcTqiSqjz5aN4LJXz4DCk0IUem0HZl
         wIWIHAOrFHmhltDWUJsoUnrtAytw2EaMDLxbtI1yOnI68L6RzO2qZlI2yKul8egm8F9h
         c8ILlgtnUAf/NjuaVBNRAkGJMUE123MKeHdapNMCPDcuJ9ZIZwRbhuTBDtgj/GnC2Q+d
         YW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjXvj9uYdDfvQGceZjGoJR2VJkgyZdNrVxwfz5vNECM=;
        b=MabFdtuVOyN+RRt0L629yRyLyv/pHpMQWNpJ/wAkdhOyidsvZsEbpFBdEk2mGA5LfV
         iNnS6wVEHRegnyAA68TGmcQMyI3g91xhaaKTyQ5XZp0dmlK21Suhtve1oEzoB1rOqW+Q
         DVS6KfKnqC0QjMKQXreqdviDDNO+/tPdrXkaIGfcxiiF64mTPnS1FOqbt9mHeIn7RQCc
         JdP/kItYbK/luzlVP/jiDtqwG52qI5CqP/WpXAsn7luqheZLIoBolecSauTUmzBUYmkd
         th1cVTZM0A41Pomx/5W34TingxTDTtcRCOjoWTHsKl6tJf7rBxd3ZBhyhiUkMwL3BLL0
         +Wsw==
X-Gm-Message-State: ABuFfogossnupNsJ0IdoZTACgYT82ZQQCFM55AGT7li8hkasnjPlibs1
        2TzTykcUjdUGKdzbuamoxeo=
X-Google-Smtp-Source: ACcGV62z7Lw8xXw2ugJDpHUQIkTNHrAkLr5BAgYZN+zzFnzqgKxeP73LM58q2oVJFAda+71wM/PYQQ==
X-Received: by 2002:a19:1603:: with SMTP id m3-v6mr272916lfi.82.1537870524588;
        Tue, 25 Sep 2018 03:15:24 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t2-v6sm329033ljj.46.2018.09.25.03.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 03:15:23 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g4kNH-0005e5-1F; Tue, 25 Sep 2018 12:15:23 +0200
Date:   Tue, 25 Sep 2018 12:15:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v6] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180925101523.GD3332@localhost>
References: <20180924143151.2273-1-pados@pados.hu>
 <20180925100635.GC3332@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925100635.GC3332@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:06:35PM +0200, Johan Hovold wrote:
> On Mon, Sep 24, 2018 at 04:31:51PM +0200, Karoly Pados wrote:

> > +static void ftdi_gpio_set_multiple(struct gpio_chip *gc,
> > +				   unsigned long *mask, unsigned long *bits)
> > +{
> > +	struct usb_serial_port *port = gpiochip_get_data(gc);
> > +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> > +
> > +	mutex_lock(&priv->gpio_lock);
> > +
> > +	priv->gpio_value &= ~(*mask);
> > +	priv->gpio_value |= *bits;
> 
> gpiolib doesn't clear bits not in mask for you, so you need to OR with
> *mask here to avoid setting random other bits.

That was of course meant to be: *AND* with *mask.

Johan
