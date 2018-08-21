Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486D2217C9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EgoLdWdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486D2217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHVATk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:19:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38457 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVATk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:19:40 -0400
Received: by mail-pl0-f65.google.com with SMTP id u11-v6so9335845plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hAHWk6/qd9S7OusfCLBNHTNgXGAVK8jrW+6sAJHEyz4=;
        b=EgoLdWdhnTEiZ5T19gKs+KZTRsZqrCmf484bnngpIGuTj7vGiNZtoHQQB0Zb50fbHE
         mwXWeNwOye5PDj3StXWk5/FWTJDigPaq+9Uu9aWK5jsLeDw30Ld2LSTmVG8kpCe/8w//
         i9OlttY392K+qVHTYSfTI3o2G9gzSS/X2zdI7PKF8D41rFUS9FWeCPIwfSYomy7X+n1t
         sgBH9lrb5tch9iYuR+v/5/0iAdE9sCYe4RVe5pg10mO3hwplNSWsd3j7CPF0MFistjRG
         wC7uNYA7VXgzOhaxD7Iny7zYE0eJRyWThSBpf+4Yf4BX8HINwLFFxnWDuVsS61ohU152
         kbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hAHWk6/qd9S7OusfCLBNHTNgXGAVK8jrW+6sAJHEyz4=;
        b=Heyd0VF1q92yLNG7umMNXZchNt0sQe7m/gLJ2x8iFSqguZs0bO7gXVHOm9cIevvthr
         zlS1VxD8MBJNpNKD29Vs+otU+0vmFLHRhyfAiHxKdHb6gqXTSMAhTJH/s035N4Quu4OF
         Z5/P4OnoOQEH+37tFGPDEQEVJ0SoeUYoiEXeuBWn2U8uGvZQRlDJ8IFz34r0cnKwLixX
         w7+O6KocbzhU7waY+/yIzyXWjIIlXHcSCx7rBCU8SUL3AHuPII4q5uwt+9a9SAv0loU1
         1SBMUmbf8QWxoA5uizsr585s2uVEetgJiaOk422fhcrm9SuyIc0R3D/L2m5IHQ5bZ/EJ
         Y6Ug==
X-Gm-Message-State: AOUpUlGXIpaJfhNBicwWdFY14Jl8L/N4vXN4lQd5XOPhlyJcBARZdy9m
        ZQUnrQKEeN1M/Ze4QYMsKwDPOw==
X-Google-Smtp-Source: AA+uWPzx25ZYgaPhLl854Hs0vpAFBbQilvilfEn10UwJd41KGGI4qaYmB7WGRYmV07PkV2cIUOXjIg==
X-Received: by 2002:a17:902:47c2:: with SMTP id d2-v6mr50844580plh.139.1534885075500;
        Tue, 21 Aug 2018 13:57:55 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z22-v6sm21598625pgc.67.2018.08.21.13.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 13:57:54 -0700 (PDT)
Date:   Tue, 21 Aug 2018 13:57:54 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Aug 2018 13:56:53 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
In-Reply-To: <20180821194550.wrh3q2fkr6wmrovd@excalibur.cnev.de>
CC:     linux@roeck-us.net, linux-riscv@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     merker@debian.org
Message-ID: <mhng-d4882478-2772-4ef9-b79e-9b447a32cb8c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 12:45:50 PDT (-0700), merker@debian.org wrote:
> On Tue, Aug 21, 2018 at 11:31:48AM -0700, Palmer Dabbelt wrote:
>> On Sat, 18 Aug 2018 06:37:59 PDT (-0700), linux@roeck-us.net wrote:
> [...]
>> > Do you have vmlinux embedded in bbl ?
>> >
>> > With separate bbl and vmlinux, and the following qemu command line
>> > (with qemu 3.0)
>> >
>> > qemu-system-riscv64 -M virt -m 512M -no-reboot \
>> > 	-bios bbl -kernel vmlinux \
>> > 	-netdev user,id=net0 -device virtio-net-device,netdev=net0 \
>> > 	-device virtio-blk-device,drive=d0 \
>> > 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
>> > 	-append 'root=/dev/vda rw console=ttyS0,115200' \
>> > 	-nographic -monitor none
>> >
>> > all I get is
>> >
>> > rom: requested regions overlap (rom mrom.reset. free=0x000000000001cbe8, addr=0x0000000000001000)
>> >
>> > However, the she system boots fine with the same qemu command line if I use qemu
>> > built from https://github.com/riscv/riscv-qemu.git, branch qemu-for-upstream.
>>
>> Yes, I have a vmlinux built into my BBL.  I didn't actually look closely at
>> the command line I was copying and see that vmlinux in there, my guess would
>> be that it's getting ignored.  I don't remember if upstream BBL actually
>> works with the split bbl/vmlinux setup, I've kind of stopped paying
>> attention to BBL as I'm just waiting for someone to tell me instructions as
>> to how to use a real bootloader... :)
>
> JFTR, upstream bbl supports the split bbl/vmlinux setup, it's just
> upstream qemu that lacks the support for now (qemu-riscv has it).

Thanks!
