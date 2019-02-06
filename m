Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618D8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7FC218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfBFWSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:18:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37096 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:18:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5388514016582;
        Wed,  6 Feb 2019 14:18:11 -0800 (PST)
Date:   Wed, 06 Feb 2019 14:18:10 -0800 (PST)
Message-Id: <20190206.141810.950568527074058350.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next v4 00/12] net: Introduce
 ndo_get_port_parent_id()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190206.135050.939253959263316807.davem@davemloft.net>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
        <20190206.135050.939253959263316807.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Feb 2019 14:18:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 06 Feb 2019 13:50:50 -0800 (PST)

> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Wed,  6 Feb 2019 09:45:34 -0800
> 
>> Based on discussion with Ido and feedback from Jakub there are clearly
>> two classes of users that implement SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
>> 
>> - PF/VF drivers which typically only implement return the port's parent
>>   ID, yet have to implement switchdev_port_attr_get() just for that
>> 
>> - Ethernet switch drivers: mlxsw, ocelot, DSA, etc. which implement more
>>   attributes which we want to be able to eventually veto in the context
>>   of the caller, thus making them candidates for using a blocking notifier
>>   chain
>> 
>> Changes in v4:
>  ..
> 
> Series applied, thanks Florian.
> 
> I'll push this out to net-next after my build tests complete.

I had to remove the unused variable 'rocker' to kill a warning introduced
by patch #8.

Just FYI...
