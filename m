Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3092C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC35208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC35208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeLMJKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:10:24 -0500
Received: from verein.lst.de ([213.95.11.211]:39628 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbeLMJKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:10:23 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DCDFF68DEE; Thu, 13 Dec 2018 10:10:21 +0100 (CET)
Date:   Thu, 13 Dec 2018 10:10:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181213091021.GA2106@lst.de>
References: <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de> <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de> <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de> <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de> <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de> <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de> <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de> <20181212141556.GA4801@lst.de> <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de> <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:41:50AM +0100, Christian Zigotzky wrote:
> Today I tried the first patch (0001-get_required_mask.patch) with the last 
> good commit (977706f9755d2d697aa6f45b4f9f0e07516efeda). Unfortunately this 
> patch is already included in the last good commit 
> (977706f9755d2d697aa6f45b4f9f0e07516efeda). I will try the next patch.

Hmm, I don't think this is the case.  This is my local git log output:

commit 83a4b87de6bc6a75b500c9959de88e2157fbcd7c
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Dec 12 15:07:49 2018 +0100

    get_required_mask

commit 977706f9755d2d697aa6f45b4f9f0e07516efeda
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Nov 10 22:34:27 2018 +0100

    powerpc/dma: remove dma_nommu_mmap_coherent

I've also pushed a git branch with these out to:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.5-debug
