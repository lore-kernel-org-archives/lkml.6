Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E576160290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbeFFSBm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:01:42 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45444 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeFFSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:01:38 -0400
Date: Wed, 06 Jun 2018 14:01:35 -0400 (EDT)
Message-Id: <20180606.140135.1343207157647295023.davem@davemloft.net>
To: Julia.Lawall@lip6.fr
Cc: ariel.elior@cavium.com, kernel-janitors@vger.kernel.org,
        everest-linux-l2@cavium.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bnx2x: use the right constant
From: David Miller <davem@davemloft.net>
In-Reply-To: <1528290202-32454-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1528290202-32454-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed,  6 Jun 2018 15:03:22 +0200

> Nearby code that also tests port suggests that the P0 constant should be
> used when port is zero.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e,e1;
> @@
> 
> * e ? e1 : e1
> // </smpl>
> 
> Fixes: 6c3218c6f7e5 ("bnx2x: Adjust ETS to 578xx")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

This definitely looks correct.  Applied and queued up for -stable, thanks!
