Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0FCC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 14:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581A620881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 14:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmf8j7+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581A620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbeLBOfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 09:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbeLBOfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 09:35:50 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9C12081C;
        Sun,  2 Dec 2018 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543761346;
        bh=HFjynd9/tRh8MEcfx+KdS+ZjtVAh7rEKNU92/kCUMZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmf8j7+p425QE0+CXctW8DLBBp2fS8BBBVkmPcXVHAe7h4ydOWtTbi1a/GebB4S6g
         v+LSdEADjPut6Qkqs23spHaX5XlHCqMTvNG560WTMZ4nGObUfc6F4ETaMNIgox4F2D
         nzH8lZp5QVAVTydQx0mGRSHpx6pci8ALHNsgVbb8=
Date:   Sun, 2 Dec 2018 09:35:43 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        martin.kepplinger@ginzinger.com, Stable <stable@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Juergen <juergen.lachmann@harman.com>
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
Message-ID: <20181202143543.GE221015@sasha-vm>
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
 <20181129080923.GE13859@kroah.com>
 <1676802.TThbbZSlzy@blindfold>
 <CADVatmP1h7GJJRVURkinwSM44Y4iooMP-U_7zew4V+zsMva4Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADVatmP1h7GJJRVURkinwSM44Y4iooMP-U_7zew4V+zsMva4Vw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 11:50:33AM +0000, Sudip Mukherjee wrote:
>Hi Greg,
>
>On Sun, Dec 2, 2018 at 8:51 AM Richard Weinberger <richard@nod.at> wrote:
>>
>> Greg,
>>
>> Am Donnerstag, 29. November 2018, 09:09:23 CET schrieb Greg KH:
>> > On Mon, Nov 26, 2018 at 11:38:42AM +0100, Martin Kepplinger wrote:
>> > > From: Richard Weinberger <richard@nod.at>
>> > >
>> > > [ Upstream commit 34653fd8c46e771585fce5975e4243f8fd401914 ]
>> > >
><snip>
>> >
>> > Now queued up for 4.14.y, thanks.
>>
>> can you *please* slow a little down?
>
>True. It will really help if you can have some sort of fixed schedule
>for stable release, like maybe stablerc is ready on Thursday or Friday
>and release the stable on Monday. Having a weekend in stablerc will be
>helpful for people like me who only get the time in weekends for
>upstream or stable kernel.

Any sort of schedule will never work for everyone (for example, if it's
part of your paid job - you don't necessarily want to review stuff over
the weekend).

--
Thanks,
Sasha
