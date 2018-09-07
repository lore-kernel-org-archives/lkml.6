Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA79FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6616E2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="M6tZWC/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6616E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeIGPwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:52:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33746 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIGPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:52:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id d8-v6so11285175edv.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJ1b8oDYuqnyKXjPHvRTWs7zSA5DsNYYe8sviNyyVMI=;
        b=M6tZWC/TWn5poqk0W7JAyOeTdsFd4k+KqjoU8u46UUc5EBsG9nPacShNhdnsGwvY5Y
         eUAW2QU1Kr8h0CZsnQaICdaUlg1+sGF3awtICi2YJfvLqYQnhoM9yP4HJSZal8ctjwV9
         8Zgi0YXHuFQAhTjR/sEwKO2EnpEeBf/GRmXFpg/aYt+Gg7byyBcZ5G5+jJW2/i2Rqrgf
         wfVg3dLfW6RtFOm0vurK9M5PAGaxDuuRHSUTkVFgdI+GvByBCQoyGVehA/+G0QzOfj3a
         tKrmJvqvS/NVvh6W9KHVDK+zk0ms2+jG6GUi1YMolbH1/jajTfxkm4vl7LfJirEB2eYD
         0F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJ1b8oDYuqnyKXjPHvRTWs7zSA5DsNYYe8sviNyyVMI=;
        b=WTSl+qpwGuliFC6bqO2Ph/cV5/uOReMv5RhyQboR2wjaFS8ELmhO/Jk0F76ilQw34N
         dQ2Kq+QWVNm8H3zqpTZOcfKFDgTMj+fExkYGD4uZTIgE1l/j3LgamiEJUgeTzcRbhdVO
         4qyU7Ycn+qhDaOnUOrxfmYyIhxkdVGATYFpV8QphQBAadAPNRkzDxvu90dV1MIrSm8+2
         /6F/By1Ym+3C+Jd4vREC6zOsNQrKgpFwllAqfQiuk4yOU8ZwGyl5urJcQVwD4vng5K11
         2nLDPQ0k13Fj3urdAg+CA/r4QMUkW7yUIoAJIivldFbESSM+rhYWrMnFC7TzdPulLIFF
         4Kig==
X-Gm-Message-State: APzg51DM+e7Pg7asBFNVS0RwOqMaQAoYtiUC3fyY0luK/uDbYiw3guSa
        yaJOjl7fk9F6LipgxR3eIaiRJA==
X-Google-Smtp-Source: ANB0VdZ94PHeesyenj+aGTHPRVzuRk42pjLLSN9WphEWKKRHCCra2AuWrkaZgNzccwC5BFSNy+J5og==
X-Received: by 2002:a50:a267:: with SMTP id 94-v6mr8480754edl.189.1536318730281;
        Fri, 07 Sep 2018 04:12:10 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w22-v6sm4509732eda.34.2018.09.07.04.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 04:12:09 -0700 (PDT)
Message-ID: <1536318728.23560.98.camel@arista.com>
Subject: Re: [LKP] [tty] 0b4f83d510: INFO:task_blocked_for_more_than#seconds
From:   Dmitry Safonov <dima@arista.com>
To:     Jiri Slaby <jslaby@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     lkp@01.org, Daniel Axtens <dja@axtens.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Fri, 07 Sep 2018 12:12:08 +0100
In-Reply-To: <d5d23bc5-0e11-5cee-6d66-514dfc4fc25b@suse.cz>
References: <20180907045041.GF1110@shao2-debian>
         <d5d23bc5-0e11-5cee-6d66-514dfc4fc25b@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 08:39 +0200, Jiri Slaby wrote:
