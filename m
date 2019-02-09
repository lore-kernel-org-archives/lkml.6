Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A0C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E688C21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="zZQpzrMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfBISdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:33:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37377 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBISdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:33:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id x10so3866879wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gBXsGXhszxIuz+YD4FJ4cHlPy2yWnNu2/lCk+9iRO2s=;
        b=zZQpzrMAR+xwKfIxsftvQTj0GCo1L9H6jPFJaGXy2562ukbLjZ39nDC4WQUAXWminF
         REtg4boim52dqJT65vtVwaQTI/l3rkaYNnaOPduVnSE9Sc/Z6HRN+xbtT+SzTh9ItydL
         kZKGzIkOXWe0APOuY3+i+KduhMhJW2KNaRUXw0Qz+sExFe/1WYvI1/57yY3GHBlRSjxX
         UdK2IDULMse5s8z22LKdDEqX/6nZiKWCl0yXiEilAWPSovtjXrRimixZxCZu++uLwe6B
         KBMxkUPT2cvQB0ckW5FwjZz0Hwe5ROJ3w8MnFuRayWXptVZ7gBaJ8oDXE329tYJFk74Q
         QLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gBXsGXhszxIuz+YD4FJ4cHlPy2yWnNu2/lCk+9iRO2s=;
        b=I7JMRajw4/I8FCQaE1aHwyAe2SUc6UlJHV6wdhOqsIyuRB7CiWiRv5UO2MdvlAVP26
         5ERGAik0I4PLJSIFcq+gYQugoGyh0972S9Sp4N8OngzQRA1/yfk/tqIDJxr71g2xRE//
         pEr/gJcux5j3rTDZPzlhqhHZYYLFKRBjpgDAethkvTpzNuoPoz021HE5S1n0DrQWJd/F
         0gdGGiSYkwEmmB9/gQhYLtUwpbEnqMo+tMPT1acFjBrnqSDntv3KiNvhUBH5xn8Ql4Py
         OYVF9eNul20opVHcdwH8FcWR6SLs7yuaETI0jC6d8VMtrsEcfK2IEfLDw3hkro84JllO
         BK0A==
X-Gm-Message-State: AHQUAuZwbRGH1JnzujvKmPUn7f0YMydVyAcLCiZtvn3jyHcNtMxPw7pC
        4rOznmxW7kkWMehEv3sGIrzDCQ==
X-Google-Smtp-Source: AHgI3IbGEJbbm98Or9/MoSlapKTcThTjHL+oO2B1dH4l6kL7/swdeE0MXkjnP/y9rl2BZrE5XJ4M/A==
X-Received: by 2002:a1c:27c6:: with SMTP id n189mr3415514wmn.108.1549737210838;
        Sat, 09 Feb 2019 10:33:30 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id a144sm10312354wmd.30.2019.02.09.10.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:33:30 -0800 (PST)
Date:   Sat, 9 Feb 2019 19:24:18 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 10/16] rocker: Handle SWITCHDEV_PORT_ATTR_SET
Message-ID: <20190209182418.GR2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-11-f.fainelli@gmail.com>
 <20190209182147.GQ2353@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209182147.GQ2353@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 07:21:47PM CET, jiri@resnulli.us wrote:

[...]

>>+static int
>>+rocker_switchdev_port_attr_event(unsigned long event, struct net_device *netdev,
>>+				 struct switchdev_notifier_port_attr_info
>>+				 *port_attr_info)
>>+{
>>+	int err = -EOPNOTSUPP;
>>+
>>+	switch (event) {
>>+	case SWITCHDEV_PORT_ATTR_SET:
>
>Do you expect some other event to be handled in
>rocker_switchdev_port_attr_event()? Because you have SWITCHDEV_PORT_ATTR_SET
>selected in case here and in rocker_switchdev_blocking_event.
>Perhaps you can rename rocker_switchdev_port_attr_event() to
>rocker_switchdev_port_attr_set_event() and avoid this switchcase.

Same comment applies on next 4 patches.
