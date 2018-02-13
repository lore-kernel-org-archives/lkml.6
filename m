Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3063047-1518493110-2-8697474534743165607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518493109; b=reSWOE27G27n4iKKliY76hSF/baATjzmqZ0oKvsizI72s77
    TmDxjAh+jdzkiVwI2Z9+p0pWsJ+uPxf1qzFgFzH00MOJkJNICItKgOqOXW2Pk7eR
    XKse9Xzh+s5cTcgIP8wvKHg9VFGuhtA7mSQ7ZYzXSQNw+muhd6R3VAhkfZXnKVaS
    Pw6hoRoUG1RX8XDX6/et+Gfce7b2ND2qXa6q/bOCkp/KTkpnRhOX5MbaGvUVVQSX
    Bzkj1vwjA+vbwvl2rfvXOAEezlhjmKFPBFm0rhjnJs8hlK9x/8GgKdVYvjqoHDFK
    3HqMXP9ctnn9GuduZhTF7PTrXshJTd/9b6ebv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518493109; bh=55wwDwRrNhLvkesQgSBAetKKCQ
    dGuc5yYlM6Ir5gAsU=; b=H0YZfQpKkqqYtA/KNt5dvlcSqiZh6F1DcDMI5h3PpQ
    6HCP2iC0aOPuQHDCe9SFrg5IonHBWbV7TIJa49mWRy92f6WxDuu6R0v4LerwLm9U
    egzfdkYPhsAikqnYOu3TSA3UJWgCiP9lWIDcej/Lvd84IN0Cu9bB6TGtQLAHvU5e
    btfUgeYg5YJ3szK3bpdUcAklLWM4UKoxSkv0O2MzB52tJv46srSTFRRrMPfKZ4pa
    p37Sww7+uDKyaxl6Gs8d1oiByQXuspiiIIuPkfBJ/SfsyQMl8MRu52p1DDNfueUA
    r+O/BvBld6ZR9yNEKNbiodTW8Ygng8BhKI1gLuNeQwMA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dtUmXrjY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YKqqIApS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dtUmXrjY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YKqqIApS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeBMDi0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 22:38:26 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40116 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933323AbeBMDiY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Feb 2018 22:38:24 -0500
X-Google-Smtp-Source: AH8x226Yq/zxVaSL1lLiZYsoKRi4XgIYrusOqGU9r0gVZhhOY67S64Ze1/4cUBqBDHTleBN9e6YeHg==
Date: Mon, 12 Feb 2018 19:38:21 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] KVM: prevent overlap between user and private memslots
Message-ID: <20180213033821.GA23301@zzz.localdomain>
References: <94eb2c06f65e7ece95055cf1aafd@google.com>
 <20180119081820.30803-1-ebiggers3@gmail.com>
 <CANRm+CxLaDQEtEFjnFofXXWY6hNTjEGoJ+0WHZteVXU2LkkhMQ@mail.gmail.com>
 <CANRm+Cw_aw5J9_ZSkXSGgdvjaEu7WoKkYorOQLh5CFJp58XBhg@mail.gmail.com>
 <20180119185716.rmjh7nts6cubkvgw@gmail.com>
 <20180130204921.trzixusqdorm4a7w@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130204921.trzixusqdorm4a7w@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jan 30, 2018 at 12:49:21PM -0800, Eric Biggers wrote:
