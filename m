Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B996C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C52084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1sbYO+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfBADNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:13:52 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36960 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBADNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:13:51 -0500
Received: by mail-lf1-f42.google.com with SMTP id u188so2001671lff.4;
        Thu, 31 Jan 2019 19:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVKTDPuQk3YSCYPsaJKpqZyPdGwzwhM4jJy9THAMqNs=;
        b=I1sbYO+VgHEn3Vv8rpjafcxVpLCcez0EPej+RBuMGG5Gaac9ZqCKn0qmaSBEtRJmqf
         tnepE6UA4zDU+9Mo48UIoeRnmGQ+LYdH25cAyuuYH2vws6ItkneIfu2hZirS8DT28diw
         7XDrjpQ+8HKA42OgtaSMtjV0YtSI0CsKZNYM0+rWCvpxTUazVACLyoDMDSiUf7FVWvKa
         s+SUqCe57zGGZ5WvKjkaSudThEg2X9hW/aNEYznmgfWBPdaM/2gRDxhGEdFstE52PkR9
         Bm73zr09Si1gjN91FfTL7VwfkWKU/Pm0drzGg6DBl8SEO6T+NX3Ap7F+LTAR4uNYJrvs
         HQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVKTDPuQk3YSCYPsaJKpqZyPdGwzwhM4jJy9THAMqNs=;
        b=EHXmHVhwIlau4bNp8xsUSxAmYTmoiid4aIwqzBmrZMcyf0Ew2Foq1y/nemAHqbPVTe
         5QX6kJMQK6QDohpSc8d3zGTD0zdhs0mB3Y0gJDynG2BJo/ATV75mrjsDfb7AawYuesUa
         lafSccmraIGmnHJKfYhr8G7O04zZxZ8d1OUEtnAgSFgb/D2Ec5hbyKr7RW38EbPQq0tk
         X/CXrzrp9EAhFn7aPnI2+Xm2YJ/ut1EMlcCq9sYh5MR1UL7AOjLzleZ98dFfFWdpk6rY
         LJRBr/+LWH6eW07LVl65YzkEPO8ivcaHnhflITCaS8U8o6B49zObWEuend18YZIUSvhl
         YorQ==
X-Gm-Message-State: AJcUukfg2L5hfAbAQSFvMZRxqJsahQk851yLN0KQZjAa/BTfYS7neLl2
        Ukt/MTQOg6KJy75iKPfzD5g=
X-Google-Smtp-Source: ALg8bN5MjHJkMrMRPK462RIjCVE8vM/7sa1T/M2nIkx8xdvmlMmSZt446MEGTWjHEx6r6Gd0vh7Wzg==
X-Received: by 2002:a19:5510:: with SMTP id n16mr22347688lfe.68.1548990828518;
        Thu, 31 Jan 2019 19:13:48 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id h203sm1173350lfe.44.2019.01.31.19.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 19:13:48 -0800 (PST)
Date:   Fri, 1 Feb 2019 06:14:14 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190201061414.05443ea1@dimatab>
In-Reply-To: <BYAPR12MB33986DDF4267ED1F499317B0C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
        <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
        <20190131124423.GG23438@ulmo>
        <20190201035249.5b1cdfe2@dimatab>
        <BYAPR12MB33986DDF4267ED1F499317B0C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Fri, 1 Feb 2019 01:11:06 +0000
