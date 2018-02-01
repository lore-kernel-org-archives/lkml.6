Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeBAIP0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:15:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:33845 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbeBAIPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:15:22 -0500
Date: Thu, 1 Feb 2018 09:15:20 +0100
From: Michal Hocko <mhocko@kernel.org>
To: "He, Roger" <Hongbo.He@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Message-ID: <20180201081520.GF21609@dhcp22.suse.cz>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <20180130075553.GM21609@dhcp22.suse.cz>
 <9060281e-62dd-8775-2903-339ff836b436@amd.com>
 <20180130101823.GX21609@dhcp22.suse.cz>
 <7d5ce7ab-d16d-36bc-7953-e1da2db350bf@amd.com>
 <20180130122853.GC21609@dhcp22.suse.cz>
 <MWHPR1201MB0127CEE71F679F43BF0D25B6FDFA0@MWHPR1201MB0127.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1201MB0127CEE71F679F43BF0D25B6FDFA0@MWHPR1201MB0127.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-02-18 06:13:20, He, Roger wrote:
> Hi Michal:
> 
> How about only  
> EXPORT_SYMBOL_GPL(total_swap_pages) ?

I've already expressed that messing up with the amount of swap pages is
a wrong approach. You should scale your additional buffers according the
the current memory pressure. There are other users of memory on the
system other than your subsystem.
-- 
Michal Hocko
SUSE Labs