> On Fri, Jan 19, 2018 at 10:57:16AM -0800, Eric Biggers wrote:
> > +Cc alex.williamson@redhat.com
> > 
> > On Fri, Jan 19, 2018 at 05:03:47PM +0800, Wanpeng Li wrote:
> > > 2018-01-19 17:01 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> > > > 2018-01-19 16:18 GMT+08:00 Eric Biggers <ebiggers3@gmail.com>:
> > > >> From: Eric Biggers <ebiggers@google.com>
> > > >>
> > > >> Memslots must not overlap in guest physical memory, since otherwise some
> > > >> guest physical addresses will not uniquely map to a memslot.  Yet, the
> > > >> overlap check in __kvm_set_memory_region() allows a memslot that
> > > >> overlaps one of the "private" memslots, e.g. the memslot reserved for
> > > >> the TSS on x86.
> > > >>
> > > >> This seems to be a very old bug that was introduced years ago when
> > > >> private memory slots were first added.  It seems that later refactoring
> > > >> incorrectly assumed this bug was intentional and preserved it.
> > > >>
> > > >> Fix it by removing the loophole for private memslots, so we just check
> > > >> for overlap against all memslots.
> > > >>
> > > >> This bug was found by syzkaller, which used a memslot overlap to make
> > > >> pte_list_remove() be called for the wrong memslot, hitting a BUG():
> > > >>
> > > >>     pte_list_remove: 000000007185ed42 0->BUG
> > > >>     kernel BUG at arch/x86/kvm/mmu.c:1209!
> > > >>     [...]
> > > >>     RIP: 0010:pte_list_remove+0x107/0x110 arch/x86/kvm/mmu.c:1208
> > > >>     [...]
> > > >>     Call Trace:
> > > >>      mmu_page_zap_pte+0x7e/0xd0 arch/x86/kvm/mmu.c:2499
> > > >>      kvm_mmu_page_unlink_children arch/x86/kvm/mmu.c:2521 [inline]
> > > >>      kvm_mmu_prepare_zap_page+0x4f/0x340 arch/x86/kvm/mmu.c:2565
> > > >>      kvm_zap_obsolete_pages arch/x86/kvm/mmu.c:5348 [inline]
> > > >>      kvm_mmu_invalidate_zap_all_pages+0xa6/0x100 arch/x86/kvm/mmu.c:5389
> > > >>      kvm_mmu_notifier_release+0x4f/0x80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:468
> > > >>      __mmu_notifier_release+0x63/0x100 mm/mmu_notifier.c:75
> > > >>      mmu_notifier_release include/linux/mmu_notifier.h:244 [inline]
> > > >>      exit_mmap+0x160/0x170 mm/mmap.c:3009
> > > >>      __mmput kernel/fork.c:966 [inline]
> > > >>      mmput+0x44/0xd0 kernel/fork.c:987
> > > >>      exit_mm kernel/exit.c:544 [inline]
> > > >>      do_exit+0x24a/0xb50 kernel/exit.c:856
> > > >>      do_group_exit+0x34/0xb0 kernel/exit.c:972
> > > >>      SYSC_exit_group kernel/exit.c:983 [inline]
> > > >>      SyS_exit_group+0xb/0x10 kernel/exit.c:981
> > > >>      entry_SYSCALL_64_fastpath+0x1e/0x8b
> > > >>
> > > >> Reproducer:
> > > >>
> > > >>     #include <fcntl.h>
> > > >>     #include <linux/kvm.h>
> > > >>     #include <sys/ioctl.h>
> > > >>
> > > >>     int main()
> > > >>     {
> > > >>             static char buf[4096*3] __attribute__((aligned(4096)));
> > > >>             int kvm, vm, cpu;
> > > >>             struct kvm_mp_state mp_state = { KVM_MP_STATE_SIPI_RECEIVED };
> > > >>             struct kvm_userspace_memory_region memreg = {
> > > >>                     .memory_size = sizeof(buf),
> > > >>                     .userspace_addr = (__u64)buf,
> > > >>             };
> > > >>
> > > >>             kvm = open("/dev/kvm", O_RDWR);
> > > >>             vm = ioctl(kvm, KVM_CREATE_VM, 0);
> > > >>             ioctl(vm, KVM_CREATE_IRQCHIP);
> > > >>             cpu = ioctl(vm, KVM_CREATE_VCPU, 0);
> > > >>             ioctl(cpu, KVM_SET_MP_STATE, &mp_state);
> > > >>             ioctl(vm, KVM_SET_TSS_ADDR, 0);
> > > >>             ioctl(cpu, KVM_RUN, 0);
> > > >>             ioctl(vm, KVM_SET_USER_MEMORY_REGION, &memreg);
> > > >>     }
> > > >>
> > > >> Reported-by: syzbot <syzkaller@googlegroups.com>
> > > >> Fixes: e0d62c7f4860 ("KVM: Add kernel-internal memory slots")
> > > >> Cc: <stable@vger.kernel.org> # v2.6.25+
> > > >> Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > >
> > > > Please refer to this one. https://patchwork.kernel.org/patch/9645377/
> > > 
> > > https://lkml.org/lkml/2017/3/27/57
> > > 
> > 
> > Ah, so this was reported before, and you sent the same fix.  Well, it was never
> > applied, so the bug is still there, and anyone who can use /dev/kvm can trigger
> > it.  So one of these patches needs to be applied, unless there is a better fix.
> > 
> > I don't agree with the "Fixes:" line in your version of the patch.  The bug was
> > actually there prior to 5419369ed, which might explain why that commit seemed to
> > preserve the behavior intentionally.  (Note that KVM_MEMORY_SLOTS did not
> > include the private memory slots; it was later renamed to KVM_USER_MEM_SLOTS.)
> > 
> > Eric
> 
> Ping.  Paolo or Radim, can you please consider applying one of these patches?
> 
> Eric

Ping.
