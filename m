Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31316C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15EB223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeIjVfvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15EB223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHJHVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 03:21:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39730 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeHJHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 03:21:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so3517242plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 21:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sk8sWp077d3s9/3xUXVeQktZnJ+M1Ypof7sqPAl8MuM=;
        b=MeIjVfvDXP4xV6SmzquM35SUY1lFgfMW9jwd+tbEZy1jfCLE5C8z0zGmp81TqaXmHM
         szc8C/zta396DAvoD8kIQhvV2tjYM0Z/zRB11YKLsF6g5fYehfnRauCvwMSnV5t46jOE
         N/kY/9KKX4Tlv8eeO4VbLDxGqVqqKQ3YsEoSko8j9w3dxQgYC49HumJbx0RdHNpO3aPr
         GjDCGcyx0QbefJG6ozIxGAEObasXGxMaDr/tUrcTziA9XBgPEveBcABohaDp0qMP+Lhq
         seluqTDBHu/1UHt6T2z2AxDCfP7+XLS7JU/fsInUy0Vk7fBWd99ZTYuN+11NBR9D8Bqb
         Fbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sk8sWp077d3s9/3xUXVeQktZnJ+M1Ypof7sqPAl8MuM=;
        b=rLcqg6e6qcWdN0yq3PvKNLD+eNUooPSpG7B2B2Ij5Nl4MTjjxnJNo2ahRaxqRAqmdj
         ungcGVR/v+FejvPZqY9KWsy1HDaZ7Qe55wGvzrKiO7MtZyauVkLO4wcLQ/D63athrq3g
         B3mO9PxIZUdbjFbax8DyP2No1mLplvSgwueykYSSOBj4vKjL8squ/vtW+LR66gwFAo4f
         XgDrVmrPFMbYMyp32FAEtZclBuDBIEc+bT0ol1aerzTd5HPwp1fJimxGmHU2tUs68rqm
         Go65u8yYmW6XvMTk2X5IQi8/mgYz7xIpKYC3gYUwxrJ3wCItrlWLtBz5tbjJhf1eX0VU
         EZJg==
X-Gm-Message-State: AOUpUlHr/o5nFk/sn38ymJxMqu6Ob44f/sor0XIDDfdllkzICr8zDCfe
        PWgA8If8okcv5I17y5ifRkY=
X-Google-Smtp-Source: AA+uWPxOhJGCOmAR4bbsyThtugSLfHbD+8sfPtVCE++g+AZFkSx3K2PY3Mr5RI90Mh3mtTRVq441IQ==
X-Received: by 2002:a17:902:25ab:: with SMTP id y40-v6mr4719991pla.120.1533876810212;
        Thu, 09 Aug 2018 21:53:30 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 203-v6sm12697989pgb.14.2018.08.09.21.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 21:53:29 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcus@mc.pp.se
References: <mhng-ef018453-7a99-48b3-bda5-5408383d9566@palmer-si-x1c4>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <98730af5-701d-f0be-410c-29e74bb36ec3@roeck-us.net>
Date:   Thu, 9 Aug 2018 21:53:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-ef018453-7a99-48b3-bda5-5408383d9566@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 08:59 PM, Palmer Dabbelt wrote:
[ ... ]
>>> Also, what is your methodology?  I follow
>>>
>>>     https://wiki.qemu.org/Documentation/Platforms/RISCV

Here are my qemu command lines:

qemu-system-riscv64 -M virt -m 512M -no-reboot -bios bbl \
	-kernel vmlinux -netdev user,id=net0 -device virtio-net-device,netdev=net0 \
	-initrd rootfs.cpio \
	-append 'rdinit=/sbin/init earlycon console=ttyS0,115200' \
	-nographic -monitor none

qemu-system-riscv64 -M virt -m 512M -no-reboot -bios bbl \
	-kernel vmlinux -netdev user,id=net0 -device virtio-net-device,netdev=net0 \
	-device virtio-blk-device,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
	-append 'root=/dev/vda rw earlycon console=ttyS0,115200' \
	-nographic -monitor none

Root file systems and the bbl binary are published at
	https://github.com/groeck/linux-build-test/tree/master/rootfs/riscv64

Hint: If you specify "noreboot" as additional command line option, you'll end up in a shell.

Qemu version:
	https://github.com/riscv/riscv-qemu.git branch 'v3.0.0-local-riscv'

Guenter
