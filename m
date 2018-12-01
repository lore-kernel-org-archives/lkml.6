Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070C7C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD59021473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD59021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLAM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:29:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36840 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLAM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:29:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6BEAA14F2407A;
        Fri, 30 Nov 2018 17:18:09 -0800 (PST)
Date:   Fri, 30 Nov 2018 17:18:08 -0800 (PST)
Message-Id: <20181130.171808.92319030357740168.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: Fix tagging attribute location
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181128214012.16397-1-f.fainelli@gmail.com>
References: <20181128214012.16397-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Nov 2018 17:18:09 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 28 Nov 2018 13:40:04 -0800

> While introducing the DSA tagging protocol attribute, it was added to the DSA
> slave network devices, but those actually see untagged traffic (that is their
> whole purpose). Correct this mistake by putting the tagging sysfs attribute
> under the DSA master network device where this is the information that we need.
> 
> While at it, also correct the sysfs documentation mistake that missed the
> "dsa/" directory component of the attribute.
> 
> Fixes: 98cdb4807123 ("net: dsa: Expose tagging protocol to user-space")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
