Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2999C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A7620873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIZbuwaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A7620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeLMCDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:03:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37127 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeLMCDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:03:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so253196plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 18:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UjZBh/bAPUwkg3HpYHmym8vez0Qh5RE9CNc/Xw+QIB0=;
        b=XIZbuwaKb7jm5cEBumQUQdSS0hoEhuaYd98aPV+NaINZ6rHQhRKgkdXM5X9v/1/Nrm
         axnOxvOqIgDTjzPDoDtKTI7Iw+nZ1PsfoVbJg445j3GPedENhgwMLG7s2r0j1H6n5bY5
         XwAOicejlthbA4dGjl5008/FM5NFio7QZIz/7h5thuBY/sHkHZOOUi2aCemE8pv1xp+R
         0+FiasesziiOiIuiR62zYMcKk+FCobTKqYE9F0x4MGjdznPNkClLzTuYLowcCUx5UTrk
         NRdS3P5NbitZk0AxihsvPxK3tkOG8HCEnAD4ObDa66hQkmNmUn+hvWFIgPozNOoQhyd2
         d6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UjZBh/bAPUwkg3HpYHmym8vez0Qh5RE9CNc/Xw+QIB0=;
        b=gIlFV3R3KHDd/MicQw68eG1srJ7cam9C7nRl8ZaTtU9woTf+w9gkbAs78/oK8a/bes
         r8Z88YWLumwehuDrvFSdkeFnUMP13i/W0mPvhwXu/5qFnUORta6b2lar013lZrn7aEV5
         y9kp4H8ifJWbffyr37l5Pc5UzEpmoBr9SZ6jgOipNkZArqVZtnjzwb/blydvxBTv7QNI
         LnfZfabM9E4Dxukv6/TsJuEgXRixTqvGLJNa7L5LCS82YKdE5MGXTxiAiauUWvH4F/A8
         VgDQMpQrGRVrote3E7aDeAtshWZtnWfUeYGUPBBsJfOmcPQL0nG89B3FajD5Ku7k/r43
         XP5A==
X-Gm-Message-State: AA+aEWZvEwkj9IDOiGLX4xVU7tF+yqIhnNpBBV0eSn900Xe1T+8l+ZSb
        xYyklx1sn/9xkitAKbpGtw0=
X-Google-Smtp-Source: AFSGD/V1ccIsdkEGygYqHo/O2xXNUPzD12LSb7gMh1+zF8jO4QYwavhjex0dBUDNmPT19hm8EKjdAw==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr22243409plb.312.1544666626324;
        Wed, 12 Dec 2018 18:03:46 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id g5sm331781pgu.57.2018.12.12.18.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:03:45 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:03:42 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181213020342.GA4860@jagdpanzerIV>
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544653694-27873-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 17:28), Waiman Long wrote:
> The db->lock is a raw spinlock and so the lock hold time is supposed
> to be short. This will not be the case when printk() is being involved
> in some of the critical sections. In order to avoid the long hold time,
> in case some messages need to be printed, the debug_object_is_on_stack()
> and debug_print_object() calls are now moved out of those critical
> sections.
> 
> Holding the db->lock while calling printk() may lead to deadlock if
> printk() somehow requires the allocation/freeing of debug object that
> happens to be in the same hash bucket or a circular lock dependency
> warning from lockdep as reported in https://lkml.org/lkml/2018/12/11/143.
> 
> [   87.209665] WARNING: possible circular locking dependency detected
> [   87.210547] 4.20.0-rc4-00057-gc96cf92 #1 Tainted: G        W
> [   87.211449] ------------------------------------------------------
> [   87.212405] getty/519 is trying to acquire lock:
> [   87.213074] (____ptrval____) (&obj_hash[i].lock){-.-.}, at: debug_check_no_obj_freed+0xb4/0x302
> [   87.214343]
> [   87.214343] but task is already holding lock:
> [   87.215174] (____ptrval____) (&port_lock_key){-.-.}, at: uart_shutdown+0x3a3/0x4e2
> [   87.216260]
> [   87.216260] which lock already depends on the new lock.
> 
> This patch was also found to be able to fix a boot hanging problem
> when the initramfs image was switched on after a debugobjects splat
> from the EFI code.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

The patch looks good to me. A bit curious if we need to also patch
the self-test part debugobjects - check_results(). That guy still
printk()-s under bucket ->lock.

	-ss
