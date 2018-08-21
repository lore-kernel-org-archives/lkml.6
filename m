Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60739C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1941121837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WHLNtQ2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1941121837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHUVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:53:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45176 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeHUVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:53:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so9156740pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=g8IpY6hzTZwIrzQA58MO50kervf+ZjMhPMKD1MIyhkI=;
        b=WHLNtQ2Cz0hR0bGvc19P9GieGuL2RJSWGUx1nL2yT3dNpOSYjOYUSWzzlnHHgpAFzC
         Wi6X8E894kpVME/sMqatJXHlnbbFp6ENpi1QmRaZ2ZC47aZHFWUNKShyS+lHkeHjhdUw
         sPOgAPZHc209ldLPURNlSAdb7emXr/7aZWrJ8EJv4ZRW4DvgWsGPH2ZyWlkma9xWk86u
         +gds4kZPwlw1nKD/JxXSs0vNmrWVo4BQtHjrw8dum1S7P2T1xqZLO0BGhvjUTXk0coV1
         MaG5d/pO0SH9KhnV0iA1oZjV+vTC50EENTnbW3bHiTuD+NahKZeTcSbPa3/r+QBwLS04
         sFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=g8IpY6hzTZwIrzQA58MO50kervf+ZjMhPMKD1MIyhkI=;
        b=sdfoCUh3DWk7Gy23HakJ34n8DeV9swp5oQNM2Jd6OywiEZLmoen2EGD8o2Yc39LPS7
         f9jTlecP+TRHT+z+RSBgH0pozWl86QL/Eg2fRt9Rr4GVHNkQLqLgHz3ay7ciuPFpl90r
         I5uW0qoI+ZcSKnVDmANNNmORd3P3Rp+QTiX+kMcnvZcmD+Vb0OxyJ0wvhY7FrBOfwTCq
         9x41IfuT81r6sP9yaofVIcqqwytmjDc474AYY/ObSLONv9KiY86lsZ3DLtotvdW6CMsc
         PZZR1oz6XTPfoeQZQNGp97mDobsVkU2k3gJY1jArjB9lYQ8TBYEB+xO18qhK2F/JQMGl
         acrQ==
X-Gm-Message-State: AOUpUlFZ4MHgIVRUkKatK0/B/ezAXHex2Y0SWskKoCH/knhpsG1ajwak
        nDMyiGwZgOn9JVNGljHmDTLO+o/qOVg=
X-Google-Smtp-Source: AA+uWPxkz0wBGe0RA7zZs/iLFdzhxu3YRPaIUN+KAewG/alxTSp4fWhGOkp9drHnshfmRslZskk0ZA==
X-Received: by 2002:a17:902:654b:: with SMTP id d11-v6mr50763094pln.8.1534876309000;
        Tue, 21 Aug 2018 11:31:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h18-v6sm35357939pfa.173.2018.08.21.11.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 11:31:48 -0700 (PDT)
Date:   Tue, 21 Aug 2018 11:31:48 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 11:24:28 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
In-Reply-To: <20180818133759.GA20049@roeck-us.net>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-d01c95f5-d4bb-49c5-addb-78b09911f6cd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2018 06:37:59 PDT (-0700), linux@roeck-us.net wrote:
> Hi Palmer,
>
> On Fri, Aug 17, 2018 at 01:28:11PM -0700, Palmer Dabbelt wrote:
> [ ... ]
>
>>
>> This tag boots a Fedora root filesystem on QEMU's master branch for me,
>> and before this morning's rebase (from 4.18-rc8 to 4.18) it booted on
>> the HiFive Unleashed.
>>
>
> Do you have vmlinux embedded in bbl ?
>
> With separate bbl and vmlinux, and the following qemu command line
> (with qemu 3.0)
>
> qemu-system-riscv64 -M virt -m 512M -no-reboot \
> 	-bios bbl -kernel vmlinux \
> 	-netdev user,id=net0 -device virtio-net-device,netdev=net0 \
> 	-device virtio-blk-device,drive=d0 \
> 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
> 	-append 'root=/dev/vda rw console=ttyS0,115200' \
> 	-nographic -monitor none
>
> all I get is
>
> rom: requested regions overlap (rom mrom.reset. free=0x000000000001cbe8, addr=0x0000000000001000)
>
> However, the she system boots fine with the same qemu command line if I use qemu
> built from https://github.com/riscv/riscv-qemu.git, branch qemu-for-upstream.

Yes, I have a vmlinux built into my BBL.  I didn't actually look closely at the 
command line I was copying and see that vmlinux in there, my guess would be 
that it's getting ignored.  I don't remember if upstream BBL actually works 
with the split bbl/vmlinux setup, I've kind of stopped paying attention to BBL 
as I'm just waiting for someone to tell me instructions as to how to use a real 
bootloader... :)

I'm building master from QEMU as of a few weeks ago

    * f7502360397d - (HEAD -> master, tag: v3.0.0-rc3, origin/master, origin/HEAD) Update version for v3.0.0-rc3 release (3 weeks ago) <Peter Maydell>
    *   b89041647422 - Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2018-07-31' into staging (3 weeks ago) <Peter Maydell>
    |\
    | * 9a1054061c62 - monitor: temporary fix for dead-lock on event recursion (3 weeks ago) <Marc-André Lureau>
    |/
    *   42e76456cf68 - Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (3 weeks ago) <Peter Maydell>
    |\
    | * 5d9f3ea08172 - linux-user: ppc64: don't use volatile register during safe_syscall (3 weeks ago) <Shivaprasad G Bhat>
    | * 28cbb997d66e - tests: add check_invalid_maps to test-mmap (3 weeks ago) <Alex Bennée>
    | * 38138fab9358 - linux-user/mmap.c: handle invalid len maps correctly (3 weeks ago) <Alex Bennée>
    * |   45a505d0a4b3 - Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (3 weeks ago) <Peter Maydell>

in general once we get a port upstream I jump over to using master from 
upstream as that way we'll find any bugs quickly.  Michael Clark has a pretty 
big QEMU patch queue, but nothing appears to be critical for Linux boot.

> Excellent - once this series hits mainline, I'll add riscv to my
> boot tests.

Thanks!  I'm super excited to get CI stuff up and running as now that we can 
boot I'm worried people will notice when I screw something up :)
