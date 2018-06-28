Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EE0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CF826E4D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kda/oJPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CF826E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933090AbeF1F04 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:26:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35421 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeF1F0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:26:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id i7-v6so1951092pgp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Y9J9hWEOa7io46PY6CRRRPiujAbMcKIOpABS0IvvBI=;
        b=Kda/oJPNQwPpJeuwczS5GFeViyaPG9NQE9IQxW9QvtD5wzchSYW+5hq1eVQtfX6DUU
         6tD4Rp2ogVDhmBaKGmtgMVXS4VbqwiGNv0bw1noeUqgzGsu87TX7kH5C7+qMKT5xj79R
         tUZ+ZUgPuz++in5rb0trANWyeazreBr402mSZf1DEmXjdiZFV+wF62S/7DEG++hPYp2L
         lWDwH0AitplbZdR3vKHwG3+/7Z0JMcDQO1M2DUyQivyAyYjOJSQSTuHgKI1Oe45oeSkT
         ol5lgbIpXFP64hsujt5fLxcctN73Kuhpa506PLwlxaP3c/YDWWJXAKFNUQPTd8ryolAg
         nBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Y9J9hWEOa7io46PY6CRRRPiujAbMcKIOpABS0IvvBI=;
        b=bY3ge7d/eMU1m0OheZ8u/ZYfWQ8el/DV0bEceCvS/d/ZYZOxMeuwmFdMppd9cVess6
         5qCahCvBWbagQwKGJk4bM+mgJbSfz2ZC3JdL/i/YSowzgIiNpTm7IuNgASs73bRvgW37
         /jQ3Y39rlMrRxJHuX8+D0f1w0STQEDwIdvpriC5F9Sg8tZLjF8Ootqg3Lby8aFsfRYkb
         VfsZSDh5NaptVIMGCRqtc1vaAxGE1J6wDNPqnwV44vClIp+ZHn8hfrOHTBi5nbFAXnXA
         ECfNVipA5vMRIg1qR6gZENpYHAmse6M1INR3+Hv5oKe3jW8C8cIX0YMU3HFpuQV/DSbd
         Z0dg==
X-Gm-Message-State: APt69E3smnWE/9VTqJtDg7YEaa1OM/kTkA4hFbu2LqkzaMGc+s8cc3vp
        YU95EDBg7lcPVFb5tfqBhb7Mp2dwLv5nviOQ/AU0Qg==
X-Google-Smtp-Source: ADUXVKI9BGWHzZJD+VfizP8AnZCVxOYuw334TKSuh+lMqPyx1TpzyVtxFsgafgtUI0SdkNNnok6B3Dp9OdOx/jT/gH8=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr7835562pgh.216.1530163613187;
 Wed, 27 Jun 2018 22:26:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 27 Jun 2018 22:26:32
 -0700 (PDT)
In-Reply-To: <00000000000073cb2a056facf03f@google.com>
References: <00000000000073cb2a056facf03f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Jun 2018 07:26:32 +0200
Message-ID: <CACT4Y+b-orsK687CRh6G3_Pp=V+J6xu0rCSuf31dWeVhiE6FBg@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in vmx_vcpu_run
To:     syzbot <syzbot+74aad0c92138fdbff11f@syzkaller.appspotmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 7:24 AM, syzbot
<syzbot+74aad0c92138fdbff11f@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    debd52a05061 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1058cc9f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a63be0c83e84d370
> dashboard link: https://syzkaller.appspot.com/bug?extid=74aad0c92138fdbff11f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+74aad0c92138fdbff11f@syzkaller.appspotmail.com

#syz dup: BUG: unable to handle kernel paging request in vmx_vcpu_run

