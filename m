Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D84BC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D18E218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551229065;
	bh=9B3aqTS5AoTT/ONu6CUGqUc7X1qgGOsOsWQK/fstrXQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ALaVd39eriqiuGBe08FTdCS6/rS7K4ArXxt8cW3P3ig8Dm2UpDfHzegggAiY9T5F2
	 F+BmW83YPwhME5oWK1Dm1z4tRa0KB5M8JE0bsQ8fCub//nG+CYvICYARdYUSM8H8Kf
	 TfX4gUgNrZplMIHdadSR2vIaTqlqWGoJqWIKfY3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfB0A5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfB0A5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:57:43 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEFE218CD;
        Wed, 27 Feb 2019 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551229062;
        bh=9B3aqTS5AoTT/ONu6CUGqUc7X1qgGOsOsWQK/fstrXQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UWYbABDQbBm/YgFsjAv3XpmXMMugOSIIIxivym0v1PT0gpDPUlXhtMiPsggs3x231
         nC/7vSonh90TyrDoOOs61Pxc0gAqDevPIrt/DkfiwJbn4tSmcC+S5PeifGvR11pRjZ
         4fJP5dkEu46PEt8N1VnPnno3DQ41sEerx+GDv+xg=
Subject: Re: [PATCH v2 1/5] selftests/ima: cleanup the kexec selftest
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kselftest@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
 <1551223620-11586-2-git-send-email-zohar@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <cb400d8f-a560-d8d8-07e1-461ca74bae55@kernel.org>
Date:   Tue, 26 Feb 2019 17:57:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551223620-11586-2-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

Thanks for the patches.

On 2/26/19 4:26 PM, Mimi Zohar wrote:
> Remove the few bashisms and use the complete option name for clarity.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>   tools/testing/selftests/ima/test_kexec_load.sh | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
> index 1c10093fb526..0345803e7bec 100755
> --- a/tools/testing/selftests/ima/test_kexec_load.sh
> +++ b/tools/testing/selftests/ima/test_kexec_load.sh
> @@ -1,7 +1,7 @@
>   #!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: GPL-2.0-or-later

# SPDX-License-Identifier: GPL-2.0

>   # Loading a kernel image via the kexec_load syscall should fail
> -# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
> +# when the kernel is CONFIG_KEXEC_VERIFY_SIG enabled and the system
>   # is booted in secureboot mode.
>   
>   TEST="$0"
> @@ -12,8 +12,8 @@ rc=0
>   ksft_skip=4
>   
>   # kexec requires root privileges
> -if [ $UID != 0 ]; then
> -	echo "$TEST: must be run as root" >&2
> +if [ $(id -ru) -ne 0 ]; then
> +	echo "$TEST: requires root privileges" >&2
>   	exit $ksft_skip
>   fi
>   
> @@ -33,17 +33,17 @@ secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
>   
>   # kexec_load should fail in secure boot mode
>   KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
> -kexec -l $KERNEL_IMAGE &>> /dev/null
> -if [ $? == 0 ]; then
> -	kexec -u
> -	if [ "$secureboot" == "1" ]; then
> +kexec --load $KERNEL_IMAGE 2>&1 > /dev/null
> +if [ $? -eq 0 ]; then
> +	kexec --unload
> +	if [ $secureboot -eq 1 ]; then
>   		echo "$TEST: kexec_load succeeded [FAIL]"
>   		rc=1
>   	else
>   		echo "$TEST: kexec_load succeeded [PASS]"
>   	fi
>   else
> -	if [ "$secureboot" == "1" ]; then
> +	if [ $secureboot -eq 1 ]; then
>   		echo "$TEST: kexec_load failed [PASS]"
>   	else
>   		echo "$TEST: kexec_load failed [FAIL]"
> 

The rest looks good to me.

thanks,
-- Shuah
