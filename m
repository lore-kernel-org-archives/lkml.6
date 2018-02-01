Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-774879-1517528843-2-15099544294133551302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  FSL_HELO_FAKE 3.2, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517528842; b=QFjdD10TQPiuCPkURnvOteIwLfH/4DERjnrowvGn+wUeERi
    Gps0oe8G/eKnl6uuw9wsiWPXksWtEUDDVM0vLm1fC60DMSXXkGw/ZNlOWNtPkK7/
    DTf0SveHAf9ZP/dMJjSmwbJOr3ir6xys/pHvhFwtwiUJwYRHGrUse2nDwl+FvrTv
    aLPRfYfsEkGox4JjMbQdsWa26mMbWKbRigf9RIbtmOsrn9DGLb2ms5tfX/Qk1aHg
    UxZ6wr63yy6MbYZ1Hta7p9d7Vr5nzJUUjNzjCFxB1ABQo2jQuJKGhi8T4VurehkB
    LLoF2C62DQG9mlMk8MitSNOOSVkiMO1Z0OVmhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517528842; bh=7yE/bdGsAnmq0p2bLLlZ27gP4u
    ANjEAFiuyWqBfO2e4=; b=GvB968y9Ge7yTECXOpYU0pzpX5VOgeaGibKfZ8Pa1N
    +cqpb7+ROOkh9ss0Lp4T83ZPKnwMwBfdAv+iUqcGFL+u5WjChw4gQErIygcpYvKu
    r15hCkdq7IhT5J9KYIG1FNWRX2FExOgGGq9sQI1oxW7rfcC8U6K1he9zCurO8iPp
    SOhSY+cJShVIE/QcH4IcsPtazXojXkH2DUcqS0GeroRNlo6lQAhrTpBA4wlvj6WW
    ZToiiouD1O8NAjLmIGMa/jynDYvInRqipz4OCkkfan3va6gQgvI7Zk27k+O7q4ZM
    QMd1UKV+tDD7vXNf6kvOMunPix5UTsJEDqaqbD8uRfOw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZAmAzL4s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AXlDv4Zn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZAmAzL4s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AXlDv4Zn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeBAXrR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 18:47:17 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:56290 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeBAXrR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Feb 2018 18:47:17 -0500
X-Google-Smtp-Source: AH8x225tjndNUpsOEhXVPv6H/Ox6zJQsIa/YxH0/BwhZ7Ih55Ww3XLB7BqpmSu2uYc2e870PP8oiCw==
Date: Thu, 1 Feb 2018 15:47:13 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+b8845cd4aa5a5e2c6cdc@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, dave.jiang@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mingo@kernel.org,
        ross.zwisler@linux.intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, zaitcev@redhat.com
Subject: Re: BUG: Bad page state (3)
Message-ID: <20180201234713.wbiowmhjgsywfdyp@gmail.com>
References: <94eb2c19de60aed12a0561b192eb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c19de60aed12a0561b192eb@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Dec 31, 2017 at 11:03:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 30a7acd573899fd8b8ac39236eff6468b195ac7d
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b8845cd4aa5a5e2c6cdc@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> BUG: Bad page state in process syzkaller246299  pfn:1c0c5f
> page:000000004c4544aa count:1 mapcount:1 mapping:          (null) index:0x0
> flags: 0x2fffc0000000004(referenced)
> raw: 02fffc0000000004 0000000000000000 0000000000000000 0000000100000000
> raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> Modules linked in:
> CPU: 1 PID: 3493 Comm: syzkaller246299 Not tainted 4.15.0-rc6+ #245
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  bad_page+0x230/0x2b0 mm/page_alloc.c:577
>  free_pages_check_bad+0x1f0/0x2e0 mm/page_alloc.c:955
>  free_pages_check mm/page_alloc.c:964 [inline]
>  free_pages_prepare mm/page_alloc.c:1054 [inline]
>  free_pcp_prepare mm/page_alloc.c:1079 [inline]
>  free_unref_page_prepare mm/page_alloc.c:2622 [inline]
>  free_unref_page+0x594/0x9e0 mm/page_alloc.c:2672
>  __free_pages+0x107/0x150 mm/page_alloc.c:4297
>  free_pages+0x51/0x90 mm/page_alloc.c:4309
>  mon_free_buff drivers/usb/mon/mon_bin.c:1331 [inline]
>  mon_bin_ioctl+0x653/0xd40 drivers/usb/mon/mon_bin.c:1039
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x23/0x9a

Crash is no longer occurring, seems to have been fixed by commit 46eb14a6e1585:

#syz fix: USB: fix usbmon BUG trigger

- Eric
