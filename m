Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809EBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264432086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M7JkMLn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264432086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeJPTcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:32:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58096 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:32:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GBfwCj058796;
        Tue, 16 Oct 2018 11:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7wXgTRZ7x3APT00JswZE9ntbg+k1oShhLbuFsxnQVxI=;
 b=M7JkMLn9Ljur4nEYlI/C/8gHK+Yxl87bykUW+HYdC/saqugyKb+fp7ewBWt4Z5m9NbjE
 42ytWN6vevh8l0Dr7cyiPke6RDSNhKbHOmy+31VIffENmql7DuGZVKs/JATMC7dytSJ1
 D9tI6aN21qhxK/pxUb50kmUMpxqzxE8ptChmXnsXfuHr0i37VRHfD04ad/v1lZuEDn/g
 OaG3whQCz5ys9MeMWVhVDSDDBIk6W5Nas9Q5gtCUkFAGp8+amWHeTc6Puho1mYNZtZVN
 HEyAeWR+dgC8semzKhWIypr1MoRsXtXnC3NgIi/UZWI46m/d+eQYcyjzBlod/veb2L62 9A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n384u07dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 11:42:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9GBg0n0013630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 11:42:00 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9GBfx24019432;
        Tue, 16 Oct 2018 11:42:00 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 04:41:58 -0700
Date:   Tue, 16 Oct 2018 14:41:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcin Ciupak <marcin.s.ciupak@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: add nrf24 driver
Message-ID: <20181016114150.2acsbpluwqe6d4l3@mwanda>
References: <20181016101747.ex6ftchhsiyzdjti@metis.ciupak.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016101747.ex6ftchhsiyzdjti@metis.ciupak.eu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=698
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we add drivers, can we use the new subsystem prefix for the driver?
In other words:

[PATCH] staging: nrf24: Add new driver for 2.4Ghz radio transceiver

This driver seems basically OK to me.  I don't think you necessarily
need to go through staging?  Have you tried sending it directly to
netdev?

> +		//take out size of data

This comment is sort of useless?  "take out" is like Chinese food.  It
seems like it should be obvious what the code does.  The format is
wrong.  So there are very minor things to be tidied up.

