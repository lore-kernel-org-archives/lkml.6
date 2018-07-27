Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA279C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620720671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5620720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbeG0U4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:56:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388467AbeG0U4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:56:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4430F4219DA6;
        Fri, 27 Jul 2018 19:33:35 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36DAB21568A1;
        Fri, 27 Jul 2018 19:33:34 +0000 (UTC)
Date:   Fri, 27 Jul 2018 15:33:33 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        axboe@kernel.dk, linux-s390@vger.kernel.org, dave.jiang@intel.com,
        martin.petersen@oracle.com, vishal.l.verma@intel.com,
        chengnt@lenovo.com, linux-fsdevel@vger.kernel.org,
        heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, colyli@suse.de, bart.vanassche@wdc.com,
        dm-devel@redhat.com, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, schwidefsky@de.ibm.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, agk@redhat.com,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH v2 5/6] md/dm-writecache: Don't request pointer
 dummy_addr when not required
Message-ID: <20180727193333.GA23266@redhat.com>
References: <20180725162849.8320-1-yehs2007@zoho.com>
 <20180725162849.8320-6-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725162849.8320-6-yehs2007@zoho.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 19:33:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 19:33:35 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25 2018 at 12:28pm -0400,
Huaisheng Ye <yehs2007@zoho.com> wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Function persistent_memory_claim doesn't need to get local pointer
> dummy_addr from direct_access. Using NULL instead of having to pass
> in a useless local pointer that caller then just throw away.
> 
> Suggested-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

Acked-by: Mike Snitzer <snitzer@redhat.com>
