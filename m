Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCUIzs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:55:48 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:39765 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeCUIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:55:42 -0400
X-Google-Smtp-Source: AG47ELtvvO6tDbRrP+T0Ht3inlMN0HcnpTrJFjbxUID4V45kk16tzsJDqJfVftfTSgpIHWWAxJMycL/uzr3gWUIbiWk=
MIME-Version: 1.0
In-Reply-To: <20180312184943.GB230165@gmail.com>
References: <001a114aa95cf6decb055cf1623b@google.com> <001a113ebb3240667d055e337d48@google.com>
 <CANRm+CwOti9F4Fitr5TvX+ji8s807n_kGXe_p=SPe5tp27=3mw@mail.gmail.com>
 <CANRm+CyZZJDbKNwu25ZCf0LhZizUfcehZqoO=SiqS0r_H51=Zg@mail.gmail.com>
 <CACT4Y+aq1tXikwzz-dGvexjOx=50cbo-RrgHC=Nqgm=dzVwwbQ@mail.gmail.com>
 <CACT4Y+a0vsKyoOuwSvZEBc1mZmhOr1WauMM03sAvbZiZ6SGi+Q@mail.gmail.com> <20180312184943.GB230165@gmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 21 Mar 2018 16:55:41 +0800
Message-ID: <CANRm+Cx-s4iprsS1ye0_1M_e0kbRmyyXNa6Gu1eF7hrYrEr31Q@mail.gmail.com>
Subject: Re: WARNING in kvm_arch_vcpu_ioctl_run (2)
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
        syzbot
        <bot+d9fbc5c299aa8a95ac07572b4f6e191c0f4efff6@syzkaller.appspotmail.com>,
        kvm <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-13 2:49 GMT+08:00 Eric Biggers <ebiggers3@gmail.com>:
> On Wed, Dec 27, 2017 at 07:27:40PM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
>> On Sun, Dec 3, 2017 at 5:38 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> >>>> Hello,
>> >>>>
>> >>>> syzbot has tested the proposed patch but the reproducer still triggered
>> >>>> crash:
>> >>>> WARNING in kvm_arch_vcpu_ioctl_run
>> >>>>
>> >>>> VMExit: intr_info=00000000 errcode=00000000 ilen=00000000
>> >>>>         reason=80000021 qualification=0000000000000000
>> >>>> IDTVectoring: info=00000000 errcode=00000000
>> >>>> TSC Offset = 0xffffffeeb46bc6ac
>> >>>> EPT pointer = 0x00000001ce37601e
>> >>>> WARNING: CPU: 0 PID: 3023 at arch/x86/kvm/x86.c:7293
>> >>>> kvm_arch_vcpu_ioctl_run+0x213/0x5d20
>> >>>> Kernel panic - not syncing: panic_on_warn set ...
>> >>>>
>> >>>> CPU: 0 PID: 3023 Comm: syz-executor4 Not tainted 4.14.0-next-20171117+ #9
>> >>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> >>>> Google 01/01/2011
>> >>>> Call Trace:
>> >>>>  dump_stack+0x173/0x237
>> >>>>  panic+0x1e4/0x41c
>> >>>>  __warn+0x1d9/0x1f0
>> >>>>  report_bug+0x20a/0x2d0
>> >>>>  fixup_bug.part.10+0x32/0x80
>> >>>>  do_error_trap+0x29c/0x370
>> >>>>  invalid_op+0x18/0x20
>> >>>> RIP: 0010:kvm_arch_vcpu_ioctl_run+0x213/0x5d20
>> >>>> RSP: 0018:ffff8801ce197680 EFLAGS: 00010293
>> >>>> RAX: ffff8801ce588440 RBX: ffff8801d5b8f000 RCX: ffffffff810d4003
>> >>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8801ce0e02b8
>> >>>> RBP: ffff8801ce197a50 R08: 0000000000000001 R09: 0000000000000001
>> >>>> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
>> >>>> R13: ffff8801ce0e0168 R14: ffff8801cec10980 R15: ffff8801ce0e0080
>> >>>>  kvm_vcpu_ioctl+0x619/0xf80
>> >>>>  do_vfs_ioctl+0x18b/0x13e0
>> >>>>  SyS_ioctl+0x7e/0xb0
>> >>>>  entry_SYSCALL_64_fastpath+0x1f/0x96
>> >>>> RIP: 0033:0x452879
>> >>>> RSP: 002b:00007f4bc97fdbe8 EFLAGS: 00000212 ORIG_RAX: 0000000000000010
>> >>>> RAX: ffffffffffffffda RBX: 0000000000000082 RCX: 0000000000452879
>> >>>> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000004
>> >>>> RBP: 00007ffce1993510 R08: 0000000000000000 R09: 0000000000000000
>> >>>> R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000000
>> >>>> R13: 00007ffce199348f R14: 00007f4bc97fe9c0 R15: 0000000000000006
>> >>>> Dumping ftrace buffer:
>> >>>>    (ftrace buffer empty)
>> >>>> Kernel Offset: disabled
>> >>>> Rebooting in 86400 seconds..
>> >>>
>> >>> I will have a look.
>> >>
>> >> Please have a try. https://lkml.org/lkml/2017/11/20/118
>> >
>> > Hi Wanpeng,
>> >
>> > Please also follow this part:
>> >
>> >> syzbot will keep track of this bug report.
>> >> Once a fix for this bug is committed, please reply to this email with:
>> >> #syz fix: exact-commit-title
>> >> Note: all commands must start from beginning of the line.
>> >
>> > It will greatly help to keep overall process running.
>> > Thanks
>>
>> still happens, number of crashes crossed 40K
>> we won't know if it's a new bugs or the same issue is still not fixed
>> until you tell syzbot about the fix as it asks
>>
>
> syzbot still doesn't know about Wanpeng's fix for this from a few months ago
> (commit c37c28730bb0), so telling it:
>
> #syz fix: KVM: VMX: Fix rflags cache during vCPU reset
>
> However, this WARN actually continued occurring very frequently for a couple
> months afterwards, presumably for a different reason, then stopped.  From what I

