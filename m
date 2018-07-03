Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C301C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368D124897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpUKZ8Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368D124897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeGCUY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:24:28 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35693 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbeGCUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:24:27 -0400
Received: by mail-yb0-f194.google.com with SMTP id x15-v6so1234570ybm.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGq/BvXRbFqYH9A0/oiAvRVehZ4pTwwjtWX+nry8ngM=;
        b=KpUKZ8BcKwhjM494kI//oaQV7G4jMV2qfQ7hq0Fzp3WdgwDFgNCYXvDAbm2FuwLfPO
         cVZhgph24eTJy5pYkNG7TAAUCJSn2FmKSPlrAgRJz+CbcTo5Nd8+o9K7NbzEpxW1QNMQ
         hs7+5hfdCNgdcUF125hpt0NhiAGooKAbC9iofL22XPQZ+K94b9pHiBe9LkvbbxO7lsqV
         /Vwly0nziLSjAgOz4PQrWrNoag894vsIxCBMsNIwaxp9UZd4cSfzJ5GSx1lVtc7jIAmK
         AVxKhfyqTZvaV5GNgssRzuyl9Iv98wWPDZPxMhM/8WLVuGe3ExP9KnkHL/xJ9oyhaO+n
         IF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGq/BvXRbFqYH9A0/oiAvRVehZ4pTwwjtWX+nry8ngM=;
        b=eLxT8TQGpVKOucJDnyjuns5IfHEdhprtO62LXRFGUv60PQ2frPcZIse2RrUSCxd7+Y
         mZEweD4xY2G6AipokCt6dd7MI44c5pgo44e1LaPdxs2PEO4FwcnOcHQuuWOD8BtFBPay
         8oDHE0+Wg0RnExQXkVHVNTFtBmVSjqHTcqmdXdzfrbjSYWFzKEQyWMmxlCc0o4zPrIub
         A6bz5t5wcF8SoUWNAHGhMx94AU7LTYYr1f1gAbRa5XxV8TaUsdddNSVS4PtoPbFnSfxD
         eZd356p1IBejFytwH/zg1tVZoYP2grNVlOkm5sEYcrYx7P3IYFyAINJiPbvFil9OYG62
         iyGA==
X-Gm-Message-State: APt69E3nA/PEHkIm/u0dxocyBy0AiTao9xxGY+MacuVPJ7zjpEuB93JX
        UkFbDbTeurvd1tSPLG4r5KVLiyMY
X-Google-Smtp-Source: ADUXVKKyZRasrh4Serk2Dc1vfh4F+jIrI6K41Y5Eu0aYTBot7JyMcQFha5Fne2vwlb4C+IsIDqSk6g==
X-Received: by 2002:a25:1a45:: with SMTP id a66-v6mr16566166yba.268.1530649466837;
        Tue, 03 Jul 2018 13:24:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:a4be])
        by smtp.gmail.com with ESMTPSA id o126-v6sm673749ywf.102.2018.07.03.13.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 13:24:25 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:24:24 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] cgroup: use irqsave in cgroup_rstat_flush_locked()
Message-ID: <20180703202424.GB72677@devbig577.frc2.facebook.com>
References: <20180703164544.25268-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703164544.25268-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing Peter and Ingo for lockdep)

Hello, Sebastian.

On Tue, Jul 03, 2018 at 06:45:44PM +0200, Sebastian Andrzej Siewior wrote:
> All callers of cgroup_rstat_flush_locked() acquire cgroup_rstat_lock
> either with spin_lock_irq() or spin_lock_irqsave().

So, irq is always disabled in cgroup_rstat_flush_locked().

> cgroup_rstat_flush_locked() itself acquires cgroup_rstat_cpu_lock which
> is a raw_spin_lock. This lock is also acquired in cgroup_rstat_updated()
> in IRQ context and therefore requires _irqsave() locking suffix in
> cgroup_rstat_flush_locked().

Yes, the cpu locks should be irqsafe too; however, as irq is always
disabled in that function, save/restore is redundant, no?

> Since there is no difference between spin_lock_t and raw_spin_lock_t
> on !RT lockdep does not complain here. On RT lockdep complains because
> the interrupts were not disabled here and a deadlock is possible.

We at least used to do this in the kernel - manipulating irqsafe locks
with spin_lock/unlock() if the irq state is known, whether enabled or
disabled, and ISTR lockdep being smart enough to track actual irq
state to determine irq safety.  Am I misremembering or is this
different on RT kernels?

Thanks.

-- 
tejun
