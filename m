Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeFDLUa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:20:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeFDLU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:20:29 -0400
Date: Mon, 4 Jun 2018 13:20:26 +0200
From: Michal Hocko <mhocko@kernel.org>
To: nixiaoming <nixiaoming@huawei.com>
Cc: akpm@linux-foundation.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        garsilva@embeddedor.com, ktkhai@virtuozzo.com, stummala@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Add conditions to avoid out-of-bounds
Message-ID: <20180604112026.GI19202@dhcp22.suse.cz>
References: <20180604103735.42781-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604103735.42781-1-nixiaoming@huawei.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-06-18 18:37:35, nixiaoming wrote:
> In the function memcg_init_list_lru
> if call goto fail when i == 0, will cause out-of-bounds at lru->node[i]

How? All I can see is that the fail path does
	for (i = i - 1; i >= 0; i--)

so it will not do anything for i=0.
-- 
Michal Hocko
SUSE Labs
