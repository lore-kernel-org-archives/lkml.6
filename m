Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2bxmBZqAHlsHcgAAmS7hNA
	; Mon, 11 Jun 2018 14:04:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1E31D607A4; Mon, 11 Jun 2018 14:04:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="aACAxKmc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7EC756074D;
	Mon, 11 Jun 2018 14:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EC756074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933444AbeFKOEW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:04:22 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:54108 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933223AbeFKOEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zJB73XS7lUbPrg7oRQIuf+fw3UTmxPtdyzlhlVF9Igo=; b=aACAxKmcQnKIUncm37R2EJavih
        9EgQE/s9zEaY8fkLI3pO3745nzJzlribwhW0fXqwc0co6Jp+FAtUe8QDyS9qx51u4LN30WSv2njut
        nuJ/WNK3+V+YLxZfiouiA2wFMMW44gxhhWIDYYzUMUVEeZUINmg6Ho98txHI/iTeURDA=;
Date: Mon, 11 Jun 2018 10:06:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] swap,blkcg: issue swap io with the appropriate
 context
Message-ID: <20180611140635.GA1507@cmpxchg.org>
References: <20180605132948.1664-1-josef@toxicpanda.com>
 <20180605132948.1664-6-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605132948.1664-6-josef@toxicpanda.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:29:40AM -0400, Josef Bacik wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> For backcharging we need to know who the page belongs to when swapping
> it out.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
