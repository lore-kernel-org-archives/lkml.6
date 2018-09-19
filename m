Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C0AECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EB1214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szMC5oSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EB1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbeISMrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:47:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36120 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeISMrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:47:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id v26-v6so4031881ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A3NG/kNQp6hyhlDdtpVbqGO73GKPgcuu0RdvsVPum0s=;
        b=szMC5oShuqDaZEu9dEMPlQRCx4HM2i9memo8dYIBb7v4H/N6uuIG/Xz1e6LtXryhHs
         ejy8eyZPS8IhobL+VDSkS0Majei80b1aybDs3Rl2U8VvlUpuspSSWn5mV5Np54CygibK
         X0HP0VqmDVcMcnLNyTT1/xRx4N4BZsMJmtmcv9Ei6XablW3TJU8LU3DmrdAIg+ztGMoi
         5goJAYL5IdDWl7+0DczjbCMGPnOY/+I6zK0TNRPdBR51TcySqydD8/fltkIxVbJoN4AB
         uQNb07ikMhO96KN4bZdf1weSU6FsgGQyhVcBxSxKpOAUe0eT+ipgjcS3eNYHtkMrCgH6
         /EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3NG/kNQp6hyhlDdtpVbqGO73GKPgcuu0RdvsVPum0s=;
        b=JlJqymWejw6idlI2SdT0xY266/13C5xQjrbdXKMItNt3L2lq3Dmc+992jABQshLSSM
         TDP3JKZKtu0DXZZ/81RXfqsV/n3azIJahlYUL9kSCVVf10pp1NDbzUNYRnBI2nCuCTsL
         SabOi7S9VqKmS0THsK1wkjNZ/kU4xbqc82N3wRivWBizJpuPi2EQ58dSmSaBq4jlvBxS
         WiG7zKBaD0rRCJUx+vvKvwrull3TGgADOZXLEVzufh6AzUnYN1mZHdmnBEVDYQa1NKTr
         jIR3YG/cfNmJhm1tjbXGEDVb+UDHClJl4csGfS7h0AQf+ZYo+0G3BKDl1QFBCWnqdXiK
         uNyg==
X-Gm-Message-State: APzg51BYA3rOYO5QeJVbFvf5dPhXDXgyHyU4nyP/uB6PNVYJGggMK3gJ
        uovQqxWfANcnsQFrY77CSuw=
X-Google-Smtp-Source: ANB0Vdbd07GiwrOZ/IHh8ESmKAn+NQlcfUR6c4ONCB55A8/O1yStoEmAa6lLRcwkg54uhQM9kgHmYg==
X-Received: by 2002:a2e:9883:: with SMTP id b3-v6mr239918ljj.80.1537341058057;
        Wed, 19 Sep 2018 00:10:58 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id e67-v6sm64985lfg.2.2018.09.19.00.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 00:10:57 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id DE992460652; Wed, 19 Sep 2018 10:10:56 +0300 (MSK)
Date:   Wed, 19 Sep 2018 10:10:56 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next] BUG triggered in ptraceme
Message-ID: <20180919071056.GC17524@uranus.lan>
References: <20180919070737.GB17524@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919070737.GB17524@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:07:37AM +0300, Cyrill Gorcunov wrote:
> Hi Oleg! While been testing criu with linux-next we've triggered a BUG.
> https://api.travis-ci.org/v3/job/430308998/log.txt
> 
> [    2.461618] BUG: sleeping function called from invalid context at security/apparmor/include/cred.h:154
> [    2.461794] in_atomic(): 1, irqs_disabled(): 1, pid: 152, name: init
> [    2.461890] 1 lock held by init/152:
> [    2.461981]  #0: 00000000f30c3fda (tasklist_lock){.+.+}, at: ptrace_traceme+0x1c/0x70
> [    2.462114] irq event stamp: 2524
> [    2.462242] hardirqs last  enabled at (2523): [<ffffffff98002922>] do_syscall_64+0x12/0x190
> [    2.462363] hardirqs last disabled at (2524): [<ffffffff98b8b02f>] _raw_write_lock_irq+0xf/0x40
> [    2.462476] softirqs last  enabled at (1904): [<ffffffff98ac79ef>] unix_sock_destructor+0x4f/0xc0
> [    2.462586] softirqs last disabled at (1902): [<ffffffff98ac79ef>] unix_sock_destructor+0x4f/0xc0
> [    2.462697] CPU: 1 PID: 152 Comm: init Not tainted 4.19.0-rc4-next-20180918+ #1
> 
> Which is due to commit
> 
> commit 4b105cbbaf7c06e01c27391957dc3c446328d087
> Author: Oleg Nesterov <oleg@redhat.com>
> Date:   Wed Jun 17 16:27:33 2009 -0700
> 
>     ptrace: do not use task_lock() for attach
> 
> because now after write_lock_irq(&tasklist_lock); apparmor calls for
> traceme and
> 
> static inline struct aa_label *begin_current_label_crit_section(void)
> {
> 	struct aa_label *label = aa_current_raw_label();
> 
> -->	might_sleep();
> 
> Take a look please, once time permit.

Heh, actually not :) It is due to commit

commit 1f8266ff58840d698a1e96d2274189de1bdf7969
Author: Jann Horn <jannh@google.com>
Date:   Thu Sep 13 18:12:09 2018 +0200

which introduced might_sleep. Seems it is bad idea to send bug report
without having a cup of coffee at the morning :)
