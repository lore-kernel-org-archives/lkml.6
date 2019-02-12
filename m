Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80213C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F622083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfBLKyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:54:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35674 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBLKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:54:03 -0500
Received: from static-50-53-47-167.bvtn.or.frontiernet.net ([50.53.47.167] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1gtVhP-0001Pl-PO; Tue, 12 Feb 2019 10:54:00 +0000
Subject: Re: [PATCH] apparmor: fix build error undefined reference to zlib_*
To:     Anders Roxell <anders.roxell@linaro.org>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190212094828.8429-1-anders.roxell@linaro.org>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <2f189cdd-28fb-58a7-63ad-abe8ba185b3a@canonical.com>
Date:   Tue, 12 Feb 2019 02:53:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212094828.8429-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 1:48 AM, Anders Roxell wrote:
> With commit 876dd866c084 ("apparmor: Initial implementation of raw
> policy blob compression") and SECURITY_APPARMOR is set to '=y'
> ZLIB_DEFLATE must be enabled as well for the linker to see the symbols.
> 
> aarch64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `deflate_compress':
> ../security/apparmor/policy_unpack.c:1030: undefined reference to `zlib_deflate_workspacesize'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1030:(.text+0xe20): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflate_workspacesize'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1036: undefined reference to `zlib_deflateInit2'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1036:(.text+0xe60): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflateInit2'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1053: undefined reference to `zlib_deflate'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1053:(.text+0xec0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflate'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081: undefined reference to `zlib_deflateEnd'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081:(.text+0xf90): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflateEnd'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081: undefined reference to `zlib_deflateEnd'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081:(.text+0xfb4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflateEnd'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081: undefined reference to `zlib_deflateEnd'
> aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081:(.text+0xfd8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflateEnd'
> make[1]: *** [Makefile:1023: vmlinux] Error 1
> make[1]: Target 'Image' not remade because of errors.
> make: *** [Makefile:152: sub-make] Error 2
> make: Target 'Image' not remade because of errors.
> 
> Rework so when SECURITY_APPARMOR is set to '=y' ZLIB_INFLATE and ZLIB_DEFLATE gets
> selected, since both are used by the SECURITY_APPARMOR.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

yep thanks for the patch,

unfortunately this same fix landed in apparmor-next about 5 hours ago

> ---
>  security/apparmor/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index 3de21f46c82a..99c35e22c119 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -5,6 +5,8 @@ config SECURITY_APPARMOR
>  	select SECURITY_PATH
>  	select SECURITYFS
>  	select SECURITY_NETWORK
> +	select ZLIB_INFLATE
> +	select ZLIB_DEFLATE
>  	default n
>  	help
>  	  This enables the AppArmor security module.
> 

