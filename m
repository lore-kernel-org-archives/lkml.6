Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s1ztHXuUHluaKwAAmS7hNA
	; Mon, 11 Jun 2018 15:26:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7ACF9607BB; Mon, 11 Jun 2018 15:26:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIBeWNfk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D48E160385;
	Mon, 11 Jun 2018 15:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D48E160385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeFKP0I (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:26:08 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45130 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbeFKP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:26:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id n3-v6so31169426lfe.12;
        Mon, 11 Jun 2018 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KwjE/R7qSxqkVHPMK3uvhs2VsOaczK+qez3gpTHW7Bc=;
        b=PIBeWNfkjpIb493MjbT2T0Um5QgX/8w5UsEkNRFJpoCBxf5hqdha+GG31cSRkvbRks
         rsTuqPpKbwFZxBF/yXj2Z9CHn6De7mzRp4i95OrZb3AP2dJORWpBK8QaXo5VfuXc9uII
         knaPYBVwycFHuqwM8Z39XnRylBOM48srHJviuI7dgDq/wLTbP7G1H8HyOIWqnhYLtyUr
         pKtH+tMzfpzRM4ZyDgJ/WD/ha4QxWrKZlTSXG+oMzhDLNXmIDiEYoFwXCd2ldzJe0Phz
         DjD76SpgNy4PT16crow9x2KhWkyCpm7n5PMa/pZ4fwQliBjo5K0FYX9g4QHoHIsmU1vF
         dEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KwjE/R7qSxqkVHPMK3uvhs2VsOaczK+qez3gpTHW7Bc=;
        b=D8M4mb4osH3jlRrgIrDmjQDF1KL8zZDsiTvWVMTF+iNfgkPjGDsgNJ0stCz9j0X6UZ
         Uw3aB+XInBdC1lMYiZXwyAjJWHrlCJoVc9a9qh/dh98xdHz6s/ohajlNanh/GM4vkO49
         ZtvVMMnmBcc0KCPGJdk9+9Pz8fWzpUFITa90G4Ymj2b47f44HpEGUgPI1plchbv/rmji
         IcBcjiknM7mfItW3EZLbMOfLQnBVg7/VGGKK3ZZmOclVKycvhp2/V8pUyd9iZen9Oxzs
         txSjOZ1PycmqX6FU0IPD8wucKKlZRXcweWuKztm8g39oJ4ZPUrvl4lVUeaxJWc2Q1/PS
         C9jw==
X-Gm-Message-State: APt69E1BGoPVeHo2gvo2gsha/HQw8wYhQRXefOOOQLzyQ70KkEAxqLhk
        aMS4brUeKzsmVY/U2pkqcYo=
X-Google-Smtp-Source: ADUXVKIhFVIWOExKVcqJTQDfyd4y9eyMFx24pebDMjdGYgaG1EyjnNlSQ0ZuxQ538pLNvmWVYRFaaA==
X-Received: by 2002:a19:274e:: with SMTP id n75-v6mr5678817lfn.14.1528730764021;
        Mon, 11 Jun 2018 08:26:04 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id o7-v6sm3458419ljh.97.2018.06.11.08.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:26:03 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fSOhR-0003g7-FG; Mon, 11 Jun 2018 17:25:42 +0200
Date: Mon, 11 Jun 2018 17:25:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: 4.16.14: kernel tried to execute NX-protected page [after USB
 device went to charging state]
Message-ID: <20180611152541.GB13775@localhost>
References: <12230457-6839-c320-c270-be4916486438@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12230457-6839-c320-c270-be4916486438@xs4all.nl>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +CC: linux-usb, even if this does not look like a USB issue ] 

On Sat, Jun 09, 2018 at 11:50:34AM +0200, Udo van den Heuvel wrote:
> Hello,
> 
> My Holus GPSport 245 was used to download a gpx track. Afterwards I 
> turned the device off while it was attached to USB so it could charge.
> Later I found these messages you can find below.
> Is this an actual bug?

Well, you've got some kind of corruption going on somewhere.