> On 09/07/2018, 06:50 AM, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 0b4f83d510f6fef6bb9da25f122c8d733d50516f ("[PATCH 2/4] tty:
> > Hold tty_ldisc_lock() during tty_reopen()")
> > url: https://github.com/0day-ci/linux/commits/Dmitry-Safonov/tty-Ho
> > ld-write-ldisc-sem-in-tty_reopen/20180829-165618
> > base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git
> > tty-testing
> > 
> > in testcase: trinity
> > with following parameters:
> > 
> > 	runtime: 300s
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -m 256M
> > 
> > caused below changes (please refer to attached dmesg/kmsg for
> > entire log/backtrace):
> > 
> > 
> > +--------------------------------------------------+------------+
> > ------------+
> > >                                                  | 58dd163974 |
> > > 0b4f83d510 |
> > 
> > +--------------------------------------------------+------------+
> > ------------+
> > > boot_successes                                   | 14         |
> > > 4          |
> > > boot_failures                                    | 0          |
> > > 6          |
> > > INFO:task_blocked_for_more_than#seconds          | 0          |
> > > 6          |
> > > Kernel_panic-not_syncing:hung_task:blocked_tasks | 0          |
> > > 6          |
> > 
> > +--------------------------------------------------+------------+
> > ------------+
> > 
> > 
> > 
> > [  244.816801] INFO: task validate_data:655 blocked for more than
> > 120 seconds.
> > [  244.818833]       Not tainted 4.18.0-11684-g0b4f83d #1
> > [  244.820028] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  244.826965] validate_data   D    0   655    623 0x20020000
> > [  244.828279] Call Trace:
> > [  244.828958]  ? __schedule+0x843/0x950
> > [  244.830173]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.834903]  schedule+0x31/0x70
> > [  244.835665]  schedule_timeout+0x34/0x760
> > [  244.836613]  ? ftrace_likely_update+0x35/0x60
> > [  244.837683]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.838818]  ? ftrace_likely_update+0x35/0x60
> > [  244.840127]  ? ftrace_likely_update+0x35/0x60
> > [  244.845947]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.847882]  __ldsem_down_read_nested+0x23a/0x3b0
> > [  244.849886]  ? tty_ldisc_ref_wait+0x25/0x50
> > [  244.853807]  tty_ldisc_ref_wait+0x25/0x50
> > [  244.854946]  tty_compat_ioctl+0x8a/0x120
> > [  244.855928]  ? this_tty+0x80/0x80
> > [  244.856742]  __ia32_compat_sys_ioctl+0xc28/0x1ce0
> > [  244.857981]  do_int80_syscall_32+0x1d2/0x5f0
> > [  244.859003]  entry_INT80_compat+0x88/0xa0
> > [  244.859972] INFO: task dnsmasq:668 blocked for more than 120
> > seconds.
> > [  244.868315]       Not tainted 4.18.0-11684-g0b4f83d #1
> > [  244.869583] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  244.871744] dnsmasq         D    0   668      1 0x20020000
> > [  244.873063] Call Trace:
> > [  244.873697]  ? __schedule+0x843/0x950
> > [  244.874572]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.875725]  schedule+0x31/0x70
> > [  244.876576]  schedule_timeout+0x34/0x760
> > [  244.877573]  ? ftrace_likely_update+0x35/0x60
> > [  244.878660]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.879872]  ? ftrace_likely_update+0x35/0x60
> > [  244.890522]  ? ftrace_likely_update+0x35/0x60
> > [  244.891572]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.892746]  __ldsem_down_read_nested+0x23a/0x3b0
> > [  244.893861]  ? tty_ldisc_ref_wait+0x25/0x50
> > [  244.894841]  tty_ldisc_ref_wait+0x25/0x50
> > [  244.895911]  tty_compat_ioctl+0x8a/0x120
> > [  244.896916]  ? this_tty+0x80/0x80
> > [  244.897717]  __ia32_compat_sys_ioctl+0xc28/0x1ce0
> > [  244.898821]  do_int80_syscall_32+0x1d2/0x5f0
> > [  244.899830]  entry_INT80_compat+0x88/0xa0
> > [  244.909466] INFO: task dropbear:734 blocked for more than 120
> > seconds.
> > [  244.911173]       Not tainted 4.18.0-11684-g0b4f83d #1
> > [  244.912394] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  244.914176] dropbear        D    0   734      1 0x20020000
> > [  244.915446] Call Trace:
> > [  244.916068]  ? __schedule+0x843/0x950
> > [  244.916945]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.918076]  schedule+0x31/0x70
> > [  244.918832]  schedule_timeout+0x34/0x760
> > [  244.919781]  ? ftrace_likely_update+0x35/0x60
> > [  244.921104]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.922304]  ? ftrace_likely_update+0x35/0x60
> > [  244.923347]  ? ftrace_likely_update+0x35/0x60
> > [  244.924369]  ? __ldsem_down_read_nested+0x1c4/0x3b0
> > [  244.925496]  __ldsem_down_read_nested+0x23a/0x3b0
> > [  244.926598]  ? tty_ldisc_ref_wait+0x25/0x50
> > [  244.927578]  tty_ldisc_ref_wait+0x25/0x50
> > [  244.928526]  tty_compat_ioctl+0x8a/0x120
> > [  244.929449]  ? this_tty+0x80/0x80
> > [  244.930240]  __ia32_compat_sys_ioctl+0xc28/0x1ce0
> > [  244.940083]  do_int80_syscall_32+0x1d2/0x5f0
> > [  244.941310]  entry_INT80_compat+0x88/0xa0
> > [  244.944070] 
> > [  244.944070] Showing all locks held in the system:
> > [  244.945558] 1 lock held by khungtaskd/18:
> > [  244.946495]  #0: (____ptrval____) (rcu_read_lock){....}, at:
> > debug_show_all_locks+0x16/0x190
> > [  244.948503] 2 locks held by askfirst/235:
> > [  244.949439]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
> > tty_ldisc_ref_wait+0x25/0x50
> > [  244.951762]  #1: (____ptrval____) (&ldata-
> > >atomic_read_lock){+.+.}, at: n_tty_read+0x13d/0xa00
> 
> Here, it just seems to wait for input from the user.
> 
> > [  244.953799] 1 lock held by validate_data/655:
> > [  244.954814]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
> > tty_ldisc_ref_wait+0x25/0x50
> > [  244.956764] 1 lock held by dnsmasq/668:
> > [  244.957649]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
> > tty_ldisc_ref_wait+0x25/0x50
> > [  244.959598] 1 lock held by dropbear/734:
> > [  244.967564]  #0: (____ptrval____) (&tty->ldisc_sem){++++}, at:
> > tty_ldisc_ref_wait+0x25/0x50
> 
> Hmm, I assume there is another task waiting for write_ldsem and that
> one
> prevents these readers to proceed. Unfortunately, due to the defunct
> __ptrval__ pointer hashing crap, we do not see who is waiting for
> what.
> But I am guessing all are the same locks.

Hmm, and the writer is not able to grab it because there is already
reader who uses console, I suppose.
I wonder if we can add re-acquiring for the reader side..
That will make write acquire less likely to fail under the load.
I'll try to reproduce it.

> 
> So I think, we are forced to limit the waiting to 5 seconds in reopen
> in
> the end too (the same as we do for new open in tty_init_dev).
> 
> Dmitry, could you add the limit and handle the return value of
> tty_ldisc_lock now?

Yeah, will do.

-- 
Thanks,
             Dmitry
