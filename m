Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C5120834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C5120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeH3SQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:16:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbeH3SQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:16:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87FAA40216F9;
        Thu, 30 Aug 2018 14:13:53 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9987202704E;
        Thu, 30 Aug 2018 14:13:52 +0000 (UTC)
Date:   Thu, 30 Aug 2018 22:13:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 3/3] x86/kdump/64: Change the upper limit of crashkernel
 reservation
Message-ID: <20180830141349.GB14702@192.168.1.2>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-4-bhe@redhat.com>
 <20180830135037.efhruljtekoozgxr@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830135037.efhruljtekoozgxr@kshutemo-mobl1>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 14:13:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 14:13:53 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 at 04:50pm, Kirill A. Shutemov wrote:
> On Wed, Aug 29, 2018 at 10:16:24PM +0800, Baoquan He wrote:
> > Restrict kdump to only reserve crashkernel below 64TB. Since the kdump
> > jumping may be from 5-level to 4-level, and the kdump kernel is put
> > above 64TB in 5-level kernel, then the jumping will fail. And the
> > crashkernel reservation is done during the 1st kernel bootup, there's
> > no way to detect the paging mode of kdump kernel at that time.
> > 
> > Hence change the upper limmit of crashkernel reservation to 64TB
> 
> s/limmit/limit/

Thanks, will change.
