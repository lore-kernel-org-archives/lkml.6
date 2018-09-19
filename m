Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE0ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A1214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhm2l8Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0A1214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbeISMoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:44:13 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:35130 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeISMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:44:13 -0400
Received: by mail-lf1-f46.google.com with SMTP id x20-v6so4177578lfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Fg6LoEdL2+zi+1DXDiJJSKdb2FlhkB9PuSQUPRqnHCQ=;
        b=Nhm2l8YlUFpuagIZXzCIJXDvRyh4DiPguo2LGkwEESSSVlvmTPHxlZjDvKaQ0JvGhB
         BO7BeMQIjWPFKrcQTNu0qhvNp9TM5WMKXJeK5pt8Iwy9fIsGzHs0XkgnVi1hVMbtBfOS
         maRJFluu+XPR/Gnds9iungkur1mfpJUVnXaQoUvVaPyLgfBrlrj/ejUX8VQj4GTibvJN
         DfACn9sfw7VBdScHNvqVhp0J5r20ItrErpzHapBprs2QJNFM0jnh86jjGdr5bWAIPwfL
         mBzwhsgVn8VVqDnlv4Wsc0BpqnK17yuhrNWB3EpLnrNNtIbmIuX0bgVsWPUcKgzpBW7f
         1ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fg6LoEdL2+zi+1DXDiJJSKdb2FlhkB9PuSQUPRqnHCQ=;
        b=uDm6T37EsB7glCoRv+19K+NZ/LNZ5AC9hpYT+rDfkrBMPmlAkKvXHOfQhKg6a6A4ax
         pctwX1ol28uWLS1L4QAL2Tts1Pylb3oIqZ9vVhisl6oq8rxbBeKERR/P5YIG3pZhcZgd
         bmO7OBETbD8IYOOw3R7F/XXLgboI/KTE+XmEXsWzX6kFYHa1ncN+xoO6UO7pOiqdH7AZ
         6cfb2p7xWGRRJxposqwCa4pGIw4qZuXb0GxZ2NaBkyoNvnEi8SVtWa9TFmgLVQpwohsp
         PRHZXr+w/R5LmWX4HLhL68xX3iZyl809ekwNfNe2D1tPTOsOvs6ROKNSMWbjzx7bVGgh
         Yg9A==
X-Gm-Message-State: APzg51CiDCJI3JsHxCnb/PIR7h3R/1qltoR6TcDfcz4UWoxvC4uB3xwU
        K8AewnGHTpW7y4DzHZVo4EFc0xxjFn4=
X-Google-Smtp-Source: ANB0Vdb2W/1QEq+N8E9FzUs+Jj8aSBn2vBtAJ9CHb6+BsUygmOhx/bk9FyNytpSwQy4btr2wq6v9AA==
X-Received: by 2002:ac2:4218:: with SMTP id y24-v6mr6622379lfh.6.1537340859069;
        Wed, 19 Sep 2018 00:07:39 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id r70-v6sm882259lff.0.2018.09.19.00.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 00:07:37 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id A141D460652; Wed, 19 Sep 2018 10:07:37 +0300 (MSK)
Date:   Wed, 19 Sep 2018 10:07:37 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrey Vagin <avagin@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [linux-next] BUG triggered in ptraceme
Message-ID: <20180919070737.GB17524@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg! While been testing criu with linux-next we've triggered a BUG.
https://api.travis-ci.org/v3/job/430308998/log.txt

[    2.461618] BUG: sleeping function called from invalid context at security/apparmor/include/cred.h:154
[    2.461794] in_atomic(): 1, irqs_disabled(): 1, pid: 152, name: init
[    2.461890] 1 lock held by init/152:
[    2.461981]  #0: 00000000f30c3fda (tasklist_lock){.+.+}, at: ptrace_traceme+0x1c/0x70
[    2.462114] irq event stamp: 2524
[    2.462242] hardirqs last  enabled at (2523): [<ffffffff98002922>] do_syscall_64+0x12/0x190
[    2.462363] hardirqs last disabled at (2524): [<ffffffff98b8b02f>] _raw_write_lock_irq+0xf/0x40
[    2.462476] softirqs last  enabled at (1904): [<ffffffff98ac79ef>] unix_sock_destructor+0x4f/0xc0
[    2.462586] softirqs last disabled at (1902): [<ffffffff98ac79ef>] unix_sock_destructor+0x4f/0xc0
[    2.462697] CPU: 1 PID: 152 Comm: init Not tainted 4.19.0-rc4-next-20180918+ #1

Which is due to commit

commit 4b105cbbaf7c06e01c27391957dc3c446328d087
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Wed Jun 17 16:27:33 2009 -0700

    ptrace: do not use task_lock() for attach

because now after write_lock_irq(&tasklist_lock); apparmor calls for
traceme and

static inline struct aa_label *begin_current_label_crit_section(void)
{
	struct aa_label *label = aa_current_raw_label();

-->	might_sleep();

Take a look please, once time permit.

	Cyrill
