Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D821868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6D821868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHQTDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:03:14 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:59779 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQTDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:03:14 -0400
X-IronPort-AV: E=Sophos;i="5.53,251,1531785600"; 
   d="scan'208";a="77776861"
Date:   Fri, 17 Aug 2018 17:59:09 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>, <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v3 0/5] xen/blk: persistent grant rework
Message-ID: <20180817155909.4cwiy6bhhgiala5m@mac>
References: <20180813140114.20126-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180813140114.20126-1-jgross@suse.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 04:01:09PM +0200, Juergen Gross wrote:
> Persistent grants are used in the Xen's blkfront/blkback drivers to
> avoid mapping/unmapping of I/O buffers in the backend for each I/O.
> 
> While this speeds up processing quite a bit there are problems related
> to persistent grants in some configurations: domains with multiple
> block devices making use of persistent grants might suffer from a lack
> of grants if each of the block devices experienced a high I/O load at
> some time. This is due to the number of persistent grants per device
> only to be limited by a rather high maximum value, but never being
> released even in case of longer times without any I/O.
> 
> This series modifies xen-blkback to unmap any domU page mapped via a
> persistent grant after a timeout (default: 60 seconds). The timeout
> is set to its default value again when a persistent grant has been
> used for an I/O.
> 
> xen-blkfront is modified to scan every 10 seconds for persistent grants
> not in use by blkback any more and to remove such grants.
> 
> The last 3 patches are small cleanups of blkfront and blkback drivers.
> 
> V3:
> - patch 1: make timeout parameter static

Konrad if you are OK with this series, could you please send a pull
request to Jens?

Thanks, Roger.
