Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E25C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7410223CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7410223CC5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeGEOvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:51:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753553AbeGEOto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:49:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABD94AFF7;
        Thu,  5 Jul 2018 14:49:42 +0000 (UTC)
Date:   Thu, 5 Jul 2018 16:49:41 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init
 state / control
Message-ID: <20180705144941.drfiwhqcnqqorqu3@linux-x5ow.site>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180705082931.echvdqipgvwhghf2@linux-x5ow.site>
 <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:46:05AM -0700, Dan Williams wrote:
> ...but that also allows 'echo "syncAndThenSomeGarbage" >
> /sys/.../memmap_state' to succeed.

Yep it does :-(.

Damn
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
