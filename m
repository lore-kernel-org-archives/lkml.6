Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD9920664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD9920664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeKAJ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:56:30 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:47787 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbeKAJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:56:30 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wA10uZUK012526;
        Thu, 1 Nov 2018 08:56:35 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 1 Nov 2018
 08:55:41 +0800
Date:   Thu, 1 Nov 2018 08:55:42 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Anup Patel <anup@brainfault.org>, Zong Li <zong@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, <greentime@andestech.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        <vincentc@andestech.com>, <linux-riscv@lists.infradead.org>,
        <deanbo422@gmail.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181101005541.GA25604@andestech.com>
References: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
 <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <20181031141745.GA5183@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181031141745.GA5183@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wA10uZUK012526
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 07:17:45AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 31, 2018 at 04:46:10PM +0530, Anup Patel wrote:
> > I agree that we need a place for vendor-specific ISA extensions and
> > having vendor-specific directories is also good.
> 
> The only sensible answer is that we should not allow vendor specific
> extensions in the kernel at all.  ...

How can this even be possible if a extension includes an extra register
set as some domain-specific context?  In such a case, kernel should
at least process the context during any context switch, just like how it
deals with the FP context.

> ... We need to standardize cache flushing 
> and we need to do it soon and not introduce horrible bandaids because
> the foundation did not do its work.
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
