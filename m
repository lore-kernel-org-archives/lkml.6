Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524E0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255BE2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXryfH5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404192AbfBMRlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:41:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390671AbfBMRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DcGFhf6h97NUpnAHIEvUVakzIIHc3VwZBTf+cXsB2o0=; b=GXryfH5sMVtephiO9ZVlv0dXc
        N36HVZqY215pX3wQRr4UeWrBGnQP0lo2miRGAUpUpzk94hWlKlVqH1W4ge8VGtr+j2Tf+pc82rG4U
        p3M/tA9xLLi06JpPoMZ8+nTEsVCY1Vbpg/HIQaAly0lxHDhZZxztHCAvJ+2nHj7wNQ6xAOpjhCK3H
        80Q3C/5TZzwgPnYJP7Xpll7u9lcJ+GcbSHRlmpeAZXwU955SvP50Jb86zjfHQBjgZMLt80OLaKw+2
        nLSQou1R1OvVp1NmY5T+Le+ev/eaShaI5Vs8K/Ih5U0RhracYhAgUQT9L9PfWyIUvDEg6oYjDQh5s
        Q2yu8P5Gg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyW7-0007Cv-D1; Wed, 13 Feb 2019 17:40:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: consolidate a few more arch support config options
Date:   Wed, 13 Feb 2019 18:39:54 +0100
Message-Id: <20190213174005.28785-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series moves various config options that are defined in multiple
arch Kconfig files into common files, usually close to the code
supporting such features.
