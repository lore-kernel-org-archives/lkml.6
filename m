Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-159713-1518532691-2-10456297950466876516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518532690; b=FkmsLNEnTaCHAk3rsMEV1TtdX5+2glDlKESUbfjkIwdeDxN
    rW7379TB496nenfxT5pi1eqktw6a+5yChTcrPs5RNmucD5rEun0RFooJy7FvqKyq
    SlE6NUhIiDYBY6xRoELyWfDBlcKi2RFrgNlv6bnoCcDC50jMvWzIq7H+f6g3DsPg
    qA4EkT3ZKtqVTKjejwpXPgdmegtHtU4PCazMoLxbnpAgP98qNMWtsxrq2v9ubpF3
    nnr8Z+g5NkwkmgBRDSagSKDCtJ56zym/cISpn5SO4EfqDP1O5jC9ZclLs0XT81hS
    Zh+nGi0Od+w9R4dWSDvbx4F+ym8hJdVEBR0AjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518532690; bh=oZJ7hEAq4w3ocC6Fb2OfEJx2ze6PlMZxP6tM98P6yio=; b=I
    L70Z8SD71JUIP8d2xhgBBJHvS2HmOvoiBRKMql46Kv7f0H4353nL22UxP3nYqYWH
    NoClAya1eGaGKLDwTsht6hEpzq6+2jc2HtDrzfBDEWqxHKdbx1vZADiIUUx823uA
    HnhRtQA/V4hVdhKBWhWQjtka/tZgqZigGZQkiA79wgNS8OwZDiDFc+7xpnJduPh6
    YSCxx10OfJoNzFMKo6TJBChlCJFaYfmXPkEO4sUHTLHU87gFrUrs+UT8UXna8W1W
    axxG/o/3Dc9iLQSGsY1YTIOR9vqLP4DvSitoqZA5A487mwbFzy+djyEdPEKJkdov
    CHooW8mdtTo45eMOckPGA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935383AbeBMOiH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 09:38:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935370AbeBMOiG (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 09:38:06 -0500
Subject: Re: [PATCH] KVM: prevent overlap between user and private memslots
To: Eric Biggers <ebiggers3@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc: kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
References: <94eb2c06f65e7ece95055cf1aafd@google.com>
 <20180119081820.30803-1-ebiggers3@gmail.com>
 <CANRm+CxLaDQEtEFjnFofXXWY6hNTjEGoJ+0WHZteVXU2LkkhMQ@mail.gmail.com>
 <CANRm+Cw_aw5J9_ZSkXSGgdvjaEu7WoKkYorOQLh5CFJp58XBhg@mail.gmail.com>
 <20180119185716.rmjh7nts6cubkvgw@gmail.com>
 <20180130204921.trzixusqdorm4a7w@gmail.com>
 <20180213033821.GA23301@zzz.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afaebc4f-356e-9b1e-0a44-a8fa92662d14@redhat.com>
Date: Tue, 13 Feb 2018 15:38:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180213033821.GA23301@zzz.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/02/2018 04:38, Eric Biggers wrote:
> On Tue, Jan 30, 2018 at 12:49:21PM -0800, Eric Biggers wrote:
>> On Fri, Jan 19, 2018 at 10:57:16AM -0800, Eric Biggers wrote:
>>> +Cc alex.williamson@redhat.com
>>>
>>> On Fri, Jan 19, 2018 at 05:03:47PM +0800, Wanpeng Li wrote:
>>>> 2018-01-19 17:01 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
>>>>> 2018-01-19 16:18 GMT+08:00 Eric Biggers <ebiggers3@gmail.com>:
>>>>>> From: Eric Biggers <ebiggers@google.com>
>>>>>>
>>>>>> Memslots must not overlap in guest physical memory, since otherwise some
>>>>>> guest physical addresses will not uniquely map to a memslot.  Yet, the
>>>>>> overlap check in __kvm_set_memory_region() allows a memslot that
>>>>>> overlaps one of the "private" memslots, e.g. the memslot reserved for
>>>>>> the TSS on x86.
>>>>>>
>>>>>> This seems to be a very old bug that was introduced years ago when
>>>>>> private memory slots were first added.  It seems that later refactoring
>>>>>> incorrectly assumed this bug was intentional and preserved it.
>>>>>>
>>>>>> Fix it by removing the loophole for private memslots, so we just check
>>>>>> for overlap against all memslots.
>>>>>>
>>>>>> This bug was found by syzkaller, which used a memslot overlap to make
>>>>>> pte_list_remove() be called for the wrong memslot, hitting a BUG():
>>>>>>
>>>>>>     pte_list_remove: 000000007185ed42 0->BUG
>>>>>>     kernel BUG at arch/x86/kvm/mmu.c:1209!
>>>>>>     [...]
>>>>>>     RIP: 0010:pte_list_remove+0x107/0x110 arch/x86/kvm/mmu.c:1208
>>>>>>     [...]
>>>>>>     Call Trace:
>>>>>>      mmu_page_zap_pte+0x7e/0xd0 arch/x86/kvm/mmu.c:2499
>>>>>>      kvm_mmu_page_unlink_children arch/x86/kvm/mmu.c:2521 [inline]
>>>>>>      kvm_mmu_prepare_zap_page+0x4f/0x340 arch/x86/kvm/mmu.c:2565
>>>>>>      kvm_zap_obsolete_pages arch/x86/kvm/mmu.c:5348 [inline]
>>>>>>      kvm_mmu_invalidate_zap_all_pages+0xa6/0x100 arch/x86/kvm/mmu.c:5389
>>>>>>      kvm_mmu_notifier_release+0x4f/0x80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:468
>>>>>>      __mmu_notifier_release+0x63/0x100 mm/mmu_notifier.c:75
>>>>>>      mmu_notifier_release include/linux/mmu_notifier.h:244 [inline]
>>>>>>      exit_mmap+0x160/0x170 mm/mmap.c:3009
>>>>>>      __mmput kernel/fork.c:966 [inline]
>>>>>>      mmput+0x44/0xd0 kernel/fork.c:987
>>>>>>      exit_mm kernel/exit.c:544 [inline]
>>>>>>      do_exit+0x24a/0xb50 kernel/exit.c:856
>>>>>>      do_group_exit+0x34/0xb0 kernel/exit.c:972
>>>>>>      SYSC_exit_group kernel/exit.c:983 [inline]
>>>>>>      SyS_exit_group+0xb/0x10 kernel/exit.c:981
>>>>>>      entry_SYSCALL_64_fastpath+0x1e/0x8b
>>>>>>
>>>>>> Reproducer:
>>>>>>
>>>>>>     #include <fcntl.h>
>>>>>>     #include <linux/kvm.h>
>>>>>>     #include <sys/ioctl.h>
>>>>>>
>>>>>>     int main()
>>>>>>     {
>>>>>>             static char buf[4096*3] __attribute__((aligned(4096)));
>>>>>>             int kvm, vm, cpu;
>>>>>>             struct kvm_mp_state mp_state = { KVM_MP_STATE_SIPI_RECEIVED };
>>>>>>             struct kvm_userspace_memory_region memreg = {
>>>>>>                     .memory_size = sizeof(buf),
>>>>>>                     .userspace_addr = (__u64)buf,
>>>>>>             };
>>>>>>
>>>>>>             kvm = open("/dev/kvm", O_RDWR);
>>>>>>             vm = ioctl(kvm, KVM_CREATE_VM, 0);
>>>>>>             ioctl(vm, KVM_CREATE_IRQCHIP);
>>>>>>             cpu = ioctl(vm, KVM_CREATE_VCPU, 0);
>>>>>>             ioctl(cpu, KVM_SET_MP_STATE, &mp_state);
>>>>>>             ioctl(vm, KVM_SET_TSS_ADDR, 0);
>>>>>>             ioctl(cpu, KVM_RUN, 0);
>>>>>>             ioctl(vm, KVM_SET_USER_MEMORY_REGION, &memreg);
>>>>>>     }
>>>>>>
>>>>>> Reported-by: syzbot <syzkaller@googlegroups.com>
>>>>>> Fixes: e0d62c7f4860 ("KVM: Add kernel-internal memory slots")
>>>>>> Cc: <stable@vger.kernel.org> # v2.6.25+
>>>>>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>>>>>
>>>>> Please refer to this one. https://patchwork.kernel.org/patch/9645377/
>>>>
>>>> https://lkml.org/lkml/2017/3/27/57
>>>>
>>>
>>> Ah, so this was reported before, and you sent the same fix.  Well, it was never
>>> applied, so the bug is still there, and anyone who can use /dev/kvm can trigger
>>> it.  So one of these patches needs to be applied, unless there is a better fix.
>>>
>>> I don't agree with the "Fixes:" line in your version of the patch.  The bug was
>>> actually there prior to 5419369ed, which might explain why that commit seemed to
>>> preserve the behavior intentionally.  (Note that KVM_MEMORY_SLOTS did not
>>> include the private memory slots; it was later renamed to KVM_USER_MEM_SLOTS.)
>>>
>>> Eric
>>
>> Ping.  Paolo or Radim, can you please consider applying one of these patches?

Applied, thanks.

Paolo
