Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DA1218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="CtUHcEzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBKMtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:49:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52880 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfBKMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:49:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so17562265wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=80MVU5byieRQ94ouyCQrnHT9UeWUF1wGlI/rU+Uki4E=;
        b=CtUHcEzqamlPSw20NfrdwePGfvI8mG2khfdUY76EQ9eDBaOPGbb2hdNpi+8My2379R
         Hb+XBFrjpA3/HgOxxEpD9DJfkAEthvDrdWS5O+HWP9XmaVXqOe5iyFieW/gN+cWrKieC
         iCJGkVHd89HeOfXvp9IlLfCjmoiYw6ulHHjqg8TYNYW1wMC4FozSs+xrGXZ6j5XinAmW
         QNhfBBlErVLyK4LvrekpDfgQmrQSjFXtzIFzRez+1ayhJntpleUXPZAdWNObgl7iLwSb
         MI3UKCkOix5GntOQmT0bv8U+sjhtHlgzgAR68TSqIy84uUPUptePAaB/FO4tdmTaZoBL
         jxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=80MVU5byieRQ94ouyCQrnHT9UeWUF1wGlI/rU+Uki4E=;
        b=XW00eYfryOqwCD94NwKdcGQcLPzM5EJ1G27V5EV3LTToR6l7DHeBjkrYf7Ih3se/yc
         1j8VU6c3Y6bMGG84imb7KsUDVpculmlIDYvqbnC0UeECslQgmePd6fTKnf7Ep5EmGpuy
         aVmqhLl3cHkLB9q4ct10wBuBmMOnzm38V2nBoreVmJ8tHd4YzZDebKJX3R/poIExNr2Z
         pJm15BNavrNCB89kOpAVKUjb9MiAf1gb7KQhPRzbcIBOX/ziRHcDKb4DEa1lRURl6fF6
         TRZQeBYHxmgZBTNDJGA1FakcfZ/BZzOdzCVmJqlgSR+Uwqy7zkK9o5kOVghzkp/kVzYW
         qgLg==
X-Gm-Message-State: AHQUAuZ6WJLW8y1BK2Uc8jFR94FqE93nijw984qe0W7dAXOJ5HU4XPTj
        Bn6sUou/iInsod2YARZ04YKUSw==
X-Google-Smtp-Source: AHgI3IbMMETtW7Vnm2Ctl6GHaHGhyqlPft2zCDOI2Jpbf5tJmajXob1V9jgljtPu9+6Dtr0gG9Lzzg==
X-Received: by 2002:a1c:e71a:: with SMTP id e26mr1345122wmh.111.1549889342753;
        Mon, 11 Feb 2019 04:49:02 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id c9sm8746441wrs.84.2019.02.11.04.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:49:02 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:39:38 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 8/9] net: switchdev: Replace port attr
 get/set SDO with a notification
Message-ID: <20190211123938.GK2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-9-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-9-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:40:06AM CET, f.fainelli@gmail.com wrote:
>Drop switchdev_ops.switchdev_port_attr_get and _set. Drop the uses of
>this field from all clients, which were migrated to use switchdev
>notification in the previous patches.
>
>Add a new function switchdev_port_attr_notify() that sends the switchdev
>notifications SWITCHDEV_PORT_ATTR_GET and _SET.
>
>Update switchdev_port_attr_get() to dispatch to this new function. Drop
>__switchdev_port_attr_set() and update switchdev_port_attr_set()
>likewise.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
