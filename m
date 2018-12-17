Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C06C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A0020675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbeLQRdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:33:00 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40192 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQRdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:33:00 -0500
Received: by mail-pl1-f177.google.com with SMTP id u18so6453511plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypJp55WrzNMKjM9alLugWWDmV5I5UrX2mUc95ZcKynU=;
        b=OxMqer/09zkpqn4Kl9C9aa1mAeorv4J3Bx3geQkcqnTLWfKbW0WAWBx1pXReddjCwM
         ANwDm/dfL3n/mcM0nQVpCpC06iPLslqSArk/0Jb7qhAnefhusUzIMnHZjcwTSF6vkS3D
         2Fb/ESv9Y7xeDjAtM+nCDwMWg3rApnfgj22OiRF5LStSUjgEjQ85Cpfl+ylx8VO93oxS
         Tx46icXyMIpggNTuZ1PajAGpUOPeZDnhieZeJh5xUYAAxnKcKdUbMtWZxiHhBWe0Q4xL
         g2SereM8YdxDX03VAv3JMSmlcZA9UN4fDvGRX+TJ5PYIfEUzmOH3+77MvlMkvwYxVCP9
         +w6w==
X-Gm-Message-State: AA+aEWY7f5F6Mdgx7DD+px/e5YtsdG+ZaFmdzL+9fO1gNCAFbqFom4H9
        oXQ531BieghwrNc8CZk+GT8=
X-Google-Smtp-Source: AFSGD/WB7GkdG00mZigmh5nMDs6zrpmfAJjr07dZBkMaInVSU3So82jLqp6PTizTXLsBizeybYjzuw==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr13527760plb.192.1545067979185;
        Mon, 17 Dec 2018 09:32:59 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v70sm22011752pfa.152.2018.12.17.09.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:32:58 -0800 (PST)
Message-ID: <1545067977.185366.436.camel@acm.org>
Subject: Re: cdbeb78c7a ("kernel/workqueue: Use dynamic lockdep keys for
 .."):  WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:1002
 lockdep_register_key
From:   Bart Van Assche <bvanassche@acm.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org
Date:   Mon, 17 Dec 2018 09:32:57 -0800
In-Reply-To: <5c17230f.mbgTPR4404Mp8abU%lkp@intel.com>
References: <5c17230f.mbgTPR4404Mp8abU%lkp@intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 12:16 +-0800, kernel test robot wrote:
+AD4 Greetings,
+AD4 
+AD4 0day kernel testing robot got the below dmesg and the first bad commit is
+AD4 
+AD4 https://github.com/bvanassche/linux for-next
+AD4 
+AD4 commit cdbeb78c7a2e34af6d6cc5d3570a585a23eea8e9
+AD4 Author:     Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 AuthorDate: Fri Nov 9 09:53:31 2018 -0800
+AD4 Commit:     Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 CommitDate: Fri Dec 14 11:24:37 2018 -0800
+AD4 
+AD4     kernel/workqueue: Use dynamic lockdep keys for workqueues
+AD4     
+AD4     +AFs ... +AF0
+AD4 
+AD4 60e521015c  locking/lockdep: Add support for dynamic keys
+AD4 cdbeb78c7a  kernel/workqueue: Use dynamic lockdep keys for workqueues
+AD4 9294000d6d  IB/srp: Drain the send queue before destroying a QP
+AD4 +------------------------------------------------------------+-------------+-------------+----------------------+-
+AD4 +AD4                                                           +AHw 60e521015c +AHw cdbeb78c7a +AHw bvanassche/for-next +AHw
+AD4 
+AD4 +------------------------------------------------------------+-------------+-------------+----------------------+-
+AD4 +AD4 boot+AF8-successes                                            +AHw 915        +AHw 305        +AHw 0                   +AHw
+AD4 +AD4 boot+AF8-failures                                             +AHw 1          +AHw 7          +AHw 310                 +AHw
+AD4 +AD4 INFO:rcu+AF8-preempt+AF8-self-detected+AF8-stall+AF8-on+AF8-CPU               +AHw 1          +AHw            +AHw                     +AHw
+AD4 +AD4 EIP:smp+AF8-call+AF8-function+AF8-single                              +AHw 1          +AHw            +AHw                     +AHw
+AD4 +AD4 BUG:kernel+AF8-hang+AF8-in+AF8-boot-around-mounting-root+AF8-stage        +AHw 1          +AHw            +AHw                     +AHw
+AD4 +AD4 WARNING:at+AF8-kernel/locking/lockdep.c:+ACM-lockdep+AF8-register+AF8-key +AHw 0          +AHw 7          +AHw                     +AHw
+AD4 +AD4 EIP:lockdep+AF8-register+AF8-key                                  +AHw 0          +AHw 7          +AHw                     +AHw
+AD4 +AD4 WARNING:kernel+AF8-stack                                      +AHw 0          +AHw 0          +AHw 310                 +AHw
+AD4 
+AD4 +------------------------------------------------------------+-------------+-------------+----------------------+-

The +ACI-WARNING:at+AF8-kernel/locking/lockdep.c:+ACM-lockdep+AF8-register+AF8-key+ACI warnings have
already been removed from my branch so I think this report can be ignored.

Bart.


