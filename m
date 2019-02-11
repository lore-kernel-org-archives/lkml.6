Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A99C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D965720818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="UVCQpeKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfBKM3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:29:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51147 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfBKM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:29:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so1582699wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jIxRTJEboWiB5yUpWcBi5gwx/8yOoh7zT+NO1snmFmo=;
        b=UVCQpeKZLTkOQ70p4HITaHw9LHQgjxH6ZkAeTBcRAN7OK25vcyD7/VNToMn0UhueGv
         EXK0vYBm9qqhM+3sGXCHCMc8zw+UPsoZNzqmZVh31bMNhbozE/fU6MG3849vkFsoukrr
         3by7gWYw9aqdMHk0DJHZBEcBm5kXC8N+n8cM0Mr4b4VHvl3hAR4PPzDSA64s/nVCCnV6
         fXQVT40sx8+MiKT2J6daXSPT+g9ic4VmNt1K2hJaa8FqQqZomdVzE4+YXrHTlQ2+7lF9
         29s1ov0hLw2RjMUhIm4fGtJh/rA0MLWxpelNJ+PxmBMXQHCUP3FXvBpdjj2FC3ufRXm7
         POxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jIxRTJEboWiB5yUpWcBi5gwx/8yOoh7zT+NO1snmFmo=;
        b=J/6GmolZ6vlllJyIydnkRzbqCLQzt1/KsDfw9rJwTud7LIPvhJQ7Trh2Ee0sqYOPmU
         jDCmC16IIFss1ZQrwsXPQGMgm38qQ0DB56CkGhhuFRO+W7OuHc1m+nWfX1dURtMWg5bZ
         5pLocwQlI6tCKkLTrx5idQS15ioo3TggbtIbUhG5F8jv94reFyHh1Kk8W4a4PYTMsXJZ
         wBoDoHONIE3k18UM5+5GJjXcbXQQ85xAJd/dpCnJm3TnZjNDs0sBHK2QZe5mZm3AUTwP
         O/VqWoKvqQjqXmMqmJEuGsuimMGb/eAojMLd1FMnNYhnvWjthQYxRRv9nssu1bLQdDsm
         B9/A==
X-Gm-Message-State: AHQUAuZudasWNPJaAQT6Lh0lWtswXJ6NSE0MgL2fC6tbmEHNws6llSj+
        3WLH4UupDci47zbCrMYFTsNY7A==
X-Google-Smtp-Source: AHgI3Ia0RLapkklfpHEsBn59uRxRNCQetjynMNNzyVYHt4P8s/mKmunLtMlAPGZ/rnoV0y4Mu3701Q==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr956682wmc.82.1549888158013;
        Mon, 11 Feb 2019 04:29:18 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id t4sm11614211wrb.64.2019.02.11.04.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:29:17 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:19:54 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 2/9] switchdev: Add SWITCHDEV_PORT_ATTR_SET,
 SWITCHDEV_PORT_ATTR_GET
Message-ID: <20190211121954.GE2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:40:00AM CET, f.fainelli@gmail.com wrote:
>In preparation for allowing switchdev enabled drivers to veto specific
>attribute settings from within the context of the caller, introduce a
>new switchdev notifier type for port attributes.
>
>Suggested-by: Ido Schimmel <idosch@mellanox.com>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