> ==================================================================
> BUG: KASAN: stack-out-of-bounds in msr_write_intercepted
> arch/x86/kvm/vmx.c:2338 [inline]
> BUG: KASAN: stack-out-of-bounds in vmx_vcpu_run+0x23ba/0x2600
> arch/x86/kvm/vmx.c:10160
> Read of size 8 at addr ffff88019755f7a0 by task syz-executor5/21645
>
> CPU: 0 PID: 21645 Comm: syz-executor5 Not tainted 4.18.0-rc2+ #119
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  msr_write_intercepted arch/x86/kvm/vmx.c:2338 [inline]
>  vmx_vcpu_run+0x23ba/0x2600 arch/x86/kvm/vmx.c:10160
> WARNING: kernel stack frame pointer at 00000000b24d5c50 in
> syz-executor5:21645 has bad value 00000000adda72ba
> unwind stack type:0 next_sp:          (null) mask:0x2 graph_idx:0
> 00000000f6bc44a5: ffff88019755f210 (0xffff88019755f210)
> 000000003207c122: ffffffff812a9095 (show_trace_log_lvl+0x1f6/0x28c)
> 000000004e97c852: ffffffff811f576a (vmx_vcpu_run+0x23ba/0x2600)
> 00000000cd5e7e10: ffff88019755f368 (0xffff88019755f368)
> 00000000b3ed19e4: 0000000000000002 (0x2)
> 00000000967e7c78: 0000000000000001 (0x1)
> 0000000057be443f: ffff880197558000 (0xffff880197558000)
> 000000007809f181: ffff880197560000 (0xffff880197560000)
> 00000000a0a291fa: 0000000000000000 ...
> 00000000677def61: ffff880197558000 (0xffff880197558000)
> 000000007321ac4a: ffff880197560000 (0xffff880197560000)
> 000000007423cee7: 0000000000000000 ...
> 00000000a148b5c1: 0000000000000002 (0x2)
> 00000000a37f5c7d: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 000000008234600d: 0000000100000000 (0x100000000)
> 00000000d6767ac7: ffff88019755f360 (0xffff88019755f360)
> 00000000d047810d: ffff88019755f140 (0xffff88019755f140)
> 00000000b15843e3: ffffffff811f576a (vmx_vcpu_run+0x23ba/0x2600)
> 00000000e6b8af55: 0000000000000000 ...
> 0000000077346d63: f6729f4af8185300 (0xf6729f4af8185300)
> 0000000062093407: 0000000000000016 (0x16)
> 00000000581fc196: 0000000000000000 ...
> 000000007a661406: ffffffff88f1b0a0 (pv_cpu_ops+0x120/0x120)
> 00000000a4980fed: 00000000ffffffff (0xffffffff)
> 00000000708d3d3f: ffff88019755f220 (0xffff88019755f220)
> 00000000bdc264ab: ffffffff812a9163 (show_stack+0x38/0x3a)
> 00000000ced6bc99: ffff88019755f2d0 (0xffff88019755f2d0)
> 000000008c2e2231: ffffffff878af5b5 (dump_stack+0x1c9/0x2b4)
> 0000000041a32e6b: fffffbfff11e3614 (0xfffffbfff11e3614)
> 00000000e10c52bf: dffffc0000000000 (0xdffffc0000000000)
> 000000004d053b1b: 1ffff10032eabe49 (0x1ffff10032eabe49)
> 0000000035d88931: 0000000041b58ab3 (0x41b58ab3)
> 000000004a562365: ffffffff88bd7ad4 (regoff.34027+0x3680f4/0x37ac50)
> 000000009f1914b6: ffffffff878af3ec (dump_stack_print_info.cold.2+0x52/0x52)
> 00000000f03e0fba: ffffffff8163049b (printk+0xa7/0xcf)
> 00000000d8655ef3: 0000000041b58ab3 (0x41b58ab3)
> 00000000e16aa3ec: ffffffff88bedb4c (K512_4+0x130c/0x120414)
> 00000000a10fbcdd: ffffffff816303f4 (kmsg_dump_rewind_nolock+0xe4/0xe4)
> 0000000095377466: ffffffff89029bc0 (kmem_cache_boot+0x320/0x320)
> 00000000258ab7c5: ffffffff00000008 (0xffffffff00000008)
> 00000000244091b8: ffff88019755f318 (0xffff88019755f318)
> 00000000f6a76323: ffff88019755f2c8 (0xffff88019755f2c8)
> 00000000eb8ea1b3: f6729f4af8185300 (0xf6729f4af8185300)
> 0000000064c60c7f: ffffea00065d57c0 (0xffffea00065d57c0)
> 000000008343ef5c: 0000000000000008 (0x8)
> 00000000e70d1b6e: ffff88019755f7a0 (0xffff88019755f7a0)
> 000000003a3b04c2: ffffffff811f576a (vmx_vcpu_run+0x23ba/0x2600)
> 00000000cf60c7bc: ffff88019755f7a0 (0xffff88019755f7a0)
> 0000000072788657: ffff88019755f308 (0xffff88019755f308)
> 000000006a758353: ffffffff81b9e384 (print_address_description+0x6c/0x20b)
> 0000000033ab7b1c: ffff88019755f7a0 (0xffff88019755f7a0)
> 000000000bc48851: 0000000000000008 (0x8)
> 00000000fb786515: 0000000000000000 ...
> 00000000eb1d1d22: ffffffff811f576a (vmx_vcpu_run+0x23ba/0x2600)
> 0000000051fa6761: ffff88019755f7a0 (0xffff88019755f7a0)
> 00000000241d6f8f: ffff88019755f350 (0xffff88019755f350)
> 0000000064caa33c: ffffffff81b9e765 (kasan_report.cold.7+0x242/0x2fe)
> 0000000061971ddf: 0000000000000082 (0x82)
> 00000000c8bdbff7: f6729f4af8185300 (0xf6729f4af8185300)
> 000000004dad3fe7: 0000000010000000 (0x10000000)
> 00000000feb537e9: 0000000000000000 ...
> 00000000e8a02ee4: ffff88019755f360 (0xffff88019755f360)
> 000000007e75b17a: ffffffff81b9e044 (__asan_report_load8_noabort+0x14/0x20)
> 00000000b24d5c50: ffffffff88be9b28 (regoff.34027+0x37a148/0x37ac50)
> 00000000c670b42d: ffffffff811f576a (vmx_vcpu_run+0x23ba/0x2600)
> 000000001c5bb19f: ffff8801b1ba2fb0 (0xffff8801b1ba2fb0)
> 0000000054d784c3: ffff88019755f7a0 (0xffff88019755f7a0)
> 0000000075fb725a: 0000000000000282 (0x282)
> 00000000ad71fefb: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 0000000082cd41ca: ffffffff88f92660 (rcu_callback_map+0x40/0x40)
> 00000000d9190806: 0000000000000039 (0x39)
> 000000008ddd1cf4: ffffffff89f8f308 (lock_chains+0x78c08/0x200020)
> 00000000d0977624: ffff88019755f3d8 (0xffff88019755f3d8)
> 000000004251f056: 0000000041b58ab3 (0x41b58ab3)
> 00000000cfb609b1: ffffffff88bee218 (K512_4+0x19d8/0x120414)
> 0000000064e8df53: ffffffff81489670 (mm_update_next_owner+0x9a0/0x9a0)
> 00000000282e80d7: 0000000041b58ab3 (0x41b58ab3)
> 00000000977c1535: ffffffff88bd98c0 (regoff.34027+0x369ee0/0x37ac50)
> 00000000347e3c55: ffffffff815e87c0 (print_usage_bug+0xc0/0xc0)
> 00000000e0ee1f63: ffffffff89f43a08 (lock_chains+0x2d308/0x200020)
> 000000004bb3e12e: 0000000041b58ab3 (0x41b58ab3)
> 00000000b411f7e0: ffffffff88bd6e57 (regoff.34027+0x367477/0x37ac50)
> 00000000aee2a97a: ffffffff815e17b0 (graph_lock+0x170/0x170)
> 00000000f633dab7: ffffffff81601c17 (do_raw_spin_unlock+0xa7/0x2f0)
> 00000000e38032c3: 0000000041b58ab3 (0x41b58ab3)
> 00000000e7c03ac6: ffffffff88bd7ad4 (regoff.34027+0x3680f4/0x37ac50)
> 00000000c5c55d64: 0000000041b58ab3 (0x41b58ab3)
> 000000001b56fe5f: ffffffff88be40c8 (regoff.34027+0x3746e8/0x37ac50)
> 00000000b7f60728: ffffffff81671750 (rcu_note_context_switch+0x730/0x730)
> 000000007188d96a: ffffffff815f1a04 (lock_acquire+0x1e4/0x540)
> 000000001febe75c: 0000000000000000 ...
> 000000001b4d3034: f6729f4af8185300 (0xf6729f4af8185300)
> 000000003c52903b: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 00000000c4c34668: ffffffff87ec9480 (tk_debug_sleep_time_fops+0x2e0/0x960)
> 00000000408b8f93: 0000000000000039 (0x39)
> 00000000d257b940: 0000000000000000 ...
> 000000004b87b7ce: ffff88019755f4a8 (0xffff88019755f4a8)
> 000000008bae97e1: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000d12ed4d4: ffff88019755f628 (0xffff88019755f628)
> 0000000047a7fe37: f6729f4af8185300 (0xf6729f4af8185300)
> 000000008470de73: 1ffff10032eabea6 (0x1ffff10032eabea6)
> 0000000059cfc0f6: ffff8801b1ba2fb8 (0xffff8801b1ba2fb8)
> 00000000e9830b37: ffffc90000c83620 (0xffffc90000c83620)
> 000000009d54c0d9: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000e927424d: 000000000000008e (0x8e)
> 00000000736a67ed: ffff8801b1ba2fda (0xffff8801b1ba2fda)
> 00000000b43dfff3: 0000000000000000 ...
> 0000000043dbdf19: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 00000000fe45025a: 000000000000000c (0xc)
> 00000000d238af0d: ffff88019755f868 (0xffff88019755f868)
> 000000008bf3dbaf: ffffffff815eb0dc (__lock_acquire+0x7fc/0x5020)
> 00000000b60b4f22: ffffc90000c83620 (0xffffc90000c83620)
> 000000000f5cd785: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 00000000ddc6ebe3: ffff88019755f550 (0xffff88019755f550)
> 000000007cc8ec66: ffff88019755f638 (0xffff88019755f638)
> 0000000072a59a31: 0000000000000282 (0x282)
> 0000000041186ead: 0000000000000000 ...
> 00000000d2388a07: ffff880100000001 (0xffff880100000001)
> 00000000e8f2d621: ffff8801b1ba2fb0 (0xffff8801b1ba2fb0)
> 00000000c9e61ed8: 0000000000000282 (0x282)
> 00000000552f6791: ffffffff00000001 (0xffffffff00000001)
> 00000000d808b3ff: 0000000041b58ab3 (0x41b58ab3)
> 000000006102189a: ffffffff88bf3058 (K512_4+0x6818/0x120414)
> 00000000bd725d51: ffff8801b1ba2fd0 (0xffff8801b1ba2fd0)
> 000000009e4c8665: 1ffff10000000000 (0x1ffff10000000000)
> 000000000e1a0b4f: ffff8801b1ba2fd8 (0xffff8801b1ba2fd8)
> 00000000888e6108: ffff8801b1ba2fb0 (0xffff8801b1ba2fb0)
> 000000001279b958: ffff8801b1ba2fa8 (0xffff8801b1ba2fa8)
> 00000000eed89c93: ffff8801b1ba2fb8 (0xffff8801b1ba2fb8)
> 000000006b275ba3: 1ffff10032eabeb0 (0x1ffff10032eabeb0)
> 000000005a43c040: ffffffff8a558b40 (chainhash_table+0x3a1c0/0x40020)
> 0000000097a41bed: 0000000041b58ab3 (0x41b58ab3)
> 00000000ca43b0ed: ffffffff88bf2fc8 (K512_4+0x6788/0x120414)
> 0000000067470b02: ffffffff815ea8e0 (trace_hardirqs_on+0x10/0x10)
> 00000000cbd0726f: ffffffff81b9d001 (kasan_check_read+0x11/0x20)
> 0000000067ea9e1d: ffff88019755f638 (0xffff88019755f638)
> 0000000045487b19: ffffffff81601c17 (do_raw_spin_unlock+0xa7/0x2f0)
> 00000000641cffdf: 0000000041b58ab3 (0x41b58ab3)
> 0000000084fa44a6: ffffffff88bd7ad4 (regoff.34027+0x3680f4/0x37ac50)
> 00000000d16bb8ab: ffffffff81601b70 (do_raw_spin_trylock+0x1c0/0x1c0)
> 00000000d573307d: 0000000000000000 ...
> 000000004659cf04: 0000000000000001 (0x1)
> 00000000f46244aa: ffffc90000c83610 (0xffffc90000c83610)
> 000000005802583b: ffffc90000c83618 (0xffffc90000c83618)
> 000000000691c1d4: ffffc90000c83640 (0xffffc90000c83640)
> 00000000557045c7: ffffffff81b9d024 (kasan_check_write+0x14/0x20)
> 00000000c504939d: ffff88019755f630 (0xffff88019755f630)
> 00000000f1916e79: ffffffff817c0e13 (__sanitizer_cov_trace_switch+0x53/0x90)
> 00000000fb3ced94: 0000000000000002 (0x2)
> 00000000c5ef0873: ffff880195334fc0 (0xffff880195334fc0)
> 00000000f02bd4dd: ffff88019755f878 (0xffff88019755f878)
> 000000002cf8e17b: ffff88019755f630 (0xffff88019755f630)
> 00000000ddb6af40: ffffffff817c0d5a
> (__sanitizer_cov_trace_const_cmp1+0x1a/0x20)
> 00000000ba5ac51a: ffff88019755f650 (0xffff88019755f650)
> 00000000d924d97c: ffffffff816e9abd (drop_futex_key_refs.isra.14+0x6d/0xe0)
> 00000000ace4fc15: ffff88019755f650 (0xffff88019755f650)
> 00000000f3fc533f: ffffffff817c0db8
> (__sanitizer_cov_trace_const_cmp8+0x18/0x20)
> 00000000a4b452ca: ffff88019755f8a0 (0xffff88019755f8a0)
> 00000000f547dc1b: ffffffff816f03b2 (futex_wait+0x5d2/0xa20)
> 00000000d692a846: ffff88019755f838 (0xffff88019755f838)
> 000000002260e340: 1ffff10032eabed7 (0x1ffff10032eabed7)
> 00000000306a7695: 0000000000000000 ...
> 00000000bf82796f: ffff88019755f7c8 (0xffff88019755f7c8)
> 00000000c8dee787: 00000000ffffffff (0xffffffff)
> 0000000055b71ae5: 000000000072bf68 (0x72bf68)
> 0000000085c443bf: ffff88019755f6d8 (0xffff88019755f6d8)
> 00000000bea3b7a0: ffff88019755f718 (0xffff88019755f718)
> 0000000027da5dba: ffffed0032eabef9 (0xffffed0032eabef9)
> 000000002dc48939: fffffe0000000001 (0xfffffe0000000001)
> 000000006ddd0354: 0000000000000000 ...
> 00000000eb573821: 0000000041b58ab3 (0x41b58ab3)
> 00000000c60fbdee: ffffffff88bf78b0 (K512_4+0xb070/0x120414)
> 00000000d9b12014: ffffffff816efde0 (futex_wait_setup+0x410/0x410)
> 000000009098a79d: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000ddfe6eb4: ffffc90000c83600 (0xffffc90000c83600)
> 000000006fe408d5: ffff88019755f718 (0xffff88019755f718)
> 000000003ad37ae6: ffffffff817c0e13 (__sanitizer_cov_trace_switch+0x53/0x90)
> 0000000093cab59c: 0000000000000002 (0x2)
> 00000000de1986fb: ffff880195334fc0 (0xffff880195334fc0)
> 000000002ff0f9d2: ffffffff89f19028 (lock_chains+0x2928/0x200020)
> 0000000000f35ba8: ffff88019755f718 (0xffff88019755f718)
> 00000000ce45789c: ffffffff817c0d5a
> (__sanitizer_cov_trace_const_cmp1+0x1a/0x20)
> 00000000c8b9b47d: ffff88019755f738 (0xffff88019755f738)
> 000000004c40f134: ffffffff816e9abd (drop_futex_key_refs.isra.14+0x6d/0xe0)
> 00000000070b1781: 0000000000000001 (0x1)
> 000000008fcb1693: ffffc90000c82028 (0xffffc90000c82028)
> 000000005f62bfd4: ffff88019755f8a0 (0xffff88019755f8a0)
> 000000001535dc1f: 0000000041b58ab3 (0x41b58ab3)
> 0000000066e5bbea: ffffffff88bd6e57 (regoff.34027+0x367477/0x37ac50)
> 000000005c6058f1: ffffffff815e17b0 (graph_lock+0x170/0x170)
> 00000000ea0adde4: 1ffff10032eabef3 (0x1ffff10032eabef3)
> 00000000ba1cf32c: 00000f6e00000000 (0xf6e00000000)
> 000000006cc1818a: 00000001ffffffff (0x1ffffffff)
> 0000000019b3f4a1: ffffed0032eabf00 (0xffffed0032eabf00)
> 000000006bf6aff5: ffff88019755f7b8 (0xffff88019755f7b8)
> 000000005f7cc6a4: ffff88019755f7f8 (0xffff88019755f7f8)
> 00000000054f56d2: ffffc90000c82040 (0xffffc90000c82040)
> 000000000f1f8270: 00000000ffffffff (0xffffffff)
> 0000000059f5e680: 0000000000000064 (0x64)
> 000000002bdbdab9: ffff88019755fc9c (0xffff88019755fc9c)
> 000000008c54b7e8: 0000000000000074 (0x74)
> 0000000030b31659: 0000000000000000 ...
> 00000000c8823495: ffff88019755f7e0 (0xffff88019755f7e0)
> 00000000ae457987: ffffffff81b9d681 (memset+0x31/0x40)
> 00000000b3af193e: 1ffff10032eabf04 (0x1ffff10032eabf04)
> 0000000004e67d73: ffff8801b1ba2e60 (0xffff8801b1ba2e60)
> 00000000c6ef4735: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000cb339efb: 1ffff10032eabf11 (0x1ffff10032eabf11)
> 000000007cc71acd: ffff8801b1ba2fb8 (0xffff8801b1ba2fb8)
> 00000000914ae717: ffff8801d82ec960 (0xffff8801d82ec960)
> 00000000ef5fee9e: ffff8801d82ec960 (0xffff8801d82ec960)
> 000000005f9022e3: 0000000000000000 ...
> 00000000202f9891: ffff88019755f850 (0xffff88019755f850)
> 000000003cd34d3f: ffffffff815e20b6 (find_held_lock+0x36/0x1c0)
> 00000000bfd8a8e0: 000000019755f828 (0x19755f828)
> 000000001854b439: ffff88019755f8a8 (0xffff88019755f8a8)
> 00000000a7f0beaf: 1ffff10032eabf11 (0x1ffff10032eabf11)
> 000000006b9b39d1: ffff88019755f968 (0xffff88019755f968)
> 00000000dd418b0d: ffff8801d82ec960 (0xffff8801d82ec960)
> 0000000091376075: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 000000006c4c544c: ffff88019755f8a8 (0xffff88019755f8a8)
> 0000000041d6bbbc: ffff88019755f990 (0xffff88019755f990)
> 00000000c210513d: 0000000000000082 (0x82)
> 00000000014644fe: 0000000041b58ab3 (0x41b58ab3)
> 000000007593c769: ffffffff00000001 (0xffffffff00000001)
> 0000000025f4394b: ffff8801b1ba2fb0 (0xffff8801b1ba2fb0)
> 00000000df9a45bc: 0000000000000082 (0x82)
> 000000008ae0b1a2: ffffffff00000001 (0xffffffff00000001)
> 00000000fdaec959: 0000000041b58ab3 (0x41b58ab3)
> 000000002cd37689: ffffffff88bf3058 (K512_4+0x6818/0x120414)
> 00000000d507e55c: ffffffff815f0df0 (lock_downgrade+0x8f0/0x8f0)
> 00000000b04b0915: 0000000000000004 (0x4)
> 00000000a06280f3: 0000000000000000 ...
> 000000007c540010: 0000000000000282 (0x282)
> 00000000673e520d: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000935a942b: 0000000000000009 (0x9)
> 00000000dc4d8691: f6729f4af8185300 (0xf6729f4af8185300)
> 000000008d75ea5d: 0000000000000000 ...
> 00000000edfbc8eb: ffff88019755f980 (0xffff88019755f980)
> 000000000c40416f: ffff88019aa28100 (0xffff88019aa28100)
> 0000000033dcc58a: 0000000000000004 (0x4)
> 00000000d4a09b82: ffff88019aa2819c (0xffff88019aa2819c)
> 00000000dd8cdafb: ffff88019755f9a8 (0xffff88019755f9a8)
> 000000003ab27df6: ffffffff8148c017 (do_group_exit+0x177/0x440)
> 000000008a0c52ae: 0000000041b58ab3 (0x41b58ab3)
> 00000000b9e49c44: ffffffff88bd7ad4 (regoff.34027+0x3680f4/0x37ac50)
> 00000000c9d227f3: ffffffff81601b70 (do_raw_spin_trylock+0x1c0/0x1c0)
> 0000000021a9bf15: 0000000041b58ab3 (0x41b58ab3)
> 000000007b8b06cf: ffffffff88bd782e (regoff.34027+0x367e4e/0x37ac50)
> 00000000619972c0: ffffffff8148bea0 (__ia32_sys_exit+0x50/0x50)
> 0000000000e83c54: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 00000000597cff7b: ffffffff87925347 (_raw_spin_unlock_irq+0x27/0x70)
> 00000000ba078d66: 0000000000000000 ...
> 000000000ffff8fc: 0000000000000009 (0x9)
> 00000000f5f31f29: 0000000000000000 ...
> 00000000171fb5e1: ffff88019755f980 (0xffff88019755f980)
> 000000005347b0c4: ffffffff815ea731 (trace_hardirqs_on_caller+0x421/0x5c0)
> 00000000e8fa1e32: ffff8801d82ec948 (0xffff8801d82ec948)
> 000000005fa3d538: f6729f4af8185300 (0xf6729f4af8185300)
> 0000000091a329f6: dffffc0000000000 (0xdffffc0000000000)
> 0000000076007d3c: 0000000000000000 ...
> 000000006d310845: 0000000000000009 (0x9)
> 00000000396dd1ab: 0000000000000000 ...
> 00000000564fc3db: ffff88019755fb58 (0xffff88019755fb58)
> 0000000005560402: ffffffff814c2c8e (get_signal+0x88e/0x1970)
> 00000000d78a83ea: 1ffff10032eabf42 (0x1ffff10032eabf42)
> 00000000180f5e00: ffffed0032eabf5e (0xffffed0032eabf5e)
> 00000000b8c1bf80: ffff88019755fc70 (0xffff88019755fc70)
> 00000000d2fdb44d: 0000000000000108 (0x108)
> 000000000731da34: ffff88019aa2819c (0xffff88019aa2819c)
> 00000000a848cdf3: ffff8801d82ec948 (0xffff8801d82ec948)
> 00000000e564ef26: ffff88019aa28100 (0xffff88019aa28100)
> 00000000321a2218: ffffffff00000004 (0xffffffff00000004)
> 000000009e8ce37c: 0000000800000282 (0x800000282)
> 00000000762166fc: ffff8801d82ec140 (0xffff8801d82ec140)
> 00000000ff68efb6: ffff88019755fc90 (0xffff88019755fc90)
> 000000001f385308: 0000000041b58ab3 (0x41b58ab3)
> 000000008d8780cc: ffffffff88bdcb90 (regoff.34027+0x36d1b0/0x37ac50)
> 0000000078c3dc70: ffffffff814c2400 (ptrace_notify+0x130/0x130)
> 000000006c966e6a: 0000000000000000 ...
> 00000000ad676ef8: ffff8801dae236a0 (0xffff8801dae236a0)
> 00000000a9f8a1a2: 1ffff10032eabf4f (0x1ffff10032eabf4f)
> 000000005b91d2e9: ffff8801dae236a0 (0xffff8801dae236a0)
> 0000000023e07088: 1ffff10032eabf51 (0x1ffff10032eabf51)
> 000000007a75906f: ffff8801dae236b0 (0xffff8801dae236b0)
> 00000000ffaefec4: ffff88019755fa70 (0xffff88019755fa70)
> 00000000723124ce: ffffffff81b9d001 (kasan_check_read+0x11/0x20)
> 00000000859d8b8a: ffff88019755fb10 (0xffff88019755fb10)
> 000000003a47118d: ffffffff816678fc (rcu_is_watching+0x8c/0x150)
> 00000000c0f26dfb: ffff88019755fad0 (0xffff88019755fad0)
> 00000000d66e4f45: 0000000041b58ab3 (0x41b58ab3)
> 000000002f977ff6: ffffffff88bd7ad4 (regoff.34027+0x3680f4/0x37ac50)
> 000000005cab7087: ffffffff81667870 (rcu_report_qs_rnp+0x7a0/0x7a0)
> 0000000079fd9cf6: ffffffff88f926e0 (rcu_bh_lock_map+0x40/0x40)
> 00000000d357d8ef: 0000000000000000 ...
> 00000000dc75c0a3: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 0000000095834a2a: ffffffff88f926e0 (rcu_bh_lock_map+0x40/0x40)
> 00000000fa21337f: ffff88019755fc48 (0xffff88019755fc48)
> 00000000daf8fd63: ffff8801b0ed4040 (0xffff8801b0ed4040)
> 000000004f7e9956: ffff88019755fb00 (0xffff88019755fb00)
> 0000000053c17be9: 0000000000000282 (0x282)
> 000000001c36b826: 0000000000000000 ...
> 00000000040cb66b: 0000000000000001 (0x1)
> 000000004e5d48ff: 0000000000000000 ...
> 00000000474bb61b: dffffc0000000000 (0xdffffc0000000000)
> 00000000ba87a383: ffff88019755fc48 (0xffff88019755fc48)
> 0000000097fa8b10: 0000000000000001 (0x1)
> 00000000a4fcbd51: ffff88019755fc70 (0xffff88019755fc70)
> 000000006a91253f: ffffffff81cc80f4 (__fget+0x414/0x670)
> 000000004d500c0b: ffff88019755fbc8 (0xffff88019755fbc8)
> 0000000058423d42: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000b0420c1b: 1ffff10032eabf7a (0x1ffff10032eabf7a)
> 00000000f2c79eb2: ffff88019755fc70 (0xffff88019755fc70)
> 000000006f1a4b9c: ffff88019755fdf8 (0xffff88019755fdf8)
> 000000007da8a76c: dffffc0000000000 (0xdffffc0000000000)
> 00000000f88c5e42: 0000000000000004 (0x4)
> 000000000f9390d8: ffff88019755fd78 (0xffff88019755fd78)
> 00000000900aa217: ffffffff8129887c (do_signal+0x9c/0x21c0)
> 00000000342c6ebd: 0000000041b58ab3 (0x41b58ab3)
> 00000000bfb22531: ffffffff88bd7728 (regoff.34027+0x367d48/0x37ac50)
> 00000000d152d22c: ffffffff81cc7ce0 (expand_files.part.8+0x9c0/0x9c0)
> 00000000bb14322f: ffff880100000001 (0xffff880100000001)
> 00000000310a59f5: 0000000000000001 (0x1)
> 0000000058ca67af: 0000000000000082 (0x82)
> 00000000b7bdd144: ffffffff00000001 (0xffffffff00000001)
> 00000000c530a39e: 0000000041b58ab3 (0x41b58ab3)
> 00000000a9864a43: ffffffff88bf3058 (K512_4+0x6818/0x120414)
> 0000000089bd0093: ffffffff815f0df0 (lock_downgrade+0x8f0/0x8f0)
> 00000000a2ff8f93: ffff8801ad65a2c0 (0xffff8801ad65a2c0)
> 00000000d9f29f4c: 0000000000000000 ...
> 0000000023cced39: ffff88019755ff58 (0xffff88019755ff58)
> 000000007d14195b: 0000000041b58ab3 (0x41b58ab3)
> 0000000094275d3b: ffffffff88be4288 (regoff.34027+0x3748a8/0x37ac50)
> 000000006588e330: ffffffff812987e0 (setup_sigcontext+0x7d0/0x7d0)
> 0000000056845fab: 1ffff10032eabf8a (0x1ffff10032eabf8a)
> 000000008634cd3a: ffff88019755fc00 (0xffff88019755fc00)
> 0000000029eb0f71: dffffc0000000000 (0xdffffc0000000000)
> 000000007d6d3325: 0000000000000000 ...
> 00000000acb93da2: 1ffff10039d68984 (0x1ffff10039d68984)
> 000000003df758b8: 0000000000000000 ...
> 0000000018459e78: ffff8801dae282a8 (0xffff8801dae282a8)
> 000000004482d580: ffff88019755f1e8 (0xffff88019755f1e8)
> 0000000081462c74: 0000000000000000 ...
> 00000000a632ad3c: ffffffff88f1b0a0 (pv_cpu_ops+0x120/0x120)
> 000000004d9d092f: 0000000000000001 (0x1)
> 0000000007e98671: 0000000000000000 ...
> 00000000731f8d28: 0000000000000001 (0x1)
> 00000000a64103f3: 0000000000000000 ...
> 0000000039a8695d: ffff8801ceb44c20 (0xffff8801ceb44c20)
> 00000000278e4a7f: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 00000000c821c77c: 0000000000000000 ...
> 00000000a83d5226: ffffffff81cc8687 (__fget_light+0x2f7/0x440)
> 00000000e1650f9f: ffff8801b1ba2fb0 (0xffff8801b1ba2fb0)
> 00000000795fe209: 0000000000000000 ...
> 00000000ed3af2c9: 0000000000000009 (0x9)
> 00000000cee2cbe8: fffffffffffffff8 (0xfffffffffffffff8)
> 0000000019b92e99: 0000000000000000 ...
> 00000000032fa981: ffff88019755fe20 (0xffff88019755fe20)
> 000000003e8a60a0: ffff88019755fe20 (0xffff88019755fe20)
> 00000000efd11dc9: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 0000000083c6a42c: ffffffff8100ab9c (exit_to_usermode_loop+0x8c/0x370)
> 00000000e9dfb8fa: ffff88019755fdf8 (0xffff88019755fdf8)
> 000000003df301a5: fffffbfff11e3616 (0xfffffbfff11e3616)
> 0000000009b1fb35: 1ffff10032eabfdc (0x1ffff10032eabfdc)
> 0000000075e5ac99: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000d5d79172: 0000000000000004 (0x4)
> 000000008c1ba42f: dffffc0000000000 (0xdffffc0000000000)
> 0000000012207a92: ffff88019755fdf8 (0xffff88019755fdf8)
> 000000006f63231d: fffffbfff11e3616 (0xfffffbfff11e3616)
> 000000003234a959: 0000000000000004 (0x4)
> 00000000addf67f9: ffff88019755fe20 (0xffff88019755fe20)
> 000000000bf4312a: ffffffff8100adf0 (exit_to_usermode_loop+0x2e0/0x370)
> 00000000a5fa7ac3: 1ffff10032eabfb3 (0x1ffff10032eabfb3)
> 000000001a7bed0f: ffff88019755ff58 (0xffff88019755ff58)
> 0000000003c8d19d: 0000000041b58ab3 (0x41b58ab3)
> 00000000653c38f5: ffffffff88bd782e (regoff.34027+0x367e4e/0x37ac50)
> 00000000b510cd15: ffffffff8100ab10 (syscall_slow_exit_work+0x500/0x500)
> 0000000017c02d83: ffff8801b1ba2fb0 (0xffff8801b1ba2fb0)
> 00000000d129477c: 0000000000000000 ...
> 00000000ca2535cf: ffffffff81c95161 (ksys_ioctl+0x81/0xd0)
> 000000001a121dee: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 0000000063c7592e: ffffffff8100c3ba (do_syscall_64+0x9a/0x820)
> 000000009537cf29: ffff88019755ff20 (0xffff88019755ff20)
> 000000000637b4c0: ffff88019755ff58 (0xffff88019755ff58)
> 00000000cc1679c1: dffffc0000000000 (0xdffffc0000000000)
> 00000000ef123bde: f6729f4af8185300 (0xf6729f4af8185300)
> 000000003aca24a6: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 000000001c498a88: 1ffff10032eabfc8 (0x1ffff10032eabfc8)
> 0000000063a0ac8b: 0000000000000004 (0x4)
> 0000000050ac740c: ffff88019755ff58 (0xffff88019755ff58)
> 00000000b480a78e: 1ffff10032eabfdc (0x1ffff10032eabfdc)
> 0000000067660b43: ffff88019755ff48 (0xffff88019755ff48)
> 00000000e57a0974: ffffffff8100c9de (do_syscall_64+0x6be/0x820)
> 000000005292566e: ffffffff8100ab10 (syscall_slow_exit_work+0x500/0x500)
> 000000001842821a: 0000000000000004 (0x4)
> 00000000c500f8d1: 0000000041b58ab3 (0x41b58ab3)
> 0000000022dec3ad: ffffffff88bd7728 (regoff.34027+0x367d48/0x37ac50)
> 000000001873c383: ffffffff8100c320 (syscall_return_slowpath+0x5e0/0x5e0)
> 00000000361920ee: ffff88019755fe68 (0xffff88019755fe68)
> 000000003e7dc435: 0000000000000000 ...
> 00000000b9cf4b12: ffff88019755ff48 (0xffff88019755ff48)
> 000000006dddd967: ffffffff8100c05d (syscall_return_slowpath+0x31d/0x5e0)
> 00000000ca68f0af: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000dcc49647: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 0000000049401273: 0000000000000002 (0x2)
> 000000003ecb4604: ffff8801b1ba2fb0 (0xffff8801b1ba2fb0)
> 0000000079246ed9: ffff88019755ff20 (0xffff88019755ff20)
> 00000000dce0c51f: 0000000000000004 (0x4)
> 000000002fb3a4b4: ffff8801b1ba2780 (0xffff8801b1ba2780)
> 000000000baea424: ffffffff87a0009d
> (entry_SYSCALL_64_after_hwframe+0x59/0xbe)
> 00000000680c0f2d: 0000000000000000 ...
> 000000004d2bc85e: 0000000000000082 (0x82)
> 000000002e6c82da: 0000000000000000 ...
> 000000007629c286: 0000000000000004 (0x4)
> 00000000a9b96d8d: 0000000000000000 ...
> 00000000f18b94d3: ffff88019755ff48 (0xffff88019755ff48)
> 000000002ac64f73: ffffffff81007d20 (trace_hardirqs_off_thunk+0x1a/0x1c)
> 00000000e231befa: 0000000000000000 ...
> 00000000e4fa3cec: f6729f4af8185300 (0xf6729f4af8185300)
> 00000000cff4c135: 0000000000000000 ...
> 00000000cd1669c4: ffffffff87a0008d
> (entry_SYSCALL_64_after_hwframe+0x49/0xbe)
> 000000001ccf813f: 0000000000000001 (0x1)
> 00000000f4c17744: 00007f22c04009c0 (0x7f22c04009c0)
> 00000000f051d589: 0000000000a3e81f (0xa3e81f)
> 00000000d190ad22: 0000000000000000 ...
> 00000000a0c73dbc: 000000000072bf68 (0x72bf68)
> 00000000776d3198: 000000000072bf68 (0x72bf68)
> 00000000206eafe5: 0000000000000246 (0x246)
> 00000000450434d5: 0000000000000000 ...
> 0000000032682bde: 000000000072bf48 (0x72bf48)
> 000000009d1b9971: 0000000000000000 ...
> 000000008481d925: fffffffffffffe00 (0xfffffffffffffe00)
> 0000000068dd5dd1: 0000000000455a99 (0x455a99)
> 000000003a9c7eb8: 0000000000000000 ...
> 00000000b5494a1d: 000000000072bf68 (0x72bf68)
> 00000000229e71a1: 00000000000000ca (0xca)
> 00000000b179ec09: 0000000000455a99 (0x455a99)
> 00000000d3750a47: 0000000000000033 (0x33)
> 000000009abe34c3: 0000000000000246 (0x246)
> 00000000526ccfa8: 00007f22c03ffce8 (0x7f22c03ffce8)
> 00000000fed30aa5: 000000000000002b (0x2b)
>
> The buggy address belongs to the page:
> page:ffffea00065d57c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 ffffffff06e50101 0000000000000000
> raw: 0000000000000000 ffff88019755f000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff88019755f680: f2 f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
>  ffff88019755f700: f2 f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
>>
>> ffff88019755f780: f2 f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
>
>                                ^
>  ffff88019755f800: f2 f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2
>  ffff88019755f880: f2 f2 00 f2 f2 f2 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000073cb2a056facf03f%40google.com.
> For more options, visit https://groups.google.com/d/optout.
