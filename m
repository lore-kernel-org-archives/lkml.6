Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8725C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896D9214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIU2qbii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896D9214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbeIRW3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:29:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:29:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so1292234pfo.12;
        Tue, 18 Sep 2018 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v9yxKlhdbAJO33IdLZGWGHGBz2zpZVT7MlHi2+CTTkY=;
        b=oIU2qbiiN4AXM2axSYWJbwrtwBXw0FnvrMX/NsrkuoKDz7m8PcdlkxQT5AEkMzSbZP
         TRMNjAjGU/Aix1e5SnzqHp17k7bNVzcuglGBgXI5cHZFWWRna2DlZUvyEPmyzwWlZ4+6
         lRKZsx10FjAK6GuXcsSb+rQKPm1y50f3/ylHB+gOlzjIIDSOrA32LwRWnsoVsn9vfrbx
         QlinvffQ8mkOzsxxpZZ6fhXbnn5ZfA/AkoVCkAivQ3Y/KuevILdzG5SRVfqRsmK3s1cZ
         sWumk/vZsU1detur9vT+xqLkRnT8XWpyK3E6xCWr26EiR4LcApSj7Rlo0X6rKjqP0BzH
         QC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v9yxKlhdbAJO33IdLZGWGHGBz2zpZVT7MlHi2+CTTkY=;
        b=jlMUBm2/Ki2BHE8Z/b1+IDTwxUt0T8ywffiA8LRpAOUA+0t1UVYgiFaZ5M4PoWLckr
         u8Hwr/ImRjwXYZbiezL9XGXlejnYu5XzNJFtsQMydzDH/aLWX2k+Yif4FXNbieZv6zV4
         HmdypVpQ5ZriLB9b27n9tTo3i18Il6cwO3noSjGeKy1J0C8ykTmL+TcU40olLdmOf84K
         zOFocMS/sMArvLR976pznRI0HK8+tAPyRE9mZ9VYx/ZET7VH5vfAxDTnh0jR8+wa+QiJ
         Z7UwpJ/eHspX6KuDwsTpAQWm8P2FHJfCEEIjmpflACOoB39ua8speQU+kbTIIsjLJfnf
         iUhw==
X-Gm-Message-State: APzg51AcbuybxGV/ZqQLoYp/GodZvSpS6OOJJT89BSqJaKsfQj8hr0po
        ISbmNsX1kLChxBb4w3Ltfjs=
X-Google-Smtp-Source: ANB0VdaY+q3ZANxh7KvGQ3khaJcFlpJcMi8ot6csrHgZZSG8Yp26fTT9LARE6I+hHaEFGVvVmdD2cw==
X-Received: by 2002:a62:4808:: with SMTP id v8-v6mr32005405pfa.89.1537289787691;
        Tue, 18 Sep 2018 09:56:27 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f87-v6sm49888090pfh.168.2018.09.18.09.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 09:56:26 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:56:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org,
        wsa@the-dreams.de, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Message-ID: <20180918165624.GB177805@dtor-ws>
References: <20180917052254.12336-1-andreas@kemnade.info>
 <20180917175131.GA104770@dtor-ws>
 <20180917205634.6a320cad@aktux>
 <20180917222345.GA203020@dtor-ws>
 <20180918181619.2e266f0d@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918181619.2e266f0d@aktux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 06:16:19PM +0200, Andreas Kemnade wrote:
> Hi,
> 
> On Mon, 17 Sep 2018 15:23:45 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Mon, Sep 17, 2018 at 08:56:34PM +0200, Andreas Kemnade wrote:
> > > Hi Dmitry,
> > > 
> > > On Mon, 17 Sep 2018 10:51:31 -0700
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >   
> > > > Hi Andreas,
> > > > 
> > > > On Mon, Sep 17, 2018 at 07:22:54AM +0200, Andreas Kemnade wrote:  
> > > > > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > > > > the counter will be incremented but the resume callback not called,
> > > > > so enumeration and charging will not start properly.
> > > > > To avoid that happen, wait and try again later.
> > > > > 
> > > > > Practically this happens when the device is woken up from suspend by
> > > > > plugging in usb.
> > > > > 
> > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > ---
> > > > >  drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
> > > > > index a44680d64f9b..1f3cf4e48383 100644
> > > > > --- a/drivers/phy/ti/phy-twl4030-usb.c
> > > > > +++ b/drivers/phy/ti/phy-twl4030-usb.c
> > > > > @@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
> > > > >  
> > > > >  	status = twl4030_usb_linkstat(twl);
> > > > >  
> > > > > +	/* we might get here too early when runtime is not ready yet
> > > > > +	 * and we will get an EACCESS later, so try again later
> > > > > +	 */    
> > > > 
> > > > How exactly can this happen? What disables (and later re-enables)
> > > > runtime PM?   
> > > If the whole resume process is started by plugging in usb, the
> > > interrupt will be triggered still in the resume process so that 
> > > runtime resume is not yet possible, pm_runtime_get_sync() returns
> > > EACCESS  
> > 
> > I see. This all seems a bit wonky, to be honest. I would expect that the
> > driver would have a suspend routine that disables interrupt and also
> > configure interrupt for wakeup (enable_irq_wake) and kick bus scanning
> > from there instead of aborting interrupt handler...
> > 
> well, that seems doable. So there will be a v2.
> 
> > >   
> > > > How can we guarantee that the interrupt will be
> > > > re-triggered?
> > > >   
> > > The interrupt will not be re-triggered but the handler will be
> > > called at some other places...
> > >   
> > > > > +	if (!pm_runtime_enabled(twl->dev)) {
> > > > > +		cancel_delayed_work(&twl->id_workaround_work);
> > > > > +		schedule_delayed_work(&twl->id_workaround_work, HZ);
> > > > > +		return IRQ_HANDLED;
> > > > > +	}
> > > > > +  
> > > ... for example by this delayed work which is already there.  
> > 
> > If we decide to keep this, it should be mod_delayed_work() I think.
> > 
> Well, is that valid for the other uses of id_workaround_work() (which
> are clearly required)? So there should be a second, independent
> cleanup patch for the existing uses?

Yes, mod_delayed_work() is replacement for cancel + reschedule. I guess
this driver was created before mod_delayed_work() was added to the
kernel.

Thanks.

-- 
Dmitry
