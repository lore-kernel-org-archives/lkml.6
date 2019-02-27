Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BB7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2012184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfB0Suc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:50:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:51263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfB0Sua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:50:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 10:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="125679633"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 27 Feb 2019 10:50:29 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 87F655804B4;
        Wed, 27 Feb 2019 10:50:29 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: linux-next: build warning after merge of the iommu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190227132004.4d3a3da4@canb.auug.org.au>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <e4db08ff-256d-5273-f02e-f8d0533efe04@linux.intel.com>
Date:   Wed, 27 Feb 2019 10:48:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190227132004.4d3a3da4@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/26/19 6:20 PM, Stephen Rothwell wrote:
> Hi Joerg,
>
> After merging the iommu tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> In file included from drivers/pci/pci.c:32:
> include/linux/pci-ats.h:70:12: warning: 'pci_prg_resp_pasid_required' defined but not used [-Wunused-function]
>   static int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>    e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required() interface.")
>
> The non CONFIG_PCI_PASID version needs an "inline".
I can submit the fix, but do we need a new patch to fix it or the 
original patch can be updated ?
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

