Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeEHDSY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:18:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:24455 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753809AbeEHDSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:18:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,376,1520924400";
   d="gz'50?scan'50,208,50";a="38191738"
Date: Tue, 8 May 2018 11:18:54 +0800
From: kernel test robot <shun.hao@intel.com>
To: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [lkp-robot] 51f1de79ad [   72.673003] WARNING: CPU: 0 PID: 1392 at
 include/net/sock.h:638 smc_unhash_sk
Message-ID: <20180508031853.ssitkso3beje5x3k@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6adfkbz2ea5qtnlo"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6adfkbz2ea5qtnlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 51f1de79ad8ed3555fd01ae8fd432691d397684b
Author:     Ursula Braun <ubraun@linux.vnet.ibm.com>
AuthorDate: Fri Jan 26 09:28:48 2018 +0100
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Fri Jan 26 10:41:56 2018 -0500

    net/smc: replace sock_put worker by socket refcounting
    
    Proper socket refcounting makes the sock_put worker obsolete.
    
    Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

8dce2786a2  net/smc: smc_poll improvements
51f1de79ad  net/smc: replace sock_put worker by socket refcounting
f142f08bf7  Fix typo in comment.
28b24f518f  Add linux-next specific files for 20180507
+------------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                  | 8dce2786a2 | 51f1de79ad | f142f08bf7 | next-20180507 |
+------------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                   | 994        | 817        | 855        | 67            |
| boot_failures                                                    | 15         | 16         | 7          | 24            |
| Mem-Info                                                         | 15         | 10         | 3          | 5             |
| WARNING:at_include/net/sock.h:#smc_unhash_sk                     | 0          | 4          | 0          | 19            |
| EIP:smc_unhash_sk                                                | 0          | 4          | 0          | 19            |
| WARNING:at_lib/refcount.c:#refcount_dec                          | 0          | 4          | 0          | 19            |
| EIP:refcount_dec                                                 | 0          | 4          | 0          | 19            |
| WARNING:at_lib/refcount.c:#refcount_sub_and_test                 | 0          | 4          | 0          | 19            |
| EIP:refcount_sub_and_test                                        | 0          | 4          | 0          | 19            |
| invoked_oom-killer:gfp_mask=0x                                   | 0          | 2          | 0          | 4             |
| EIP:preempt_count_sub                                            | 0          | 1          |            |               |
| EIP:rcu_gp_kthread                                               | 0          | 1          |            |               |
| BUG:kernel_reboot-without-warning_in_test_stage                  | 0          | 1          |            |               |
| BUG:kernel_hang_in_boot_stage                                    | 0          | 0          | 1          |               |
| EIP:preempt_schedule_common                                      | 0          | 0          | 1          |               |
| EIP:schedule_timeout                                             | 0          | 0          | 2          |               |
| INFO:rcu_preempt_detected_stalls_on_CPUs/tasks                   | 0          | 0          | 3          |               |
| EIP:arch_local_irq_restore                                       | 0          | 0          | 1          |               |
| EIP:finish_swait                                                 | 0          | 0          | 2          |               |
| EIP:arch_local_irq_enable                                        | 0          | 0          | 2          |               |
| EIP:schedule                                                     | 0          | 0          | 1          |               |
| EIP:prepare_to_swait                                             | 0          | 0          | 1          |               |
| EIP:arch_local_save_flags                                        | 0          | 0          | 1          |               |
| INFO:rcu_sched_detected_stalls_on_CPUs/tasks                     | 0          | 0          | 1          |               |
| EIP:poll_schedule_timeout                                        | 0          | 0          | 1          |               |
| EIP:worker_thread                                                | 0          | 0          | 1          |               |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 0          | 0          | 0          | 4             |
+------------------------------------------------------------------+------------+------------+------------+---------------+


