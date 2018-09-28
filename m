Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3B5C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F14821580
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U31ev38l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F14821580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeI1T4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:56:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59540 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1T4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:56:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180928133250euoutp0150cbad3638250b35c2be84e400bb2178~Yk5vXMH023137731377euoutp01Q
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 13:32:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180928133250euoutp0150cbad3638250b35c2be84e400bb2178~Yk5vXMH023137731377euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538141570;
        bh=Ud0PsHYwfx0uLAHZaGRuIFh+ijbvUK4h30W0BCZFq5c=;
        h=To:Cc:From:Subject:Date:References:From;
        b=U31ev38lx/j7YdjgJZ0j+T9KqVTykO9OTjpUogyjhaFTgAlo64Ew6hv10qvFEXYQU
         auv9rY6fwNBwA94r7fRbeop7J1ZvU1H+UH/a/v88rhKR3j1Lyj/iCHigbftxDRmh9k
         9/H/b/fy+qfIxjyM6KHUJSOlXmLsTVUr2KqEjISA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180928133249eucas1p10324dc2d0b7baf5af15c929a1d5477a8~Yk5u3VQCb1586615866eucas1p1T;
        Fri, 28 Sep 2018 13:32:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.18.04441.18D2EAB5; Fri, 28
        Sep 2018 14:32:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180928133248eucas1p27feaea76c3193825e319943c60491962~Yk5t7fL-z0673006730eucas1p2K;
        Fri, 28 Sep 2018 13:32:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180928133248eusmtrp21357b23f09fd4f6bb9f937076183b7a1~Yk5tqquxg3269732697eusmtrp2I;
        Fri, 28 Sep 2018 13:32:48 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-f3-5bae2d81e321
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.A9.04284.08D2EAB5; Fri, 28
        Sep 2018 14:32:48 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180928133248eusmtip14e4b86238d64290ffcabc1054a1a9a22~Yk5tVBnNO2505225052eusmtip1i;
        Fri, 28 Sep 2018 13:32:48 +0000 (GMT)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_CHECK config option to
 non-Exynos platforms
Date:   Fri, 28 Sep 2018 15:32:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7qNuuuiDTb2CFhsnLGe1aL/8Wtm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jsjg0dS+jA7vH5WsXmT02repk89i8pN6jb8sqRo/Pm+QC
        WKO4bFJSczLLUov07RK4Mr4se8haMEO3Yua3TYwNjA9Vuxg5OSQETCS+N51i62Lk4hASWMEo
        8WzPZnYI5wujxMoZLVCZz4wS+559ZYdpWbG2hRUisZxR4n/fMyYI5z2jxOnvt5lBqkQENCWu
        //0OVsUs8IpRomH2XiaQBJuAlcTE9lWMXYwcHMICsRJN02RAwiwCqhJL525iBwmLCkRI9J9R
        BwnzCghKnJz5hAXEZhaQl9j+dg4zyEgJgW52iSu9l9khisok7r16AXWdi8SE57/YIGxhiVfH
        t0DFZST+75zPBNE8nVHiza+lLBDOekaJNWeOMUFUWUscPn6RFeQKZqAP1u/Shwg7ShzedAos
        LCHAJ3HjrSDEQXwSk7ZNZ4YI80p0tAlBVKtJbFi2gQ1mbdfOlVAlHhLXv5mChIWAHn924RHz
        BEaFWUi+nIXky1kIJyxgZF7FKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmGhO/zv+aQfj
        10tJhxgFOBiVeHgTHq2JFmJNLCuuzD3EKMHBrCTCu696bbQQb0piZVVqUX58UWlOavEhRmkO
        FiVxXj6ttGghgfTEktTs1NSC1CKYLBMHp1QDY9hPy5anb4rffts6dcH75v6vRd/NDVRVn4ew
        rfxWw7CWN9p5/1Qhgy7JxGmBT0NX+kXb7tF0iJrfoMDhej/9qm+7hk7dhvTWLScWcR++/zym
        Odv7q8D8Mv7JRyoKVrOJza5pKVihPP2x7nJbcQthaYNXq6WZHbXqT36t/FjzdN2aHsPI/uZ7
        SizFGYmGWsxFxYkArQcOazADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Xd0G3XXRBjv6JC02zljPatH/+DWz
        xfnzG9gtNj2+xmpxedccNosZ5/cxWRyaupfRgd3j8rWLzB6bVnWyeWxeUu/Rt2UVo8fnTXIB
        rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GV+W
        PWQtmKFbMfPbJsYGxoeqXYycHBICJhIr1rawdjFycQgJLGWUmDLvB2MXIwdQQkbi+PoyiBph
        iT/Xutggat4ySszobWQFSYgIaEpc//sdrJlZ4BWjxJ6J5xlBEmwCVhIT21eBDRIWiJVomiYD
        EuYVsJOY0zQRrJdFQFVi6dxN7CC2qECExK2HHSwQNYISJ2c+AbOZBdQl/sy7xAxhy0tsfzuH
        eQIj/ywkZbOQlM1CUraAkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYERsO/Zz8w7GSxuD
        DzEKcDAq8fAmPFoTLcSaWFZcmXuIUYKDWUmEd1/12mgh3pTEyqrUovz4otKc1OJDjKZAh09k
        lhJNzgdGa15JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsb+/aav
        MqYfNtCaw6sl7q1RbJX1pbPuhMiMNYtcvjBOFZ02Vzfz1BbD3KQsZgN2jaVW3u/DEvdWnuj5
        V6b9dKvVzgpdyZX3/z6bmztxeenXlzGp1iUmbB8X3RGJzGc/orGYPeapz23raecfRqz+f/H5
        mkvlH99sv6Uy2c7v+LsFS/lcji3beuOvEktxRqKhFnNRcSIAlvqtCZ4CAAA=
