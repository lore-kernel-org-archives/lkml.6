Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045CAC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB38920849
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB38920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbeGLQa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:30:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbeGLQa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:30:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0EA34075742;
        Thu, 12 Jul 2018 16:20:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9211F1C676;
        Thu, 12 Jul 2018 16:20:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 12 Jul 2018 18:20:41 +0200 (CEST)
Date:   Thu, 12 Jul 2018 18:20:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm: Fix vma_is_anonymous() false-positives
Message-ID: <20180712162039.GA16175@redhat.com>
References: <20180712145626.41665-1-kirill.shutemov@linux.intel.com>
 <20180712145626.41665-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712145626.41665-2-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 12 Jul 2018 16:20:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 12 Jul 2018 16:20:41 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill, I am not trying to review this change (but it looks good to me),
just a silly question...

On 07/12, Kirill A. Shutemov wrote:
>
> This can be fixed by assigning anonymous VMAs own vm_ops and not relying
> on it being NULL.

I agree, this makes sense, but...

> If ->mmap() failed to set ->vm_ops, mmap_region() will set it to
> dummy_vm_ops.

Shouldn't this change alone fix the problem?

Oleg.

