Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C8FC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC4120836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y6KlvPtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC4120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbeFTAUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:20:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFTAU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rdgZ7sCQDqc6ECiDVErWi9g08tB50NrZGVKu+RigMJA=; b=Y6KlvPtnxji70njKRvP3FbNA0
        g/3C1VvJyBeBgj0+iCemAAkfr1iNkfTqfZasngCYN1fE6R3V0f4cLCnwnoEA01ZtQsjKGslgAx5nI
        fFpw6rrvK0aFFez7eHi6EoNQYqpsfdMjrqOzLeZ96fzZSsEonuW6vt6c3lgj4Vp31W7p99NMi1UD0
        +7972B65EMPrLGSjWLxrSABQgu1SmjwQkBWFClnOR0FQfCJX8M4j2iFXCpVj57s9nh/1ihO9P5fdM
        lx5OnpavJbZJz5OyvjIcsRNGyJAX5iAydhvpvbVyQSROPjy1pjeEoGl0hynUxvkj0NzE7hqL7pmdS
        vEvjZKGYA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVQrM-00075Z-15; Wed, 20 Jun 2018 00:20:28 +0000
Date:   Tue, 19 Jun 2018 17:20:25 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Vadim Pasternak <vadimp@mellanox.com>, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, jiri@resnulli.us,
        michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v6 6/8] platform/mellanox: Introduce support for Mellanox
 register access driver
Message-ID: <20180620002025.GC11460@fury>
References: <1529254615-88124-1-git-send-email-vadimp@mellanox.com>
 <b804ccc4-77c3-e7a9-9486-8d12d50ec5f7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b804ccc4-77c3-e7a9-9486-8d12d50ec5f7@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 09:52:16AM -0700, Randy Dunlap wrote:
> On 06/17/2018 09:56 AM, Vadim Pasternak wrote:
> > diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
...
> > +	  space trough sysfs interface. The sets of registers for sysfs access
> 
> 	        through
> 
> > +	  are defined per system type bases and includes the registers related
> 
> 	                                    and include the
> 

I've taken care of these, thanks Randy, and applied the series to my testing
queue. Once the builds complete, I'll move these to for-next.

Vadim, I see you've already updated the kernel version in the sys documentation
to 4.19, so I won't attempt to push these into the 4.18 RC cycle.

-- 
Darren Hart
VMware Open Source Technology Center
