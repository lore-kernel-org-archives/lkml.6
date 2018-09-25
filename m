Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7D02086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="T+wxv77B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7D02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeIYSl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:41:29 -0400
Received: from 8bytes.org ([81.169.241.247]:35238 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbeIYSl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:41:29 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 460846FB; Tue, 25 Sep 2018 14:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537878847; bh=L+TQeNhz9pD14gewg7yCrjmdNXR57TRa5CnB9tBeyQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+wxv77BYN46eOw+dEDcNUK7LZa365bpD4g0MWcY46YiGojhTzcf9nuNj3hNatLwD
         pmd/yyOROfFLl7pb/XAJJ3y/SVhb/epIDdiGVYPqSRwBCPgHf+FMgm6xnmyfSU3qwu
         HEiWJ0RlIAluLb83VfqWskj3o1PiLhApZ8Criznf0+XNkg1YPLLBE+DDslTl7xJvuE
         LHk+SJX+TjgyyfF5TUu+K0vNR1G/WgL/pEVrVBObIyNrS2J2aJ0u72wNtW/I7y25nH
         8Bs9n+DdpGuLfHaYrrm+KCqAYxt+Mypd9YHuhALCgCC3UkhI+J5A0+jPbfmvB8FIQI
         5djYfCbqcdJfA==
Date:   Tue, 25 Sep 2018 14:34:06 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v8 0/6] Add Intel IOMMU debugfs support
Message-ID: <20180925123406.xbqxg4t5gdtmtpp7@8bytes.org>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912001141.64025-1-sohil.mehta@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 05:11:35PM -0700, Sohil Mehta wrote:
> Sohil Mehta (5):
>   iommu/vt-d: Relocate struct/function declarations to its header files
>   iommu/vt-d: Update register definitions to VT-d 3.0 specification
>   iommu/vt-d: Enable base Intel IOMMU debugfs support
>   iommu/vt-d: Add debugfs support for Interrupt remapping
>   iommu/vt-d: Add debugfs support to show context internals
> 
>  arch/x86/include/asm/irq_remapping.h |   2 +
>  drivers/iommu/Kconfig                |  13 ++
>  drivers/iommu/Makefile               |   1 +
>  drivers/iommu/intel-iommu-debugfs.c  | 314 +++++++++++++++++++++++++++
>  drivers/iommu/intel-iommu.c          |  32 +--
>  drivers/iommu/intel_irq_remapping.c  |   2 +-
>  include/linux/intel-iommu.h          |  72 ++++++
>  7 files changed, 407 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/iommu/intel-iommu-debugfs.c

Applied, thanks.

