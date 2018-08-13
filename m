Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9B12171F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixOBjCEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9B12171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeHMUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:31:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40108 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeHMUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:31:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id y200-v6so11858657lfd.7;
        Mon, 13 Aug 2018 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4kMegHIvfAupDnWu8kE21Vr289uNCmkzuhqqIqA8aM=;
        b=ixOBjCExp+/4K52AJ+i5NKh9I7n/GUpP2XZ0NfWUq8Fb6DAiClC4XY9BMu7SsoiyzS
         PBVMdh76ffbuV0xStfzKKioLbBnrw93Leu0ilWMtaqFYFOEv2CAoJjRIWIdBHQln1Fj/
         F45+i1A9j4TjwCWnotVYzw9VJQWzpvQnvuXFUpLlgWvXkFIOb2QpwuMfCtjuszzDBc0a
         ol5xlVyIo+zxdV8OeivVJML2tZzgxq3eVdYjZcngxf3pZI8dSExeGrJt3crY7SJwRWo1
         b/gQova1Ri0TEmNFtEPIdKVshu90aQo5n5w/VDq+PxVJJ37a+f63XkaZD9K9uhXoc0J2
         qFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4kMegHIvfAupDnWu8kE21Vr289uNCmkzuhqqIqA8aM=;
        b=gIBxcc7JHW+X+dmkEAwHqWa8LQKnW00KAzJMH8TQfsb/tysPRDXO29Q5gFxHo54Dy2
         Mmzb3fTsB/y4ucbOTTZ3Z/D1G5qTahT7oz+ztJGGUUuEA7B0rRAbk905bFIxbNjPqFpl
         OGNo74GCnLGn4WlrIcRTXEdxB7B+msahp2dXxE9L9eNFXjAuMiVVlmBSr5kWL/x12gWo
         R+2uqLYNXzIxN0qnGh6Z6eCtRMOKMpBYyGxapopyvkE6Eu+RL/8j/ggkdIMNSZq8PP4W
         FCIzrqy54Z1Jxc69Kv1d6TvXyowrWv6yaTGZqKWzCjt4P6zUDZSxQskcQOAJ/zguqJ37
         12qg==
X-Gm-Message-State: AOUpUlHC88lgEH3CcH4Kw7Ip8Xw1AHO0GQkaauYUAoTCwmvknG2slOAQ
        XktQoNlHHO40VLlAW+WFpQY=
X-Google-Smtp-Source: AA+uWPy+tCnXhj80TwQzl3ILKxtnbVZroek32BE7GPFBC0CBMNJHGB1J5dpafITifv3S1tzlv+RlRg==
X-Received: by 2002:a19:9403:: with SMTP id w3-v6mr11395834lfd.29.1534182507760;
        Mon, 13 Aug 2018 10:48:27 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id z10-v6sm3122584ljh.57.2018.08.13.10.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 10:48:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpu: host1x: Ignore clients initialization failure
Date:   Mon, 13 Aug 2018 20:48:25 +0300
Message-ID: <2093022.0kn10W7Lqi@dimapc>
In-Reply-To: <20180809231211.26182-1-digetx@gmail.com>
References: <20180809231211.26182-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 10 August 2018 02:12:11 MSK Dmitry Osipenko wrote:
> From time to time new bugs are popping up, causing some host1x client to
> fail its initialization. Currently a single clients initialization failure
> causes whole host1x device registration to fail, as a result a single DRM
> sub-device initialization failure makes whole DRM initialization to fail.
> Let's ignore clients initialization failure, as a result display panel
> lights up even if some DRM clients (say GR2D or VIC) fail to initialize.
> Actually VIC fails if initramfs misses the firmware file, so with this
> change a serial console isn't needed anymore to figure out why display
> isn't working.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: Added WARN_ON() that should get more attention than just a error
> message. Made clients_lock to lock around the lists modification, that is
> in line with the rest of the code.
> 
>  drivers/gpu/host1x/bus.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 815bdb42e3f0..07bb6b6c1260 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -199,19 +199,23 @@ static void host1x_subdev_unregister(struct
> host1x_device *device, */
>  int host1x_device_init(struct host1x_device *device)
>  {
> -	struct host1x_client *client;
> +	struct host1x_client *client, *cl;
>  	int err;
> 
>  	mutex_lock(&device->clients_lock);
> 
> -	list_for_each_entry(client, &device->clients, list) {
> +	list_for_each_entry_safe(client, cl, &device->clients, list) {
>  		if (client->ops && client->ops->init) {
>  			err = client->ops->init(client);
> -			if (err < 0) {
> +			if (WARN_ON(err < 0)) {
>  				dev_err(&device->dev,
>  					"failed to initialize %s: %d\n",
>  					dev_name(client->dev), err);
> -				goto teardown;
> +
> +				/* add the client to the list of idle clients */
> +				mutex_lock(&clients_lock);
> +				list_add_tail(&client->list, &clients);

This shall be list_move_tail(), v3 is coming.

> +				mutex_unlock(&clients_lock);




