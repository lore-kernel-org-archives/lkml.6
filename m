Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02CAC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3492218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfAKTTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:19:32 -0500
Received: from relay.sw.ru ([185.231.240.75]:42918 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387451AbfAKTTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:19:32 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gi2L4-0006oM-Uj; Fri, 11 Jan 2019 22:19:31 +0300
Subject: Re: [PATCH 3/3] mm/vmalloc: pass VM_USERMAP flags directly to
 __vmalloc_node_range()
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190103145954.16942-1-rpenyaev@suse.de>
 <20190103145954.16942-4-rpenyaev@suse.de>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <75680183-6e15-0487-c758-d1ce5fba27bc@virtuozzo.com>
Date:   Fri, 11 Jan 2019 22:19:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190103145954.16942-4-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/19 5:59 PM, Roman Penyaev wrote:
> vmalloc_user*() calls differ from normal vmalloc() only in that they
> set VM_USERMAP flags for the area.  During the whole history of
> vmalloc.c changes now it is possible simply to pass VM_USERMAP flags
> directly to __vmalloc_node_range() call instead of finding the area
> (which obviously takes time) after the allocation.
> 
> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
