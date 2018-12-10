Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFEBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235A420821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544483016;
	bh=2QAhmTE6HeFe5gWb9ZW4ddkoBsGY7jSscr+kL7a+/8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XtWg7Cfj32usVYT8+Jpn7fdbObGF/JN3O0ppZFvXK5KiUOPsZxFmOZrYw51KRG0z4
	 g9nksdeu3SZV5zQTANjDVIep6TNjE5wUwO/c509g1hSX3/pHHZ30JI1/ZSmM+HTrGB
	 IVhyYCHST+7mEShMZ2ZB16U8eEbmFuHN6VGlTtLQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235A420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeLJXDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:03:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbeLJXDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:03:34 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCAAF20821;
        Mon, 10 Dec 2018 23:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544483014;
        bh=2QAhmTE6HeFe5gWb9ZW4ddkoBsGY7jSscr+kL7a+/8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y49xZ2NbScfCi/UpozpIg7+gKJ0VecHTDHolqVsEX5HojqQlZEFlueK/2SBxDIiFK
         5jinMO4zxYOhyxMom7FXF9CZUk76vAbYpDz4s2vVB3y+5VZh6kd2iL+nPka4IBfSB5
         SoxDBW7z+P1NUbl8jhiklaWCiN+goDpnrU+hSlxw=
Date:   Mon, 10 Dec 2018 18:03:32 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] tools/lib/traceevent: Fix processing of dereferenced
 args in bprintk events
Message-ID: <20181210230332.GH97256@sasha-vm>
References: <20181210134522.3f71e2ca@gandalf.local.home>
 <20181210210921.A4C862084C@mail.kernel.org>
 <20181210162515.4a10d827@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181210162515.4a10d827@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:25:15PM -0500, Steven Rostedt wrote:
>On Mon, 10 Dec 2018 21:09:20 +0000
>Sasha Levin <sashal@kernel.org> wrote:
>
>> Hi,
>>
>> [This is an automated email]
>>
>> This commit has been processed because it contains a "Fixes:" tag,
>> fixing commit: .
>>
>> The bot has tested the following trees: v4.19.8, v4.14.87, v4.9.144, v4.4.166, v3.18.128,
>>
>> v4.19.8: Build OK!
>> v4.14.87: Failed to apply! Possible dependencies:
>>     37db96bb4962 ("tools lib traceevent: Handle new pointer processing of bprint strings")
>
>Bah, I cut and pasted incorrectly the sha1. I had:
>
>7db96bb49629 (chopped off the 3)

You tricked my bot :)

--
Thanks,
Sasha
