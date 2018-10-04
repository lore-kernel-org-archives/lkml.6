Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC78C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33802084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2rYECgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33802084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJEEmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:42:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52665 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeJEEmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:42:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so33693wmw.2;
        Thu, 04 Oct 2018 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u2KpLHr2vlE5br7zxzrOEp0JaZBnE5TCghydrlSZ+gY=;
        b=j2rYECgErMVUk7CK7IILhsJdodSc6/e8c64nDrdRSx7b2CBntGVcCh8DxkzoymsSJ9
         VB0FUM0l3HFxn71YAyJOvr9yG3goDKMBQxwSKR8WHIlbV9kd2I7pvjUoqVbDJMdxW+6P
         duefF6cz4LR33/+Vvk3a4cigpUWLrPTaaYn8lDf4D45qcD44vREStFShru006TX7hk1P
         ZhTfE3WuJf1OC3/LpB/mZb+NPTv1wDWWWVT6UggHtFV/asaY5Oq5owLiX8Ue3/MNY1CW
         EyzUBO5BgeCzqvGH3Nmzo5CpDRmSloe4fMfe/YdhSO7tkynPiQDe4zDEJdGGQ7bEdRBH
         jydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u2KpLHr2vlE5br7zxzrOEp0JaZBnE5TCghydrlSZ+gY=;
        b=OvEqfh40qHgDmvhtOI0+KLeFJymlOt5S+kY19Hku2rh6NGTxBtxMtRfMxRUmK3K57r
         BOHaw7CBedwSanyx36ilWfKAaa5tQfA7tmU/d+jFptR22DKlhlgwvlqpuCD2hQD4e8Ui
         /GIPav2PLL6h59ASBLCUjPCYdLutbzysKu4LLEyLSPVcIvIVgtasDCMRQTFA3QkAPXCI
         ILWLeqLwwEAAmpIWHn3GMvApwXsE0OiYroHX9+zEMa4CmejHEcD502zWLVxV+zUwIgQ+
         1ZBBzaJxo5UcbNZf4i9kiFHcoPFHWIq/aebmS1A3oyQgYs60pBT3bGzR0mY5VnetA7h+
         8EqA==
X-Gm-Message-State: ABuFfog8R1pd8E2x1xr04OUzxg7RhV59+s7uWepE6P16u3+3uUS90otT
        ueGZ5KBCPA4mTSFE1XUb/AM=
X-Google-Smtp-Source: ACcGV63DG+vlm595aTIrDmYKnCq+3JTIXvMv1yMe3qXsXM2tgsxdjOq/RubamzcxSDp0Qy+U7SMkRQ==
X-Received: by 2002:a1c:2052:: with SMTP id g79-v6mr6186917wmg.42.1538689607867;
        Thu, 04 Oct 2018 14:46:47 -0700 (PDT)
Received: from Ettosoft-T55 (208-202-243-213.terrecablate.net. [213.243.202.208])
        by smtp.gmail.com with ESMTPSA id l38-v6sm6200695wre.38.2018.10.04.14.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 14:46:47 -0700 (PDT)
Date:   Thu, 4 Oct 2018 23:46:45 +0200
From:   ektor5 <ek5.chimenti@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     hverkuil@xs4all.nl, luca.pisani@udoo.org, jose.abreu@synopsys.com,
        sakari.ailus@linux.intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 2/2] seco-cec: add Consumer-IR support
Message-ID: <20181004214643.4flghzsjrczmwpjd@Ettosoft-T55>
References: <cover.1538474121.git.ek5.chimenti@gmail.com>
 <beeab2fa9a2906ecaebb225dc88ca4c0c88dd14b.1538474121.git.ek5.chimenti@gmail.com>
 <20181004134927.ox7alorufq56f2ux@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004134927.ox7alorufq56f2ux@gofer.mess.org>
