Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ECFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B6B205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B6B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJBRhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:37:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:50005 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeJBRhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:37:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 03:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="scan'208";a="91394775"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Oct 2018 03:54:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A34921FF; Tue,  2 Oct 2018 13:54:50 +0300 (EEST)
Date:   Tue, 2 Oct 2018 13:54:50 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 1/6] mm/gup_benchmark: Time put_page
Message-ID: <20181002105450.2t6b4uprplhu2r4a@black.fi.intel.com>
References: <20180921223956.3485-1-keith.busch@intel.com>
 <20180921223956.3485-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921223956.3485-2-keith.busch@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:51PM +0000, Keith Busch wrote:
> We'd like to measure time to unpin user pages, so this adds a second
> benchmark timer on put_page, separate from get_page.
> 
> Adding the field will breaks this ioctl ABI, but should be okay since
> this an in-tree kernel selftest.
> 
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
