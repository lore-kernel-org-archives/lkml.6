Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308BBC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFB1222E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/g5d0G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfBPSDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 13:03:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46339 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbfBPSDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 13:03:45 -0500
Received: by mail-qk1-f196.google.com with SMTP id i5so7641085qkd.13;
        Sat, 16 Feb 2019 10:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NH7FVrrdwACc7/vkZYW12XFis5p3VUb2dh3ui3X4N3Q=;
        b=K/g5d0G+Cbc0cmzpFpELpJ6Dz/qxpMKS1VnBbss5YjkHKfiZ/L5hJQfT5FbaMse4z/
         pqyorbdd4UGJxQ9OtB/qN9Q9XFEfurR3xOoKru2GEAZyDXAQDRD3kcd42jtELSXw4cqI
         nvoEJ/KdozOtKO7e547XjY72xgEG/DE5+jPqrhn5YIXOml7DUZ4kEwcTIn1dIIxpnvWP
         mq8aHO4f/srbV9MJBSgRY7XvrA4J1298LQap9+d3DzqsU4LiSyXHUg1Xbz6bTz0LO0rV
         rUqn8QmqRdhZs6yjCM9JeJIlQpuU4kJlZre9h0j2oaOeiwhB7fDLsVEPhyOY5Drbhj4S
         5q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NH7FVrrdwACc7/vkZYW12XFis5p3VUb2dh3ui3X4N3Q=;
        b=DWXkJKmnOVssZVVChcdYQcyv+vVDSXBN6c9ChS3+dtQNVm2IiyXY+N09GUX7eSFkwN
         NIYB1DqiX7bznDv0ItFekLySeGSRksJV+aIJOpWBpWVDOq4o7LqbdaXO3wbTX+FWBEmC
         ZN5SBCwmlqnFY9T1icQ54PUJCtCwls1LibTEBeivPnHg+HabobFoqgurbPJ92r6MzmqU
         Ukqnxg8ytzpN5pcCYUZFZErtP6m4LZwICohA5GC3cUwO/vBtJDh7JVTNiSHw//GihEe7
         xHrlYJ3DhkJkj8fYsgJuH9tN1ib5BzFJz8zWIVRykKNyAOOxczUVL+7Hka0gqpO9EPyH
         aABg==
X-Gm-Message-State: AHQUAuakZED3QowTARkTCU/uO9uRcV35CuTddeEidjP0USHArQaU70Qm
        Uh5Sf+/ww/WtaA6juXqXv2CuFkOW51NI+A==
X-Google-Smtp-Source: AHgI3IZ9/WJL1J5D2m31kZQZsam/gECjmDF7le+qQRJuZUbIH9EXXfvGPDEvnSBnyQWVoU8Afp5bGg==
X-Received: by 2002:a37:e40f:: with SMTP id y15mr11307285qkf.230.1550340223990;
        Sat, 16 Feb 2019 10:03:43 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p186sm4532517qkb.69.2019.02.16.10.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 10:03:43 -0800 (PST)
Date:   Sat, 16 Feb 2019 13:03:32 -0500
From:   niveditas98@gmail.com
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        intel-wired-lan@lists.osuosl.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4.20 237/352] igb: Fix an issue that PME is not enabled
 during runtime suspend
Message-ID: <20190216180332.GA51434@rani.riverdale.lan>
References: <CAFU=Bqd8ZVNqT5OY0ou05h0N2Oue3=-2exBf-43r0A_rEFpbvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFU=Bqd8ZVNqT5OY0ou05h0N2Oue3=-2exBf-43r0A_rEFpbvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=202571

The igb commit is commit fb29f76cc5668d8fc9e2b04ebfaf4de4f62e1866


On Tue, Feb 12, 2019 at 7:21 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> After upgrading to 4.20.8, I got a WARN in my dmesg and I suspect this
> change. Reverting it removes this warning.
>
> I am not subscribed to the list, please Cc me if any follup questions.
>
> [   12.457238] ------------[ cut here ]------------
> [   12.457251] PCI PM: State of device not saved by igb_runtime_suspend+0x0/0x80
> [   12.457275] WARNING: CPU: 1 PID: 175 at
> drivers/pci/pci-driver.c:1280 pci_pm_runtime_suspend+0x127/0x130
> [   12.457277] Modules linked in: 8021q zfs(PO) zunicode(PO) zlua(PO)
> zcommon(PO) znvpair(PO) zavl(PO) icp(PO) spl(O) zlib_inflate
> x86_pkg_temp_thermal kvm_intel kvm coretemp hwmon irqbypass
> crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64
> crypto_simd cryptd glue_helper intel_cstate intel_uncore
> intel_rapl_perf intel_pch_thermal i2c_i801 ipmi_si ipmi_devintf
> ipmi_msghandler
> [   12.457318] CPU: 1 PID: 175 Comm: kworker/1:1 Tainted: P
> O    T 4.20.8 #16
> [   12.457320] Hardware name: Supermicro Super Server/X10SDV-7TP8F,
> BIOS 2.0 06/13/2018
> [   12.457329] Workqueue: pm pm_runtime_work
> [   12.457337] RIP: 0010:pci_pm_runtime_suspend+0x127/0x130
> [   12.457340] Code: f7 0f 00 8b 44 24 04 eb a1 44 39 e8 74 9a 80 3d
> cb 7b d0 00 00 75 91 48 c7 c7 d8 b3 75 a2 c6 05 bb 7b d0 00 01 e8 fe
> 37 cf ff <0f> 0b 31 c0 e9 77 ff ff ff 41 55 41 54 45 31 e4 55 53 48 89
> fb 48
> [   12.457343] RSP: 0018:ffffb300406abd88 EFLAGS: 00010282
> [   12.457347] RAX: 0000000000000000 RBX: ffff965fc6ff20b0 RCX: ffffffffa2829cb8
> [   12.457350] RDX: 0000000000000001 RSI: 0000000000000082 RDI: ffffffffa3755d88
> [   12.457353] RBP: ffffffffa24a7980 R08: 0000000000000001 R09: 0000000000000442
> [   12.457355] R10: 0000000000000003 R11: 0000000000000000 R12: ffff965fc6ff2000
> [   12.457358] R13: 0000000000000000 R14: ffffffffa1b62550 R15: 0000000000000000
> [   12.457361] FS:  0000000000000000(0000) GS:ffff96671f440000(0000)
> knlGS:0000000000000000
> [   12.457365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.457368] CR2: 00007fff7670c11c CR3: 00000002c7c0a004 CR4: 00000000003606e0
> [   12.457370] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   12.457373] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   12.457374] Call Trace:
> [   12.457387]  ? __switch_to_asm+0x34/0x70
> [   12.457395]  __rpm_callback+0x70/0x1b0
> [   12.457401]  ? __switch_to_asm+0x34/0x70
> [   12.457406]  ? pci_dev_put+0x20/0x20
> [   12.457412]  rpm_callback+0x66/0x90
> [   12.457418]  ? pci_dev_put+0x20/0x20
> [   12.457424]  rpm_suspend+0x15a/0x570
> [   12.457431]  pm_runtime_work+0x8c/0xa0
> [   12.457439]  process_one_work+0x1d2/0x350
> [   12.457446]  worker_thread+0x28/0x3d0
> [   12.457453]  ? wq_calc_node_cpumask.constprop.50+0x20/0x20
> [   12.457457]  kthread+0x103/0x120
> [   12.457462]  ? kthread_create_on_node+0x90/0x90
> [   12.457468]  ret_from_fork+0x35/0x40
> [   12.457472] ---[ end trace aa262aac85ec967a ]---
