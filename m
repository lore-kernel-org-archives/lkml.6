Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F40C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133AE21785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX1ZFHGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133AE21785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeHMFo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:44:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44675 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeHMFo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:44:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so7003671pff.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 20:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=TwpSUGuGFDFkxibKJ3TSKJ5JM4XI0YwfNEnufeR4F7U=;
        b=AX1ZFHGPnxX/VWPPAt6m3wEglTTzhI0U012I9GGKa03jbnqNBiNGS+bJRIz82Rajha
         Ww8V47T+hvkQqGMtVnhbfAEwDlAzziKjHv5g7TMzs5YIyGWCZe9xj/9HH/33YJBMlsQw
         oCXwx+gIIqD05EzwBAljmo5A1g4x2ZCPRbFgNG1j3QTeK6ELKAiLreGFgJj5v2asXo8R
         d6195ziXWVtMj0/VSrMrumW8WB70uo3RfJGnOrS/l8eg6ULdrNMVq6Qrhr2rgnMcV5AS
         4AjfQQ7uTygxD1vHFzlOwZiOrxcan7fpWlvJyDS7d1MisZI6VtGpy+bZ8cQOnBKIk8w5
         zE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=TwpSUGuGFDFkxibKJ3TSKJ5JM4XI0YwfNEnufeR4F7U=;
        b=kNXX3Ixy7Iemi6fnASlj0bIRKbfYp4/4PrGrwHnV5I6H4v1blGdS8DgXsyWBCvUyss
         DO1FmquJVPEyQ0Mg7Ej6vhgvV6itFiSrjD/8wQ80zxROS7X6v9D+2q0p9mTcBvXG6G4n
         x9qb7WGKS7WN4ss9zoqEYa97YSWO/nA4WGR+uSffR94uHb2GeUksieY/gF7p+SleoSFU
         1k4zSqTfEkuCehzJD83V+M/azCAQHbjzQ9Ag/8S7EZ7/EGAXdqzp/1YGgeEubyhlonov
         3uBF2+7hWb6DJWrPK/dwPNqQOHsWLWpzdfsSBaZS9togiQJM+qSVahzh+HL6nyRXj8GT
         ofuA==
X-Gm-Message-State: AOUpUlELCTIcbUn9yGGFj1rEDRkES9uhmNj23yt5qen75WFb6W2FtY49
        8QkIgY3eDyKw8i0qqBdfLqMq5fll
X-Google-Smtp-Source: AA+uWPxqm4kdjIrKIgBi6GD6TrK7PG9U+Q0cTCZt0cAf5IKP928+jXHv4hZpNMh1C45vcRTdowVvuw==
X-Received: by 2002:a65:5b8e:: with SMTP id i14-v6mr15497646pgr.242.1534129455254;
        Sun, 12 Aug 2018 20:04:15 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id h130-v6sm56982170pgc.88.2018.08.12.20.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 20:04:14 -0700 (PDT)
To:     dave@stgolabs.net, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] kernel: rcu: a possible sleep-in-atomic-context bug in
 srcu_read_delay()
Message-ID: <4179b4d2-b832-abcd-d407-b865765f28d6@gmail.com>
Date:   Mon, 13 Aug 2018 11:04:10 +0800
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

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] schedule_timeout_interruptible
kernel/rcu/rcutorture.c, 523: schedule_timeout_interruptible in 
srcu_read_delay
kernel/rcu/rcutorture.c, 1105: [FUNC_PTR]srcu_read_delay in 
rcu_torture_timer
kernel/rcu/rcutorture.c, 1104: spin_lock in rcu_torture_timer

Note that [FUNC_PTR] means a function pointer call is used.

I do not find a good way to fix, so I only report.
This is found by my static analysis tool (DSAC).


Thanks,
Jia-Ju Bai
