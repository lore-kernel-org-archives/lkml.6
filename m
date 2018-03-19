Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3553123-1521485665-2-2851146379431315272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521485664; b=s1cgxJD6/RAt5qdYw457RlpRQhTmjjbvz4wsZjl9QXZMEWw
    qM9o+kGgMFQORjEVgXlgs8XycWtdPwQE/yh+NoYiph5fEX1AaYv6dITbejZf6e0n
    1OuCNdm48hAToD75WPfjQgmCGw4TZ7opaV6r0471U4EbpuvxOcY67xIHlorGwfI9
    ZjJIBPwzmuMS0VEBEmC5VjyF5oOcYYzy4wx11LXaXQSMq5bUVVO5pSLPRnIiFu09
    /03hGtGRz+1t6y9ghcRdH1NspFfgCvGL7iy4czcH4S0fmHAZdgAoofpseoCokA54
    as/xsTWYmFb6d7bbq6AjMQtN3SDTuxF60cWbHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521485664; bh=noG+arw
    PQk+QNoCqoLff22X3fp8RCIdhWKLDSX9OA+4=; b=ewo7Za2p1b6dlm9DNdzSlHp
    g0jbng4LvkEAdcBanAINkGAFhUIUIYIzaTWHPuHEv2wvoBnPkGAfQaPgN6aNQzZP
    B4BJG+CLkLPAKi2caYRXO7H1fE26dK7X/rYsEMf+q0ThHQE0x2zD4dS0RiLyFgvc
    pGMUa2Cp6iWfTMSQ7IECw7Jt4e5lWWrBkcAM3CCX3CuHJoCCNqwe7wUO/tPUo11m
    O9DJZTInRoSn1H2QWjJHVA2CdV0Qt8x8OwKJrtSabHGB6VQ5xCwljEiAT6ipoE2u
    2eHcLqWep2NeXOxDSJjT0H2sUUm+ebbivg21a+76WrmqTpUM2EUhd9zz5Nk3Xyg=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wunner.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggugfgjfghsphejsehtkeertddtredunecuhfhrohhmpefnuhhkrghsucghuhhnnhgvrhcuoehluhhkrghsseifuhhnnhgvrhdruggvqeenucfkphepvddtledrudefvddrudektddrieejpdekfedrvddvfedrleehrddvkeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeiieelheenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wunner.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wunner.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggugfgjfghsphejsehtkeertddtredunecuhfhrohhmpefnuhhkrghsucghuhhnnhgvrhcuoehluhhkrghsseifuhhnnhgvrhdruggvqeenucfkphepvddtledrudefvddrudektddrieejpdekfedrvddvfedrleehrddvkeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeiieelheenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=wunner.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966550AbeCSSyG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:54:06 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:47907 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970563AbeCSSyA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:54:00 -0400
Date: Mon, 19 Mar 2018 19:53:58 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
        <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH AUTOSEL for 4.15 099/124] Bluetooth: hci_bcm: Mandate
 presence of shutdown and device wake GPIO
Message-ID: <20180319185358.GA13467@wunner.de>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-99-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319154645.11350-99-alexander.levin@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 03:48:50PM +0000, Sasha Levin wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> [ Upstream commit 3e81a4ca51a1172253078ca7abd6a91040b8fcf4 ]
>

Unfortunately this commit had to be fixed up with ab2f336cb7e6
("Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional")
by Stefan Wahren (+cc).

Please be sure to apply that one on top.  Thanks!


> Commit 0395ffc1ee05 ("Bluetooth: hci_bcm: Add PM for BCM devices")
> amended this driver to request a shutdown and device wake GPIO on probe,
> but mandated that only one of them need to be present:
> 
> 	/* Make sure at-least one of the GPIO is defined and that
> 	 * a name is specified for this instance
> 	 */
> 	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
> 		dev_err(&pdev->dev, "invalid platform data\n");
> 		return -EINVAL;
> 	}
> 
> However the same commit added a call to bcm_gpio_set_power() to the
> ->probe hook, which unconditionally accesses *both* GPIOs.  Luckily,
> the resulting NULL pointer deref was never reported, suggesting there's
> no machine where either GPIO is missing.
> 
> Commit 8a92056837fd ("Bluetooth: hci_bcm: Add (runtime)pm support to the
> serdev driver") removed the check whether at least one of the GPIOs is
> present without specifying a reason.
> 
> Because commit 62aaefa7d038 ("Bluetooth: hci_bcm: improve use of gpios
> API") refactored the driver to use devm_gpiod_get_optional() instead of
> devm_gpiod_get(), one is now tempted to believe that the driver doesn't
> require *any* of the two GPIOs.
> 
> Which is wrong, the driver still requires both GPIOs to avoid a NULL
> pointer deref.  To this end, establish the status quo ante and request
> the GPIOs with devm_gpiod_get() again.  Bail out of ->probe if either
> of them is missing.
> 
> Oddly enough, whereas bcm_gpio_set_power() accesses the device wake pin
> unconditionally, bcm_suspend_device() and bcm_resume_device() do check
> for its presence before accessing it.  Those checks are superfluous,
> so remove them.
> 
> Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
> Cc: Loic Poulain <loic.poulain@linaro.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/bluetooth/hci_bcm.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 707c2d1b84c7..b8eeac4e6f35 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -577,11 +577,9 @@ static int bcm_suspend_device(struct device *dev)
>  	}
>  
>  	/* Suspend the device */
> -	if (bdev->device_wakeup) {
> -		gpiod_set_value(bdev->device_wakeup, false);
> -		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
> -		mdelay(15);
> -	}
> +	gpiod_set_value(bdev->device_wakeup, false);
> +	bt_dev_dbg(bdev, "suspend, delaying 15 ms");
> +	mdelay(15);
>  
>  	return 0;
>  }
> @@ -592,11 +590,9 @@ static int bcm_resume_device(struct device *dev)
>  
>  	bt_dev_dbg(bdev, "");
>  
> -	if (bdev->device_wakeup) {
> -		gpiod_set_value(bdev->device_wakeup, true);
> -		bt_dev_dbg(bdev, "resume, delaying 15 ms");
> -		mdelay(15);
> -	}
> +	gpiod_set_value(bdev->device_wakeup, true);
> +	bt_dev_dbg(bdev, "resume, delaying 15 ms");
> +	mdelay(15);
>  
>  	/* When this executes, the device has woken up already */
>  	if (bdev->is_suspended && bdev->hu) {
> @@ -779,14 +775,12 @@ static int bcm_get_resources(struct bcm_device *dev)
>  
>  	dev->clk = devm_clk_get(dev->dev, NULL);
>  
> -	dev->device_wakeup = devm_gpiod_get_optional(dev->dev,
> -						     "device-wakeup",
> -						     GPIOD_OUT_LOW);
> +	dev->device_wakeup = devm_gpiod_get(dev->dev, "device-wakeup",
> +					    GPIOD_OUT_LOW);
>  	if (IS_ERR(dev->device_wakeup))
>  		return PTR_ERR(dev->device_wakeup);
>  
> -	dev->shutdown = devm_gpiod_get_optional(dev->dev, "shutdown",
> -						GPIOD_OUT_LOW);
> +	dev->shutdown = devm_gpiod_get(dev->dev, "shutdown", GPIOD_OUT_LOW);
>  	if (IS_ERR(dev->shutdown))
>  		return PTR_ERR(dev->shutdown);
>  
> -- 
> 2.14.1
