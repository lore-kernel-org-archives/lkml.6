Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8169FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDFB20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="f7Z8nyL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDFB20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbeG3Oyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:54:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33999 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeG3Oyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:54:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so8378943wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lxws2c5lx9WEPctQJR07FjWC1GaR0wvXflSzuXTHPQo=;
        b=f7Z8nyL8gLghO4g8LVafgAH0DSSMFxZeDujr6qzq33F/9qZIYHW53JwZH8tolNx4Wz
         NzBAPs9WOSI3LSwRsjFz5sPAXdsGUBduLLEpc6+Vdl7Pcg+NE1H+uv9V4mV75I/vARp7
         kf3eVjem48ORTRvHNG5LRhB7t392kekh40gwkJm8c9e/YJw/9b3S/cBF53rTgafkj8g4
         78dJ5JhEchOXI8afxDZPrRajvY1GXbA0A66VO3AQgljOr91nGYja5y3iE4Lw4oR+nHhy
         +VEksQHcI3qIcUgP6RdLiDjZpk2yqTYlrlUbvKIB+qEQkFPOLWYtP392L4sD/1vPqx+i
         uHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lxws2c5lx9WEPctQJR07FjWC1GaR0wvXflSzuXTHPQo=;
        b=jXVvTyic123wReGzmDK+rWvj0rAEqRy0Kkh/FmNU3M/HwFOIihU/v/HM0jGOnoP969
         EQ++tNnu6fyXbA2He0by8bfCBbJOw5lvFgGSTKG7oIlgAnEUqkZkHrwXVa+JuicfbInI
         lHG88AFuoBwTwTSCZW/qZ5QZ/i7ovwExMQM2QlfbiHmUM9b5N0lNv6ZmIVQRYuO5NoRh
         owR37zGMxu6dyiGD7SK9jGVZbcPpf2bUaxUOVqifdFdwSSvxXPPYwYOHk1tLGbNgIgQ8
         2+6SI7S+/LUZjcpdCk/ONzKsYwgEKyA9u9MhoHRybaO3Xj8L/BaqUoWfG1kIJRlrsjM4
         /Irw==
X-Gm-Message-State: AOUpUlG9q8VITAYzBPPMfOSgttKVc7s3DZAoWeL5V3mFg+7frQ26m/Xx
        gt4iQRZUICWAjG855K0aQySHPQ==
X-Google-Smtp-Source: AAOMgpdFk5yHvuuLxomIZxe30k9XTFSUlo66XRF3rVvkk6k6Z87o31iSApNRbA6twyPzUsE8APpz7w==
X-Received: by 2002:a1c:90e:: with SMTP id 14-v6mr15246621wmj.130.1532956777109;
        Mon, 30 Jul 2018 06:19:37 -0700 (PDT)
Received: from localhost (static-cl188134168102.unet.cz. [188.134.168.102])
        by smtp.gmail.com with ESMTPSA id z14-v6sm18201937wrr.71.2018.07.30.06.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 06:19:36 -0700 (PDT)
Date:   Mon, 30 Jul 2018 15:16:55 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 06/17] ethtool: support for netlink
 notifications
Message-ID: <20180730131655.GA10626@nanopsycho>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <e0e0433fd250dc331caa23aa739d7841e9602e0f.1532953989.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0e0433fd250dc331caa23aa739d7841e9602e0f.1532953989.git.mkubecek@suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 30, 2018 at 02:53:12PM CEST, mkubecek@suse.cz wrote:

[...]

>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index c1295c7a452e..c4b0c575d57e 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -2444,6 +2444,7 @@ enum netdev_cmd {
> 	NETDEV_CVLAN_FILTER_DROP_INFO,
> 	NETDEV_SVLAN_FILTER_PUSH_INFO,
> 	NETDEV_SVLAN_FILTER_DROP_INFO,
>+	NETDEV_ETHTOOL,

I don't understand why this goes through netdev notifier. What's the
reason?