> [223632.768623] usb 1-7: cp210x converter now attached to ttyUSB0
> [225389.048501] usb 1-7: USB disconnect, device number 6
> [225389.048758] cp210x ttyUSB0: cp210x converter now disconnected from 
> ttyUSB0
> [225389.048785] kernel tried to execute NX-protected page - exploit 
> attempt? (uid: 0)
> [225389.048788] BUG: unable to handle kernel paging request at 
> ffffffffc08b64e0
> [225389.048797] IP: usb_serial_exit+0x35df/0xff [usbserial]
> [225389.048799] PGD 2ea00c067 P4D 2ea00c067 PUD 2ea00e067 PMD 408590067 
> PTE 8000000109510163
> [225389.048807] Oops: 0011 [#1] PREEMPT SMP NOPTI
> [225389.048809] Modules linked in: cp210x usbserial it87(O) hwmon_vid 

First, please try and reproduce this after blacklisting this out-of-tree
it87 module.

> fuse ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport iptable_filter 
> ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 
> nf_defrag_ipv4 nf_nat_ipv4 nf_nat cpufreq_userspace 
> nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT 
> nf_reject_ipv6 xt_tcpudp nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack 
> msr nf_conntrack ip6table_filter ip6_tables eeprom uvcvideo 
> videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 snd_usb_audio videodev 
> snd_hwdep videobuf2_common cdc_acm snd_usbmidi_lib snd_rawmidi amdgpu 
> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec 
> snd_hda_core snd_seq snd_seq_device snd_pcm chash snd_timer gpu_sched 
> backlight snd ttm i2c_piix4 evdev acpi_cpufreq k10temp nfsd auth_rpcgss 
> nfs_acl
> [225389.048857]  lockd grace sunrpc binfmt_misc ip_tables x_tables 
> hid_generic sr_mod cdrom usbhid i2c_dev autofs4 [last unloaded: hwmon_vid]
> [225389.048871] CPU: 1 PID: 5717 Comm: kworker/1:2 Tainted: G 
> O     4.16.14 #5
> [225389.048873] Hardware name: Gigabyte Technology Co., Ltd. X470 AORUS 
> ULTRA GAMING/X470 AORUS ULTRA GAMING-CF, BIOS F3g 05/10/2018
> [225389.048880] Workqueue: usb_hub_wq hub_event
> [225389.048886] RIP: 0010:usb_serial_exit+0x35df/0xff [usbserial]
> [225389.048889] RSP: 0018:ffff90d3c8c27be8 EFLAGS: 00010282
> [225389.048892] RAX: ffffffffc08b64e0 RBX: ffff8bd5d2190ae8 RCX: 
> 0000000000000000
> [225389.048895] RDX: 0000000080000001 RSI: 0000000000000282 RDI: 
> ffff8bd5d2190ad8
> [225389.048897] RBP: ffff8bd5d2190ad8 R08: 0000000000000000 R09: 
> 0000000000000000
> [225389.048899] R10: 0000000000000000 R11: 0000000000000000 R12: 
> ffff8bd392029480
> [225389.048902] R13: ffff8bd64b4d4e00 R14: ffff8bd64d2fc030 R15: 
> ffff8bd64d2fc030
> [225389.048905] FS:  0000000000000000(0000) GS:ffff8bd65ee40000(0000) 
> knlGS:0000000000000000
> [225389.048908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [225389.048910] CR2: ffffffffc08b64e0 CR3: 00000003f0b50000 CR4: 
> 00000000003406e0
> [225389.048912] Call Trace:
> [225389.048918]  ? device_release+0x39/0xa0
> [225389.048924]  ? kobject_put+0xa1/0x1c0
> [225389.048929]  ? usb_serial_put+0x4c/0xf0 [usbserial]
> [225389.048933]  ? usb_serial_disconnect+0xdd/0x100 [usbserial]
> [225389.048938]  ? usb_unbind_interface+0x66/0x1e0
> [225389.048942]  ? device_release_driver_internal+0x17a/0x230
> [225389.048946]  ? bus_remove_device+0xe0/0x150
> [225389.048950]  ? device_del+0x129/0x330
> [225389.048954]  ? usb_disable_device+0x8d/0x230
> [225389.048958]  ? usb_disconnect+0xb1/0x270
> [225389.048962]  ? hub_event+0x5f5/0x13b0
> [225389.048967]  ? SyS_uname+0x11/0xa0
> [225389.048971]  ? process_one_work+0x1a1/0x2f0
> [225389.048974]  ? worker_thread+0x26/0x3f0
> [225389.048978]  ? process_one_work+0x2f0/0x2f0
> [225389.048982]  ? kthread+0x109/0x120
> [225389.048986]  ? kthread_create_on_node+0x60/0x60
> [225389.048991]  ? ret_from_fork+0x22/0x40
> [225389.048994] Code: ff ff ff 29 1a 8b c0 ff ff ff ff 50 73 8b c0 ff ff 
> ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> 00 00 <e0> 34 8b c0 ff ff ff ff 00 00 00 00 00 00 00 00 00 65 8b c0 ff
> [225389.049043] RIP: usb_serial_exit+0x35df/0xff [usbserial] RSP: 
> ffff90d3c8c27be8
> [225389.049045] CR2: ffffffffc08b64e0
> [225389.049048] ---[ end trace 43c4e5674b0ca81f ]---

This looks to me like you've got a struct device whose release pointer
is pointing into a non-executable page.

The IP symbol looks weird

	usb_serial_exit+0x35df/0xff

but this could correspond with usb_serial_port_release (check
/proc/kallsyms as root).

Enabling dynamic debugging for usbserial might give some indication of
how far you get in usb_serial_put(), but this smells like an x86/mem
(or hardware?) issue.

Did you say you could reproduce this easily?

Johan
