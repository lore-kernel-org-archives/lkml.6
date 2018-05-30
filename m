Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968728AbeE3JFG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:05:06 -0400
Received: from verein.lst.de ([213.95.11.211]:59901 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965116AbeE3JFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:05:01 -0400
Date: Wed, 30 May 2018 11:11:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        Ocean HY1 He <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [External]  Re: [RFC PATCH v2 00/12] get rid of
        GFP_ZONE_TABLE/BAD
Message-ID: <20180530091119.GA30154@lst.de>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com> <20180522183728.GB20441@dhcp22.suse.cz> <HK2PR03MB16847646E90A10E2D48CEA8E926B0@HK2PR03MB1684.apcprd03.prod.outlook.com> <20180524121853.GG20441@dhcp22.suse.cz> <HK2PR03MB1684ED6EC6859A88A196DC0C92690@HK2PR03MB1684.apcprd03.prod.outlook.com> <20180528133733.GF27180@dhcp22.suse.cz> <HK2PR03MB1684C44F2408F3927B1A21BC926C0@HK2PR03MB1684.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR03MB1684C44F2408F3927B1A21BC926C0@HK2PR03MB1684.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 09:02:13AM +0000, Huaisheng HS1 Ye wrote:
> 
> I don't quite understand that. I think those, mostly drivers, need to
> get the correct zone they want. ZONE_DMA32 is an example, if drivers can be
> satisfied with a low mem zone, why they mark the gfp flags as
> 'GFP_KERNEL|__GFP_DMA32'?

Drivers should never use GFP_DMA32 directly.  The right abstraction is
the DMA API, ZONE_DMA32 is just a helper.
