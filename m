Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18323C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACAB21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBGVW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:22:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:16020 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGVW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:22:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 13:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="142494220"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.48])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2019 13:22:55 -0800
Date:   Thu, 7 Feb 2019 13:22:54 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 1/1] iommu/vt-d: Enable PRI only if the device enables
 PASID.
Message-ID: <20190207212254.GA1647@otc-nc-03>
References: <142748f6a00153f9926fe2a9dc30cf3cd89164cd.1549408090.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0faf4f6a5bbd8cbee84aa78c40ab15216c2b8f0e.camel@infradead.org>
 <20190207210936.GH103220@otc-nc-03>
 <9393b9b2c15564ee84b627a73fb34bd17ebe4a7f.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9393b9b2c15564ee84b627a73fb34bd17ebe4a7f.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:15:24PM +0000, David Woodhouse wrote:
> On Thu, 2019-02-07 at 13:09 -0800, Raj, Ashok wrote:
> > You are right.. they are completely orthogonal. We just don't have
> > a way to handle the page-requests for request without PASID's.
> > 
> > There are some of the vIOMMU work to pass the PRI to who owns
> > the device, and we can certainly relax it then. This is just to reflect
> > what support exists today. FWIW, even the native driver maybe be able
> > to resolve this if supported.
> 
> As things stand, if a device makes a PRI request without a PASID, it'll
> get told that we didn't manage to bring the page in for it. Which is
> true.

That's true...it does seem to be covered already.. I can't remember
why I thought this was required :-(.. 

We can drop this patch.
> 
> What's the actual problem being fixed by this patch? Yes, we're going
> to want to hook up a way to pass the PRI to the right place... but why
> add *another* thing that's just going to have to be fixed, by reverting
> this patch?
> 


