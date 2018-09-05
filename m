Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A58C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A671A2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A671A2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeIFALg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:11:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:60190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeIFALf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:11:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78FDCAD33;
        Wed,  5 Sep 2018 19:39:54 +0000 (UTC)
Subject: Re: [PATCH] efi_stub: update documentation on dtb= parameter
To:     Grant Likely <grant.likely@arm.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     olof@lixom.net, scott.branden@broadcom.com,
        catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        leif.lindholm@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20180905190750.4566-1-grant.likely@arm.com>
From:   Alexander Graf <agraf@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=agraf@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8bed0e5b-cfb7-e1dd-199d-9643b964cb9d@suse.de>
Date:   Wed, 5 Sep 2018 21:39:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905190750.4566-1-grant.likely@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.09.18 21:07, Grant Likely wrote:
> The dtb= parameter is no longer the primary mechanism for providing a
> devicetree to the kernel. Now either firmware or the boot selector (ex.
> Grub) should provide the devicetree and dtb= should only be used for
> debug or when using firmware that doesn't understand DT.
> Update the EFI stub documentation to reflect the current usage.
> 
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Alexander Graf <agraf@suse.de>

Btw, isn't the option missing from kernel-parameters.rst/txt?


Alex

> ---
>  Documentation/efi-stub.txt | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/efi-stub.txt b/Documentation/efi-stub.txt
> index 41df801f9a50..833edb0d0bc4 100644
> --- a/Documentation/efi-stub.txt
> +++ b/Documentation/efi-stub.txt
> @@ -83,7 +83,18 @@ is passed to bzImage.efi.
>  The "dtb=" option
>  -----------------
> 
> -For the ARM and arm64 architectures, we also need to be able to provide a
> -device tree to the kernel. This is done with the "dtb=" command line option,
> -and is processed in the same manner as the "initrd=" option that is
> +For the ARM and arm64 architectures, a device tree must be provided to
> +the kernel. Normally firmware shall supply the device tree via the
> +EFI CONFIGURATION TABLE. However, the "dtb=" command line option can
> +be used to override the firmware supplied device tree, or to supply
> +one when firmware is unable to.
> +
> +Please note: Firmware adds runtime configuration information to the
> +device tree before booting the kernel. If dtb= is used to override
> +the device tree, then any runtime data provided by firmware will be
> +lost. The dtb= option should only be used either as a debug tool, or
> +as a last resort when a device tree is not provided in the EFI
> +CONFIGURATION TABLE.
> +
> +"dtb=" is processed in the same manner as the "initrd=" option that is
>  described above.
> --
> 2.11.0
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> 
