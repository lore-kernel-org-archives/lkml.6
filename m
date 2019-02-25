Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D9CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC282084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfBYSZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:25:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYSZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:25:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4B6AF14EE18E5;
        Mon, 25 Feb 2019 10:25:49 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:25:48 -0800 (PST)
Message-Id: <20190225.102548.247362521843809607.davem@davemloft.net>
To:     eric.dumazet@gmail.com
Cc:     mail@timurcelik.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tun: fix blocking read
From:   David Miller <davem@davemloft.net>
In-Reply-To: <b727b3bb-ec46-12bf-dd38-0363c9ca5854@gmail.com>
References: <20190223115313.15064-1-mail@timurcelik.de>
        <20190224.221236.905722532971991928.davem@davemloft.net>
        <b727b3bb-ec46-12bf-dd38-0363c9ca5854@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Feb 2019 10:25:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 25 Feb 2019 07:53:08 -0800

> 
> 
> On 02/24/2019 10:12 PM, David Miller wrote:
>> From: Timur Celik <mail@timurcelik.de>
>> Date: Sat, 23 Feb 2019 12:53:13 +0100
>> 
>>> This patch moves setting of the current state into the loop. Otherwise
>>> the task may end up in a busy wait loop if none of the break conditions
>>> are met.
>>>
>>> Signed-off-by: Timur Celik <mail@timurcelik.de>
>> 
>> Applied and queued up for -stable, thanks.
>> 
> 
> First part of the patch was matching the changelog, however
> the second change was not really needed, or should have used 
> 
> __set_current_state(TASK_RUNNING);

Timur, please followup.
