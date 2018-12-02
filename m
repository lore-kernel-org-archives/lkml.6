Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45D2C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996902145D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNjLc8/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996902145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeLBPcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbeLBPcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:32:55 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC3B2081C;
        Sun,  2 Dec 2018 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543764772;
        bh=ZyZj8UbhSeQzaYFX1AyNE6wl6HzVZvmRKfkPflrF9iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNjLc8/+yc4xjmjgahm9HcfJFrd16+wEsAygK6rE1bRrr/Psjc8w2lo+xWujzI+bA
         oM6Zp7WwL/JFzOQ6vdyQOaOVanQjR239gGmR6V4yu50P1aEIqH5E1jycCwvr576HZw
         m4KLb5fTmrdivnr1x1hf+uIVLJ21VN40s7DSOLsw=
Date:   Sun, 2 Dec 2018 10:32:44 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        martin.kepplinger@ginzinger.com, Stable <stable@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Juergen <juergen.lachmann@harman.com>
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
Message-ID: <20181202153244.GJ221015@sasha-vm>
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
 <CADVatmP1h7GJJRVURkinwSM44Y4iooMP-U_7zew4V+zsMva4Vw@mail.gmail.com>
 <20181202143543.GE221015@sasha-vm>
 <1678636.EYQpd7BODG@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1678636.EYQpd7BODG@blindfold>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 04:02:47PM +0100, Richard Weinberger wrote:
>Sasha,
>
>Am Sonntag, 2. Dezember 2018, 15:35:43 CET schrieb Sasha Levin:
>> On Sun, Dec 02, 2018 at 11:50:33AM +0000, Sudip Mukherjee wrote:
>> >> > Now queued up for 4.14.y, thanks.
>> >>
>> >> can you *please* slow a little down?
>> >
>> >True. It will really help if you can have some sort of fixed schedule
>> >for stable release, like maybe stablerc is ready on Thursday or Friday
>> >and release the stable on Monday. Having a weekend in stablerc will be
>> >helpful for people like me who only get the time in weekends for
>> >upstream or stable kernel.
>>
>> Any sort of schedule will never work for everyone (for example, if it's
>> part of your paid job - you don't necessarily want to review stuff over
>> the weekend).
>
>a schedule is not needed, but please give maintainers at least a chance
>to react on stable inclusion request.
>In this case Martin asked for inclusion on Monday and the patch was applied
>two days later.
>
>As you noted not everyone works full time on the kernel and gets paid for that.
>So it might take a few days to react and review such a request.

Yes, that's fair, I wasn't arguing against that.

--
Thanks,
Sasha
