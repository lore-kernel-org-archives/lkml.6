Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB868C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905F32243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905F32243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbeKLWup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:50:45 -0500
Received: from ozlabs.org ([203.11.71.1]:56725 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeKLWuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:50:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42trPz5YtKz9s4s;
        Mon, 12 Nov 2018 23:57:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>, Jonathan Corbet <corbet@lwn.net>,
        Colin King <colin.king@canonical.com>,
        Geoff Levand <geoff@infradead.org>
Cc:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
In-Reply-To: <d1048515-239a-2686-e897-fb2a2b8d180f@ozlabs.org>
References: <20181026172549.3628-1-colin.king@canonical.com> <20181107153104.71eddf4d@lwn.net> <d1048515-239a-2686-e897-fb2a2b8d180f@ozlabs.org>
Date:   Mon, 12 Nov 2018 23:57:22 +1100
Message-ID: <87bm6ua1xp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Kerr <jk@ozlabs.org> writes:
> Hi Jon,
>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>   Documentation/filesystems/spufs.txt | 2 +-
>>>   Documentation/gpu/drm-uapi.rst      | 4 ++--
>>>   2 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> Applied, thanks.
>> 
>> This is the first patch to spufs.txt since 2006...I wonder if that stuff
>> is being used by anybody...
>
> Anyone who is using the vector processors on the Cell BE processors will
> be using it. However, that hardware is becoming pretty rare now.
>
> We'll want to remove the spufs bits if/when we drop support for the cell
> platforms (IBM QSxx, PS3, celleb). mpe: any ides on that? Do you have a 
> policy for dropping platform support?

I don't have a policy. We discussed it a bit at maintainer summit, that
basically boiled down to stuff should get removed when it is not used
much and/or is causing undue maintenance burden - both of which are
fairly arbitrary criteria.

My feeling is spufs is not causing anyone much work, it does get hit by
some VFS updates but it's just one of many many filesystems, so the
incremental overhead is pretty small I think - though VFS people may
disagree :)

I still have a working IBM QS22, and Geoff is still maintaining PS3,
celleb is gone.

Basically we're keeping it around in case people are still using it on
their PS3s. I don't know how we gauge how many people that is without
removing support and seeing who is annoyed. But even if we did that a
lot of folks will probably not notice for months to years, and when they
do notice they'll just bin their PS3s rather than telling us.

But maybe Geoff has a better feel for how many people (other than him)
are still running upstream on PS3s.

cheers
