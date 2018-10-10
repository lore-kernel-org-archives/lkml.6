Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED9DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D67D2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrkNGi8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D67D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJJPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:47:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50438 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJPrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:47:07 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so710515ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GvcoGoIzsfjuwhH+CMiW9vTBiW596lvMfquEE2xEa68=;
        b=CrkNGi8h6woKTsGCPweqhp3j8cABILD+nRYn/onE7O1d7YUKES5M0/kAiCxv1aJiXg
         GAKtS9KFV4uCXv6fctPL0sYwfedBM7iTvDtVaNpE9DoAM4PGc9AnabL5t5NDodEoPWx1
         AHsrG+t+BCh0Cc3IwP5Gutu7QnPf8JkcxFgF17QWLeoq/OEGp2mwF0tio6dVGW/szszM
         UQERKIIfL54/AMa/ctpKo2j/RMOZN7WBM81S6iNMtfZ0wP2puz52JnXAkR7rhuRQBn/G
         ljzNvwN8VKw0wq/N4hWTJf+CVckdnqPSlpHVYm2+Cho3iMwQ8MH82URii06UhoukZLdD
         v+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GvcoGoIzsfjuwhH+CMiW9vTBiW596lvMfquEE2xEa68=;
        b=Y3aC+hWEk0WdT39QozXn+rSr3w9Hl1cqoL1ILxAUZLk0UYhW2RM245JLhrfbvgcRZh
         A2nRtjplM+lIMivW0rlRT+fXmqAs7MvpnrveMkQxvJoM7IIa56zNVgvS1VF4DMMI9C4J
         n51a+cYKxAL9ApqYaVBgq5lx9JitV1OTYvBhhhlgU9f95g5kpDup7zAnxT/JRrk4Elzp
         UEBmyVuJKEhY80yvtf7GMPy213JmdSAx4acqOw+MZv9YsoBCfR4o+SM8ghXeYdyAq6Xz
         TY+uZT5HG70Id2SjhnygXNMhRp0GzaKUIqoYi9LvETiKLjVHsIelJX2M9vgRSiQvKGkf
         hjLQ==
X-Gm-Message-State: ABuFfojFC6W7qwYzoMAbP3d5mxB7ynEU3+uMwRtMVLSFRRsnNkgK1KL+
        kr5w8E/+NWuVLNM702Ry+sstNfbNcfSnwDc9nJsx4w==
X-Google-Smtp-Source: ACcGV60OwUGLV5Ghim5f9fM32U3m3dQ8UGzdU2wRB5KaN2Vn4JKHn3X81FB1BPHY9jME04pIuj4uc/PvO8/IegglJZA=
X-Received: by 2002:a02:55c1:: with SMTP id e184-v6mr24682888jab.35.1539159962837;
 Wed, 10 Oct 2018 01:26:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 01:25:42
 -0700 (PDT)
In-Reply-To: <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
References: <20180918152931.17322-1-williams@redhat.com> <20181005163018.icbknlzymwjhdehi@linutronix.de>
 <20181005163320.zkacovxvlih6blpp@linutronix.de> <CACT4Y+YoNCm=0C6PZtQR1V1j4QeQ0cFcJzpJF1hn34Oaht=jwg@mail.gmail.com>
 <20181009142742.ikh7xv2dn5skjjbe@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 10:25:42 +0200
Message-ID: <CACT4Y+ZB38pKvT8+BAjDZ1t4ZjXQQKoya+ytXT+ASQxHUkWwnA@mail.gmail.com>
Subject: Re: [PATCH] kasan: convert kasan/quarantine_lock to raw_spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 4:27 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-10-08 11:15:57 [+0200], Dmitry Vyukov wrote:
>> Hi Sebastian,
> Hi Dmitry,
>
>> This seems to beak quarantine_remove_cache( ) in the sense that some
>> object from the cache may still be in quarantine when
>> quarantine_remove_cache() returns. When quarantine_remove_cache()
>> returns all objects from the cache must be purged from quarantine.
>> That srcu and irq trickery is there for a reason.
>
> That loop should behave like your on_each_cpu() except it does not
> involve the remote CPU.


The problem is that it can squeeze in between:

+               spin_unlock(&q->lock);

                spin_lock(&quarantine_lock);

as far as I see. And then some objects can be left in the quarantine.


>> This code is also on hot path of kmallock/kfree, an additional
>> lock/unlock per operation is expensive. Adding 2 locked RMW per
>> kmalloc is not something that should be done only out of refactoring
>> reasons.
> But this is debug code anyway, right? And it is highly complex imho.
> Well, maybe only for me after I looked at it for the first time=E2=80=A6

It is debug code - yes.
Nothing about its performance matters - no.

That's the way to produce unusable debug tools.
With too much overhead timeouts start to fire and code behaves not the
way it behaves in production.
The tool is used in continuous integration and developers wait for
test results before merging code.
The tool is used on canary devices and directly contributes to usage experi=
ence.

We of course don't want to trade a page of assembly code for cutting
few cycles here (something that could make sense for some networking
code maybe). But otherwise let's not introduce spinlocks on fast paths
just for refactoring reasons.


>> The original message from Clark mentions that the problem can be fixed
>> by just changing type of spinlock. This looks like a better and
>> simpler way to resolve the problem to me.
>
> I usually prefer to avoid adding raw_locks everywhere if it can be
> avoided. However given that this is debug code and a few additional us
> shouldn't matter here, I have no problem with Clark's initial patch
> (also the mem-free in irq-off region works in this scenario).
> Can you take it as-is or should I repost it with an acked-by?

Perhaps it's the problem with the way RT kernel changes things then?
This is not specific to quarantine, right? Should that mutex detect
that IRQs are disabled and not try to schedule? If this would happen
in some networking code, what would we do?
