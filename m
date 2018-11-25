Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C550AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBF720881
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBF720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeKYM66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:58:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60062 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYM66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:58:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C739514EF0A63;
        Sat, 24 Nov 2018 18:09:03 -0800 (PST)
Date:   Sat, 24 Nov 2018 18:09:03 -0800 (PST)
Message-Id: <20181124.180903.1457197646957052282.davem@davemloft.net>
To:     willemdebruijn.kernel@gmail.com
Cc:     deepa.kernel@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: Re: [PATCH 6/8] socket: Add struct sock_timeval
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAF=yD-+1BJHuajcW=2bpeAp5XOAX2fObyvhOdH-YsiGY3-_J4Q@mail.gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
        <20181124022035.17519-7-deepa.kernel@gmail.com>
        <CAF=yD-+1BJHuajcW=2bpeAp5XOAX2fObyvhOdH-YsiGY3-_J4Q@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Nov 2018 18:09:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 24 Nov 2018 14:37:42 -0500

> On Sat, Nov 24, 2018 at 4:00 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
>> index 04d5587f30d3..106f9398c285 100644
>> --- a/include/uapi/linux/time.h
>> +++ b/include/uapi/linux/time.h
>> @@ -70,6 +70,11 @@ struct __kernel_old_timeval {
>>  };
>>  #endif
>>
>> +struct sock_timeval {
>> +       long long tv_sec;
>> +       long long tv_usec;
> 
> should these use fixed-width type __u64?
> 
> even if all data models define long long as 64-bit, that might be more
> descriptive.

Agreed.
