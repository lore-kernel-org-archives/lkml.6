Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA2AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0152086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0152086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeH1U1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:27:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:24338 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1U1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:27:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 09:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,300,1531810800"; 
   d="scan'208";a="68771288"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2018 09:34:21 -0700
Date:   Tue, 28 Aug 2018 09:36:16 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi L <yi.l.liu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Liu@mail.linuxfoundation.org, Jean Delvare <khali@linux-fr.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Message-ID: <20180828093616.30e1160f@jacob-builder>
In-Reply-To: <7c331f56-1ff8-7929-76bf-e73915a91ace@redhat.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <b6621306-fd32-7ede-ae88-7345898eb134@redhat.com>
        <20180827221422.57e233df@jacob-builder>
        <7c331f56-1ff8-7929-76bf-e73915a91ace@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 10:34:19 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> > Anyway, for the new VT-d 3.0 spec. we no longer need this API. In
> > stead, I will introduce bind_guest_pasid() API, where per device
> > PASID table is allocated by the host.  
> 
> So what is the exact state of this series? Is it outdated as you don't
> target VT-d 2.5 anymore? Will you keep the rest of the API?

Hi Eric,

I am not targeting VT-d 2.5 for SVA related work. I am working on the
rest of the APIs for supporting VT-d v3, which includes guest PASID
bind, fault reporting, and invalidation passdown from the guest. These
are based on some recent patches from Baolu.
https://lkml.org/lkml/2018/7/16/62

So I feel it is better for you to take over bind_pasid_table() API in
your series. I will drop it from my next version.

Thanks,

Jacob
