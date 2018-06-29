Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D4DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01390248DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CFWM8z+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01390248DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932517AbeF2HIs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:08:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932332AbeF2HIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GTQTWzVj+w34pTdO9ou1Ci/poFKn8CcYpvyPNYktK3s=; b=CFWM8z+yEb45kRxo2qFWvVrcD
        9D3RHuicBpokGQv3/+ZpZ9rD+rslAtm1ZDOm/ymwzvPKOZOUBlpc3QPIRp6/PtFdfn+DXHmMaFukV
        bR+8hEz9g0T+8cs0PVMsGySNLlGHBB+QpKgsLc6MNonvwVYWhCQvClAA9hTNp3cKcMCGCSsPKwpEi
        uKP3u0HK69cH9+UsF3TSpy0ipr9bl43A0s0vnMb2wsamhxLCvEdf7yqZT0KwKVDI8sCfrgDx7Hhml
        8NDdPCyGg/9NmLaep44Bq9GPaxoV1Riyd+bTU6HCAdgkumDiIsqGW2M0ARjNY/x3e5I4WKOXQigW4
        9mS7bw6JA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYnWO-0003ZL-Iv; Fri, 29 Jun 2018 07:08:44 +0000
Date:   Fri, 29 Jun 2018 00:08:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong@andestech.com>
Cc:     palmer@sifive.com, hch@infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zongbox@gmail.com, greentime@andestech.com
Subject: Re: [PATCH v2 2/4] RISC-V: Select GENERIC_UCMPDI2 on RV32I
Message-ID: <20180629070844.GB12956@infradead.org>
References: <cover.1529915117.git.zong@andestech.com>
 <e83cbb33e4b72fdef56bfe396131474040a194b7.1529915117.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83cbb33e4b72fdef56bfe396131474040a194b7.1529915117.git.zong@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:49:38PM +0800, Zong Li wrote:
> On 32-bit, it need to use __ucmpdi2, otherwise, it can't find the __ucmpdi2
> symbol.
> 
> Signed-off-by: Zong Li <zong@andestech.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
