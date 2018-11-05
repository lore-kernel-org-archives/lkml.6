Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F6BECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CBE2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CBE2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeKESpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:45:32 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:56830 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbeKESpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:45:32 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id E1E841C1B2C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Nov 2018 09:26:43 +0000 (GMT)
Received: (qmail 6387 invoked from network); 5 Nov 2018 09:26:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Nov 2018 09:26:43 -0000
Date:   Mon, 5 Nov 2018 09:26:42 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        "=?utf-8:iso-8859-1?B?UGF3ZcWC?= Staszewski" <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/2] mm/page_alloc: free order-0 pages through PCP in
 page_frag_free()
Message-ID: <20181105092642.GF23537@techsingularity.net>
References: <20181105085820.6341-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181105085820.6341-1-aaron.lu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 04:58:19PM +0800, Aaron Lu wrote:
> page_frag_free() calls __free_pages_ok() to free the page back to
> Buddy. This is OK for high order page, but for order-0 pages, it
> misses the optimization opportunity of using Per-Cpu-Pages and can
> cause zone lock contention when called frequently.
> 
> [1]: https://www.spinics.net/lists/netdev/msg531362.html
> [2]: https://www.spinics.net/lists/netdev/msg531421.html
> [3]: https://www.spinics.net/lists/netdev/msg531556.html
> Reported-by: Paweł Staszewski <pstaszewski@itcare.pl>
> Analysed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Well spotted,

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
