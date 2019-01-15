Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DDAC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ABF204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F258RlYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfAOP0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:26:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbfAOP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kneFJsa1Lswy9ul15fp467Eov8UvQNCI+hahk1evOYY=; b=F258RlYi7CWVFsURqw8Qd/lr5
        BUpl2QpOv2ibBFmV3WjhMlCWfX4zyP/CUxi43oHAmuq9apvnOhXpiteGm1biyqqqWjtKxfZHav6G0
        ouBO5t84prWhhInpZgwUdXpXL9oZD2+kjrGFsvnNPKjZNksfVAJjVDASc0VJiLysNYhhWYCpqgajg
        UqjbmRIMXWe7H453jB94KQ/eq9JSMkNuwylQzth0G6J2tXSu/zkuQwF2ePYJYBcgzqU5ksccn1XT6
        jUq+ZS6e7az43ETvbpgrZeQ1StYNa/Wku11lISXyJBs6wQGyJgM4omcIz/GxFMuJDcTrdodLdyp81
        PGEHo0oVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjQbP-0007EJ-EA; Tue, 15 Jan 2019 15:26:07 +0000
Date:   Tue, 15 Jan 2019 07:26:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] RISC-V: defconfig: Enable Generic PCIE by default
Message-ID: <20190115152607.GA26443@infradead.org>
References: <20190112004117.28265-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112004117.28265-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 12:41:26AM +0000, Alistair Francis wrote:
> Enable generic PCIe by default in the RISC-V defconfig, this allows us
> to use QEMU's PCIe support out of the box.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Alistair, is there a ready-made qemu machine with riscv + pcie?
That would be really useful for testing..
