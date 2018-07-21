Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED8CECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4C120854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeGUDEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 23:04:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:52200 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725139AbeGUDEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 23:04:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 19:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,382,1526367600"; 
   d="gz'50?scan'50,208,50";a="68897277"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2018 19:13:53 -0700
Date:   Sat, 21 Jul 2018 10:14:33 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Paul Blakey <paulb@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [lkp-robot] [confidence: ] 499ac3b60f [    9.040615] WARNING: CPU: 0
 PID: 1 at lib/debugobjects.c:328 __debug_object_init
Message-ID: <20180721021433.GC12513@shao2-debian>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline


Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 499ac3b60f657dae82055fc81c7b01e6242ac9bc
Author:     Paul Blakey <paulb@mellanox.com>
AuthorDate: Sun Mar 4 17:29:49 2018 +0200
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Wed Mar 7 10:44:03 2018 -0500

    test_rhashtable: add test case for rhltable with duplicate objects
    
    Tries to insert duplicates in the middle of bucket's chain:
    bucket 1:  [[val 21 (tid=1)]] -> [[ val 1 (tid=2),  val 1 (tid=0) ]]
    
    Reuses tid to distinguish the elements insertion order.
    
    Signed-off-by: Paul Blakey <paulb@mellanox.com>
    Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
    Signed-off-by: David S. Miller <davem@davemloft.net>

d3dcf8eb61  rhashtable: Fix rhlist duplicates insertion
499ac3b60f  test_rhashtable: add test case for rhltable with duplicate objects
28c20cc73b  Merge tag 'drm-fixes-2018-07-20' of git://anongit.freedesktop.org/drm/drm
89cf553533  Add linux-next specific files for 20180720
+-----------------------------------------------------+------------+------------+------------+---------------+
|                                                     | d3dcf8eb61 | 499ac3b60f | 28c20cc73b | next-20180720 |
+-----------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                      | 0          | 0          | 0          | 0             |
| boot_failures                                       | 78         | 19         | 27         | 51            |
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page | 78         | 19         | 25         | 38            |
| EIP:note_page                                       | 78         | 19         | 25         | 38            |
| WARNING:at_lib/debugobjects.c:#__debug_object_init  | 0          | 19         | 27         | 51            |
| EIP:__debug_object_init                             | 0          | 19         | 27         | 51            |
| WARNING:at_mm/page_alloc.c:#__alloc_pages_nodemask  | 0          | 0          | 27         | 51            |
| EIP:__alloc_pages_nodemask                          | 0          | 0          | 27         | 51            |
| Mem-Info                                            | 0          | 0          | 27         | 51            |
+-----------------------------------------------------+------------+------------+------------+---------------+

[    8.895900]   Duration of test: 593133413 ns
[    9.027319] test if its possible to exceed max_size 8192: no, ok
[    9.037926] Average test time: 554321718
[    9.038814] test inserting duplicates
[    9.039642] ODEBUG: object is on stack, but not annotated
[    9.040615] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:328 __debug_object_init+0x228/0x3e0
[    9.040615] Modules linked in:
[    9.040615] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc4-00130-g499ac3b #2
[    9.040615] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.047343] EIP: __debug_object_init+0x228/0x3e0
[    9.047343] EFLAGS: 00210092 CPU: 0
[    9.047343] EAX: c16719a8 EBX: c0080e28 ECX: c103eae0 EDX: 00000016
[    9.047343] ESI: c0023e10 EDI: c1fd5238 EBP: 00074b14 ESP: c0023d60
[    9.047343]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[    9.047343] CR0: 80050033 CR2: 00000000 CR3: 01923000 CR4: 000006b0
[    9.047343] Call Trace:
[    9.047343]  ? bucket_table_alloc+0x70/0x170
[    9.047343]  ? kstrtos8_from_user+0xb0/0xb0
[    9.047343]  ? rhashtable_init+0x1a2/0x2a0
[    9.047343]  ? rhltable_init+0xf/0x30
[    9.047343]  ? test_insert_dup+0x41/0x43d
[    9.047343]  ? sched_clock_local+0xc5/0x190
[    9.047343]  ? kstrtos8_from_user+0xb0/0xb0
[    9.047343]  ? jhash+0x130/0x130
[    9.047343]  ? my_hashfn+0x30/0x30
[    9.047343]  ? test_rht_init+0x2b5/0x55f
[    9.047343]  ? vprintk_default+0xf/0x20
[    9.047343]  ? test_rhashtable+0x409/0x409
[    9.047343]  ? do_one_initcall+0x3f/0x1c0
[    9.047343]  ? parse_args+0xe6/0x370
[    9.047343]  ? set_debug_rodata+0xa/0xa
[    9.047343]  ? kernel_init_freeable+0xe6/0x174
[    9.047343]  ? kernel_init_freeable+0x100/0x174
[    9.047343]  ? rest_init+0x120/0x120
[    9.047343]  ? kernel_init+0x5/0xf0
[    9.047343]  ? ret_from_fork+0x19/0x30
[    9.047343] Code: ff ff c7 43 08 01 00 00 00 e9 d4 fe ff ff 8b 4c 24 0c 85 c9 0f 84 a5 fe ff ff 40 a3 ec 06 f6 c1 68 74 19 67 c1 e8 ee c1 e4 ff 5a <0f> 0b 8b 43 08 83 f8 03 0f 85 92 fe ff ff ba 83 05 68 c1 89 d8
[    9.047343] ---[ end trace 3fb7737483abaf54 ]---
[    9.136072] 

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.16 v4.15 --
git bisect good 1388c80438e69fc01d83fbe98da3cac24c3c8731  # 16:06  G     18     0   18  18  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 98577c6aa2cddf73d55b6f1e2825a1f333ea1723  # 16:40  G     18     0   18  18  Merge tag 'chrome-platform-4.16-rc4-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform
git bisect good efac2483e8f289cd879e750075e63a9d16897e65  # 17:12  G     19     0   19  19  Merge branch 'for-4.16-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata
git bisect  bad f1869a890cdedb92a3fab969db5d0fd982850273  # 17:31  B      0     9   24   0  tty: vt: fix up tabstops properly
git bisect  bad 9ec7ccc8f4f89843991cf692e89fc1fcbca85c83  # 17:59  B      0    14   29   0  Merge tag 'drm-fixes-for-v4.16-rc7' of git://people.freedesktop.org/~airlied/linux
git bisect good 76c0b6a36a1239494a5ae3c0dc83208a8112c483  # 18:36  G     19     0   19  19  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good 9ce207880d8e4b20b6c1bcd82c749970c2b9e6d2  # 18:53  G     18     0   18  18  Merge tag 'mmc-v4.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect  bad 394c73d396284897207dbb1bad2a43e621cb9dac  # 19:09  B      0    13   28   0  Merge tag 'modules-for-v4.16-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux
git bisect  bad c4f4d2f917729e9b7b8bb452bf4971be93e7a15f  # 19:30  B      0    12   27   0  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect  bad 5a9f8df68ee6927f21dd3f2c75c16feb8b53a9e8  # 19:44  B      0     5   20   0  net: dsa: Fix dsa_is_user_port() test inversion
git bisect  bad 652dfb2b31b076153c73106863a4a57e5318c152  # 20:16  B      0    19   34   0  Merge tag 'wireless-drivers-for-davem-2018-03-08' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers
git bisect  bad 17cfe79a65f98abe535261856c5aef14f306dff7  # 20:35  B      0    18   33   0  l2tp: do not accept arbitrary sockets
git bisect  bad 89036a2a9852f70dcec97d5962974fe806828382  # 20:52  B      0     2   17   0  Merge branch 'for-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
git bisect good 25b5cdfcce1b57971840505dfc78556bd12dea6d  # 21:27  G     19     0   19  19  dt-bindings: net: renesas-ravb: Make stream buffer optional
git bisect  bad 803fafbe0cd522fa6b9e41ca3b96cfb2e2a2222d  # 21:43  B      0     1   16   0  fsl/fman: avoid sleeping in atomic context while adding an address
git bisect  bad 499ac3b60f657dae82055fc81c7b01e6242ac9bc  # 22:20  B      0    19   34   0  test_rhashtable: add test case for rhltable with duplicate objects
git bisect good d3dcf8eb615537526bd42ff27a081d46d337816e  # 22:45  G     19     0   19  19  rhashtable: Fix rhlist duplicates insertion
# first bad commit: [499ac3b60f657dae82055fc81c7b01e6242ac9bc] test_rhashtable: add test case for rhltable with duplicate objects
git bisect good d3dcf8eb615537526bd42ff27a081d46d337816e  # 23:12  G     59     0   59  78  rhashtable: Fix rhlist duplicates insertion
# extra tests with debug options
git bisect  bad 499ac3b60f657dae82055fc81c7b01e6242ac9bc  # 23:29  B      0     1   16   0  test_rhashtable: add test case for rhltable with duplicate objects
# extra tests on HEAD of linus/master
git bisect  bad 30b06abfb92bfd5f9b63ea6a2ffb0bd905d1a6da  # 23:41  B      0     5   20   0  Merge tag 'pinctrl-v4.18-3' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
# extra tests on tree/branch linus/master
git bisect  bad 28c20cc73b9cc4288c86c2a3fc62af4087de4b19  # 00:06  B      0    19   34   0  Merge tag 'drm-fixes-2018-07-20' of git://anongit.freedesktop.org/drm/drm
# extra tests with first bad commit reverted
git bisect good 0f03cc902101ed1df7b09968eb0d7fa416e94519  # 00:30  G     18     0   18  18  Revert "test_rhashtable: add test case for rhltable with duplicate objects"
# extra tests on tree/branch linux-next/master
git bisect  bad 89cf553533084a35b44f533d59198497d3319d69  # 00:51  B      0     3   46  28  Add linux-next specific files for 20180720

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--adJ1OR3c6QgCpb/j
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-intel12-11:20180720221835:i386-randconfig-w0-07180254:4.16.0-rc4-00130-g499ac3b:2.gz"
Content-Transfer-Encoding: base64

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
+b9qOWYgAQA=