Message-Id: <20180928133248eucas1p27feaea76c3193825e319943c60491962~Yk5t7fL-z0673006730eucas1p2K@eucas1p2.samsung.com>
X-CMS-MailID: 20180928133248eucas1p27feaea76c3193825e319943c60491962
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180928133248eucas1p27feaea76c3193825e319943c60491962
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180928133248eucas1p27feaea76c3193825e319943c60491962
References: <CGME20180928133248eucas1p27feaea76c3193825e319943c60491962@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"S3C2410 PM Suspend Memory CRC" feature (controlled by
SAMSUNG_PM_CHECK config option) is incompatible with highmem
(uses phys_to_virt() instead of proper mapping) which is used by
the majority of Exynos boards. The issue manifests itself in OOPS
on affected boards, i.e. on Odroid-U3 I got the following one:

[   18.757127] Unable to handle kernel paging request at virtual address f0000000
[   18.757127] pgd = 1c0f9bb4
[   18.757127] [f0000000] *pgd=00000000
[   18.757127] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   18.757127] Modules linked in:
[   18.757127] CPU: 0 PID: 1357 Comm: rtcwake Not tainted 4.19.0-rc1-next-20180830 #35
[   18.757127] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   18.757127] PC is at crc32_le+0x30/0x150
[   18.757127] LR is at s3c_pm_makecheck+0x34/0x54
[   18.757127] pc : [<c0458034>]    lr : [<c0121f8c>]    psr: 000000d3
[   18.757127] sp : ed2e3db0  ip : 00002000  fp : 00002000
[   18.757127] r10: 00000000  r9 : c0c2f6e8  r8 : c0fc0734
[   18.757127] r7 : 01000200  r6 : efffce40  r5 : ec68c000  r4 : effffffc
[   18.757127] r3 : c0a25dc0  r2 : 00000000  r1 : effffffc  r0 : ffffffff
[   18.757127] Flags: nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
[   18.757127] Control: 10c5387d  Table: 6d24c04a  DAC: 00000051
[   18.757127] Process rtcwake (pid: 1357, stack limit = 0x104b670f)
[   18.757127] Stack: (0xed2e3db0 to 0xed2e4000)
[   18.757127] 3da0:                                     c0fc0734 00000000 70000000 ec68c000
[   18.757127] 3dc0: efffce40 01000200 c0fc0734 c0c2f6e8 00000000 c0fac13c efffce40 ec680000
[   18.757127] 3de0: c0121f58 c0121efc c0fc773c c0f0f3cc ec680000 c0121f58 01000200 c0121ecc
[   18.757127] 3e00: c0fc773c c0f0d9e0 c0ce4d00 00000000 c0fac13c c01210b8 c0121054 c16d17ec
[   18.757127] 3e20: 00000003 c018893c c0f07470 ec60b300 ec60b880 c017cc5c 00000000 60000053
[   18.757127] 3e40: c0f07470 c0faa913 00000003 c0f07470 c0fac13c c0c2f6f8 c0faa913 c0a035c4
[   18.757127] 3e60: c0c2f71c c0189534 00000001 00000006 00000000 00000003 c0c286c8 c16d180c
[   18.757127] 3e80: 00000003 ec41c940 00000000 00000004 00000000 c0186ce8 00000004 ec4210c0
[   18.757127] 3ea0: 00000004 ec41c940 00000004 00000000 ec4210d0 c09db434 00000004 c02fa63c
[   18.757127] 3ec0: ec4210c0 ec41c940 ed2e3f80 c02f97a4 00000000 00000000 c0a0dec4 b6f1a000
[   18.757127] 3ee0: ed1f8f00 ed2e3f80 00000004 ed2e2000 b6f1a000 c027b198 00000001 c017ccd4
[   18.757127] 3f00: 00000001 c0f53b64 ed1301f4 c0198fa4 c0faa925 c01992d8 d166c958 00000000
[   18.757127] 3f20: 00000000 c027cad0 00000001 00000000 c027b4b8 00000000 ed118554 ed1f8f00
[   18.757127] 3f40: ed1f8f00 00000004 b6f1a000 00000000 ed2e3f80 c027b418 b6f1a000 c023e65c
[   18.757127] 3f60: 00000022 00000000 00000000 ed1f8f00 ed1f8f00 00000004 b6f1a000 c027b5d8
[   18.757127] 3f80: 00000000 00000000 00000000 00000004 b6f1a000 000160e0 00000004 c01011c4
[   18.757127] 3fa0: 00000004 c0101000 00000004 b6f1a000 00000004 b6f1a000 00000004 00000000
[   18.757127] 3fc0: 00000004 b6f1a000 000160e0 00000004 00000004 b6f1a000 00000004 00000000
[   18.757127] 3fe0: 00000000 be880b2c b6e21a6c b6e77a0c 60000050 00000004 00000000 00000000
[   18.757127] [<c0458034>] (crc32_le) from [<c0121f8c>] (s3c_pm_makecheck+0x34/0x54)
[   18.757127] [<c0121f8c>] (s3c_pm_makecheck) from [<c0121efc>] (s3c_pm_run_res+0x74/0x8c)
[   18.757127] [<c0121efc>] (s3c_pm_run_res) from [<c0121ecc>] (s3c_pm_run_res+0x44/0x8c)
[   18.757127] [<c0121ecc>] (s3c_pm_run_res) from [<c01210b8>] (exynos_suspend_enter+0x64/0x148)
[   18.757127] [<c01210b8>] (exynos_suspend_enter) from [<c018893c>] (suspend_devices_and_enter+0x9ec/0xe74)
[   18.757127] [<c018893c>] (suspend_devices_and_enter) from [<c0189534>] (pm_suspend+0x770/0xc04)
[   18.757127] [<c0189534>] (pm_suspend) from [<c0186ce8>] (state_store+0x6c/0xcc)
[   18.757127] [<c0186ce8>] (state_store) from [<c09db434>] (kobj_attr_store+0x14/0x20)
[   18.757127] [<c09db434>] (kobj_attr_store) from [<c02fa63c>] (sysfs_kf_write+0x4c/0x50)
[   18.757127] [<c02fa63c>] (sysfs_kf_write) from [<c02f97a4>] (kernfs_fop_write+0xfc/0x1e4)
[   18.757127] [<c02f97a4>] (kernfs_fop_write) from [<c027b198>] (__vfs_write+0x2c/0x140)
[   18.757127] [<c027b198>] (__vfs_write) from [<c027b418>] (vfs_write+0xa4/0x160)
[   18.757127] [<c027b418>] (vfs_write) from [<c027b5d8>] (ksys_write+0x40/0x8c)
[   18.757127] [<c027b5d8>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   18.757127] Exception stack(0xed2e3fa8 to 0xed2e3ff0)
[   18.757127] 3fa0:                   00000004 b6f1a000 00000004 b6f1a000 00000004 00000000
[   18.757127] 3fc0: 00000004 b6f1a000 000160e0 00000004 00000004 b6f1a000 00000004 00000000
[   18.757127] 3fe0: 00000000 be880b2c b6e21a6c b6e77a0c
[   18.757127] Code: 0a00002a e59f3120 e1a04001 e1a0c00b (e5945004)
[   18.757127] ---[ end trace 213166221066122e ]---

Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
SAMSUNG_PM_CHECK config option to hide it on Exynos platforms.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/plat-samsung/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/arch/arm/plat-samsung/Kconfig
===================================================================
--- a/arch/arm/plat-samsung/Kconfig	2018-09-28 15:20:00.057911275 +0200
+++ b/arch/arm/plat-samsung/Kconfig	2018-09-28 15:20:00.053911275 +0200
@@ -256,7 +256,7 @@ config S3C_PM_DEBUG_LED_SMDK
 
 config SAMSUNG_PM_CHECK
 	bool "S3C2410 PM Suspend Memory CRC"
-	depends on PM
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
 	select CRC32
 	help
 	  Enable the PM code's memory area checksum over sleep. This option

