Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QVNfAB9bGFvYHAAAmS7hNA
	; Wed, 06 Jun 2018 22:07:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C3F026089E; Wed,  6 Jun 2018 22:07:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 326ED607E4;
	Wed,  6 Jun 2018 22:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 326ED607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeFFWHx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:07:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:3522 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751885AbeFFWHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:07:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 15:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,484,1520924400";
   d="scan'208";a="235283996"
Received: from downor-z87x-ud5h.fm.intel.com (HELO downor-Z87X-UD5H) ([10.1.122.107])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2018 15:07:50 -0700
Date: Wed, 6 Jun 2018 15:05:21 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>,
        matthew.d.roper@intel.com, jgross@suse.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        linux-media@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH v2 9/9] xen/gntdev: Expose gntdev's dma-buf
 API for in-kernel use
Message-ID: <20180606220521.GA7054@downor-Z87X-UD5H>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-10-andr2000@gmail.com>
 <86f5b340-856c-204f-4ba7-dd51f1e92639@oracle.com>
 <984bcf75-9bea-aceb-3d3a-62e3c65709c7@gmail.com>
 <398d53c9-9c47-d86a-89bd-b9941e638434@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398d53c9-9c47-d86a-89bd-b9941e638434@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 05:51:38PM -0400, Boris Ostrovsky wrote:
> On 06/06/2018 08:46 AM, Oleksandr Andrushchenko wrote:
> > On 06/05/2018 01:36 AM, Boris Ostrovsky wrote:
> >> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
> >>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >>>
> >>> Allow creating grant device context for use by kernel modules which
> >>> require functionality, provided by gntdev. Export symbols for dma-buf
> >>> API provided by the module.
> >> Can you give an example of who'd be using these interfaces?
> > There is no use-case at the moment I can think of, but hyper dma-buf
> > [1], [2]
> > I let Intel folks (CCed) to defend this patch as it was done primarily
> > for them
> > and I don't use it in any of my use-cases. So, from this POV it can be
> > dropped,
> > at least from this series.
> 
> 
> Yes, let's drop this until someone actually needs it.
> 
> -boris

I agree. We are working on re-architecturing hyper_dmabuf. We would use zcopy
apis however, not sure if we are going to do it from kernel or from userspace.
So please do not expose those for now.

> 
> 
> >>
> >> -boris
> >>
> > [1] https://patchwork.freedesktop.org/series/38207/
> > [2] https://patchwork.freedesktop.org/patch/204447/
> >
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel@lists.xenproject.org
> > https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
