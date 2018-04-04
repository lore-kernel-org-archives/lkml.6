Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeDDRtO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:49:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34978 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDDRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:49:13 -0400
X-Google-Smtp-Source: AIpwx4+YaFWVi3+Er6lyBBszYC6F46Fi7B/COM9FhuY5+COn3q2m2muhSnPG9B5QIATo+08uWrO3Nw==
Date: Wed, 4 Apr 2018 20:49:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: ebiederm@xmission.com
Cc: alban.crequy@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc
 mounts when not fully visible
Message-ID: <20180404174909.GB2540@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The only option I have seen proposed that might qualify as something
> general purpose and simple is a new filesystem that is just the process
> directories of proc.

While "mount -t pid" and "mount -t sysctl" are decades overdue, I don't
think they cover everything.

IIRC some gcc versions read /proc/meminfo on every invocation. Now
imagine such program doesn't have a fallback if /proc/ doesn't exist
(how many thousands such programs are there?) So user is going to ask
for /proc with just /proc/meminfo only. At this point it is back to
nearly full /proc.