Yeah, a different story here.

> can gather, the reason it stopped occurring was not due to an upstream kernel
> change, but rather GCE started exposing the "unrestricted guest" CPU feature,
> which changed the reachable code paths in guest kernels.  So, syzbot will not be
> reporting it anymore.  But if anyone is still interested in looking into it, I
> can still reproduce the WARN locally, provided that you first run the following
> on the host:
>
>     rmmod kvm_intel
>     modprobe kvm_intel nested=1 unrestricted_guest=0

It doesn't associated with nested virt. I can reproduce w/o the
nested=1 on the host, I add some traces for debugging:

2920  [001] ....   154.395008: kvm_vcpu_ioctl: set guest debug
3188  [001] ....   154.395029: kvm_fpu: load
3188  [001] ....   154.395031: kvm_inj_exception: #UD (0x0)
3188  [001] ....   154.395033: kvm_mmio: mmio write len 2 gpa 0xfffe val 0x2
3188  [001] ....   154.395033: kvm_mmio: mmio write len 2 gpa 0xfffc val 0x3000
3188  [001] ....   154.395034: kvm_mmio: mmio write len 2 gpa 0xfffa val 0x8000
3188  [001] d..1   154.395045: kvm_entry: vcpu 0
3188  [001] ....   154.395046: kvm_exit: reason EXCEPTION_NMI rip 0x0 info 0 0
3188  [001] ....   154.395047: x86_emulate_instruction: =>
vcpu->mmio_needed is true
3188  [001] ....   154.395047: kvm_fpu: unload
3188  [001] ....   154.395048: kvm_userspace_exit: reason KVM_EXIT_DEBUG (4)
3279  [001] ....   154.395056: kvm_fpu: load
3279  [001] ....   154.395057: kvm_arch_vcpu_ioctl_run:  => Warning here

The KVM_SET_GUEST_DEBUG ioctl passes the parameter to set
KVM_GUESTDBG_USE_HW_BP| KVM_GUESTDBG_SINGLESTEP| KVM_GUESTDBG_ENABLE,
in addition, kvm injects a #UD before the vmentry and tries to emulate
this inject realmode interrupt since vm8086. It saves the
eflags/cs/eip to the ss segment by the three mmio writes in the trace
log above. However, syzkaller just registers one memory region whose
gpa range from 0x0~0x1000. KVM needs to exit to userspace to figure
out who owns this gpa address(0xfffe, 0xfffc, 0xfffa), The
eflags/cs/eip are stored in vcpu->run->mmio.data buffer and
vcpu->mmio_needed is set. __emulate_in_real() gets a X86EMUL_CONTINUE
and tries to continue the vmenty. There is a user exit due to debug
after vmexit since "handle hardware breakpoints during emulation"
logic. The other race syzkaller which mmaps and operates on the same
vCPU will see the vcpu->mmio_needed is true w/o complete_userspace_io
and warning as above.

So what I think we should do is to return EMULATE_USER_EXIT in
kvm_inject_realmode_interrupt() when vcpu->mmio_needed is true.
However, a lot of interfaces in inject_pending_events path needs to be
changed. Paolo, Radim, do you have any better idea? I can make a
patch. :)

Regards,
Wanpeng Li



