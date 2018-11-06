Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537BA2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537BA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbeKGBxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:53:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:53429 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387685AbeKGBxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:53:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 08:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="98073011"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 06 Nov 2018 08:27:19 -0800
Message-ID: <c7f9e6b6b3d7e2217f93bb23b16589dd5dc0b092.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v5 1/9] workqueue: Provide queue_work_node
 to queue work near a given NUMA node
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 08:27:19 -0800
In-Reply-To: <1541464948.196084.168.camel@acm.org>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145230445.29224.14651284855380723028.stgit@ahduyck-desk1.jf.intel.com>
         <1541464948.196084.168.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 16:42 -0800, Bart Van Assche wrote:
> On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
> > +/**
> > + * workqueue_select_cpu_near - Select a CPU based on NUMA node
> > + * @node: NUMA node ID that we want to bind a CPU from
> 
>                                           ^^^^
>                                           select?
> > +	/* If CPU is valid return that, otherwise just defer */
> > +	return (cpu < nr_cpu_ids) ? cpu : WORK_CPU_UNBOUND;
> 
> Please leave out the superfluous parentheses if this patch series would have to
> be reposted.
> 
> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

I will incorporate you suggestions and add your Reviewed-by for the
next submission.

Thanks.

- Alex

