Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB51C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907372086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5jirQJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907372086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeIDIrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:47:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35579 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIDIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:47:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id q13-v6so1834317lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0IRW2G9Fds/0otGo66FD/TWUGs/vYpaxYW1RpZFBLQQ=;
        b=M5jirQJ6O9cFHPqelQQkcWOuAcQuAhVl9GL1iXpVcHP85pWzXQ0lPKBFF1ITdKU7H6
         ZEAWrpEvhVvTz1IAAaK2uqt57HH1D528e7m8Wi1ZaYmFLU3K7cZAjcOgwib3xn9R41TP
         rbFkjWwJZBTF33yBCEOt3N4zmuzubgJ9JX6XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0IRW2G9Fds/0otGo66FD/TWUGs/vYpaxYW1RpZFBLQQ=;
        b=ccOb+CAcB8GMCJpnWDJwYaU4a1zza23ygDqWuy0pfo78tQFzzM+ff243plubiA0gpa
         e8FjFcHrA76cWQZHMEdMTjxorGJLKlzxnxy1Sx2tYOUPS0+1vgFUW9YVSr8fAgBZYkJy
         VU3Twg9jnwEbR/+Ig0IqvI9fLtRzb1hVygOYB6SZPGfmjaLeflQn5rILFRaJzUe8Ev79
         sRLD4lARQG6ppfbLShAT9spJxJwMVtbaxwSD+mwncHkn7eOkqOmXeqDCpVGzJnDCWSnI
         XJfO0IKx6jbUjoSEcvBpHrKOQgBqQEtmmkfJtzHf7JGTSy3MogkWua0jcYVBvk9BHw4Y
         UMew==
X-Gm-Message-State: APzg51BmQutx+TMUY693SoZ7UxuXQ1sRoNZCo5Gao54lNhCuRbc5UFZs
        yqtHMKmPnXrZ6LuHqfR5rMCp+itL0aOXvANr0Y4AoA==
X-Google-Smtp-Source: ANB0Vda0uyvrS6JPl71CQdb0BGgo6tAakCmptVppXDKKnpXjjhg8aJ/FKurb3Dl0toVuiBDvNuOsNDLzU2maapwp6Vs=
X-Received: by 2002:a19:e21b:: with SMTP id z27-v6mr20082084lfg.68.1536035046761;
 Mon, 03 Sep 2018 21:24:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:180c:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 21:24:06 -0700 (PDT)
In-Reply-To: <8147a9c3-256b-023a-932f-f3b45cb80a16@gmail.com>
References: <20180903165719.499675257@linuxfoundation.org> <64889a4a-c095-3db8-b496-631acbafcf9a@applied-asynchrony.com>
 <8147a9c3-256b-023a-932f-f3b45cb80a16@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Sep 2018 09:54:06 +0530
