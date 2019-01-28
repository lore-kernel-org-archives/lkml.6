Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0C42148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548698713;
	bh=/szYvrSDJrZWv0e/DMQcKHb2F+VlTFitliuA1bO4nkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2dGrshbIO4jwsjZXRtUle3MIv1B7+U4tLJFCy7e1rStF/dA/yJE65auNkRFeEaYzT
	 Tutct497i59LPy5VNR6p5R1IRZV3vZqf8X7OY33TBlcuXUxqNkCHws8VOv+PMghW6A
	 WS2vOp+X/4iOqgUf41SakXg0xFZSYi9VxRuyCXxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfA1SFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfA1SFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:05:01 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741EA2175B;
        Mon, 28 Jan 2019 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548698700;
        bh=/szYvrSDJrZWv0e/DMQcKHb2F+VlTFitliuA1bO4nkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5PAnxXIjoM1lDEvmNtkcFvaKpjq/0LG/0rY3z6JRoFSNoTYxy4BLcik1R7jJKUmu
         AgD3HKSCPm16aYo1z6Hwpbpk4PagPQ3HsU8V/+ZO7tRc9T6xrUN6FQqXAyl7Jy9PZD
         YBcv+gnvbznq2cALDCNOG1JBWigLv7RqhBkKCS8Q=
Date:   Mon, 28 Jan 2019 13:04:59 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 034/258] sctp: Fix SKB list traversal in
 sctp_intl_store_reasm().
Message-ID: <20190128180459.GG3973@sasha-vm>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-34-sashal@kernel.org>
 <20190128170434.GA10665@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190128170434.GA10665@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 03:04:34PM -0200, Marcelo Ricardo Leitner wrote:
>On Mon, Jan 28, 2019 at 10:55:40AM -0500, Sasha Levin wrote:
>> From: "David S. Miller" <davem@davemloft.net>
>>
>> [ Upstream commit 348bbc25c40844c5efa083a3842c7f53d70a815e ]
>>
>> To be fully correct, an iterator has an undefined value when something
>> like skb_queue_walk() naturally terminates.
>>
>> This will actually matter when SKB queues are converted over to
>> list_head.
>>
>> Formalize what this code ends up doing with the current
>> implementation.
>
>I don't think this patch is really needed for -stable without the SKB
>queue convertion, but okay.

I'll drop it. I'm not sure why this sctp patch wasn't filtered out as
davem deals with net/. Sorry for the noise.

--
Thanks,
Sasha
