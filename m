Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE127C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEF920837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt4mbZTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEF920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbeFUDPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:15:21 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:42835 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbeFUDPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:15:19 -0400
Received: by mail-pf0-f180.google.com with SMTP id w7-v6so773205pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 20:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=EoyQPZYlHsfxO8tSnUKsnrVIsKXHjxJDP97fp/Bqf6M=;
        b=Mt4mbZTY8pvStfamlYvvzl8xcxA8xio7R3p09oSmSJg2AonD6rMNuZxwAi9bSiO3NY
         toTWczae8D2oVeXBk3tJhCl/c+vH2QoKkCHRLyDZNjl6Pe/m/zwA8hye0mGkLgBNkkUi
         SNzM7m//MARd+ocZzHztzwiVWwfr56dlSdtv0ajVsAvuXqY9LCvgCFRMCIq8n5SBCZiQ
         CUgTSebYY+6MM84x4ojsOURtGY1ESNdB6uAnOdsI0s0pzATcZQhH1coFDT8OYaSHKYdf
         pUzdWGRHl8a3XPTr6466tLuxSDVXXNdDkLZoIzyzwQNZWxOsd55TIG/rhPwFDSwY7p+u
         dgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=EoyQPZYlHsfxO8tSnUKsnrVIsKXHjxJDP97fp/Bqf6M=;
        b=eMRLlg74gqNYk1PCD1fk0UqSwqcUtywhKOgnubZbGqm+BcLB+EKcIkIenNnoLzcaa9
         fH1qYYizQDARLDeHrFA77VgULtdrwmY48mNuA6jZBI2o0AQ/kh+4l1sPMvE9LY03m3hS
         MQ5BqjU10IzXpkBqtrngweWXO3OsWEjR813NH1JHqZ8JqSJckhydI5KPlxnGbXE69HPC
         5mfuZPOyaOZ5/MPA0EDebnbnnKna7JxVbN3yLhipEStNtRNRXd0MGoppoDV476DqJqZX
         fktvj7K+su7Od+I0aIDx1uvY/MdShTP9mg934GKVDomUPNPgbGthLzCxiiIA43wMWWXg
         9VnA==
X-Gm-Message-State: APt69E3+akOZjXMW6VJ2eO8eR/yHlq6/YXGnCsbyl3OQytOLFaD8FJdo
        69AOJhs9aSRNLtR6m9vdPw/mmFDB
X-Google-Smtp-Source: ADUXVKLFy9ZFpGAFv3fBa1X1nq7oyy7VqVVaEGAp1PJLLL+mtXkYAc4yyswd+Sn0/qop8haSpncwxw==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr20831531pgf.319.1529550918813;
        Wed, 20 Jun 2018 20:15:18 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.11? ([2402:f000:1:1501:200:5efe:a66f:460b])
        by smtp.gmail.com with ESMTPSA id h124-v6sm6374958pfc.100.2018.06.20.20.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 20:15:18 -0700 (PDT)
To:     peterz@infradead.org, mingo@redhat.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] kernel: locking: a possible sleep-in-atomic-context bug in
 rt_mutex_slowlock()
Message-ID: <10fdf749-b47c-587c-96cb-9a877d8760ac@gmail.com>
Date:   Thu, 21 Jun 2018 11:14:49 +0800
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

[FUNC] schedule
kernel/locking/rtmutex.c, 1223: schedule in rt_mutex_handle_deadlock
kernel/locking/rtmutex.c, 1273: rt_mutex_handle_deadlock in 
rt_mutex_slowlock
kernel/locking/rtmutex.c, 1249: _raw_spin_lock_irqsave in rt_mutex_slowlock

This bug is found by my static analysis tool (DSAC-2) and checked by my
code review.

I do not know how to correctly fix this bug, so I just report them.


Best wishes,
Jia-Ju Bai
