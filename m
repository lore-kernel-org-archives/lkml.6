Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE1BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB29208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tgBnXJiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB29208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeHBEXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:23:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeHBEXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0ARTojSIDQ6SD6TMdu6XS54/k2JLZPyXvzW7r/W2lGw=; b=tgBnXJiHVef2mGBrPytMGUtFu
        E63oUORsG/GgYqPo6Hz3gXOvix4pF3NpAjW9WzFuSmPsMQ8mUH16B+DchVQOozg2xxkvdiXSLkBEg
        AZPL6yrtL6ljO9rtM+a6s7MC5PrGkfJo0Roq0ficAjWyruYkwdyI1FiCbdfJlU84ddz3Cc/Ns0bq/
        FhVpc/j79Ntf32FiZqvb97D8gsMz8zbU5VLf3leX6sJChiU9fYivxTQK4Gl7bIH3fOrVxfs0Q8zI8
        U/RjI71JIntVqPsvbgJB6p+pPNRQxrfiEeJod4JZYvV+REII53Yx3XNYmOV28QnLOrf14ZDNdBlJu
        CPgPQjmvQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fl3RM-0005eI-Os; Thu, 02 Aug 2018 02:34:12 +0000
Date:   Wed, 1 Aug 2018 19:34:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/binfmt_elf: remove the same condition check
Message-ID: <20180802023412.GA25338@bombadil.infradead.org>
References: <1533175228-17547-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533175228-17547-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 10:00:28AM +0800, zhong jiang wrote:
> dump_align is used to double check in a expression. It is redundant.
> so just remove one of them.

You're wrong.  Functions in C can have side-effects (and this one does).