> +		ret = kfifo_out(&device->tx_fifo, &size, sizeof(size));
> +		if (ret != sizeof(size)) {
> +			dev_dbg(&device->dev, "get size from fifo failed\n");
> +			mutex_unlock(&device->tx_fifo_mutex);
> +			continue;
> +		}
> +
> +		//alloc space for data
> +		buf = kzalloc(size, GFP_KERNEL);
> +		if (!buf) {
> +			dev_dbg(&device->dev, "buf alloc failed\n");
> +			mutex_unlock(&device->tx_fifo_mutex);
> +			continue;
> +		}
> +
> +		//take out size of data
> +		ret = kfifo_out(&device->tx_fifo, buf, size);
> +		if (ret != size) {
> +			dev_dbg(&device->dev, "get buf from fifo failed\n");
> +			mutex_unlock(&device->tx_fifo_mutex);
> +			goto next;
> +		}
> +
> +		//unlock tx fifo
> +		mutex_unlock(&device->tx_fifo_mutex);
> +
> +		//enter Standby-I mode
> +		nrf24_ce_lo(device);
> +
> +		//set TX MODE
> +		ret = nrf24_set_mode(device->spi, NRF24_MODE_TX);
> +		if (ret < 0)
> +			goto next;
> +
> +		//set PIPE0 address
> +		//this is needed to receive ACK
> +		ret = nrf24_set_address(device->spi,
> +					NRF24_PIPE0,
> +					(u8 *)&p->cfg.address);
> +		if (ret < 0) {
> +			dev_dbg(&device->dev, "set PIPE0 address failed (%d)\n", ret);
> +			goto next;
> +		}
> +
> +		//set TX address
> +		ret = nrf24_set_address(device->spi,
> +					NRF24_TX,
> +					(u8 *)&p->cfg.address);
> +		if (ret < 0) {
> +			dev_dbg(&device->dev, "set TX address failed (%d)\n", ret);
> +			goto next;
> +		}
> +
> +		//check if pipe uses static payload length
> +		spl = p->cfg.plw != 0;
> +
> +		//check if dynamic payload length is enabled
> +		dpl = nrf24_get_dynamic_pl(device->spi);
> +
> +		if (spl && dpl) {
> +			//disable dynamic payload if pipe
> +			//does not use dynamic payload
> +			//and dynamic paload is enabled
> +			ret = nrf24_disable_dynamic_pl(device->spi);
> +			if (ret < 0)
> +				goto next;
> +		}
> +
> +		memset(pload, 0, PLOAD_MAX);
> +		memcpy(pload, &size, sizeof(size));
> +
> +		//calculate payload length
> +		n = spl ? p->cfg.plw : sizeof(size);
> +
> +		//send size
> +		nrf24_write_tx_pload(device->spi, pload, n);
> +		if (ret < 0) {
> +			dev_dbg(&device->dev, "write TX PLOAD failed (%d)\n", ret);
> +			goto next;
> +		}
> +
> +		//enter TX MODE and start transmission
> +		nrf24_ce_hi(device);
> +
> +		//wait for ACK
> +		wait_event_interruptible(device->tx_done_wait_queue,
> +					 (device->tx_done ||
> +					 kthread_should_stop()));
> +
> +		if (kthread_should_stop())
> +			goto abort;
> +
> +		//clear counter
> +		sent = 0;
> +
> +		while (size > 0) {
> +			n = spl ? p->cfg.plw : min_t(ssize_t, size, PLOAD_MAX);
> +
> +			dev_dbg(&device->dev, "tx %zd bytes\n", n);
> +
> +			memset(pload, 0, PLOAD_MAX);
> +			memcpy(pload, buf + sent, n);
> +
> +			//write PLOAD to nRF FIFO
> +			ret = nrf24_write_tx_pload(device->spi, pload, n);
> +
> +			if (ret < 0) {
> +				dev_dbg(&device->dev,
> +					"write TX PLOAD failed (%d)\n",
> +					ret);
> +				goto next;
> +			}
> +
> +			sent += n;
> +			size -= n;
> +
> +			device->tx_done = false;
> +
> +			//wait for ACK
> +			wait_event_interruptible(device->tx_done_wait_queue,
> +						 (device->tx_done ||
> +						 kthread_should_stop()));
> +
> +			if (kthread_should_stop())
> +				goto abort;
> +		}
> +next:
> +		//free data buffer
> +		kfree(buf);
> +
> +		//restore dynamic payload feature
> +		if (dpl)
> +			nrf24_enable_dynamic_pl(device->spi);
> +
> +		//if all sent enter RX MODE
> +		if (kfifo_is_empty(&device->tx_fifo)) {
> +			dev_dbg(&device->dev, "%s: NRF24_MODE_RX\n", __func__);
> +
> +			//enter Standby-I
> +			nrf24_ce_lo(device);
> +
> +			p = nrf24_find_pipe_id(device, NRF24_PIPE0);
> +			if (!IS_ERR(p)) {
> +				//restore PIPE0 address
> +				nrf24_set_address(device->spi,
> +						  p->id,
> +						  (u8 *)&p->cfg.address);
> +			}
> +			//set RX MODE
> +			nrf24_set_mode(device->spi, NRF24_MODE_RX);
> +
> +			//enter RX MODE and start receiving
> +			nrf24_ce_hi(device);
> +		}
> +	}
> +abort:
> +	kfree(buf);
> +
> +	return 0;
> +}
> +

[ snip ]

