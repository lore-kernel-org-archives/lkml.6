Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D97C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E6A21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mf09QgYB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n8FvuTpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfAKIME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:12:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbfAKIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:12:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9508B60908; Fri, 11 Jan 2019 08:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547194322;
        bh=4aPFGzg1sYUi9RN9kbgII9O0iJEGLlXwbc2oeZitpmc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mf09QgYBpkw5hASEjORbW5A4XI3hsMHip4jJ7dQrknoUntoJOmdIpFdRjyMUFjcZ9
         gaEMhlOxrgOlMIKepYIheR/uc0U6ainyqYZN8sIul86JyOXDkaXZRsWEeMU+u9ph0P
         pSlnwe9urchMy/tOuIFSEiGGMgVtkStUsF3q+zgI=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76AC8601B4;
        Fri, 11 Jan 2019 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547194320;
        bh=4aPFGzg1sYUi9RN9kbgII9O0iJEGLlXwbc2oeZitpmc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n8FvuTpgT2yXip4dbLhAj1zTK3aSh73L4yHOAY0mR8ObbhQN7CWHg3J5wxFf7ELr5
         hHAGZNQMpvpTLNm0YHMEPFoc4PNmXMvIqdDwnZF/l9WBSQyaIdHYx0DHATd59ZFIm/
         SPY0Gv7WkcYVnffg4tXtOjdqvnogHH1Z0PH90ExI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76AC8601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2] ASoC: soc-core: defer card probe until
 all component is added to list
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org
Cc:     Ajit Pandey <ajitp@codeaurora.org>
References: <1547023627-30312-1-git-send-email-rohitkr@codeaurora.org>
 <598efaa4-1543-5441-0d1d-01935dc62056@linux.intel.com>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <0294d952-18e6-7cd5-fbd0-5822571468f2@codeaurora.org>
Date:   Fri, 11 Jan 2019 13:41:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <598efaa4-1543-5441-0d1d-01935dc62056@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for reporting the issue.

On 1/11/2019 10:37 AM, Pierre-Louis Bossart wrote:
> While debugging Skylake audio stuff, I came across a kernel oops 
> introduced by this commit.
>
> It's quite late here and my brain is fried, submitting as is but my 
> money is on the use of link->platform->of_node which is quite unlikely 
> to work on ACPI platforms.
>

Right, either name or of_node should not be NULL for soc_find_component.

We will provide fix.

> and btw you may want to fix the typos, it's registration, not 
> registartion.


Sure.