--adJ1OR3c6QgCpb/j
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-intel12-10:20180720225906:i386-randconfig-w0-07180254:4.16.0-rc4-00129-gd3dcf8e:3.gz"
Content-Transfer-Encoding: base64

H4sICAATUlsAA2RtZXNnLXF1YW50YWwtaW50ZWwxMi0xMDoyMDE4MDcyMDIyNTkwNjppMzg2
LXJhbmRjb25maWctdzAtMDcxODAyNTQ6NC4xNi4wLXJjNC0wMDEyOS1nZDNkY2Y4ZTozAKxb
W3PbOpJ+3vkVvXNelF1LJngnpzQ1viYaR7aO5ZyTnVRKRZGgzGOKZHjxJb9+uwFKokjJsROr
ypZIdn9oAI1GX0Du5fET+GlSpDGHKIGCl1WGNwL+t0mezqNkAWenp9DjQTBMwxDKFIKo8OYx
fzcYDCC9+9sXwI8yUMTnK3yMkuoR7nleRGkC+oCZA6Wf+3pfUZjq9BeBFvihzaF3N6+iOPhX
fJf1i7livIPewvfXjNZAGyjQO+XzyKuv+sx89w5+02A6nsB5HsG/qxhUBVTV1VRXt+BkeoPX
zG6L9Gibh2FWufjDgvPJJ3iI4hiqgsP55+nRH2dtem6rigvHo6tpP8vT+yjgAWS3T0XkezFc
H41h6WVum0mQS84vS74E5VFpffpbt5xwHoZfUQoay1eBOaHfBQsJLOcFz+958Cq4sCtb+PNw
rN1VZikBC3+mq8SpdsB+WraQhzRwTTi69dNwEm0LLvwRXMDn1cKFaJGkOS2tOF3E/J7HtOxK
vDFoM1x+ht7ZI/erksNpve4AlbLkfonLxAUPv+87g5p7SZAuXQi9osRVHZUQpEmHajqm7oE6
sBESJU7KTvun45ELv5+NP8G0REwvD2ByAr1I15Xzz/C/MBmNPh8Acxzz3YEYLGADpgzUPgNF
P1TYIa5HvQ364SnD0YmKNMcBoZ7wwIWLP8a712GVBR72vjX8q2FvaBYMh//cO/ISK+fL9L6J
5W2w6qnbraWSPcbhnGVhAkPkFuqJpuBx5uX+7ea2ZNllgyZHNy6cpEkYLarco/mDL0rf+urC
n8cAf94AfDrp4x90rjsz56NRDHH8yBSi1d4zOBp26OWsDbsi7cnLWRs2JNzJGqZVEgi+8aRf
itnyyiaA6RkrAPyJ84A2NkO7S1S9rMzvvfhdBxVgmfmo5aZnKv3QnFv+LpETWmkMvJx7hRA/
Th8AW05z2vnyvMpoKtqctGoitPc1oRSnYwVIZNXY3edjD3eYmr3MvWWWxlHCt3sEzhxpoYi+
c2CmZnfWyvH1BSoJNqLopKsHUP8Wujp5f3N0/LGzfzV45g2e+Qt5/AaP/xwPboWno+nFelCY
YdtzOSi4OPydg3J0MkGLcibcDqkH/i3374pqSVt/FOIeKxZG7WR01rHkv56eTrZ3sXPT1hWg
X0yH3j2O6fHVyYcpvNsLcLO91ZwxU7UFgKYQAKsB4Pjz5ESS17TizvpqTwPn+NVuQLckm6V3
GpDkr2ngtNsDRRFDwHTtpNPA6c/0YNppQJFjrHfsm+Q5moxO2r02LMljd4dVkr9GqA+Ts868
GeeyAc3uNCDJX9PAx5ScPCGYFwS4mxTYXMi5IGqz1DZKUKNjvPqEtW8AvfWdGqDTqGba42P4
ePXn+GwM3r0XxaT1nW0YVk2R6UJT4oICfVg5SF3qF5H5S8+FYOnN0P0vcUtKq2JWb5+9OFqi
07Di7Ih9d7/s+3Hq37ngZxWguVgWOSguMdDgHqBDES09MrD4WFA+A/GpIAuNCAXoc8PUA5wr
dDZWFx3BG6yVYC3QhgSA4Qm6UfgFlqHZtmU4NvhPfsyLTs+JuUir3OduE23pFfgf57v1Ebu8
hKLHzA90letBGM4PxKMoiPkswWe2zQxHMRym2xoknXb/g04Y+WYLxOlO2mWaL1H3YFf8QF7F
Lqe6jTJO74VR/U4tFaWXl2LH455/CwkFdS16aYjrTYoIavG60omHeGtneNMSDz8O3yXeszD7
Q4c2zAj3ZuKWwaqAVH5l1K6SFUiZll6ceTRB4OiaumNt1dNEI+yChUZHkFM4GYixRjFwsf6A
T6m59rmrLXIhimQ5gI+j8yuYe6V/62qssyfXgDCvSqiStUlBjFrSNodcfcKGBTnGEuSUh14V
l7sN5GTcv4mWSDW6gkmal7QgTKUTc/+ENa1ZiHp2OR5Bz/OzCNfWF1qQGDuFsfhDJ6rEW+xr
xyqNroj3i4IOtZdFPrKSZVplFJh1sCWEiN7w+fvpCJS+qu0WZ3R5M5ten8yu/riG3rxCVhzZ
Yhbl3/DXIk7nXiwu1JV8XakSHKMSQx4SBn1A+irzaEHfAhC/R9e/i28xUqNTWP+8xO1LfbVk
RlMyA26jxS2IOPPHwrFaOK0lnLFHOOPVwjlN4Zw3Ec7ZI5zzauHY1qTi1VuI5+0Rz3u9eGxL
PPYm4s33iDffI97174q0dvMnwGg6z6Og67G8WOvZntY7lu3FiNoexM4KfzGivgexE62tR8h4
wxEy97Ru/jSitQfR+mlEew/inn0BeZwfj9Calr1A4TbE7A3H3t/Tr06i4cWIwR7EjgvwYkS+
B7Hj7L0YMdyDGO7xHXDooTc+Or15t04P+VtprigJyZ3ZlWdpxHVRQM6Erdimp2IIMPcKLrxx
Huz0F4plNk9T7NJRjPEOCaLCyeQTekhottMyi6uFuN4TtUlvgeI2cvFFGqa38go6xnQrBcys
tatKGWSZV1l7WmIIJicjdKPuI7/rbx2jzCRs5uXefZSXlRdH31GeO54nPAYcrR2p0K2IJedh
lPCg/1cUhhF5qu24pRWvrG63ghXmMMUxHUdXNAxYmLMjYBEO9izjuU/lk8vrGY7n1NVUSPIZ
3qJ2Z/OoLDa3EL5wxQV51OKqY8lXeGfLOQ+ouKLppvRNDylc/NcqOwYF02zL1G3IFQhUxzBt
qFBSS2Ud25chZ99DRfDd59hAkAyxwf/RsfPPoaAfSVEF/med/CvOUB18eMVT4sPkXMy6iIV3
RatFyb24RLd5K15mhhpalt/hOK6iGINv4fvHUVGiRi/TeRRH5RMs8rTKSH3SZABwQ+EKrOIV
zbA7vuKF1Co/xaAEQ2rKQKICoQoOD1E/D3NviYulShazkuYy85LIHzJZpxBO9FD+LJ6K/NvM
ix+8p2LGE5Gag9yXufkB/hBzjwFnHM+on2lVDnGRQMLLQRQm3pIXQ4WSAkl5N8CG75bFYoiq
LhvsMyjSsCQdJ3WrhUiW0eyBwpwgXQzFTUjTrKh/xqkXzFD8ICruhirVRJZZub6BE5/Pg8Ey
SlJUy7RKyqFNnSj5MhjE6WImfKYhbg+yGMNn61JMXQwdluWTgoEzxsdSbLoxVQ4Yzhp2rEG1
uXm/8IaJjNvyBxrru+Ghz7PbsDiU1c7DvEr63ype8cNvlZfgcPURmsdMPYw02+xT3UZazv4D
mheL2Ypq6IeIVBUurraS525dQJ2bzDA0y1DNeaCrYahanmKzQDcDTbNsZnJ3HhXcL/vE/Nhn
xuHgfkm/v/dfitCnYqpiqYqq6oZq95njtqTu4848R6H926GQ8VDKCMdXVzez0fjo/dnwMLtb
iA48PtvFhe/3rcOXSna46sr++vKO+Sd95Xk4KG6rMkgfkmF3SyE1d+UXSG2HWtu7pTGelJTg
8vxbDrdecVvns+m2sMom9sGEXpoHOGuAXpxqqkzX0TEpebHDXUd72d+PpqkW2rEVGoZjTGM4
N3vQGul82jxX6fzghSUA3uDhz/GMZJUk+k4mCTeH3zpDOha5JZLfMRT94lCzLNVWLhr7Zc9g
BrtY7X909OAANNO8wDWE1gWDJ2YZdJXWV46uX4jyzAFYqm5fwLxAC6lblkVUdf4Dpb+gDGd/
daMzRPXeu2q3zoHF3hParh3ZOYAwekTXAUBuqYFmkcvQX+2vdAHQU23cd+6OO60BGf6ZVBkJ
oIsnNYDNWQ2gO465GwDgfin2JgEQWLbIzdYAWshrADA1A8a7AdBPIhdGAEhPpwYI6kyvANBQ
0fYAAAxEOVkAMGszBj56E0ENQDO0rwsIQNNYAxiK5XOjBrAYt205iLiBPwNQ8seVBI0urNFA
atQugBOqNZGqRiGUt1FB2wa6aFSJvk0TdK8KvM3hzwmgVwO4HSTiTEy1rlcvUTsHg8HVXcMc
MAH9IeI5FYLlIZGTTxAts5gvccaF29uh/y+iQeXE5e2X9eopIMRtbOVnDdGpQu9041cN1d0o
SAxi64UHL6dqJ/ZC7sHkpBAGbcW9nbv0uy7kDXoChehC1/RJEnyGXnfwV1UIyRc8XXJSbPKB
qJXQw7EscY/1wiFDw9fsQhsLO4sxx9QFVaM4G0mj/BvaO8OkIgIXCo8+RgDydtPzkwDUe0U8
LT30kQ/QeubBcONDomOxvmrzrg4+fRHb+NdVh9tkH9ExQZ8o40nAE/8JECpCLU5zKudnTxhC
3ZbQ898BLiETrlHYDx5ap1HiD+j/IoVxGide3salE1Tjo8+zj1cnF6dnk9n00/HJx6Pp9AyH
A+znqGdIfvPBhfVHf5acwC/O/m+6ZrBxue5iEM1/OJp+mE1H/zlr4m95y7tbOLu8uR6d1Y2I
/epHHCcfjkaXK6nEfrlTKKLaJdTONlaWfJUEiFuTR7GoC7qpOWghOsy40oFcYXTZ88ovV2Ah
eszCDUQ9ZazeddvMV6dnx5/eo/vA4xAfl+jdFkVXm2TEe4JOJ65/NCsUIAtPizWzqU1aJkPs
o/FH6RUUaJJ8slthFcdP4PnfqiinwxLk4aNf3G1zK368zXj5C0EjU01F101rK16UzRCybIts
Z4n9W0TkEG4LpFpfRVLBhelDhP49WajiaUk2BB370eGVMLMywNrw4dpyvsIZrdB1wYLoUB/O
Y6/EaEhmI5hAoMcN8TTFtNbLG84eS8pn4Li3XBZDUTVs4xJdndHlexhd9WXy4/r3BpZhabo8
H4IEsx0EpqJgYyJ8okIP7iAYCKUlWZtEnHbakFqK6mwVLqY4gBjiCbsqvYWeguFR/584JTyk
b8rQMDQo2HMFjsTxL/xxivrmNovajqJpP0ZWJbKmrJCVHyKz2vP7AbLWlll7K2S9jay/FbLR
RjYkMvtlZLONbL6VzFYb2XorZLuNbL8VstNGdt5qnJnSWSrKm2F3lyF7M2y1g62+1WizzlJk
b7YWWWcxsjdbjayzHJnxUuym8WXmHuu7i9Z6Ba39Clrn5bTqvt1iFy17Ba36ClrtedrB4GY0
Prt24R4fp/lQbCHEz4YCgA1VcalSbg+v6buNURa+i/MnDwCD6qjmQFPRLn74vgnLmjzMbvkx
CNAXCboXn9xRPZWbtm7oRtDya3RdsRxDZY6K8XvDsWFMYSoGGejxz6mYgQoa8NgjtzLNoFfc
RVRMeCcPUJcUGVQYIIJhG+rANOA4XaTj0WQKvTj7a0h9xC42tFVTFOxVFgUzlMZdnbxwhbsN
S/QxltXSBa1RDaXcNvuKK8avckoIn+fekj+k+d3qxCoVEzbUuqIadCyoSspnkkvok+nr3JJy
IJtvZZYwvKaREFBZGv06nqnptgjfXJis3q6YrOPx0anbyKUzS9GwHx/pPLtM00Y3H483DeoX
x9SOOhZfOn1teG3hjzV4gx/xHgB7vwXhoCLgoGeoq+i2/6GCu75Y4qgvPHkav84lyaWzzCJy
NtHFvUVHuJTHf/+BDxssmzTYfzcbc3Cgz3POSd2omubF6EQnHtm8og5JMBBRLtY8qqpb2qoe
F29O3ZTiqA5la8U552LQ5vAbit3gwLBrQ6mvI7FYmAhcAKUHQzA1nNZGWb1BuD4ltKLVTKap
zrOkuIJQ95uvFG2okE4i7W8TSZZi7aiW4jiGZhu7idY9xtGXTZK+Kk4z+NxioASDsDtQZJwS
EQUaK0MbkCBkrXaNFLLdpqhvVFZt8VJbA4VSwy1eXNmNoia2qrhUskV9OkmXS1kXbCSseqG3
jMj2odU7EJFQLM5iHQBGXBnViMRZxc2CU02monQTnotibOJzOKMoDZdAlRRVlqU5GeJLXs6r
HGWnfgtYoA0U5+lTfUDsQCRVHjxUfhHmFRhJxU+NrthMY62M2PS5lJjqaA72nQ59rQo+rpBT
4oOfc3oFRMZruEOF3mZl9TcZJTSmym6Y5i0K8bH3iIuhc+eYuaYySxfT4MIxvaNDC6PKMBjF
vTCgE60iT9dcH5qmM0vmoVgnDzW3Ak3VFC7zUNw2bNPiG83UdDTR4u0Qd10Y7pTPN9loDW1w
rWD1Scrf0FaRRHVW5Lcdx2ZaGfpO3qd1mJdtH+ZV8XrT+R3HeSUIbcCdyHrTlIHKbTxbN+3Q
7qibslXdVDdYs25q4KZqrSctrSgdh20wMUYH9bGADTWOudlYaWPvkV7EEmqa4dTJaupGrQw5
6Gt6WXRNQ1A3q7GQL2KJRGWP4cgZA3SIVrv/Zg0aFu6j9B7YfbnMQmxm16ZtOF1f59dr/XXa
RrUMypg3XByTicxKWJX8cfduvqli9dUDubm3NnNTVRUc02z14llBxm5OL/2Q1lBCDHZlxExd
NZtslKdeExcdakNs5GjacOOlSlHOtwZw/aSo5rLWu2G1NA1ZL89uXLheJ6XEm3Spn8YgbWkz
u2w6qGZfgTwrUbClqjl2py9eipUpdx7Lt/BIh30qOfFH8gnIwKwtLJo81Iw1Kk6/hXKgMtPU
rM6vL+igUkJvJnkBDvOGWlWNdRKQthJxeIfOluxIrFmaRWqNT11BIt7Go5eeaNPJH0Ry8HGA
LgKHzI+GCfYjLagQ8pRWaBzRzEYlXH7e2DVLrpNtwE3GcoCRtYzVvJIULzDoLB+9IkeiNmqr
lpw2gSMdlO3DQaJTTBgCOvKDK4nW1Jrd1hTatj5UC05u26bnKAKqyzg6FgcgxDtUomTQ39QM
lNaRZ1vXyHn286esDFy5dLJq9i3mSaNUshHdNsR01S+3iLMqs6vpqIdRaIUr5FSc8NmsAtsU
lqJDvvFqOxyW2LI6HPTy82x6MiGDyhMa8MZis6VD+0wzR4sFjhNVKDotOoblaOvjcuQY4pBR
zb5d+0DvRtVXhL3aPyhgqsDUaMBZIsCQVHJ264NVNJ9rx3MV3W/4bIXcz4ZSSH8pjwKcy4cI
7cFDXQ4j7H+QomIoit1Dg3IgXt7+u1RjPy/+LpQ75yQheKh+jXbQU1PXr53V+V8V3k/OCirt
zYVvptDBf1DOV1yMGaazOfGOun+Nlp/8ARLuC97Ahz20WB7ldsmcfpHn5/6ftmtrbhtX0s/n
X+DUPIwzY8nEhQDIrZwqx44zrokdb5TbVirl0oVKtIklryQnnvPrt78GSVASJdtzHD0ksoj+
CDaARt/Q7IzHMS1dSpoONE5IYxcX5xfJYaLzhJQ6GqyjXNBiqpn6sVd8hl60+BSJXWKyLcSV
ArR3+Pzy/NWby5NXb8+Pn/xXqc2wKt+7OItQPtFt/QAKHpyEjjg7O3p1fnL6opmqt0+68vTX
ZbkgSbotEUMZMUNWl/CChFxBWuQI0RPEVcM4dmMXMoU9HZTNcaabB8ZRd+KyIzWVzS0a38vG
5ZC3xASkt/O+KD5OZqI89IGDHsOxK+dOZKSSrGI9AGwUUvuwuW6A6bAF3QOs7YzxoB3UsNi4
P+hKAuJg3A6a8uS7D2icu5Ha0sph6poyodWUi49Iz8yJD4QdUkkTUlT6fKYCgY/mKHoJ0bCC
ISOGC06gTQzZwNCkDLkNDBkxZBuGhM1fYxhdTYA1DBKR8AmhR2Hkh4p5Sv81WGFIUsk28m8k
YYd/idPj5wLxt68VoIyAiRzzyMuxawBmrG89ANBEQD22EQma3MOQfKNrLnTNNbqWEuf0gwCH
ja65Ztdo/m0yXdcDJ3GfzcH3zQlEan66+XiEUXahurENy8vqMZTmPpkLHPhFbQLDMjwipknL
lNxEdAHRJW2IvbNnEdBptd5FxXOclojJpYQc23hMvbJOrOSNdhOjMZ3Cuh+HRGhe96NS/afd
uzFZLW3adgeWj1gkOBoyJGmei5PO7uySTpowRYQpWrrkvMmSNSzdECVJUrSwSK2wyKvNJazb
WVQMhrE/o5Uz6JK0Lbgwt8LEdVYWChnSeqvJFXVKrs8evY0rPvZisMkVlZAJu/5EJkyc/tiA
K20TRza5ohJfifg1jA05NExMeBzX6AJc2+tzxaxxI84VGefKyhlKRVviLhjV5EqcvgVXpxgL
a5BptcobUhXcOm/SB/JGt/Qq3cIbH3gzaHRBu93kq7xRkTdqhTemZYTSrbwxkTduG29So826
wLEP5E3qN+ex3cKbYeBN86FIXm08lN3KGx15o1d445KdMGu88ZE3g228cdgw1hDdA3njQ5xp
E2OTNzKICNkUEb5l2rmtvDGRN2aFN5neHCG3lTfDyJvxNt5kGe33a4j+YbzRSUuv/BbeBHkj
G/JGJ243+Spv0sibtMkbDatqfQX4bbyRUd7IbfJGK2X9+raQPZA3ym7O5mwLb4K8kQ15Q9Jq
c95kW3ljI2/sCm+03wmzxpsob+Q2eaMNzcV17bf/QN6YdLNX/S28CfJGNh+K1Ied5Ku8cZE3
boU3toXF/a28ifJGbpM32hqbrmvLg6jZqLQ/aOGNb+q42rYsisE2zWbs48PR10ZXvHJatVh7
ZJufvz07LMsbxObYRpr+jdPaUfNyMv0qPr48//Pwk9hDXptIxW8yETJGkjTpUam/g/zZDnKv
o1dtC/lRJCfq35rk8I6nd5Af7yCHM+IO8l5F/lvWIEyNWxcTrBR//9zvzwd5VcRN9BcCkQLx
7sVheQgwYmDp7sKINHDLoOLUqMCRiMXTyex3mgj7sx/T+jsHCJ5OG6XdcAPTqrlXNyg9L6j5
Mp99E9ezxWLSKHimM8cbYNV8NZ1UZz61q247zkyFrw8JOmtePggYaLncHHOTMwYuEQe/5JJX
pc/VmtWEWgTFVBKLtvEJDq68OLgZj4v5fYqWGWjr/m6MRpVBloKrGKmGwbASiQk5q2QQUscb
F2IYLVKTNUYS591JL0fxvq9kZc6WNDlG+P/SdknbiW2dRVpsaIvr98uu2JJcgZ/gVz7pdY4A
g0oczXE0MkkdxM70mtbA9CKMIkIpsQVO3XALUcqSCxyohaP1AvkvTBFm6r44PV6wZ3GAcwah
JGHsiyTRm0UkeS8kUjZakFKdNZDUvZDGsg3JKTYxSiT4JUZXfaHi0EuvTbLS4h73cm3PrxIO
OlRI5l5IphVJGdl4/vReSLT5tiAZnTaezv4HSDUn40zKy3p/bv0MtLHGYbtbWVBc5uX6aj20
2RrYXAtrkgmMiCrWw7RxE2fa3ceVx9Pcw29sbMbpEttR0ns4jI1LvGvbmGsU+wBPMe0/Vuld
aO4BLmLjjIdn5q6gqIoEPoE3djm8vsS55GJ6ifAFiupcspxqE1YqjdFjuS8kWfd+XVq5zCf0
WG+OLkSxAP1kAQHbBsfCrsJDMBpFE9fxvNTwggFvQM98NxCOU3qkRG0gaekNI+XijxplUYc/
EIRpdjnIYtwT3xo4pCrSyn17fHEnk+ihlEndhkj3aZZKhui8nCzbd4Z74TgDnDtD4ZHAZ55G
/fXF0QoBDnWPxNvz0w9igQMfSxS5nC44BnfF8dE6/EMaPAuJdYib0fUuIqlglq0T0ezbRUTz
K2snOj/pfTdd1JUYfh1+6U+RqbcDSFu7rphzBOQlSuNxHuhkjmg/KTcHUCMZihSLKIcyk9nN
4AV20tPTDzqPZ1kuyDSYQDspvhX9RREBrGpxohPAYUg24Whr71Ack4ZPD/SZsxX6nKfQ6IVL
XauL+t1kVMwqZZNzqRZf+iQgiF2vX52t1mdtlDpe9amajGZlVqp4Ry97KFaE+bZf5bKScle1
JZPewkh+O0WaDR/DJI1j3r8aL+p8KolEU5rpn8TXOmFrT6sn4TjXZ04EWywF51jhVNfySy6c
MaVIEd+K8bICSqX0sDOqREq+2SimT9KKUn/WjckmwnPUBWO3FopFThr9YJMyLWpRQ5DCh/u9
+VKEjBAu8XHFwXVarJwVOigamQZdbno6xzlUYvsc9dVpGGlzm4cS5YGCOs5HNuuDmLiVspbW
xnl/2SuuJqJ3dIv6A8ecnhcbaYt9cD686SAlJe90OijjPOcaiWBjLqbEUJIWKM4w/TEnsUJf
FUqmDWaL4qkU60flgZpK5wPqkhbODZJwjjAu4BpOf+JelwGMj9JFykzpZn9aW4eqhZWqylQa
ovNv3C+VHsbKA++XKm/SmDe3KMq6EbTAbxZLLtTyFxID47inxkPBxeLD7zhch5w1Ar665vIo
T3XCegtL5qfSkQkCgVn+HVlLOjlYO0Z2A58v2zskNSyWxK9Tx6ktGZJplcoyu/o8v+R1sWeS
3UtFq9al4pIM/oM/i7+Cw6Ifz+OtpxqhNRngsMBjI+IJZjsZWeLX2zTJfm0lo42ZtmX06vJL
cTu6Qb4eji3TQjUtKV8goQ2MJOD632EWg4KXKu234PPekzLZmrPJOuMJ1gxOctf1GIFADwoe
g2Za3C5B2DhSWn4kdYk0AtIqWcUwxgnMGM52iAPvFVkJTax/0yLeAJRGK4MDFYxF30wrFunG
qsTiOuPt/SI7MfNmV79UN1VOwvTlAxavQ7Eg8aZ3tGKuNtKg8+rwhUFKckTxpu3IxcMOW1gU
YjXthy1IOutUxH77xCauGpvxZN7GBNIfk4RG0NjdPPCJl1jGcWz6YZLk//iHNyjBHDq6j5zd
FupMY2TX/9497xa8AlYmHJFKmXh154Sjpl7iNA/1SPBZ6LZu0dYIPeqOCacyeFwdY2nlEmVb
sZyW5s4JJ4Q2spxw2/uldIpEjF0DRx/owF5nd2Gl0pr2gYOp53cPnKItGBUKbsIuPoeWHJRk
Foak8xVXT32Yj3BBPU32aZMjeQ7RXYli4FA/aNTegIg0psbvPklRieJwNMINEKZIIP7qLmTI
MuBiFW/mfcjuPpdfuv5GikAuuBZNMXrKdPuhP4vqr1KPr/7kfnf+l8TkIvYsS62GovLT4L2C
EiPEMdEu2x5Rd5PEZ5q5cFxlgNUahXRZkhmvYjkxzae3MltxU+aN3x1OKW/lpu5KbVIoDT/l
cTUyHTIoUj8NPpPa3sFNZSVb9W3cVNRcpzZzDW4qqzkjKXBT5Y3feVvewU2ToNbbT3tcEsXO
/zxuGthT6g5upolRMNlbuakzYy1qw0wb7VMj67mp8/i7ZQVrBzdJ1ChtftrjOtrr0p/HTUd8
UMkd3HQ4LOm2cNM5l9KGnTS46a0xptTxkLI7gUpXhhhg8xS3Q5wMqKQv6pAoskJm+/WxL2CQ
NoroFD0zErsZKxwCUdqm3vrKpERbUtNcGL0ys3x4M59z7Yko+ssEVs4mlolYfoHVU/bZdR3q
PhBGJLikFn2xl9ndujRMrnVdmuBId1SqDS7dCUeCaFM1JziL+mslR7VUKeJCByMMGQxM2myR
ZT2j28ElV1F5rXl3j1RBKS6bNTFm16ubKBE7TXp2qe1QfyPL9uvDV/tAamys84Iss+miijEC
hEzqaiY0tXpcwiwpDQGuqjIOdoAySYsZAALHaaBMcHODOqFsNvgtrb3DbtMnu2gytOYyTNfQ
KKSl0yT6XVx/6y+R6xyUt6MPnt3f/Eev97xGo/0ejqD5YDkvikr3q6/SZodgJE6o85NKsUew
XGiGFsoUcVcMEBlGy98Dw5/gPK+xcuXdBK6bJcaw3KqQVBsSB4VGm4AonrQB6GzaBNQrgKiM
x+nalWx5Ap+oyzZQMuR1RhQTUVA6tUD9Flb5OMb8pKaTCXtxqs90Ng0RrRGsjfWbSMmR9OpT
NUzW2zmY9DSyN5wtjxKUraOS+Sw15qGjYmTm7codPWk6RrEy97dGxfpMrQM6xwkVn68ns8vJ
0jtIv5UoMbXJEokJPLm+mogrHHn4XNSOocoboLOuigQyxeHR04uzU9EL3gqOao+Rlh8ObXZj
Y62wuoFOQjgXb6f9UjpD56ZF8NcGxl7lPwa58Uj+5nu9r49Zlq8O2DjOBgKr+KB3rJR1xJWy
UChiuuy/I3nUF73qRGknIF/AIQbPk/g+6cMDczkvEFSvH0PSGjIadXiub2h1c3vx7Ga5xKHq
hTgoI08HL88/9P6n9+YsTxJ8v3j/+tk5vjNd+DeJmNbZmFrQhPxIhCefqoYqMRwY7hVzetpc
kLGQHNAcTpP6iKwRfLQjVFRefOnPg8u4edyUcLSX0CDKaB5XIYPjFRWMkls99mIPhd6fCrKg
cTbqctC/GdGfod7oE5zs6gu+72ENSUZSBWkDpIyQKkLqB0AaBZ/JYggv4yWmLs/a0uuIv6sX
yEWSlAd9uhhy+zgx6mXKjTJEof/oTz/zW6Dy4Izj00DVb+WB9KSbdWkVLyf0Cw5R+9r9Cltu
/nkyxc/RKfukniikDfJuwxUWyxPVe6+fiIvXrw646OJ5seT6CcF7ShOw+Q5KJTtffef8sEoi
B56VCJuVeKsF4GSWZR2uAled3J7TNGged/ZdKw27wbdnvlR1qjBsXGYmkGYwFcgcL++9koQs
iuUX6s0e/PBan/3x71yrDlnNT0Sq8tSgmVS5NnlqazAnOT9hK9h2Vh2FuiB1Oe8MXJYwjCee
JGaOcDH90ztQaIpEE4iuj2VgP//z2fF+GZrPz169/RROENpkn/4xgl9tsC9VhCYtT6MY9RwT
j+8gCEKE414bpJEuY1/ACt3h2w/b6OINEXmiZyknBDQG2fkxIeF0TGoHPPklG6qYWTdSorMI
tpAOZRHpOcKXW/bkV+863C9jTfxj2DMqiQAEHAfAWqPlePljRKLt/fGbSrxydfUjulKvJ1Jp
ulW1R7iZafqLvensB5cxfVoVMg+48OaV4vLwDYyK6eIbH5NE+R0FvX8wwxsem+KzUpIOmH0H
zMsV4RnZnTkLTWEyIIW6reOnzxy/6m76mZ493AnmzM2ysW8savHAgA7++whYHnuDtlt6l8XV
ZDFc2T6zrk6UhOyJdDROg4KVnvKnlQoCtACpdx1pI4Dm9Lgf/XExT73SbU/zHhcFrj7gkTSZ
lN6vIyPkNFuuPhM9EpL3uIDxU4lX0lE3n+IVuBGL7CQX5pqROsyVd9XLbros9Enwksx/HkmI
oeskf/fuISq8GAxtcnv7nyBJYnfKSJ7XzD1HWUouGjG8vkn57mhzWVMEkNhYqXDmfzHUbkAG
Qnj23tniSGj3jH6I9SEwgjPUh6iGG8xsjmYdrAQwwtSbwFGn2soNQdyIMFbB6UkPM54X/3c5
5fghydHzmZie8Hcx/DK5XhTLSOJT6MzU22I0yetNK+nCZqRd7MtyeZ0fHPz48aMb2nRn8zgR
FamYWUVd/pfk5ZfSYqqq65IVNZ99n31b7pc/hV/CTkt8+16wGdVfLlkPru+hlXMt9yi5+mvj
Xr9ygHS1qOXNctZppFmsNI/8p6kDL83JxYtDcfzq/fnLV4fHotPp/Cu2SCVOGnOLyRVU6fEE
wrcPh8Ltt8n09nJ8/bkPv/UVNNDuYBKZrK3GQagXF6evxOn56Rtxcnj68p//jNcdZwncmUwR
R9ooXrXlgV/xuqx6xpLo9OJ7FEKGFgOWBRzpuLCPfw3bqGcXL3v8cpPw0/IGuQysXzYCwICw
BrMqvAfumg1/sC9ezxxrEwTZcjVNPA7podZI+TaQ0qOflB+xF/cXBACgI9at3z1/3Tt9dU5G
HOkFSf0W4Ngy+Q8/j4kXX48IPJcBb3pzNSAO065xdhGUeI6BIf8yjfMv9R7mXGxc1Qz9JamX
PhJzTIMk8zgzWEWRUHD6NBQs7bZ/akobaq2UrekWG9ctkLk8TC13foGWusE0qzjdobwDfszj
O84Znd/G0iDQfIxvheCYZh0nQ7z567qoy3WhMSJ8a41fvumJ+rPSOCW1drPXEreXOCUkY1NS
YlZxBVdxILqQjcP5GXWerIuEjjaAdcILGtS6JBH7G2J7LxGNXW1f8b0Utblo9iyT8LetP4Rq
Y32W+WQduz8fIBUmhGMbjV3ia+ZwhnXjQdn9lsem0pm6rKJIGhfIeoMP93oyhTe4MkL3RYFM
8H1+idi+eLdH5h/M1dd7+L/H/1ZTYl8ch8tnzTXvdMZuFgDL/dps2QBWagO4KrjDwGoDOLVQ
ghlY7QDWmz1eAZYbwE5jS2Jg/aisyBKXlMDmMYF94qDMMnD6qMDKZNWssI8KbJSsWOEeFTj1
7FIEsH9UYJfWg5c1pxuXC2zMY/nAeewzVusYuP+YPUaMVZbAg0cFVhapuAw83LWk72DFxsrD
K0yrJT161B5brnTNwMWjAiO8VQKPHxU4M2m58uRjymNDW6UqWSHlowIrr8uVJ9WjApu0mhXy
MeWxSUjBqXr8mPIYIRJT8fgx5bFBKaVyScvHlMeGFBNZseIx5bGRcAJ8YrWEDF2UDcar9ZAC
mTfaeOzk/NJQVHPOVbxEFo7lS6Gwdi4blzI4q+hSqF2d63gp5W2LLoXS07mJl2xSAobK0Xna
uJRCe6VLoRJ7buMlJ9MAGEqp565xyalwKdRCz3285HUSLoVi5nnWuMRpGOG9leHBkngRGQif
yvdUhovxsckM8eVFVV5UjYsW3jBcLJkiI1eUVNDEcLFkSzS46CLnLOFiyRgZOaNQtLTWRnd+
xGg2LbqRUqemrjl7enEqzmed3pfZfDm84XT6IrY0Bm4nfk37ZVlq8qzP2bJiEYLIexlaJdIa
mqLJk86/9mSiicckdzJaZp0McX9ino/TD/kHqOs7649C6D8U3O3QPPzQTZNMDIv5cjKeoBTc
oqaCbmmQg15r6dffOT5TjOLLPlZe5UdEyOz29atmkMr9A6+bx0HG2EZL+KOqbPObKcf6V94u
lYeXV0USY+AxfY9sZPYZFMPaJCwJ8a6jXKQyVV8jWWp1tpsM0foOqrIKvG0JppBrAlgPfef8
Q6edOtCQ/e8bNFlq6aadxuejwEh/KeaF+NT8vaZJkxSW9K23B1dXuTjhQ2HweA9viOb97x8q
gQFfZfVuboRuh3LoD7gKS79pOhmyWTEO7w9fn5+ev8hD8WgpLuCaYIcn6s0ehPsdIL/4EvX/
wpmd7jBXlkvBF/zr78mtHTu6iy8aN8DLMFHkGg76Bb/CjwO7eaMFByNW74wCvblY/MCbRecH
Ca2EJVlnEw5Rb39F3S9x/aaWCw3+0Z+POAoavFP//fzsLbIwUEUTZdfE3oSm4skH8TsfIcG7
0DJLUpkrM8quTLqqI0ViDhJ5oBouF1I3PHyFz08v8rsY4C0S1p6fvDx80YMlquBdseXzxmYZ
n458fvihMnCNFP/P3LP2tpEj+Tn6FX3AAcnctRw+mo8W1nfnOM7gbjGbQTKD/TAY+FqtlqON
LGn0iJP79VfFfpCy2WQ70i4WMWKp3cUqkvVisVi8eQPfYM4Yn8ssubnGbyDFVVGR5OZt92Z7
sTQ0I4nAs9g3H//brpPhVfuNQaM/N9+o5PDmzy0Khy0kNYvk5K2hWE2Tm/bDO/NhppO6M0DI
R/NBWk0uWY5L/esPZJJoTAUCdxK+wcq9y2u+/sAxjpUzUzr1+kPWUCSnDg2gSYUpFL/ErZXS
LsxB4Wvc5kz+M9nsDVM+FMvPt5u7WX0L5S0WMoXJABcZJgP0vAVUGocHAPGisFuMQcN7lJHX
5n/7njZh/X4EuJH68BVhEdSFBKeDGMha9FscTMJ7c/ueIhlGlgwl+1tMpLoFLfkZW8xfY+kj
+yalmAJ4bW7mgbHDH5WUCmsgUNxmND/zRGeJku0L80TqRCu8UEMKYJqkyhPFk3nV/LWUCREJ
zxKQGkXxBUITwfAHAJnG2zIaQJ2A5hdVg+hPZA72bproaSJ4QspE86TM8ANgKKD5vMEgSCKL
hGjTpPkADXPrCii8G8Cov99MvHSPU5xMp3lZaQylZyWfzWo9aGGkyURs1Z+5fA4UgqP3dhMT
UL55mya5NH8w9Urr47OdpUVFjGrv00NdSvwVpZFUMnl8IOoecwWBMSd1we9HmyPgGUmMoePU
Az3d7ktTdXuz/5aMndKSsMy7aw9I/W09ta0wE5ysW/mlusd9bzCmTYlkTI5/WNV7bWZbY3cw
iUNg+qGdOqYFFrJtTRLNiD6VJknAmOiz0cS1CVSeSBMsWDk9G01ZnQt8Ik3giKCjex6asKIJ
yU6lCW/GYmcbJwUaH9XzqTRpk3t/JpowOxxGvZVOkGumInLN5ZMUUWwo13h668TOwRrCZJ2d
p3NMKMtS30+ToucTFpXl3KqDzfIbjPz+0xhwJ6aSb9vqK6rkD+B5b+8XK5MfUZ/u2Rf7w876
QErwjrZyj7OndGz2mG/2wJeip7MmrH1zdraRUsSw5ok0Kcbys6lfpTKzmjjMqi+z3zDr20kX
a3e/qepWtkoTk4B8Yh80VXWa4Vn6AItYnZ9Ok2bq9HGtB5IR/rubc1F9hdUZ0PLy9W66WL2G
dbzJnnn5+EEynn7BQ+WTL+gJY8ErU5wUy2/tzCN69S7bmWeUgs9fErkrCV0Q8nIIUdl5iaJ9
RFFDlB5CFKzdv58oLHIy6XJRBw2BOOsQUMr750WTofMiz0AUlsZtCKC0hygO8xIlCuWBmtuh
GD9NqrAVrKd6uv1rByo/B6+8+fXjIF6h5Pux1RmBUxj53EzFBiehrulbkZSmn1WWbov75W7+
MIgU+g/t+DmUFzJfzXvw85gfMQjR6ImhQkLPIblnJ+oskntuovQ/I1EniO7fjSh2goT//Yj6
Z5Q+dlbXgYmrNz0mSj/DbrITpM9oRUyXp4QPUorsFKlq8r0n7YfxHGvY1DUTB3kI5xDpbvjx
oomAOzl0+PkJjGqGH08EIYdO6vtTxKB54Kf6i8+ZdH6C0emQXQ1Fdg52vibvBiHLTvAo6rMf
+2+EbrbALcA/1ddhLJOxc7hUFHmX1i7V1ZuM1i5VllKa0gxcK5oqliqego+lRKpkqlSq8lRd
pepNqq5T9TZVN6l6l2qS6utU36T6XZq/SfPrNH+b5jdp/i694ulVll6J9EqmV9fp1dv0jUrf
6PRNnr7N0xuG3luWLhExSwd6cdkJ5ubZE8zVPxLZCfrp+chOXQUMQtYsYChWYvv+uGs786eq
SvDfcbNwEJedYUE9GNep846bsegQDMN2Hm0shyE7hzYejOwcwhpF1rA0dM2cdzzPmlydY1L4
QBOpzjFOgtBhyM7BARkhw5CdQ4MO7tk5NKga2DN9auwCkb2jwxhEn8PEvhnasxO8mdn9YjL9
svpYFZhnAh+3barJZDqzySaT3ZcV6sjJZtWmrPx83SSs/LtJVzHZKpPNl+2mHOPz+dcx3iI6
KRvAck/h8+O/DtETiubOPtH3RgAV56aYzBli/dCapjTLT9vCNq3U5SjPRJPMTE7zYpO8YpF6
NCInT+rRUJj5PMsoOa1b2IpQ/DzbVdAawyzTk2liVBDrP51MEyNKd62h6O2KefVoo5Hl/Ifk
c1On8lvyy82Hn5Ld4m5VLG0z3Jzhq5tBaR7Pi+USaxiP77bF5tOi3D1qlFPSv3vJlG1Zanqi
zGArubm3/kyDpnNziXHdWnPMHrE+6iFjkf1ZaAvPFecn949TRuR50lqwNVYX5ziRJsboGbyi
rjWV69P2erEVvBvqfOOUcXViqo1pRQh+NoHmggt6WpaFaQWaOd3G/LnNDt7td5PkDd428/7P
/zL6ZYvtfku+0Itss62S5G3xpUr+Z70CJf6nGXz+239tq9mnYo9Hwv9j9Bu+/btNxf62KzEP
5a7a34L1P+z2psw/ahSQt2JnruutugMEF6O30LAp+2tSeLd3B3OH8cWobRAbaxrdIXxzmuii
Rfy2G63urXsArUwJihYNKkag9h4PPmPCdbLeNNXKLPXwVpT4WVXUVdMdAtoLobkgHQkXDVlY
+Mw+HL29+suPNx8myYdf/4K5x8nVx+TD+/e/XIx+XS1x4vAWdczc3TaVR0FfFcmXxXZ/KJbQ
q/ITkJ7WlyOX68NylpQFlnk2ASpQW+huYQW/esKBXDzejWWqsa3rn95/HMH87xb3i2WxTR5A
639qmtms9zDoiwLPzN8Xn6saRYMwOaywaJLJsEcluT7g/djtSXdzK87+YjQq99vluDRZ7Qfb
G+BrbPQzPn4Anum6OFtjEQTD0QwrF5OcdBkS+/237FhbmzujU8SFrN0WwzCAXFIXUAwGzLT1
rACQPbYPGY3YB9OK5CLrbyWAXjkpIQDIn6CPmSfTilbWsDxtJYA+z5l0AOUT9NkA9DnJ80Ar
veglyRXmku/MKQ78/xaY6LYpQTNJ/ndf66AxNvcyebVZzLAQGlCEh7JRhWD5+xXeTo9XHjRw
rUDWh0kA5hZPdV+aWzTavzU67wEVUZNbj1ePYwrQYXOR/BUr5oPvtAYOnS+LO3jrkzkRUIEe
wvMQ3xLD7U1rbXHDruxH0/MUc/rxjIdmYvQbdgJVDIxMXQLR1MfCU+8N/7MLrFmNR4HqAWnH
79EwANTBdG093a1N2UWgBSFAmSUf39+++fj2+v1PP1/9UrfKkTsl2vhzDzO0znH2pZK6X2Zf
SRljYY6sQKmQz5V8A4heY7/kA/oYC5tWMnYkCIP0hwEE7lcB/SGlGIJeccmfqz8MIEhwHtAf
UqoB6MG9ZQEt1I+e0vxo7h/rD2nYKIqem6pqz9AftSx97Pj+FU3KRJMZ3hCbMPkDSvN8hhci
0Qn8+90LoTsIqlsIlfzGJmxClQ+E5QnNOyCZt0Aa0BDAQ7x4CF7v1AJVvAXKAUgCqsxPHJt3
MFkLQkmwP6zygFDsEJ/gXqoPiIJj8hSImQ71DQNFQp4C8RBxLp75vIPJQsMNM8k8eHQN4x1s
6aCZVh1IHpsg/hQPI80EUT8Ulh7tOK7ooCiOguidIstzGDJpYBj2qIc64DMPbTzYoYTOLGll
ByQivO0ZbCYbTuihbeYB0TXHSS8IihBJ3NfruQEO5Sw6ZqyTU25EgQ3gtg4Tj3E1s70pO97h
WSNAfjbA/hSWvk4lcBGaIekwXNlpBK5qPpA9iLQ7bjyodAjK8JMRyEjdF9DaPSgyDxCNDJtH
UWVZM6l4EtHPoR4gEZhSgvrlKYhsOqR6tKiy2qAzCpnqiOvhOF+PdFD1Ws7pODTLA7N5xGy6
0wQirD08+l2wZgSyPi3lgeHBGSWuYexgREDr+rlNyAjjWMUmOv0pVGAECKrXp6TlETzqKW0y
ZEldIzJnHQgNzKdXS0sW1tLWflQWJgvyGfUoXCkaDeVnAdRQCjSHtD2JTYwzm0p1UKGZkT4L
KnVQAqjHRsnWGtBeq6ufIlIkQBr2n7maU7GQTevB0FgBKkQPDn6EQgwfYQukwlPv8blUY2uF
V5+7Q2ytjAo7Q64XqTpHTdfOEDBZTJQ72jQNdOfYbFqYiF/Dph4YEdazPpDQSBNYkjxVMroZ
6V4vxRkBuy7ofBvaR53HDuYh1+bIRpfTDiaoaoB4i0eSDijofRtMLlkiLDYeLZvLgFweETXr
/K1cBQzN0bKI2o7odpyzHkFgpYe6PGgD8qcQlJCAp448TZOj12Ouk48sSlh4CWH1AKcWiId9
R2MCSuf91kPDsMdQhU6JDMmaq2+kXeMRFRyFIz6YOxTmsaV4AV2inVtHzep44DJcTi2YaNd5
PQPh09WUqjAneBQipTrGDr4xZ43T7tU7LpvaIAZlNKJHfXzHWFArUvFUK1KWRRaivrFjIbUg
He+zmlmY0NqIuBxkQcJhGVeQdG6hQlqBOiw06ywqlqLuZ4Yjp03ZHnEacUM8rh7lPCQU7tiV
diB4cJKIs0SwE8vblZXo43A0DpVDmYqMti+eZRaxvat41zpqYoHydsnjXfQBadbkOzGgjITH
26fvzdq3oS9JkozhjomT1+MJN/OM5JGQJzaTE2U3gIfGmw0gM/WvQvtVoQ0rLwP4tEHWLiyZ
N3BowhEdlFXCGW/sin9yXAFSThgwG7jutQtFmjXLHjBKcUfWMnYmu9V/n5nwBEGoCRoEwrUe
L5PWMYN+Q+5wt9UlwbCBRDveKSDbKRE0fUcSYZeBVHRzxeMW03ZLZM1aoHeJZkVdWn0nRGSR
hr4TtTwh2jCNf8l15G1oZyhiboPPIsmgbiCOL2T7I1sBoX76fDEhLDsV1JKeNRGVWdBB8S6+
qAyNtqvsZlaipAy73lZNCKuNZTtNsoc6y3qFQ14+NNZnZ1aRiIurfdZChV2h49i/HQsTJMBB
97pdgE0cefrNgp9PtH8UjkTJ0UZKtnP7DCaqAwW9VtMns22ggPq3gYyGADvg4OgCMaxvSeXz
T3QoEnMksjPrcmkaElnqNU+aNfTlvfPqU+MmwGB0V894OxETZaFCQTni3UFroxLPiDFRLSMu
lBcoFJZzw7/Uqi4d2kJzGcgusakTy+hzc32bgjkNj4NPG+fR7UcLpZ1NvizQKyOxHlSt3Ob+
7dEj9TB34GQoHtazZsx1JHqAG2OFHfI8Fth2FhZWjeM1auGNS9+GIglF64h/f7TzEPt0JM2h
Q2xuIXjIzHpdcEZCrqFX9hgJbnR6IxuMOLIXC1JoZsFCknQE5KCKTasj5zYuxujzQ7CMhveT
PE4ro51T2GPPPUqI0aD/7t3tYzQ4S0dAhTMKsb0LxyzZvQtGI7F13z42DYmrd5OQsaAlQ4nA
bQI+tQCRLSLmUVrM7P73239H99hMGMayiPfkEz4W3MU+SoGYWgUUi9X48gxiwRoHSDiJE6Fg
jX/LmPF2E9yfoOCPyTP+jFCutUmMR2JqPkz82ZFFxrtobs9iySu1POTv9+SD8HAwt2fNyEyg
B5VXz5g7yVszC5SHV4xHLjjLIvE0xz1h3EJ1G3vDw+Asi4mFb7Sz1gXP+7YQrTqeWQuTtX6X
8nsofnESrQ/wDBdA0IBa8Q+EiO3XeYHC3rRPFYt46pKbHMREF+SRfcxztCXMojkEzOPcsmAW
gX8fkcnIYsedztxChe2E38LKkEPc45zI8C7fkT/MrajK1h+ORv0cVGGbzOz6zSbIMKljFhad
6NyhrFvIkp6FrM8LUsH0Msf2W6unQvkhRy5GZT1iFbP/PuFWPOjVeRVCm8DA/KE+b+4oUzE9
Z4dOWOFTwaxbl1WpZXAV2vY95lWrvJUOMas/c1JHokhoVErrNmkajEIerfRyB0toO9bdtCtt
eqaO7KU5AjF1MIlgNJY4vGqVkFZt3lw0N8fB1O6y99hKb/SS6ZAR96aasbz10PIeZnVMuXTA
Ii7acUjIaoi8DfX1ZWI7EQAruXnICZe+4BPLs3AsxHIFtx5knUPRGyl1uM/pUUiY2nV55hAW
2Zg+cuocjs3zsNZ3/KBpF9bgJGw1fbFfTkJhpDr26+bGkphatbq4sEChBHbX/+EOXeEp9fiB
nISVKoy1R39z0gWKe2TPsxzlJBwbtOpxNrcw4VWvL8jHoxEN3/qat0cTRF/4yOM8chqZWU8W
Eg+eTCDe4aaRWKI1fNYJ4rQNJtLcH6OBufXlpdPYJoBnac5pm5DWt1Hog4meg/CNBYsEnnzH
IHh7pmFYLnv0PIOlSzo4wguJwqNHWCQs71HbnMXC8lY3zu2xARaJy/vktT06gSWrA5qb2xMD
3ekJmvch8okeH5r+7ICE3NsjN4gqCxTTw9brtOk0nEf8W4uJWZhW9mSPl+/xBTkP2dbHAQbO
W/+HxwNH1rPlWcjhdJe7lkujRy4sa9u4P88ifoxnK5Fn4VCil0vD0Q//upJnMZfEp+yz6ME6
n7xmrVfSp059QVUuwiJhA1TKMp0IHwnwZcxxEcs+96lgEcvUpUfp51wMD1DZHQYuQnl5PWeq
RCRd144bdxDFMvN8fpMIJ+Y5NrILr3PZrCREz0EXn4mQsdxJy3M2vM4lb4+J+aXPP3oyG5p3
4sDIkOE/zsuyQN2ZJy69G1zH2wZWF8twhp5Pq8r82QFsrkhLH+3BZBmpsLpVNVuQveYS3Qxm
+UG1m1tYdXawklSh3S3pS0/gKuRnuHF/6hDXBohFX46GiU04vW+Nv5N0gpgRAuCaajKzZFrs
6voGi9V8neCFa80rSVmUnyqsCFNXIBDqQuRZbi838p1nV7ED5aYVyeSz62EYQM14oJIFoI8d
KIdWJMkoeXY9DASkVPFAFQJAHzvNLzR0gtKjTgyqZWAAcywvHThOr2K5pdCKJIQ/sxxHzTs/
VqtqW5gqMaZK0KzaldvFZr/e7tpXrmYAa8Jb+AbeLLmrGer1rPpiCJAai7Hoo+F/UpJBB6qK
2VaUUM9OkZV4UxvByFGAhXWspItphQoZEIQAepWxLMTCOlYPQxHkIcYChR386A2g5jxYjgOT
TWPoJWGUPZuFDaBiIlDLAdBnA9CDGcgCdSWeom+qXL3clhfLdVksXybV14Up63LY7xazylxJ
W33dVCU+LNczLOyyfqj1nsK8aiFt5aHvqshlWlFCnOfeM4V1WxgebG5a25aPM725ChX8U9mF
ULkgNCiI0SZ0JigNClMeayInnOqQQOQk2oTIjoTxCVPnLNIEaAWhRIgxw/UTTRMCVEfbRHOD
5niHZdEeN9XP44p0zVEqbOmY7gq5w8aUIRpPtwu8U/1xyzEDoASWc8lsUakAnWDronRK5CJm
CykOo1NlIQ1/MNcUTpLX28PqdX2F92q9ry8vrGaj5N/qAkxYLAwvqwUshpbclOsSWKdnyJXb
1AIJc9/0tjyMQb72h201gRbMFeKHZV3vbV+BU/TpsJ+tQUBn1d7oCdsAzDvWqSoFI7cPMyD9
r22pJ6yGtG3v8e7K2V1ctLCaiAwpPkL+cb+u76qGp7ebaju/xfJs1dYCSXPKowFo60U9ehvL
5ZnaeLNDZao0HXfDNqYUOmPPpEArVB3noQD8IdQA2woryE2SD1V32V4NYV9kBK1H+2Jbeq7l
gtHNstigM4ujPsHzmKPRH9X9Yby4v2tV9Xie/FGuHxhOxufxH4cCL8QcY42vJWVjSsYE8wN+
fD4c/U449p1w/Dvhsu+EE98JJ2u40ecv95evRi8MfD2t469a3sps9GJcV2scwyvwBYUTPpk/
NLfE/2v9Gx6gltnOktfr3eK+uKteNwjb32O84Hq84FpelHf/B+/f44ITfu/uNwmD3+CHLkow
9cAbJF1Ve/h+Cb8I/Kn+hnWKt+li1j5FTgPzO6u2l6sS31qPa/aDz11Bt4WE1Vq1mzrPxlgC
co3KYnq4g+fbfWlWWpfG/0AGRWq2WDENLfxlLzum99VsUZi/p4v5JdZ5XKyHwdITYNkJsPwE
2OwEWHECrOyDxbKZxRKs06xuarHbLItvoM9XOIP3a2BIsCirw3I5+mE0KjYb8D6R0bfAI5e4
7nm9Le6Bkz4dVne3+2L3+XZTrBblJR29aHij2MDX5jNIxvaP22L5UHzb3TZFTKGt8rCZgbRd
oIIF+bjd4S2+bYm+S1R0L4BfLxZzs+a6hK+bLXTu8wXg/3y/u7tcr+CRwTsGxLv1fI+G9bCx
xKzuF7ct816ap6MX6/Vm135erovZLXQFB+iSIYL1/WbfPQGUs+10dgEmfb29LdFWX2rTH5D0
GXjdd/UN8Zfg3o5e1MUTb+GpeTh6Ua5XWK3wEjwvaKkqtstvdQ/wyUeSgjPEsJfOe87TL3fF
JTR4D87Yi+3D6MV0W6zKT/8/W2BbvLRYPzcR1BDg4nTy9w+J9/R1dHe11S/ITtcHyVbog8oK
XaDyFKDJaZnpuuXALGduaGEA7Kbopycn65rrpxinJKdZpCaZGZqaGpsD2xdJKSZGaWlG5okG
FoYpJmYpwJa2haFZqn5ZLsjIKl0TPUMzPQPdomQTXdC1Upa66VAjsAcRKHKBdaYerFoEBiUw
ISmpVAMLwWiH2FolBV1IqlIAikFY0VpAYS4AO6DLZVIPAQA=

