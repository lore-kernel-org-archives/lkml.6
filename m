Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B47C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E820720875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYmsgk+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E820720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeFUDVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:21:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45901 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbeFUDV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:21:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so773652pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 20:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=7kY3i7BmDLb/n8wyrsOFnJPe4bMBBoW1BMNv5XmrVgU=;
        b=uYmsgk+zFxu6ZztWlLzEFzIzLsYj9by17nw0SgDs9z8SivohAPktrv2XNMS6P/9wB7
         R3NikJeF0IUhthrDLHUvLyLRMYEvieKMwSwtydz2oI1J+9ZuRf+Gz3UDPS8lik5bH5La
         DIMIlwGIL3bs1mmSsv7WnM13kG20S1PLOyBP4rHNMsGEND3DUN23Yj+I6GvLhVaiXP2w
         LUjYpBXiQOjbIUxvqbAomj6w9x96VbRy72e2LuPCHs7EZYncGh3GQBQU8RmWNWpAr4Cq
         nc91YAkRIrMWXVwin8k+Vsrn5GpBNGU7sW9kpr3Vwq154mvqs0PtWyqwGlG3Yc1AjeaY
         27lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=7kY3i7BmDLb/n8wyrsOFnJPe4bMBBoW1BMNv5XmrVgU=;
        b=eYRSsk44K5EbYoj9jTcg6wF3TDLGxIeVtdJ3uIUaN3BapROvJf5364DRE6Ec3ybFqD
         I6bKd0LivFhSBUuk7ufyOiv0P1gvUI+giefylXILZ6DUvJmszQyqtKR9g7fYyt7FzwCI
         y45IX6CvoKX1X6Ozl1WAlxcHk/lTHKpJuiSSO0VVSZavqG+8YL3puYc4u3cdFkhmaBQT
         rvvabN6sjZK7T87bVWqPbof82qbWJ5MMAJOLfEQamFviU83IckEpkL8s4lOq0Jbjemvu
         yy8BBE+2kGmwGyvQxrHkzJnr4qwymu0CxTIAAB/5cL5LRqogzD+Gkikt/+SPrSTa8TMn
         A0ag==
X-Gm-Message-State: APt69E28WFZEUTY6upmNY5guxk1eHmUAXsCWunDcuuc7gfFIWsiyj9Y/
        vlJKVGFmjVIcUXebLOHblMR6mEnD
X-Google-Smtp-Source: ADUXVKKXUDKYgGzsO0+T1r55/i3p3lJ5GkMQ6K2XYUL6twej5rj0jQX0P32xD+eKxbp2yVAMmrp6GQ==
X-Received: by 2002:a62:234a:: with SMTP id j71-v6mr24921607pfj.221.1529551288674;
        Wed, 20 Jun 2018 20:21:28 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.11? ([2402:f000:1:1501:200:5efe:a66f:460b])
        by smtp.gmail.com with ESMTPSA id b4-v6sm4357200pgq.51.2018.06.20.20.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 20:21:28 -0700 (PDT)
To:     akpm@linux-foundation.org, dvyukov@google.com,
        Greg KH <gregkh@linuxfoundation.org>, tchibo@google.com,
        aryabinin@virtuozzo.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] kernel: kcov: a possible sleep-in-atomic-context bug in
 kcov_ioctl()
Message-ID: <ca2e4f0b-dd08-8d66-51e3-05cc69e15d65@gmail.com>
Date:   Thu, 21 Jun 2018 11:20:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep with holding a spinlock.
The function call path (from bottom to top) in Linux-4.16.7 is:

[FUNC] vfree --> can sleep
kernel/kcov.c, 237: vfree in kcov_put
kernel/kcov.c, 396: kcov_put in kcov_ioctl_locked
kernel/kcov.c, 410: kcov_ioctl_locked in kcov_ioctl
kernel/kcov.c, 409: spin_lock in kcov_ioctl

This bug is found by my static analysis tool (DSAC-2) and checked by my
code review.

I do not know how to correctly fix this bug, so I just report them.


Best wishes,
Jia-Ju Bai
