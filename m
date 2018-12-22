Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A476C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01DD21920
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545506175;
	bh=BhHSPxjMfzxRY4VjDfI3pJHpoByijvCOwmgepcrouCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H+HF/iAN+3ijobJmd1po4B+z6Wz98QzTuHHLzws+ScWF2E/WAyRqEgqONod1oZPWC
	 t8RpI2IW7dJLfs6/iSAv3VlNHXIba2Tj/ipUrLMFZTFzApQr27OcaOmcHVBm5w9u93
	 yFhi66tJEd+S3JeB+10iozQOwHHcQrStS6ZhrE78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbeLVTQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731157AbeLVTQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:16:14 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C9E21920;
        Sat, 22 Dec 2018 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545506173;
        bh=BhHSPxjMfzxRY4VjDfI3pJHpoByijvCOwmgepcrouCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlH9Vr6L0TED7XugsqY5Gt0iOc0atgdcxSck97iF+0d39eUj2XV3N4bgryF+ubSJj
         0PE6r2pANQTT7mmmooNiTRXOeJ6h8sSobgQb+y9KsRtGLtUB7TGZ6nl2qY3+6e5p2w
         8xGGgiyew8zLZAoen6i8OPfKUvd67ZmZJ72gmzJM=
Date:   Sat, 22 Dec 2018 14:16:12 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: math-emu: Write-protect delay slot emulation pages
Message-ID: <20181222191612.GQ86645@sasha-vm>
References: <20181220174514.24953-1-paul.burton@mips.com>
 <20181220192616.42976218FE@mail.kernel.org>
 <20181221211603.r7226vjkubi3lfzg@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181221211603.r7226vjkubi3lfzg@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:16:37PM +0000, Paul Burton wrote:
>Hi Sasha,
>
>On Thu, Dec 20, 2018 at 07:26:15PM +0000, Sasha Levin wrote:
>> Hi,
>>
>> [This is an automated email]
>>
>> This commit has been processed because it contains a "Fixes:" tag,
>> fixing commit: 432c6bacbd0c MIPS: Use per-mm page to execute branch delay slot instructions.
>>
>> The bot has tested the following trees: v4.19.10, v4.14.89, v4.9.146,
>
>Neat! I like the idea of this automation :)

Thank you! :)

>> v4.19.10: Build OK!
>> v4.14.89: Build OK!
>> v4.9.146: Failed to apply! Possible dependencies:
>>     05ce77249d50 ("userfaultfd: non-cooperative: add madvise() event for MADV_DONTNEED request")
>>     163e11bc4f6e ("userfaultfd: hugetlbfs: UFFD_FEATURE_MISSING_HUGETLBFS")
>>     67dece7d4c58 ("x86/vdso: Set vDSO pointer only after success")
>>     72f87654c696 ("userfaultfd: non-cooperative: add mremap() event")
>>     893e26e61d04 ("userfaultfd: non-cooperative: Add fork() event")
>>     897ab3e0c49e ("userfaultfd: non-cooperative: add event for memory unmaps")
>>     9cd75c3cd4c3 ("userfaultfd: non-cooperative: add ability to report non-PF events from uffd descriptor")
>>     d811914d8757 ("userfaultfd: non-cooperative: rename *EVENT_MADVDONTNEED to *EVENT_REMOVE")
>
>This list includes the correct soft dependency - commit 897ab3e0c49e
>("userfaultfd: non-cooperative: add event for memory unmaps") which
>added an extra argument to mmap_region().
>
>> How should we proceed with this patch?
>
>The backport to v4.9 should simply drop the last argument (NULL) in the
>call to mmap_region().
>
>Is there some way I can indicate this sort of thing in future patches so
>that the automation can spot that I already know it won't apply cleanly
>to a particular range of kernel versions? Or even better, that I could
>indicate what needs to be changed when backporting to those kernel
>versions?

The "official" way of doing that is described here:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst#n101

However, most people just either add a comment in the commit message, or
reply to the patch mail (or the "FAILED:" mail from Greg) saying how to
fix this. Either way works really.

Greg will also usually look up these automated mails when he adds stuff
to -stable, so if you describe how to deal with it here (like you did
above) is enough as well.

--
Thanks,
Sasha
