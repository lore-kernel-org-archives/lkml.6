Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8388C208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="HbiEXKU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8388C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeGaI1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:27:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40614 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeGaI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:27:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so15350911wrs.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=npQeeeF5WBeYsFutmAsasdV3d+DrmG1u9HeOMcXnW0k=;
        b=HbiEXKU8Xq6N8tS1dLxlrDYu6INSGp5px5xyiC97qSNoaFjjZPqxIrDVy9QRrEeYWk
         kkQmHUmSrqTcnUOSKxGF0lzMKL2HaxAUMp1VzDqaV6bkGp2ZFpWUQSIYf8MNqtDzm9dh
         ItUu6D+vYJs3qqeHKC8zQTDWy7czdzHSBCjuHhZ48Sjcz56jv7WN0Kh8UteFYx7+aWd4
         1hueg7nwrFvAO4rl37mHubCU6c7NZGgf40FWJNElXIsfUZ0XzF97+EAPmGdlE46gk1tY
         CBOs9xa0Iwnx5NlS22cTDeG6rNGXmBDFGhB8Cy96b73eDjNeum0Zs2k4iQy3gJkTgUv1
         F5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=npQeeeF5WBeYsFutmAsasdV3d+DrmG1u9HeOMcXnW0k=;
        b=CoGsjcH3LRSuY54cPTzPIAxkqsaaQVbuNf96qzX0Z+Uk0ZG4N5u/1es1Npfg/WJP4V
         v92hipiP38G1FYiHKDbIDRdliKHKGCZcY2V8yVHsivGelWhHrZ2/BvSvoYcX/ve9joqA
         75Bm5u+5ZaAXeZylehlsNTxa2AYzqTMBh5gTU9QPu1tjG1bkkRIrT4dwRxzxi5Qjmqdy
         4u9fTucpj+aPijdGyUkHiybfk5O6FztvKGtLC2RlhV0b5dkSI7RdNBkVIuGXK5hCkfgu
         1b7MaR5EjUE0+llbV0hSs8SM/pC2faADGhO0Enf2arugU4QbzfYccIPGfw0wYK0m0KCG
         Uh8w==
X-Gm-Message-State: AOUpUlEe3HXihuMyhdtr5R+OXu2pess0jFuThyHRyAMWkh9Kd90RkzPk
        yWSiSZSWT05iIixtUjMaHaaiKw==
X-Google-Smtp-Source: AAOMgpfw+1rau30tfwezpKovTyiUbWiXdIGW/oHO8umih9YLN8vNj2wzXkCVnFsgWuRXkef/EIJyjA==
X-Received: by 2002:a5d:4410:: with SMTP id z16-v6mr20209328wrq.272.1533019723936;
        Mon, 30 Jul 2018 23:48:43 -0700 (PDT)
Received: from localhost (static-cl188134168102.unet.cz. [188.134.168.102])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1168478wmh.9.2018.07.30.23.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 23:48:43 -0700 (PDT)
Date:   Tue, 31 Jul 2018 08:46:00 +0200
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
Message-ID: <20180731064600.GC2154@nanopsycho>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <e0e0433fd250dc331caa23aa739d7841e9602e0f.1532953989.git.mkubecek@suse.cz>
 <20180730131655.GA10626@nanopsycho>
 <20180730170121.e6k5slbhdamclnt6@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730170121.e6k5slbhdamclnt6@unicorn.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 30, 2018 at 07:01:21PM CEST, mkubecek@suse.cz wrote:
>On Mon, Jul 30, 2018 at 03:16:55PM +0200, Jiri Pirko wrote:
>> Mon, Jul 30, 2018 at 02:53:12PM CEST, mkubecek@suse.cz wrote:
>> 
>> [...]
>> 
>> >diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> >index c1295c7a452e..c4b0c575d57e 100644
>> >--- a/include/linux/netdevice.h
>> >+++ b/include/linux/netdevice.h
>> >@@ -2444,6 +2444,7 @@ enum netdev_cmd {
>> > 	NETDEV_CVLAN_FILTER_DROP_INFO,
>> > 	NETDEV_SVLAN_FILTER_PUSH_INFO,
>> > 	NETDEV_SVLAN_FILTER_DROP_INFO,
>> >+	NETDEV_ETHTOOL,
>> 
>> I don't understand why this goes through netdev notifier. What's the
>> reason?
>
>To allow triggering a notification from other code (ethtool ioctl or
>e.g. netdev_features_change()) when netlink interface is built as a
>module. If it's a (performance?) problem, an alternative could be having
>a global pointer which would be either null or point to ethtool_notify()
>depending on whether the module is loaded (and ready).
>
>(Which made me realize I forgot to handle a race between module
>unloading and processing a notification.)
>
>Another question is if we really need the option to build the netlink
>interface as a module. I must admit my main motivation to have it as
>a module is that it makes testing and debugging easier.

Yeah. It is very core thing. I think it does not have to be a module.
