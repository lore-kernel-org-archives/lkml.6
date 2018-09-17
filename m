Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCCBECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE248214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE248214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeIQNHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:07:14 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39160 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeIQNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:07:14 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g1o9T-0008Lj-Ob; Mon, 17 Sep 2018 09:40:59 +0200
Message-ID: <1537170050.2957.1.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix issue with possible txq NULL pointer
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Sep 2018 09:40:50 +0200
In-Reply-To: <20180914160034.2753-1-erik.stromdahl@gmail.com> (sfid-20180914_180044_364636_63E0B0A6)
References: <20180914160034.2753-1-erik.stromdahl@gmail.com>
         (sfid-20180914_180044_364636_63E0B0A6)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-14 at 18:00 +0200, Erik Stromdahl wrote:
> Drivers that do not have the BUFF_MMPDU_TXQ flag set will not have a
> TXQ for the special TID = 16.
> 
> In this case, the last member in the *struct ieee80211_sta* txq array
> will be NULL.
> 
> We must check this in order not to get a NULL pointer dereference when
> iterating the txq array.

Uh, yes, thanks. This is my fault - I merged the overlapping patches
closely together.

johannes
