Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F7C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 12:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169FE2449D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 12:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169FE2449D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxdriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeGAMTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 08:19:51 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:37628 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeGAMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 08:19:50 -0400
Received: from cpe-2606-a000-111b-40b7-215-ff-fecc-4872.dyn6.twc.com ([2606:a000:111b:40b7:215:ff:fecc:4872] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1fZbKF-0006a4-5k; Sun, 01 Jul 2018 08:19:38 -0400
Date:   Sun, 1 Jul 2018 08:18:58 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, kbuild-all@01.org, linux-rdma@vger.kernel.org,
        Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmw_pvrdma: Release netdev when vmxnet3 module is removed
Message-ID: <20180701121857.GA20336@neilslaptop.think-freely.org>
References: <20180628135938.19625-1-nhorman@tuxdriver.com>
 <20180630191507.dtzpvvvicmphnzsz@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630191507.dtzpvvvicmphnzsz@mwanda>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 10:15:07PM +0300, Dan Carpenter wrote:
> Hi Neil,
> 
> I love your patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Neil-Horman/vmw_pvrdma-Release-netdev-when-vmxnet3-module-is-removed/20180628-232414
> 
> smatch warnings:
> drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c:987 pvrdma_pci_probe() warn: variable dereferenced before check 'dev->netdev' (see line 985)
> 
Appreciate the smatch check, but this was caught by visual review and fixed in V2 already.

Best
Neil