--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-intel12-11:20180720221835:i386-randconfig-w0-07180254:4.16.0-rc4-00130-g499ac3b:2"

#!/bin/bash

kernel=$1
initrd=quantal-core-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 369
	-smp 2
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

--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.16.0-rc4-00130-g499ac3b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.16.0-rc4 Kernel Configuration
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
CONFIG_NEED_DMA_MAP_STATE=y
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
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
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
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
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
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

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
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_INTEL_RDT=y
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
# CONFIG_PARAVIRT_SPINLOCKS is not set
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
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_MELAN=y
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=4
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_TOSHIBA=m
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
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
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_ARCH_WANTS_THP_SWAP is not set
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
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
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_ELAN_CPUFREQ=y
# CONFIG_SC520_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=m
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=m
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_TS5500=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_FOU is not set
# CONFIG_IPV6_FOU_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
# CONFIG_DMA_SHARED_BUFFER is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_MISC_RTSX is not set
CONFIG_C2PORT=m
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module (requires I2C)
#
CONFIG_ALTERA_STAPL=m
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

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
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_AMD_XGBE_HAVE_ECC is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_MVNETA_BM is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_MDIO_BUS is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
CONFIG_KEYBOARD_ADP5588=m
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=m
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=m
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MAX77693_HAPTIC is not set
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=m
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=m
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_CMA3000=m
# CONFIG_INPUT_CMA3000_I2C is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_SOC_BUTTON_ARRAY is not set
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=m
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
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
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=m
CONFIG_TRACE_SINK=m
# CONFIG_GOLDFISH_TTY is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
# CONFIG_CARDMAN_4000 is not set
CONFIG_CARDMAN_4040=m
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
CONFIG_PINCTRL_MCP23S08=m
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
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_TS5500=m

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_WM8994 is not set

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=m
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_DA9063_WATCHDOG=m
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
CONFIG_XILINX_WATCHDOG=m
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_RAVE_SP_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SC520_WDT=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=y
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=m
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=m
# CONFIG_MFD_CROS_EC_I2C is not set
# CONFIG_MFD_CROS_EC_CHARDEV is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_HTC_PASIC3=m
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=m
CONFIG_ABX500_CORE=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
CONFIG_MFD_TI_LMU=m
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_RAVE_SP_CORE=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PM800=m
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=m
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=m
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
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
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_PWM=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_VGASTATE is not set
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
CONFIG_I2C_HID=m
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
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=m
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=m
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_APU=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_NET48XX=y
CONFIG_LEDS_WRAP=m
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=m
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
# CONFIG_IRDA is not set
# CONFIG_IPX is not set
# CONFIG_NCP_FS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
CONFIG_COMEDI_TEST=y
CONFIG_COMEDI_PARPORT=y
# CONFIG_COMEDI_SERIAL2002 is not set
CONFIG_COMEDI_SSV_DNP=m
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=y
# CONFIG_COMEDI_PCM3724 is not set
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
CONFIG_COMEDI_RTI800=y
# CONFIG_COMEDI_RTI802 is not set
# CONFIG_COMEDI_DAC02 is not set
# CONFIG_COMEDI_DAS16M1 is not set
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=m
# CONFIG_COMEDI_DAS1800 is not set
CONFIG_COMEDI_DAS6402=m
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=y
CONFIG_COMEDI_DT2814=y
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=y
# CONFIG_COMEDI_DT282X is not set
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
CONFIG_COMEDI_II_PCI20KC=y
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=m
# CONFIG_COMEDI_ADQ12B is not set
CONFIG_COMEDI_NI_AT_A2150=m
# CONFIG_COMEDI_NI_AT_AO is not set
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=m
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
# CONFIG_COMEDI_PCMUIO is not set
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=m
# CONFIG_COMEDI_PCI_DRIVERS is not set
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_LABPC_ISADMA=m
CONFIG_COMEDI_NI_TIO=y
# CONFIG_RTLLIB is not set

