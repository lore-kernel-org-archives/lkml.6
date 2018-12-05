Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA43C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E4F20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6TyLBOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E4F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeLEIIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:08:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEIIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:08:14 -0500
Received: from localhost (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2A32084C;
        Wed,  5 Dec 2018 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543997293;
        bh=Rm/lvRzuUOV7SnM8Hz0FnBd0bFlW8+lIhYnbVz37f6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6TyLBOHV5kUv6XyEI/SEJ8UHCd8iy+H/8DYOZEEj36xAU2352AKdb3M7+9QCFbxd
         9IxjQrQTyv5dSU2+AAi9fkrBpsu5IjPnlUGvKm+h0BadxiOqgcVhJGNPZRXTMdUmLJ
         wbKcQejVtNLHvYRkhDGB4gUhSciWJh4KIIhMBZrw=
Date:   Wed, 5 Dec 2018 13:38:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: fix a small memory leak in
 dmatest_func()
Message-ID: <20181205080804.GD2847@vkoul-mobl>
References: <20181203144933.uwkmm2sjs434t322@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203144933.uwkmm2sjs434t322@kili.mountain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-18, 17:49, Dan Carpenter wrote:
> We recently moved the test size tests around but it means we need to
> adjust the error handling as well or we leak the "pq_coefs" memory.  I
> updated the label name to reflect that we're freeing coefs.

Applied, thanks

-- 
~Vinod
