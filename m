Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B31BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A730F2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRcEGRem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A730F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbeGSNpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:45:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BVgKdjJfoAo97OSwnMPdIxfx4p4FVZXBUcOKhMYHZO8=; b=aRcEGRemyvo+xkl5ckjkh8Fbe
        EOnVMlAEO2V1ei9q3anuohLZorVNjBq9fy7Vg8x+r0d+z1VfwoklvBt/5UPjUlzX2/8YozN/Bzw+A
        GcgZ1C6sulvKRH/1YWw2YJKrynI7bf5QxGpi7vJOh0XQeEwRv+KPG3FQZ1/ScUHVpDv2RHCnm/Q7u
        MUI7NTf1L1+B4VRTF5N5VWNNr2wY6pY5X7bon9/B8JoRiXWWROd4qCReVQ/IMaY7mImQSJjnU6gK/
        0a+809voFSDgPisbETnc0BjPKXegR6pNtSGi7ZTS6JyOdz4CjTOUYfzGyD+5d3Hlo8nk1BTNbI4uV
        EmxpJScUw==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8Zk-0008LW-K2; Thu, 19 Jul 2018 13:02:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: use the generic dma-noncoherent code for openrisc
Date:   Thu, 19 Jul 2018 06:02:28 -0700
Message-Id: <20180719130232.1819-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Openrisc maintainers,

can you review these patches to switch openrisc to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
