Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5961BC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A4820684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HCXPGQY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A4820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeGSNWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:22:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hi7OzSbCDtT9HWkNAuRqyW02TiKx1qPS0KSXLZuV1M8=; b=HCXPGQY8mlkKRZINTpvPyIeZw
        X0jLPkk6MOPHSZDj/NlObHzso95rOhZkrvFFF9jz+KS8hJKrW+pLiouUcS65Zd3N46xkqN8u5UxHw
        GGxw/lpczvxfP4dXuvUe9YAIvx7a+pkL46WqlWJmIAz+AXUmKjIhja4FJiHF3lHKPOGMnX6czocSV
        NyI8zgWviJjDAOoLJnBjTB4Z2OCyOyDU0tRwBVvbShufKBBmfb9K0h0wE74sJZ58gNIHyd6rQea42
        OuZd32AeFZXxdk3TQnmDKJAQ47dIdCPWvslyoXqRRWJ5RaCdk0LyjdK7jdovJpv+4j2LaAU3eQjk9
        eoT6YLl2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8D6-0007ko-V7; Thu, 19 Jul 2018 12:39:08 +0000
Date:   Thu, 19 Jul 2018 05:39:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v3 1/8] swap: Add comments to lock_cluster_or_swap_info()
Message-ID: <20180719123908.GA28522@infradead.org>
References: <20180719084842.11385-1-ying.huang@intel.com>
 <20180719084842.11385-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719084842.11385-2-ying.huang@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 04:48:35PM +0800, Huang Ying wrote:
> +/*
> + * Determine the locking method in use for this device.  Return
> + * swap_cluster_info if SSD-style cluster-based locking is in place.
> + */
>  static inline struct swap_cluster_info *lock_cluster_or_swap_info(
>  	struct swap_info_struct *si,
>  	unsigned long offset)
>  {
>  	struct swap_cluster_info *ci;
>  
> +	/* Try to use fine-grained SSD-style locking if available: */

Once you touch this are can you also please use standard two-tab
alignment for the spill-over function arguments:

static inline struct swap_cluster_info *lock_cluster_or_swap_info(
		struct swap_info_struct *si, unsigned long offset)
