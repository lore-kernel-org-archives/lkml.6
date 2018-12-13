Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D5C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DDA20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TtOuM+AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DDA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeLMEfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:35:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33413 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeLMEfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:35:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so927031eds.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=orM2T302GLXd0qMe7L+3lsCuQEdR41QPOhOJq1iDZBs=;
        b=TtOuM+APjrNVmBFtWlXl3zybutIVzVT/jShq4Wy8oZdEmUTvBzQqtVUNRB863/Vpqw
         y8IDn65z1HjK1k/i1FSlZ4f3AJ96xva902efwQJflwEBGTAhrsDGmSf3KXITUI9rvAZy
         A65QoC/EbvPXEuWVP+tVg+bc1FKBsAsXoZiKUQQGpOhCGoB5yJWcYZWDEyMqNvEX8V3a
         w9JWyMCGw8YprVeCeMcg63Zr7P5dNZ4CIdUG5eEJv9CPjgFskNWmAcnN3Un5Fi3n2o2B
         g4xPS4d83Tn8ifVRENl3+tnpnsoVUZWHae4YexAqrtV+uNnLC1Jh/r7bIcx2ZRNSAuoa
         wf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=orM2T302GLXd0qMe7L+3lsCuQEdR41QPOhOJq1iDZBs=;
        b=QQbBcYqaQgBy4wUuBoqnqNSrIgZkVGm0mXnybugpJtoQyBM7RBE6XJ4ArJ9PtgVWYi
         h/rW2z8up6fsJJHN1c90I6j3zI91jy7zZ7qzsXeeBqjnejFv805s9dS2hM9W5+aO8SGp
         y3/kS72aJL6pwVJymFPnBGQ2ng4MvM/KYdCif15y500wIpxAcE7H8b8otgAYGqxNlqfD
         W730mK9ySO4RBX8OPyTyT+dZONgqrB9ebxr6r53KX82m0Sp1DEVO2hCm+ZnllHW3fJAE
         weBAM8kMUbWwkZIQMlqcqhVAeeLdHgE49r2sV+4y3cELt+pE7ePb6Y/q/UGitusFsGgF
         qFFg==
X-Gm-Message-State: AA+aEWZkb87BQ6ga0n98ur8wyM5Jd2hfmex1IyRi4epAQldpidW/XR2b
        hPM10V6PrlHQYLTxrsxL5Hha3A==
X-Google-Smtp-Source: AFSGD/XSNonmjwvrbtSVvFphSo3ObpghbUv2H+lMojqib528abRDlxyCUe/VAAbWZBo98XCZgWuAQg==
X-Received: by 2002:a17:906:340a:: with SMTP id c10-v6mr4927493ejb.130.1544675706209;
        Wed, 12 Dec 2018 20:35:06 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k31sm312210ede.5.2018.12.12.20.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 20:35:05 -0800 (PST)
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical
 sections
To:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <9cb1526a-e82f-dfa7-4b3c-5ea911a8d476@arista.com>
Date:   Thu, 13 Dec 2018 04:35:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1544653694-27873-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On 12/12/18 10:28 PM, Waiman Long wrote:
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
> ---

I've tried to review it and found minor issues like missed
debug_object_is_on_stack() for initializing already active object.

But than I come to opinion that it's just generally unsafe:
debug_obj life-time is protected by bucket's spin_lock.
Check the conditions when free_object() is being called.

So, I resulted by finishing my stack-copy version which I've started
yesterday on test robot report when I didn't know about your patch.

I've sent it now concurrently.

Thanks,
          Dima
