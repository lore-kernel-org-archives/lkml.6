Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeEQSuk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:50:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39839 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeEQSuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:50:37 -0400
X-Google-Smtp-Source: AB8JxZoFFE4VsZM5CRcjYjJYaZmL2j07ufppBE3MZWa3/OoH73O7O3OhgOrdPwLbrlLB0UV4MNrWMQ==
Date: Thu, 17 May 2018 21:50:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: Don't allow empty /proc/PID/cmdline for user tasks
Message-ID: <20180517185033.GA24408@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel threads have empty /proc/PID/cmdline and some userland tools
> including ps(1) and older versions of systemd use this to detect
> kernel threads.

Those tools are broken. Systemd is fixed, see
https://github.com/systemd/systemd/blob/master/src/basic/process-util.c#L442

Empty /proc/*/cmdline is perfectly fine as long as

	execve(filename, NULL, NULL)

is fine.

> However, any userland program can emulate the
> behavior by making its argvs unavailable and trick the affected tools
> into thinking that the task is a kernel thread.

Or it can set ->comm to "[kthreadd] and cmdline to "[kthreadd]".
