Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43382C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F212064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F212064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeKAXVZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:21:25 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:48071 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeKAXVZ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Thu, 1 Nov 2018 19:21:25 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Thu, 01 Nov 2018 08:18:15 -0600
Message-Id: <5BDB0B240200007800142507@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Thu, 01 Nov 2018 08:18:12 -0600
From:   "Jan Beulich" <jbeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     <sstabellini@kernel.org>, <xen-devel@lists.xenproject.org>,
        <boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] xen: remove size limit of privcmd-buf
 mapping interface
References: <20181101123307.8424-1-jgross@suse.com>
In-Reply-To: <20181101123307.8424-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Juergen Gross <jgross@suse.com> 11/01/18 1:34 PM >>>
>Currently the size of hypercall buffers allocated via
>/dev/xen/hypercall is limited to a default of 64 memory pages. For live
>migration of guests this might be too small as the page dirty bitmask
>needs to be sized according to the size of the guest. This means
>migrating a 8GB sized guest is already exhausting the default buffer
>size for the dirty bitmap.
>
>There is no sensible way to set a sane limit, so just remove it
>completely. The device node's usage is limited to root anyway, so there
>is no additional DOS scenario added by allowing unlimited buffers.

But is this setting of permissions what we want long term? What about a
de-privileged qemu, which still needs to be able to issue at least dm-op
hypercalls?

Jan


