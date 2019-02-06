Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9CCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972CD20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="UeFfIuyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfBFNgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:36:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32861 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbfBFNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:36:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so1841784wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NEvHq8EuxGMgrB3WuwQcfqJfJGn5IKHVBYmtcFHCs3M=;
        b=UeFfIuyGIV4VSmAPrHi7oZiS6fS/u/EU90th/rk5b6XzT++8wD+QxV+5hygyJo/7wG
         PYF3+/YvDv1GhwwOOZMQbYxy9tV+k4f+SVnoxTedKS70TXee6ZjroH4U7w/fj71vFEWF
         /RzQJdU2HjO2Xfgmg2c2cc/qtvUdx77EMp46h3Hc+TbDHTEIcg45eXuSMJsNXjQoI2P+
         kDkB15e9UollLyoOgI6vK8LInQqdFYasCPVYG0u1PcII9yqwNH0J7vM7zXoQlxYOcXQ3
         8e358NCQSJNiOMUdpMMaCSIodBLG8NICy960nIrk1gM86aJIjsAT7TDRttpz5BaUIJW4
         UMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NEvHq8EuxGMgrB3WuwQcfqJfJGn5IKHVBYmtcFHCs3M=;
        b=TNUtYg6TB7OpVVvpzo5lTmMoGe6y8gdlG6xwrKdREhdhZWySO232vYAsg3JQaxCwdi
         VncE0FFJzmRWrYD5/Huq93ijuY/GLo8vmqGPQ/4bJHVjcp1Sg00T/dMNV9gKQTUNy3tC
         kcfVnoNdp0a9BBWRnTgcIzj4lGlAiXNwyth8F21TsQF0Xx1Ojt2ZpSD46L++bO1gH4x0
         +ReHUfp+9n7p8sOKgQg7YtWl4WpeGmHuKBYwoijnxoPMqkdNDmDy65CZvujaOvr+DphY
         M094kkFufV2P59GuHVvEDsqfQ5twcNXddfmrQvcf0VXUuC1dZc6G9veOdo80mmGOYNrq
         ad3Q==
X-Gm-Message-State: AHQUAuYKKWWgjn8FXiNgLNrkmjiazsFZEcIKOomWTmSg7thOasmaX3FZ
        kr+bqX5UBvUdy8J8VbgQb7u5sQ==
X-Google-Smtp-Source: AHgI3IYMMTQ7Rf8i9un310LpLVy2ocAHeQE7mWF4EKOxmdpkC2NbsTZyFpEY5fm20KhkfGmHv8IaJA==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr2464120wmk.70.1549460178876;
        Wed, 06 Feb 2019 05:36:18 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id j124sm16951825wmb.48.2019.02.06.05.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:36:18 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:27:07 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 11/12] net: dsa: Implement
 ndo_get_port_parent_id()
Message-ID: <20190206132707.GK2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-12-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-12-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:25AM CET, f.fainelli@gmail.com wrote:
>DSA implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
>of switchdev_ops eventually, ease that migration by implementing a
>ndo_get_port_parent_id() function which returns what
>switchdev_port_attr_get() would do.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
