Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CC2C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CDD20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ADC+x1l0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CDD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeILPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:37:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36603 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeILPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:37:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so1814137wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmokVs+jUymxKJI18+8ZXLUnxVykW00O/mjg+Retk9I=;
        b=ADC+x1l0vp77rsDk4lkugpaIt7NABI8UVubtyki1i3ZSFAyuia5sa9vBPDDhpxCTi9
         pY14WofPuNNpEqvX8Dl8l4TlFBG8zntMmkAwmc116orXB6LRhpV4eBQOo2Q0A4kkFFx3
         VRnJQVtr4C9sMpWnMRTSIaa7yJN9hf3iVLaatvAxpxBi7NpiTBD/7U6eotweatxOLJDy
         mTamXdI49KlV858ARV2yNMCPzL2a2aDl9mCKl0kQUGr5kOQnpsiC4dNxZ+qoFkwuT+Bm
         wjLEfVMhIuavCForsm2pwlFkhpe+mzwQWwSx76KcnjPQGt9y0N7lTMJdHpm4dg91haKu
         i+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmokVs+jUymxKJI18+8ZXLUnxVykW00O/mjg+Retk9I=;
        b=DsD/VzOzt+YoGEtO/81HS3qepTXCIFBKEO+95HHtiDbZP79B+l5vBqtaGx6SvGsXEj
         tAC2rUZSBkGHnspckJtQvlK508ZtcGuNSImBXzHqwukYj2pB6ioWnKgceTj0y7G0vzzS
         fUuhli6w/FHsY8GPk3Wy6odO/n31Eptleq0HNt99aHQrRmJ7nuBLajyOH3NKUxyu/sjE
         JkNenL3KdSNo/6gOJpAXIrnSxAHTk1awZJ+GrcGHHUEqpbwjkpJP2ZrYcdcOG3462nxY
         ZEphAyTwhVx+RuSEuUtPgsoeTedtgt8TZTaeEilAsKqQKej2S117mcoH3wG85jiOmJ0O
         Qzsg==
X-Gm-Message-State: APzg51DxVualiqBkortnkOIbVi3GNvvuj2ZYw1alt5t2Eb+74R6hx2Ip
        JsowK7fKfMNmVLECG56pyOTl2g==
X-Google-Smtp-Source: ANB0VdbCu+WCF1X92jugH5yX3dZ+089zrvjYmpJ60MVdM75n+NpYnqFiuA1ybV8JXm8sWPTeuTInUg==
X-Received: by 2002:a1c:2e11:: with SMTP id u17-v6mr1098199wmu.102.1536748393534;
        Wed, 12 Sep 2018 03:33:13 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (mm-129-246-122-178.brest.dynamic.pppoe.byfly.by. [178.122.246.129])
        by smtp.gmail.com with ESMTPSA id 72-v6sm782569wrb.48.2018.09.12.03.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 03:33:12 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A92C0300DB6; Wed, 12 Sep 2018 13:33:11 +0300 (+03)
Date:   Wed, 12 Sep 2018 13:33:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Henry Willard <henry.willard@oracle.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: mprotect: check page dirty when change ptes
Message-ID: <20180912103311.iwytyuk4lgckad5a@kshutemo-mobl1>
References: <20180912064921.31015-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912064921.31015-1-peterx@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:49:21PM +0800, Peter Xu wrote:
> Add an extra check on page dirty bit in change_pte_range() since there
> might be case where PTE dirty bit is unset but it's actually dirtied.
> One example is when a huge PMD is splitted after written: the dirty bit
> will be set on the compound page however we won't have the dirty bit set
> on each of the small page PTEs.
> 
> I noticed this when debugging with a customized kernel that implemented
> userfaultfd write-protect.  In that case, the dirty bit will be critical
> since that's required for userspace to handle the write protect page
> fault (otherwise it'll get a SIGBUS with a loop of page faults).
> However it should still be good even for upstream Linux to cover more
> scenarios where we shouldn't need to do extra page faults on the small
> pages if the previous huge page is already written, so the dirty bit
> optimization path underneath can cover more.
> 
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Mel Gorman <mgorman@techsingularity.net>
> CC: Khalid Aziz <khalid.aziz@oracle.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Andi Kleen <ak@linux.intel.com>
> CC: Henry Willard <henry.willard@oracle.com>
> CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> CC: Andrea Arcangeli <aarcange@redhat.com>
> CC: Kirill A. Shutemov <kirill@shutemov.name>
> CC: Jerome Glisse <jglisse@redhat.com>
> CC: Zi Yan <zi.yan@cs.rutgers.edu>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - checking the dirty bit when changing PTE entries rather than fixing up
>   the dirty bit when splitting the huge page PMD.
> - rebase to 4.19-rc3
> 
> Instead of keeping this in my local tree, I'm giving it another shot to
> see whether this could be acceptable for upstream since IMHO it should
> still benefit the upstream.  Thanks,
> ---
>  mm/mprotect.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6d331620b9e5..5fe752515161 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -115,6 +115,17 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  			if (preserve_write)
>  				ptent = pte_mk_savedwrite(ptent);
>  
> +                       /*
> +                        * The extra PageDirty() check will make sure
> +                        * we'll capture the dirty page even if the PTE
> +                        * dirty bit is unset.  One case is when the
> +                        * PTE is splitted from a huge PMD, in that
> +                        * case the dirty flag might only be set on the
> +                        * compound page instead of this PTE.
> +                        */
> +			if (PageDirty(pte_page(ptent)))
> +				ptent = pte_mkdirty(ptent);
> +

How do you protect against concurent clearing of PG_dirty?

You can end up with unaccounted dirty page.

NAK.

-- 
 Kirill A. Shutemov
