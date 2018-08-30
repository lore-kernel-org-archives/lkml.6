Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79E3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9042082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9042082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHaCQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:16:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39636 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaCQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:16:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 66B732762BC
Message-ID: <4fc5107f93871599ead017af7ad50f22535a7683.camel@collabora.com>
Subject: Re: [RFC 2/3] USB: core: Add non-coherent buffer allocation helpers
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "Matwey V . Kornilov" <matwey@sai.msu.ru>,
        Alan Stern <stern@rowland.harvard.edu>, kernel@collabora.com,
        Keiichi Watanabe <keiichiw@chromium.org>
Date:   Thu, 30 Aug 2018 19:11:35 -0300
In-Reply-To: <20180830175850.GA11521@infradead.org>
References: <20180830172030.23344-1-ezequiel@collabora.com>
         <20180830172030.23344-3-ezequiel@collabora.com>
         <20180830175850.GA11521@infradead.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 10:58 -0700, Christoph Hellwig wrote:
> Please don't introduce new DMA_ATTR_NON_CONSISTENT users, it is
> a rather horrible interface, and I plan to kill it off rather sooner
> than later.  I plan to post some patches for a better interface
> that can reuse the normal dma_sync_single_* interfaces for ownership
> transfers.  I can happily include usb in that initial patch set based
> on your work here if that helps.

Please do. Until we have proper allocators that go thru the DMA API,
drivers will have to kmalloc the USB transfer buffers, and have
streaming mappings. Which in turns mean not using IOMMU or CMA.

Regards,
Eze
