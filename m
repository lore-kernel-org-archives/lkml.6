Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A081DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5741F21719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8cNRwBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5741F21719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeHHInB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbeHHInB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:43:01 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3729A216F7;
        Wed,  8 Aug 2018 06:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533709491;
        bh=8bD+qOTI6QBvimakfbv6M+CVCxCUhTYdAPOIdLRHbU8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=E8cNRwBZzQ0Bgc631hnrDcrPHcynDTLTm7cQ+0bGWQe/Bp09ft+uyOMBBip3bImoL
         9O1sguKrlG05cMoamacC6oNBwHMNOJnCBxs9O/t4jp5kitzRzECkfVcs7DSkrfwizD
         jpRDVueEgz/04iuw2S1205Ue9YOwYiC048SyNyoo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180802001435.116963-1-mka@chromium.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20180802001435.116963-1-mka@chromium.org>
Message-ID: <153370949062.220756.17724147096194635522@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] scsi: ufs: Check workqueue exists before destroying it
Date:   Tue, 07 Aug 2018 23:24:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-08-01 17:14:35)
> In ufshcd_hba_exit() the clock gating workqueue is always destroyed
> when clock gating is supported. However the workqueue pointer is NULL
> when ufshcd_init() fails before the workqueue is created. Only destroy
> the workqueue if it exists.
> =

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Any sort of Fixes: tag?

