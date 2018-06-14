Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8EC02C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF0208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxyY6477"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEF0208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbeFNH6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:58:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37892 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeFNH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:58:16 -0400
Received: by mail-lf0-f67.google.com with SMTP id i83-v6so7937657lfh.5;
        Thu, 14 Jun 2018 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m66ozvjXS1bhpyzjxuKLPdcWUZiSarME8fwDzGG9uuo=;
        b=DxyY6477nLx+hCPhe+puYnneMUHnaNYZlNDVF5RNbZ1X1YzqcLHlKKPM8IeisHeZ+3
         eeFHY7gME3ONMhsWNpkvkooSBQvkFoVR/Jc5hprbGQj68X3vnWwhvB4xK6r/94FXsylB
         Ts8vL6ZTgJwYnVaeBJj6KN5/286imU0XTnlC3Pm0Z/lgFjEAS5jKbRT0LSueyLwifTz9
         7IiiIkFwh5d752ssd8mStb7cJs6AH1FLu/MrSxqQYlOKR+cZ5sUL/buaPI+0TAJLG35M
         MiOihdDoMWvcfMurUp7krwNYzu0MQhBM+1mO9hP/oPnBZkDZ6SEKPLno3lNkp1ysnpQ+
         dUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m66ozvjXS1bhpyzjxuKLPdcWUZiSarME8fwDzGG9uuo=;
        b=hh2+vxR7FStSiuoyvBWA2PA6z71qSrViUdGR0PN03k0t1omZfFSAAD2WGfrTSBE/xd
         OQTxIXPqJ34KDRj3FZNQ164CsJ3boGsscf8TyLYk/23LU04rJGAIN2RzLSXzpzgjkwdX
         RsBJh+iEO/WTR52A8f5lmcc9eMSGLeJRnU+ABAdXnhVjUADYqdU4X0giJkLEcHCkte7O
         LNkYR3M+6N6Zb/a4lcy6MjMD4921Y91zfuuBXhKOZhJnSJeLg7MlXmFkEzPsA+iopIUl
         TYtAV2R9Sxkp2RhsA593QrWxv6652t/0D+nM51hZxY9Gc8YtxnacS362J5XH1cyrsI4m
         +Vcw==
X-Gm-Message-State: APt69E1rGvZEvVMdzC0g2O1+lmr/KksC0FsIMQ/1E7MefM7exTqYzFWf
        g5YGQVY3OudS5N2JCe14RX7n3vOy
X-Google-Smtp-Source: ADUXVKLiMi0RTdYoZc6f7YHuQzp3ySGk2xVZ9rqaJ2//oNQ6/b/sg5dh07qOv92Tqb+2q8QD5OokGw==
X-Received: by 2002:a19:cc4b:: with SMTP id c72-v6mr5478528lfg.30.1528963095305;
        Thu, 14 Jun 2018 00:58:15 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id r84-v6sm840564ljb.24.2018.06.14.00.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 00:58:14 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fTN8i-0005oP-59; Thu, 14 Jun 2018 09:57:52 +0200
Date:   Thu, 14 Jun 2018 09:57:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        "Gerlach, Dave" <d-gerlach@ti.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] usb: dwc3: of_simple: don't call
 pm_runtime_set_active()
Message-ID: <20180614075752.GB32411@localhost>
References: <1527518174-27860-1-git-send-email-rogerq@ti.com>
 <1527518174-27860-2-git-send-email-rogerq@ti.com>
 <87k1rlcok2.fsf@linux.intel.com>
 <d6015f73-358b-1f96-2682-8cbe2423960a@ti.com>
 <87bmcwcl1j.fsf@linux.intel.com>
 <4a4fd59c-84a6-61c6-5567-50660b07302a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a4fd59c-84a6-61c6-5567-50660b07302a@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:15:11PM +0300, Roger Quadros wrote:
> On 31/05/18 10:59, Felipe Balbi wrote:
> > 
> > Hi,
> > 
> > Roger Quadros <rogerq@ti.com> writes:
> > 
> >> On 30/05/18 15:31, Felipe Balbi wrote:
> >>> Roger Quadros <rogerq@ti.com> writes:
> >>>
> >>>> Don't call pm_runtime_set_active() as it will prevent the device
> >>>> from being activated in the next pm_runtime_get_sync() call.
> >>>>
> >>>> Also call pm_runtime_get_sync() before of_platform_populate().
> >>>>
> >>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >>>
> >>> This patch is wrong.
> >>>
> >>>> ---
> >>>>  drivers/usb/dwc3/dwc3-of-simple.c | 7 +++----
> >>>>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> >>>> index e98d221..2cbb5c0 100644
> >>>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> >>>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> >>>> @@ -121,6 +121,9 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
> >>>>  	if (ret)
> >>>>  		goto err_resetc_assert;
> >>>>  
> >>>> +	pm_runtime_enable(dev);
> >>>> +	pm_runtime_get_sync(dev);
> >>>
> >>> No, this is the wrong way to do things. My device should be enabled
> >>> already from probe, specially since I have already enabled clocks.
> >>
> >> As far as I understood just enabling clocks (which might not
> >> include bus clock) doesn't ensure device is enabled.

In general, that cannot be assumed no. Specifically, this cannot
currently be assumed for OMAP due to how its power domain has been
implemented.

> >> Did you mean that I don't need to do a pm_runtime_get_sync() to
> >> enable my device in probe?
> >> Who is enabling by device for me then? Is device core supposed to
> >> do it?

Driver core calls the power domain activate() callback before probe, but
OMAP does not implement that callback. So you're right that you
currently need a pm_runtime_get_sync() in probe instead of setting
status active explicitly as the OMAP pm domain will not enable the bus
clock otherwise.

You still need to deal with the current driver explicit clock enable if
you want to change this, though.

Johan
