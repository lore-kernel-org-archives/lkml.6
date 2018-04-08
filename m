Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3391426-1523227113-2-4873829207480953518
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523227112; b=kzfxbgDCjCk1uPWOYMIUBc9gREh4L+Pgaua3e11c50cBpjUQSj
    Hut1xEnN026d4Gtvna4ACjwIkRLKXAXarUpiRfazuZW5ywxYEWzo9TQeC8KnbnEq
    +T9JLGHGZaMweHeYCPMzILhYJT/lsod5ovc1+edKZ+hW6WBxLLPF+l7MiJF/MZ1X
    ns2XQ+C+B7AHZ8+Igu/Y5sOutzido3zy3z5PPxE0kzppBBI9rrwYsLkAAQVSOpk1
    j7J7bwUDjoJ4102NkL8WjhPXH82DBkbQ2eyiZ3BHUkAIoe0F5dZfUmlswPBjEYGe
    VRkZF+1ymolOWj9evm1RJWPXuVFMI60uxjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523227112; bh=ucQmS
    1BX/HYQ0BoEdCCLgBBkBu6scfI/xAVwKcG7f4w=; b=AwcHadla4yXUlZSeyVNO5
    J925SdGRxJfvdre2v0Vi+c1C8hLsFEohyZ/P+uC2rarFG4ylzCa69Z17Jw6Gzlu+
    p70WpZr54iRTIOj+zpas/9GvfEJk3YgHNdv6kQIQJuS7MzOB5pyy4pt/qzHLf2i0
    0TPpy24c01iE3FfXVdpwcruhGG9a18GnRS6QZGq2eYAFyyyPct1Wt65em8sK1a4v
    m0lWRRf4+fckyeWx5hCJZMzqmdeTvsRmWXjT/UqTjFWQJHVsckRpiP94/p1zA1NX
    c4EVHKtAG6OLwJ7KGftl9yDaSobzWo4G6uhGLmakBm95I5D4b+v7ao1o1kjxLUnH
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VJ2UGWDi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qHOeGbNV;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=49 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VJ2UGWDi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qHOeGbNV;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBWrCxes+PxF8K2GNJkN3DWycUsOKRnVjuxzuUnFSe616UvbwGg6ezwt4+Kt6TxU5lM8QaNeu9P6JJoPJXDbsf+nPc1s5NPNiEzaGy3tY/9KPzKUIRAo
    PEz/bVgfsGQhgaEvHVEFwvMpsDEj0SjwNfJy6c5lKZLXAjPSu8C1SG1WIv3gTaKPkNMiWSMk3C/ZmJGQUmn5s5I1SCghFvN9Z9LgaaO63/6xuZqMmXijBymS
    L0cYWWO/v/5lvGeKgsaskw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=6HZ6NwbpNn0A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=VwQbUJbxAAAA:8 a=aD1W39H_AAAA:20 a=hSkVLCK3AAAA:8 a=DDOyTI_5AAAA:8
    a=n0Wmz8fxMbBi-S92BqwA:9 a=CjuIK1q_8ugA:10 a=W7bAngp8pZcA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cQPPKAXgyycSBL8etih5:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/wBgWOe0QGYMumrPel9QA21DuoN1Ov9u2pMVpxg+9rY4fJT9Ai2sBZtMK+ae3wW7PwcjPQRg==
Date: Sun, 8 Apr 2018 15:39:06 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
 <syzbot+a4a91202715b834181f106c1ad79f2f6fc35e102@syzkaller.appspotmail.com>
Subject: Re: WARNING in binder_send_failed_reply
Message-ID: <20180408223906.GF685@sol.localdomain>
References: <001a1143d7429813c5055f49d62c@google.com>
 <001a113f75c20d3510056145af9a@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <001a113f75c20d3510056145af9a@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, tkjos@android.com, gregkh@linuxfoundation.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 arve@android.com, riandrews@android.com, maco@android.com, dvyukov@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Dec 26, 2017 at 02:20:01PM -0800, syzbot wrote:
> syzkaller has found reproducer for the following crash on
> 0e08c463db387a2adcb0243b15ab868a73f87807
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by:
> <syzbot+a4a91202715b834181f106c1ad79f2f6fc35e102@syzkaller.appspotmail.com>
> It will help syzbot understand when the bug is fixed.
> 
> binder: undelivered TRANSACTION_COMPLETE
> binder: undelivered TRANSACTION_ERROR: 29189
> binder: send failed reply for transaction 844 to 4059:4061
> ------------[ cut here ]------------
> Unexpected reply error: 29189
> WARNING: CPU: 0 PID: 1409 at drivers/android/binder.c:1998
> binder_send_failed_reply+0x13b/0x390 drivers/android/binder.c:1997
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 0 PID: 1409 Comm: kworker/0:2 Not tainted 4.15.0-rc4-next-20171221+ #78
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events binder_deferred_func
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  panic+0x1e4/0x41c kernel/panic.c:183
>  __warn+0x1dc/0x200 kernel/panic.c:547
>  report_bug+0x211/0x2d0 lib/bug.c:184
>  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:177
>  fixup_bug arch/x86/kernel/traps.c:246 [inline]
>  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:295
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:314
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
> RIP: 0010:binder_send_failed_reply+0x13b/0x390 drivers/android/binder.c:1997
> RSP: 0018:ffff8801d3887128 EFLAGS: 00010286
> RAX: dffffc0000000008 RBX: ffff8801c2fbce00 RCX: ffffffff8159f9ce
> RDX: 0000000000000000 RSI: 1ffff1003a70c91d RDI: 0000000000000293
> RBP: ffff8801d3887150 R08: 1ffff1003a710db8 R09: 0000000000000000
> R10: ffff8801d3886fa0 R11: 0000000000000000 R12: ffff8801bf73a840
> R13: 0000000000007205 R14: 0000000000007205 R15: 0000000000000fdb
>  binder_cleanup_transaction+0xd2/0x140 drivers/android/binder.c:2035
>  binder_release_work+0x340/0x490 drivers/android/binder.c:4198
>  binder_deferred_release drivers/android/binder.c:4951 [inline]
>  binder_deferred_func+0xe42/0x1340 drivers/android/binder.c:4996
>  process_one_work+0xbbf/0x1af0 kernel/workqueue.c:2112
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2246
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 

syzbot is no longer hitting this because the WARN() was removed by commit
e46a3b3ba7509c:

#syz fix: ANDROID: binder: remove WARN() for redundant txn error

- Eric
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