run-parts: /etc/kernel-tests/99-rmmod exited with code 123
wfg: skip syslogd
Deconfiguring network interfaces... done.
Sending all processes the TERM signal...
[   72.673003] WARNING: CPU: 0 PID: 1392 at include/net/sock.h:638 smc_unhash_sk+0x30/0x5a
[   72.678155] Modules linked in:
[   72.679274] CPU: 0 PID: 1392 Comm: trinity-c1 Not tainted 4.15.0-rc9-02013-g51f1de7 #2
[   72.685861] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   72.692551] EIP: smc_unhash_sk+0x30/0x5a
[   72.693926] EFLAGS: 00010246 CPU: 0
[   72.695216] EAX: 00000000 EBX: cf837740 ECX: 00000001 EDX: cf9a80f4
[   72.703836] ESI: cf7bd480 EDI: 00000000 EBP: cf9fbed4 ESP: cf9fbed0
[   72.705525]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[   72.707064] CR0: 80050033 CR2: 47f8704b CR3: 107f1000 CR4: 000406d0
[   72.712833] Call Trace:
[   72.713903]  smc_release+0xf0/0xfe
[   72.715134]  sock_release+0x10/0x4d
[   72.720395]  sock_close+0xb/0xf
[   72.721551]  __fput+0xcc/0x13d
[   72.722679]  ____fput+0x8/0xa
[   72.727855]  task_work_run+0x6e/0x8c
[   72.729112]  do_exit+0x356/0x7b4
[   72.730290]  ? remove_wait_queue+0x51/0x51
[   72.731595]  do_group_exit+0x2e/0x90
[   72.736913]  SyS_exit_group+0x11/0x11
[   72.738139]  do_fast_syscall_32+0x8f/0xd0
[   72.739414]  entry_SYSENTER_32+0x47/0x71
[   72.744758] EIP: 0xb7fdbb19
[   72.745832] EFLAGS: 00000292 CPU: 0
[   72.747025] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
[   72.752851] ESI: 00000001 EDI: 00007a3b EBP: 00000008 ESP: bfa5563c
[   72.754534]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b
[   72.760161] Code: c3 b8 01 02 00 00 e8 6d d3 83 ff 8b 53 38 85 d2 74 31 8b 43 34 85 c0 89 02 74 03 89 50 04 8b 43 44 c7 43 38 00 00 00 00 48 75 02 <0f> ff 8d 43 44 e8 53 fa a1 ff 8b 53 20 8b 43 24 83 c9 ff e8 e0
[   72.769124] ---[ end trace c8ecd73b4a109872 ]---
[   72.770588] ------------[ cut here ]------------
[   72.770588] ------------[ cut here ]------------
[   72.776088] refcount_t: decrement hit 0; leaking memory.
[   72.777633] WARNING: CPU: 0 PID: 1392 at lib/refcount.c:228 refcount_dec+0x26/0x2b
[   72.784474] Modules linked in:
[   72.785657] CPU: 0 PID: 1392 Comm: trinity-c1 Tainted: G        W        4.15.0-rc9-02013-g51f1de7 #2
[   72.792584] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   72.795270] EIP: refcount_dec+0x26/0x2b
[   72.800692] EFLAGS: 00010282 CPU: 0
[   72.801906] EAX: 0000002c EBX: cf837740 ECX: 00000000 EDX: 00000202
[   72.803594] ESI: cf7bd480 EDI: 00000000 EBP: cf9fbec8 ESP: cf9fbec4
[   72.809414]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[   72.810976] CR0: 80050033 CR2: 47f8704b CR3: 107f1000 CR4: 000406d0
[   72.816794] Call Trace:
[   72.817814]  smc_unhash_sk+0x3a/0x5a
[   72.819026]  smc_release+0xf0/0xfe
[   72.824328]  sock_release+0x10/0x4d
[   72.825546]  sock_close+0xb/0xf
[   72.826726]  __fput+0xcc/0x13d
[   72.831994]  ____fput+0x8/0xa
[   72.833201]  task_work_run+0x6e/0x8c
[   72.834376]  do_exit+0x356/0x7b4
[   72.835425]  ? remove_wait_queue+0x51/0x51
[   72.840816]  do_group_exit+0x2e/0x90
[   72.842131]  SyS_exit_group+0x11/0x11
[   72.844547]  do_fast_syscall_32+0x8f/0xd0
[   72.845741]  entry_SYSENTER_32+0x47/0x71
[   72.846907] EIP: 0xb7fdbb19
[   72.852084] EFLAGS: 00000292 CPU: 0
[   72.853281] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
[   72.855091] ESI: 00000001 EDI: 00007a3b EBP: 00000008 ESP: bfa5563c
[   72.860871]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b
[   72.862416] Code: 0f ff 58 c9 c3 55 89 e5 e8 48 ff ff ff 84 c0 74 1d 80 3d 35 97 c8 c1 00 75 14 68 64 ff ad c1 c6 05 35 97 c8 c1 01 e8 45 78 e0 ff <0f> ff 58 c9 c3 55 89 e5 53 89 c3 e8 2b ff ff ff 84 c0 74 04 31
[   72.871405] ---[ end trace c8ecd73b4a109873 ]---
[   72.877271] ------------[ cut here ]------------
[   72.877271] ------------[ cut here ]------------
[   72.878680] refcount_t: underflow; use-after-free.
[   72.884627] WARNING: CPU: 0 PID: 1392 at lib/refcount.c:187 refcount_sub_and_test+0x31/0x53
[   72.887533] Modules linked in:
[   72.892771] CPU: 0 PID: 1392 Comm: trinity-c1 Tainted: G        W        4.15.0-rc9-02013-g51f1de7 #2
[   72.895493] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   72.902119] EIP: refcount_sub_and_test+0x31/0x53
[   72.903543] EFLAGS: 00010286 CPU: 0
[   72.911780] EAX: 00000026 EBX: 00000000 ECX: 00000000 EDX: 00000001
[   72.913495] ESI: cf7bd480 EDI: 00000000 EBP: cf9fbec0 ESP: cf9fbeb4
[   72.915191]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[   72.920813] CR0: 80050033 CR2: 47f8704b CR3: 107f1000 CR4: 000406d0
[   72.922491] Call Trace:
[   72.923525]  refcount_dec_and_test+0xf/0x11
[   72.928967]  sock_put+0xe/0x1c
[   72.930114]  smc_release+0xf7/0xfe
[   72.931373]  sock_release+0x10/0x4d
[   72.936646]  sock_close+0xb/0xf
[   72.937765]  __fput+0xcc/0x13d
[   72.938895]  ____fput+0x8/0xa
[   72.944117]  task_work_run+0x6e/0x8c
[   72.945377]  do_exit+0x356/0x7b4
[   72.946541]  ? remove_wait_queue+0x51/0x51
[   72.951929]  do_group_exit+0x2e/0x90
[   72.953188]  SyS_exit_group+0x11/0x11
[   72.954437]  do_fast_syscall_32+0x8f/0xd0
[   72.959794]  entry_SYSENTER_32+0x47/0x71
[   72.961089] EIP: 0xb7fdbb19
[   72.962143] EFLAGS: 00000292 CPU: 0
[   72.963384] EAX: ffffffda EBX: 00000000 ECX: 00000000 EDX: 00000000
[   72.969183] ESI: 00000001 EDI: 00007a3b EBP: 00000008 ESP: bfa5563c
[   72.970893]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b
[   72.976496] Code: 51 8b 02 83 f8 ff 74 3c 89 c1 29 d9 39 c1 76 20 8a 1d 36 97 c8 c1 84 db 75 2a 68 e3 fe ad c1 c6 05 36 97 c8 c1 01 e8 3d 79 e0 ff <0f> ff 58 eb 16 0f b1 0a 0f 94 45 fb 80 7d fb 00 74 c6 85 c9 0f
[   72.985500] ---[ end trace c8ecd73b4a109874 ]---
Sending all processes the KILL signal...

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.16 v4.15 --
git bisect  bad 1388c80438e69fc01d83fbe98da3cac24c3c8731  # 23:41  B    566     3    0  86  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 4bf772b14675411a69b3c807f73006de0fe4b649  # 23:41  B    538     1    0 116  Merge tag 'drm-for-v4.16' of git://people.freedesktop.org/~airlied/linux
git bisect good c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e  # 23:48  G    909     0   30  89  iversion: make inode_cmp_iversion{+raw} return bool instead of s64
git bisect  bad 73da9e1a9f310a449eeb9bf5735a9cd475fef5e2  # 23:48  B    954     1    0 136  Merge branch 'akpm' (patches from Andrew)
git bisect good 9798f5178f5791f964562eccedcf4dabe02fd825  # 00:03  G    910     0   76 100  Merge tag 'gpio-v4.16-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
git bisect good 3c29548f87f9545f2f3c1cd1a784fae8ad2d53ba  # 00:18  G    909     0   62 102  Merge branch 'next-integrity' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect good 3dbc4f548519f9882676843b4fcdb4e61668baf8  # 00:35  G    904     0   62 101  Merge branch 'next-seccomp' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect good a103950e0dd2058df5e8a8d4a915707bdcf205f0  # 00:50  G    904     0   84 118  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect  bad b2fe5fa68642860e7de76167c3111623aa0d5de1  # 00:50  B    274     1    0  35  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good a9f894634e679b560af4aaf29eeabd631c3d2f64  # 01:04  G    904     0   58  92  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
git bisect good 1057c55f6b6cdc4fa3e8e29cfb9061c211e58395  # 01:20  G    902     0   58  85  net: sched: cls: add extack support for tcf_change_indev
git bisect good bf4405737f9f85a06db2b0ce5d76a818b61992e2  # 01:42  G    910     0   56  82  kill dev_ifsioc()
git bisect  bad 457740a903db30b14d53060f4e10d8cdecf464ac  # 01:53  B    396     1   17  63  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect good 2bafa8fac19a31ca72ae1a3e48df35f73661dbed  # 03:00  G    909     0  107 107  ixgbe: don't set RXDCTL.RLPML for 82599
git bisect good 96a71005bdcbbcf01abe50e2965bbcd1aee6a1e5  # 03:27  G    909     0   99  99  bpf, arm64: remove obsolete exception handling from div/mod
git bisect  bad 79eee41085414c25c788cd98b78e8776551d837f  # 03:45  B    104     1   17  17  net: hns3: add int_gl_idx setup for VF
git bisect good 8dce2786a2905e5b0ce49263910b4a47af75b752  # 04:25  G    901     0  100 100  net/smc: smc_poll improvements
git bisect  bad 72a231b7a7c801d413fb3aacaff04af6457a59b7  # 04:49  B    518     1   83  83  Merge branch 'net-smc-fixes-2018-01-26'
git bisect  bad 127f497058236e5f07672e11382232f80cb7e8c4  # 05:19  B    707     1   98  98  net/smc: release clcsock from tcp_listen_worker
git bisect  bad 51f1de79ad8ed3555fd01ae8fd432691d397684b  # 05:40  B     53     1    7   7  net/smc: replace sock_put worker by socket refcounting
# first bad commit: [51f1de79ad8ed3555fd01ae8fd432691d397684b] net/smc: replace sock_put worker by socket refcounting
git bisect good 8dce2786a2905e5b0ce49263910b4a47af75b752  # 06:07  G   1007     0   16 116  net/smc: smc_poll improvements
# extra tests on HEAD of linux-devel/devel-hourly-2018050615
git bisect  bad 4d35c4fd4f1336f48b26b11f2a3c56717838c8e7  # 06:08  B     26     7    0   2  0day head guard for 'devel-hourly-2018050615'
# extra tests on tree/branch linus/master
git bisect good f142f08bf7ecc41c3e71e05b765ea654047cf0c0  # 06:51  G    907     0   61  61  Fix typo in comment.
# extra tests on tree/branch linux-next/master
git bisect  bad 28b24f518f4590b02baa794669e82678ebef695d  # 07:05  B     27     8    4   5  Add linux-next specific files for 20180507

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--6adfkbz2ea5qtnlo
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-16:20180508054006:i386-randconfig-x0-05062255:4.15.0-rc9-02013-g51f1de7:2.gz"
Content-Transfer-Encoding: base64

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
Y+nLDzA7/wPcYtcDDzUBAA==

