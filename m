Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF01C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F342077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLYWZdWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F342077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeJKTis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:38:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43117 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbeJKTis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:38:48 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so6368769ioa.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wj8+PqkbOsaOoQE10HDfYExr3V0xGoDhaVqrrPiUxs0=;
        b=LLYWZdWk798vrOJdvw1jAcjHfO3vnQ7HVE6o+0GFhby17xHuGcVruZng34g3jmYpyp
         oi7lquzbWl6wwW82/03yBCl0vEphXrJ2+axKkG0bFwzW8eZ94k6Wr5cckO5MWl1lLr0Q
         IoYRClyjQzoNPS8GHbeUuz9WoM2/IuIKG2FQeBypAST9Qzp8kNX2Hsl7JCyQOzZAeVaI
         CYNIjvTSdkckcgKFockVeIU/G2YNjMoWl+rGu5aUG8t1nF0FYiqAkPPTRtmnfgim/oge
         TYMm/YXEiAcJp1Pw9v4meYevNo5/Z4zTbVubnnLUkOGIfBsy9fnBhChyp3A6hk4rcl+b
         b81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wj8+PqkbOsaOoQE10HDfYExr3V0xGoDhaVqrrPiUxs0=;
        b=e7gJ+dJah9xrlc4euOpE6HmwVcXcASo4gWU9L4PT2PZntuJKm599+14okGwOn981BA
         xQACY79bPeV8xXK6k5uMvo/tuaAlrgMdbn8B5KB2ZZmmVh9eJUWEO907gnTTU3FmYUYT
         r5jQ88tHdxT/mS9GV+ntCU9HEEiX+aFT7juFrf34Ul6bnKbVlOrP4xHjjaaNB6SJjp1I
         LcvmxJdKTqfZ66ZxUFjmRMhrReyJKtLwvppYhxD2+l3o2ensN8bX3mDy1o9tbnU+pWYp
         jJc/d7QxQg9oItg+2tF67x2CR2lNGZWS0riVZRfMmUXPVRiYTFSn6m045pGF92nVlxO9
         3VwQ==
X-Gm-Message-State: ABuFfogOR21eFJ0Gcnp80frUdtqVKnc1A8g8Dm8UzXOuF4f6/IimBUuo
        lP5O96jVNx17Ry0m9XqZFFXIwGe8kyaCKLB61i/U22gn
X-Google-Smtp-Source: ACcGV60o9Fq6W7UwZw9G+pdKVYmd+R4skc1WypxwemjGx5f27dEufBzbsczfzqTKiVQKoNUMBwF842wKaC8t0yvflE8=
X-Received: by 2002:a6b:6209:: with SMTP id f9-v6mr839478iog.11.1539259910225;
 Thu, 11 Oct 2018 05:11:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 05:11:29
 -0700 (PDT)
In-Reply-To: <97d8c196-cd11-8859-fc14-ed12191f52af@windriver.com>
References: <CACT4Y+bcxEz=P2E5TRj6A1qeCOQ+WtWR44WGLzqdDttLzD393A@mail.gmail.com>
 <CACT4Y+Ym3_NuqWrgHXWfTahWTm17xi_2gjy8hvuDeyUCPuYXUQ@mail.gmail.com> <97d8c196-cd11-8859-fc14-ed12191f52af@windriver.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 14:11:29 +0200
Message-ID: <CACT4Y+Y-5B2n3ccHMzPro1dD-30ZiGnZ9Zy59aT8iVKjvHemxA@mail.gmail.com>
Subject: Re: net/tipc: recursive locking in tipc_link_reset
To:     Ying Xue <ying.xue@windriver.com>
Cc:     Jon Maloy <jon.maloy@ericsson.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 2:03 PM, Ying Xue <ying.xue@windriver.com> wrote:
>>> Hi,
>>>
>>> I am getting the following error while booting the latest kernel on
>>> bb2d8f2f61047cbde08b78ec03e4ebdb01ee5434 (Oct 10). Config is attached.
>>>
>>> Since this happens during boot, this makes LOCKDEP completely
>>> unusable, does not allow to discover any other locking issues and
>>> masks all new bugs being introduced into kernel.
>>> Please fix asap.
>>> Thanks
>> -parthasarathy.bhuvaragan address as it gives me bounces
>> but this is highly likely due to:
>>
>> commit 3f32d0be6c16b902b687453c962d17eea5b8ea19
>> Author: Parthasarathy Bhuvaragan
>> Date:   Tue Sep 25 22:09:10 2018 +0200
>>
>>     tipc: lock wakeup & inputq at tipc_link_reset()
>>
>>
>
> Dmitry, I agree with you. The complaint should be caused by the commit
> above. Please try to verify the patch:
> https://patchwork.ozlabs.org/patch/982447.


I trust you for testing ;)

Thanks for the quick fix!
