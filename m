Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E6EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1254214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lVXf+hLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1254214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIZSsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:48:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37913 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZSsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:48:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so8743090pgr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mO8L9+bJkywsmFzPVE8QncFmHyJu8f72Gzq1LR55OfA=;
        b=lVXf+hLRseNAM7fT0i+gcSGWfsGuDSLAf8TL7X5BFaMTjIBJB/q6h1paSJHfavVw0l
         mjEjUSfxx0BCSyAamVBmYIbJjy/9z/RxT6UatOS8ObI3mAHdcUvjx8mTpb6T5+v3h0U3
         pHxx2JPBoiAOV21w2blQFMeGtk+Ii8K8In1Df+/XiHtjlofm2sOgxgOk3iRaJyeYWV1G
         /FNoTAUC8zEt9NldmBW1C5FOdJO1dHC49cCEfD5Q2uriGxWg67a/unES3yEIL1Si1G4S
         5J6mph0XXL/Mo6/oYqNsWiFXb3x9IGL0AWbTJ3KrWQNTSFzjgCCYbhkkCBLGijdl7hus
         3GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mO8L9+bJkywsmFzPVE8QncFmHyJu8f72Gzq1LR55OfA=;
        b=NxfC6Kl6CE3/I/zlPy3AyVNBkb64q02+mwppIZdxZJvh5nedWZTgr4AovKqELgv4xI
         kxELobvwtYrtlVCG0nyUn2ozIq7iZkUyt8Z9e+wykxDK3IsS5jjWxozZHP4PmlS94ILM
         kW6yHh4ZDnOjImJy1NcKvRWoyuSPKSMHlNHsPuwsR6hepOoJiTNe22FJFHAkRuhOBSem
         BE9g+COTnn9EhWB6M5pPY6co/ZyAHZTb6TyvfaqqqzyXPLiBCG1LpnTG+0B/oLBpwdVv
         6MIINwigM2yIKWbRqpjY3w4m0f8lOPUOXjCQ/0nHOq/rKFZjaOyGkxBZEySD5g3Z6Gpc
         Bn6Q==
X-Gm-Message-State: ABuFfogMx6l8nEtjCIgns/4Oig2NHRNYMn5hfTbEYivd9TlOpE5klO/c
        k9D0CmWVTFhrqkisgo28T5VoOA==
X-Google-Smtp-Source: ACcGV63WxNAbg1muUVwCcuSTiajfM8a6oDUe+JIkNkZXbkUnag9ZiMMDUakeEj7ZNtRF6+ht74zYYg==
X-Received: by 2002:a62:868b:: with SMTP id x133-v6mr6177816pfd.252.1537965364163;
        Wed, 26 Sep 2018 05:36:04 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id t12-v6sm5934574pgg.72.2018.09.26.05.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 05:36:03 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A3BFB300029; Wed, 26 Sep 2018 15:35:58 +0300 (+03)
Date:   Wed, 26 Sep 2018 15:35:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        vbabka@suse.cz, akpm@linux-foundation.org, dave.hansen@intel.com,
        oleg@redhat.com, srikar@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v11 PATCH 0/3] mm: zap pages with read mmap_sem in munmap for
 large mapping
Message-ID: <20180926123558.fiutdxeexeiqbndk@kshutemo-mobl1>
References: <1537376621-51150-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537376621-51150-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:03:38AM +0800, Yang Shi wrote:
> 
> Yang Shi (3):
>       mm: mmap: zap pages with read mmap_sem in munmap
>       mm: unmap VM_HUGETLB mappings with optimized path
>       mm: unmap VM_PFNMAP mappings with optimized path
> 
>  mm/mmap.c | 50 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 11 deletions(-)

The patchset looks good to me.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
