Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F83ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AC721523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OorfAQ8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AC721523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbeIUM2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:28:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389179AbeIUM2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AcIv6rIlCpZ5VAdRl87Hu3OKikDuPX/rItM+yoKpXgk=; b=OorfAQ8xEueNvL9sHMhvF4kwF
        2VQQKkjcdVyWCVDFVGGZLXj5G92P20TwCZJOaxPYT9w/3zVhQ42vM/n8CLAsJQrEdI0hNvPqvramG
        N7BJn2OVNH8UjhNJ0hUbN3EUBd4x/2jq9nK+twRe9k58hBEmVcQn62p/Wfs8aTRLbI44f1GsO15kT
        bnjnUwFdcTcXZbBexI8ta1kvQEw87s8r4JwV+Fokbr6MZumTylk03Ix10CnnH0rNYCee8NYptBMdt
        orWBnT86tRWphvPJaydOwfoXhHfGDbOn7xpxo+TDlmmkUNTgEVnwl6/qH2qo9hahIaTRBY7pG/5Qe
        hwqExT9Ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3F7G-0006rS-HG; Fri, 21 Sep 2018 06:40:38 +0000
Date:   Thu, 20 Sep 2018 23:40:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to recover inode's uid/gid during POR
Message-ID: <20180921064038.GA21481@infradead.org>
References: <20180920094130.124622-1-yuchao0@huawei.com>
 <20180921060629.GA13865@infradead.org>
 <f2479038-3e4e-63e3-083e-d125b4a4d919@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2479038-3e4e-63e3-083e-d125b4a4d919@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 02:20:49PM +0800, Chao Yu wrote:
> No problem, I just plan to.
> 
> Out of curiosity, are you filter some key words like 'recover' in your
> email client to find this so quickly?

No, I just do a quick glanceof lkml every morning, and this just caught
my eye.
