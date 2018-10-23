Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A199C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BE220652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0adIbb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BE220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeJXANI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbeJXANI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:13:08 -0400
Received: from localhost (unknown [185.7.230.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB8A020652;
        Tue, 23 Oct 2018 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540309751;
        bh=OtDAkJ5WP5ygueOGQcHF2S6JPxgCh/geZXn/huDDOVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0adIbb8qN6UsU/oPP1t0YjhPnxszCAX2ulMjRBErCW5XNP0Wsf6kMJJgYvy1VHFc
         nJTlMeDG+HioqUWjKLBvq/IB7CMYCpRgOl3JGbLP0wBnVpw5cPxsZBq8ZxIIJbmcbm
         7KIkDOe1sVBqAnM8OnsqUkWYj4gYFDyVWsiN0beE=
Date:   Tue, 23 Oct 2018 11:49:08 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.18 08/27] Input: evdev - add a schedule point
 in evdev_write()
Message-ID: <20181023154908.GB24189@sasha-vm>
References: <20181022101924.40531-1-sashal@kernel.org>
 <20181022101924.40531-8-sashal@kernel.org>
 <20181022170244.GB27929@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181022170244.GB27929@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 10:02:44AM -0700, Dmitry Torokhov wrote:
>Hi Sasha,
>
>On Mon, Oct 22, 2018 at 06:19:05AM -0400, Sasha Levin wrote:
>> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> [ Upstream commit 36d2582ff235b4e01ad64a734c877a52dc762d9c ]
>>
>> Large writes to evdev interface may cause rcu stalls. Let's add
>> cond_resched() to the loop to avoid this.
>
>This is not needed in stable:
>
>- the interfaces are not accessible for unprivileged users so there is
>  no DOS concerns
>- the issue can only happen on non-preemptible kernels
>- the issue only showed up with synthetic test and not real life use
>  cases
>- this is not a regression
>
>The same goes to similar patches to mousedev, joydev and uinput that you
>autoselected.

Dropped, thanks!

--
Thanks,
Sasha
