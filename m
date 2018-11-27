Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F51BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2965208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX+HIAIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2965208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeK1CU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:20:29 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42729 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeK1CU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:20:29 -0500
Received: by mail-lf1-f47.google.com with SMTP id l10so16726525lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=D0TC7u4pmpmpc+9j8m0s5YIQH8WK1Up0qkNyaGtjkf4=;
        b=IX+HIAIU1wZxIifrfjYQFXOz3ZZinW1MymmZ767KiRUhYAD1WWQPYk31+YmrrnxMVy
         uOLmy2cZcoAHh61Ilguanj265NKzKzerBZaMAA00xy3QP34WIR5wyLCJHnSrQGHsMz6o
         3SzDOGPfSk93Ii/pKkscvnErLcGzQWyirrnW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=D0TC7u4pmpmpc+9j8m0s5YIQH8WK1Up0qkNyaGtjkf4=;
        b=sSzicOyMgK8ixY3TsmcGl5ga/Cbcs5kF30UlD1JyBjePTBwC6ZAupD/upK2cY1WLPg
         /jSntEJ2qdtPfxHxKp66q+AGeLYZuE20Q7oFZvIrtIDEzCbn4ZHmO6Dg7XEZzOoiqkCb
         1xDfPNUipbbmUdGI9D9RN1OFfF4DAf4E2V9HXcHprjag9UhirnOlX1Zz/+F5hkzCWwTc
         Ls5Gqav5W0cHLkgcYCuSHBT915SCuVQoN9aHg+X4RPt78Vy8OiAFj+FrbVnKOYysVxXT
         VvTeajS6ICdIYIp5m0LjzLVl5f7TkQSHjci05sbRrxhoPUxtiV63Z4lff2PBg+hvP1IH
         LG7A==
X-Gm-Message-State: AGRZ1gK1At+3HmyxJs99ZC93pRU5ZXN3k5UA6AAD5tV8tPrao9bxMV8B
        3OZq5CgIMx5CEpfftCj2HXr+sn8FAio6e7Lq1nbM1N1xvAw=
X-Google-Smtp-Source: AJdET5dPvGc5zODgTtJs5UrrLHVD2WhJ8MWWsD60wQDI5p+4hYvT9ZQLWc0YEE/q8NJBuzbgxvusCtjGt9a6OBPu6EM=
X-Received: by 2002:a19:1019:: with SMTP id f25mr18619464lfi.54.1543332132499;
 Tue, 27 Nov 2018 07:22:12 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Nov 2018 20:52:00 +0530
Message-ID: <CA+G9fYvgDP2+D2mgqxJJJYm1DTgxbByxjKuVGBFOa-m_fT7Q-Q@mail.gmail.com>
Subject: File not found: /sys/kernel/debug/tracing/events/syscalls
To:     open list <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        rostedt@goodmis.org, mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging the selftests/bpf: get_cgroup_id_user test failure on arm64
where the test is expecting trace file
/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id
but this path not enabled after enabling required kernel configuration also.
CONFIG_FTRACE_SYSCALLS=y

strace output:
open(\"/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id\",
O_RDONLY) = -1 ENOENT (No such file or directory)

This problem noticed on Linux mainline kernel version 4.20.0-rc3.

Best regards
Naresh Kamboju
