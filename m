Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C134BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4572070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfAGSi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:38:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGSi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:38:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC9D8A4034;
        Mon,  7 Jan 2019 18:38:26 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42843601A3;
        Mon,  7 Jan 2019 18:38:22 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, devel@linuxdriverproject.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page during tail onlining
In-Reply-To: <20190107175650.GG166797@sasha-vm>
References: <20190104141942.19126-1-vkuznets@redhat.com> <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com> <87d0p837lt.fsf@vitty.brq.redhat.com> <20190107175650.GG166797@sasha-vm>
Date:   Mon, 07 Jan 2019 19:38:20 +0100
Message-ID: <87a7kc2u03.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 07 Jan 2019 18:38:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> On Mon, Jan 07, 2019 at 02:44:30PM +0100, Vitaly Kuznetsov wrote:
>>P.S. I still think about bringing mem_hotplug_begin()/done() to
>>hv_balloon but that's going to be a separate discussion, here I want to
>>have a small fix backportable to stable.
>
> This should probably be marked for stable then :)
>

Yes, please :-)

I didn't test old kernels but this seems to be an old issue,
e.g. DEFERRED_STRUCT_PAGE_INIT appeared in 4.2 - not sure if memory
hotplug code was using it back then but, oh well, it's all history now.

(I remember Greg disliked when people were tagging patches for stable@
themselves, he prefered maintainers deciding if the particular commit
deserves stable@ or not - but as you have a tree now we may as well have
different rules :-)

-- 
Vitaly