--6adfkbz2ea5qtnlo
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-vp-10:20180508041802:i386-randconfig-x0-05062255:4.15.0-rc9-02012-g8dce278:1.gz"
Content-Transfer-Encoding: base64

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
bi2wG4BX38TWWxtrAQvIp5nGzgKLpguRtrm+/vv6caZx6ypZ/+nkN/pP177Wxw313z+/s64Z
wumWPakMmCJMM9v0E53T24Ey5HuJG82zwAWdtWcksjepkZPABZJJdgG4jIRlwCUIMTCpWeFb
TkVhsl1DCHzK8ZmwjhClR/2+PusIkWZtWY11cCALWWQdISZT7lnWEWh36ZdZR6TKaHy5rWAd
tMja5aAunNALNlNYwTqiDK5xPjfLOji0wgpbE6S0DLg2sI6ofHKUt8g63nzz4eye7Yeu0d5a
vHnzL/ub57fXN+93Fw97qpPd26vdv1zc/aR2l9ePP7z95e7i6e7tj/ekBr7FAZb76w0Z5NYM
amsGvTWD2ZrBbs3gUoY3P/x48+7Xb37FGZNh1tufgzt15s2v3u5vsb9/S0now8X9M43Dx5/2
Hz58+Z8eb/b3+P+ze/olHZ3t/kP6l77AeKeB+dXd4/UNNfFXXG76/3Yf9vZaB3dy8f5fKfnN
TkVH/z7e3O8k/XuJ4739bg+V/svb/RN9fkf/CPopfYJt2cOX15ftt+d3NK+keer2Aqnu3j7s
8SX9/dPZ08X3l3fvd9dOC7F/PM++e4vDxbvb3eX+/Pk9ff/wdLGDP7d3vNNF38PTPFz/uOfZ
+d24q315s7+8PuMfvry+evfj9QMJXMgkj8mkjsmkj8lkjslkj8nkpjJR617juOzpMsm4frz/
cPYLLU23aJCbO+pAtCZjfXrzxZs3IAm3l+jED9Tk776iDvLVw9kNdYzvn2/fJ/R1f3Z7ffGO
OlfT1Gf39LH5m3r9w7/QjPTT2S+Pp6nLX5Ksi+f7SxpCJ/THKfV9rAE0xaJT0Nz4jvrmm19R
9zu5vsKa9PiOPt5T13764YTK/+Hm8f27u1v6ist9SwU/3l094cD5+b5/mNub69O2L77jb9/8
6u7u/rH9+8Pd2SWtADeooHcKBdxh8Wi/oSIvH84vT26ub+8e0pLyLvD70Ci+PPlw9/70w/7H
/Yd3+4eHN7+6fn+LtZu+5S/f/Ori7haGme+enn4hSfuzhw+/pDfAN78XX+IaHt4yS5d9++P7
s3e3fCJMdfXTm1+dP5zdXnz/7sP17fPPGMH7D1/x/7/9/u6ZJL+ldTcIK5y0b37157/73T+d
/u23f/bX37z76v6H919xpq8wI7wlKZdU4NX1+7c/0/iiDIoWmq/eX1y8tV81CoI7I3XI7u25
uNibqEgplOLcnBl/duXtubfqqx9vIPJf307qGOWaQ5vvH65OHr9/frq8++mWapj617/7D/+L
ZsA//Jc//p9/t3ubOtuOvkt//eE39PWb/wsJtv3KLj4DAA==

