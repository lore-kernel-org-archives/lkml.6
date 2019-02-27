Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78674C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45123218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551289105;
	bh=EqoXXfWva20wppUEgsELWuum7qWqGz5tslGFQmEJ+5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kv4hc/uSVxSIM7CD+0H9LCCj9DZ0naSc5DtUozRJanJ50xSXGsSfS0DnuEfu4mHWb
	 pBOv9pCykiqHldJvrNfrDtH9UfrhOHm2kYzRrVe/h1zeuWVk5ji3inoEnoZRwCqvES
	 Jgc3Hzk62hSw60YyUJoy8YoGa/nBV5bBxlsprp8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfB0RiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0RiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:38:23 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B21D20C01;
        Wed, 27 Feb 2019 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551289102;
        bh=EqoXXfWva20wppUEgsELWuum7qWqGz5tslGFQmEJ+5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2BdtGI9ItkmJVEqzDadwcs7Yv6gDZRftlIf1fGc43GqkMeFm1G/zr9sv31R7IhYUm
         N7J6ZEWWlRi6I5xMPCSEleUXGqkQfFkM2sW2aIyNxRR7nE+/NQmUo7sKeMwZYveUAx
         eObsElXUlM+PkrXPAJ3wCc97N9BXklvJryzzuwN0=
Date:   Wed, 27 Feb 2019 12:38:21 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 42/77] dm: fix clone_bio() to trigger
 blk_recount_segments()
Message-ID: <20190227173821.GK10616@sasha-vm>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-42-sashal@kernel.org>
 <20190215034909.GB17226@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190215034909.GB17226@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:49:09PM -0500, Mike Snitzer wrote:
>On Thu, Feb 14 2019 at  9:08pm -0500,
>Sasha Levin <sashal@kernel.org> wrote:
>
>> From: Mike Snitzer <snitzer@redhat.com>
>>
>> [ Upstream commit 57c36519e4b949f89381053f7283f5d605595b42 ]
>>
>> DM's clone_bio() now benefits from using bio_trim() by fixing the fact
>> that clone_bio() wasn't clearing BIO_SEG_VALID like bio_trim() does;
>> which triggers blk_recount_segments() via bio_phys_segments().
>>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please no, I later effectively reverted this change with commit
>fa8db4948f522 ("dm: don't use bio_trim() afterall")

I've dropped it, thank you.

>(As and aside, I really shouldn't have to defend against stable@ bots
>picking up a commit, like 57c36519e4b949f, that wasn't marked for
>stable@.)

Is it the case that this commit isn't appropriate for stable for some
reason, or was it just buggy?

--
Thanks,
Sasha
