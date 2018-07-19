Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EA2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3802084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AdoUsODt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3802084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbeGSNhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:37:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeGSNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cki9UydLl1Bpk5uwm4geE2pgDCRHkphWhSniRGmoErE=; b=AdoUsODtUwEUO2rHAXznyqjjy
        3iztUWfGvGGDX3fJn2vxBROMPOOB2SBWuSoGKiQD4q7ekNmdCQ2OH+2QL3mzHxJoBasx/C7Iple90
        3A/kjHI+cK+ARSgCysU5b/7SEub701FC+AVySCBIDcQ/2HW5+M8vNahaUYsoq85ywHIDmnpV3wHoK
        oXwxeaDrkep5F+ywqM+VkvLQSu8bzIXv5d7hsAz0HZnCvuxWvsNOXtbhgJOJmMczQxGxhBSEDr3K4
        aKCPcKwDYOy528CJf/TuldzvrEpM0RYknerarcr5waYQTSwP8wdWG1v+zEEnARVfuAScpaZ12/bGq
        RTpwjTSgg==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8S8-0004tK-Jw; Thu, 19 Jul 2018 12:54:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <monstr@monstr.eu>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: use the generic dma-noncoherent code for microblaze
Date:   Thu, 19 Jul 2018 05:54:38 -0700
Message-Id: <20180719125440.424-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

can you review these patches to switch microblaze to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
