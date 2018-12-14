Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE3CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CD6206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeLNTG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:06:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59330 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbeLNTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:06:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C6A1814DF1C8B;
        Fri, 14 Dec 2018 10:58:15 -0800 (PST)
Date:   Fri, 14 Dec 2018 10:58:13 -0800 (PST)
Message-Id: <20181214.105813.1295365050705161277.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
Cc:     sudipm.mukherjee@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, edumazet@google.com, soheil@google.com,
        ycheng@google.com
Subject: Re: [PATCH 4.14 12/89] tcp: Do not underestimate rwnd_limited
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181214142621.GA28340@kroah.com>
References: <20181214115730.277730409@linuxfoundation.org>
        <CADVatmN2tM+zNFmz+upPpV4+g1R1+kg62yL8Q=8jJ4Sy2EU6Xw@mail.gmail.com>
        <20181214142621.GA28340@kroah.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 10:58:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 14 Dec 2018 15:26:21 +0100

> On Fri, Dec 14, 2018 at 02:03:55PM +0000, Sudip Mukherjee wrote:
>> Hi Greg,
>> 
>> On Fri, Dec 14, 2018 at 12:08 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >
>> > 4.14-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Eric Dumazet <edumazet@google.com>
>> >
>> > [ Upstream commit 41727549de3e7281feb174d568c6e46823db8684 ]
>> 
>> There is one upstream commit which fixes this one.
>> f9bfe4e6a9d0 ("tcp: lack of available data can also cause TSO defer")
> 
> I can take this if Eric and/or David ack it :)

Acked-by: David S. Miller <davem@davemloft.net>