--6adfkbz2ea5qtnlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-vp-16:20180508054006:i386-randconfig-x0-05062255:4.15.0-rc9-02013-g51f1de7:2"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 296
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--6adfkbz2ea5qtnlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.15.0-rc9-02013-g51f1de7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.15.0-rc9 Kernel Configuration
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_DEBUG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
# CONFIG_HAVE_ARCH_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_MQ_IOSCHED_DEADLINE=m
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_INTEL_RDT is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=y
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=m
# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=y
CONFIG_I8K=m
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_ARCH_WANTS_THP_SWAP is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=m
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_SFI is not set
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_GX_SUSPMOD=y
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
CONFIG_PCIEASPM_POWER_SUPERSAVE=y
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT is not set

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_SMC=y
# CONFIG_SMC_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
# CONFIG_IP_MULTIPLE_TABLES is not set
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
# CONFIG_IP_PIMSM_V1 is not set
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_UDP_TUNNEL=y
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
# CONFIG_TCP_CONG_CUBIC is not set
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=y
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=y
# CONFIG_TCP_CONG_DCTCP is not set
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=m
# CONFIG_DEFAULT_BIC is not set
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_HYBLA is not set
CONFIG_DEFAULT_WESTWOOD=y
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="westwood"
CONFIG_TCP_MD5SIG=y
# CONFIG_IPV6 is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
# CONFIG_NF_CONNTRACK is not set
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=y
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_EXTHDR=y
CONFIG_NFT_META=m
CONFIG_NFT_RT=m
CONFIG_NFT_NUMGEN=m
# CONFIG_NFT_SET_RBTREE is not set
CONFIG_NFT_SET_HASH=m
CONFIG_NFT_SET_BITMAP=y
CONFIG_NFT_COUNTER=y
# CONFIG_NFT_LOG is not set
# CONFIG_NFT_LIMIT is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
CONFIG_NFT_QUOTA=y
# CONFIG_NFT_REJECT is not set
# CONFIG_NFT_COMPAT is not set
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NF_DUP_NETDEV=y
CONFIG_NFT_DUP_NETDEV=m
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
# CONFIG_NETFILTER_XT_SET is not set

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=y
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=y
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=y
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=y
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
# CONFIG_NETFILTER_XT_TARGET_TPROXY is not set
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=y
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=y
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
CONFIG_NETFILTER_XT_MATCH_MARK=y
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=y
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=y
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
# CONFIG_IP_SET_BITMAP_IP is not set
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
# CONFIG_IP_SET_HASH_IPPORTIP is not set
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
CONFIG_IP_SET_HASH_MAC=m
# CONFIG_IP_SET_HASH_NETPORTNET is not set
# CONFIG_IP_SET_HASH_NET is not set
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
# CONFIG_IP_SET_LIST_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV4 is not set
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TABLES_IPV4=y
# CONFIG_NFT_CHAIN_ROUTE_IPV4 is not set
# CONFIG_NFT_REJECT_IPV4 is not set
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
CONFIG_NF_REJECT_IPV4=m
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_MATCH_AH is not set
CONFIG_IP_NF_MATCH_ECN=m
# CONFIG_IP_NF_MATCH_RPFILTER is not set
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_MANGLE=y
# CONFIG_IP_NF_TARGET_ECN is not set
CONFIG_IP_NF_TARGET_TTL=y
CONFIG_IP_NF_RAW=y
# CONFIG_IP_NF_ARPTABLES is not set

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
# CONFIG_BRIDGE_EBT_BROUTE is not set
# CONFIG_BRIDGE_EBT_T_FILTER is not set
# CONFIG_BRIDGE_EBT_T_NAT is not set
# CONFIG_BRIDGE_EBT_802_3 is not set
# CONFIG_BRIDGE_EBT_AMONG is not set
# CONFIG_BRIDGE_EBT_ARP is not set
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
# CONFIG_BRIDGE_EBT_MARK is not set
CONFIG_BRIDGE_EBT_PKTTYPE=m
# CONFIG_BRIDGE_EBT_STP is not set
# CONFIG_BRIDGE_EBT_VLAN is not set
CONFIG_BRIDGE_EBT_ARPREPLY=m
# CONFIG_BRIDGE_EBT_DNAT is not set
CONFIG_BRIDGE_EBT_MARK_T=m
# CONFIG_BRIDGE_EBT_REDIRECT is not set
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
CONFIG_IP_DCCP_CCID3_DEBUG=y
CONFIG_IP_DCCP_TFRC_LIB=y
CONFIG_IP_DCCP_TFRC_DEBUG=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
# CONFIG_L2TP_IP is not set
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_MRP=y
CONFIG_BRIDGE=m
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=m
# CONFIG_NET_DSA_LEGACY is not set
CONFIG_NET_DSA_TAG_DSA=y
CONFIG_NET_DSA_TAG_EDSA=y
CONFIG_NET_DSA_TAG_KSZ=y
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_NET_DSA_TAG_QCA=y
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_IPX=y
CONFIG_IPX_INTERN=y
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
CONFIG_LTPC=m
# CONFIG_COPS is not set
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_X25=y
CONFIG_LAPB=m
CONFIG_PHONET=y
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
# CONFIG_MAC802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_HFSC=y
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
# CONFIG_NET_SCH_GRED is not set
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=m
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
# CONFIG_NET_CLS_FW is not set
CONFIG_NET_CLS_U32=y
CONFIG_CLS_U32_PERF=y
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
# CONFIG_NET_ACT_GACT is not set
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=y
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=y
# CONFIG_NET_ACT_SKBEDIT is not set
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
# CONFIG_NET_IFE_SKBTCINDEX is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=m
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_NCSI=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
# CONFIG_CAN_CALC_BITTIMING is not set
CONFIG_CAN_LEDS=y
CONFIG_PCH_CAN=m
CONFIG_CAN_C_CAN=m
# CONFIG_CAN_C_CAN_PLATFORM is not set
# CONFIG_CAN_C_CAN_PCI is not set
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
# CONFIG_CAN_CC770_PLATFORM is not set
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_SJA1000_ISA=m
# CONFIG_CAN_SJA1000_PLATFORM is not set
# CONFIG_CAN_EMS_PCI is not set
# CONFIG_CAN_PEAK_PCI is not set
CONFIG_CAN_KVASER_PCI=m
# CONFIG_CAN_PLX_PCI is not set
# CONFIG_CAN_TSCAN1 is not set
CONFIG_CAN_SOFTING=m
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=m
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_CFG80211_DEFAULT_PS is not set
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
# CONFIG_LIB80211 is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
# CONFIG_MAC80211_RC_MINSTREL_VHT is not set
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
# CONFIG_MAC80211_DEBUGFS is not set
CONFIG_MAC80211_MESSAGE_TRACING=y
CONFIG_MAC80211_DEBUG_MENU=y
# CONFIG_MAC80211_NOINLINE is not set
# CONFIG_MAC80211_VERBOSE_DEBUG is not set
CONFIG_MAC80211_MLME_DEBUG=y
CONFIG_MAC80211_STA_DEBUG=y
# CONFIG_MAC80211_HT_DEBUG is not set
CONFIG_MAC80211_OCB_DEBUG=y
# CONFIG_MAC80211_IBSS_DEBUG is not set
# CONFIG_MAC80211_PS_DEBUG is not set
# CONFIG_MAC80211_TDLS_DEBUG is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
CONFIG_NET_9P=m
CONFIG_NET_9P_VIRTIO=m
CONFIG_NET_9P_RDMA=m
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=y
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_SIM=m
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_UART=m
# CONFIG_NFC_MRVL_I2C is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_NXP_NCI is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=y
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_HWSPINLOCK=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_CONNECTOR=m
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
CONFIG_MTD_CMDLINE_PARTS=m
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=m
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=m
# CONFIG_MTD_SWAP is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
# CONFIG_MTD_RAM is not set
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=m
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_ECC=m
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_BCH=m
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_SM_COMMON is not set
CONFIG_MTD_NAND_DENALI=m
CONFIG_MTD_NAND_DENALI_PCI=m
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_NAND_DOCG4 is not set
CONFIG_MTD_NAND_CAFE=m
CONFIG_MTD_NAND_CS553X=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
# CONFIG_MTD_ONENAND_GENERIC is not set
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_MT81xx_NOR=m
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=m
CONFIG_SPI_INTEL_SPI_PCI=m
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_BLK_DEV_DAC960=y
CONFIG_BLK_DEV_UMEM=m
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_DRBD=m
CONFIG_DRBD_FAULT_INJECTION=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SX8=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
CONFIG_ATA_OVER_ETH=y
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_RDMA=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_RDMA is not set
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=m
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_CS5535_MFGPT is not set
CONFIG_HP_ILO=m
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
CONFIG_DS1682=y
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_IDE_LEGACY=y
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_IDE_GD=m
# CONFIG_IDE_GD_ATA is not set
CONFIG_IDE_GD_ATAPI=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
CONFIG_BLK_DEV_OFFBOARD=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_BLK_DEV_OPTI621=y
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=m
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CS5520=y
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_BLK_DEV_CS5535=y
# CONFIG_BLK_DEV_CS5536 is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_JMICRON=y
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IT8172=y
CONFIG_BLK_DEV_IT8213=y
# CONFIG_BLK_DEV_IT821X is not set
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BLK_DEV_TC86C001=m

