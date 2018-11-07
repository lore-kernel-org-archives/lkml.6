Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A23C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D8920827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toGPkD/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D8920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeKHFSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:18:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51441 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKHFSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:18:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so15211732wmc.1;
        Wed, 07 Nov 2018 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WX4o1b9CfavJF7tL72poCIr5V1AP6JICSuMh15MN7FA=;
        b=toGPkD/u9gsg5XYh+1AjF+hDC5yB4AYYOI/hIgwSp6LaV5gIj6TAGcxovhEq6l2Vmt
         AdwEWMmSICVS5svbYv7QvgMEnFI+cO9TYWG95OQHsQ1N7Nd9tEHeUmqXPWCuXi8LpTrR
         6GQuGbyAQmIjT7VLOCaRfYOCoxUmFqKSJK94nhuIQX8NaEOyZH4ay7fObNflqi8WXji9
         ouWTFoNKzd3vlUXR+bw744TeG3eN2IaOw+h+uW09I7B915DQ/DlhrvFO5t8pQDJPxCzl
         QbrLsZwK44f7KcR+/kpJqhLi4J4Ifc4tsDM9zNw1G8d6+fq3UX4/GvKgXcM231t2WFUs
         Nctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WX4o1b9CfavJF7tL72poCIr5V1AP6JICSuMh15MN7FA=;
        b=he0/XaJ2M7ohtP7bV50FT0swyYCYx4+/ELl2sVMqEX21cOK5I10fsUzBoYBnBhTd+W
         7PClWs1yk44ZLETYlD8J7tsCBusk7ZMnffTW4Eop/gV/rlJBq3Cy46oW5s5La/b5yfjm
         dI5zyzhyRUxLurocG3aJwSkL/jD+jzRvOTEK9uM9+3r3vjrWFEql+75hZYzct0kVyY19
         63rPUpPJWL7wUiJodxj3hemo2HIJmPArUpZ1EDLtRmOiZNLGzEzlXLQup6V+HvXlKT9U
         cYopL5bYIgQ1LoEJtih9Hn/rZVMzJ6NXXJdiEK5qMiOtXOc9uYI9GhjuYZnT/eQ9Hoef
         /2hQ==
X-Gm-Message-State: AGRZ1gJ7X+K4XpzG+Wwy+NULcifrgHVIuZkRu3manE9yuEEE8G7uYdW5
        VcIshuIie+/hc/wbKME55CEdZdAZ
X-Google-Smtp-Source: AJdET5f+1uuK7OaTModefCrlFKdE5Ytspor7mJ79UPbHH99exWOchNZaBF423GL85p7f+6TdjW0UWw==
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr1254936wml.15.1541619991273;
        Wed, 07 Nov 2018 11:46:31 -0800 (PST)
Received: from [10.0.20.223] (mail.jambit.com. [95.157.63.22])
        by smtp.gmail.com with ESMTPSA id r3-v6sm2437218wmd.25.2018.11.07.11.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 11:46:30 -0800 (PST)
Cc:     mtk.manpages@gmail.com,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
To:     Tejun Heo <tj@kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Cgroups v2 bug: incorrect reporting in "domain threaded" cgroup.procs
 file
Message-ID: <fdb057a2-342a-d49e-587a-f1ca8680033e@gmail.com>
Date:   Wed, 7 Nov 2018 20:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

I've discovered what looks to be a bug in the reporting
of PIDs in the cgroup.procs file in the "domain threaded"
node at the root of a threaded subtree. The following
demo is on vanilla kernel 4.19.

Suppose we have the following multithreaded process:

$ ps -L 654
  PID   LWP TTY      STAT   TIME COMMAND
  654   654 pts/12   Tl     0:00 ./cpu_multithread_burner 100
  654   655 pts/12   Tl     0:01 ./cpu_multithread_burner 100

Now suppose we create a threaded subtree in the v2 hierarchy:

# cd /sys/fs/cgroup/unified/
# mkdir -p x/a/b
# echo 'threaded' > x/a/cgroup.type
# echo 'threaded' > x/a/b/cgroup.type

Then we move the multithreaded process into x/a in 
the threaded subtree:

# echo 654 > x/a/cgroup.procs 

Now we visualize the set-up using my visualization
program[1]:

# go run ~mtk/lsp/cgroups/view_v2_cgroups.go x
x [dt]
    PIDs: {654}
    a [t]
        TIDs: {654 655-[654]}
        b [t]

The above is as I expect.

Now, we move the thread group leader (it has to be the 
thread group leader to show the bug) to a x/a/b, and again
use my visualization program:

# echo 654 > x/a/b/cgroup.threads 
# go run ~mtk/lsp/cgroups/view_v2_cgroups.go x
x [dt]
    PIDs: {654 655}
    a [t]
        TIDs: {655-[654]}
        b [t]
            TIDs: {654}

Note how the *thread ID* of the non-thread-group-leader
(655) is being reported in the x/cgroup.procs!

And just to verify that this is not a bug in my 
visualization program:

# cat x/cgroup.procs 
655
654

Your thoughts?

Thanks,

Michael

[1] https://www.spinics.net/lists/cgroups/msg20710.html

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
