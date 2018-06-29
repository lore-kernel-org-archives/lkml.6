Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7396C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8924127B85
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8924127B85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934467AbeF2IAE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:00:04 -0400
Received: from verein.lst.de ([213.95.11.211]:52883 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933949AbeF2IAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:00:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 93A3168C4E; Fri, 29 Jun 2018 10:00:08 +0200 (CEST)
Date:   Fri, 29 Jun 2018 10:00:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/4] nvme: add disk name to tracepoints
Message-ID: <20180629080008.GB13413@lst.de>
References: <20180628214956.13877-1-keith.busch@intel.com> <20180628214956.13877-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628214956.13877-5-keith.busch@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +
> +	if (name[0] != 0)
> +		trace_seq_printf(p, "disk=%-.*s, ", DISK_NAME_LEN, name);

	if (*name)
		trace_seq_printf(p, "disk=%-.*s, ", DISK_NAME_LEN, name);

?

> +		    req->rq_disk ?
> +			memcpy(__entry->disk, req->rq_disk->disk_name, DISK_NAME_LEN) :
> +			memset(__entry->disk, 0, DISK_NAME_LEN);

Make this a helper please.