>
> Here's the reproducer (for running in L1 guest):
>
> // autogenerated by syzkaller (http://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
> #include <endian.h>
> #include <linux/futex.h>
> #include <pthread.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <unistd.h>
>
> static void test();
>
> void loop()
> {
>   while (1) {
>     test();
>   }
> }
>
> struct thread_t {
>   int created, running, call;
>   pthread_t th;
> };
>
> static struct thread_t threads[16];
> static void execute_call(int call);
> static int running;
> static int collide;
>
> static void* thr(void* arg)
> {
>   struct thread_t* th = (struct thread_t*)arg;
>   for (;;) {
>     while (!__atomic_load_n(&th->running, __ATOMIC_ACQUIRE))
>       syscall(SYS_futex, &th->running, FUTEX_WAIT, 0, 0);
>     execute_call(th->call);
>     __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
>     __atomic_store_n(&th->running, 0, __ATOMIC_RELEASE);
>     syscall(SYS_futex, &th->running, FUTEX_WAKE);
>   }
>   return 0;
> }
>
> static void execute(int num_calls)
> {
>   int call, thread;
>   running = 0;
>   for (call = 0; call < num_calls; call++) {
>     for (thread = 0; thread < sizeof(threads) / sizeof(threads[0]); thread++) {
>       struct thread_t* th = &threads[thread];
>       if (!th->created) {
>         th->created = 1;
>         pthread_attr_t attr;
>         pthread_attr_init(&attr);
>         pthread_attr_setstacksize(&attr, 128 << 10);
>         pthread_create(&th->th, &attr, thr, th);
>       }
>       if (!__atomic_load_n(&th->running, __ATOMIC_ACQUIRE)) {
>         th->call = call;
>         __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
>         __atomic_store_n(&th->running, 1, __ATOMIC_RELEASE);
>         syscall(SYS_futex, &th->running, FUTEX_WAKE);
>         if (collide && call % 2)
>           break;
>         struct timespec ts;
>         ts.tv_sec = 0;
>         ts.tv_nsec = 20 * 1000 * 1000;
>         syscall(SYS_futex, &th->running, FUTEX_WAIT, 1, &ts);
>         if (running)
>           usleep((call == num_calls - 1) ? 10000 : 1000);
>         break;
>       }
>     }
>   }
> }
>
> long r[3];
> uint64_t procid;
> void execute_call(int call)
> {
>   switch (call) {
>   case 0:
>     syscall(__NR_mmap, 0x20000000, 0xfff000, 3, 0x32, -1, 0);
>     break;
>   case 1:
>     memcpy((void*)0x20d7eff7, "/dev/kvm", 9);
>     r[0] = syscall(__NR_openat, 0xffffffffffffff9c, 0x20d7eff7, 0, 0);
>     break;
>   case 2:
>     r[1] = syscall(__NR_ioctl, r[0], 0xae01, 0);
>     break;
>   case 3:
>     r[2] = syscall(__NR_ioctl, r[1], 0xae41, 0);
>     break;
>   case 4:
>     *(uint32_t*)0x206cf000 = 0x10004;
>     *(uint32_t*)0x206cf004 = 0;
>     *(uint64_t*)0x206cf008 = 0;
>     *(uint64_t*)0x206cf010 = 0x1000;
>     *(uint64_t*)0x206cf018 = 0x20a98000;
>     syscall(__NR_ioctl, r[1], 0x4020ae46, 0x206cf000);
>     break;
>   case 5:
>     syscall(__NR_ioctl, r[2], 0xaeb7);
>     break;
>   case 6:
>     syscall(__NR_ioctl, r[2], 0xae80, 0);
>     break;
>   case 7:
>     *(uint32_t*)0x20413000 = 0x20003;
>     *(uint32_t*)0x20413004 = 0;
>     *(uint64_t*)0x20413008 = 0;
>     *(uint64_t*)0x20413010 = 0;
>     *(uint64_t*)0x20413018 = 0;
>     *(uint64_t*)0x20413020 = 0;
>     *(uint64_t*)0x20413028 = 0;
>     *(uint64_t*)0x20413030 = 0;
>     *(uint64_t*)0x20413038 = 0;
>     *(uint64_t*)0x20413040 = 1;
>     syscall(__NR_ioctl, r[2], 0x4048ae9b, 0x20413000);
>     break;
>   case 8:
>     syscall(__NR_ioctl, r[2], 0xae80, 0);
>     break;
>   }
> }
>
> void test()
> {
>   memset(r, -1, sizeof(r));
>   execute(9);
>   collide = 1;
>   execute(9);
> }
>
> int main()
> {
>   for (procid = 0; procid < 8; procid++) {
>     if (fork() == 0) {
>       for (;;) {
>         loop();
>       }
>     }
>   }
>   sleep(1000000);
>   return 0;
> }
