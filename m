Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FDEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AECB21470
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AECB21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeJAXYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:24:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34077 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJAXYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:24:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so14872164edr.1;
        Mon, 01 Oct 2018 09:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=19N/jwX5WMEvvBUEUOZ3k0/lyNiG2wRsaIIrqoMKK9o=;
        b=D5z+mhRBt63Ig1N+76oULRXL+NHFcxey4tigH3II6OosJ7N3ng3QXLDTJJTDmDS7GC
         uIcpoj2NZ+oZdrhZKpLv0ivin0coWX1cAe59aNWv1mHypHruqs6WGEDFrRTa3EkbTtwG
         VsOvOZUPff8PQru7N0Cpor6npt/sWm+x1XDFegcKPlV5+k/UV/uyQ6rfzpjOOisq+4Li
         zNxex+SPGHl83TDZukgqsaqoob9JdUIqrhJB3s9WAUD8oCbRNB4078sLrcKy1HpQznxd
         VEyhsQP0sB6bCW/yJI0EuE0K1qOZJZXLM8wzszDf0Xfm45SnYXQ+o3yUGQUqpUFBafW6
         fBcw==
X-Gm-Message-State: ABuFfogBm2I30CD8ogC4uayULPy0Y6LQ63l/a+IsyTini44yCN3n2tKt
        yz+Dm5i0qv37RH4A3+AqBj0=
X-Google-Smtp-Source: ACcGV61EP2tjZYiOG4v7jR/RMlRLubdKXhy6lGb7W3RCs5V2gwvKW48JhfCAqBthMfFv92qGz6Ia0g==
X-Received: by 2002:a50:ba3c:: with SMTP id g57-v6mr19208577edc.214.1538412347863;
        Mon, 01 Oct 2018 09:45:47 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id s7-v6sm1750189eju.51.2018.10.01.09.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 09:45:46 -0700 (PDT)
Date:   Mon, 1 Oct 2018 18:45:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: SAMSUNG: limit SAMSUNG_PM_CHECK config option to
 non-Exynos platforms
Message-ID: <20181001164545.GA14091@kozik-lap>
References: <CGME20180928133248eucas1p27feaea76c3193825e319943c60491962@eucas1p2.samsung.com>
 <20180928133248eucas1p27feaea76c3193825e319943c60491962~Yk5t7fL-z0673006730eucas1p2K@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180928133248eucas1p27feaea76c3193825e319943c60491962~Yk5t7fL-z0673006730eucas1p2K@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 03:32:46PM +0200, Bartlomiej Zolnierkiewicz wrote:
