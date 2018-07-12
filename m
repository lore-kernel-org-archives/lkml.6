Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D94ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66BC2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66BC2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeGLV4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:56:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43218 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeGLV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:56:36 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2264D1420D3B2;
        Thu, 12 Jul 2018 14:45:08 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:45:07 -0700 (PDT)
Message-Id: <20180712.144507.982978521957929138.davem@davemloft.net>
To:     vakul.garg@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        borisp@mellanox.com, aviadye@mellanox.com, davejwatson@fb.com
Subject: Re: [PATCH net-next][RESEND] net/tls: Use aead_request_alloc/free
 for request alloc/free
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180711090220.14697-1-vakul.garg@nxp.com>
References: <20180711090220.14697-1-vakul.garg@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Jul 2018 14:45:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vakul Garg <vakul.garg@nxp.com>
Date: Wed, 11 Jul 2018 14:32:20 +0530

> Instead of kzalloc/free for aead_request allocation and free, use
> functions aead_request_alloc(), aead_request_free(). It ensures that
> any sensitive crypto material held in crypto transforms is securely
> erased from memory.
> 
> Signed-off-by: Vakul Garg <vakul.garg@nxp.com>

Applied, thanks.
