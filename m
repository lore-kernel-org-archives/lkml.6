Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeBEMnh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:43:37 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34617 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeBEMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:43:28 -0500
X-Google-Smtp-Source: AH8x226/Hw1/J7XZh+4h+G9m03SIvy3u60Hb73CXheNhEpQz+OK+usruECMsncmVo9vRiBvJ89MZDw==
Date: Mon, 5 Feb 2018 21:43:23 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Minchan Kim <minchan@kernel.org>, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: bisected bd4c82c22c367e is the first bad commit (was [Bug
 198617] New: zswap causing random applications to crash)
Message-ID: <20180205124323.GB426@jagdpanzerIV>
References: <20180130114841.aa2d3bd99526c03c6a5b5810@linux-foundation.org>
 <20180203013455.GA739@jagdpanzerIV>
 <CAC=cRTPyh-JTY=uOQf2dgmyPDyY-4+ryxkedp-iZMcFQZtnaqw@mail.gmail.com>
 <20180205013758.GA648@jagdpanzerIV>
 <87d11j4pdy.fsf@yhuang-dev.intel.com>
 <20180205123947.GA426@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205123947.GA426@jagdpanzerIV>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/05/18 21:39), Sergey Senozhatsky wrote:
> > I have successfully reproduced the issue and find the problem.  The
> > following patch fix the issue for me, can you try it?
> 
> That was quick ;)
> 
> > ---------------------------------8<-------------------------------
> > From 4c52d531680f91572ebc6f4525a018e32a934ef0 Mon Sep 17 00:00:00 2001
> > From: Huang Ying <huang.ying.caritas@gmail.com>
> > Date: Mon, 5 Feb 2018 19:27:43 +0800
> > Subject: [PATCH] fontswap thp fix
> 
> Seems to be fixing the problem on my x86 box. Executed several tests, no
> crashes were observed. Can run more tests tomorrow.
> 
> 
> ============================================================================
> 
> Probably unrelated, but may be it is related: my X server used to hang
> sometimes (rarely) which I suspect was/is caused by nouveau driver. It,
> surprisingly, didn't hang this time around. Nouveau spitted a number
> of backtraces, but X server managed to survive it. Any chance that
> nouveau-X server thing was caused by THP?

No, wait. How could it be... I don't even use frontswap usually.
Sorry for the silly question.

	-ss
