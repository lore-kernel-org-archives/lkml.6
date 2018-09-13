Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76769FC6181
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E7921527
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E7921527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeIMVOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:14:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50456 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeIMVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:14:21 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A30DA13FDD203;
        Thu, 13 Sep 2018 09:04:12 -0700 (PDT)
Date:   Thu, 13 Sep 2018 09:04:10 -0700 (PDT)
Message-Id: <20180913.090410.1329696288697398656.davem@davemloft.net>
To:     vasilykh@arista.com
Cc:     roopa@cumulusnetworks.com, adobriyan@gmail.com,
        edumazet@google.com, stephen@networkplumber.org,
        jwestfall@surrealistic.net, w.bumiller@proxmox.com,
        anarsoul@gmail.com, keescook@chromium.org, ihrachys@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] neighbour: confirm neigh entries when ARP packet is
 received
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180911180406.31283-1-vasilykh@arista.com>
References: <20180911180406.31283-1-vasilykh@arista.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 09:04:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <vasilykh@arista.com>
Date: Tue, 11 Sep 2018 11:04:06 -0700

> Update 'confirmed' timestamp when ARP packet is received. It shouldn't
> affect locktime logic and anyway entry can be confirmed by any higher-layer
> protocol. Thus it makes to sense not to confirm it when ARP packet is
> received.
> 
> Fixes: 77d7123342 ("neighbour: update neigh timestamps iff update is
> effective")
> 
> Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
> ---
> v2: - update comment to match new code.

Please fix the wording in this commit message, as per Sergei's
feedback.

Also, the Fixes: tag should be all one line (people grep for these
strings in the repository) and with no empty lines between it and the
rest of the tags such as Signed-off-by:

Thanks.
