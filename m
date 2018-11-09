Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9AA20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9AA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeKIMv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:51:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41996 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeKIMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:51:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A2BCA14B3D57D;
        Thu,  8 Nov 2018 19:13:20 -0800 (PST)
Date:   Thu, 08 Nov 2018 19:13:20 -0800 (PST)
Message-Id: <20181108.191320.1503108955211963619.davem@davemloft.net>
To:     robh@kernel.org
Cc:     frowand.list@gmail.com, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 3/8] sparc: prom: use property "name" directly to
 construct node names
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181107223151.14991-4-robh@kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
        <20181107223151.14991-4-robh@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Nov 2018 19:13:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Wed,  7 Nov 2018 16:31:46 -0600

> In preparation to remove direct accesses to the device_node.name
> pointer, retrieve the node name from the "name" property instead.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

On some 32-bit sparcs, the OF runs in non-cached memory.

Sucking in the OF device tree take a signficant amount of the
boot time on such systems.

And these changes are going to make it even slower.

Please just put a wrapper around dp->name or whatever and use that,
instead of making more get property OF calls which can be very
expensive.
