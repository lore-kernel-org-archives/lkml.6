Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E1ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32D820867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af/Isp8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32D820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeIRDxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:53:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37938 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeIRDxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:53:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so8073774plq.5;
        Mon, 17 Sep 2018 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eaekUQ9eV4wEvO33KdfURJwGZi80tEEamCz+pDEq8FY=;
        b=af/Isp8EW6XdbOX7rtm/6KwEc79E1YZgtjJ1lDb+9RVDo+xRM4onGP4QL+t5edi25q
         FHPCUudIcL5nmvuWBMVXxbBjECDnepb29+A5kHlzz0UGk1+e6Jwbt+k583uEe8uud25L
         EOhRu9cywhnuTeRQ5WA3LU37svbjHf7/o1m70m3249FbRclkdWKt+Aje1vuAyUR8Z33L
         MEnhey90VwXinMnDrPxJSCq1pVH3wDNyesahZfiq1Vlm4QQFIRtgZhtK3z/1B99q0amh
         SyuYHbRZ9pPfaIb/0UBqZ4hjLy8IF1Ff6P1mIcByvmlMuHGu15cJPKw+cJGxZ7fAqQCw
         RlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eaekUQ9eV4wEvO33KdfURJwGZi80tEEamCz+pDEq8FY=;
        b=A1xB0YO4dTYCH+p5IU3QNM8mJUy+h4rJpFaT8qQC+rPM3Dfv8UXbxemdvkXPl9m4ee
         /xgyVYxU5OPDftoTgvHC0OA7rGKmcj8M6WKXkJMVLKJC8BUXT7kzlwnV2NO8sZ3w284M
         +x7napzihiuB+EtGu2h4/5pk6nH66G+43JSqWeRWS6aPn75Eco6Lw+GLOfTB92wOOFB6
         O1vM+ZV4lbva6FZYKpRxpsoxD0aeLO8Jvqk+r7JIrGv5+9T6kzwnSf1ayIE08YFutgDz
         9xTGDtW3MiadIYr8H1JoGZj28ihTOUTADdS5wDvRdGeCxnQjB/zOKZlNDQIZDD5L7VK/
         Sr6w==
X-Gm-Message-State: APzg51Dq4NH4gMQoebGI8f2I81ZyrpuDkzxlYATP3v1KJICE74SGqwEG
        2jmCPrdCESxynfCp2mHzmBY=
X-Google-Smtp-Source: ANB0VdaLbxPtBI6l7mLhElBVVf6YhPWZhDDptpXL+0RgpPpqRaLJw1vK4kpnD/7y0uU36XGmJ7urIQ==
X-Received: by 2002:a17:902:8b8b:: with SMTP id ay11-v6mr26211982plb.1.1537223028691;
        Mon, 17 Sep 2018 15:23:48 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 8-v6sm18904083pgu.10.2018.09.17.15.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 15:23:47 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:23:45 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org,
        wsa@the-dreams.de, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Message-ID: <20180917222345.GA203020@dtor-ws>
References: <20180917052254.12336-1-andreas@kemnade.info>
 <20180917175131.GA104770@dtor-ws>
 <20180917205634.6a320cad@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917205634.6a320cad@aktux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 08:56:34PM +0200, Andreas Kemnade wrote:
> Hi Dmitry,
> 
> On Mon, 17 Sep 2018 10:51:31 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Andreas,
> > 
> > On Mon, Sep 17, 2018 at 07:22:54AM +0200, Andreas Kemnade wrote:
> > > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > > the counter will be incremented but the resume callback not called,
> > > so enumeration and charging will not start properly.
> > > To avoid that happen, wait and try again later.
> > > 
> > > Practically this happens when the device is woken up from suspend by
> > > plugging in usb.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
> > > index a44680d64f9b..1f3cf4e48383 100644
> > > --- a/drivers/phy/ti/phy-twl4030-usb.c
> > > +++ b/drivers/phy/ti/phy-twl4030-usb.c
> > > @@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
> > >  
> > >  	status = twl4030_usb_linkstat(twl);
> > >  
> > > +	/* we might get here too early when runtime is not ready yet
> > > +	 * and we will get an EACCESS later, so try again later
> > > +	 */  
> > 
> > How exactly can this happen? What disables (and later re-enables)
> > runtime PM? 
> If the whole resume process is started by plugging in usb, the
> interrupt will be triggered still in the resume process so that 
> runtime resume is not yet possible, pm_runtime_get_sync() returns
> EACCESS

I see. This all seems a bit wonky, to be honest. I would expect that the
driver would have a suspend routine that disables interrupt and also
configure interrupt for wakeup (enable_irq_wake) and kick bus scanning
from there instead of aborting interrupt handler...

> 
> > How can we guarantee that the interrupt will be
> > re-triggered?
> > 
> The interrupt will not be re-triggered but the handler will be
> called at some other places...
> 
> > > +	if (!pm_runtime_enabled(twl->dev)) {
> > > +		cancel_delayed_work(&twl->id_workaround_work);
> > > +		schedule_delayed_work(&twl->id_workaround_work, HZ);
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> ... for example by this delayed work which is already there.

If we decide to keep this, it should be mod_delayed_work() I think.

Thanks.

-- 
Dmitry
