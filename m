Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD28C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEE820869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2ePuyZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEE820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJPVZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:25:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33408 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeJPVZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:25:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so20925359ljz.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ilSKTIHNrFgTNNUmmNh0o6KWqQdusr0cIfTck96jS4g=;
        b=i2ePuyZX4B6qwbmkOD4uw+QJ5s7kdVP3ODm2AgaEtGSwPMsKz9OKTDgUvvo6JKQpNL
         GZgOs215jwl5ILcm4Fnx1dTeiSdaNhi12CsXvYuW59O8DTmmKSIF294Zd+gD6OTbf/9F
         texoWz+9a/2aDji2CiE7gGmtgV1zn2sA00WOP/3RsUN6TaV2dqAMlQixTyxG1j4LIL9z
         SzfEVJmrPD5gbWrEfDIvDFolh0O+uvviKzK6HO34Q+lx9mXkT7TgAjqhOORMp0MBnSDx
         pMF83ei+5Io8tVfHOS3D9lbkBbALJYc05MOxZVYKHhfgmeMfd0Hr9dWEOX2UN0tiQeBL
         sJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ilSKTIHNrFgTNNUmmNh0o6KWqQdusr0cIfTck96jS4g=;
        b=Rcb+zB9JDfhHeTJOhhSmgr1E21h45FWwsp7NFmvQ5LBSeBgJwcTTeJiMByIkXMhNWv
         c5w2VhpmI1R3MXA/EOsFfrnDp5HuQcC9TeK0pX+KXtqfuXWZhPb3CSdsEvw8vBO3g8y9
         YIizBuvk+SIWawfsdPaBAHGiOekvfyDskaxol/UjFpqn/4Ge0Edw7O5jqoIgfe3uiUDv
         MEq05+Ng2nXJPmYjEtq33rOGpr7Vfi1owdoHthTJXW/L2QUaaWdSn8tJ/6l4GK9YQcJk
         mTXXwaMP7nrz6drOiNdVnmjQ0QLNr7H5VqQp/WZQQAsaM6KfwakTR+1noiQ0gRDKXSL8
         M1Gg==
X-Gm-Message-State: ABuFfoj+BqDQQVqMNl3T2slTCim+MFbul85xWoi3q4rAbi840Nfyjaf+
        9CdqL7pTKu6pn/Nt++lTPH4=
X-Google-Smtp-Source: ACcGV61F7feOnoc0qaBNWDlCr68X5afA3KbH916o/Xn8WpAuh1m6k2Ec2CdrudKyVr+iBYl/nWgB+w==
X-Received: by 2002:a2e:9955:: with SMTP id r21-v6mr13263285ljj.5.1539696894036;
        Tue, 16 Oct 2018 06:34:54 -0700 (PDT)
Received: from metis.ciupak.eu ([31.130.108.122])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2981999lfc.47.2018.10.16.06.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 06:34:53 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:39:15 +0200
From:   Marcin Ciupak <marcin.s.ciupak@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: add nrf24 driver
Message-ID: <20181016153915.uknqmey6ko2ldnbw@metis.ciupak.eu>
References: <20181016101747.ex6ftchhsiyzdjti@metis.ciupak.eu>
 <20181016114150.2acsbpluwqe6d4l3@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016114150.2acsbpluwqe6d4l3@mwanda>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:41:50PM +0300, Dan Carpenter wrote:
> When we add drivers, can we use the new subsystem prefix for the driver?
> In other words:
> 
> [PATCH] staging: nrf24: Add new driver for 2.4Ghz radio transceiver
>
Sure.

> This driver seems basically OK to me.  I don't think you necessarily
> need to go through staging?  Have you tried sending it directly to
> netdev?
> 
I have not tried that, mainly as I believe it is not mature enough. I
would give it some time in staging for testing and bugfixing. If you say
that it is not needed and can be done out of staging, I will ask netdev
if it can be accepted there.

> > +		//take out size of data
> 
> This comment is sort of useless?  "take out" is like Chinese food.  It
> seems like it should be obvious what the code does.  The format is
> wrong.  So there are very minor things to be tidied up.
> 
Agree, I will do comments cleanup.

