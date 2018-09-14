Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B724FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C6320833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jE9hGbAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C6320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeINVL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:11:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43009 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:11:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so7825169edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yz4dXbSthk1H7nYe5dLh+symxdrFwa2H1yur9MJ4h1k=;
        b=jE9hGbAQCGqJmUfx3RXK4Ut+YnbzfjHB/dB7Ev022EJFumStdLHgYa1E2vS8+8h4vT
         oWojMvfaqsRD5WRSUmMZncalVtw2vJ6gq/CNhKfCDk2h55lAdzOcYRy1thbr30Z/QCHR
         XAsKLoXop7XQ+3Rrk1z2p+UoGLvI9tCIfjrSRsEZhbI1G71uSErJN09INTpcARpYIG3N
         oM2a7kNREDnOEGB1bJ/tFJItm7a5DznZh3loCEOt4Ydh8MKOy7iKbyIZbWM8Y/8q/uW+
         Dt8Z5EvhBnQcfwEY9zPUGKGW8tghoMmKxoWRousmgkMpMWNEbspzYO+gdrd2OlaxrvoP
         dkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yz4dXbSthk1H7nYe5dLh+symxdrFwa2H1yur9MJ4h1k=;
        b=n+kyAwQQVnzivsVZv+UBEetxLHV3QyxeCkSGC7QV0m4dFFAccOuwvMevWe9jkMyyiL
         prL0Phjb3LdWooxg9vqv2vmAMOXOuVha3jPDlrB4fmVdM2Im8ovOWoIXM+CSWPhBErpb
         OUV5ZeiLM/vl8cZUBtbuW0FQxrmEwzM1AkQcMn6FJTX82tgO6FgrtHmkdLreduB/Esj+
         lxPE1O1QWsXqU/R65OobRPPJ2ey9qb/iyJzYnEKCgn5++VipiLQlk3a7vd3bLQzR9LAb
         DOuGwpKqwDzhQFQrA/HalU1G/nzgpNW6gCOCmvygef2suSQl0R2E85Bdbm5eExJGLPpy
         Y7ig==
X-Gm-Message-State: APzg51BaOPw1JRWK8r28tNVaapzUVdV8uMBAji7CD+bQ9W+7yp6mCPHN
        JVKrh16d0EnPUBuj5pmWK8nlSw==
X-Google-Smtp-Source: ANB0VdZYBCQFm3eN27+s5ctBnAuoTMqeXAdnkCnbSYsdBa+VskMFJ1qqWrvAQoC6aWQQHtFHOwYQpg==
X-Received: by 2002:a50:a762:: with SMTP id h89-v6mr21676051edc.261.1536940611173;
        Fri, 14 Sep 2018 08:56:51 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g39-v6sm3971274edg.63.2018.09.14.08.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 08:56:50 -0700 (PDT)
Message-ID: <1536940609.3185.29.camel@arista.com>
Subject: Re: [LKP] [tty]  f26eb68a52: INFO:task_blocked_for_more_than#seconds
From:   Dmitry Safonov <dima@arista.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, lkp@01.org
Date:   Fri, 14 Sep 2018 16:56:49 +0100
In-Reply-To: <20180914090151.GH7632@shao2-debian>
References: <20180914090151.GH7632@shao2-debian>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-14 at 17:01 +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-4.9):

Thanks,

[..]
> [  245.080051] INFO: task lkp-setup-rootf:500 blocked for more than
> 120 seconds.
> [  245.082850]       Tainted: G        W       T 4.19.0-rc3-00014-
> gf26eb68 #1
> [  245.084673] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  245.086455] lkp-setup-rootf D 6516   500    498 0x00000000
> [  245.087766] Call Trace:
> [  245.088391]  __schedule+0x4b1/0xe80
> [  245.089322]  schedule+0x25/0x60
> [  245.090178]  schedule_timeout+0x275/0x4e0
> [  245.091105]  ? __ldsem_down_write_nested+0x1aa/0x300
> [  245.092217]  __ldsem_down_write_nested+0x1b2/0x300
> [  245.093286]  ? ldsem_down_write+0x2a/0x2e
> [  245.094305]  ldsem_down_write+0x2a/0x2e
> [  245.095211]  tty_ldisc_lock+0x16/0x40
> [  245.096104]  tty_reopen+0x3f/0xc0
> [  245.096892]  tty_open+0x3cf/0x450
> [  245.097718]  chrdev_open+0x9c/0x1f0
> [  245.098511]  ? security_file_open+0x99/0xa0
> [  245.099512]  do_dentry_open+0x3d5/0x5d0
> [  245.100428]  ? inode_permission+0x95/0x180
> [  245.101351]  ? cdev_put+0x30/0x30
> [  245.102138]  vfs_open+0x2d/0x30
> [  245.102898]  path_openat+0x9e1/0x17d0
> [  245.103733]  do_filp_open+0x6a/0x120
> [  245.104541]  ? _raw_spin_unlock+0x22/0x30
> [  245.105439]  ? __alloc_fd+0xa5/0x170
> [  245.106309]  do_sys_open+0x13a/0x250
> [  245.107118]  sys_open+0x22/0x30
> [  245.107980]  do_int80_syscall_32+0x94/0x1c0
> [  245.108982]  entry_INT80_32+0xf3/0xf3

So, unfortunately, I'll still have to set timeout to 5 sec for
tty_reopen(). The better fix would be to release read lock whenever a
writer is pending (say n_tty_receive_buf_common() can fallback), but
that's probably better to put in another patches set, as this one is
already packed.
Annoyingly, it means that open(tty) will have now more chances to fail
then before.. But still it's better than a panic with null-ptr deref.

-- 
Thanks,
             Dmitry