>
> -Pierre
>
> 8780cf1142a59568a3aa77959cbd76b2edb6fd81 is the first bad commit
> commit 8780cf1142a59568a3aa77959cbd76b2edb6fd81
> Author: Ajit Pandey <ajitp@codeaurora.org>
> Date:   Wed Jan 9 14:17:07 2019 +0530
>
>     ASoC: soc-core: defer card probe until all component is added to list
>
>     DAI component probe is not called if it is not present
>     in component list during sound card registration.
>     Check if component is available in component list for
>     platform and cpu dai before soundcard registration.
>
>     Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
>     Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>     Signed-off-by: Mark Brown <broonie@kernel.org>
>
> :040000 040000 98da59b0a73551030a0c9030b8cd58114003c82b 
> 48f0618f37a16dcfea5999ecd9743edbb0763594 M    sound
>
> [    2.686029] HDMI HDA Codec ehdaudio0D2: Max dais supported: 3
> [    2.687854] BUG: unable to handle kernel NULL pointer dereference 
> at 0000000000000000
> [    2.687858] PGD 0 P4D 0
> [    2.687862] Oops: 0000 [#1] SMP PTI
> [    2.687866] CPU: 1 PID: 1647 Comm: systemd-udevd Not tainted 
> 4.20.0-rc7-test+ #88
> [    2.687867] Hardware name: Dell Inc. XPS 13 9350/07TYC2, BIOS 1.0.0 
> 09/10/2015
> [    2.687872] RIP: 0010:strcmp+0xc/0x20
> [    2.687875] Code: 75 f7 48 83 c6 01 0f b6 4e ff 48 83 c2 01 84 c9 
> 88 4a ff 75 ed f3 c3 0f 1f 80 00 00 00 00 48 83 c7 01 0f b6 47 ff 48 
> 83 c6 01 <3a> 46 ff 75 07 84 c0 75 eb 31 c0 c3 19 c0 83 c8 01 c3 66 90 
> 48 85
> [    2.687877] RSP: 0018:ffff9fadc104bb18 EFLAGS: 00010202
> [    2.687880] RAX: 0000000000000065 RBX: ffff9d6834ba5428 RCX: 
> 0000000000000001
> [    2.687882] RDX: ffffffffc0288d00 RSI: 0000000000000001 RDI: 
> ffff9d68351b5a61
> [    2.687883] RBP: 0000000000000000 R08: 0000000000000001 R09: 
> ffff9d6836dbfd80
> [    2.687885] R10: 0000000000000000 R11: ffff9d6835e65648 R12: 
> 0000000000000000
> [    2.687887] R13: 0000000000000000 R14: 0000000000000000 R15: 
> ffff9fadc104be98
> [    2.687889] FS:  00007f976806a8c0(0000) GS:ffff9d6838a80000(0000) 
> knlGS:0000000000000000
> [    2.687891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.687893] CR2: 0000000000000000 CR3: 00000002b4286002 CR4: 
> 00000000003606e0
> [    2.687895] Call Trace:
> [    2.687902]  soc_find_component+0x4c/0x70 [snd_soc_core]
> [    2.687908]  soc_init_dai_link+0x124/0x280 [snd_soc_core]
> [    2.687913]  snd_soc_register_card+0x6b/0x1f0 [snd_soc_core]
> [    2.687918]  ? __devres_alloc_node+0x2c/0x60
> [    2.687922]  devm_snd_soc_register_card+0x3e/0x80 [snd_soc_core]
> [    2.687926]  platform_drv_probe+0x35/0x90
> [    2.687930]  ? driver_sysfs_add+0x70/0xd0
> [    2.687932]  really_probe+0xee/0x2e0
> [    2.687935]  driver_probe_device+0x4a/0xe0
> [    2.687938]  __driver_attach+0xac/0xb0
> [    2.687941]  ? driver_probe_device+0xe0/0xe0
> [    2.687943]  bus_for_each_dev+0x71/0xb0
> [    2.687946]  bus_add_driver+0x191/0x210
> [    2.687948]  ? 0xffffffffc01bf000
> [    2.687951]  driver_register+0x56/0xe0
> [    2.687953]  ? 0xffffffffc01bf000
> [    2.687956]  do_one_initcall+0x41/0x1b8
> [    2.687960]  ? kobject_uevent_env+0x101/0x680
> [    2.687962]  ? _cond_resched+0x10/0x40
> [    2.687966]  ? kmem_cache_alloc_trace+0x35/0x160
> [    2.687969]  do_init_module+0x56/0x1db
> [    2.687973]  load_module+0x1e7c/0x2560
> [    2.687976]  ? vfs_read+0x10a/0x130
> [    2.687979]  ? __do_sys_finit_module+0xba/0xe0
> [    2.687983]  __do_sys_finit_module+0xba/0xe0
> [    2.687988]  do_syscall_64+0x43/0xf0
> [    2.687992]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    2.687995] RIP: 0033:0x7f9768aef219
> [    2.687998] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 
> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 
> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 fc 0c 00 f7 d8 64 89 
> 01 48
> [    2.688000] RSP: 002b:00007ffccf3a4c98 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000139
> [    2.688003] RAX: ffffffffffffffda RBX: 000055991cf57970 RCX: 
> 00007f9768aef219
> [    2.688006] RDX: 0000000000000000 RSI: 00007f97689d3cad RDI: 
> 000000000000000f
> [    2.688008] RBP: 00007f97689d3cad R08: 0000000000000000 R09: 
> 0000000000000000
> [    2.688010] R10: 000000000000000f R11: 0000000000000246 R12: 
> 0000000000000000
> [    2.688012] R13: 000055991cf49930 R14: 0000000000020000 R15: 
> 000055991cf57970
> [    2.688015] Modules linked in: snd_soc_skl_hda_dsp(+) 
> snd_soc_hdac_hdmi snd_soc_dmic ax88179_178a(+) usbnet 
> snd_hda_codec_realtek snd_hda_codec_generic snd_soc_skl 
> snd_soc_hdac_hda snd_hda_ext_core snd_soc_skl_ipc x86_pkg_temp_thermal 
> snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi 
> snd_soc_core snd_compress snd_hda_codec snd_hwdep snd_hda_core snd_pcm 
> efivarfs intel_lpss_pci xhci_pci intel_lpss mfd_core xhci_hcd
> [    2.688031] CR2: 0000000000000000
> [    2.688034] ---[ end trace 8b96d01935d9effd ]---
> [    2.688037] RIP: 0010:strcmp+0xc/0x20
> [    2.688039] Code: 75 f7 48 83 c6 01 0f b6 4e ff 48 83 c2 01 84 c9 
> 88 4a ff 75 ed f3 c3 0f 1f 80 00 00 00 00 48 83 c7 01 0f b6 47 ff 48 
> 83 c6 01 <3a> 46 ff 75 07 84 c0 75 eb 31 c0 c3 19 c0 83 c8 01 c3 66 90 
> 48 85
> [    2.688042] RSP: 0018:ffff9fadc104bb18 EFLAGS: 00010202
> [    2.688044] RAX: 0000000000000065 RBX: ffff9d6834ba5428 RCX: 
> 0000000000000001
> [    2.688046] RDX: ffffffffc0288d00 RSI: 0000000000000001 RDI: 
> ffff9d68351b5a61
> [    2.688048] RBP: 0000000000000000 R08: 0000000000000001 R09: 
> ffff9d6836dbfd80
> [    2.688050] R10: 0000000000000000 R11: ffff9d6835e65648 R12: 
> 0000000000000000
> [    2.688052] R13: 0000000000000000 R14: 0000000000000000 R15: 
> ffff9fadc104be98
> [    2.688055] FS:  00007f976806a8c0(0000) GS:ffff9d6838a80000(0000) 
> knlGS:0000000000000000
> [    2.688057] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.688059] CR2: 0000000000000000 CR3: 00000002b4286002 CR4: 
> 00000000003606e0
>
Thanks,

Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