> > +		ret = kfifo_out(&device->tx_fifo, &size, sizeof(size));
> > +		if (ret != sizeof(size)) {
> > +			dev_dbg(&device->dev, "get size from fifo failed\n");
> > +			mutex_unlock(&device->tx_fifo_mutex);
> > +			continue;
> > +		}
> > +
> > +		//alloc space for data
> > +		buf = kzalloc(size, GFP_KERNEL);
> > +		if (!buf) {
> > +			dev_dbg(&device->dev, "buf alloc failed\n");
> > +			mutex_unlock(&device->tx_fifo_mutex);
> > +			continue;
> > +		}
> > +
> > +		//take out size of data
> > +		ret = kfifo_out(&device->tx_fifo, buf, size);
> > +		if (ret != size) {
> > +			dev_dbg(&device->dev, "get buf from fifo failed\n");
> > +			mutex_unlock(&device->tx_fifo_mutex);
> > +			goto next;
> > +		}
> > +
> > +		//unlock tx fifo
> > +		mutex_unlock(&device->tx_fifo_mutex);
> > +
> > +		//enter Standby-I mode
> > +		nrf24_ce_lo(device);
> > +
> > +		//set TX MODE
> > +		ret = nrf24_set_mode(device->spi, NRF24_MODE_TX);
> > +		if (ret < 0)
> > +			goto next;
> > +
> > +		//set PIPE0 address
> > +		//this is needed to receive ACK
> > +		ret = nrf24_set_address(device->spi,
> > +					NRF24_PIPE0,
> > +					(u8 *)&p->cfg.address);
> > +		if (ret < 0) {
> > +			dev_dbg(&device->dev, "set PIPE0 address failed (%d)\n", ret);
> > +			goto next;
> > +		}
> > +
> > +		//set TX address
> > +		ret = nrf24_set_address(device->spi,
> > +					NRF24_TX,
> > +					(u8 *)&p->cfg.address);
> > +		if (ret < 0) {
> > +			dev_dbg(&device->dev, "set TX address failed (%d)\n", ret);
> > +			goto next;
> > +		}
> > +
> > +		//check if pipe uses static payload length
> > +		spl = p->cfg.plw != 0;
> > +
> > +		//check if dynamic payload length is enabled
> > +		dpl = nrf24_get_dynamic_pl(device->spi);
> > +
> > +		if (spl && dpl) {
> > +			//disable dynamic payload if pipe
> > +			//does not use dynamic payload
> > +			//and dynamic paload is enabled
> > +			ret = nrf24_disable_dynamic_pl(device->spi);
> > +			if (ret < 0)
> > +				goto next;
> > +		}
> > +
> > +		memset(pload, 0, PLOAD_MAX);
> > +		memcpy(pload, &size, sizeof(size));
> > +
> > +		//calculate payload length
> > +		n = spl ? p->cfg.plw : sizeof(size);
> > +
> > +		//send size
> > +		nrf24_write_tx_pload(device->spi, pload, n);
> > +		if (ret < 0) {
> > +			dev_dbg(&device->dev, "write TX PLOAD failed (%d)\n", ret);
> > +			goto next;
> > +		}
> > +
> > +		//enter TX MODE and start transmission
> > +		nrf24_ce_hi(device);
> > +
> > +		//wait for ACK
> > +		wait_event_interruptible(device->tx_done_wait_queue,
> > +					 (device->tx_done ||
> > +					 kthread_should_stop()));
> > +
> > +		if (kthread_should_stop())
> > +			goto abort;
> > +
> > +		//clear counter
> > +		sent = 0;
> > +
> > +		while (size > 0) {
> > +			n = spl ? p->cfg.plw : min_t(ssize_t, size, PLOAD_MAX);
> > +
> > +			dev_dbg(&device->dev, "tx %zd bytes\n", n);
> > +
> > +			memset(pload, 0, PLOAD_MAX);
> > +			memcpy(pload, buf + sent, n);
> > +
> > +			//write PLOAD to nRF FIFO
> > +			ret = nrf24_write_tx_pload(device->spi, pload, n);
> > +
> > +			if (ret < 0) {
> > +				dev_dbg(&device->dev,
> > +					"write TX PLOAD failed (%d)\n",
> > +					ret);
> > +				goto next;
> > +			}
> > +
> > +			sent += n;
> > +			size -= n;
> > +
> > +			device->tx_done = false;
> > +
> > +			//wait for ACK
> > +			wait_event_interruptible(device->tx_done_wait_queue,
> > +						 (device->tx_done ||
> > +						 kthread_should_stop()));
> > +
> > +			if (kthread_should_stop())
> > +				goto abort;
> > +		}
> > +next:
> > +		//free data buffer
> > +		kfree(buf);
> > +
> > +		//restore dynamic payload feature
> > +		if (dpl)
> > +			nrf24_enable_dynamic_pl(device->spi);
> > +
> > +		//if all sent enter RX MODE
> > +		if (kfifo_is_empty(&device->tx_fifo)) {
> > +			dev_dbg(&device->dev, "%s: NRF24_MODE_RX\n", __func__);
> > +
> > +			//enter Standby-I
> > +			nrf24_ce_lo(device);
> > +
> > +			p = nrf24_find_pipe_id(device, NRF24_PIPE0);
> > +			if (!IS_ERR(p)) {
> > +				//restore PIPE0 address
> > +				nrf24_set_address(device->spi,
> > +						  p->id,
> > +						  (u8 *)&p->cfg.address);
> > +			}
> > +			//set RX MODE
> > +			nrf24_set_mode(device->spi, NRF24_MODE_RX);
> > +
> > +			//enter RX MODE and start receiving
> > +			nrf24_ce_hi(device);
> > +		}
> > +	}
> > +abort:
> > +	kfree(buf);
> > +
> > +	return 0;
> > +}
> > +
> 
> [ snip ]
> 
> > +static int nrf24_gpio_setup(struct nrf24_device *device)
> > +{
> > +	int ret;
> > +
> > +	device->ce = gpiod_get(&device->spi->dev, "ce", 0);
> > +
> > +	if (device->ce == ERR_PTR(-ENOENT))
> > +		dev_dbg(&device->dev, "%s: no entry for CE\n", __func__);
> > +	else if (device->ce == ERR_PTR(-EBUSY))
> > +		dev_dbg(&device->dev, "%s: CE is busy\n", __func__);
> > +
> > +	if (IS_ERR(device->ce)) {
> > +		ret = PTR_ERR(device->ce);
> > +		dev_err(&device->dev, "%s: CE gpio setup error\n", __func__);
> > +		return ret;
> > +	}
> > +
> > +	nrf24_ce_lo(device);
> > +
> > +	//irq
> > +	ret = request_irq(device->spi->irq,
> > +			  nrf24_isr,
> > +			  0,
> > +			  dev_name(&device->dev),
> > +			  device);
> > +	if (ret < 0) {
> > +		free_irq(device->spi->irq, device);
> 
> I don't think we need to free this because the requiest failed.
> 
True, free_irq is not needed here.

> I'm not a huge fan of your label naming scheme.  You're generally using
> come-from names like "alloc_failed:" but that doesn't tell you what the
> goto does so I have to open two windows and manually line up the gotos
> with the labels to see what the goto does.  It's better for the name
> to say "err_put_ce".
>
I got your point and it make sens. I will review and try to rename
labels accordingly.

> > +		goto err;
> > +	}
> > +
> > +	return 0;
> > +
> > +err:
> > +	gpiod_put(device->ce);
> > +	return ret;
> > +}
> > +
> > +static void nrf24_dev_release(struct device *dev)
> > +{
> > +	struct nrf24_device *device = to_nrf24_device(dev);
> > +
> > +	ida_simple_remove(&nrf24_ida_dev, device->id);
> > +	kfree(device);
> > +}
> > +
> > +static struct device_type nrf24_dev_type = {
> > +	.name = "nrf24_device",
> > +	.release = nrf24_dev_release,
> > +};
> > +
> > +static struct nrf24_device *nrf24_dev_init(struct spi_device *spi)
> > +{
> > +	int ret;
> > +	struct nrf24_device *device;
> > +	int id;
> > +
> > +	id = ida_simple_get(&nrf24_ida_dev, 0, 0, GFP_KERNEL);
> > +	if (id < 0)
> > +		return ERR_PTR(id);
> > +
> > +	//sets flags to false as well
> > +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> > +	if (!device) {
> > +		ida_simple_remove(&nrf24_ida_dev, id);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +	device->spi = spi;
> > +
> > +	dev_set_name(&device->dev, "nrf%d", id);
> > +	device->id = id;
> > +	device->dev.parent = &spi->dev;
> > +	device->dev.class = nrf24_class;
> > +	device->dev.type = &nrf24_dev_type;
> > +	device->dev.groups = nrf24_groups;
> > +	ret = device_register(&device->dev);
> > +	if (ret < 0) {
> > +		put_device(&device->dev);
> 
> We don't have to do ida_simple_remove()?
> 
We do have to do ida_simple_remove. I missed it!

> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	init_waitqueue_head(&device->tx_wait_queue);
> > +	init_waitqueue_head(&device->tx_done_wait_queue);
> > +	init_waitqueue_head(&device->rx_wait_queue);
> > +
> > +	INIT_WORK(&device->isr_work, nrf24_isr_work_handler);
> > +	INIT_KFIFO(device->tx_fifo);
> > +	spin_lock_init(&device->lock);
> > +	mutex_init(&device->tx_fifo_mutex);
> > +
> > +	INIT_LIST_HEAD(&device->pipes);
> > +
> > +	return device;
> > +}
> 
> [ snip ]
> 
> > +static ssize_t address_show(struct device *dev,
> > +			    struct device_attribute *attr,
> > +			    char *buf)
> > +{
> > +	struct nrf24_device *device = to_nrf24_device(dev->parent);
> > +	u8 addr[16];
> > +	int ret;
> > +	int count;
> > +	int i;
> > +	struct nrf24_pipe *pipe;
> > +
> > +	pipe = nrf24_find_pipe_ptr(dev);
> > +	if (IS_ERR(pipe))
> > +		return PTR_ERR(pipe);
> > +
> > +	ret = nrf24_get_address(device->spi, pipe->id, addr);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	count = snprintf(buf, PAGE_SIZE, "0x");
> > +	for (i = --ret; i >= 0; i--)
> > +		count += snprintf(buf + count, PAGE_SIZE, "%02X", addr[i]);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +	count += snprintf(buf + count, PAGE_SIZE, "\n");
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This isn't right.  Use scnprintf().  The snprintf() function returns
> the nubmer of characters that would have been written if we had space.
> And it should be PAGE_SIZE - count.
> 
You are right, I will use scnprintf here.

> > +
> > +	return count;
> > +}
> > +
> 
> 
> regards,
> dan carpenter

Thanks for the review, I will send v3 in some time now.

br,
Marcin
