Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8289DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2782121582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="YWltKhOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2782121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeI0Qlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:41:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33264 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeI0Qlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:41:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id g26-v6so4577279edp.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtuLwL52ABRMSiJmhvjqBIJLUXOhH+kVoBER6pK0E7M=;
        b=YWltKhOTsU68TTgo8fb0jiGpV0qmXXCeq7lYHoWui93KxuQGNVCAsFMPwUObdkLQoh
         vvPGe6EWw7QWMX69lx9rQXiYYsdcoAQkzagNRVe//Z4Dcb7lfgYgReyRstSJ7azR5+ss
         23sWeGX9qO6FUg253RWRD8xYXR9Q8kWj3ACC/Qys6R0vD3W7OiFsw2v3fXA89hDvQIKd
         XaJEfliLZ6T2T2ubFjsx+cS8ziQcwGPZezxGntAhB77sla9vhH3g8EUTuyozRFrKtaoo
         FGuOxbGYX0nQOJUZdv8UEgPLYbXkfK39gN/H+3p4OpaQIvuFUXC9WTZ/PmGSptVM+5cI
         KGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtuLwL52ABRMSiJmhvjqBIJLUXOhH+kVoBER6pK0E7M=;
        b=canErZ8dFChJmy7tZb4tFwrm6T7mmK3Zd8+0AO6jFcrGe6CjhX1llrcr1kKdG58EvV
         ZBM0fpco7f5qfcf/ScGtVLVaUzT+djBP+4rjScFAQBv+2DVXTznKgRTAIFprGzFdivEo
         WtrOHqfzELQychJ2n0v4PfgeLi1Y0H/P6mY8gzLfpyrPVYMgQ4D4yMaHKQlE9iQdEFcB
         NdOy4sEwOqYwaSd/lNXfoLYTWoFJ6paLfiVTT2u3MVSG0/pLIC5qh2gEWthMQyakxWGT
         feFD6UPHF3qCVaVm+fjth+hc/rL/Mm9dVyZZxxkzdvjVYegsAv9pQYNWcLNiYrvm4JW2
         yuCw==
X-Gm-Message-State: ABuFfohhVTudFJEflnpENMkC9puTtw+NpzL5OxxnC373MBcVrTcO2SJV
        NufYstvFkz8XnI4r2YYc1gCy5A==
X-Google-Smtp-Source: ACcGV613TNtOFULLkxH4LDGnkWybqm3thBN4ov8aBGw/KI4Pu2YR7TkCuoWZjnH6Ie5VKdy8RzePPQ==
X-Received: by 2002:a50:95c6:: with SMTP id x6-v6mr16714925eda.113.1538043840610;
        Thu, 27 Sep 2018 03:24:00 -0700 (PDT)
Received: from shemminger-XPS-13-9360 ([213.244.170.154])
        by smtp.gmail.com with ESMTPSA id i4-v6sm935002eds.65.2018.09.27.03.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 03:24:00 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:23:55 +0200
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "otubo@redhat.com" <otubo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH] hv_netvsc: Make sure out channel is fully opened on
 send
Message-ID: <20180927122355.470df119@shemminger-XPS-13-9360>
In-Reply-To: <1538038625.19334.2.camel@redhat.com>
References: <1537979659-26979-1-git-send-email-mgamal@redhat.com>
        <BN6PR21MB01612C60B5421AF2BB09742CCA150@BN6PR21MB0161.namprd21.prod.outlook.com>
        <1538038625.19334.2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 10:57:05 +0200
Mohammed Gamal <mgamal@redhat.com> wrote:

> On Wed, 2018-09-26 at 17:13 +0000, Haiyang Zhang wrote:
> > > -----Original Message-----
> > > From: Mohammed Gamal <mgamal@redhat.com>
> > > Sent: Wednesday, September 26, 2018 12:34 PM
> > > To: Stephen Hemminger <sthemmin@microsoft.com>; netdev@vger.kernel.
> > > org
> > > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > > <haiyangz@microsoft.com>; vkuznets <vkuznets@redhat.com>;
> > > otubo@redhat.com; cavery <cavery@redhat.com>; linux-
> > > kernel@vger.kernel.org; devel@linuxdriverproject.org; Mohammed
> > > Gamal
> > > <mgamal@redhat.com>
> > > Subject: [PATCH] hv_netvsc: Make sure out channel is fully opened
> > > on send
> > >=20
> > > Dring high network traffic changes to network interface parameters
> > > such as
> > > number of channels or MTU can cause a kernel panic with a NULL
> > > pointer
> > > dereference. This is due to netvsc_device_remove() being called and
> > > deallocating the channel ring buffers, which can then be accessed
> > > by
> > > netvsc_send_pkt() before they're allocated on calling
> > > netvsc_device_add()
> > >=20
> > > The patch fixes this problem by checking the channel state and
> > > returning
> > > ENODEV if not yet opened. We also move the call to
> > > hv_ringbuf_avail_percent()
> > > which may access the uninitialized ring buffer.
> > >=20
> > > Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> > > ---
> > > =C2=A0drivers/net/hyperv/netvsc.c | 7 ++++++-
> > > =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/hyperv/netvsc.c
> > > b/drivers/net/hyperv/netvsc.c index
> > > fe01e14..75f1b31 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -825,7 +825,12 @@ static inline int netvsc_send_pkt(
> > > =C2=A0	struct netdev_queue *txq =3D netdev_get_tx_queue(ndev,
> > > packet->q_idx);
> > > =C2=A0	u64 req_id;
> > > =C2=A0	int ret;
> > > -	u32 ring_avail =3D
> > > hv_get_avail_to_write_percent(&out_channel- =20
> > > > outbound); =20
> > >=20
> > > +	u32 ring_avail;
> > > +
> > > +	if (out_channel->state !=3D CHANNEL_OPENED_STATE)
> > > +		return -ENODEV;
> > > +
> > > +	ring_avail =3D hv_get_avail_to_write_percent(&out_channel- =20
> > > >outbound); =20
> >=20
> > When you reproducing the NULL ptr panic, does your kernel include the
> > following patch?
> > hv_netvsc: common detach logic
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c
> > ommit/?id=3D7b2ee50c0cd513a176a26a71f2989facdd75bfea
> >  =20
> Yes it is included. And the commit did reduce the occurrence of this
> race condition, but it still nevertheless occurs albeit rarely.
>=20
> > We call netif_tx_disable(ndev) and netif_device_detach(ndev) before
> > doing the changes=C2=A0
> > on MTU or #channels. So there should be no call to start_xmit() when
> > channel is not ready.
> >=20
> > If you see the check for CHANNEL_OPENED_STATE is still necessary on
> > upstream kernel (including=C2=A0
> > the patch " common detach logic "), we should debug further on the
> > code and find out the=C2=A0
> > root cause.
> >=20
> > Thanks,
> > - Haiyang
> >  =20
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Is there some workload, that can be used to reproduce this?
The stress test from Vitaly with changing parameters while running network =
traffic
passes now.

Can you reproduce this with the upstream current kernel?

Adding the check in start xmit is still racy, and won't cure the problem.

Another solution would be to add a grace period in the netvsc detach logic.