> "S3C2410 PM Suspend Memory CRC" feature (controlled by
> SAMSUNG_PM_CHECK config option) is incompatible with highmem
> (uses phys_to_virt() instead of proper mapping) which is used by
> the majority of Exynos boards. The issue manifests itself in OOPS
> on affected boards, i.e. on Odroid-U3 I got the following one:
> 
> [   18.757127] Unable to handle kernel paging request at virtual address f0000000
> [   18.757127] pgd = 1c0f9bb4
> [   18.757127] [f0000000] *pgd=00000000
> [   18.757127] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [   18.757127] Modules linked in:
> [   18.757127] CPU: 0 PID: 1357 Comm: rtcwake Not tainted 4.19.0-rc1-next-20180830 #35
> [   18.757127] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   18.757127] PC is at crc32_le+0x30/0x150
> [   18.757127] LR is at s3c_pm_makecheck+0x34/0x54
> [   18.757127] pc : [<c0458034>]    lr : [<c0121f8c>]    psr: 000000d3
> [   18.757127] sp : ed2e3db0  ip : 00002000  fp : 00002000
> [   18.757127] r10: 00000000  r9 : c0c2f6e8  r8 : c0fc0734
> [   18.757127] r7 : 01000200  r6 : efffce40  r5 : ec68c000  r4 : effffffc
> [   18.757127] r3 : c0a25dc0  r2 : 00000000  r1 : effffffc  r0 : ffffffff
> [   18.757127] Flags: nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [   18.757127] Control: 10c5387d  Table: 6d24c04a  DAC: 00000051
> [   18.757127] Process rtcwake (pid: 1357, stack limit = 0x104b670f)
> [   18.757127] Stack: (0xed2e3db0 to 0xed2e4000)
> [   18.757127] 3da0:                                     c0fc0734 00000000 70000000 ec68c000
> [   18.757127] 3dc0: efffce40 01000200 c0fc0734 c0c2f6e8 00000000 c0fac13c efffce40 ec680000
> [   18.757127] 3de0: c0121f58 c0121efc c0fc773c c0f0f3cc ec680000 c0121f58 01000200 c0121ecc
> [   18.757127] 3e00: c0fc773c c0f0d9e0 c0ce4d00 00000000 c0fac13c c01210b8 c0121054 c16d17ec
> [   18.757127] 3e20: 00000003 c018893c c0f07470 ec60b300 ec60b880 c017cc5c 00000000 60000053
> [   18.757127] 3e40: c0f07470 c0faa913 00000003 c0f07470 c0fac13c c0c2f6f8 c0faa913 c0a035c4
> [   18.757127] 3e60: c0c2f71c c0189534 00000001 00000006 00000000 00000003 c0c286c8 c16d180c
> [   18.757127] 3e80: 00000003 ec41c940 00000000 00000004 00000000 c0186ce8 00000004 ec4210c0
> [   18.757127] 3ea0: 00000004 ec41c940 00000004 00000000 ec4210d0 c09db434 00000004 c02fa63c
> [   18.757127] 3ec0: ec4210c0 ec41c940 ed2e3f80 c02f97a4 00000000 00000000 c0a0dec4 b6f1a000
> [   18.757127] 3ee0: ed1f8f00 ed2e3f80 00000004 ed2e2000 b6f1a000 c027b198 00000001 c017ccd4
> [   18.757127] 3f00: 00000001 c0f53b64 ed1301f4 c0198fa4 c0faa925 c01992d8 d166c958 00000000
> [   18.757127] 3f20: 00000000 c027cad0 00000001 00000000 c027b4b8 00000000 ed118554 ed1f8f00
> [   18.757127] 3f40: ed1f8f00 00000004 b6f1a000 00000000 ed2e3f80 c027b418 b6f1a000 c023e65c
> [   18.757127] 3f60: 00000022 00000000 00000000 ed1f8f00 ed1f8f00 00000004 b6f1a000 c027b5d8
> [   18.757127] 3f80: 00000000 00000000 00000000 00000004 b6f1a000 000160e0 00000004 c01011c4
> [   18.757127] 3fa0: 00000004 c0101000 00000004 b6f1a000 00000004 b6f1a000 00000004 00000000
> [   18.757127] 3fc0: 00000004 b6f1a000 000160e0 00000004 00000004 b6f1a000 00000004 00000000
> [   18.757127] 3fe0: 00000000 be880b2c b6e21a6c b6e77a0c 60000050 00000004 00000000 00000000
> [   18.757127] [<c0458034>] (crc32_le) from [<c0121f8c>] (s3c_pm_makecheck+0x34/0x54)
> [   18.757127] [<c0121f8c>] (s3c_pm_makecheck) from [<c0121efc>] (s3c_pm_run_res+0x74/0x8c)
> [   18.757127] [<c0121efc>] (s3c_pm_run_res) from [<c0121ecc>] (s3c_pm_run_res+0x44/0x8c)
> [   18.757127] [<c0121ecc>] (s3c_pm_run_res) from [<c01210b8>] (exynos_suspend_enter+0x64/0x148)
> [   18.757127] [<c01210b8>] (exynos_suspend_enter) from [<c018893c>] (suspend_devices_and_enter+0x9ec/0xe74)
> [   18.757127] [<c018893c>] (suspend_devices_and_enter) from [<c0189534>] (pm_suspend+0x770/0xc04)
> [   18.757127] [<c0189534>] (pm_suspend) from [<c0186ce8>] (state_store+0x6c/0xcc)
> [   18.757127] [<c0186ce8>] (state_store) from [<c09db434>] (kobj_attr_store+0x14/0x20)
> [   18.757127] [<c09db434>] (kobj_attr_store) from [<c02fa63c>] (sysfs_kf_write+0x4c/0x50)
> [   18.757127] [<c02fa63c>] (sysfs_kf_write) from [<c02f97a4>] (kernfs_fop_write+0xfc/0x1e4)
> [   18.757127] [<c02f97a4>] (kernfs_fop_write) from [<c027b198>] (__vfs_write+0x2c/0x140)
> [   18.757127] [<c027b198>] (__vfs_write) from [<c027b418>] (vfs_write+0xa4/0x160)
> [   18.757127] [<c027b418>] (vfs_write) from [<c027b5d8>] (ksys_write+0x40/0x8c)
> [   18.757127] [<c027b5d8>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> [   18.757127] Exception stack(0xed2e3fa8 to 0xed2e3ff0)
> [   18.757127] 3fa0:                   00000004 b6f1a000 00000004 b6f1a000 00000004 00000000
> [   18.757127] 3fc0: 00000004 b6f1a000 000160e0 00000004 00000004 b6f1a000 00000004 00000000
> [   18.757127] 3fe0: 00000000 be880b2c b6e21a6c b6e77a0c
> [   18.757127] Code: 0a00002a e59f3120 e1a04001 e1a0c00b (e5945004)
> [   18.757127] ---[ end trace 213166221066122e ]---
> 
> Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
> SAMSUNG_PM_CHECK config option to hide it on Exynos platforms.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/plat-samsung/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied with reduced OOPS log (all these addresses and register
values do not look relevant and they blow up the commit message).

Best regards,
Krzysztof