#
# Other IDE chipsets support
#

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
CONFIG_BLK_DEV_ALI14XX=m
# CONFIG_BLK_DEV_DTC2278 is not set
CONFIG_BLK_DEV_HT6560B=m
# CONFIG_BLK_DEV_QD65XX is not set
CONFIG_BLK_DEV_UMC8672=m
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=m
# CONFIG_SCSI_AHA152X is not set
CONFIG_SCSI_AHA1542=m
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=m
CONFIG_SCSI_DPT_I2O=m
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
# CONFIG_MEGARAID_MAILBOX is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
CONFIG_SCSI_SMARTPQI=m
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_FLASHPOINT is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
# CONFIG_FCOE_FNIC is not set
CONFIG_SCSI_SNIC=m
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=m
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
CONFIG_SCSI_GDTH=m
# CONFIG_SCSI_ISCI is not set
CONFIG_SCSI_GENERIC_NCR5380=m
CONFIG_SCSI_IPS=m
# CONFIG_SCSI_INITIO is not set
CONFIG_SCSI_INIA100=m
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
# CONFIG_SCSI_QLOGIC_FAS is not set
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=m
# CONFIG_SCSI_NSP32 is not set
CONFIG_SCSI_WD719X=m
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=m
CONFIG_SCSI_BFA_FC=m
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
# CONFIG_TCM_PSCSI is not set
CONFIG_TCM_USER2=m
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LAN is not set
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
CONFIG_EQUALIZER=m
CONFIG_NET_FC=y
# CONFIG_IFB is not set
CONFIG_NET_TEAM=y
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
# CONFIG_NET_TEAM_MODE_RANDOM is not set
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
# CONFIG_NET_TEAM_MODE_LOADBALANCE is not set
# CONFIG_MACVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=m
CONFIG_GTP=y
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
CONFIG_TUN=m
CONFIG_TUN_VNET_CROSS_LE=y
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_VSOCKMON=m
CONFIG_SUNGEM_PHY=m
CONFIG_ARCNET=m
# CONFIG_ARCNET_1201 is not set
# CONFIG_ARCNET_1051 is not set
CONFIG_ARCNET_RAW=m
# CONFIG_ARCNET_CAP is not set
CONFIG_ARCNET_COM90xx=m
# CONFIG_ARCNET_COM90xxIO is not set
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
# CONFIG_ARCNET_COM20020_ISA is not set
CONFIG_ARCNET_COM20020_PCI=m

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=m
CONFIG_CAIF_SPI_SLAVE=y
# CONFIG_CAIF_SPI_SYNC is not set
# CONFIG_CAIF_HSI is not set
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
# CONFIG_B53 is not set
CONFIG_NET_DSA_LOOP=m
CONFIG_NET_DSA_MT7530=m
CONFIG_MICROCHIP_KSZ=m
CONFIG_NET_DSA_MV88E6XXX=m
CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
CONFIG_NET_DSA_QCA8K=m
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
# CONFIG_LANCE is not set
CONFIG_PCNET32=m
CONFIG_NI65=m
CONFIG_AMD_XGBE=m
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=y
CONFIG_ATL1=m
# CONFIG_ATL1E is not set
CONFIG_ATL1C=y
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=m
CONFIG_NET_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
CONFIG_MACB_PCI=m
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
# CONFIG_BNXT_FLOWER_OFFLOAD is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
CONFIG_CHELSIO_T1_1G=y
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_CS89x0=m
CONFIG_CS89x0_PLATFORM=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_CX_ECAT=y
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
CONFIG_DE4X5=y
CONFIG_WINBOND_840=y
CONFIG_DM9102=y
CONFIG_ULI526X=y
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
CONFIG_VXGE=y
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
CONFIG_NET_VENDOR_HP=y
CONFIG_HP100=y
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBEVF=m
# CONFIG_I40E is not set
CONFIG_I40EVF=m
CONFIG_FM10K=m
CONFIG_NET_VENDOR_I825XX=y
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=y
# CONFIG_MVNETA_BM is not set
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
CONFIG_SKY2=y
# CONFIG_SKY2_DEBUG is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
CONFIG_FEALNX=m
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
# CONFIG_NFP_APP_FLOWER is not set
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
CONFIG_HAMACHI=y
CONFIG_YELLOWFIN=y
# CONFIG_NET_VENDOR_QLOGIC is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=m
CONFIG_NET_VENDOR_SEEQ=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=y
# CONFIG_SFC_MCDI_MON is not set
CONFIG_SFC_SRIOV=y
# CONFIG_SFC_MCDI_LOGGING is not set
CONFIG_SFC_FALCON=m
# CONFIG_SFC_FALCON_MTD is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_EPIC100 is not set
CONFIG_SMSC911X=m
# CONFIG_SMSC911X_ARCH_HOOKS is not set
CONFIG_SMSC9420=m
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=m
CONFIG_STMMAC_PLATFORM=m
CONFIG_DWMAC_GENERIC=m
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=y
CONFIG_SUNGEM=m
CONFIG_CASSINI=m
CONFIG_NIU=m
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_FDDI=y
# CONFIG_DEFXX is not set
CONFIG_SKFP=m
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=y
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_NET_SB1000=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_GPIO=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83848_PHY is not set
CONFIG_DP83867_PHY=m
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=y
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROSEMI_PHY=y
CONFIG_NATIONAL_PHY=y
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=y
# CONFIG_VITESSE_PHY is not set
CONFIG_XILINX_GMII2RGMII=y
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPP_DEFLATE is not set
CONFIG_PPP_FILTER=y
# CONFIG_PPP_MPPE is not set
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=m
# CONFIG_PPTP is not set
# CONFIG_PPPOL2TP is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
CONFIG_LANMEDIA=m
CONFIG_SEALEVEL_4021=m
CONFIG_HDLC=m
# CONFIG_HDLC_RAW is not set
CONFIG_HDLC_RAW_ETH=m
# CONFIG_HDLC_CISCO is not set
CONFIG_HDLC_FR=m
# CONFIG_HDLC_PPP is not set
CONFIG_HDLC_X25=m
# CONFIG_PCI200SYN is not set
CONFIG_WANXL=m
# CONFIG_WANXL_BUILD_FIRMWARE is not set
# CONFIG_PC300TOO is not set
CONFIG_N2=m
CONFIG_C101=m
# CONFIG_FARSYNC is not set
CONFIG_DSCC4=m
CONFIG_DSCC4_PCISYNC=y
CONFIG_DSCC4_PCI_RST=y
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
CONFIG_LAPBETHER=m
# CONFIG_X25_ASY is not set
CONFIG_SBNI=m
# CONFIG_SBNI_MULTILINE is not set
CONFIG_IEEE802154_DRIVERS=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=y
CONFIG_ISDN_PPP=y
# CONFIG_ISDN_PPP_VJ is not set
# CONFIG_ISDN_MPP is not set
CONFIG_IPPP_FILTER=y
CONFIG_ISDN_PPP_BSDCOMP=y
CONFIG_ISDN_AUDIO=y
# CONFIG_ISDN_TTY_FAX is not set
CONFIG_ISDN_X25=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=y
CONFIG_ISDN_DIVERSION=y

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=y

