Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F13C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236E120874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PMmkBmSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbfAKRKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:10:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44231 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732737AbfAKRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:10:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so7020095plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fQyA7PYCxQENfWhPz6dSiDsgSet3p+Oi1/3rkGt1iow=;
        b=PMmkBmSD+Vz9RzlWKxX9RNTWDg04GgYGQW2Gs/jo17kBjMjKeawGhAaj8qhmBYnSoX
         zWzANO6mvvAJ+ZQg9f/nHWpUHOx9PRX5cDv7NBbBE82bLl8JjDpi1/8kkE3KRlbCqWG3
         fOqiWj+RSTGpycSTmZuPr+03D7NvPDUi2ca/3gULeCIkCiV9xdXJEKUJhbN/kmuL5s8r
         5HE6CEgAmFwzafAjSrfuH2mCRbIS8tpJXSn1JAyM3RAQ5UNUbgG43T5ZXSllne6LtIwJ
         tLkDreprYADo6EO37z9msrFrXtc3oXeIcFSrVwwg3F2SSIAKaayuP2lZncI381vhw2lk
         CCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fQyA7PYCxQENfWhPz6dSiDsgSet3p+Oi1/3rkGt1iow=;
        b=dYCDn0Ud2V0OovkdGFCgi0we3qg85CXYJaNWwYToMp0rh5a52LMZDSvIgoDd8+giLw
         1NQLvxXcDyVVYhXM3RXYJcV672zspPKuAyVlpZ3Jt0kJX8fcgqWJ+scSr7k9Lj0Tf8Sj
         XVJj9Lu4z+YRFw3+5jN51LtmN1Z5GE+b6lWvXYIGZ1l904M6Q538DOA6YKW6rlcimPkN
         PUzXMAtHWeNok24lQMX6P0A61J9H2pyrZlOLd3mEEW6jtgRCmjnt/aq04YBOT5rZAtcY
         Ixscay8EZWgjXFfSzB2ZMhTniTYYwsWdm7oDsTu012GHgDLG3LXS9bAIJHe/jS9Dm1lY
         swUQ==
X-Gm-Message-State: AJcUukesDnpnrEdoTOy1JHAKMV5A7hJ8ChOELtLt23EU1pOw86g/Qiu0
        JMlgKn3Pd4k0z9Tl9fv70puurg==
X-Google-Smtp-Source: ALg8bN5cO12OYfU8E7Ho1PEPka1vHwULBxeFyxYKFXdMKDrjmadJjKrQLjCcYUXe/POfjHnsvav83Q==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr15538357plr.128.1547226619481;
        Fri, 11 Jan 2019 09:10:19 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d6sm109441915pgc.89.2019.01.11.09.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:10:14 -0800 (PST)
Date:   Fri, 11 Jan 2019 09:10:14 -0800 (PST)
X-Google-Original-Date: Fri, 11 Jan 2019 09:10:03 PST (-0800)
Subject:     Re: [PATCH v2] RISC-V: defconfig: Enable Generic PCIE by default
In-Reply-To: <20190110193451.29016-1-alistair.francis@wdc.com>
CC:     Palmpalmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alistair Francis <Alistair.Francis@wdc.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-8b2184cd-f91b-465b-bead-f3c2c58e2d44@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 11:35:01 PST (-0800), Alistair Francis wrote:
> Enable generic PCIe by default in the RISC-V defconfig, this allows us
> to use QEMU's PCIe support out of the box.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  arch/riscv/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index f399659d3b8d..ccfd3f05223c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -14,6 +14,8 @@ CONFIG_EXPERT=y
>  CONFIG_BPF_SYSCALL=y
>  CONFIG_SMP=y
>  CONFIG_PCI=y
> +CONFIG_PCIEPORTBUS=y
> +CONFIG_PCI_HOST_GENERIC=y
>  CONFIG_PCIE_XILINX=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> @@ -77,5 +79,6 @@ CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
>  # CONFIG_RCU_TRACE is not set
> -- 
> 2.19.1

Odd -- when your QEMU patches came through I tried doing this, which resulted 
in a non-booting kernel.  For some reason this patch is fine, though.  I'm 
going to just assume I screwed this up the first time, so it looks like this 
and the QEMU patch are good to go.

Thanks!
