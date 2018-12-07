Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB35C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099CD20672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099CD20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeLGPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:34:33 -0500
Received: from verein.lst.de ([213.95.11.211]:35863 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLGPed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:34:33 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 209B568AA6; Fri,  7 Dec 2018 16:34:32 +0100 (CET)
Date:   Fri, 7 Dec 2018 16:34:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: dma_declare_coherent_memory on main memory
Message-ID: <20181207153432.GA24917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the ARM imx27/31 ports and various sh boards use
dma_declare_coherent_memory on main memory taken from the memblock
allocator.

Is there any good reason these couldn't be switched to CMA areas?
Getting rid of these magic dma_declare_coherent_memory area would
help making the dma allocator a lot simpler.