#
# D-channel protocol features
#
# CONFIG_HISAX_EURO is not set
# CONFIG_HISAX_1TR6 is not set
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
# CONFIG_HISAX_16_0 is not set
CONFIG_HISAX_16_3=y
# CONFIG_HISAX_TELESPCI is not set
CONFIG_HISAX_S0BOX=y
# CONFIG_HISAX_AVM_A1 is not set
# CONFIG_HISAX_FRITZPCI is not set
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
CONFIG_HISAX_ELSA=y
# CONFIG_HISAX_IX1MICROR2 is not set
# CONFIG_HISAX_DIEHLDIVA is not set
CONFIG_HISAX_ASUSCOM=y
# CONFIG_HISAX_TELEINT is not set
CONFIG_HISAX_HFCS=y
# CONFIG_HISAX_SEDLBAUER is not set
CONFIG_HISAX_SPORTSTER=y
# CONFIG_HISAX_MIC is not set
# CONFIG_HISAX_NETJET is not set
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_ISURF=y
CONFIG_HISAX_HSTSAPHIR=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
# CONFIG_HISAX_GAZEL is not set
CONFIG_HISAX_HFC_PCI=y
# CONFIG_HISAX_W6692 is not set
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_DEBUG=y

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
CONFIG_HISAX_HFC4S8S=m
CONFIG_HISAX_FRITZ_PCIPNP=m
# CONFIG_ISDN_CAPI is not set
CONFIG_ISDN_DRV_GIGASET=y
CONFIG_GIGASET_I4L=y
# CONFIG_GIGASET_DUMMYLL is not set
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_MISDN=y
CONFIG_MISDN_DSP=y
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
# CONFIG_MISDN_HFCPCI is not set
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_AVMFRITZ=y
# CONFIG_MISDN_SPEEDFAX is not set
CONFIG_MISDN_INFINEON=y
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=y
CONFIG_MISDN_IPAC=y
CONFIG_ISDN_HDLC=y
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=m
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=m
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_DA9052=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=m
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=m
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_HTCPEN=m
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=y
CONFIG_CYCLADES=m
CONFIG_CYZ_INTR=y
CONFIG_MOXA_INTELLIO=y
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
# CONFIG_SYNCLINKMP is not set
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=y
CONFIG_ISI=y
CONFIG_N_HDLC=y
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=m
CONFIG_SERIAL_8250_MOXA=m

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_TPM=m
CONFIG_NVRAM=y
CONFIG_DTLK=m
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m
CONFIG_MWAVE=m
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=m
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_I2C_CROS_EC_TUNNEL is not set
CONFIG_SCx200_ACB=y
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=y
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_CS5535=m
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_ML_IOH=m
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_RDC321X=y
# CONFIG_W1 is not set
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=m
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=m
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
# CONFIG_AB3100_OTP is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PM800=m
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=m
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_AB3100=m
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=m
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=m
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65910=m
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_TPS80031 is not set
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
CONFIG_LIRC=y
CONFIG_IR_LIRC_CODEC=y
CONFIG_IR_NEC_DECODER=y
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=y
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=y
# CONFIG_IR_FINTEK is not set
CONFIG_IR_NUVOTON=y
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=y
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_PCI_SKELETON=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=y
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_TW5864=y
CONFIG_VIDEO_TW68=y
CONFIG_VIDEO_ZORAN=m
# CONFIG_VIDEO_ZORAN_DC30 is not set
CONFIG_VIDEO_ZORAN_ZR36060=m
CONFIG_VIDEO_ZORAN_BUZ=m
# CONFIG_VIDEO_ZORAN_DC10 is not set
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZORAN_LML33R10=m
CONFIG_VIDEO_ZORAN_AVS6EYES=m

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_FB_IVTV is not set
CONFIG_VIDEO_HEXIUM_GEMINI=m
# CONFIG_VIDEO_HEXIUM_ORION is not set
CONFIG_VIDEO_MXB=y
CONFIG_VIDEO_DT3155=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX25821=m
CONFIG_VIDEO_CX88=y
CONFIG_VIDEO_CX88_BLACKBIRD=y
CONFIG_VIDEO_CX88_MPEG=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=m
CONFIG_VIDEO_VIA_CAMERA=y
CONFIG_SOC_CAMERA=y
CONFIG_SOC_CAMERA_PLATFORM=m
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
# CONFIG_VIDEO_SH_VEU is not set
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
CONFIG_RADIO_SI4713=m
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=m
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_TEA5764=m
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_TIMBERDALE is not set
CONFIG_RADIO_WL1273=y

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_V4L_RADIO_ISA_DRIVERS=y
CONFIG_RADIO_ISA=y
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=y
CONFIG_RADIO_RTRACK_PORT=30f
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
CONFIG_RADIO_GEMTEK=y
CONFIG_RADIO_GEMTEK_PORT=34c
# CONFIG_RADIO_GEMTEK_PROBE is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
CONFIG_RADIO_ZOLTRIX=m
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_SAA711X=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m

