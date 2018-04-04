Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDDOK6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:10:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57273 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbeDDOK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:10:56 -0400
Date: Wed, 4 Apr 2018 16:10:52 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180404141052.GH6312@dhcp22.suse.cz>
References: <20180403121614.GV5501@dhcp22.suse.cz>
 <20180403082348.28cd3c1c@gandalf.local.home>
 <20180403123514.GX5501@dhcp22.suse.cz>
 <20180403093245.43e7e77c@gandalf.local.home>
 <20180403135607.GC5501@dhcp22.suse.cz>
 <20180403101753.3391a639@gandalf.local.home>
 <20180403161119.GE5501@dhcp22.suse.cz>
 <20180403185627.6bf9ea9b@gandalf.local.home>
 <20180404062039.GC6312@dhcp22.suse.cz>
 <20180404085901.5b54fe32@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404085901.5b54fe32@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-04-18 08:59:01, Steven Rostedt wrote:
[...]
> +       /*
> +        * Check if the available memory is there first.
> +        * Note, si_mem_available() only gives us a rough estimate of available
> +        * memory. It may not be accurate. But we don't care, we just want
> +        * to prevent doing any allocation when it is obvious that it is
> +        * not going to succeed.
> +        */
> +       i = si_mem_available();
> +       if (i < nr_pages)
> +               return -ENOMEM;
> +
> 
> Better?

I must be really missing something here. How can that work at all for
e.g. the zone_{highmem/movable}. You will get false on the above tests
even when you will have hard time to allocate anything from your
destination zones.
-- 
Michal Hocko
SUSE Labs
