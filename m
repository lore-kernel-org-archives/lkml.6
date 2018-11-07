Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608F0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0521920882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0521920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeKHHm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:42:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:15550 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbeKHHm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:42:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 14:10:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,477,1534834800"; 
   d="scan'208";a="106774744"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 07 Nov 2018 14:10:34 -0800
Date:   Wed, 7 Nov 2018 14:12:25 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2] iommu/vt-d: respect max guest address width in agaw
Message-ID: <20181107141225.2339ca4f@jacob-builder>
In-Reply-To: <20181107160428.awgpvo73mp3lbdro@8bytes.org>
References: <1541544435-52624-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20181107160428.awgpvo73mp3lbdro@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 17:04:28 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> On Tue, Nov 06, 2018 at 02:47:15PM -0800, Jacob Pan wrote:
> >  drivers/iommu/intel-iommu.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)  
> 
> Applied, thanks.

Hi Joerg,
We have found some issues with this patch on some platforms. Please
disregard this patch.

The intent of this patch was to fix some IOMMU with max address of 48
but SAGAW of both 48 and 57 bits. Need to do more investigation in the
page table level calculation and context address width setup. Sorry
about that.

Jacob
