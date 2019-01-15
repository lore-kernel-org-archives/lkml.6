Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C3CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A520651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547544374;
	bh=upnb4znZQ7qQguBkYT5hcEwa5hM1vyNjelyUwydM7lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aqmw/pTUjPZsEO6eJhcD+WggqO4KcP+KkAegopp6RcLtseItyUzAVEn1BUfUENSkY
	 Lb45K3sC5Ao3l1O3pI7x0oDtUHwrF1MdLUxSoisbkTMNfTazep40I0YL/lwCEac7qG
	 7gL2p7xQxmURdHmFvQ6Qu1g0FeXvlwm6vyPyNMIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfAOJ0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:26:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36902 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfAOJ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:26:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so1708011ljd.4;
        Tue, 15 Jan 2019 01:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NzOXWx92iFVINbMVMujqRu+vpTLEDiqieBeoM58cn0o=;
        b=krm1xb+8dZ+mQgagI6M4HDLUmB80kO6cuyUyvY5BGbTxvDT4Rc2eE4F3gNEnk3DAy7
         EJNAvDYVeISKx+tw5LkghyvgtuH4kV0umvPmu9wyrhYpnziah/BFFeRhArZqTD6s+WvY
         LkgBmEyeVDwIVwkAX+WCaY0vW43WHrz1xFewOkq2s+oFGhNDq4BWVpVoY8nPr/LxhGxy
         VviS6s18LcmIdrqU0wYkX2vzWJquYcTMVHtE8twZmAF3ITl+q8brFyAUczaVUK4Vd1uh
         gYvMkiCbmLDqfCKxib4Q0X+9SHctjAPf/fpe7JKD4mftrQ7we00Spk14hGZDh78f6wqq
         OUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NzOXWx92iFVINbMVMujqRu+vpTLEDiqieBeoM58cn0o=;
        b=g9GtuQfaqgE8gG4Cglp6pPQv4Aa163jd1/eoGwkCw5rjhDHTbpVhxolBvuF4fyNGvg
         7r5rWqCiFPiBUCfDKjoEo7bAYy8bVBBrIli+Ag92foS7JWhQM8Ljqx2y8P4MLJ5NIoje
         89AImj2Y/9C+urVg4ZflIjLuSgYCsQkG2C74K2pzNF1R8PLBvJU+qQ6Dp6QgYKh4PJ+J
         XjeYSrXPkxbmHWjlLwEGS31kq9mhZ7SLncPqyI/B+dJHgRkUXLRo2yTlRyWsn/C50ZmZ
         YKYu6zWX0+p3u+OegvybWfnwfbhzKrMeblsTUSl5lqiAzw2Xl+061AHvJ2L/MDBOuOH1
         ensQ==
X-Gm-Message-State: AJcUukePuItIYggwe3YIvq/GLhIlcYpLc3iY5yMxZaJQmKz+pA6KX5WC
        cOIRapbp3+2GCg07anEwP9w=
X-Google-Smtp-Source: ALg8bN47DeBl9of7gfMP+X8fbk9hkiJ/5tQiX77i7sukRvMmzbnvYc485wfkXZZBNBN2kNTHVCgzhQ==
X-Received: by 2002:a2e:3218:: with SMTP id y24-v6mr2144023ljy.157.1547544369264;
        Tue, 15 Jan 2019 01:26:09 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b25-v6sm478626lji.94.2019.01.15.01.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 01:26:08 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gjKz1-0008WG-CC; Tue, 15 Jan 2019 10:26:08 +0100
Date:   Tue, 15 Jan 2019 10:26:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190115092607.GN3691@localhost>
References: <20190115085743.GL3691@localhost>
 <20190114194352.4579-1-pados@pados.hu>
 <15f71a61af66817847d4b11b9e2e60e8@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f71a61af66817847d4b11b9e2e60e8@pados.hu>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:17:58AM +0000, Karoly Pados wrote:
> > I think it's better to add the autopm call to gpio210x_gpio_get/set
> > only. This will allow for a simpler patch, and keeps the autopm handling
> > confined to the gpio paths.
> 
> I'll submit a v2.
> 
> >> @@ -1383,6 +1397,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int
> >> value)
> >> } else {
> >> u16 wIndex = buf.state << 8 | buf.mask;
> >> 
> >> + usb_autopm_get_interface(serial->interface);
> > 
> > Also make sure to always check for errors from autopm_get().
> 
> I checked everywhere else, the reason I didn't check here is on
> purpose based on your previous feedback. The caller function here
> doesn't have a return value, so the only way to return errors is to
> log, but in my last patch to ftdi_sio you made clear that errors from
> autopm_get shouldn't get logged. Trying to call usb_control_msg() even
> though the device could not wake does not cause issues, and the return
> value from usb_control_msg() clearly identifies the reason for failure
> (failure due to autosuspend), so error information is not lost either.
> So I thought not checking here has no real disadvantage and I still
> stay conformant to your previous guidance.

Ok, I understand your reasoning, but please do check for errors and bail
out early if autopm_get() fails. No need to log errors.

Thanks,
Johan
