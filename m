Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeDJMTH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:19:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbeDJMTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:19:05 -0400
Date: Tue, 10 Apr 2018 05:19:04 -0700
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?0JTQvNC40YLRgNC40Lkg0JvQtdC+0L3RgtGM0LXQsg==?=
        <dm.leontiev7@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: __GFP_LOW
Message-ID: <20180410121904.GD22118@bombadil.infradead.org>
References: <20180405153240.GO6312@dhcp22.suse.cz>
 <20180405161501.GD28128@bombadil.infradead.org>
 <20180405185444.GQ6312@dhcp22.suse.cz>
 <20180405201557.GA3666@bombadil.infradead.org>
 <20180406060953.GA8286@dhcp22.suse.cz>
 <20180408042709.GC32632@bombadil.infradead.org>
 <20180409073407.GD21835@dhcp22.suse.cz>
 <20180409155157.GC11756@bombadil.infradead.org>
 <20180409181400.GO21835@dhcp22.suse.cz>
 <CA+JonM0HG9kWb6-0iyDQ8UMxTeR-f=+ZL89t5DvvDULDC8Sfyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+JonM0HG9kWb6-0iyDQ8UMxTeR-f=+ZL89t5DvvDULDC8Sfyw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 03:12:37PM +0300, Дмитрий Леонтьев wrote:
> First, I've noticed the network drivers were allocating memory in interrupt
> handlers. That sounds strange to me, because as far as I know, this
> behaviour is discouraged and may lead to DDOS attack.

Linux supports allocating memory in interrupt context.  We also support
allocating memory while holding locks.

Doing it any other way would require the network stack to preallocate
all of the memory it's going to use.  You can pop over to the netdev
mailing list and ask them to stop this behaviour, but I don't think
they'll be very sympathetic.
