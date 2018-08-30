Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5EFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8282620834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXeflht5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8282620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeHaAdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:33:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39624 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaAdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:33:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so3286831wmq.4;
        Thu, 30 Aug 2018 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=f9/zIQyCSA7fblz6Zl5h7hr0vwXEyQ5lJJqqPVQFDgY=;
        b=rXeflht5N7yC8O+vGOwBw56AVA8L8hdQqqmmEtkEIxwifp4Q9zTPM2RgWa5s2YqbI9
         DGaSDmeq6Wm01rkumL2xV0Ps+02wGBggzZW4bOH1W3ugkoX1UFi/mEJpVN30nzs/39iz
         9RlvSR1pqDVbx+o7UQC69xR5EI9MfoaA8hyFsESfsQEzKAWNVKQwLaAi9DnoQkDhWaBa
         9pQMNK1uGSZQ/2ID+S0eHN5nymU1I6RxxrlFL12pKRJmR6cNBem3Idmveu3gE9Xp44no
         2MQSQrnox+jDWsTx4f4AcpF5lCNmajgVW28IM0fA6bz1J7/KY05D1zOuY961KvRDm/w4
         Fpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f9/zIQyCSA7fblz6Zl5h7hr0vwXEyQ5lJJqqPVQFDgY=;
        b=FEKCGjY6mrkIRjvTM/fiagpjWQOeNbuu+CvKVSBIqx4JRU9EcdYeW0pPbNkbft1NFq
         mUUdP5iniCTfEb7t0yAyFtjg8Ftqbn9aK40Qj9ivUcXfkMw88F/VZcd8ZmS93nhQUcrK
         HUBlRWWm+iMDQDVs9vgcmgdtMN5Cmp7Lvk41sr5BV0Lhxcvjgn4P3OL4RJjpuUJL4joS
         CZzOrmZRUGBu3p76RqLwDHCUHSM9iqFiQCI7nyQzwexR3Q2z0t4B2xUgeCIgwxiUO8xX
         NRZNc9HodrsTnvDdXFR2TnsVfqnxeKHkkat5nyCh7qwUAcoYifUBeQeF7WnNJ3g4/ifY
         f4CQ==
X-Gm-Message-State: APzg51BW2SxH2JSCdtFslLgrBNfWshdoiNxxRzJJDVq+OoL5tLkXeU8n
        W3QjReNgv+VV1HnqnkKCtZc=
X-Google-Smtp-Source: ANB0VdbfNeN5TFCslzEf61Av9WQbOSixsfH0b9QhXzXJtQyP94bDu4xBa+T0MXGB7cb6Uer63TXc2Q==
X-Received: by 2002:a1c:bd84:: with SMTP id n126-v6mr2830817wmf.67.1535660993727;
        Thu, 30 Aug 2018 13:29:53 -0700 (PDT)
Received: from [192.168.2.67] (p578F0EE7.dip0.t-ipconnect.de. [87.143.14.231])
        by smtp.gmail.com with ESMTPSA id i125-v6sm3924350wmd.23.2018.08.30.13.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:29:53 -0700 (PDT)
