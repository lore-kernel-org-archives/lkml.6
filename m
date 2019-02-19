Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1348C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EEC21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1JU6Xh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfBSO6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:58:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39183 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:58:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so21231296wrw.6;
        Tue, 19 Feb 2019 06:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ccW7ncM36wcX0YIiFKZhIN/xKRaCNIdmYHn7rszp/w0=;
        b=A1JU6Xh3j9sQEvhE3iUUBL8GXi6VivG8ysDGQVd7kDIlyO79HzCfH7AeLremAnLbtp
         +e/NbGmZ1ZpUMKaWYci5LYE5iIUIz6HEu7SWm54nyQ5UDrtWJ+GTrzulHUvsD9fD0aUf
         F9Mlb6EQjqR9CYMqARWYrnWcDQP6D90Sq6zfsWmHITp6Qe2Bf/2Q9zaNVI+9ysgSs/NW
         161FDZDDNM5GhXKbNzpI+HxfRlUzEsYH1cb4S1Upwwts0zdu0bnkkBfx6/WBMRfEGzbG
         FuLcLUOkYNKQr9FCVXWkfeKWcpsnn5coW3lDZVBZdKoPdAu4tEicxPO7CK4YVN4cbNxm
         Z9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ccW7ncM36wcX0YIiFKZhIN/xKRaCNIdmYHn7rszp/w0=;
        b=oHCNWeXPC/wM5QKAYnS2Yd519BvG/fpjYE4hl6/UVFW/fXBYu3izByu7SMmAck3O2E
         a5Vn4zMMKSEs79C6E+hbg2D4jET4oOeRqgRwEj7EjExLawyy44A2m+IkekdhlpWmnZu1
         EhTampdurIGri2GK5sFhYTex7TiHGjrQnmAgXE4WKX2q8+oiwLoDNp5dZJVLzc5S1//M
         QNYPXNRoY5XfjM0YB83vVi+INaXQ00owDazxQoiMTKppfkUPcHYZQIoC8GyV11aWEo5d
         3ikNCI/PtGp1c4qyUGhq9hDs5I5rI3qtSMU2+I/v3xhcXTkAMB5vYDwOw+FbcoNxUzAV
         36tQ==
X-Gm-Message-State: AHQUAuYJ/imwp0LZx7E1UkMWgKU8AjgPiYe0GXQ6Tk8jox52I4lvaRmm
        QUl0GMOTFs08Qv9lIe2iUyfkjlR1
X-Google-Smtp-Source: AHgI3IYW7SeLYbR2aMQWlFrCFVim2rtdUMWcCNA5cjNq+hQcXJwoo8B3Dg3ew0xpLR4W+vooIgSP7g==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr20583779wrs.170.1550588310189;
        Tue, 19 Feb 2019 06:58:30 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.225])
        by smtp.gmail.com with ESMTPSA id x24sm4600669wmi.5.2019.02.19.06.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 06:58:29 -0800 (PST)
Date:   Tue, 19 Feb 2019 15:58:26 +0100
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 1/2] softirq: Avoid "local_softirq_pending" messages
 if ksoftirqd is blocked
Message-ID: <20190219145826.GH21785@localhost.localdomain>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/02/19 17:31, Sebastian Andrzej Siewior wrote:
> If the ksoftirqd thread has a softirq pending and is blocked on the
> `local_softirq_locks' lock then softirq_check_pending_idle() won't
> complain because the "lock owner" will mask away this softirq from the
> mask of pending softirqs.
> If ksoftirqd has an additional softirq pending then it won't be masked
> out because we never look at ksoftirqd's mask.
> 
> If there are still pending softirqs while going to idle check
> ksoftirqd's and ktimersfotd's mask before complaining about unhandled
> softirqs.
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I've been seeing those messages while running some stress tests (hog
tasks pinned to CPUs).

Have yet to see them after I applied this patch earlier this morning (it
usually took not much time to reproduce).

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

- Juri
