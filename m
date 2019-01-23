Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108FDC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5424217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAWBSg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:18:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38738 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfAWBSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:18:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8147F101FC9C1;
        Tue, 22 Jan 2019 17:18:35 -0800 (PST)
Date:   Tue, 22 Jan 2019 17:18:32 -0800 (PST)
Message-Id: <20190122.171832.1199555290239452595.davem@davemloft.net>
To:     linus.luessing@c0d3.blue
Cc:     netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, bridge@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] bridge: implement Multicast Router
 Discovery (RFC4286)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190121062628.2710-1-linus.luessing@c0d3.blue>
References: <20190121062628.2710-1-linus.luessing@c0d3.blue>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 22 Jan 2019 17:18:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Lüssing <linus.luessing@c0d3.blue>
Date: Mon, 21 Jan 2019 07:26:24 +0100

> This patchset adds initial Multicast Router Discovery support to
> the Linux bridge (RFC4286). With MRD it is possible to detect multicast
> routers and mark bridge ports and forward multicast packets to such routers
> accordingly.
> 
> So far, multicast routers are detected via IGMP/MLD queries and PIM
> messages in the Linux bridge. As there is only one active, selected
> querier at a time RFC4541 ("Considerations for Internet Group Management
> Protocol (IGMP) and Multicast Listener Discovery (MLD) Snooping
> Switches") section 2.1.1.a) recommends snooping Multicast Router
> Advertisements as provided by MRD (RFC4286).
> 
> 
> The first two patches are refactoring some existing code which is reused
> for parsing the Multicast Router Advertisements later in the fourth
> patch. The third patch lets the bridge join the all-snoopers multicast
> address to be able to reliably receive the Multicast Router
> Advertisements.
 ...

Series applied, thanks!