Sowjanya Komatineni <skomatineni@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > > > +	if (dma) {
> > > > +		if (i2c_dev->msg_read) {
> > > > +			chan =3D i2c_dev->rx_dma_chan;
> > > > +			tegra_i2c_config_fifo_trig(i2c_dev,
> > > > xfer_size,
> > > > +
> > > > DATA_DMA_DIR_RX);
> > > > +
> > > > dma_sync_single_for_device(i2c_dev->dev, +
> > > > i2c_dev->dma_phys,
> > > > +						   xfer_size,
> > > > +
> > > > DMA_FROM_DEVICE); =20
> > >=20
> > > Do we really need this? We're not actually passing the device any=20
> > > data, so no caches to flush here. I we're cautious about flushing=20
> > > caches when we do write to the buffer (and I think we do that
> > > properly already), then there should be no need to do it here
> > > again.=20
> >
> > IIUC, DMA API has a concept of buffer handing which tells to use =20
> dma_sync_single_for_device() before issuing hardware job that touches
> the buffer and to use dma_sync_single_for_cpu() after hardware done
> the execution. In fact the CPU caches are getting flushed or
> invalidated as appropriate in a result.
> >
> > dma_sync_single_for_device(DMA_FROM_DEVICE) invalidates buffer in
> > the CPU cache, probably to avoid CPU evicting data from cache to
> > DRAM while hardware writes to the buffer. Hence this hunk is
> > correct.=20
> > > > +			err =3D tegra_i2c_dma_submit(i2c_dev,
> > > > xfer_size);
> > > > +			if (err < 0) {
> > > > +				dev_err(i2c_dev->dev,
> > > > +					"starting RX DMA
> > > > failed, err %d\n",
> > > > +					err);
> > > > +				goto unlock;
> > > > +			}
> > > > +		} else {
> > > > +			chan =3D i2c_dev->tx_dma_chan;
> > > > +			tegra_i2c_config_fifo_trig(i2c_dev,
> > > > xfer_size,
> > > > +
> > > > DATA_DMA_DIR_TX);
> > > > +			dma_sync_single_for_cpu(i2c_dev->dev,
> > > > +
> > > > i2c_dev->dma_phys,
> > > > +						xfer_size,
> > > > +
> > > > DMA_TO_DEVICE); =20
> > >=20
> > > This, on the other hand seems correct because we need to
> > > invalidate the caches for this buffer to make sure the data that
> > > we put there doesn't get overwritten. =20
> >
> > As I stated before in a comment to v6, this particular case of
> > dma_sync_single_for_cpu() usage is incorrect because CPU should
> > take ownership of the buffer after completion of hardwate job. But
> > in fact dma_sync_single_for_cpu(DMA_TO_DEVICE) is a NO-OP because
> > CPU doesn't need to flush or invalidate anything to take ownership
> > of the buffer if hardware did a read-only access.=20
> > >  =20
> > > > +	if (!i2c_dev->msg_read) {
> > > > +		if (dma) {
> > > > +			memcpy(buffer, msg->buf, msg->len);
> > > > +
> > > > dma_sync_single_for_device(i2c_dev->dev, +
> > > > i2c_dev->dma_phys,
> > > > +						   xfer_size,
> > > > +
> > > > DMA_TO_DEVICE); =20
> > >=20
> > > Again, here we properly flush the caches to make sure the data
> > > that we've written to the DMA buffer is visible to the DMA engine.
> > >  =20
> >
> > +1 this is correct
> >
> >
> > =20
> > > > +
> > > > +		if (i2c_dev->msg_read) {
> > > > +			if (likely(i2c_dev->msg_err =3D=3D
> > > > I2C_ERR_NONE)) {
> > > > +
> > > > dma_sync_single_for_cpu(i2c_dev->dev,
> > > > +
> > > > i2c_dev->dma_phys,
> > > > +
> > > > xfer_size, +
> > > > DMA_FROM_DEVICE); =20
> > >=20
> > > Here we invalidate the caches to make sure we don't get stale
> > > data that may be in the caches for data that we're copying out of
> > > the DMA buffer. I think that's about all the cache maintenance
> > > that we real need. =20
> >
> > Correct.
> >
> > And technically here should be
> > dma_sync_single_for_cpu(DMA_TO_DEVICE) for the TX. But again, it's
> > a NO-OP. =20
>=20
> Is my below understanding correct? Can you please confirm?
>=20
> During Transmit to device:
> - Before writing msg data into dma buf by CPU, giving DMA ownership
> to CPU dma_sync_single_for_cpu with dir DMA_TO_DEVICE
>=20

I tried to take a look at it again and now thinking that your variant
is more correct. Still it's a bit difficult to judge because this case
is no-op.

> - After writing to dma buf by CPU, giving back the ownership to
> device to access buffer to send during DMA transmit
> dma_sync_single_for_device with dir DMA_TO_DEVICE

Correct.

> During Receiving from Device:
> - before submitting RX DMA to give buffer access to DMAengine
> 	dma_sync_single_for_Device(DMA_FROM_DEVICE)=20

Correct.

> - after DMA RX completion, giving dma ownership to CPU for reading
> dmabuf data written by DMA from device dma_sync_single_for_cpu with
> dir DMA_FROM_DEVICE
>=20

Correct.