#
# Camera sensor devices
#
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_MT9M111=m

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# soc_camera sensor drivers
#
# CONFIG_SOC_CAMERA_IMX074 is not set
CONFIG_SOC_CAMERA_MT9M001=m
CONFIG_SOC_CAMERA_MT9M111=m
# CONFIG_SOC_CAMERA_MT9T031 is not set
# CONFIG_SOC_CAMERA_MT9T112 is not set
CONFIG_SOC_CAMERA_MT9V022=m
CONFIG_SOC_CAMERA_OV5642=y
CONFIG_SOC_CAMERA_OV772X=m
CONFIG_SOC_CAMERA_OV9640=m
CONFIG_SOC_CAMERA_OV9740=m
CONFIG_SOC_CAMERA_RJ54N1=m
CONFIG_SOC_CAMERA_TW9910=m
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_NVIDIA=y
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=y
CONFIG_DRM_AMDGPU_SI=y
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y
CONFIG_DRM_AMDGPU_GART_DEBUGFS=y

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
# CONFIG_DRM_AMD_DC_PRE_VEGA is not set
CONFIG_DRM_AMD_DC_FBC=y
# CONFIG_DRM_AMD_DC_DCN1_0 is not set
CONFIG_DEBUG_KERNEL_DC=y

#
# AMD Library routines
#
CONFIG_CHASH=y
CONFIG_CHASH_STATS=y
CONFIG_CHASH_SELFTEST=y
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
CONFIG_DRM_I915=m
CONFIG_DRM_I915_ALPHA_SUPPORT=y
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=y
CONFIG_DRM_GMA600=y
# CONFIG_DRM_GMA3600 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_QXL=y
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_HISI_HIBMC=m
CONFIG_DRM_TINYDRM=y
# CONFIG_DRM_LEGACY is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=m
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=m
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
# CONFIG_FB_AUO_K1900 is not set
# CONFIG_FB_AUO_K1901 is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_VGASTATE=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=m
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_WHCI=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_APU=y
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=y
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
CONFIG_INFINIBAND_USER_ACCESS=y
# CONFIG_INFINIBAND_EXP_USER_ACCESS is not set
CONFIG_INFINIBAND_USER_MEM=y
# CONFIG_INFINIBAND_ON_DEMAND_PAGING is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_MTHCA=m
CONFIG_INFINIBAND_MTHCA_DEBUG=y
CONFIG_INFINIBAND_CXGB3=m
# CONFIG_INFINIBAND_CXGB3_DEBUG is not set
# CONFIG_INFINIBAND_CXGB4 is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_NES is not set
CONFIG_INFINIBAND_OCRDMA=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
CONFIG_INFINIBAND_SRP=m
# CONFIG_INFINIBAND_SRPT is not set
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
# CONFIG_RDMA_RXE is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_INTEL_IDMA64=y
CONFIG_PCH_DMA=y
# CONFIG_TIMB_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=m

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=m
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
# CONFIG_IRDA is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=m
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
# CONFIG_COMEDI_ADDI_APCI_3XXX is not set
# CONFIG_COMEDI_ADL_PCI6208 is not set
CONFIG_COMEDI_ADL_PCI7X3X=m
# CONFIG_COMEDI_ADL_PCI8164 is not set
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
# CONFIG_COMEDI_ADV_PCI1724 is not set
CONFIG_COMEDI_ADV_PCI1760=m
CONFIG_COMEDI_ADV_PCI_DIO=m
# CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=m
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
# CONFIG_COMEDI_DYNA_PCI10XX is not set
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
# CONFIG_COMEDI_ICP_MULTI is not set
CONFIG_COMEDI_DAQBOARD2000=m
# CONFIG_COMEDI_JR3_PCI is not set
# CONFIG_COMEDI_KE_COUNTER is not set
CONFIG_COMEDI_CB_PCIDAS64=m
# CONFIG_COMEDI_CB_PCIDAS is not set
CONFIG_COMEDI_CB_PCIDDA=m
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
# CONFIG_COMEDI_ME4000 is not set
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
CONFIG_COMEDI_NI_670X=m
CONFIG_COMEDI_NI_LABPC_PCI=m
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=m
# CONFIG_COMEDI_RTD520 is not set
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_R8822BE=m
CONFIG_RTLHALMAC_ST=m
CONFIG_RTLPHYDM_ST=m
CONFIG_RTLWIFI_DEBUG_ST=y
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=m

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_I2C=m

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# CONFIG_AD7152 is not set
CONFIG_AD7746=y

