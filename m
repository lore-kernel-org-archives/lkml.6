Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B99C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3672F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548702537;
	bh=+jbsUdwYLhZ4Bd0EKnvnepxK2jt06DrWhRLqag714lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vCC/Olec3m/qFYotigyiGM8RG+ETdBWxyp6pp+AR6t4fUOkro8RXqdWtBWiUDC/hF
	 KGQopuCs2eOj3nMn4CJtLyzGdEU2BIAPbiwS4paAroOcla5tJZ/5uqv6Nd8MHvbz8j
	 ho4iS7fazmFh9cr3E54xuE/Qt2pOdbCiB+B1qTEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfA1TIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:08:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfA1TIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:08:55 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3C920989;
        Mon, 28 Jan 2019 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548702534;
        bh=+jbsUdwYLhZ4Bd0EKnvnepxK2jt06DrWhRLqag714lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zePydK1KGMLKJuO7+FBi5kJo6qy+UFOB3Zd0G2jkLq8k87ChzCzQzn4if2zGyHc8S
         yW6fIK7mye2DHqf6zT+NFiI9H82/N0uTpZ8A1WxEK3a9ILx8RM1Qx3jdmFcQZ+o9XO
         pnb5/0mwhkKsmOt4z9unHRjPfULkJxH28HVRBrNM=
Date:   Mon, 28 Jan 2019 14:08:53 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 148/304] Input: rotary-encoder - don't log
 EPROBE_DEFER to kernel log
Message-ID: <20190128190852.GI3973@sasha-vm>
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-148-sashal@kernel.org>
 <20190128182405.GA30191@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128182405.GA30191@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:24:05AM -0800, Dmitry Torokhov wrote:
>Hi Sasha,
>
>On Mon, Jan 28, 2019 at 10:41:05AM -0500, Sasha Levin wrote:
>> From: Uwe Kleine-König <uwe@kleine-koenig.org>
>>
>> [ Upstream commit 0832e93632c61987d504e251b927a2be769dd21a ]
>>
>> When a driver fails to bind because a resource it still missing it's not
>> helpful to report this as (usually) probing is repeated later.
>
>I do not think that patch that merely suppresses a harmless warning in
>dmesg belongs in stable.

I'll drop it.

FWIW, my experience with users is that unexplained warnings in dmesg
sometimes end up being even more trouble than an actual bug :)

--
Thanks,
Sasha
