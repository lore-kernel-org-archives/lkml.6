Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3865743-1521099410-2-8094407714597826392
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521099410; b=e01jCu9QszYZo/8CV29Q3QsVNtc2vzYY3dLRg6eWtvX8c2Z
    wsESpfp3u7pV/9dZBUAQGtXCNYGxTzxD4GdZmN+Xvc3O7uO2oaYsUhlqAqo07DVC
    CNhk2TWWKlPQ9RRb4mefcKu9oL7Md09N7YN8BRjNcfK/PpANOHCR8siivMIGeEa/
    tXiQZXGUj/A8JJp0vMs5LGereXUQ/rs11uOB7Z2hfpT2jBf+BVCJvEuaKiLImTZa
    BVpg+dEUz9VjZJ2iybXzSbZI6w3XqatVrDrS8P4LxFibknq4Y6PacwAEebyRCnBM
    4g1OnKvMCyObuC33dI+cOmWYQdKpCt8x8oJuwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521099410; bh=c9d1ui
    VW+6Gc6EKdyQ+w4hSqD//mw7m3X/GSqy89RPk=; b=RnGgxo7/8SfOzdJ3IPB17X
    lc6yOqTdjPoLbGdNzhoyKUcAd3mkzaE+cvuXZqX0D8SoAs/6efIR6pQ0CyhusL5k
    pBo2Ku4hDWzxfeQkuNWRfL7pTJacjM97fBgGX0EwFxZhFN6W1veShIb6lE4pAIK5
    ap3L1OtKoq2o6F4Q9K6RJqPbCbvr9LgDV6L8OATMB7al5+T8rbvXxbbV3xGl+MSP
    ErJ7yHxIiXCtFwIeoZZ+XteqSAK7hX9gP4mXjD99bnFJAxWiXEdv+NsmHBWPsxNt
    rAVITEbqesHwLpBuEtj2iNpQANfduVspaxodSdMoiOP7ROUhXnEYuzX7E8otaKVA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCOHgb convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 15 Mar 2018 03:36:31 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9315 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeCOHga (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 03:36:30 -0400
X-IronPort-AV: E=Sophos;i="5.48,308,1517900400";
   d="scan'208";a="12107666"
From: <Nisar.Sayed@microchip.com>
To: <agraf@suse.de>, <Woojung.Huh@microchip.com>
CC: <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tbogendoerfer@suse.de>, <phil@raspberrypi.org>
Subject: RE: [PATCH] lan78xx: Connect phy early
Thread-Topic: [PATCH] lan78xx: Connect phy early
Thread-Index: AQHTu6RtRKCcnT2O9k2lhCneqxr8AaPQ3VhQ
Date: Thu, 15 Mar 2018 07:36:29 +0000
Message-ID: <CE371C1263339941885964188A0225FA3838A8@CHN-SV-EXMX03.mchp-main.com>
References: <20180314145456.69029-1-agraf@suse.de>
In-Reply-To: <20180314145456.69029-1-agraf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alexander,

Thanks for the patch.

> @@ -2575,13 +2571,7 @@ static int lan78xx_stop(struct net_device *net)
>  	if (timer_pending(&dev->stat_monitor))
>  		del_timer_sync(&dev->stat_monitor);
> 
> -	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
> -	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
> -
>  	phy_stop(net->phydev);
> -	phy_disconnect(net->phydev);
> -
> -	net->phydev = NULL;
> 
>  	clear_bit(EVENT_DEV_OPEN, &dev->flags);
>  	netif_stop_queue(net);

Please do add valid "phydev"  check before phy_stop, since "phy_disconnect" should be called before "unregister_netdev"

+ if (net->phydev)
	phy_stop(net->phydev);

> @@ -3481,6 +3471,11 @@ static void lan78xx_disconnect(struct
> usb_interface *intf)
>  	net = dev->net;
>  	unregister_netdev(net);
> 
> +	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
> +	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
> +
> +	phy_disconnect(net->phydev);
> +
>  	cancel_delayed_work_sync(&dev->wq);
> 
>  	usb_scuttle_anchored_urbs(&dev->deferred);

Please move "unregister_netdev" after "phy_disconnect", otherwise "phy_disconnect" will fail while we disconnect USB.

> @@ -3634,6 +3629,10 @@ static int lan78xx_probe(struct usb_interface
> *intf,
>  	pm_runtime_set_autosuspend_delay(&udev->dev,
>  					 DEFAULT_AUTOSUSPEND_DELAY);
> 
> +	ret = lan78xx_phy_init(dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
> 
>  out3:
> --
> 2.12.3

We should "goto out4" instead of "return" upon "lan78xx_phy_init" fail

+ out4:
+	unregister_netdev(netdev);

In addition to current changes, you might have to take care of the following.

In function "lan78xx_reset_resume"

-  lan78xx_phy_init(dev);
+ phy_start(dev->net->phydev);

Thanks,
Sd.Nisar