Subject: Re: [linux-sunxi] [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP
 tables and CPUfreq
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
 <20180830163833.v7zvmaz2vsxvzhur@core>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <64aaae69-b993-44b7-e159-2f9cd790d2a7@gmail.com>
Date:   Thu, 30 Aug 2018 22:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830163833.v7zvmaz2vsxvzhur@core>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2018 18:38, Ondřej Jirman wrote:
> Hello,
> 
> On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
>> Since we have now thermal trotteling enabeled we can now add the full
>> range of the OPP table.
> 
> I'm not sure we can. I have a tablet with A83T SoC and it gets unstable
> at these frequencies even with thermal throttling on mainline kernel. (Though
> I have my own THS driver, but I doubt a different driver will change much.)
> 
> There might be some other issue left in the cpufreq code. I'll let others
> test this on a better cooled boards though.
> 
> Did you/someone test this?
> 
> regards,
>    o.
I have a good cooled device, with big heatsinks and a fan blowing 
directly on it. But there is some big issue left!

cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
[   85.076270] Unable to handle kernel paging request at virtual address 
2e83c684
[   85.083519] pgd = (ptrval)
[   85.086220] [2e83c684] *pgd=00000000
[   85.089813] Internal error: Oops: 5 [#3] SMP ARM
[   85.094429] Modules linked in:
[   85.097483] CPU: 4 PID: 127 Comm: sh Tainted: G      D W 
4.18.0-00031-g8f59917020b9-dirty #2
[   85.106597] Hardware name: Allwinner A83t board
[   85.111130] PC is at down_write+0x14/0x54
[   85.115135] LR is at anon_vma_clone+0x9c/0x1e4
[   85.119571] pc : [<c066a3d4>]    lr : [<c01e71b8>]    psr: 60000013
[   85.125826] sp : ede45e70  ip : 000001a0  fp : eea3c690
[   85.131041] r10: eea4193c  r9 : 00400200  r8 : c0a942a4
[   85.136255] r7 : 2e83c680  r6 : eea3aea0  r5 : eea3b220  r4 : 2e83c684
[   85.142771] r3 : ffff0001  r2 : 2e83c680  r1 : ede45e58  r0 : 2e83c684
[   85.149287] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[   85.156410] Control: 10c5387d  Table: 6df1806a  DAC: 00000051
[   85.162145] Process sh (pid: 127, stack limit = 0x(ptrval))
[   85.167706] Stack: (0xede45e70 to 0xede46000)
[   85.172057] 5e60:                                     eea3b900 
c01e71b8 eea41900 ffebd684
[   85.180221] 5e80: c0a637b0 c07ea07c c0a10754 eea3aea0 eea41900 
c0a04c48 edd71880 00000000
[   85.188385] 5ea0: eea3aea0 eea41900 c0a69030 c01e7324 00000002 
edd701c0 c0a04c48 edd71880
[   85.196548] 5ec0: 00000000 c011c2f4 00000069 00000000 00000002 
00000000 00000000 00000000
[   85.204711] 5ee0: 00000000 edd701c0 edd82280 eea3af00 edd701f8 
edd718b8 eea3af08 eea3af14
[   85.212875] 5f00: eea3af10 ede44000 edd8255c 01200011 00000000 
ede45f14 ede45f14 b61ea11a
[   85.221039] 5f20: edd805c0 01200011 c0a04c48 beef38b0 00000000 
00000000 00000000 00000078
[   85.229202] 5f40: beef38dc c011ce0c 00000000 00000000 00000000 
ede44000 000000ae c012d9e0
[   85.237365] 5f60: eea43480 00000000 04000000 b61ea11a 00000000 
b6fb5068 b6f8b670 beef38b0
[   85.245529] 5f80: 00000078 c0101204 ede44000 00000078 beef38dc 
c011d1bc b6fb5068 00000000
[   85.253692] 5fa0: 000000ae c0101000 b6fb5068 b6f8b670 01200011 
00000000 00000000 00000000
[   85.261856] 5fc0: b6fb5068 b6f8b670 beef38b0 00000078 b6f8ac4c 
b6fb5490 ffffffff beef38dc
[   85.270020] 5fe0: 00000002 beef38b0 00000000 b6f5bfd0 60000010 
01200011 00000000 00000000
[   85.278191] [<c066a3d4>] (down_write) from [<c01e71b8>] 
(anon_vma_clone+0x9c/0x1e4)
[   85.285836] [<c01e71b8>] (anon_vma_clone) from [<c01e7324>] 
(anon_vma_fork+0x24/0x160)
[   85.293741] [<c01e7324>] (anon_vma_fork) from [<c011c2f4>] 
(copy_process.part.3+0xbc4/0x158c)
[   85.302253] [<c011c2f4>] (copy_process.part.3) from [<c011ce0c>] 
(_do_fork+0xb0/0x394)
[   85.310157] [<c011ce0c>] (_do_fork) from [<c011d1bc>] 
(sys_clone+0x20/0x28)
[   85.317107] [<c011d1bc>] (sys_clone) from [<c0101000>] 
(ret_fast_syscall+0x0/0x54)
[   85.324661] Exception stack(0xede45fa8 to 0xede45ff0)
[   85.329704] 5fa0:                   b6fb5068 b6f8b670 01200011 
00000000 00000000 00000000
[   85.337868] 5fc0: b6fb5068 b6f8b670 beef38b0 00000078 b6f8ac4c 
b6fb5490 ffffffff beef38dc
[   85.346021] 5fe0: 00000002 beef38b0 00000000 b6f5bfd0
[   85.351068] Code: e1a04000 f590f000 e3a03001 e34f3fff (e1902f9f)
[   85.357200] ---[ end trace aad10e0b4fcbf194 ]---


OR

cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
[   73.873939] ------------[ cut here ]------------
[   73.878584] WARNING: CPU: 5 PID: 132 at mm/rmap.c:235 
unlink_anon_vmas+0x1f4/0x1fc
[   73.886210] Modules linked in:
[   73.889276] CPU: 5 PID: 132 Comm: sh Tainted: G      D 
4.18.0-00031-g8f59917020b9-dirty #2
[   73.898391] Hardware name: Allwinner A83t board
[   73.902934] [<c010f310>] (unwind_backtrace) from [<c010bd54>] 
(show_stack+0x10/0x14)
[   73.910671] [<c010bd54>] (show_stack) from [<c0652f98>] 
(dump_stack+0x84/0x98)
[   73.917887] [<c0652f98>] (dump_stack) from [<c011dd14>] 
(__warn+0xfc/0x114)
[   73.924840] [<c011dd14>] (__warn) from [<c011de44>] 
(warn_slowpath_null+0x40/0x48)
[   73.932398] [<c011de44>] (warn_slowpath_null) from [<c01e7114>] 
(unlink_anon_vmas+0x1f4/0x1fc)
[   73.941006] [<c01e7114>] (unlink_anon_vmas) from [<c01da874>] 
(free_pgtables+0x78/0xcc)
[   73.948999] [<c01da874>] (free_pgtables) from [<c01e1e88>] 
(exit_mmap+0xe4/0x188)
[   73.956471] [<c01e1e88>] (exit_mmap) from [<c011b3a8>] (mmput+0x40/0xf0)
[   73.963169] [<c011b3a8>] (mmput) from [<c0208f1c>] 
(flush_old_exec+0x550/0x6e0)
[   73.970473] [<c0208f1c>] (flush_old_exec) from [<c0250e74>] 
(load_elf_binary+0x2f0/0x1324)
[   73.978726] [<c0250e74>] (load_elf_binary) from [<c02086c4>] 
(search_binary_handler+0xa0/0x234)
[   73.987412] [<c02086c4>] (search_binary_handler) from [<c02098b0>] 
(__do_execve_file+0x57c/0x6bc)
[   73.996271] [<c02098b0>] (__do_execve_file) from [<c0209c54>] 
(sys_execve+0x34/0x3c)
[   74.004003] [<c0209c54>] (sys_execve) from [<c0101000>] 
(ret_fast_syscall+0x0/0x54)
[   74.011645] Exception stack(0xede71fa8 to 0xede71ff0)
[   74.016690] 1fa0:                   000c530c 000c52d0 000c530c 
000c52d0 000c52dc 00000000
[   74.024853] 1fc0: 000c530c 000c52d0 000a2a0c 0000000b 000c52dc 
000c4b5c 000c4b5c 000c530c
[   74.033016] 1fe0: b6f25ed4 beef38b8 00042038 b6f25ee0
[   74.038086] ---[ end trace aad10e0b4fcbf192 ]---
[   74.042726] Unable to handle kernel paging request at virtual address 
2e83c684
[   74.049958] pgd = (ptrval)
[   74.052665] [2e83c684] *pgd=00000000
[   74.056243] Internal error: Oops: 5 [#2] SMP ARM
[   74.060851] Modules linked in:
[   74.063904] CPU: 5 PID: 132 Comm: sh Tainted: G      D W 
4.18.0-00031-g8f59917020b9-dirty #2
[   74.073019] Hardware name: Allwinner A83t board
[   74.077548] PC is at down_write+0x14/0x54
[   74.081553] LR is at unlink_anon_vmas+0xa8/0x1fc
[   74.086160] pc : [<c066a3d4>]    lr : [<c01e6fc8>]    psr: 60000013
[   74.092416] sp : ede71d88  ip : 00000000  fp : eea3b680
[   74.097630] r10: eea3c690  r9 : c0a637b0  r8 : eea41e40
[   74.102845] r7 : c0a942a4  r6 : 2e83c680  r5 : eea41e7c  r4 : 2e83c684
[   74.109360] r3 : ffff0001  r2 : ffff0001  r1 : 00000000  r0 : 2e83c684
[   74.115878] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[   74.123000] Control: 10c5387d  Table: 6de6406a  DAC: 00000051
[   74.128735] Process sh (pid: 132, stack limit = 0x(ptrval))
[   74.134296] Stack: (0xede71d88 to 0xede72000)
[   74.138645] 1d80:                   eea41e74 c01e6fc8 c07ea07c 
eea3c690 eea41f00 eea41e40
[   74.146809] 1da0: eea41d20 b6f17000 ede71df4 00002000 00000000 
edd9c300 ede71e90 c01da874
[   74.154973] 1dc0: b6f17000 c01dbf94 00000000 eea41360 00000000 
c0a04c48 edd716c0 edd826b0
[   74.163136] 1de0: edd90540 c01e1e88 eeabc6c8 00000001 00000000 
edd716c0 00000001 00000000
[   74.171299] 1e00: 00000000 ffffffff c0a68f40 00000000 000000ac 
00000400 eeacf000 eeb9f038
[   74.179463] 1e20: 00000100 b61ea11a 00000000 edd716c0 00000000 
edda8540 edd716c0 b61ea11a
[   74.187627] 1e40: edd716c0 00000000 edda8540 c011b3a8 edd716c0 
edd82280 edda8540 c0208f1c
[   74.195790] 1e60: 000000a0 c024f610 000000d4 c0a04c48 eeab4100 
00000000 edd9c300 eeab4134
[   74.203954] 1e80: eeabc6c0 edd9c400 ede71e90 c0250e74 effcec80 
effcec80 00000001 eeabc6c0
[   74.212118] 1ea0: eeaab180 eeabb000 00000000 c01d9704 effcec80 
80000013 beffff22 00000000
[   74.220281] 1ec0: ede70000 effcec80 edd9c300 c01d9344 00000000 
00000004 beffff22 00000000
[   74.228445] 1ee0: 00000034 00000000 00000011 ede71f20 00000000 
00000000 00000051 b61ea11a
[   74.236609] 1f00: befff000 c0a1130c edd9c300 c0a9558c fffffff8 
c0a10e3c c0a9558c c07ebbb4
[   74.244772] 1f20: 00000001 c02086c4 c0a0bbd4 c0a04c48 edda2000 
ffffe000 00000084 edd9c300
[   74.252936] 1f40: 00000001 00000000 00000000 c02098b0 c0a04f34 
edda8540 eeab8de0 edda8578
[   74.261100] 1f60: 00000000 b61ea11a 000c530c 000c52d0 000c52dc 
000a2a0c 0000000b c0101204
[   74.269263] 1f80: ede70000 0000000b 000c530c c0209c54 00000000 
00000000 20000010 000c530c
[   74.277428] 1fa0: 000c52d0 c0101000 000c530c 000c52d0 000c530c 
000c52d0 000c52dc 00000000
[   74.285592] 1fc0: 000c530c 000c52d0 000a2a0c 0000000b 000c52dc 
000c4b5c 000c4b5c 000c530c
[   74.293755] 1fe0: b6f25ed4 beef38b8 00042038 b6f25ee0 a0000010 
000c530c 00000000 00000000
[   74.301924] [<c066a3d4>] (down_write) from [<c01e6fc8>] 
(unlink_anon_vmas+0xa8/0x1fc)
[   74.309743] [<c01e6fc8>] (unlink_anon_vmas) from [<c01da874>] 
(free_pgtables+0x78/0xcc)
[   74.317733] [<c01da874>] (free_pgtables) from [<c01e1e88>] 
(exit_mmap+0xe4/0x188)
[   74.325204] [<c01e1e88>] (exit_mmap) from [<c011b3a8>] (mmput+0x40/0xf0)
[   74.331898] [<c011b3a8>] (mmput) from [<c0208f1c>] 
(flush_old_exec+0x550/0x6e0)
[   74.339195] [<c0208f1c>] (flush_old_exec) from [<c0250e74>] 
(load_elf_binary+0x2f0/0x1324)
[   74.347447] [<c0250e74>] (load_elf_binary) from [<c02086c4>] 
(search_binary_handler+0xa0/0x234)
[   74.356134] [<c02086c4>] (search_binary_handler) from [<c02098b0>] 
(__do_execve_file+0x57c/0x6bc)
[   74.364993] [<c02098b0>] (__do_execve_file) from [<c0209c54>] 
(sys_execve+0x34/0x3c)
[   74.372724] [<c0209c54>] (sys_execve) from [<c0101000>] 
(ret_fast_syscall+0x0/0x54)
[   74.380365] Exception stack(0xede71fa8 to 0xede71ff0)
[   74.385407] 1fa0:                   000c530c 000c52d0 000c530c 
000c52d0 000c52dc 00000000
[   74.393571] 1fc0: 000c530c 000c52d0 000a2a0c 0000000b 000c52dc 
000c4b5c 000c4b5c 000c530c
[   74.401733] 1fe0: b6f25ed4 beef38b8 00042038 b6f25ee0
[   74.406778] Code: e1a04000 f590f000 e3a03001 e34f3fff (e1902f9f)
[   74.412895] ---[ end trace aad10e0b4fcbf193 ]---

I think I will drop this patch until this issue is fixed.

Philipp
