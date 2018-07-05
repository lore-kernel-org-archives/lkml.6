Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163E2C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68FD20847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68FD20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeGEI3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:29:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:60928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753287AbeGEI3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:29:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8064AADE2;
        Thu,  5 Jul 2018 08:29:33 +0000 (UTC)
Date:   Thu, 5 Jul 2018 10:29:31 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, hch@lst.de,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init
 state / control
Message-ID: <20180705082931.echvdqipgvwhghf2@linux-x5ow.site>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 11:50:13PM -0700, Dan Williams wrote:
> +static ssize_t memmap_state_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	int i;
> +	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
> +	struct memmap_async_state *async = &nd_pfn->async;
> +
> +	if (strcmp(buf, "sync") == 0)
> +		/* pass */;
> +	else if (strcmp(buf, "sync\n") == 0)
> +		/* pass */;
> +	else
> +		return -EINVAL;

Hmm what about:

  	if (strncmp(buf, "sync", 4))
	   return -EINVAL;

This collapses 6 lines into 4.


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
