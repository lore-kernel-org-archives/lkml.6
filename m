Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20279C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92B8205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkZ543KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92B8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeH3QEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:04:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33421 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeH3QEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:04:51 -0400
Received: by mail-io0-f195.google.com with SMTP id r196-v6so7330421iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g43ii98jlS2GP4lq6RvdUCodvSB8M1KClKjyZgsuw8M=;
        b=KkZ543KFYenqm0kRtUEZGD3sc065rTITKbIL6wOzM02IK3qW5E4TPxM7F4Hqg81/R/
         ucdMusZdKb7aTOgMSO4YLtXo7iSIHW+B5TDr4bDlq12g0wVcnLJBBGa2r4saNnib9STH
         U2qHFk6dvQy1DvUexssDyYQehr3ZDAgisq2bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g43ii98jlS2GP4lq6RvdUCodvSB8M1KClKjyZgsuw8M=;
        b=rzUZnJDBq6F3gO/9aUIJfgfj5wDzT69Cb8qvLn/cZluRdRaKRKuLULJ5lYqIrt/6X5
         6J/BO0IqDO83q3xcg1UYgJRk96qO9kNMkKJkGaBc6tK1m/vWxtvfbk157d6PAz3DL/WU
         sA68Tp5+cv19VXt6iNZ0ism4P4m2nLG3f9N1ZTkpLrsF6Y6ZX4S8hNxOc8nmiw6vFJ0Q
         oGKbH9FsCMYhz8IvZcohKn8Op0v2du9KeC/cuJdylpEThQcD/1ptWH5oizC7+mr6ZILd
         stYwGOHYy46eL6wUoovxt563c6NBsFdjm6so80YUTByzHAxGwljg0KV+3SZmtc+UGDyl
         6guw==
X-Gm-Message-State: APzg51BBkF01Q7pr+bOgZcPSZFchs181zA4kZwKDC9Xvja2fYijBEuyn
        nKlMOPTaXp3G4qOsCF73nZLVIHBrIgOeTSz6BeznLA==
X-Google-Smtp-Source: ANB0VdadnJnTL7nb8OTOkV6EhN0hiqGChAWqT1jFO0yujcgU7fqxUtt4MCywJJ+o5XXo9uw9j1aOwkMLLhYMnq4LjcY=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr8566957iou.218.1535630581315;
 Thu, 30 Aug 2018 05:03:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 05:03:00
 -0700 (PDT)
In-Reply-To: <6c696030-51a5-9ab9-47a9-d6fa3000a8a3@interlog.com>
References: <6c696030-51a5-9ab9-47a9-d6fa3000a8a3@interlog.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Aug 2018 14:03:00 +0200
Message-ID: <CAPDyKFqk+K7TOyHoB1-+sguxbS_1s=RwCRiFMdrWOaSVhkpqJQ@mail.gmail.com>
Subject: Re: 4.19.0-rc1 rtsx_pci_sdmmc.0: error: data->host_cookie = 62,
 host->cookie = 63