> +static int nrf24_gpio_setup(struct nrf24_device *device)
> +{
> +	int ret;
> +
> +	device->ce = gpiod_get(&device->spi->dev, "ce", 0);
> +
> +	if (device->ce == ERR_PTR(-ENOENT))
> +		dev_dbg(&device->dev, "%s: no entry for CE\n", __func__);
> +	else if (device->ce == ERR_PTR(-EBUSY))
> +		dev_dbg(&device->dev, "%s: CE is busy\n", __func__);
> +
> +	if (IS_ERR(device->ce)) {
> +		ret = PTR_ERR(device->ce);
> +		dev_err(&device->dev, "%s: CE gpio setup error\n", __func__);
> +		return ret;
> +	}
> +
> +	nrf24_ce_lo(device);
> +
> +	//irq
> +	ret = request_irq(device->spi->irq,
> +			  nrf24_isr,
> +			  0,
> +			  dev_name(&device->dev),
> +			  device);
> +	if (ret < 0) {
> +		free_irq(device->spi->irq, device);

I don't think we need to free this because the requiest failed.

I'm not a huge fan of your label naming scheme.  You're generally using
come-from names like "alloc_failed:" but that doesn't tell you what the
goto does so I have to open two windows and manually line up the gotos
with the labels to see what the goto does.  It's better for the name
to say "err_put_ce".

> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	gpiod_put(device->ce);
> +	return ret;
> +}
> +
> +static void nrf24_dev_release(struct device *dev)
> +{
> +	struct nrf24_device *device = to_nrf24_device(dev);
> +
> +	ida_simple_remove(&nrf24_ida_dev, device->id);
> +	kfree(device);
> +}
> +
> +static struct device_type nrf24_dev_type = {
> +	.name = "nrf24_device",
> +	.release = nrf24_dev_release,
> +};
> +
> +static struct nrf24_device *nrf24_dev_init(struct spi_device *spi)
> +{
> +	int ret;
> +	struct nrf24_device *device;
> +	int id;
> +
> +	id = ida_simple_get(&nrf24_ida_dev, 0, 0, GFP_KERNEL);
> +	if (id < 0)
> +		return ERR_PTR(id);
> +
> +	//sets flags to false as well
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device) {
> +		ida_simple_remove(&nrf24_ida_dev, id);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	device->spi = spi;
> +
> +	dev_set_name(&device->dev, "nrf%d", id);
> +	device->id = id;
> +	device->dev.parent = &spi->dev;
> +	device->dev.class = nrf24_class;
> +	device->dev.type = &nrf24_dev_type;
> +	device->dev.groups = nrf24_groups;
> +	ret = device_register(&device->dev);
> +	if (ret < 0) {
> +		put_device(&device->dev);

We don't have to do ida_simple_remove()?

> +		return ERR_PTR(ret);
> +	}
> +
> +	init_waitqueue_head(&device->tx_wait_queue);
> +	init_waitqueue_head(&device->tx_done_wait_queue);
> +	init_waitqueue_head(&device->rx_wait_queue);
> +
> +	INIT_WORK(&device->isr_work, nrf24_isr_work_handler);
> +	INIT_KFIFO(device->tx_fifo);
> +	spin_lock_init(&device->lock);
> +	mutex_init(&device->tx_fifo_mutex);
> +
> +	INIT_LIST_HEAD(&device->pipes);
> +
> +	return device;
> +}

[ snip ]

> +static ssize_t address_show(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct nrf24_device *device = to_nrf24_device(dev->parent);
> +	u8 addr[16];
> +	int ret;
> +	int count;
> +	int i;
> +	struct nrf24_pipe *pipe;
> +
> +	pipe = nrf24_find_pipe_ptr(dev);
> +	if (IS_ERR(pipe))
> +		return PTR_ERR(pipe);
> +
> +	ret = nrf24_get_address(device->spi, pipe->id, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	count = snprintf(buf, PAGE_SIZE, "0x");
> +	for (i = --ret; i >= 0; i--)
> +		count += snprintf(buf + count, PAGE_SIZE, "%02X", addr[i]);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +	count += snprintf(buf + count, PAGE_SIZE, "\n");
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This isn't right.  Use scnprintf().  The snprintf() function returns
the nubmer of characters that would have been written if we had space.
And it should be PAGE_SIZE - count.

> +
> +	return count;
> +}
> +


regards,
dan carpenter
