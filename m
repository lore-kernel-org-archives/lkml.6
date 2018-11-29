Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A66C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FC5206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FC5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=knorrie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeK2MSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:18:45 -0500
Received: from syrinx.knorrie.org ([82.94.188.77]:43678 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeK2MSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:18:45 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2018 07:18:44 EST
Received: from [IPv6:2001:980:4a41:fb::12] (unknown [IPv6:2001:980:4a41:fb::12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id E47292F8F3E05;
        Thu, 29 Nov 2018 02:05:24 +0100 (CET)
Subject: Re: [Xen-devel] [PATCH 0/2] Move RSDP address out of setup_header
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     sstabellini@kernel.org, daniel.kiper@oracle.com, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, boris.ostrovsky@oracle.com,
        tglx@linutronix.de
References: <20181120072529.5489-1-jgross@suse.com>
From:   Hans van Kranenburg <hans@knorrie.org>
Openpgp: preference=signencrypt
Autocrypt: addr=hans@knorrie.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <22e0ae54-9d7e-bea5-c8b8-5eac2c9174c1@knorrie.org>
Date:   Thu, 29 Nov 2018 02:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120072529.5489-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en_US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/20/18 8:25 AM, Juergen Gross wrote:
> Resend with Daniel's mailo address corrected
> 
> Instead of passing the RSDP address for Xen PVH guests from grub2 to
> the kernel in setup_header move it into the non-legacy part of the
> boot_params structure.
> 
> This patch series should be applied rather sooner than later in order
> to avoid shipping linux 4.20 with a corky boot protocol.
> 
> Juergen Gross (2):
>   x86/boot: revert commit ae7e1238e68f2a (Add ACPI RSDP address to
>     setup_header)
>   x86/acpi, x86/boot: Take RSDP address from boot params if available
> 
>  Documentation/x86/boot.txt            | 32 +-------------------------------
>  arch/x86/boot/header.S                |  6 +-----
>  arch/x86/include/asm/x86_init.h       |  2 --
>  arch/x86/include/uapi/asm/bootparam.h |  7 ++-----
>  arch/x86/kernel/acpi/boot.c           |  2 +-
>  arch/x86/kernel/head32.c              |  1 -
>  arch/x86/kernel/head64.c              |  2 --
>  arch/x86/kernel/setup.c               | 17 -----------------
>  8 files changed, 5 insertions(+), 64 deletions(-)

FWIW, I can confirm that I can boot a Xen domU in PVH mode with the
following four patches added on top of Linux 4.19.5 (applied in this
order), in combination with grub master branch with patchset v5 for grub
on top:

Date:   Wed Oct 10 08:14:55 2018 +0200
x86/boot: Add ACPI RSDP address to setup_header

Date:   Wed Oct 10 08:14:56 2018 +0200
x86/acpi, x86/boot: Take RSDP address for boot params if available

Date:   Tue Nov 20 08:25:28 2018 +0100
x86/boot: revert commit ae7e1238e68f2a (Add ACPI RSDP address to
setup_header)

Date:   Tue Nov 20 08:25:29 2018 +0100
x86/acpi, x86/boot: Take RSDP address from boot params if available

[    0.205884] Booting paravirtualized kernel on Xen PVH

Thanks,
Hans
