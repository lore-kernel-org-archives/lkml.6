Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5DDC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 22:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34F82084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 22:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsG8cx0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfBBWU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 17:20:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44983 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfBBWU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 17:20:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so5005115pfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NNpXzOTms6SxBADapuexngeaEkksrl0j8o3Zd6+81Lw=;
        b=UsG8cx0RtJPM7GAXhgHnozcbE4qG7zDUJTeJZpCltN2IxpFUlI0LIAqlLrKlSdM5qi
         /cAefgs6JlSnKtEbq216DtfTkAyk/gYLARwFPe2wCs6C81UCr7kzehT078hYyxf31Gs0
         Dd0WZ4iT/fzOrxjSVtVSR7BXiZ5K1GLF8alA1pEpDBNcJxyIObr0gQ2JTsplZcDPJSph
         XrZaUNz54s4NEhKS7ncVSNnagDzHSGGk9vT0iTdLHz8SE8njxWbkOjKL7eUhybX+Cadi
         ccKG++gyN27ZLbYlfU41KM/MMtjtUV7o2RRzSEAKFuICxHv340tJ+hTSSfWx4lVYqV1Z
         hV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=NNpXzOTms6SxBADapuexngeaEkksrl0j8o3Zd6+81Lw=;
        b=IfxT3iAE20lxbKQqkIlO1y7fiA9nNN/ywg5rM1xQDEl6fe0+ccPmhaQ2yt0Fz98FAN
         O+FVDxuodpzXwXcECibK0UhtiUf7g9iDnVgC20bvkEEmtrLfQqYHr1V77iYH38VjT5rJ
         MlpYRzy+eBaJrUNziPdk//Qwgje6L2AfIUFTclq5ISivb2nGfUFTC0HyynxpbVbO7hW+
         BlHevMMMllyDFZkXeiuk8nX2RgaKMjTlIGUW+XeB8f8c4/u5ZP8VWblcpzYPjQlmAJv/
         82MiC6ULXJKxBbB+R9lAQUHCsaRNi/snC3K5wLr3TCllM5g2Wig5twBrGM4GAomVmBD8
         KKCQ==
X-Gm-Message-State: AJcUukcBE93X/QK5Z0f06jjwwtJt73R/G3jHY7gowPvBEoAG2G3wKVLO
        FR6VL3YC05d75pwVSDJalgc=
X-Google-Smtp-Source: ALg8bN6ctcbSus9GH9hNz8hdNbT05gcJC/ycfq998uxyxYOOTCT5SWirplDeceKVwH7Ofq4jBt0u3g==
X-Received: by 2002:a62:ca03:: with SMTP id n3mr46653687pfg.241.1549146025815;
        Sat, 02 Feb 2019 14:20:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w11sm13996042pgk.16.2019.02.02.14.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 14:20:24 -0800 (PST)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: linux-next: tracebacks in workqueue.c/__flush_work()
Message-ID: <18a30387-6aa5-6123-e67c-57579ecc3f38@roeck-us.net>
Date:   Sat, 2 Feb 2019 14:20:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit "workqueue: Try to catch flush_work() without INIT_WORK()" added
a warning if flush_work() is called without worker function.

This results in the following tracebacks, typically observed during
system shutdown.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 101 at kernel/workqueue.c:3018 __flush_work+0x2a4/0x2e0
Modules linked in:
CPU: 0 PID: 101 Comm: umount Not tainted 5.0.0-rc4-next-20190201 #1
        fffffc0007dcbd18 0000000000000000 fffffc00003338a0 fffffc00003517d4
        fffffc00003517d4 fffffc0000e56c98 fffffc0000e56c98 fffffc0000ebc1d8
        fffffc0000ec0bd8 ffffffffa8024010 0000000000000bca 0000000000000000
        fffffc00003d3ea4 fffffc0000e56c98 fffffc0000e56c60 fffffc0000ebc1d8
        fffffc0000ec0bd8 0000000000000000 0000000000000001 0000000000000000
        fffffc000782d520 0000000000000000 fffffc000044ef50 fffffc0007c4b540
Trace:
[<fffffc00003338a0>] __warn+0x160/0x190
[<fffffc00003517d4>] __flush_work+0x2a4/0x2e0
[<fffffc00003517d4>] __flush_work+0x2a4/0x2e0
[<fffffc00003d3ea4>] lru_add_drain_all+0xe4/0x190
[<fffffc000044ef50>] shrink_dcache_sb+0x70/0xb0
[<fffffc0000478dc4>] invalidate_bh_lru+0x44/0x80
[<fffffc00003a94fc>] on_each_cpu_cond+0x5c/0x90
[<fffffc0000478d80>] invalidate_bh_lru+0x0/0x80
[<fffffc000047fe7c>] invalidate_bdev+0x3c/0x70
[<fffffc0000432ca8>] reconfigure_super+0x178/0x2c0
[<fffffc000045ee64>] ksys_umount+0x664/0x680
[<fffffc000045ee9c>] sys_umount+0x1c/0x30
[<fffffc00003115d4>] entSys+0xa4/0xc0
[<fffffc00003115d4>] entSys+0xa4/0xc0

---[ end trace 613cea34708701f1 ]---

The problem is seen with several (but not all) architectures. Affected
architectures/platforms are:
	alpha
	arm:versatilepb
	m68k
	mips, mips64 (boot from IDE drive or MMC, SMP disabled)
	parisc (nosmp builds)
	sparc, sparc64 (nosmp builds)

There may be others; several of my tests fail with build failures.

If/when it is seen, the problem is persistent.

Common denominator seems to be that SMP is disabled. It does appear that
for_each_cpu() ignores the mask for nosmp builds, but I don't really
understand why.

Guenter
