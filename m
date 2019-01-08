Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A05C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8354C20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfAHOe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:34:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbfAHOe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:34:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C6E0811DD;
        Tue,  8 Jan 2019 14:34:29 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F2755D9CC;
        Tue,  8 Jan 2019 14:34:27 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page during tail onlining
In-Reply-To: <20190108094755.GG3200@kadam>
References: <20190104141942.19126-1-vkuznets@redhat.com> <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com> <87d0p837lt.fsf@vitty.brq.redhat.com> <20190107175650.GG166797@sasha-vm> <87a7kc2u03.fsf@vitty.brq.redhat.com> <20190108094755.GG3200@kadam>
Date:   Tue, 08 Jan 2019 15:34:26 +0100
Message-ID: <87muob1aml.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 08 Jan 2019 14:34:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Mon, Jan 07, 2019 at 07:38:20PM +0100, Vitaly Kuznetsov wrote:
>> (I remember Greg disliked when people were tagging patches for stable@
>> themselves, he prefered maintainers deciding if the particular commit
>> deserves stable@ or not - but as you have a tree now we may as well have
>> different rules :-)
>
> You're thinking of Dave Miller.  So far as I know he's the only
> maintainer who handles stable that way.

This may actually be the case, you think "one of the the mighty Linux
overlords" but your fingers type "Greg" instread. Sorry for the
confusion :-)

-- 
Vitaly