Message-ID: <CA+G9fYv2RJj9NC6NqhkNo1J6dXKS+nn3_+kGVPNwFqygRnYZWw@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
To:     =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 September 2018 at 02:46, Fran=C3=A7ois Valenduc
<francoisvalenduc@gmail.com> wrote:
> Le 3/09/18 =C3=A0 20:39, Holger Hoffst=C3=A4tte a =C3=A9crit :
>> On 09/03/18 18:55, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.18.6 release.
>>
>> Unfortunately this is busted. First blamed my custom patches, but as it
>> turns out a 100% vanilla 4.18.6 build crashes as well. Single-user start=
s,
>> but later when starting services and esp. autofs (I think - too much
>> output)
>> explodes with:
>>
>> ...
>> Sep  3 20:19:36 ragnarok kernel: IPv6: ADDRCONF(NETDEV_UP): eth0: link
>> is not ready
>> Sep  3 20:19:38 ragnarok kernel: BUG: stack guard page was hit at
>> 00000000ab58c99c (stack is 00000000382b9464..00000000d642b9d6)
>> Sep  3 20:19:38 ragnarok kernel: kernel stack overflow (double-fault):
>> 0000 [#1] SMP
>> Sep  3 20:19:38 ragnarok kernel: CPU: 4 PID: 3634 Comm: automount
>> Tainted: G           O      4.18.6 #1
>> Sep  3 20:19:38 ragnarok kernel: Hardware name: Gigabyte Technology Co.,
>> Ltd. P67-DS3-B3/P67-DS3-B3, BIOS F1 05/06/2011
>> Sep  3 20:19:38 ragnarok kernel: RIP:
>> 0010:flush_tlb_func_common.constprop.4+0x23/0x260
>> Sep  3 20:19:38 ragnarok kernel: Code: 0b eb e5 0f 1f 40 00 66 66 66 66
>> 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 f0 48 83 ec 20 65 48
>> 8b 04 25 28 00 00 00 <48> 89 44 24 18 31 c0 65 66 8b 1d 96 fd fc 7e 0f
>> b7 c3 65 48 8b 15
>> Sep  3 20:19:38 ragnarok kernel: RSP: 0018:ffffc9000326bfe0 EFLAGS:
>> 00010082
>> Sep  3 20:19:38 ragnarok kernel: RAX: cf0a75e3a0e78e00 RBX:
>> ffff880601006cc0 RCX: 0000000000000000
>> Sep  3 20:19:38 ragnarok kernel: RDX: 00007fb464e7e000 RSI:
>> 0000000000000003 RDI: ffffc9000326c040
>> Sep  3 20:19:38 ragnarok kernel: RBP: ffffc9000326c030 R08:
>> 00000005fca490e7 R09: 00000000004fa811
>> Sep  3 20:19:38 ragnarok kernel: R10: 0000000000000002 R11:
>> 0000000000000000 R12: 0000000000000004
>> Sep  3 20:19:38 ragnarok kernel: R13: ffff8805fbab7600 R14:
>> ffff880601006cc0 R15: ffff880602dfb540
>> Sep  3 20:19:38 ragnarok kernel: FS:  00007fb469245240(0000)
>> GS:ffff88061f500000(0000) knlGS:0000000000000000
>> Sep  3 20:19:38 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Sep  3 20:19:38 ragnarok kernel: CR2: ffffc9000326bfd8 CR3:
>> 00000005feadb001 CR4: 00000000000606e0
>> Sep  3 20:19:38 ragnarok kernel: Call Trace:
>> Sep  3 20:19:38 ragnarok kernel:  flush_tlb_mm_range+0xff/0x110
>> Sep  3 20:19:38 ragnarok kernel:  ? cpumask_any_but+0x1f/0x40
>> Sep  3 20:19:38 ragnarok kernel:  ? cpumask_any_but+0x1f/0x40
>> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x76/0xc0
>> Sep  3 20:19:38 ragnarok kernel:  tlb_table_flush.part.13+0xe/0x30
>> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x54/0xc0
>> ..a few hundred times..
>> Sep  3 20:19:38 ragnarok kernel:  tlb_table_flush.part.13+0xe/0x30
>> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x54/0xc0
>> Sep  3 20:19:38 ragnarok kernel:  arch_tlb_finish_mmu+0x3a/0x70
>> Sep  3 20:19:38 ragnarok kernel:  tlb_finish_mmu+0x1f/0x30
>> Sep  3 20:19:38 ragnarok kernel:  unmap_region+0xdd/0x110
>> Sep  3 20:19:38 ragnarok kernel:  ? __vma_rb_erase+0x128/0x250
>> Sep  3 20:19:38 ragnarok kernel:  do_munmap+0x273/0x3f0
>> Sep  3 20:19:38 ragnarok kernel:  vm_munmap+0x5f/0xa0
>> Sep  3 20:19:38 ragnarok kernel:  __x64_sys_munmap+0x22/0x30
>> Sep  3 20:19:38 ragnarok kernel:  do_syscall_64+0x3e/0xe0
>> Sep  3 20:19:38 ragnarok kernel:  entry_SYSCALL_64_after_hwframe+0x44/0x=
a9
>> Sep  3 20:19:38 ragnarok kernel: RIP: 0033:0x7fb469081187
>> Sep  3 20:19:38 ragnarok kernel: Code: ff ff ff f7 d8 89 05 58 df 20 00
>> 48 c7 c0 ff ff ff ff eb 8a 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
>> b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 29 df 20 00
>> f7 d8 89 01 48 83
>> Sep  3 20:19:38 ragnarok kernel: RSP: 002b:00007ffef83ba548 EFLAGS:
>> 00000206 ORIG_RAX: 000000000000000b
>> Sep  3 20:19:38 ragnarok kernel: RAX: ffffffffffffffda RBX:
>> 0000562a1dca9010 RCX: 00007fb469081187
>> Sep  3 20:19:38 ragnarok kernel: RDX: 0000000000000002 RSI:
>> 0000000000204028 RDI: 00007fb464c79000
>> Sep  3 20:19:38 ragnarok kernel: RBP: 00007ffef83ba720 R08:
>> 00007fb46928e930 R09: 0000000000000000
>> Sep  3 20:19:38 ragnarok kernel: R10: 00007fb464e7d000 R11:
>> 0000000000000206 R12: 00007ffef83ba654
>> Sep  3 20:19:38 ragnarok kernel: R13: 00007ffef83ba610 R14:
>> 00007ffef83ba655 R15: 00007fb46928e000
>> Sep  3 20:19:38 ragnarok kernel: Modules linked in: autofs4 tcp_bbr
>> sch_fq_codel pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O)
>> it87 hwmon_vid x86_pkg_temp_thermal uvcvideo videobuf2_vmalloc
>> videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hwdep bfq
>> snd_usbmidi_lib videodev snd_rawmidi coretemp snd_seq_device
>> videobuf2_common radeon usbhid kvm_intel i2c_algo_bit kvm
>> snd_hda_codec_realtek irqbypass drm_kms_helper snd_hda_codec_hdmi
>> snd_hda_codec_generic pcbc syscopyarea sysfillrect sysimgblt mq_deadline
>> fb_sys_fops ttm snd_hda_intel aesni_intel snd_hda_codec drm snd_hda_core
>> aes_x86_64 crypto_simd drm_panel_orientation_quirks cryptd snd_pcm
>> glue_helper backlight snd_timer snd i2c_i801 soundcore i2c_core r8169
>> parport_pc parport mii
>> Sep  3 20:19:38 ragnarok kernel: ---[ end trace cf25033b43d98311 ]---
>> Sep  3 20:19:38 ragnarok kernel: RIP:
>> 0010:flush_tlb_func_common.constprop.4+0x23/0x260
>> Sep  3 20:19:38 ragnarok kernel: Code: 0b eb e5 0f 1f 40 00 66 66 66 66
>> 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 f0 48 83 ec 20 65 48
>> 8b 04 25 28 00 00 00 <48> 89 44 24 18 31 c0 65 66 8b 1d 96 fd fc 7e 0f
>> b7 c3 65 48 8b 15
>> Sep  3 20:19:38 ragnarok kernel: RSP: 0018:ffffc9000326bfe0 EFLAGS:
>> 00010082
>> Sep  3 20:19:38 ragnarok kernel: RAX: cf0a75e3a0e78e00 RBX:
>> ffff880601006cc0 RCX: 0000000000000000
>> Sep  3 20:19:38 ragnarok kernel: RDX: 00007fb464e7e000 RSI:
>> 0000000000000003 RDI: ffffc9000326c040
>> Sep  3 20:19:38 ragnarok kernel: RBP: ffffc9000326c030 R08:
>> 00000005fca490e7 R09: 00000000004fa811
>> Sep  3 20:19:38 ragnarok kernel: R10: 0000000000000002 R11:
>> 0000000000000000 R12: 0000000000000004
>> Sep  3 20:19:38 ragnarok kernel: R13: ffff8805fbab7600 R14:
>> ffff880601006cc0 R15: ffff880602dfb540
>> Sep  3 20:19:38 ragnarok kernel: FS:  00007fb469245240(0000)
>> GS:ffff88061f500000(0000) knlGS:0000000000000000
>> Sep  3 20:19:38 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Sep  3 20:19:38 ragnarok kernel: CR2: ffffc9000326bfd8 CR3:
>> 00000005feadb001 CR4: 00000000000606e0
>> Sep  3 20:19:40 ragnarok kernel: r8169 0000:04:00.0 eth0: link up
>> Sep  3 20:19:40 ragnarok kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0:
>> link becomes ready
>>
>> This is repeatable; full log is available on request.
>>
>> Reverting
>> "mm-tlb-x86-mm-support-invalidating-tlb-caches-for-rcu_table_free"
>> makes everything work.
>>
>> I'm now going back to my custom tree with lazy TLB handling, that worked=
 as
>> advertised. :D
>>
>> cheers
>> Holger
>>
> I confirm this also for the 4.14 tree. I get the same errors and
> reverting the same patch also fixes the problem.

I do see this crash log on 4.18.6-rc1,
4.18.6-rc1 run full log,
https://lkft.validation.linaro.org/scheduler/job/404027#L3244

>
> Fran=C3=A7ois Valenduc

Best regards
Naresh Kamboju
