Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D070C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B1A218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551229311;
	bh=6zA+U4WOwsKcG0AZ/lDOgTEZ/bXk9KzQYompDCTL+d0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=p9Soc7tJt1wMtO79rL7rwY/fJ5/eLIQGvYOOARTsBpBd/C3SFl8PTbyI1XA6HFq5m
	 u+TmT9mPDrv4zFOwEpMXBfeWFAeCnl+BRynOX/7BkuGdA7dFXZQ7Kj+z3Z+LOqox1d
	 Il6TXKE9/+q/S396SKa3Vq1pM/J0hCYSp4VFm5AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfB0BBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:01:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfB0BBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:01:49 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38022218CD;
        Wed, 27 Feb 2019 01:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551229308;
        bh=6zA+U4WOwsKcG0AZ/lDOgTEZ/bXk9KzQYompDCTL+d0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pHjjIxWaR0/GkD7Ui0KebQ/4OJrGxL3DkZ5wEpx1y3bJcx3xjvlphwAapu3niYvIu
         L5eAha+v2Mp6lVLiCFDbXIewbB++45KILB+bYb9NL5mVRRO3r8ucsjHgG5Jjlin1jD
         cANIbB4Onp/d+xG20xYl2yKbnN9FL2dzXFrsRRRw=
Subject: Re: [PATCH v2 2/5] selftests/ima: define a set of common functions
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-3-git-send-email-zohar@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <fd7426fa-c632-7c5a-e981-71b014e6d829@kernel.org>
Date:   Tue, 26 Feb 2019 18:01:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551223620-11586-3-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 4:26 PM, Mimi Zohar wrote:
> Define, update and move get_secureboot_mode() to a common file for use
> by other tests.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>   tools/testing/selftests/ima/Makefile           |  1 +
>   tools/testing/selftests/ima/common_lib.sh      | 24 ++++++++++++++++++++++++
>   tools/testing/selftests/ima/test_kexec_load.sh | 17 +++--------------
>   3 files changed, 28 insertions(+), 14 deletions(-)
>   create mode 100755 tools/testing/selftests/ima/common_lib.sh
> 
> diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
> index 0b3adf5444b6..46b9e04d2737 100644
> --- a/tools/testing/selftests/ima/Makefile
> +++ b/tools/testing/selftests/ima/Makefile
> @@ -5,6 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
>   ifeq ($(ARCH),x86)
>   TEST_PROGS := test_kexec_load.sh
> +TEST_FILES := common_lib.sh
>   
>   include ../lib.mk
>   
> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> new file mode 100755
> index 000000000000..5583ea74c14e
> --- /dev/null
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later

# SPDX-License-Identifier: GPL-2.0

> +
> +# The secure boot mode can be accessed either as the last integer
> +# of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
> +# "od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data".
> +# Return 1 for SecureBoot mode enabled.
> +get_secureboot_mode()
> +{
> +	local efivarfs="/sys/firmware/efi/efivars"
> +	# Make sure that efivars is mounted in the normal location
> +	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
> +		echo "$TEST: efivars is not mounted on $efivarfs" >&2
> +		exit $ksft_skip
> +	fi
> +
> +	# Get secureboot mode
> +	local file="$efivarfs/../vars/SecureBoot-*/data"
> +	if [ ! -e $file ]; then
> +		echo "$TEST: unknown secureboot mode" >&2
> +		exit $ksft_skip
> +	fi
> +	return `od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data`
> +}
> diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
> index 0345803e7bec..35934e0665f1 100755
> --- a/tools/testing/selftests/ima/test_kexec_load.sh
> +++ b/tools/testing/selftests/ima/test_kexec_load.sh
> @@ -5,7 +5,7 @@
>   # is booted in secureboot mode.
>   
>   TEST="$0"
> -EFIVARFS="/sys/firmware/efi/efivars"
> +. ./common_lib.sh
>   rc=0
>   
>   # Kselftest framework requirement - SKIP code is 4.
> @@ -17,19 +17,8 @@ if [ $(id -ru) -ne 0 ]; then
>   	exit $ksft_skip
>   fi
>   
> -# Make sure that efivars is mounted in the normal location
> -if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
> -	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
> -	exit $ksft_skip
> -fi
> -
> -# Get secureboot mode
> -file="$EFIVARFS/SecureBoot-*"
> -if [ ! -e $file ]; then
> -	echo "$TEST: unknown secureboot mode" >&2
> -	exit $ksft_skip
> -fi
> -secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
> +get_secureboot_mode
> +secureboot=$?
>   
>   # kexec_load should fail in secure boot mode
>   KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> 

The rest looks good to me.

thanks,
-- Shuah