#
# Direct Digital Synthesis
#

#
# Digital gyroscope sensors
#

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Light sensors
#
CONFIG_TSL2x7x=m

#
# Active energy metering IC
#
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=m

#
# Resolver to digital converters
#

#
# Triggers - standalone
#
CONFIG_FB_SM750=y
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_SPEAKUP=m
CONFIG_SPEAKUP_SYNTH_ACNTSA=m
CONFIG_SPEAKUP_SYNTH_ACNTPC=m
CONFIG_SPEAKUP_SYNTH_APOLLO=m
CONFIG_SPEAKUP_SYNTH_AUDPTR=m
# CONFIG_SPEAKUP_SYNTH_BNS is not set
CONFIG_SPEAKUP_SYNTH_DECTLK=m
CONFIG_SPEAKUP_SYNTH_DECEXT=m
CONFIG_SPEAKUP_SYNTH_DECPC=m
CONFIG_SPEAKUP_SYNTH_DTLK=m
# CONFIG_SPEAKUP_SYNTH_KEYPC is not set
CONFIG_SPEAKUP_SYNTH_LTLK=m
# CONFIG_SPEAKUP_SYNTH_SOFT is not set
CONFIG_SPEAKUP_SYNTH_SPKOUT=m
CONFIG_SPEAKUP_SYNTH_TXPRT=m
# CONFIG_SPEAKUP_SYNTH_DUMMY is not set
CONFIG_STAGING_MEDIA=y
# CONFIG_I2C_BCM2048 is not set
# CONFIG_LIRC_STAGING is not set

#
# Android
#
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_LNET is not set
CONFIG_DGNC=m
# CONFIG_GS_FPGABOOT is not set
# CONFIG_WILC1000_SDIO is not set
CONFIG_MOST=y
CONFIG_MOSTCORE=y
# CONFIG_AIM_CDEV is not set
# CONFIG_AIM_NETWORK is not set
# CONFIG_AIM_V4L2 is not set
# CONFIG_HDM_DIM2 is not set
# CONFIG_HDM_I2C is not set
CONFIG_KS7010=m
CONFIG_GREYBUS=m
CONFIG_GREYBUS_BOOTROM=m
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
# CONFIG_GREYBUS_LOOPBACK is not set
# CONFIG_GREYBUS_POWER is not set
# CONFIG_GREYBUS_RAW is not set
CONFIG_GREYBUS_VIBRATOR=m
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_DRM_VBOXVIDEO=y
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_SMBIOS_WMI is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_WMI is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_TC1100_WMI is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_MXM_WMI=m
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_CPLD_PLATFORM is not set
# CONFIG_SILEAD_DMI is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_VIRTIO=m

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_BMA180=y
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_DA280=y
CONFIG_DA311=m
CONFIG_DMARD09=y
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=m
CONFIG_MMA9553=y
CONFIG_MXC4005=m
CONFIG_MXC6255=y
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
CONFIG_AD799X=y
# CONFIG_CC10001_ADC is not set
# CONFIG_DA9150_GPADC is not set
CONFIG_HX711=y
CONFIG_INA2XX_ADC=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=m
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=m
CONFIG_MCP3422=y
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_NAU7802 is not set
CONFIG_QCOM_SPMI_IADC=m
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_TI_ADC081C=m
# CONFIG_TI_AM335X_ADC is not set

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
CONFIG_VZ89X=m
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
# CONFIG_CIO_DAC is not set
CONFIG_DS4424=y
CONFIG_M62332=m
# CONFIG_MAX517 is not set
CONFIG_MCP4725=m

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=y
CONFIG_MAX30102=m

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=y
CONFIG_BH1750=m
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM36651 is not set
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=m
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
# CONFIG_HID_SENSOR_ALS is not set
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
CONFIG_MAX44000=y
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=m
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
CONFIG_TCS3414=m
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=y
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VEML6070=m
CONFIG_VL6180=y

#
# Magnetometer sensors
#
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y

#
# Multiplexers
#

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
CONFIG_DS1803=m
CONFIG_MCP4531=m
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_HID_SENSOR_PRESS is not set
CONFIG_HP03=m
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
# CONFIG_MS5611_I2C is not set
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
CONFIG_HP206C=m
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9500=m
CONFIG_SRF08=y

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=m
# CONFIG_MLX90614 is not set
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
CONFIG_TSYS01=m
CONFIG_TSYS02D=y
CONFIG_NTB=y
CONFIG_NTB_IDT=m
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=y
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=m
CONFIG_FMC_FAKEDEV=m
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=m
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_ALTERA_PR_IP_CORE=m

#
# FSI support
#
# CONFIG_FSI is not set
CONFIG_PM_OPP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
# CONFIG_GFS2_FS_LOCKING_DLM is not set
CONFIG_OCFS2_FS=m
# CONFIG_OCFS2_FS_O2CB is not set
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
# CONFIG_OCFS2_FS_STATS is not set
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_HISTOGRAM=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_HFSPLUS_FS_POSIX_ACL=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=m
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
# CONFIG_JFFS2_FS_SECURITY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_UBIFS_FS=m
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_ENCRYPTION=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=m
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=m
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_RAM is not set
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_EXOFS_FS=m
CONFIG_EXOFS_DEBUG=y
CONFIG_ORE=m
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set

#
# Runtime Testing
#
CONFIG_LKDTM=y
CONFIG_TEST_LIST_SORT=m
CONFIG_TEST_SORT=m
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_STRING_HELPERS=m
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
# CONFIG_TEST_BITMAP is not set
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=y
# CONFIG_TEST_HASH is not set
CONFIG_TEST_LKM=m
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_FIND_BIT is not set
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=y
# CONFIG_TEST_STATIC_KEYS is not set
CONFIG_TEST_KMOD=m
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=m
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_GEODE=m
CONFIG_CRYPTO_DEV_HIFN_795X=m
# CONFIG_CRYPTO_DEV_HIFN_795X_RNG is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=y
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_INTEL is not set
# CONFIG_KVM_AMD is not set
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=y
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=m
CONFIG_AUDIT_GENERIC=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=m
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
# CONFIG_FONT_7x14 is not set
CONFIG_FONT_PEARL_8x8=y
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
CONFIG_FONT_10x18=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=m

--6adfkbz2ea5qtnlo--