#
# IIO staging drivers
#

#
# Accelerometers
#

#
# Analog to digital converters
#
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_I2C=m

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7152=m
# CONFIG_AD7746 is not set

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
# CONFIG_TSL2x7x is not set

#
# Active energy metering IC
#
CONFIG_ADE7854=m
# CONFIG_ADE7854_I2C is not set

#
# Resolver to digital converters
#

#
# Triggers - standalone
#
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y

#
# Android
#
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=m
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
CONFIG_GS_FPGABOOT=y
# CONFIG_UNISYSSPAR is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=m
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=m
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
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

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

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
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=m
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_BMA180=m
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=m
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD7291=m
# CONFIG_AD799X is not set
# CONFIG_CC10001_ADC is not set
CONFIG_HX711=m
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=m
CONFIG_LTC2497=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP3422=m
CONFIG_NAU7802=m
CONFIG_QCOM_SPMI_IADC=m
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=m

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_CCS811=m
# CONFIG_IAQCORE is not set
# CONFIG_VZ89X is not set
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
# CONFIG_IIO_CROS_EC_SENSORS is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

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
CONFIG_DS4424=m
# CONFIG_M62332 is not set
CONFIG_MAX517=m
CONFIG_MCP4725=m

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set

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
# CONFIG_BMG160 is not set
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=m
# CONFIG_HID_SENSOR_HUMIDITY is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
CONFIG_SI7020=m

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM36651=m
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP020A00F=m
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
# CONFIG_HID_SENSOR_ALS is not set
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_MAX44000=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VEML6070=m
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=m
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
# CONFIG_SENSORS_HMC5843_I2C is not set

#
# Multiplexers
#

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set

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
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
# CONFIG_IIO_CROS_EC_BARO is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_T5403=m
CONFIG_HP206C=m
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
CONFIG_SX9500=m
CONFIG_SRF08=m

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=m
# CONFIG_MLX90614 is not set
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
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
CONFIG_RESET_TI_SYSCON=m
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=m
CONFIG_NVMEM=y
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FSI is not set
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=m

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=m
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=m
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_CRAMFS=m
CONFIG_PSTORE=m
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

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
# CONFIG_DYNAMIC_DEBUG is not set

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
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAIL_MMC_REQUEST=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_LIST_SORT is not set
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=m
# CONFIG_TEST_LKM is not set
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
CONFIG_FIND_BIT_BENCHMARK=y
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=m
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITY_WRITABLE_HOOKS is not set
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_PATH=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
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
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=y

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
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
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
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
# CONFIG_XZ_DEC_BCJ is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
# CONFIG_SG_POOL is not set
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STRING_SELFTEST=m

--adJ1OR3c6QgCpb/j--
