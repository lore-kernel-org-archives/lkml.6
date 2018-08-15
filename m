Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD6C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C15216E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C15216E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbeHOMV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:21:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728583AbeHOMV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:21:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBEC7AD04;
        Wed, 15 Aug 2018 09:30:32 +0000 (UTC)
Date:   Wed, 15 Aug 2018 11:30:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/core-api: add memory allocation guide
Message-ID: <20180815093032.GQ32645@dhcp22.suse.cz>
References: <1534314887-9202-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180815063649.GB24091@rapoport-lnx>
 <20180815081539.GN32645@dhcp22.suse.cz>
 <20180815090428.GD24091@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815090428.GD24091@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-08-18 12:04:29, Mike Rapoport wrote:
[...]
> How about:
> 
> * If the allocation is performed from an atomic context, e.g interrupt
>   handler, use ``GFP_NOWARN``. This flag prevents direct reclaim and IO or
>   filesystem operations. Consequently, under memory pressure ``GFP_NOWARN``
>   allocation is likely to fail.

s@NOWARN@NOWAIT@ I guess. Looks good otherwise. I would even go and
mention GFP_NOWARN once you brought it up. Allocations which have a
reasonable fallback should be using NOWARN.

> * If you think that accessing memory reserves is justified and the kernel
>   will be stressed unless allocation succeeds, you may use ``GFP_ATOMIC``.

OK otherwise.
-- 
Michal Hocko
SUSE Labs
