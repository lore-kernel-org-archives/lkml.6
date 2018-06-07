Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /RyqD0+UGVvCXQAAmS7hNA
	; Thu, 07 Jun 2018 20:24:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5A4C6089E; Thu,  7 Jun 2018 20:24:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5510760452;
	Thu,  7 Jun 2018 20:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5510760452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932490AbeFGUYw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:24:52 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33930 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932212AbeFGUYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:24:48 -0400
Received: from localhost (unknown [66.187.232.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5876410870464;
        Thu,  7 Jun 2018 13:24:45 -0700 (PDT)
Date: Thu, 07 Jun 2018 16:24:43 -0400 (EDT)
Message-Id: <20180607.162443.917679158498262601.davem@davemloft.net>
To: decui@microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        netdev@vger.kernel.org, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, vkuznets@redhat.com,
        marcelo.cerri@canonical.com, jopoulso@microsoft.com,
        Stephen.Zarkos@microsoft.com
Subject: Re: [PATCH v2] hv_netvsc: Fix a network regression after
 ifdown/ifup
From: David Miller <davem@davemloft.net>
In-Reply-To: <KL1P15301MB00062D55F01921B958359A55BF650@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB00062D55F01921B958359A55BF650@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Jun 2018 13:24:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 6 Jun 2018 21:32:51 +0000

> 
> Recently people reported the NIC stops working after
> "ifdown eth0; ifup eth0". It turns out in this case the TX queues are not
> enabled, after the refactoring of the common detach logic: when the NIC
> has sub-channels, usually we enable all the TX queues after all
> sub-channels are set up: see rndis_set_subchannel() ->
> netif_device_attach(), but in the case of "ifdown eth0; ifup eth0" where
> the number of channels doesn't change, we also must make sure the TX queues
> are enabled. The patch fixes the regression.
> 
> Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied and queued up for -stable.