User-Agent: NeoMutt/20180716-421-ff8684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Thu, Oct 04, 2018 at 02:49:27PM +0100, Sean Young wrote:
> On Tue, Oct 02, 2018 at 06:59:56PM +0200, ektor5 wrote:
> > From: Ettore Chimenti <ek5.chimenti@gmail.com>
> > 
> > Introduce support for Consumer-IR into seco-cec driver, as it shares the
> > same interrupt for receiving messages.
> > The device decodes RC5 signals only, defaults to hauppauge mapping.
> > It will spawn an input interface using the RC framework (like CEC
> > device).
> > 
> > Signed-off-by: Ettore Chimenti <ek5.chimenti@gmail.com>
> > ---
> >  drivers/media/platform/Kconfig             |  10 ++
> >  drivers/media/platform/seco-cec/seco-cec.c | 136 ++++++++++++++++++++-
> >  drivers/media/platform/seco-cec/seco-cec.h |  11 ++
> >  3 files changed, 154 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index f477764b902a..5833f488eef8 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -624,6 +624,16 @@ config VIDEO_SECO_CEC
> >           CEC bus is present in the HDMI connector and enables communication
> >           between compatible devices.
> >  
> > +config VIDEO_SECO_RC
> > +       bool "SECO Boards IR RC5 support"
> > +       depends on VIDEO_SECO_CEC
> > +       select RC_CORE
> > +       help
> > +	 If you say yes here you will get support for the
> > +	 SECO Boards Consumer-IR in seco-cec driver.
> > +         The embedded controller supports RC5 protocol only, default mapping
> > +         is set to rc-hauppauge.
> 
> Strange mixture of spaces/tabs.

Ops. Yes, will fix.

