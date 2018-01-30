Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeA3Hz5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 02:55:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:54700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbeA3Hz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 02:55:56 -0500
Date: Tue, 30 Jan 2018 08:55:53 +0100
From: Michal Hocko <mhocko@kernel.org>
To: "He, Roger" <Hongbo.He@amd.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Message-ID: <20180130075553.GM21609@dhcp22.suse.cz>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 02:56:51, He, Roger wrote:
> Hi Michal:
> 
> We need a API to tell TTM module the system totally has how many swap
> cache.  Then TTM module can use it to restrict how many the swap cache
> it can use to prevent triggering OOM.  For Now we set the threshold of
> swap size TTM used as 1/2 * total size and leave the rest for others
> use.

Why do you so much memory? Are you going to use TB of memory on large
systems? What about memory hotplug when the memory is added/released?
 
> But get_nr_swap_pages is the only API we can accessed from other
> module now.  It can't cover the case of the dynamic swap size
> increment.  I mean: user can use "swapon" to enable new swap file or
> swap disk dynamically or "swapoff" to disable swap space.

Exactly. Your scaling configuration based on get_nr_swap_pages or the
available memory simply sounds wrong.
-- 
Michal Hocko
SUSE Labs
