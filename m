Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8221ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3526214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UxMJS++f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3526214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeIQThu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:37:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uts/hVjX78tHMfHc3q3KWjUUgKPrXsU4eGL/P0z4EHA=; b=UxMJS++fk9tG7rC/sNEHNNu9p
        QjCpUCPVjXe2qIS9GwdZrdmFArc6qcfzyPI4029FYqCqMYFdsOTkqHE/Aa8bVgXxTfZFemBnRQKzi
        iuMDiSf0hi4Y9ZrVZQ0rpeBtQYnOaVLPraV21/yF7wWZt5pZmcRkWpGpzVwmzskl4fA+XzEHyhROI
        BqzJDXA9aqMRWaGSx3vukUVc+myN2mhVCJJ61Cc5o3OtIBKSyZY4NLWbBEt4rdozutdnnNI2s1yfk
        VijdH6d+qOuHIDS2XjbNihVmLtC5LdLJMCtsCj9oTqmJHdDbN9KknOY/Xbbm0zt53AiHSHRNA5zbD
        UfFetf5Jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1uEE-000093-Nf; Mon, 17 Sep 2018 14:10:18 +0000
Date:   Mon, 17 Sep 2018 07:10:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Show CPU ID and Hart ID separately in
 /proc/cpuinfo
Message-ID: <20180917141018.GB28689@infradead.org>
References: <20180912143822.21948-1-anup@brainfault.org>
 <72961c71-c4e4-7990-da64-a7f1613f2e1c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72961c71-c4e4-7990-da64-a7f1613f2e1c@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:47:55AM -0700, Atish Patra wrote:
> The extra hart information will not be parsed by lscpu which will make the
> cpu information inconsistent between lscpu & /proc/cpuinfo.
> 
> Should we patch lscpu as well to show correct hart id as well ?

It would be good to follow whatever prescedent other architectures
with different logical vs physical cpuids have set.