> 
> > +
> >  endif #CEC_PLATFORM_DRIVERS
> >  
> >  menuconfig SDR_PLATFORM_DRIVERS
> > diff --git a/drivers/media/platform/seco-cec/seco-cec.c b/drivers/media/platform/seco-cec/seco-cec.c
> > index ba3b7c144a87..ee1949395cf4 100644
> > --- a/drivers/media/platform/seco-cec/seco-cec.c
> > +++ b/drivers/media/platform/seco-cec/seco-cec.c
> > @@ -28,6 +28,9 @@ struct secocec_data {
> >  	struct platform_device *pdev;
> >  	struct cec_adapter *cec_adap;
> >  	struct cec_notifier *notifier;
> > +	struct rc_dev *irda_rc;
> > +	char irda_input_name[32];
> > +	char irda_input_phys[32];
> 
> IrDA is a completely different encoding than RC-5, CIR or anything rc-core
> supports; RC-5 is much lower transmission speed. Please do not conflate
> the two, and rename it either ir_input_phys or rc_input_phys (same for the
> rest of the functions/members in the rest of the file).

Yes, I figured out that in the middle of developing. I got rid of most
of the "irda" references, but I have accidentally left some of them.
Will finish the work.

> 
> >  	int irq;
> >  };
> >  
> > @@ -383,6 +386,119 @@ struct cec_adap_ops secocec_cec_adap_ops = {
> >  	.adap_transmit = secocec_adap_transmit,
> >  };
> >  
> > +#ifdef CONFIG_VIDEO_SECO_RC
> > +static int secocec_irda_probe(void *priv)
> > +{
> > +	struct secocec_data *cec = priv;
> > +	struct device *dev = cec->dev;
> > +	int status;
> > +	u16 val;
> > +
> > +	/* Prepare the RC input device */
> > +	cec->irda_rc = devm_rc_allocate_device(dev, RC_DRIVER_SCANCODE);
> > +	if (!cec->irda_rc) {
> > +		dev_err(dev, "Failed to allocate memory for rc_dev");
> 
> No need to dev_err() here, kmalloc() will have already reported the error.

Ok, will remove.

> 
> > +		return -ENOMEM;
> > +	}
> > +
> > +	snprintf(cec->irda_input_name, sizeof(cec->irda_input_name),
> > +		 "IrDA RC for %s", dev_name(dev));
> 
> Since it's an RC device there is no need to put RC in the name. Just
> use dev_name() as the device_name.

I took that from CEC RC Passthrough device name.

> 
> > +	snprintf(cec->irda_input_phys, sizeof(cec->irda_input_phys),
> > +		 "%s/input0", dev_name(dev));
> > +
> > +	cec->irda_rc->device_name = cec->irda_input_name;
> > +	cec->irda_rc->input_phys = cec->irda_input_phys;
> > +	cec->irda_rc->input_id.bustype = BUS_HOST;
> > +	cec->irda_rc->input_id.vendor = 0;
> > +	cec->irda_rc->input_id.product = 0;
> > +	cec->irda_rc->input_id.version = 1;
> > +	cec->irda_rc->driver_name = SECOCEC_DEV_NAME;
> > +	cec->irda_rc->allowed_protocols = RC_PROTO_BIT_RC5;
> > +	cec->irda_rc->enabled_protocols = RC_PROTO_BIT_RC5;
> 
> No need to set enabled_protocols.

Ok.

> 
> > +	cec->irda_rc->priv = cec;
> > +	cec->irda_rc->map_name = RC_MAP_HAUPPAUGE;
> > +	cec->irda_rc->timeout = MS_TO_NS(100);
> > +
> > +	/* Clear the status register */
> > +	status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
> > +	if (status != 0)
> > +		goto err;
> > +
> > +	status = smb_wr16(SECOCEC_STATUS_REG_1, val);
> > +	if (status != 0)
> > +		goto err;
> > +
> > +	/* Enable the interrupts */
> > +	status = smb_rd16(SECOCEC_ENABLE_REG_1, &val);
> > +	if (status != 0)
> > +		goto err;
> > +
> > +	status = smb_wr16(SECOCEC_ENABLE_REG_1,
> > +			  val | SECOCEC_ENABLE_REG_1_IR);
> > +	if (status != 0)
> > +		goto err;
> > +
> > +	dev_dbg(dev, "IR enabled");
> > +
> > +	status = devm_rc_register_device(dev, cec->irda_rc);
> > +
> > +	if (status) {
> > +		dev_err(dev, "Failed to prepare input device");
> > +		cec->irda_rc = NULL;
> > +		goto err;
> > +	}
> > +
> > +	return 0;
> > +
> > +err:
> > +	smb_rd16(SECOCEC_ENABLE_REG_1, &val);
> > +
> > +	smb_wr16(SECOCEC_ENABLE_REG_1,
> > +		 val & ~SECOCEC_ENABLE_REG_1_IR);
> > +
> > +	dev_dbg(dev, "IR disabled");
> > +	return status;
> > +}
> > +
> > +static int secocec_irda_rx(struct secocec_data *priv)
> > +{
> > +	struct secocec_data *cec = priv;
> > +	struct device *dev = cec->dev;
> > +	u16 val, status, key, addr, toggle;
> > +
> > +	if (!cec->irda_rc)
> > +		return -ENODEV;
> > +
> > +	status = smb_rd16(SECOCEC_IR_READ_DATA, &val);
> > +	if (status != 0)
> > +		goto err;
> > +
> > +	key = val & SECOCEC_IR_COMMAND_MASK;
> > +	addr = (val & SECOCEC_IR_ADDRESS_MASK) >> SECOCEC_IR_ADDRESS_SHL;
> > +	toggle = (val & SECOCEC_IR_TOGGLE_MASK) >> SECOCEC_IR_TOGGLE_SHL;
> > +
> > +	rc_keydown(cec->irda_rc, RC_PROTO_RC5, key, toggle);
> 
> Here you are just reported the key, not the address. Please use:
> 
> 	rc_keydown(cec->rc, RC_PROTO_RC5, RC_SCANCODE_RC5(addr, key), toggle);
> 
> In fact, you could do:
> 
> 	rc_keydown(cec->rc, RC_PROTO_RC5, val & 0x1f7f, toggle);
> 
> I presume the compile is clever enough to fold those shift instructions.

I wondered why the address wasn't used, it had to be together. Thanks. :)

> 
> > +
> > +	dev_dbg(dev, "IR key pressed: 0x%02x addr 0x%02x toggle 0x%02x", key,
> > +		addr, toggle);
> > +
> > +	return 0;
> > +
> > +err:
> > +	dev_err(dev, "IR Receive message failed (%d)", status);
> > +	return -EIO;
> > +}
> > +#else
> > +static void secocec_irda_rx(struct secocec_data *priv)
> > +{
> > +}
> > +
> > +static int secocec_irda_probe(void *priv)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  static irqreturn_t secocec_irq_handler(int irq, void *priv)
> >  {
> >  	struct secocec_data *cec = priv;
> > @@ -420,7 +536,8 @@ static irqreturn_t secocec_irq_handler(int irq, void *priv)
> >  	if (status_val & SECOCEC_STATUS_REG_1_IR) {
> >  		dev_dbg(dev, "IR RC5 Interrupt Caught");
> >  		val |= SECOCEC_STATUS_REG_1_IR;
> > -		/* TODO IRDA RX */
> > +
> > +		secocec_irda_rx(cec);
> >  	}
> >  
> >  	/*  Reset status register */
> > @@ -595,6 +712,10 @@ static int secocec_probe(struct platform_device *pdev)
> >  	if (secocec->notifier)
> >  		cec_register_cec_notifier(secocec->cec_adap, secocec->notifier);
> >  
> > +	ret = secocec_irda_probe(secocec);
> > +	if (ret)
> > +		goto err_delete_adapter;
> > +
> >  	platform_set_drvdata(pdev, secocec);
> >  
> >  	dev_dbg(dev, "Device registered");
> > @@ -614,7 +735,16 @@ static int secocec_probe(struct platform_device *pdev)
> >  static int secocec_remove(struct platform_device *pdev)
> >  {
> >  	struct secocec_data *secocec = platform_get_drvdata(pdev);
> > +	u16 val;
> > +
> > +	if (secocec->irda_rc) {
> > +		smb_rd16(SECOCEC_ENABLE_REG_1, &val);
> >  
> > +		smb_wr16(SECOCEC_ENABLE_REG_1,
> > +			 val & ~SECOCEC_ENABLE_REG_1_IR);
> 
> Those two fit on one line.
> 
> > +
> > +		dev_dbg(&pdev->dev, "IR disabled");
> > +	}
> >  	cec_unregister_adapter(secocec->cec_adap);
> >  
> >  	if (secocec->notifier)
> > @@ -632,8 +762,8 @@ static int secocec_remove(struct platform_device *pdev)
> >  #ifdef CONFIG_PM_SLEEP
> >  static int secocec_suspend(struct device *dev)
> >  {
> > -	u16 val;
> >  	int status;
> > +	u16 val;
> >  
> >  	dev_dbg(dev, "Device going to suspend, disabling");
> >  
> > @@ -665,8 +795,8 @@ static int secocec_suspend(struct device *dev)
> >  
> >  static int secocec_resume(struct device *dev)
> >  {
> > -	u16 val;
> >  	int status;
> > +	u16 val;
> >  
> >  	dev_dbg(dev, "Resuming device from suspend");
> >  
> > diff --git a/drivers/media/platform/seco-cec/seco-cec.h b/drivers/media/platform/seco-cec/seco-cec.h
> > index cc7f0cba8e9e..c00660104a3e 100644
> > --- a/drivers/media/platform/seco-cec/seco-cec.h
> > +++ b/drivers/media/platform/seco-cec/seco-cec.h
> > @@ -101,6 +101,17 @@
> >  
> >  #define SECOCEC_IR_READ_DATA		0x3e
> >  
> > +/*
> > + * IR
> > + */
> > +
> > +#define SECOCEC_IR_COMMAND_MASK		0x007F
> > +#define SECOCEC_IR_COMMAND_SHL		0
> > +#define SECOCEC_IR_ADDRESS_MASK		0x1F00
> > +#define SECOCEC_IR_ADDRESS_SHL		7
> > +#define SECOCEC_IR_TOGGLE_MASK		0x8000
> > +#define SECOCEC_IR_TOGGLE_SHL		15
> > +
> >  /*
> >   * Enabling register
> >   */
> > -- 
> > 2.18.0
> 
> Thanks,
> Sean

Thanks a lot,
	Ettore
