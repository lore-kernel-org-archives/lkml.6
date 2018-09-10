Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5BCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0982D206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0982D206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIJMCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:02:53 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48470 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJMCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:02:53 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fzGKs-0007bL-FU; Mon, 10 Sep 2018 09:10:14 +0200
Message-ID: <1536563406.3224.2.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless: remove unnecessary condition check before
 kfree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Sep 2018 09:10:06 +0200
In-Reply-To: <1536415955-33776-1-git-send-email-zhongjiang@huawei.com>
References: <1536415955-33776-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-09-08 at 22:12 +0800, zhong jiang wrote:
> kfree has taken the null pointer into account. Just remove the
> redundant condition check before kfree.

I'm all for doing that if it actually removes conditionals, but

> -	if (!IS_ERR_OR_NULL(regdb))
> +	if (!IS_ERR(regdb))
>  		kfree(regdb);

this seems rather pointless since there's still a condition. In that
case, I feel it's easier to understand the original code.

johannes
