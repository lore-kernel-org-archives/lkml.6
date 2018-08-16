Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A6620779
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SYc1KeL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A6620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404160AbeHPSs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:48:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeHPSs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7nlVjsl6BsDMhFny3GTZX38A7Gg7WMlBARc9nXLkCAg=; b=SYc1KeL+zqk7QDf+niFinSBNJ
        OHqZeBBkjnd5/Gk7sptbPa5deFcfqZE5x2qacaJsdXtkYavvVi3cPLyMyzBdNQLceLmmyf/yKf/ck
        u6KOj0Q+gNt7SV669on5IWvUHSwkCLQg57Z7P72i5qZqGGS2xb9aG4mZL3eldr7J8cnhtlaW+VPuF
        4/hbmpJgrB349A4Vpwf+5rdvewLiFE35YJqkQXhY5r5+7KwhdIuhNX6nAHN8veocastdGO2SbgpGU
        Nixn4Tf7SocKUFhEnuwAaV+w8MjL0Wuxg27Il5qNuXXSme8mN01z2Qyk4L3gF4y6nTCkUT/zQQzJ6
        RaYdSlHJQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fqKWq-0006do-E6; Thu, 16 Aug 2018 15:49:40 +0000
Date:   Thu, 16 Aug 2018 08:49:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180816154940.GD5762@bombadil.infradead.org>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 03:26:39PM -0600, Jon Derrick wrote:
> Some users may want to disable downstream port containment (DPC), so
> give them this option

Is it possible they might only want to disable DPC on a subset of the
hierarchy rather than globally?
