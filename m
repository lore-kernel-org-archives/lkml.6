Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C854C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E14D21904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WdUuNQo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbeLTUKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:10:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbeLTUKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FjNs8VpeMu00P2stXs8RQhJqfBBhcHqh35FWhSVSkVg=; b=WdUuNQo9V7CR3cPOzpO9qxEMW
        R7+ftCMmLtVGiKF0krOp6NcNbJz6yWf+CvfbVLrIGzFwEwGqyN5fOy6BKYDeV692or32IQnOG3nIx
        ZFT1C9DgDgkFj44z7REcgBuu96/YYNPI4QisUtC10N76FNibJR++/v76cd3zgxJDPJX4q5QwMgazf
        bY0HrWX0M8QGXdACvgw8tupyBP6C+w8aNNZNloOzsBo6LaaER2PYE5PoG1K1mCLY7ZbWCmlntGb8X
        axMxR11wYeyYDacGBU6naBE3ROa4g2DH8JSSKjd5qHo5vGTnTD6rUBeSNyldzJ3n+WiNwcBdqyH3q
        qZFP7bPIw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga4eQ-00028Y-29; Thu, 20 Dec 2018 20:10:34 +0000
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217112437.5fe868eb@lwn.net>
 <8f67a8ca-bf64-c537-843a-b03bcfc3dace@infradead.org>
 <96fc8865-c54f-5c6c-f6c8-d7a5a12735e6@leemhuis.info>
 <20181220082819.69fc3e5c@lwn.net>
 <a02caf89-9221-8e31-4a2d-44b46b81cda2@infradead.org>
 <0996ba55-e5e1-49e2-f0ed-82cb1619ee03@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <abd75184-1d33-4877-eef7-eeca436e5220@infradead.org>
Date:   Thu, 20 Dec 2018 12:10:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <0996ba55-e5e1-49e2-f0ed-82cb1619ee03@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 10:21 AM, Thorsten Leemhuis wrote:
> Am 20.12.18 um 17:38 schrieb Randy Dunlap:
>> On 12/20/18 7:28 AM, Jonathan Corbet wrote:
>>> On Thu, 20 Dec 2018 16:23:38 +0100
>>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>
>>>> While at it: Jonathan, you mentioned putting the script in scripts/, but
>>>> according to the Makefile in that directory it is "for various helper
>>>> programs used throughout the kernel for the build process". That's one
>>>> reason why it feels wrong to put it there. Another one: that script
>>>> targets users and thus we should try to make sure they can access it
>>>> easily. That's why I'm currently inclined to put it in tools/ somewhere.
>>> Yeah, tools/ is a better place.  Maybe a tools/debugging directory or some
>>> such?
>> chktaint
> 
> BTW, I renamed it to kernel-taintstatus, sounded more appropriate to me.
> Does anyone mind?

Not terribly, although that seems too long to me.  ;)
maybe 'taintstatus'?

>> is similar (IMO) to scripts/decodecode though.
> 
> Hmmm. Maybe it would be better to move this to tools/? Will take a quick
> look, guess sooner or later by current endeavours will lead me to the
> documentation that refers to this script anyway.
> 
>> @Thorsten:
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thx. And thx for the feedback in the other reply.
> 
> BTW, for those following this thread and my earlier quest for a simple
> cmd to decode /proc/sys/kernel/tainted: looks like @apexo on twitter
> (thx again!) found a trick to do what I want which should work on most
> systems out-of-the-box:
> 
> $ for i in $(seq 18); do echo $i $(($(cat
> /proc/sys/kernel/tainted)>>($i-1)&1));done

I think Jon mentioned this:  The output should begin with bit #0,
not bit #1, so it should show bits 0 - 17 (or whatever the max is),
not 1 - 18.


-- 
~Randy
