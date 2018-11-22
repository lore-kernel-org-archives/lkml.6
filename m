Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC13BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C2720838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW0Vzmnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C2720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404636AbeKWGXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389492AbeKWGXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:23:15 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE03620685;
        Thu, 22 Nov 2018 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542915746;
        bh=EQOUARoGjQGg+u4cWfac16ITD1249PlBz+mOauJ2XLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MW0Vzmnp4PfUZVa1054pxyU5YT+73EjDmdOtNmI2X65eiubvLlKlTqgMzZ3Ag79zj
         ae3+RInaJDJBXSJK6anw8qo/aq9eBHLT2x3ro+eJoXRrapSjb4/Fknm17q3okbnSyF
         tKyLAMmL86VGBCnauyYrblZMPs2GNvKGQTr3k7Ao=
Date:   Thu, 22 Nov 2018 14:42:23 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Tigran Aivazian <aivazian.tigran@gmail.com>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH AUTOSEL 3.18 1/9] bfs: add sanity check at
 bfs_fill_super()
Message-ID: <20181122194223.GE9725@sasha-vm>
References: <20181113055252.79406-1-sashal@kernel.org>
 <CAK+_RLnZiy13paU3tRggDpanLv=h+ZCcyXtOz_2UzWfy4tsu2w@mail.gmail.com>
 <CAK+_RLmkDfmxQcNMk7_eoC+=PQ=T9nPc=FVSiHbJADouypcEBQ@mail.gmail.com>
 <CAK+_RLmg=7Dz8umJYXr7at42Kw27H47prqmzLEGF-F5B2bviqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK+_RLmg=7Dz8umJYXr7at42Kw27H47prqmzLEGF-F5B2bviqw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 08:00:56PM +0000, Tigran Aivazian wrote:
>On Tue, 13 Nov 2018 at 19:40, Tigran Aivazian <aivazian.tigran@gmail.com> wrote:
>>
>> On Tue, 13 Nov 2018 at 08:31, Tigran Aivazian <aivazian.tigran@gmail.com> wrote:
>> > Andrew, if you would like me to make the same patch against 4.19.1 as
>> > well, please let me know.
>>
>> I decided to just go ahead and backport it to 4.19.1 anyway (see
>> attached). Tested thoroughly under 4.19.1.
>
>I just missed the 4.19.2 release by a few minutes.
>And just as well, because the 4.19.1 patch contained a double of a
>(trivial) chunk (change to comment in include/uapi/linux/bfs_fs.h) in
>which "gmail.com" was misspelled as "veritas.com" :)
>
>So, the final patch against 4.19.2 is attached.

Hm, but this one is not upstream yet? I'll wait with it until it gets
some time to soak upstream.

--
Thanks,
Sasha