To:     dgilbert@interlog.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 August 2018 at 23:47, Douglas Gilbert <dgilbert@interlog.com> wrote:
> I usually boot my Lenovo X270 with a SD card in its:
>   # lspci
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI
> Express Card Reader (rev 01)
> ...
>
> In lk 4.19.0-rc1 the boot locks up solid, almost immediately and nothing in
> the logs. If I remove the SD card my machine boots and works okay until I
> insert the SD card. Then:
>
> Aug 28 23:30:38 xtwo70 kernel: mmc0: cannot verify signal voltage switch
> Aug 28 23:30:38 xtwo70 kernel: mmc0: new ultra high speed SDR104 SDXC card
> at address aaaa
> Aug 28 23:30:38 xtwo70 kernel: mmcblk0: mmc0:aaaa ACLCE 59.5 GiB
> Aug 28 23:30:38 xtwo70 kernel: mmcblk0: p1 p2
> Aug 28 23:30:38 xtwo70 kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: error:
> data->host_cookie = 62, host->cookie = 63
> Aug 28 23:30:38 xtwo70 kernel: BUG: unable to handle kernel NULL pointer
> dereference at 0000000000000018
> Aug 28 23:30:38 xtwo70 kernel: PGD 0 P4D 0
> Aug 28 23:30:38 xtwo70 kernel: Oops: 0000 [#1] SMP
> Aug 28 23:30:38 xtwo70 kernel: CPU: 3 PID: 1571 Comm: kworker/3:2 Not
> tainted 4.19.0-rc1 #78
> Aug 28 23:30:38 xtwo70 kernel: Hardware name: LENOVO 20HNCTO1WW/20HNCTO1WW,
> BIOS R0IET53W (1.31 ) 05/22/2018
> Aug 28 23:30:38 xtwo70 kernel: Workqueue: events sd_request [rtsx_pci_sdmmc]
> Aug 28 23:30:38 xtwo70 kernel: RIP: 0010:rtsx_pci_dma_transfer+0x6e/0x260
> [rtsx_pci]
> Aug 28 23:30:38 xtwo70 kernel: Code: 49 89 fe 45 89 c5 c7 87 90 00 00 00 00
> 00 00 00 8d 6a ff 81 c9 00 00 00 88 31 d2 41 89 cc 45 31 ff eb 07 41 8b 96
> 90 00 00 00 <8b> 78 18 48 63 ca 31 f6 44 39 fd 48 8b 50 10 40 0f 94 c6 41 83
> c7
> Aug 28 23:30:38 xtwo70 kernel: RSP: 0018:ffffc90000217d78 EFLAGS: 00010202
> Aug 28 23:30:38 xtwo70 kernel: RAX: 0000000000000000 RBX: 0000000000000003
> RCX: 0000000000000000
> Aug 28 23:30:38 xtwo70 kernel: RDX: 0000000000000001 RSI: 0000000000000021
> RDI: ffff8801b6328000
> Aug 28 23:30:38 xtwo70 kernel: RBP: 0000000000000002 R08: ffff880036000400
> R09: 0000000000000000
> Aug 28 23:30:38 xtwo70 kernel: R10: 0000000000000000 R11: 0000000000000000
> R12: 00000000a8000000
> Aug 28 23:30:38 xtwo70 kernel: R13: 0000000000002710 R14: ffff88021fd35400
> R15: 0000000000000001
> Aug 28 23:30:38 xtwo70 kernel: FS:  0000000000000000(0000)
> GS:ffff880227380000(0000) knlGS:0000000000000000
> Aug 28 23:30:38 xtwo70 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Aug 28 23:30:38 xtwo70 kernel: CR2: 0000000000000018 CR3: 000000000400f006
> CR4: 00000000003606e0
> Aug 28 23:30:38 xtwo70 kernel: Call Trace:
> Aug 28 23:30:38 xtwo70 kernel: ? mark_held_locks+0x50/0x80
> Aug 28 23:30:38 xtwo70 kernel: ? _raw_spin_unlock_irqrestore+0x2d/0x40
> Aug 28 23:30:38 xtwo70 kernel: sd_request+0x385/0x81a [rtsx_pci_sdmmc]
> Aug 28 23:30:38 xtwo70 kernel: process_one_work+0x287/0x5e0
> Aug 28 23:30:38 xtwo70 kernel: worker_thread+0x28/0x3d0
> Aug 28 23:30:38 xtwo70 kernel: ? process_one_work+0x5e0/0x5e0
> Aug 28 23:30:38 xtwo70 kernel: kthread+0x10e/0x130
> Aug 28 23:30:38 xtwo70 kernel: ? kthread_park+0x80/0x80
> Aug 28 23:30:38 xtwo70 kernel: ret_from_fork+0x3a/0x50
> Aug 28 23:30:38 xtwo70 kernel: Modules linked in: mmc_block fuse msr bnep
> ccm btusb btrtl btbcm btintel bluetooth squashfs ecdh_generic binfmt_misc
> intel_rapl nls_iso8859_1 nls_cp437 x86_pkg_temp_thermal vfat
> intel_powerclamp fat coretemp kvm_intel arc4 snd_hda_codec_hdmi kvm
> snd_hda_codec_realtek snd_hda_codec_generic irqbypass crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel pcbc iwlmvm aesni_intel aes_x86_64
> crypto_simd cryptd glue_helper mac80211 intel_cstate intel_uncore
> intel_rapl_perf snd_hda_intel joydev snd_hda_codec mousedev snd_hwdep
> iwlwifi snd_hda_core input_leds efi_pstore snd_pcm serio_raw efivars
> cfg80211 rtsx_pci_ms memstick mei_me idma64 virt_dma mei intel_lpss_pci
> intel_lpss intel_pch_thermal thinkpad_acpi nvram snd_seq_dummy tps6598x
> snd_seq_oss typec snd_seq_midi snd_rawmidi snd_seq_midi_event
> Aug 28 23:30:38 xtwo70 kernel: snd_seq snd_seq_device snd_timer snd
> soundcore rfkill tpm_crb tpm_tis tpm_tis_core tpm evdev mac_hid pcc_cpufreq
> ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 xt_hl ip6t_rt ipt_REJECT
> nf_reject_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_tcpudp
> xt_addrtype xt_conntrack ip6table_filter ip6_tables nf_conntrack_netbios_ns
> nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter parport_pc ppdev lp
> parport efivarfs ip_tables x_tables autofs4 hid_logitech_hidpp
> hid_logitech_dj hid_generic usbhid hid rtsx_pci_sdmmc mmc_core i915 nvme
> e1000e i2c_algo_bit nvme_core drm_kms_helper syscopyarea sysfillrect
> sysimgblt fb_sys_fops xhci_pci drm xhci_hcd video
> drm_panel_orientation_quirks usbcore intel_gtt agpgart usb_common rtsx_pci
> Aug 28 23:30:38 xtwo70 kernel: CR2: 0000000000000018
> Aug 28 23:30:38 xtwo70 kernel: ---[ end trace bb8ce18072d22d51 ]---
> Aug 28 23:30:38 xtwo70 dbus-daemon[2110]: [system] Activating via systemd:
> service name='org.freedesktop.hostname1'
> unit='dbus-org.freedesktop.hostname1.service' requested by ':1.77' (uid=1000
> pid=3518 comm="/usr/bin/gnome-shell ")
> Aug 28 23:30:38 xtwo70 systemd[1]: Attaching egress BPF program to cgroup
> /sys/fs/cgroup/unified/system.slice/systemd-hostnamed.service failed:
> Invalid argument
> Aug 28 23:30:38 xtwo70 systemd[1]: Starting Hostname Service...
> Aug 28 23:30:39 xtwo70 kernel: RIP: 0010:rtsx_pci_dma_transfer+0x6e/0x260
> [rtsx_pci]
> Aug 28 23:30:39 xtwo70 kernel: Code: 49 89 fe 45 89 c5 c7 87 90 00 00 00 00
> 00 00 00 8d 6a ff 81 c9 00 00 00 88 31 d2 41 89 cc 45 31 ff eb 07 41 8b 96
> 90 00 00 00 <8b> 78 18 48 63 ca 31 f6 44 39 fd 48 8b 50 10 40 0f 94 c6 41 83
> c7
> Aug 28 23:30:39 xtwo70 kernel: RSP: 0018:ffffc90000217d78 EFLAGS: 00010202
> Aug 28 23:30:39 xtwo70 kernel: RAX: 0000000000000000 RBX: 0000000000000003
> RCX: 0000000000000000
> Aug 28 23:30:39 xtwo70 kernel: RDX: 0000000000000001 RSI: 0000000000000021
> RDI: ffff8801b6328000
> Aug 28 23:30:39 xtwo70 kernel: RBP: 0000000000000002 R08: ffff880036000400
> R09: 0000000000000000
> Aug 28 23:30:39 xtwo70 kernel: R10: 0000000000000000 R11: 0000000000000000
> R12: 00000000a8000000
> Aug 28 23:30:39 xtwo70 kernel: R13: 0000000000002710 R14: ffff88021fd35400
> R15: 0000000000000001
> Aug 28 23:30:39 xtwo70 kernel: FS:  0000000000000000(0000)
> GS:ffff880227380000(0000) knlGS:0000000000000000
> Aug 28 23:30:39 xtwo70 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Aug 28 23:30:39 xtwo70 kernel: CR2: 000056531391e498 CR3: 000000000400f006
> CR4: 00000000003606e0
>
>
> Doug Gilbert

Thanks for reporting!

I don't fine anything obvious from the mmc host driver point of view.
However, there are a few changes in the mmc core layer which we
already have fixes for.

You may either try my fixes branch from my mmc tree or use Stephen's
tree and the branch pending fixes, to see if that fixes the problem.

git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git fixes

git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes

Kind regards
Uffe
