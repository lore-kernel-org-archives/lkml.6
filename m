Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966417AbeCHR2z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:28:55 -0500
Received: from muru.com ([72.249.23.125]:60184 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932091AbeCHR2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:28:53 -0500
Date: Thu, 8 Mar 2018 09:28:49 -0800
From: Tony Lindgren <tony@atomide.com>
To: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Build fails with SLOB in next
Message-ID: <20180308172849.GO5799@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like commit 8b1747684ff8 ("dcache: account external names as
indirectly reclaimable memory") caused build fail if SLOB is selected:

fs/dcache.c: In function '__d_free_external':
fs/dcache.c:278:22: error: implicit declaration of function
'kmalloc_index'; did you mean 'kmalloc_ node'?
[-Werror=implicit-function-declaration]
        -kmalloc_size(kmalloc_index(bytes)));
	                      ^~~~~~~~~~~~~

Is this already fixed somewhere?

Regards,

Tony
