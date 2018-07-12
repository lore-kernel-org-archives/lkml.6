Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F729C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC4F20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC4F20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbeGLIMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:58944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbeGLIMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:12:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB46AAE6E;
        Thu, 12 Jul 2018 08:04:19 +0000 (UTC)
Date:   Thu, 12 Jul 2018 10:04:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for
 large mapping
Message-ID: <20180712080418.GC32648@dhcp22.suse.cz>
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711111052.hbyukcwetmjjpij2@kshutemo-mobl1>
 <3d4c69c9-dd2b-30d2-5bf2-d5b108a76758@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4c69c9-dd2b-30d2-5bf2-d5b108a76758@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 10:04:48, Yang Shi wrote:
[...]
> One approach is to save all the vmas on a separate list, then zap_page_range
> does unmap with this list.

Just detached unmapped vma chain from mm. You can keep the existing
vm_next chain and reuse it.

-- 
Michal Hocko
SUSE Labs
